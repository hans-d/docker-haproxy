Haproxy docker environment
==========================

Versions/Branches
-----------------
Due to current limitations of trusted builds these are seperate docker repos.

- `master` -> hansd/haproxy
  - normal haproxy

Volumes
-------
- `/etc/haproxy`: configuration

Ports
-----
- `80`, `8080`: regular http ports
- `9000`: frequently used for accessing haproxy stats

TODO
----
- reload haproxy on change of configuration
