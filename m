Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4658ED5C0E4
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Nzp1lxksEGHScjM1n1eMaBbay0
	ut5V49nwITRZvtk+GcNXHG0Ty/c8vzE8yYT3G2r0tiDl9CdPZbatg3cJVnQ4em/kBTBEm5nfXAgS/
	0Y1qsr8oxVXMQZqJZbVY762XzSvcY/HpB+fX+V/76yr0yyPB8YuXfgzxiuE7bdFQRPSkufjr+JlPL
	SpUNjujyn0X3G4SK0tCHskNT4cEylOrVERJFYtIoqL+XDK/2PmqoqQu6k5GDSjaOtc6uxvRegzLZF
	s6Jy5b3AK0yEQPy7GacyEh6cOsE/jK/P0hbXfBL9h4pDxBrz+6ERRcyhSR0l3euJcQnNLCwkLM9Bb
	UarA7nKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QX6-0000000AxCu-3NC8;
	Fri, 08 Nov 2024 15:04:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9PsB-0000000Apmq-0ivk
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:22:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98D6468AA6; Fri,  8 Nov 2024 15:21:58 +0100 (CET)
Date: Fri, 8 Nov 2024 15:21:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 01/13] nvmet: implement id ns for nvm command set
Message-ID: <20241108142158.GA6694@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_062203_365715_AE75FF13 
X-CRM114-Status: UNSURE (   8.78  )
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


