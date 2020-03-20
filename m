Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD58C4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:41:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12ECB20724
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cxTn9SD/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfp0U12H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12ECB20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J0mDmjQim8cTEIMsgSuMTc8DUzH8tuWSWuw5wxp5oj4=; b=cxTn9SD/2AWGkQ
	FgYYOKjqRQOBZlIVSROEDo47t9CkCJCLAKhmQ3hn2P27t/EABwArx38KQqk+0f/BNz3LrSH/Qojz5
	ixn0nAAyV6zhIYTiau+bcRn8wBZptlHB3ZLm8bsVn0o4T2Q2za67rxeDejhi93KcOimkYlX4S3nJ3
	WNwZTbdx1VRGui85ztZJwbkw41UENWc7uOq+9BXoNQiF3yubKPegqlZ98PXR0gy9OqgcyOfAGOOQY
	fwYpDNC54jesURzHq1l2iFElNgeb4l0nkGiERr/kecd5DfMWCt7HIHFCe9h9YXZu8Zl2T10A5Khb9
	CDUKZqPMIklGCyOmwZ/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFOSi-0007U8-3r; Fri, 20 Mar 2020 20:41:48 +0000
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFOSc-0007QV-6D
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 20:41:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584736900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5bql8lMyjw9pjbwdbBTG4mhXhPqtT/SAh41/mP8d0A=;
 b=Kfp0U12H4KXryDN7SPzAOLaXD7kP2b9mbpsgUYKwX1yp6tHKIBRkYvdoa44fdroK3oh8ka
 dkyrBQLi8KcRwIynw+EDhrP/RVj55xKQna9F7U/5YVANZGeioReIo0vhDkUrbIcJ+8seoq
 XohWweYZjNHZJx6YFWsfXuUOsvVJKvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-0hmjznymO7asPG2-tnAlUw-1; Fri, 20 Mar 2020 16:39:52 -0400
X-MC-Unique: 0hmjznymO7asPG2-tnAlUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A1B477
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:51 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37B0590817
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:51 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/6] nvme.py: Sync the containing directory
Date: Fri, 20 Mar 2020 15:39:44 -0500
Message-Id: <20200320203946.37338-5-tasleson@redhat.com>
In-Reply-To: <20200320203946.37338-1-tasleson@redhat.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_134142_312025_D3687783 
X-CRM114-Status: GOOD (  10.29  )
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
