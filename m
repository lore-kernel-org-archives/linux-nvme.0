From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  8 Nov 2016 12:48:26 +0200
Subject: [PATCH nvme-cli v1 0/2] auto generate hostnqn file on installation
Message-ID: <1478602108-29571-1-git-send-email-sagi@grimberg.me>

This set is designed to help the user by auto-generating a hostnqn and
placing it in /etc/nvme/hostnqn file upon installation of nvme-cli (in
case such a file doesn't exist).

The user can re-generate different hostnqns on demand by running:
$ nvme gen-hostnqn

Only the deb package is tested.

Changes from v0 (rfc):
- Moved hostnqn generation to nvme with the command gen-hostnqn
- Cleanup hostnqn file only on purge in debian

Sagi Grimberg (2):
  nvme-cli: Add nvme hostnqn generation option
  nvme.spec/debian: Auto generate host nqn as part of install

 Makefile        |  1 +
 debian/postinst | 20 ++++++++++++++++++++
 debian/postrm   |  5 +++++
 nvme-builtin.h  |  1 +
 nvme.c          | 14 ++++++++++++++
 nvme.spec.in    | 12 ++++++++++++
 6 files changed, 53 insertions(+)
 create mode 100644 debian/postinst
 create mode 100644 debian/postrm

-- 
2.7.4
