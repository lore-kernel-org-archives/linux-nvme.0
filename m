Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B91FCD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LFli4dnk0HT8iwqSS7CGUBrndzcFBbOS+SFg/xg3EBE=; b=0Hith4Dl4cPsfx9qCl1CI3R6Sq
	fied++fU1b3wPGvkv9doPqZxyxm7pCL24DLuUOE+AxCR9C5WyDG30wksgKnqIpiWEFFoZ4P6zWxUo
	n0HW3WbmJEEAqtGOdZ06xJCvBmndxg/U6h9YSgDYdDRAIYhFKXBIfaJsH2LI252ogu+Che9Xihwr3
	e7QB6ZnF84/ep5BKuQ2XceqbAYcMEg0BeKaAxRtvFXN/BqzihbDqHTmz0si8egFbYQwBRfsWNEWpA
	n37JoZRw5LL9AM0uTOgH7VVWIgZd/8BoTsytpcmGwv87IyBcr5EeRkcRPwjVzcHyAvIi0ILuxxd+w
	+O8MubuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNqos-00000008Cvi-3zn8;
	Fri, 15 May 2026 11:35:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNqoq-00000008Cv2-1jKp
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 11:35:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37D7968B05; Fri, 15 May 2026 13:34:59 +0200 (CEST)
Date: Fri, 15 May 2026 13:34:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, linux-nvme@lists.infradead.org, bmarzins@redhat.com
Subject: Re: [PATCH] nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for
 multipath_sysfs
Message-ID: <20260515113459.GA25213@lst.de>
References: <20260513095030.2771178-1-john.g.garry@oracle.com> <20260515044529.GA4003@lst.de> <bea351b2-2cfe-4a3c-b2ad-7185b29a4af3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea351b2-2cfe-4a3c-b2ad-7185b29a4af3@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_043504_597530_3575D006 
X-CRM114-Status: GOOD (  11.01  )
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

On Fri, May 15, 2026 at 09:34:30AM +0100, John Garry wrote:
> yeah, lots of #/## from those sysfs helpers
>
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by?

Yes, sorry.


