From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 17 Nov 2016 14:54:46 +0200
Subject: [PATCH nvme-cli v2 0/2] auto generate hostnqn file on installation
Message-ID: <1479387288-13367-1-git-send-email-sagi@grimberg.me>

This set is designed to help the user by auto-generating a hostnqn and
placing it in /etc/nvme/hostnqn file upon installation of nvme-cli (in
case such a file doesn't exist).

The user can re-generate different hostnqns on demand by running:
$ nvme gen-hostnqn

Only the deb package is tested.

Changes from v1:
- don't keep local hostnqn var for sprintf
- don't delete /etc/nvme if it contains other files other
  than what we installed (hostnqn)

Changes from v0 (rfc):
- Moved hostnqn generation to nvme with the command gen-hostnqn
- Cleanup hostnqn file only on purge in debian

Sagi Grimberg (2):
  nvme-cli: Add nvme hostnqn generation option
  nvme.spec/debian: Auto generate host nqn as part of install

 Makefile        |  1 +
 debian/postinst | 20 ++++++++++++++++++++
 debian/postrm   | 10 ++++++++++
 nvme-builtin.h  |  1 +
 nvme.c          | 12 ++++++++++++
 nvme.spec.in    | 17 +++++++++++++++++
 6 files changed, 61 insertions(+)
 create mode 100644 debian/postinst
 create mode 100644 debian/postrm

-- 
2.7.4
