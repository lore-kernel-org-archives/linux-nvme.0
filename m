Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37699C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GVqokTdnyNvEtTffGSlxrSmviSDd658uGG3qpUHIuI=; b=HRPUWxKHr7Esz898cS0Q89WAxr
	Vw99XGUXnJ7KZtboMsMH7QFC0QM7i+5yVwAK2jWZs2M5zCKahTt0JdjCNi09U4CiXIdGytX3SMbFb
	Xe+ENWKggZLownur/lU8AbaNzbK1r2WVeUsBhP2EoG5VXra0ZCN98QAGr+8y+AazE4cq6w3RK4Bkr
	8d4xgUCz0AMOUrq3pRRa66xeS24xvdMEgc6mSrfrj4aMUOk5xALpibS3GJaLE9JEKuufWRgOzYIg8
	5Dh6a0tyG8E+GRL0RfFSZ44CrXkNQDC6Vg+r+QyFZcG/fnUPAdiDKtbX57Gb380wXtDZNPQyHFKC2
	v53c2Yhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMoF-00CIx4-2P;
	Mon, 18 Dec 2023 23:14:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMoD-00CIw4-03
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 23:14:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4C9ED61166;
	Mon, 18 Dec 2023 23:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AD0C433C8;
	Mon, 18 Dec 2023 23:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941240;
	bh=PkE44o2NgGqDHfFoTTF9KtuZHlg/U+sp3T1OYaOAVj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPSvHoloM7KE7aGzwb/8908B+ExAtEUXVdavb8/uz2cw4AqRGCvNEh5vmseIbbV1y
	 XROSL6uca2GboCHCb3LK+hq2YtZeCxC6h/pKb6HY9TC8oe1lihqp6EmYMRE1C9FwOn
	 dMyvygWiSjmhudxiq71p96A4tj51wxKYykRPHCqeAXk94IgMotydzq+dzczoV3Fk1k
	 sHp9muqIk8Mun25lNq6T4Xq5IbfoaG5VA1ft8tDEOoobc8bQhOgrBN1yz0zZfpf19V
	 jzsVYb5kmkRp3rzniby8t+XGy9sCCHP1Wx9P3dS2ZH7IxGdCBaleMlyjw1CN8uOTIA
	 U7jBLaUK7vDsA==
Date: Mon, 18 Dec 2023 16:13:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Evan Burgess <evan.burgess@seagate.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Message-ID: <ZYDSNS1TSTmQNRNf@kbusch-mbp.dhcp.thefacebook.com>
References: <SN7PR20MB6609070761257AD91613E47B8090A@SN7PR20MB6609.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR20MB6609070761257AD91613E47B8090A@SN7PR20MB6609.namprd20.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_151401_094774_7B81A479 
X-CRM114-Status: GOOD (  14.73  )
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

On Mon, Dec 18, 2023 at 07:03:32PM +0000, Evan Burgess wrote:
> 
> To prevent enabling more than one passthrough subsystem per NVMe 
> controller, passthru.c maintains an xarray indexed by cntlid values.
> Passthrough for a given nvmet subsystem cannot be enabled by configfs
> if the subsystem's passthru_ctrl->cntlid value is already accounted
> for in the xarray. 
> 
> However, according to the NVMe spec (rev 2.0c, p.145), "The Controller
> ID (CNTLID) value returned in the Identify Controller data structure 
> may be used to uniquely identify a controller within an NVM subsystem,"
> meaning that cntlid values are not guaranteed to be globally unique 
> across multiple subsystems. Instead, the cntlid only uniquely 
> identifies multiple controllers _within_ a subsystem. 
> 
> As a result, multiple unique & valid NVMe targets can be blocked from 
> enabling passthrough at the same time if their controllers share cntlid
> values, a behavior allowed by the spec. Fix this by indexing the xarray 
> with passthru_ctrl->instance values, which are allocated per 
> controller by IDA and thus should be truly unique.
>  
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Evan Burgess <evan.burgess@seagate.com>

Thank you, applied to nvme-6.8.

