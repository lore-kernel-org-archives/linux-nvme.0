From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Tue, 29 Nov 2016 15:11:00 -0800
Subject: [PATCH v1 2/2] nvmetcli: add python-six to rpm package building
In-Reply-To: <1480461060-9662-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1480461060-9662-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1480461060-9662-3-git-send-email-james_p_freyensee@linux.intel.com>

>From experience, if python-six isn't installed on a Fedora
system, hard-to-decipher errors can occur trying to use
nvmetcli.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 rpm/nvmetcli.spec.tmpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rpm/nvmetcli.spec.tmpl b/rpm/nvmetcli.spec.tmpl
index 03667d7..1ffdbe6 100644
--- a/rpm/nvmetcli.spec.tmpl
+++ b/rpm/nvmetcli.spec.tmpl
@@ -9,7 +9,7 @@ Source:         nvmetcli-%{version}.tar.gz
 BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-rpmroot
 BuildArch:      noarch
 BuildRequires:  python-devel python-setuptools systemd-units
-Requires:	python-configshell python-kmod
+Requires:	python-configshell python-kmod python-six
 Requires(post): systemd
 Requires(preun): systemd
 Requires(postun): systemd
-- 
2.7.4
