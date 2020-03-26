Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8CC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:08:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F0920722
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lD5ALYtl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bh655MV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F0920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C07ZQmucgpgVTshU3TrNFU9FEjSh6od35ueon4ztrcc=; b=lD5ALYtlpJ5cuu
	SjMp64OS6ROEp+aeGD20BWpuCz6uxfxUcsBnUuXNbi8pX/i2Yivdx7BR/oQpQO0+goKDQfFVCZLHE
	nWAd7HpElHMl++sA0MoVS0PuKrcZVWbNw5JCaxEIppH/gyxwVfulQ6tmOjsCa2PP9j7sFmIhMrcRe
	RPDJ6mVz+1DXDieEO/M7jkkja4DGIcjfnSOYpZ35dSujokrw4zDpKcxgDLVzh9k0q5HyKvUmBKaYR
	anIhHP4cqUeY0zYSsSlL4xYmxqGQdOLr4s7pBPONfJCDdc5V0PSyuCQX5vAbyux0IPvS4/aPQ00du
	Pf3amJlkdnWzeZ7VU+rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHWvb-00072G-I5; Thu, 26 Mar 2020 18:08:27 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHWvD-0006ew-GZ
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 18:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585246080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rosJKT1rd2hLhbP2Hg3A5TpWi8LU+Fx7QtGjcqVwacc=;
 b=Bh655MV2206UUEyWOi2X7+InMKqU7l0gmW4mBCMrlj6nNIPxJfl8b1flY6dsqG3tIsqfTb
 2kv6cfm55jv+L/i6yvJnfSElQ4MHB18zcvLO7IIve71pkrF7hECSJPpXa0Kn8LX4W9LQ7O
 soxBuFB8z4j2O/5zdsKYmPcAEkSBSS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-vkd3970eMy2WpqAs6y3oUw-1; Thu, 26 Mar 2020 14:07:59 -0400
X-MC-Unique: vkd3970eMy2WpqAs6y3oUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 567628017DF
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:58 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C407D19C69
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:57 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 7/7] nvmetcli: Report save name correctly
Date: Thu, 26 Mar 2020 13:07:50 -0500
Message-Id: <20200326180750.469346-8-tasleson@redhat.com>
In-Reply-To: <20200326180750.469346-1-tasleson@redhat.com>
References: <20200326180750.469346-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_110803_631837_56EBD4AD 
X-CRM114-Status: GOOD (  12.63  )
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

When a user simply does 'nvmetcli restore' without
specifying a file name the default is used.  However, if the
restore fails you end up with the error message:

Error processing config file at None, error [Errno 1] Operation not
permitted: '/sys/kernel/config/nvmet/ports/0/ana_groups/1', exiting

Correct file name if None in error path.

Error processing config file at /etc/nvmet/config.json, error \
[Errno 1] Operation not permitted: \
'/sys/kernel/config/nvmet/ports/1/ana_groups/1', exiting

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 nvmet/__init__.py | 3 ++-
 nvmetcli          | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index ca05de4..cf172bd 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1 +1,2 @@
-from .nvme import Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup
+from .nvme import Root, Subsystem, Namespace, Port, Host, Referral, ANAGroup,\
+    DEFAULT_SAVE_FILE
diff --git a/nvmetcli b/nvmetcli
index a646232..8ee8590 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -680,6 +680,9 @@ def restore(from_file):
     try:
         errors = nvme.Root().restore_from_file(from_file)
     except IOError as e:
+        if not from_file:
+            from_file = nvme.DEFAULT_SAVE_FILE
+
         if e.errno == errno.ENOENT:
             # Not an error if the restore file is not present
             print("No saved config file at %s, ok, exiting" % from_file)
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
