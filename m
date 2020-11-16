Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B2C63699
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:58:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A27E223FB
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E//MhfJe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TpTZ5F4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A27E223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Na/URHfepmjvFM6DYPT9dI65Oxh4HBs2goz90EVDpL0=; b=E//MhfJeR1cd+aWCmb3njXcrj8
	pPVhayvwEuF0ZnpjExVp4X45BOSUb07/y3zm14Jx0OelFXqh+yQZOx8M4itcu8gOfM+VM5hsgEq3C
	khX+K++TGViMhCYQr9GznVQ7P9zN+vrcERwpd977BCY6XDBS3b6Zs2TUe88JLwYZoYVbyLiWDWtxG
	8C1ayvxvVc0sMzd2ot01W4EK9SxYjyR4Ei4Q8gFiZ5VgzaJmcRUSmyRW4yw1raS/9xh6gpqeMhM7E
	sg24dM5cpnTgGVciKQdUZpfcmZs7mKrV+6vcr8V4RTj0tRHChgm/Xd0silto67mYW3YbiE/t7Tma4
	+nSK83Cw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kefxU-0003Le-6f; Mon, 16 Nov 2020 14:58:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxO-0003JP-Fq
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=dr8Nr8dbB7J11PqXo+7/b7tximxSHcvF1HcCKGt1IiI=; b=TpTZ5F4/AmdsxM2Cu94cy7eEas
 3X7DT8n5Y9HTYUNPKGh1eqWOrzm0xYcV10TWm7qZ2DAYxl9FZdzB5TSQwbJco0DGEH8GHNaKj4/uO
 UapJemi5kTz7ILke6BFMPk1Qp+enisOjgnM5WI66jPW/Vmd0viYdg1qSGiqiQimTL89OKOdtd5INW
 I0maxo/xPZ0nKatsoAF7NrHgoNRWlnrSm1gKMxhQmVA8vJCsPu08PgWB0cu99api4IM/dOgYmUa59
 BLoaxWXKPrvz0+ejgB6cVN2tLjQDwxy7EgSet0pUC1cws2cyKk57iZ+SQrQfZqgWnLnZ1UKD1blpx
 ffC4VyOw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxK-0003iO-GD; Mon, 16 Nov 2020 14:58:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: cleanup updating the size of block devices v3
Date: Mon, 16 Nov 2020 15:56:51 +0100
Message-Id: <20201116145809.410558-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

this series builds on top of the work that went into the last merge window,
and make sure we have a single coherent interfac for updating the size of a
block device.

Changes since v2:
 - rebased to the set_capacity_revalidate_and_notify in mainline
 - keep the loop_set_size function
 - fix two mixed up acks
 
Changes since v1:
 - minor spelling fixes


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
