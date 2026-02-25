Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A49FD45FA
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSlSoZdhd+uwvIlvt5xTf4hVnS+wrojFnj1H7eeev6o=; b=pPSEwfTutjAkHmjy9a5c4meEAx
	308stG46E4OVHYBoddti/Ima5siMPHz/S4T2xjqBNKNiR+Fq91D2tSHfTEjcNwE5o9XtFtzQZ7EjK
	Ya2gWPpgAmnJUdtOnfhBQz+Ug1tGwQiWFmfIcYYTOyvLKqaftZ4cttbLWgTG8KWx4Lk1X3UOZCPJr
	LENTY7dy92hxBX842aOlOKtwOCfGbFwQ9Pj5cSgWALkhaRlqV3dHg0Z3MoFPEfPcDYjPSqKZXRIFS
	Nw6/8HY1SCBAiv45f95Bus03qWqDpgnGr+KWQUrsLKX4YwnTC8GDNFPEZXgGHSJR6XGoUiPFrRB2l
	+s72cttA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNhf-000000051Yf-28Nq;
	Wed, 25 Feb 2026 22:49:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNhd-000000051YS-4AnR;
	Wed, 25 Feb 2026 22:49:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F6E660053;
	Wed, 25 Feb 2026 22:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F67C116D0;
	Wed, 25 Feb 2026 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772059796;
	bh=mgxqDo5rlL2fSjIeQ+XKlvcKVTdg4JhBlzt9laj0qHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLQgSWqwB5/tv0+42PqFvJIC6uAPHKjAVuUraKTMifpKvdyvIvgx2av6xiXb+jH5w
	 vfxvNUjNhJQFj7zDnuSMySWY8oxqftC2658+awD+Z+ssthXdxbiRx2An5UKGIFeWSW
	 m+38CS/WIcesBthKltLTgLd6s6YyLAEHVGDq4KfM7hukPxRtfCPnQNWC84zww7ujzV
	 GkMRN2aBhoBsLVtQ+AL+0EQxWMyo9+QZJEmm9A++JG1qYr+RfGPm9tKIQRmFWkajWl
	 82fndr47I2wtRIv+6rSlpJIR0iMlE8DmQUIsXlOHENAShAHcrP2x+JZZmYK471ujpS
	 y9e3wzlMle7Ig==
Date: Wed, 25 Feb 2026 23:49:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aZ98jbxb2Wh-yRe1@ryzen>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aXD/EYqhhRJEN8oy@lizhi-Precision-Tower-5810>
 <aX0EXjM4LlO3Hygd@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX0EXjM4LlO3Hygd@lizhi-Precision-Tower-5810>
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

On Fri, Jan 30, 2026 at 02:19:58PM -0500, Frank Li wrote:
> 
> Vinod Koul:
> 
> 	Do you have chance to pick up (at least first 2 patches) for 6.20?
> So I can start do more cleanup work.

Why only the first two patches?

Mani has already given his ack and said that he thinks it should go via
the dmaengine tree:
https://lore.kernel.org/dmaengine/6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym/

The series still applies to dmaengine/next btw :)


Kind regards,
Niklas

