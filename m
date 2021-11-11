Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 10:01:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ACC61104
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 10:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91ACC61104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nvlTnzEGUEsNuq4jtYo7SYEoUZ4ICiiRzpQrAM4y5PU=; b=vaf3a37xKTEn4fMnsl5fCbOT8j
	vk/ExmaLFa7vleTGLrewXpATn4KtIl1LzSyQYSMj3iSD8S49TNJL8nz1PQMgQpZhUIXC3opvoszjo
	VMIdSrt+Nl6JbtYOnpefiAT13b9V1/ThyOZ/Mj6LbiC8/f0p4+vN0LnjO1wNwi9NF9BPPSds2cqye
	bXh1Y+tFOFTwClnFA/pgkFAhUCrHl62/HNWX2D5WYVu6BOt4Mobh5b7r/lq03GVBc96DxZRbt56JU
	o788ZHCokO0HjTXjdmwFB/756+FN47M8y+z2lOraCToor0cVe5wE2/6W8IqsqKDcd+77Q+vpsEK19
	GgBV9wjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml6tS-007e1m-D9; Thu, 11 Nov 2021 10:01:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml6tK-007e0S-GE
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 10:01:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9A6DC68AA6; Thu, 11 Nov 2021 11:01:08 +0100 (CET)
Date: Thu, 11 Nov 2021 11:01:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211111100108.GB5343@lst.de>
References: <20211106020858.18625-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106020858.18625-1-ematsumiya@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_020110_716318_C38803DC 
X-CRM114-Status: UNSURE (   9.14  )
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

Thanks, applied to nvme-5.16 with a few cosmetic fixups.

