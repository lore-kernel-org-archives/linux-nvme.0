Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA499C83000
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=q0HNWv4VoMkV79vhtfnYQ58LBs
	OBp0GQSobm1bulmi3ZdTW/T4bLMm+ajsooqCLs8NA0sETRgKEkTlqwj5jeMvezuQDGDP/vWiMcf2f
	7GI7V2H9GLLHnUBWpwdpeOTx/+E+jqaQNWlmQameLQDS9S7gjtJu8tIFsmFzycj+v0tqollLP2tkA
	WvCuuWZVA4x1B/sD+cuxnAsEy0VUrJCvpQe7jGgBQgpKV/L0BJucmDoDfR5qP3djPnBcdz9yuv5jd
	j8GyLdBdxbPipfjtgWEVrluVsvRYue2XuJG5pMjEYTMww/yAHKmoAPIWb5ZuxjAX00KEKcoPOgYxf
	dgSoWILQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8Gu-00000001N4w-3TTU;
	Mon, 30 Jun 2025 06:45:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8Gs-00000001N2L-2SDE
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:45:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DBE468AFE; Mon, 30 Jun 2025 08:45:33 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:45:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: Re: [PATCH RESEND] nvme-pci: refresh visible attrs after being
 checked
Message-ID: <20250630064532.GA29859@lst.de>
References: <20250613192102.1873918-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613192102.1873918-1-andrealmeid@igalia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_234542_762645_74769C38 
X-CRM114-Status: UNSURE (   9.07  )
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

Thanks,

applied to nvme-6.16.


