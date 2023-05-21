---
title: Backup and Restore of database
---

```sh
_PSQL_CMD='psql -U "${PGUSER:-postgres}"'
_PSQL_CMD+=' -h "${PGHOST:-localhost}"'
_PSQL_CMD+=' -d "${PGDATABASE:-postgres}"'
_PSQL_CMD+=' -p "${PGPORT:-5432}"'
_PSQL_CMD+=' -v ON_ERROR_STOP=1'
pg_dump -h "${PGHOST:-localhost}" -U "${PGUSER:-postgres}" -d "${PGDATABASE:-postgres}" -Fd -j ${PGJOBS:-4} -Z0 -f "${PGDATABASE:-postgres}"
```

### Backup

```bash
export BACKUP_DATE="$(date '+%Y%m%d')" \
rm -rf $BACKUP_DATE \
md $BACKUP_DATE && \
docker run -it --rm \
-e BACKUP_DATE=$BACKUP_DATE \
--env-file $SECRET_HOME/.env \
-v "$BACKUP_DIR:/data" pgclient15:local \
    pg_dump -v -Z0 -Fd \
    -h "${PGHOST:-localhost}" \
    -U "${PGUSER:-postgres}" \
    -d "${PGDATABASE:-postgres}" \
    -j ${PGJOBS:-12} \
    -f "$BACKUP_DATE/${PGDATABASE:-postgres}" && \
tar -cvzf $BACKUP_DATE.tar.gz $BACKUP_DATE && \
rm -rf $BACKUP_DATE
```