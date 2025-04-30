Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E339C369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBsjaD0Pqfjc4dBlvRr3DUQqSvp/66vJ/h2DsOXbtiQ=; b=v8yNvX76Qnp0g1mbfdKusw+psj
	A50ZL108Q7xtHiE1uKHA5n8KesVwr7+gOnoP627t0INDjWG4pPFb5CDC5hCVqQ7UcavqU71dkAx10
	ddKO8TseJVSjMwTC/nJpp4/je5sj1TH1Z7b3Kjeqffnfdedv6udqPB+aePUIFI07MiakwhYBLNckO
	9dHPGg8aBKJc2n91kOrd88J+wBawgycp6+C2EGy1sZ93OfOTB7VwcB1h2eGr77vund1oGg0BdnURB
	X5+z7Dw3P2YOv6805pug1CbJXoioO70rcSFRSsUVntndc5SfkuiYpwg/Mn7hmy/OKsjM18EFDHlgH
	6+Op2MNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA7E9-0000000Cwrc-2sOA;
	Wed, 30 Apr 2025 13:11:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA7E6-0000000CwpL-1koS
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 13:11:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86BE767373; Wed, 30 Apr 2025 15:11:40 +0200 (CEST)
Date: Wed, 30 Apr 2025 15:11:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvme-tcp: select tls config when tcp tls is enabled
Message-ID: <20250430131140.GA2191@lst.de>
References: <20250429222347.2215363-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429222347.2215363-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_061150_598205_5277F94B 
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

I've appllied both tls select patches with a bit of commit log tweaking
to the nvme-6.15 branch.


