Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1885C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 20:12:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEA864F93
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 20:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEA864F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LYq7wQMTVJG/M04i8QcA43+xMFlkrr+GfbpeFE6/cz8=; b=VBhfo2EgPIbOW5x+pOZ3JXAah
	FbFrlOoqSB1z9BFQDP5YK1MucWQ8YAXmcsEesJ9suybvOTpj5mRwth1j7Nl1zc+ckxoOSIxUGKKjh
	UIO1xpkEtrg6+3Bb+m/cx7X9VHWF0gWWHwSPtQpzzBc2z1EH/NHajVoMxuB2yr/0VMYUIFicRLccq
	hrYGE3oanVxnOcdSZNhBGV+T2qrmVIa+71u3tnfqEdeQtKog7iWNqdkkxhQBjIX15CeJMD58l8+76
	ZCyITPzU6J4D3MxuGbvdYiIigt4I8uaEKaBWyThaG0h8LdYlSw5ysNpirCRMQuYNegD+UBkv6gTOe
	Pt59ThoHg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lK5Bu-007f3J-9N; Wed, 10 Mar 2021 20:12:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lK5Bo-007f1O-V8
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 20:12:20 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5102964F93;
 Wed, 10 Mar 2021 20:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615407132;
 bh=Tmo1a1v1MH2i18NK934dp4lhwGgyjWEmVlO4MWpnpPY=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=hGgg+F5jnU9iWQsE0cvtcH1PxmMWMCESxNN+bIhzK6OmNJ01BIcy+2gtw90WpEjQi
 XUZtd0H2rdUqEqL6eOeWwbR4foiei3HPotr1c81RZabxBZ61NSd5gQ69iXNcbYViD0
 RFOZmBIJAgk5FOR2SibjJ/3RFMhauSwqgn6/c6WNlP22DdbQUrHyc77yuATA/vjPLo
 Su6V2Q+cNedRcWB9pX40FE2V73KLAZEJnpaxJvj1CAi4RZt7BFG6GKXDh9HNrAzaPo
 DxFfTPDaafZaOm6qgJAs6Puski805RHfevSkzCiLRQFzzT0MIje2JFWJc/MwqCZzrd
 AwhZYU/fAV0/g==
Date: Wed, 10 Mar 2021 12:12:09 -0800
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme: implement non-mdts command limits
Message-ID: <20210310201209.GB3377333@dhcp-10-100-145-180.wdc.com>
References: <20210310195726.3377288-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310195726.3377288-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_201218_752550_365D9E58 
X-CRM114-Status: UNSURE (   6.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 10, 2021 at 11:57:26AM -0800, Keith Busch wrote:
>  
> +static inline u32 nvme_mps_size_to_bytes(u8 size)
> +{

Oops, this function should have been named "size_to_sectors()". I will
wait for other feedback before considering v2.

> +	/* XXX: modify if NVME_CTRL_PAGE_SHIFT ever changes */
> +	return 1 << (size + 3);
> +}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
