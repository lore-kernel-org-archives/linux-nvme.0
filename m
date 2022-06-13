Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED121C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/omQrhtKCh0gY0pTreoozcYZAMAMovcyZBqWjqmq8hc=; b=BfIHKvr9rPZLoBN2FbJeToNdnS
	ATwnxjsakQjuWOdAnxuU++9vI0UuGqpx8n0VIUThtKcFOvpDAT0+scUGDSwYzwkxd+0Kj4WqNqPIy
	IaJw+u2IPV5NKDzZUWszLvPzwGKYZ+CtpmGOmNrpi2skLE9UgPZ050XoVMKnjeHvHJISBzj+GV8UW
	qGtRu4IPoFYpp1+Y0dxQCBJsKBQsRcXo6xuf7Hbmm0m/WdsH+6/CPTHw+Sx/72NjretvF21GW/c2l
	amInLV34/cHu/VuFfDMOpFNsHul0OIy11qJTefTZSKNZHAtYVGL36MjWqsd6bDVNtSdgYj1eKz1Yi
	O7JNVzBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0kyb-004BFc-Qd; Mon, 13 Jun 2022 14:23:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0kyZ-004BDr-56
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 14:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655130209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/omQrhtKCh0gY0pTreoozcYZAMAMovcyZBqWjqmq8hc=;
	b=jDnSPvOC/oHvRFNIoaiL7LAidUDRu4lCgtBG3qYRtsF6gfB/Hwrudafka6CCZRF5eKGtmG
	FbS+07i/dJQmSmgEzwTUeoEDmK1oUh8fF4AWSuLLFPuf7h0GlwhdxTaJdasDYch4cF4V6q
	P4hPDNhbHzku5Lg2+cE3QfYuSHGhQBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-rrIBOTmpPZO2IYVSWlTIng-1; Mon, 13 Jun 2022 10:23:28 -0400
X-MC-Unique: rrIBOTmpPZO2IYVSWlTIng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D29418E5388;
	Mon, 13 Jun 2022 14:23:28 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B1AC28118;
	Mon, 13 Jun 2022 14:23:25 +0000 (UTC)
Date: Mon, 13 Jun 2022 22:23:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed from blktests on latest
 linux-block/for-next
Message-ID: <YqdIWcgnEylFuSci@T590>
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590>
 <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_072331_314393_B2C00033 
X-CRM114-Status: GOOD (  14.62  )
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

On Mon, Jun 13, 2022 at 09:08:11PM +0800, Yi Zhang wrote:
> Hi Ming
> 
> The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
> nvme_core multipath and retest.
> 
> # cat /sys/module/nvme_core/parameters/multipath
> Y
>

OK, I can understand the reason now since rqos is only removed for blk-mq queue,
then rqos allocated for bio queue is leaked, see disk_release_mq().

The following patch should fix it:

diff --git a/block/genhd.c b/block/genhd.c
index 556d6e4b38d9..6e7ca8c302aa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1120,9 +1120,10 @@ static const struct attribute_group *disk_attr_groups[] = {
 	NULL
 };
 
-static void disk_release_mq(struct request_queue *q)
+static void disk_release_queue(struct request_queue *q)
 {
-	blk_mq_cancel_work_sync(q);
+	if (queue_is_mq(q))
+		blk_mq_cancel_work_sync(q);
 
 	/*
 	 * There can't be any non non-passthrough bios in flight here, but
@@ -1166,8 +1167,7 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	if (queue_is_mq(disk->queue))
-		disk_release_mq(disk->queue);
+	disk_release_queue(disk->queue);
 
 	blkcg_exit_queue(disk->queue);
 

Thanks,
Ming


