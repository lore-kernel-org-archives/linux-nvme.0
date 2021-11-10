Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:14:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5DA61186
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E5DA61186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nndBfNfqhcbOI8YYGBnx8yCkSa49zwNeoRFjXuHDD8M=; b=14dgcR5GGl/FXfaHtobh4LQLtu
	VQhTqyRShbEsVWVawmK6hBlspcU94ATdGU3CGffzKDSLJ0XEAOL9PxsJGkXY3AQVCS9gLVX84a+87
	6upRaDPTDmek7eG7lfWf+2g1dPbnOMRSwDoXlV4HiaeHOk6VuFmHsNdXibTW2Gh9xZaBaqlu29GRx
	QnGD5VtChZyC/UpEKhchImsKoOiNqRBvaL2jWE3yXgPHM/0UIcucS3dO1AMPGWu0ulBozJaJtOLsr
	/81oor/TLBdYejxAkn8/Ad6JWh19U8exUWKPgGFb4Dfc0hbDXHYmJA/wIlwsM2tmEHvMGhwzhqEqc
	nYG5MpwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkjgO-004xag-1G; Wed, 10 Nov 2021 09:14:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkjgK-004xZK-TW
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 09:14:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 966DD68AA6; Wed, 10 Nov 2021 10:14:07 +0100 (CET)
Date: Wed, 10 Nov 2021 10:14:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: sorting out the freeze / quiesce mess
Message-ID: <20211110091407.GA8396@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_011413_139588_81146BB7 
X-CRM114-Status: UNSURE (   9.34  )
X-CRM114-Notice: Please train this message.
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

Hi Jens and Ming,

I've been looking into properly supporting queue freezing for bio based
drivers (that is only release q_usage_counter on bio completion for them).
And the deeper I look into the code the more I'm confused by us having
the blk_mq_quiesce* interface in addition to blk_freeze_queue.  What
is a good reason to do a quiesce separately from a freeze?

