Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE8C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B3E20714
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uz7J4J3o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwoWr3kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B3E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zuNIfdcjcXmsVYrkq77jpRVaonpwYSlAldmRxwLbFHQ=; b=uz7J4J3o943eMM
	8GqrA/5/SpaAlaKp9ThmHHC2ndFKjZ4JRf/zc/kfeOLYXhpUtfoYP5KRzM9tFhJdP/q9ElIecISLi
	nSGRacyj2MNJ0FjPGrDm0UHTYOAZwTxJCATht/o+7HygOoALYhSMPP5BtCZwi5nAUXmkIfGBzrCXK
	B2OfEHDIAUdKczTfviVrHpNfdYrVdLBp3R3Rv3LBKw9DnC5Kj3VkFP8jIgclOG0+cuc5q0x6u3XBz
	+S+fbp1FDVdFGLVxFJ4z/QwMhd0P7RJDffYYjYVDSKgOTQMtcukkD9dH3RiVLkkD4pvx7SYzpM0JR
	5LYqjngLBWAp7C6KL+CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHWwh-0007rW-2z; Thu, 26 Mar 2020 18:09:35 +0000
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHWvE-0006er-5x
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 18:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585246079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mx5Y4A0vNKPVoyv1xHXaD8pmFgS8ayD4i+NDYQpBlnI=;
 b=dwoWr3kvqN1325lBlB4ptDB5ozzikaD4RRR/wPelg0r0GOrVAG1ANQo19QyuLofGXJY88k
 j1hELbjp5EPeqM1+YfHrn6N48ycXqziaZpKEfpNr5+iMsLqD0FI4HOOTrLbmGSAAZTJSJD
 ScnQSTEUNCF6jp504jN/DPAox3Jz9mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ffitk6zYMimBRZkSylnl7A-1; Thu, 26 Mar 2020 14:07:58 -0400
X-MC-Unique: ffitk6zYMimBRZkSylnl7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E333100550D
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:54 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BB2419C69
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:53 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/7] nvmetcli: Improve IOError handling on restore
Date: Thu, 26 Mar 2020 13:07:45 -0500
Message-Id: <20200326180750.469346-3-tasleson@redhat.com>
In-Reply-To: <20200326180750.469346-1-tasleson@redhat.com>
References: <20200326180750.469346-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_110804_312600_367678E2 
X-CRM114-Status: GOOD (  11.99  )
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

Not all IOErrors are caused by specifying a missing configuration
file.  When the file is present, dump the error exception text too,
so the user has a better idea what is wrong.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 nvmetcli | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index 3d8c16e..a646232 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -24,6 +24,7 @@ import os
 import sys
 import configshell_fb as configshell
 import nvmet as nvme
+import errno
 from string import hexdigits
 import uuid
 
@@ -674,16 +675,26 @@ def save(to_file):
 
 
 def restore(from_file):
+    errors = None
+
     try:
         errors = nvme.Root().restore_from_file(from_file)
-    except IOError:
-        # Not an error if the restore file is not present
-        print("No saved config file at %s, ok, exiting" % from_file)
-    sys.exit(0)
+    except IOError as e:
+        if e.errno == errno.ENOENT:
+            # Not an error if the restore file is not present
+            print("No saved config file at %s, ok, exiting" % from_file)
+            sys.exit(0)
+        else:
+            print("Error processing config file at %s, error %s, exiting" %
+                  (from_file, str(e)))
+            sys.exit(1)
 
+    # These errors are non-fatal
     for error in errors:
         print(error)
 
+    sys.exit(0)
+
 
 def clear(unused):
     nvme.Root().clear_existing()
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
