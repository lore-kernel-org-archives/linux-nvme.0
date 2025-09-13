Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE212CAC587
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Sep 2025 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEKh1libysPDoaju7X7y9jetjodl7RPPl/Pmt845K8k=; b=R+ATfvJ14gno9WH2w6f+ntx1os
	VVPw+pCIgYZce969/UEH/RlWKwZi/Qwoye69L3GVejyDSOrXeU3oL5wPpLHfc1ZzfLbBgtyNKISDm
	uzYmDJU0dI0h/2p+x9ihKXdT3x5NMYQgQKHX9bXZNJehlzw70F/fxhEUsineBdDYubqDdcqgGAvJp
	OTpvGH/fCfpVKbahsgYsvBw5VLhqIJLSx1rtsWIZX37del/QmLASa6Qj8jiDYOyDFyuDvr32QbPTW
	m3tiRBGjmzreTf8zISDAOopDho4yCpa9/qVq+BmbnzvWBaeio5DTLi4UiUEAQLtumW0s1Nk7IWBV1
	rWmy73CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxKDX-0000000Dd65-1Gr6;
	Sat, 13 Sep 2025 06:58:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxKDV-0000000Dd5W-3YBo
	for linux-nvme@lists.infradead.org;
	Sat, 13 Sep 2025 06:58:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A0DA4419D;
	Sat, 13 Sep 2025 06:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69FAC4CEEB;
	Sat, 13 Sep 2025 06:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757746717;
	bh=NfVbSUIrN6naVoV2RRVp8yP2NKpTbnxv27zUjTWjWMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oTif99VuAE2puGVxK6iKvJl1gkVyO6BXKU7btxLuKorMtAX1BwSTlBKc9I+zhKaT+
	 oCnxOCqYcZd/oZkRoBfd7EfUGwfr+7ho4RiY2oU6q6LaD0oqxEi/CixpJekY/51I5t
	 USekyCyuTIP7LI/fhafJdK7ke4pbVY2/x24TazOLgUXIshr4DJ6hyJwWkVuq8vXg0d
	 WkA6qi9m7qRq4T1OB3gXFrIkikP1MYphFNUb2YD3IpV/fmrA15Fm9JpFmaaTsP1CdT
	 rPld+YJmlYLxTfoUkA6/LO7tLo+nTCudRqGl75vrSmUwN+wYusC4VjGB5AifWLSuLc
	 59M5fh/MAbpgw==
Message-ID: <700ca200-44c5-4565-85af-9d7104d61d94@kernel.org>
Date: Sat, 13 Sep 2025 15:58:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: pci-epf: fix DMA channel debug print
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Niklas Cassel <cassel@kernel.org>
References: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_235837_920507_27BD0AA0 
X-CRM114-Status: UNSURE (   6.67  )
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

On 9/13/25 15:53, Shin'ichiro Kawasaki wrote:
> Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
> print debug information about the DMA channels for RX and TX. However,
> both calls mistakenly are made for the TX channel. Fix it by referreing
> to 'nvme_epf->rx_chan' and 'nvme_epf->tx_chan' and instead of the local
> variable 'chan'.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

