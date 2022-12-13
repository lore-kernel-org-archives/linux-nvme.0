Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD631C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2hgVvXepvjLIyXjn+pQMje73Vmhj6NO6a+EckGUx5I4=; b=j1G9SjiMoSgZk1LvRUbed2KanD
	C/2Tl9p6/HigBEZ/m3YzyF9UAHNkX8ScXa/kyTPfw4G/Unc7nGbjdDsDTgYW2xDAmzo9Va70lLecK
	okufGsgDOlwIpq6z+XlxcyJxFzoT/7pDtKnVaxgrDEowdYa31x4hhWWkCKCtTEj13LzgBGs5RIAaS
	uhLhqsd+oTgWthZPSF4jhO0gxqtBN0pI+CEvFVWNRxZxT7JnOCThTkpYW6krpGTLYE3b1slorSoh5
	gBGxjDqUH1JW2/ni9R4lEl34SwX/0mBbU11YzefbHtefVN4sZC8B1yosfLY2JFi3dnM10H8iwHlDK
	4NkYq5SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p59Su-0040bZ-Ks; Tue, 13 Dec 2022 17:53:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p59Sr-0040WF-M5
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 17:53:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2B95B6166E;
	Tue, 13 Dec 2022 17:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281B5C433EF;
	Tue, 13 Dec 2022 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670953990;
	bh=qHXxPMj7y+nFs7x5xTD4A+hCan+U6uIb4oHmjuRyRy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6e9LlpSxvL0dP0jz4FMKQECx1moSU7mWCfbrIF3D2pFItgPc2kvPNbPyO5tl5sBA
	 Ej0rDAxVcFZZSoOdYyajXNHVc1MwTawyeOi6q9KKrYBIEhuoMsNtGuZYqcvO3PB35p
	 SRhutPpz1Q7ZNlvR1o2Ki0bdJCt/3TIs/alTErGmIuIC3+2rOTNHRyZbwOTv1vttuT
	 HetW03Ro1uyUMUPfVPOmre4S65TS5rfKCwp2DOcKyoXV5BT0u0BqQaLAgCnURyDSVg
	 M5CrfBD3yvDkkhSXyNdm1t6A35KC6F0BBGx/j6Tfrr26FqsEBPnfxY69KKgBnZxcLZ
	 dMX0KqARqfrUQ==
Date: Tue, 13 Dec 2022 10:53:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <Y5i8A84jGCnvLnbD@kbusch-mbp>
References: <20221213162453.584965-1-hch@lst.de>
 <20221213162453.584965-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213162453.584965-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_095313_821495_49FCEB43 
X-CRM114-Status: GOOD (  13.77  )
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

On Tue, Dec 13, 2022 at 05:24:52PM +0100, Christoph Hellwig wrote:
> +static u32 nvme_known_nvm_effects(u8 opcode)
> +{
> +	switch (opcode) {
> +	case nvme_cmd_write:
> +	case nvme_cmd_write_zeroes:
> +		return NVME_CMD_EFFECTS_LBCC;
> +	default:
> +		return 0;
> +	}
> +}

Also nvme_cmd_write_uncorr.

I think you'd need to know the namespace's command set to assume these
opcodes, though.

I was thinking instead of appending effects per-IO, we could always set
ns->head->effects even if the device doesn't support the log page, then
overwrite the log page's opcodes with known LBCC effects during
initialization. That way we don't need a per-io check. Does that sound
reasonable?

