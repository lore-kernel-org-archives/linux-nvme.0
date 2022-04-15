Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ACCC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vKRwgfC4ED3wBU2n2i2ZES29ZkioKhUCaYEzFIzNAoM=; b=0JGH4JFj7eaEg9kODO11GLQNxR
	PZRecZGQucvmCBqncNTtL2xvzJW8TWzsat2yBZUULrzcB/oCESp2UrdQ5lZB1gpuMUmyU56rMbf15
	Hg02srqH9Q52Vn6NhsR1iOz8fCN1lS0Wz1Zx85P7OLrKXMvZnffjFEFdNzaL8mw+FNeju7DDrddIC
	rk21URdxVI/1c0IWGt4mlFaXzZOrMhhaMbNZeNRlF62kClCuqntuSQUpcLTEy7ZogbBQMbLhxOwe3
	YqcagyAB5FNjL0CRIFg7Dy9yDFfYLPr8UAdONCZqLZUiiOk+9zDtw8uxU4AzOtDFg2fMr7sc+I1/D
	eO2OTegA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfEEV-008bVo-2a; Fri, 15 Apr 2022 05:10:59 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfEC8-008aDI-Fv
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 05:08:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1649999312; x=1681535312;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Fza98p6Hk/Oo3R5YjAQC2Nws92s1JhenlM6js5zQuBI=;
 b=Cvvhk3TLTKGvMUy3DBLIZdIffJjvO9VH4okeWYRCq005ydYSGjxH2O+z
 zLmMEDxw1SvdXzsRy+BlrawevwXorIlIWxQfDtNy08bg57TBxYr2caRAw
 /osTVFXe+cDTVyzpFrfXI3ugEIhqVK5vsgEwiPKyVsuJOSNP6PVqWF26R
 TRkrk7IGCenR0FnEpVJ7DloNUluqb4QsSd5FCw/SPv0t3gIChvOFxt5hi
 yfVa+lqK0Fv/bddWABWNDE0o2lL75gB1I2jop+FOhIrV5zEmB/lWghCaw
 3VnGayaqVpFB7ft/+QA2yM/QHa5QV6SD58lloKYIzYzOBCzQzMNase3CD g==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; d="scan'208";a="309936200"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 13:08:28 +0800
IronPort-SDR: jXGLtOkIhq+yNG3H3BveP63R+aNt+c+GMVm/viOrvsR8NrSQjijZaDe2sqdlJa0/wyZsyb3YSd
 v9GG0w6brJ2yAVsGOp4wl9SEWYeJRvmx/bs0rbbRnTF47OZGkTxUlehmPcvH7nqdKZz46ifb7a
 rPHpV50JQZR81GsEZnXKPbwGqErAdcT7dlQxsayM89ONZ4FmD8PiVM91pOta7XbKP7tX2CWxeM
 YTn1u9KpAm/j1Khpc47eT+H7p5mKvptP9gmRFLEsK+yUgH7pFJX3jFQMyNJ0NLwyxWs2jJv1he
 wJNIX2eh0/ac1+6nbYoAigy0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Apr 2022 21:39:39 -0700
IronPort-SDR: zvROHd2wacVO6QeVAzFIf50dIpRmUn3DtAXTr56F0+J0YlLvdOgVfsw98gB21Qjc0BHpxIQtt9
 22r07Zn+Cl6KrntX7B4Vosw4vvP1RxAEHmOp2jnl4a209Pz/Q4/bBAqGEipJI+UD3RlE1yVCNG
 zQ7A0lKtlfCnDbXZeoVpKqK7QmBx7IF6h+tXwsD8+7/xLxbgko41iIBUhNsVGumf9BLkLZYelv
 nRTK8yIqhzD+ok/rIX8t9eX0GnL2SQhb94FvejSlca9/WVcIIG66hMwRe0ZbFXZCLoiKCeKKs5
 ucA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Apr 2022 22:08:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kfkqv32Lyz1SVny
 for <linux-nvme@lists.infradead.org>; Thu, 14 Apr 2022 22:08:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1649999306; x=1652591307; bh=Fza98p6Hk/Oo3R5YjAQC2Nws92s1JhenlM6
 js5zQuBI=; b=ImgmXK0ljefxmjcwwGCZe/P1ZAiYRfxiStEm0q2wFeKQMvkTL85
 MoEiv1WWngR6yiDdywhy6m6c7CHetStsP2KPL7aGmRBSEDoQ0BBkWf7uSl7GctxX
 seFLiVHTqharLpAbcplk3yzDBSQpNNHnyTWqCGnT6SDEQPGGz4njOldB2JpZjV0c
 Fn1jBi13ZsAeHMQyLgImvLHIeNwH3xSreGo+kohOYlio/FQU9mPmWWTRsJd3G6Vg
 s7uGQ1kCv0yoS1gOWClHM7ArPs0jj6m4kJVcJWYcgsITqalXpkzGP3XvQ+R3owbL
 r+qmM2ogk4tvzMNidepDhru5fT38QuGd/Yg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Zycu7z_2KfDW for <linux-nvme@lists.infradead.org>;
 Thu, 14 Apr 2022 22:08:26 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kfkqn6sCZz1Rvlx;
 Thu, 14 Apr 2022 22:08:21 -0700 (PDT)
Message-ID: <d7a39cfc-9b28-f0d6-bf62-4351c55daec2@opensource.wdc.com>
Date: Fri, 15 Apr 2022 14:08:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 27/27] direct-io: remove random prefetches
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-28-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220415045258.199825-28-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_220832_592046_B32C8E3C 
X-CRM114-Status: GOOD (  11.87  )
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

On 4/15/22 13:52, Christoph Hellwig wrote:
> Randomly poking into block device internals for manual prefetches isn't
> exactly a very maintainable thing to do.  And none of the performance
> criticil direct I/O implementations still use this library function

s/criticil/critical

> anyway, so just drop it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

