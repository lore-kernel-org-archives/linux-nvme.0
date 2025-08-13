Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B3C87FCF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 07:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=f4oPdlDGGf0ytFTwPCAI7Stg+d
	X3DbFy0U8rmNigXZbEufxdYIhgOOzEYeoAICXYFleMV7kbkoESShhojKIfSh0MIMF4mI8khb4eXa8
	23kJ+Lsoo9Zo0DiPXz9FDxIzFFb4j90+GoIvhKKZeSj6lXgwXAIQqELX0nzQiImWVK9HGXnmg3UnH
	XcKheK3IkHFt4aBKggGL+nzH70RLa5FVhSN2ULfUPurXki7qqhsCOoVL5nG8+yKfOuAvcal05PUQn
	cy/kvBQ4KNMqKoECAmlJHF9MUdHyS7K50DsBpURRWLZgfOzjwdx8/GOx2FgGyexo96xlTO87KNcYV
	h/Ojy1kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um66c-0000000CxQU-3pap;
	Wed, 13 Aug 2025 07:41:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5LU-0000000CqLP-171L
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 06:52:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F15AA227A87; Wed, 13 Aug 2025 08:52:20 +0200 (CEST)
Date: Wed, 13 Aug 2025 08:52:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv6 8/8] nvme-pci: convert metadata mapping to dma iter
Message-ID: <20250813065220.GB12473@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-9-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_235224_436961_BBDA4571 
X-CRM114-Status: UNSURE (   8.60  )
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


