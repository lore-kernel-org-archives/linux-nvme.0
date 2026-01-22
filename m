Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AFEC44536
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jan 2026 03:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jY1UDeMx6rM0zMCWaEjEeBzqhjFrDAC2J3qUJXIR/AA=; b=vHaKKjh3R7oiBXjew6OZar8El7
	0r9CPb1+Y+McnN/wwlv1p/9GVk/uUZEEZgezl52LxWGy3c/7q6U1jvF26teEStTMy0NcSIUMLwlF8
	Z5Vy/r7dUUXiwWDh+xsX1a1HsQRoCN5vkjxjVU4MmRFxNVF5xIYS5Pz1+zQOkIw2Ccm1yMCTtaJH7
	v7muLrnWmmAAQbLu9meEzbgOb6zizYevMqlnAOhHExwrgZRxezl0WFoPjwPFJy4pQhT6xXFv3xaO9
	tHZvCj+pM6R3E8EwX8T4pP/U69IH5xOPz5q/1OTDCai5Lpiiy5yhZAreq3ws7pn/eDNxUcwpw2ZOa
	DGWQATEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vilgI-00000006OFY-3WOQ;
	Thu, 22 Jan 2026 03:48:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vilgF-00000006OF1-3cPG
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jan 2026 03:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769053702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY1UDeMx6rM0zMCWaEjEeBzqhjFrDAC2J3qUJXIR/AA=;
	b=IvYlcrIjNtdefbhYtz3Fmu2XYZMSmosm9TMkEs/NGubNHdJ7JZag+cw0OUXm4jB1dMpllk
	R3qqU23834eK8T3vB31PtT1Iml9pgg5MfDw8jEXBNrKgCw7e06VP0rmxtH1xaJnxLKSvUV
	9rYRxQWdeuG9eExJO0moTbSUUjC+ruI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-zI3l2cyPMYKAhP2VbJoC5A-1; Wed,
 21 Jan 2026 22:48:19 -0500
X-MC-Unique: zI3l2cyPMYKAhP2VbJoC5A-1
X-Mimecast-MFC-AGG-ID: zI3l2cyPMYKAhP2VbJoC5A_1769053697
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3087E1956096;
	Thu, 22 Jan 2026 03:48:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56AA71800577;
	Thu, 22 Jan 2026 03:48:10 +0000 (UTC)
Date: Thu, 22 Jan 2026 11:48:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, fengnanchang@gmail.com
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU
 in nvme_tcp_poll() on the latest linux-block/for-next
Message-ID: <aXGd9vPeFOBgyrrG@fedora>
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
 <aXCT9sFChMdhwNYw@fedora>
 <CAHj4cs-VK+W6UXeiiTdarw+MoFtn4xe9diU3CtHXaRy7kGQxgQ@mail.gmail.com>
 <CAHj4cs_BWMOsn7MwNc=YNsmN=TM_r8WK_o2qa3DedqA4rtHefw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs_BWMOsn7MwNc=YNsmN=TM_r8WK_o2qa3DedqA4rtHefw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_194823_970543_EA113EC7 
X-CRM114-Status: GOOD (  19.85  )
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

On Wed, Jan 21, 2026 at 10:15:56PM +0800, Yi Zhang wrote:
> On Wed, Jan 21, 2026 at 5:03 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > On Wed, Jan 21, 2026 at 4:53 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Wed, Jan 21, 2026 at 10:50:00AM +0800, Yi Zhang wrote:
> > > > Hi
> > > >
> > > > This issue was observed on the latest linux-block/for-next during CKI
> > > > test, where enabling the poll queues leads to a tight busy polling
> > > > loop and 100% CPU usage during "nvme connect".
> > > > It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
> > > > I will try to bisect it.
> > >
> > > It may be related with f22ecf9c14c1 ("blk-mq: delete task running check
> > > in blk_hctx_poll()").
> >
> > This commit merged to v6.19-rc1, I will revert it and retest.
> >
> 
> Hi Ming/Christoph
> 
> Confirmed the issue was introduced by this commit.
> 
> f22ecf9c14c1 blk-mq: delete task running check in blk_hctx_poll()

I guess the need_resched() in blk_hctx_poll() is still not enough, and it
may burns CPU too aggressively, especially for this in-kernel special sync
polling from passthrough request in nvmf_connect_io_queue().

Please try the following patch:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a29d8ac9d3e3..968699277c3d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1480,7 +1480,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, 0);
+		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, BLK_POLL_ONESHOT);
 		cond_resched();
 	} while (!completion_done(wait));
 }
-- 
2.47.1



Thanks,
Ming


