From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 17 Nov 2016 14:36:49 +0200
Subject: Introducing Unit test framework based on nvme-cli
In-Reply-To: <20161116213733.GE10050@localhost.localdomain>
References: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175828.GA1207@infradead.org>
 <20161116183522.GB10050@localhost.localdomain>
 <1479325410.31236.0.camel@linux.intel.com>
 <20161116213733.GE10050@localhost.localdomain>
Message-ID: <257502b9-3373-c6aa-cbf4-a0a276d2dd59@grimberg.me>


>> No objections, enable Christoph now, address the doc issues in follow-
>> on patches :-)
>
> Alrighty, it's applied.

Now make deb is running tests :(

Usually when building a package we don't want to run tests
that require nvme devices. So until we can classify to tests
that have requirements to not run unless some env variables
are set we need:
--
diff --git a/debian/rules b/debian/rules
index c2cc8f8f8e20..e797412a128a 100755
--- a/debian/rules
+++ b/debian/rules
@@ -5,5 +5,7 @@ export DEB_BUILD_MAINT_OPTIONS = hardening=+all
  %:
         dh $@

+override_dh_auto_test:
+
  override_dh_auto_install:
         dh_auto_install -- PREFIX=/usr
--
