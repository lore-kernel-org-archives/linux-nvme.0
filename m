Return-Path: <SRS0=poiV=NT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0662FC432BE
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Aug 2021 07:37:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8E3610CA
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Aug 2021 07:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA8E3610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6rQiwt62GoY5s+dlO2lwKTsyqjGLp3vpiylFDOPB8do=; b=CpcY1FwgaTdtpe
	rPUwduInY2Zc8JFPZfx6+4TzAlhwhyyNfC6zHKqerpkX+LNuAo41HqMtjV8OY/zr89kZl6iLZJbI4
	rSmCMqHa0PWq3x9pnkFlNSt+uPkfsCTof5qdHvDUJ+/PAUvumMwYC9GgaXrIgVlWGW/az93MOh1mr
	SD+fRLhZIkT+QRqARUGZ2aV6UsZ7wrHstalvUZZUdzu3ZeUHRZTi5UsMXIuM42g1WNQ+YiOw0lrJm
	h5r5zyLKuBZadCJca4oSoUzRMR91fffE4cNrEDorhyre02o4ICEg6sm7+frcjQlREU5RR8deCNWov
	Yv46undKmQxlA2ptj1KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJstf-00DrAQ-RT; Sat, 28 Aug 2021 07:36:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJste-00DrAF-HI
 for linux-nvme@bombadil.infradead.org; Sat, 28 Aug 2021 07:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0ts55k9K+AeTzI9UinkPG1HeoaDA8i8L+H7cb7KVKcM=; b=gQt5y7F7KIDyZaXkososCL+fcG
 T2PIBhRo7HPDBmFHt+eO5KVFvLgVeZGwIKrYR2niVA+3/g2ZgL6e5pKHzjoJmm0lyXek03Dv0Du9P
 aZPQdbYOqZW9kGWcEzCGEYiBC3pfLH7iGVFSfZM5kWNvH0m++Rshqf/nGe+kSXO61lpgRAxS2aPru
 Uo7s6HzZswFEg9QYlOpn1F2dRXGqoTY6EN01HI7Kx5/EERLBx+3USkpv/0tBhHPTid8VxgaTIH1K8
 0szPfLe0HpykgcgAKjnsv0AbqbOddfn9BTTTgLf36cdVT819hgNoou8J9itvpsS1yuvX6iIb4uQTj
 9lt1aQUw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mJssf-00FNYs-A6; Sat, 28 Aug 2021 07:36:12 +0000
Date: Sat, 28 Aug 2021 08:35:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com,
 hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dm: add add_disk() error handling
Message-ID: <YSnnXdKLvxEY8yay@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-9-mcgrof@kernel.org>
 <YSSP6ujNQttGN2sZ@infradead.org>
 <YSk1EhUIr9OjIoVv@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSk1EhUIr9OjIoVv@bombadil.infradead.org>
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

On Fri, Aug 27, 2021 at 11:55:14AM -0700, Luis Chamberlain wrote:
> > I think the add_disk should just return r.  If you look at the
> > callers they eventualy end up in dm_table_destroy, which does
> > this cleanup.
> 
> I don't see it. What part of dm_table_destroy() does this?

Sorry, dm_destroy, not dm_table_destroy.  For dm_early_create it's
trivial as that calls both dm_table_destroy and dm_destroy in the error
path.  The normal table_load case is a separate ioctl, but if that
fails userspace needs to call the DM_DEV_REMOVE_CMD to cleanup
the state - similar to any other failure.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
