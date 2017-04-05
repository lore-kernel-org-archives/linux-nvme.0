From: maurosr@linux.vnet.ibm.com (Mauro S. M. Rodrigues)
Date: Wed,  5 Apr 2017 20:49:06 -0300
Subject: [PATCH] nvmetcli: Install nvmetcli in /usr/sbin with setup.py
Message-ID: <1491436146-8769-1-git-send-email-maurosr@linux.vnet.ibm.com>

According to the README, one can install nvmetcli through setup.py.
When one tries this though, the nvmetcli isn't configured in system's
$PATH.

Adding nvmetcli to scripts argument in setup call does half of the job.
Then, in order to install it in the correct location in a maintanable
way it's introduced setup.cfg file which contains 'install_scripts'
parameter for 'install' command set to /usr/sbin.

Nothing changes on the .deb package creation, the .rpm package process
in the other hand was made simpler by lines that are now done by
setup.py + setup.cfg settings.

Signed-off-by: Mauro S. M. Rodrigues <maurosr at linux.vnet.ibm.com>
---
 rpm/nvmetcli.spec.tmpl | 2 --
 setup.cfg              | 2 ++
 setup.py               | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 setup.cfg

diff --git a/rpm/nvmetcli.spec.tmpl b/rpm/nvmetcli.spec.tmpl
index 1ffdbe6..f1b5533 100644
--- a/rpm/nvmetcli.spec.tmpl
+++ b/rpm/nvmetcli.spec.tmpl
@@ -29,8 +29,6 @@ as well as saving / restoring the configuration to / from a json file.
 rm -rf %{buildroot}
 %{__python} setup.py install --skip-build --root=%{buildroot} --prefix=usr
 mkdir -p %{buildroot}%{_sysconfdir}/nvmet
-mkdir -p %{buildroot}/usr/sbin
-install -m 755 nvmetcli %{buildroot}/usr/sbin/nvmetcli
 mkdir -p %{buildroot}%{_unitdir}
 install -m 644 nvmet.service %{buildroot}%{_unitdir}/nvmet.service
 
diff --git a/setup.cfg b/setup.cfg
new file mode 100644
index 0000000..ed3bf6e
--- /dev/null
+++ b/setup.cfg
@@ -0,0 +1,2 @@
+[install]
+install_scripts=/usr/sbin
diff --git a/setup.py b/setup.py
index fdd6cea..c03a78d 100755
--- a/setup.py
+++ b/setup.py
@@ -27,4 +27,5 @@ setup(
     maintainer_email = 'hch at lst.de',
     test_suite='nose2.collector.collector',
     packages = ['nvmet'],
+    scripts=['nvmetcli']
     )
-- 
2.7.4
