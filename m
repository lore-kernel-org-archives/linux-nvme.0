Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BC0E68956
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VXU3P3CKu2CT5kp8vggCo872TF
	wXwnWNdRrFmnutIKPNf6EqXB5QLNNG4ybXez5VjdJy8oAhczBc/DJQJ75YkX5i1cVJljTsEVKl64K
	8HUf4KQuVGALcnfAi6IgSEP99p0BRfAIHtUJUI5rumPM6hHj8pooMcfCax6V7F4h913ai9V2OPGOJ
	J8NNCt7UaX+MpeeDj7JsKIn6lULHnPEPVINVTzXKZ+mbvGYMHvBYzf93qSEfT1XPJ0+zyfgp41ifw
	Q6/5u8gnyOp8f3ReL1Ho7z+VJZo3GBP5tVfquva2H3tiUEswKKL/Sfjulh63ODaM6RwbeWfwLiLMW
	PO9eoEnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6PDJ-00000002kSQ-11Js;
	Thu, 31 Oct 2024 07:03:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6PDG-00000002kRi-1OrB
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 07:03:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F288868AFE; Thu, 31 Oct 2024 08:03:17 +0100 (CET)
Date: Thu, 31 Oct 2024 08:03:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-core: remove repeated wq flags
Message-ID: <20241031070317.GA26547@lst.de>
References: <20241030064737.95291-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030064737.95291-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_000322_524339_738B4821 
X-CRM114-Status: UNSURE (   8.25  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


