From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 23 Nov 2016 10:01:10 -0800
Subject: [PATCH 0/3] nvmetcli manpage and misc tweaks
Message-ID: <1479924073-6952-1-git-send-email-james_p_freyensee@linux.intel.com>

Adding proper documentation solution to nvmetcli.

Jay Freyensee (3):
  nvmetcli: Adding manpage/html generation
  nvmetcli: add python-six to rpm package building
  nvmetcli: remove README file

 Documentation/Makefile     |  21 ++++
 Documentation/nvmetcli.txt | 237 +++++++++++++++++++++++++++++++++++++++++++++
 Makefile                   |  15 ++-
 README                     | 173 ---------------------------------
 rpm/nvmetcli.spec.tmpl     |   2 +-
 5 files changed, 272 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/Makefile
 create mode 100644 Documentation/nvmetcli.txt
 delete mode 100644 README

-- 
2.7.4
