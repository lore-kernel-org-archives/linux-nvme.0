Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:08:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E3160D43
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9E3160D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bh1OH5V/oXV6axi6Wa6ZUOnVKPhnkofaE34tMa46+lc=; b=PGdJDBCT1mwF5s
	SdTV23/OigCC5lfdPNdv0h2aB1LazqEqSfo/pC6rsQbbxGqqk2umfoPkMnf3ffO1oenZfCDo1cu1I
	0fPBKBmeo4Peg9imJa5VC7RxpoGHVEGpI0knmX3yW4F0U57mJNWh6f41m56/HFanQ905++rRRf58u
	hxUAEapoaWPhZ2y2VqLnlnpSwwLdS//J/irCFk+9BgsLSawh/tIb+qEdu7OHXE+UHaBR3yywJ3Mmf
	/FlBMfe8fwTBz5QciZKwQ6feON7rJXg+saKQL3GFW+c8dmTPEuf1RfERBmav3f8oOTJhIf/Xfu8NR
	FdCEpH3cfmbAgKultEsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJOJ-00DIZ1-Qq; Tue, 12 Oct 2021 15:08:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJOH-00DIY6-IL
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:08:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9F3FD67373; Tue, 12 Oct 2021 17:08:27 +0200 (CEST)
Date: Tue, 12 Oct 2021 17:08:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <20211012150827.GB20571@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-7-ming.lei@redhat.com>
 <20211012103010.GA29640@lst.de> <YWWki6An1sOpx3rV@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YWWki6An1sOpx3rV@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_080829_779938_2FC286C3 
X-CRM114-Status: GOOD (  15.38  )
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

On Tue, Oct 12, 2021 at 11:06:51PM +0800, Ming Lei wrote:
> > We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
> > at ->quiesce_depth directly.
> 
> I'd rather not to do that given we need to check QUEUE_FLAG_QUIESCED in fast
> path.

Checking an integer vs checking a bit is easier actually faster or at
least the same speed depending on the architecture / micro architecture.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
