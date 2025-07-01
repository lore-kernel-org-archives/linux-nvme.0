Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A3AC83038
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eQhis5TmydlJSImUeKdjyx5vR621JqqePqYksAkIsY=; b=KMX9+msJtzc1F05HYKpAseibJE
	j4xSlDBsWTYP0uIOuNRH0plb7CGwF+AcEzI1l9Aqs+CsXhlPsMCfTBn3DADWzeEEkvx9hYvkbJ/79
	nIU7dEdwR9BM54da7gcavN2Dmyq2DasyTTlmQWP8SDLC5EMrKw4ctCEePEqWqK8JUhn+tflch2OS8
	cjEV2638DgIv+SZGEXnM27rClWVNkmY2ky6T3KczZA1cDpO/D0jPmNfQIaPmYlLFBNlgblPifF3f3
	UohAyNLKRFDCL2NFp5Z1SSdMGiF1jJkJ8WNcWLL7yzHvuT3w+/TaMKz3J9tbqcUoUj7pIzUDZe6lj
	mX7tNTZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWbRB-00000005b4b-1h8u;
	Tue, 01 Jul 2025 13:54:17 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWaB6-00000005Kxk-2CwJ
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 12:33:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 61D52A52F38;
	Tue,  1 Jul 2025 12:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D2CC4CEEB;
	Tue,  1 Jul 2025 12:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373215;
	bh=an6El7LQThWyxle2ua9iz3GhLonkcJ8T/Jl+bJxDVag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1u43gwPRMoQ/rTZvdkqeBcUBEYwT1QZ4BkzVjCYor+tAmTzI775BRdA6jANrTy9v
	 065owKpzED1m1iv0KgNaH4NxJqbj5BBr+Nv8plmoYJpSuUqZh4LDUoDxnZdffNAkSA
	 sBc5PMqxGMrpj3T8mfwxHvEShk3lS31H9N2+Z8vmcITFSeQ8V+YY/rdwcq0RLbkVbH
	 HrnTKad+h4rV2x8buOteKFhBMgSpF4l2L/mKADQucRLTJKUVtKlJitj4fEiTvybHQs
	 zptQY7XHRTVNsxPoOSyVMxVEFx+AVDho6C/ZvrNRttH5TvK7IMx8pZIV9R8ez+gh6F
	 rIQXh18tODtjQ==
Date: Tue, 1 Jul 2025 13:33:28 +0100
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	tariqt@nvidia.com, gus@collabora.com, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH v29 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <20250701123328.GO41770@horms.kernel.org>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630140737.28662-2-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_053336_631597_C5217525 
X-CRM114-Status: GOOD (  10.59  )
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

On Mon, Jun 30, 2025 at 02:07:18PM +0000, Aurelien Aptel wrote:

...

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0f2443d4ec58..c1b3d6e1e5e5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -507,7 +507,8 @@ struct sock {
>  	u8			sk_gso_disabled : 1,
>  				sk_kern_sock : 1,
>  				sk_no_check_tx : 1,
> -				sk_no_check_rx : 1;
> +				sk_no_check_rx : 1,
> +				sk_no_condense : 1;

nit: sk_no_condense should be added to the kernel doc for struct sock

     Flagged by ./scripts/kernel-doc -none

>  	u8			sk_shutdown;
>  	u16			sk_type;
>  	u16			sk_protocol;

