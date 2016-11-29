From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Tue, 29 Nov 2016 15:10:58 -0800
Subject: [PATCH v1 0/2] nvmetcli manpage and misc tweaks.
Message-ID: <1480461060-9662-1-git-send-email-james_p_freyensee@linux.intel.com>

Adding proper documentation solution to nvmetcli.

v1:
   *Folded Christoph's input into the man pages.
   *undeleted README
   *Added 'installdoc/uninstalldoc' options in the Makefile

Jay Freyensee (2):
  nvmetcli: Adding manpage/html generation
  nvmetcli: add python-six to rpm package building

 Documentation/Makefile     |  31 ++++++
 Documentation/nvmetcli.txt | 253 +++++++++++++++++++++++++++++++++++++++++++++
 Makefile                   |  21 +++-
 rpm/nvmetcli.spec.tmpl     |   2 +-
 4 files changed, 304 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/Makefile
 create mode 100644 Documentation/nvmetcli.txt

-- 
2.7.4
