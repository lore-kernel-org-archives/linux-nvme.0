Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7E3C2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZ6sqrTjhmaRk5mQHDoODStCxIncHHw0DSrgcb6Bdtc=; b=W/URC1yaAxv8+w4q3zWtnFAMaJ
	IhI/junZg5ZfFT3rSkW4mHTRX+lI5g1mU/M4bJPnPuRTtlqdNe1gW8ITxSltZRn85IiS3NMaFq8UV
	wmm6TGaAkMEvdcCMYKRbwdlpa37KMJLzBR2RB3pkINF/7ZB/JCx181WzwJUIffF77RMcHpofbHG7t
	WawaO7tpFoD69DldB4mQwPgddjc/upKCOCq9TflPsdfNHNAEE4vecQQ3u0IR+09JdSNixPtlUuoov
	Cs/ToQSNYVcwGFlBaN6BXLrBecg+CO3eZEwexEzYiUB8hkdAYB2zEWlzQKuX4vN92XblAwMUzaFNL
	NQ8Ixk2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nClvm-00CwZW-14; Wed, 26 Jan 2022 17:18:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nClEL-00Cf6y-2x
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 16:33:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3DE1B68AFE; Wed, 26 Jan 2022 17:33:06 +0100 (CET)
Date: Wed, 26 Jan 2022 17:33:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <pankydev8@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Message-ID: <20220126163306.GB31892@lst.de>
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121143533.164928-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_083309_316183_AF4CA1FF 
X-CRM114-Status: UNSURE (   8.79  )
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

pci_iomap goes with the ioread/iowrite accessors which we absolutely
do not want in nvme.

