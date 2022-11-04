Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04725C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDpGQXH2BJCfW4tLSZFpGbrdCr7IFAxZ4CdgrPYbGxQ=; b=QN4jwgFXm+rN4eMg/nTCpKTTYt
	9Htpku1rbGAF3MKXO/ziZfDEkS8MmlZvuQMx8xqeQpEPEgF0zYGrA0CabtK2eov+SpDyvVhj24SMh
	p0qftriD2bERmbWV7Vzjzkr2pW9UAcFrGTJ1LYOSFrgcORoNrFsH7RFMFMKVJQ+Apq6x2PbED+UZC
	VAX3IzSA7KPko2fBSFCdgPeyojFoSfhvt9jYFjJh1C522be01tr/QZFcM66iez5I5TI+6iSO8IG5S
	xuF8Pd500dIer5jJOwuhqiWSB+R9PeGNsGdJgq0k9JozQ6o6mbndDeLXDYCpFgCbL142qUC9PQMQR
	zIgN6NNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqzMC-004PgC-0p; Fri, 04 Nov 2022 16:15:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqzM9-004Pft-IW
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 16:15:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 534B162272;
	Fri,  4 Nov 2022 16:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5E0C433C1;
	Fri,  4 Nov 2022 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667578543;
	bh=BF32zu5BdgRFY+X0dBO2QhNpBFNsBdgVPgyhKwwmT+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTKcQMnnylNeCkbF7pp3o+oJkHqBjZZWvjhQmUKrZ3CJ4LizMLb3m7o/6eyYSFZfX
	 Xe0RqSgLzgypBeA1yPhHZLNp2uYykd1Yb02on18crya3Z385VCimT04mhegRDjnyM8
	 hS8R2OVKxp9EGdR5+6IhfSJfYImUK04jeGBlLIIUfx1HfUiW79hqvdfqNWt2hwxRoC
	 5CQ0ycDtnD7VajRsdZzohfC00I2JsxokJMcLoIA3IZFfpYMkK8dCP8cAqU7ConDXNO
	 Dw3lQONJ3riUOA7Gu5juOvHE9UoJ76576cgjtexvWdLbmDBJuxO0TVBF555mKBS0Le
	 cthfLz9nzn3Rg==
Date: Fri, 4 Nov 2022 09:15:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Shai Malin <smalin@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH v7 01/23] net: Introduce direct data placement tcp
 offload
Message-ID: <20221104091541.1f014b7d@kernel.org>
In-Reply-To: <253eduiu946.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <20221025135958.6242-1-aaptel@nvidia.com>
	<20221025135958.6242-2-aaptel@nvidia.com>
	<20221025153925.64b5b040@kernel.org>
	<DM6PR12MB3564FB23C582CEF338D11435BC309@DM6PR12MB3564.namprd12.prod.outlook.com>
	<20221026092449.5f839b36@kernel.org>
	<DM6PR12MB356448156B75DD719E24E41DBC329@DM6PR12MB3564.namprd12.prod.outlook.com>
	<20221028084001.447a7c05@kernel.org>
	<DM6PR12MB356475DB9921B7E8D7802C14BC379@DM6PR12MB3564.namprd12.prod.outlook.com>
	<20221031164744.43f8e83f@kernel.org>
	<DM6PR12MB35648F8F904D783E59B7CE01BC389@DM6PR12MB3564.namprd12.prod.outlook.com>
	<253k04ct08y.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
	<20221103185713.5d2ec13b@kernel.org>
	<253eduiu946.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_091545_676005_30AE78B8 
X-CRM114-Status: UNSURE (   9.03  )
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

On Fri, 04 Nov 2022 15:44:57 +0200 Aurelien Aptel wrote:
> >>    # query ULP stats of $dev
> >>    ethtool -u|--ulp-get --include-statistics <dev>  
> >
> > -I|--include-statistics ?  
> 
> Could you please elaborate what is the comment?

Since you were noting the short version for --ulp-gen I thought 
I'd mention that --include-statistics also has one and it's -I :)

