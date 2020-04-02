Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43AAC2BA12
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:54:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFFC20757
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TzzzXtZN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBhOcwVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFFC20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vHvMLt0NJQ/pGe9nw6pOrd1rRO7GVTd9hch9Ll/JjLA=; b=TzzzXtZNF/nkQF
	QwAsPE7ZOvRczlM7SQF0uGQ8yyDPPqbYUquSqx9aEQ+M8QvVnMTYerzxBrAx9km3wk8xJ92UsF5Q9
	duR1mliqNV5jZZqrzkyB4trRLEVAaiNLnNW6J/5p+TWrZxorIHJbJFlKJe3IdymCEcvozg0mIVUaV
	0tFjeROJUmPYf02wJKE2/fTOF5t99mZUQ/Qoezv+LHgblh5cRy9AmMPEHl/3zGVswWSjWb7ynW90+
	DaNRu36LJm6BymRe8s+XdTbzt02KJZHLrhgToKu73WN7L1hqdZmBsdG98s/mHzFLd4wwu3vTVF0bj
	21W1lYPlWzqGQ1CpFYbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK2BB-0002Q3-EX; Thu, 02 Apr 2020 15:54:53 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK2B8-0002PU-El
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 15:54:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585842888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mjOpjxsJgNYE2GY0FPnvZU+SKXoI6hkMyF5DUxRHhbA=;
 b=fBhOcwVBGZfJrWwAyD5Daiy/mK/vNFbce7oBv2RldAbzDQg2ARyTKuqtJsSWl9lx68WQI6
 13f/aqYzplw5ka/r98qth10HnODYzysYUAPNlVtC+/EBQsf+hFnA3ZIx8sudDrhWm3uJrt
 5Fuo9K5mrwHlHdW4D9rW65eyWGKecGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-QNCaFWDGMEi2tMvm9gEILA-1; Thu, 02 Apr 2020 11:54:47 -0400
X-MC-Unique: QNCaFWDGMEi2tMvm9gEILA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 502AE13FD
 for <linux-nvme@lists.infradead.org>; Thu,  2 Apr 2020 15:54:46 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A7D499E16
 for <linux-nvme@lists.infradead.org>; Thu,  2 Apr 2020 15:54:44 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmetcli: Allow different devices for make test
Date: Thu,  2 Apr 2020 10:54:43 -0500
Message-Id: <20200402155443.91120-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_085450_571537_DF6686A6 
X-CRM114-Status: GOOD (  11.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The test_nvmet.py by default uses /dev/ram0 and /dev/ram1 for 2 of the
unit tests.  Add env. variable to allow user to specify different devices
or files.  Additionally, skip these unit tests that require devices/files
if they are not present.  Update README too.

$ sudo make test
......s...s.
----------------------------------------------------------------------
Ran 12 tests in 0.043s

OK (skipped=2)
Name                  Stmts   Miss  Cover
-----------------------------------------
nvmet/__init__.py         1      0   100%
nvmet/nvme.py           517    237    54%
nvmet/test_nvmet.py     276     63    77%
-----------------------------------------
TOTAL                   794    300    62%

$ sudo NVMET_TEST_DEVICES="/dev/sdc,/dev/sdd" make test
............
----------------------------------------------------------------------
Ran 12 tests in 0.124s

OK
Name                  Stmts   Miss  Cover
-----------------------------------------
nvmet/__init__.py         1      0   100%
nvmet/nvme.py           517    100    81%
nvmet/test_nvmet.py     276      4    99%
-----------------------------------------
TOTAL                   794    104    87%

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 README              |  5 ++++-
 nvmet/test_nvmet.py | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 5a4ecd1..44f1c33 100644
--- a/README
+++ b/README
@@ -47,7 +47,10 @@ Testing
 -------
 nvmetcli comes with a testsuite that tests itself and the kernel configfs
 interface for the NVMe target.  To run it make sure you have nose2 and
-the coverage plugin for it installed and simple run 'make test'.
+the coverage plugin for it installed and simple run 'make test'.  To run all
+the tests you also need some test block devices or files.  Default is to
+use /dev/ram0 and /dev/ram1.  You can override default with environmental
+variable eg. NVMET_TEST_DEVICES="/dev/sdk,/dev/sdj" make test .
 
 Development
 -----------------
diff --git a/nvmet/test_nvmet.py b/nvmet/test_nvmet.py
index aae4a86..f8ec232 100644
--- a/nvmet/test_nvmet.py
+++ b/nvmet/test_nvmet.py
@@ -1,9 +1,22 @@
 
+import os
 import random
+import stat
 import string
 import unittest
 import nvmet.nvme as nvme
 
+# Default test devices are ram disks, but allow user to specify different
+# block devices or files.
+NVMET_TEST_DEVICES = os.getenv("NVMET_TEST_DEVICES",
+                               "/dev/ram0,/dev/ram1").split(',')
+
+
+def test_devices_present():
+    return len([x for x in NVMET_TEST_DEVICES
+                if os.path.exists(x) and
+                (stat.S_ISBLK(os.stat(x).st_mode) or os.path.isfile(x))]) >= 2
+
 
 class TestNvmet(unittest.TestCase):
     def test_subsystem(self):
@@ -101,6 +114,8 @@ class TestNvmet(unittest.TestCase):
             n.delete()
         self.assertEqual(len(list(s.namespaces)), 0)
 
+    @unittest.skipUnless(test_devices_present(),
+                         "Devices %s not available or suitable" % ','.join(NVMET_TEST_DEVICES))
     def test_namespace_attrs(self):
         root = nvme.Root()
         root.clear_existing()
@@ -116,7 +131,7 @@ class TestNvmet(unittest.TestCase):
         self.assertRaises(nvme.CFSError, n.set_enable, 1)
 
         # now set a path and enable
-        n.set_attr('device', 'path', '/dev/ram0')
+        n.set_attr('device', 'path', NVMET_TEST_DEVICES[0])
         n.set_enable(1)
         self.assertTrue(n.get_enable())
 
@@ -125,7 +140,7 @@ class TestNvmet(unittest.TestCase):
 
         # test that we can't write to attrs while enabled
         self.assertRaises(nvme.CFSError, n.set_attr, 'device', 'path',
-                          '/dev/ram1')
+                          NVMET_TEST_DEVICES[1])
         self.assertRaises(nvme.CFSError, n.set_attr, 'device', 'nguid',
                           '15f7767b-50e7-4441-949c-75b99153dea7')
 
@@ -403,6 +418,9 @@ class TestNvmet(unittest.TestCase):
         self.assertRaises(nvme.CFSError, nvme.Port,
                           portid=1 << 17, mode='create')
 
+    @unittest.skipUnless(test_devices_present(),
+                         "Devices %s not available or suitable" % ','.join(
+                             NVMET_TEST_DEVICES))
     def test_save_restore(self):
         root = nvme.Root()
         root.clear_existing()
@@ -416,7 +434,7 @@ class TestNvmet(unittest.TestCase):
         s2.set_attr('attr', 'allow_any_host', 1)
 
         n = nvme.Namespace(s, nsid=42, mode='create')
-        n.set_attr('device', 'path', '/dev/ram0')
+        n.set_attr('device', 'path', NVMET_TEST_DEVICES[0])
         n.set_enable(1)
 
         nguid = n.get_attr('device', 'nguid')
@@ -454,7 +472,7 @@ class TestNvmet(unittest.TestCase):
 
         # and check everything is still the same
         self.assertTrue(n.get_enable())
-        self.assertEqual(n.get_attr('device', 'path'), '/dev/ram0')
+        self.assertEqual(n.get_attr('device', 'path'), NVMET_TEST_DEVICES[0])
         self.assertEqual(n.get_attr('device', 'nguid'), nguid)
 
         self.assertEqual(p.get_attr('addr', 'trtype'), 'loop')
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
