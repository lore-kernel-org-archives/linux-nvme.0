Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83277C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=L9E3xUrMSE8yNlF5iiBToOF1Vr
	nZMc3vdEmQfYQYFCbuZw29vekQIYfgKVSZ+YLzjSjiUXBPuz6YgMR/kuiAtboto+klSSNDQj7kaTJ
	fE+0E+40lOhTL/Bp4kJ99eKJkh9u8RdqFpAxXUTB7Kw16Dq+DQ46AJIZwdpC4rba79pg0Sk3fI9CB
	Q0zto4SQwOwTlmjIaDa4TcrULG5UGSJCYZwrDWyX/JuL1fTJtjPAlF96BR2MWrCbxEr1oEnKuqLub
	MGZnp6VKaQipzaVwyq8IyL0vXNThqlm+iViWWHhLAwv7nV8wPhfxImH2MOJtg20F5HPxea2ohBqqv
	UGGa7G5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxuwx-0072X4-Nj; Thu, 16 Dec 2021 17:53:51 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxuwo-0072Tu-AU; Thu, 16 Dec 2021 17:53:42 +0000
Date: Thu, 16 Dec 2021 09:53:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <Ybt9JuvfNNQFt09w@infradead.org>
References: <20211216163901.81845-1-axboe@kernel.dk>
 <20211216163901.81845-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216163901.81845-5-axboe@kernel.dk>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

