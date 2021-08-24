Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7691EC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:03:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA8D61248
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FA8D61248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=scbsaLZsiGsKkXgG6sFVSDuFXh2caNo+AVSUo6vSNdc=; b=cjfor5y1FpbYjo
	eXLm0LwMJLyhWAQrgzTNJQLn4ute+HYl8GvNxHnrO4ZGqmjBqyqu4q5P4gBP/kTUIWU0Y9y6NFdbl
	G22WJjolQ4eZaQqV9QM2+8zy8bpOA8Dqo2h/cTj9YUV4UPl18s58UeG3LIE3Dm+El2uBiTYIwGYI4
	4P6OIL3nxChT2c7onElt9AoryzDbhHfxakNGIc1BK0AO5hEWmm3kceUinpQQDAL6GpsLQ1vCf+Hm9
	pL+F2tQK1PjoSCIb18MY2ZAHp2IivlsTppvQSS54mJq2Yq6hg/vbM5UDDX9Nd8QYo3VHg3FbqNLUA
	DsC3jhLrUdurK/9tPfaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIPWA-001lmD-Vq; Tue, 24 Aug 2021 06:02:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIPW9-001lge-59
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 06:02:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JcT1aJS86g1/QsjFdAkPecRM4XBnficOBnxN044pPFQ=; b=NwDFWcCkHKbD2sOCndJXglXHqd
 K7MzimfAkHKuRQaTiSO2Zlf+HMWfZC2sihSBMQre3wLwOT09IliIQCvRfac9aYQJCsXP4iSRZk7tT
 rI3tdEITmFL96vtZQK4+225Nljv8fFVWOfTHHtfXHfLlyqSaEDS3y48+AuuaWeL3k6U1Hizv0H3g4
 UAkw7eMasY6QdYrfChNh4nw9Kt0WjAsv3848F0XH7f+3SJNNaQndpIblGi0kMDU3hL9skulY1fryC
 9uidUeYQJqGCuc7fsh81EBPHO6uTACeG/bHuJgqFZcp1W9l2hbpcXjnKMNLtt0lLj5wVbUCbxO5Qw
 0yMFkz4Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIPU3-00Acmq-BR; Tue, 24 Aug 2021 06:01:01 +0000
Date: Tue, 24 Aug 2021 07:00:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi/sr: use blk_cleanup_disk() instead of
 put_disk()
Message-ID: <YSSK+0afMcpUAKyK@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 23, 2021 at 01:29:23PM -0700, Luis Chamberlain wrote:
> The single put_disk() is useful if you know you're not doing
> a cleanup after add_disk(), but since we want to add support
> for that, just use the normal form of blk_cleanup_disk() to
> cleanup the queue and put the disk.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

.. not needed as the cleanup is done by the core scsi code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
