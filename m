Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0086AC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D9B20714
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="joL3GRmd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+s2UFnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D9B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J0mDmjQim8cTEIMsgSuMTc8DUzH8tuWSWuw5wxp5oj4=; b=joL3GRmdBhmYeX
	dtHhCCxxX0H4sV+TSd7H4HisDgRZMJIrLO9G3bfmS1+Ktp/KPHSe7PG0TgZ0y0E4V48F/EYF8S1+W
	2R48u+N+STo009bsgz0y+b6dI/ApkyFpFI+izmaYv8B8RWeh0agkLaeJ6PLLtERTp5i8qRJ/KfoCp
	/kf1achSq+s3RkCPtCWGrPvQoyCWoPvoZzvBTfqhH/b0lPX1oTuSAyR80sXx+bVGRkqJNlXQNYQWE
	POnCL/H+bBalgKl1DSoM8dljld+OAe0by9HPt5YPeMQXxFz/+A7t8hKHWaSR9hiSdUgYakAme541T
	zEpX+OTL+3II0R/FHgPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHWwG-0007Xq-PB; Thu, 26 Mar 2020 18:09:08 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHWvD-0006eq-GX
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 18:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585246079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5bql8lMyjw9pjbwdbBTG4mhXhPqtT/SAh41/mP8d0A=;
 b=i+s2UFnABxH2npss4n4PtQvk8YoVDLO0PBW/oXMdruZdKJAC7xn6IqtwpXkGuQrXZC3gLU
 6AvAVr0WmIGGCcjbPMi6uFEnibfeZEDqX965LXoKnDgin6A9YKeOiwoJ/pBwpbj5qxYwc7
 Vim5+u9jEAdfSJqOnnmHDGyrvCdAr9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-RSyxz57INMKV25M-kIXUzw-1; Thu, 26 Mar 2020 14:07:57 -0400
X-MC-Unique: RSyxz57INMKV25M-kIXUzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE05ADB61
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:55 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C2B819C69
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:55 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 4/7] nvme.py: Sync the containing directory
Date: Thu, 26 Mar 2020 13:07:47 -0500
Message-Id: <20200326180750.469346-5-tasleson@redhat.com>
In-Reply-To: <20200326180750.469346-1-tasleson@redhat.com>
References: <20200326180750.469346-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_110803_629553_DF8F7E17 
X-CRM114-Status: GOOD (  10.53  )
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

It's apparent that some thought went into making sure the config
file makes it atomically to the fs.  However, one thing is missing
which is doing a fsync on the containing directory of the config file.

See: https://lwn.net/Articles/457667/

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 nvmet/nvme.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 55c3930..4817124 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -305,6 +305,15 @@ class Root(CFSNode):
 
         os.rename(savefile + ".temp", savefile)
 
+        # Sync the containing directory too
+        dir_fd = None
+        try:
+            dir_fd = os.open(savefile_dir, os.O_RDONLY)
+            os.fsync(dir_fd)
+        finally:
+            if dir_fd:
+                os.close(dir_fd)
+
     def clear_existing(self):
         '''
         Remove entire current configuration.
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
