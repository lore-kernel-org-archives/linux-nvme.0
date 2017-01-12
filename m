From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 13:13:27 +0200
Subject: [PATCH nvme-cli v3 0/3] auto generate hostnqn file on installation
Message-ID: <1484219610-18370-1-git-send-email-sagi@grimberg.me>

This set is designed to help the user by auto-generating a hostnqn and
placing it in /etc/nvme/hostnqn file upon installation of nvme-cli (in
case such a file doesn't exist).

The user can re-generate different hostnqns on demand by running:
$ nvme gen-hostnqn

Only the deb package is tested.

Changes from v2:
- fixed bash style
- added review tags
- added a documentation entry

Changes from v1:
- don't keep local hostnqn var for sprintf
- don't delete /etc/nvme if it contains other files other
  than what we installed (hostnqn)

Changes from v0 (rfc):
- Moved hostnqn generation to nvme with the command gen-hostnqn
- Cleanup hostnqn file only on purge in debian

Sagi Grimberg (3):
  nvme-cli: Add nvme hostnqn generation option
  nvme.spec/debian: Auto generate host nqn as part of install
  Documentation: Add entry for gen-hostnqn

 Documentation/nvme-gen-hostnqn.txt | 29 +++++++++++++++++++++++++++++
 Makefile                           |  1 +
 debian/postinst                    | 20 ++++++++++++++++++++
 debian/postrm                      | 10 ++++++++++
 nvme-builtin.h                     |  1 +
 nvme.c                             | 12 ++++++++++++
 nvme.spec.in                       | 17 +++++++++++++++++
 7 files changed, 90 insertions(+)
 create mode 100644 Documentation/nvme-gen-hostnqn.txt
 create mode 100644 debian/postinst
 create mode 100644 debian/postrm

-- 
2.7.4
