Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E68C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CVy8wALicTiQ5DvS+riXXmUJTzaa4wFx9X//YluBpA=; b=ISQhi1QJOoUixujRmeovtY8wRR
	GdAZjpN8lgYxf9zLmkshA1q49h4rKNV76gX0KuCPBBPzJ6DTfM+M4zEz+MJz3tmp2CN7sq8QsLNyB
	BFyTfqc88UcSjdqOvOcXMky9ooAJ/iLlj6qdTtwwToG9kYOxXxPZAbKVCr14RbgpV+3PJ1VtGy7h1
	aQ1yeqUZINaU373d3eIV5MknNlGPC7EdaHG2br+KjbB4PgiqeMhY7q5FvCS/qfkvDkyCc1TLXOioR
	9Dcdptao/YxCUGTM5DufGSaykqZdgAdQit0XiQgodJ0V8zkFjKVfwEfdNZAEzgDJxRNG5T2n2KQ5f
	39Ub7m/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97r0-00BKo8-Se; Wed, 06 Jul 2022 16:26:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97qy-00BKma-66
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:26:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 71279B81ADB;
	Wed,  6 Jul 2022 16:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B832C3411C;
	Wed,  6 Jul 2022 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657124773;
	bh=/XMuQfK+Lx5qvBfgupKs0ht8LEtOx5afaMDwU0HsGuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsAHIOUM1bH816MW4VoaIMkqlTjFmdAQLDxa48L3ZbcvY5OhYyJKIdbBRkGBouV8V
	 2XRlDzGKY6hUm4SKcKEcd3rRFiigNFUK2zczsL8EN1fP8qmUsAdKw27UT5ZBgghPXN
	 9rkb9zWSw6N/XN0kyLpHIY0rHPUgxpxGQTWP3Ymt8kvyySCPERpiK9KzaFHEjz6SvW
	 OLqqEDZW0hORJ1j2P8m0aputLwgKO0J2WrOWeUDNbtI9IJUpHnM8YL8CGAtqHRWFrp
	 4uNqt2oqQ7LnYfm29sX8zSt0DM+LI8bviwABuDqiS23JAS7oGTDYvmvjBrzIh7GCCa
	 HwCzsE9B9MsIQ==
Date: Wed, 6 Jul 2022 10:26:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.garry@huawei.com>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
 <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
 <20220706161825.GA1962@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706161825.GA1962@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_092616_415333_550DE9F3 
X-CRM114-Status: GOOD (  20.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
> > Did you test what the trace looks like afte this? We're losing valuable trace
> > data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
> > don't know why it cares that the address of the field being read is only 4
> > bytes; we want everything that comes after it too.
> 
> Because accesses should not spawn boundaries of members in structs unless
> copying the entire struct.  If we want to trace the various fields we
> need to individually assign them.
> 
> Anyway, I'm dropping this patch from nvme-5.19 for now to let the
> discussion conclude.

How about this instead?

---
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..3c5e7fa03707 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -69,7 +69,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->metadata = !!blk_integrity_rq(req);
 		__entry->fctype = cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->q->disk);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
+		memcpy(__entry->cdw10, &cmd->common.bytes,
 			sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%x, cmd=(%s %s)",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e3934003f239..1be226871763 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -906,12 +906,17 @@ struct nvme_common_command {
 	__le32			cdw2[2];
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
-	__le32			cdw10;
-	__le32			cdw11;
-	__le32			cdw12;
-	__le32			cdw13;
-	__le32			cdw14;
-	__le32			cdw15;
+	union {
+		struct {
+			__le32	cdw10;
+			__le32	cdw11;
+			__le32	cdw12;
+			__le32	cdw13;
+			__le32	cdw14;
+			__le32	cdw15;
+		};
+		__u8 bytes[24];
+	};
 };
 
 struct nvme_rw_command {
--

