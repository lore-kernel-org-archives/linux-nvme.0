From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 21:12:59 +0200
Subject: [PATCH RFC nvme-cli 0/2] auto generate hostnqn file on installation
Message-ID: <1478459581-22654-1-git-send-email-sagi@grimberg.me>

Not sure if it's the best way to do this as my packeging understanding is
very limited, hence the RFC. the debian part is tested (don't have
access to rpm distros at the moment).

Sagi Grimberg (2):
  debain: generate hostnqn file on install and remove on uninstall
  nvme.spec: generate hostnqn file on install and remove on uninstall

 debian/postinst | 22 ++++++++++++++++++++++
 debian/prerm    |  5 +++++
 nvme.spec.in    | 14 ++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 debian/postinst
 create mode 100644 debian/prerm

-- 
2.7.4
