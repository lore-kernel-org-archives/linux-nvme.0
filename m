Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF83C43219
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y66Jv7GoNIElEMB7fmCohOYeeRgoIld8eqY4AMIdlx4=; b=b48sawcnBpo0XQkdDcHSGnIEi7
	jUA8VZPm+hNhj+pp6YKGmL9PKQWSqatX6/Uamd7Z2CX14aCyKJ/BRAJo176LbveffHSHFrFjv949b
	bvCYTfFT0KLsSWGMYs5vQEUfU12M101eFmdrn4dPUXsAHMVPdbWXWgWBjpy9HeamuazsffED4AvIs
	6S9UICJ+BA+Ous/9tLzmOagCQAGXrMZ/tAxEGIDut3DQlbllHnqW13jv61u0SaZACP/mtHUe79IeU
	1bOU7gpsBeTA+J/RYyOTvLwkSYR9h01lL95hGSkVjKnLX/w4uZaU5kgtsRTm/XIwy7MMR0Ia8oI01
	EFFdix3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRdVz-005Uii-9g; Tue, 08 Mar 2022 17:20:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRdKb-005QZV-1N
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 17:09:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id D3069CE1779;
 Tue,  8 Mar 2022 17:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AACC340EB;
 Tue,  8 Mar 2022 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646759341;
 bh=QEoTqlQMyV5a1Evgn26+23k5reWWaIWsdBlmmLO0qcM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cnzRKaDf0SQyj0s0PyVUJGhE0/lzCpZORFfllupHtqBvbOftgphNMzZ48rL930vz0
 SXQRkGutK2xT/kQvQt6bPq/sElirtmDJX6qiuEukHkccDyCmfw2cQCxy2p+VksgVLM
 CkixIiC97BWzeI+KZ3nadrS2YXElVlKkAUyYn01V0KRDqdxjwx36ATSxcNSAOIN6sQ
 5CB8G2vvJqZ16U97gG2LBZ40055RPM62a/Gd97RjLYZT4bq/N2Avfn81JIh0sDSyJS
 2Z+zRJq3eZ2qAejZE42D7CVwlXRvgPSbe10EdTKGbRkpU9coP2L2nruqpTTRufCPyn
 1bjxymrLGbW7w==
Date: Tue, 8 Mar 2022 09:08:57 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 13/17] nvme: allow user passthrough commands to poll
Message-ID: <20220308170857.GA3501708@dhcp-10-100-145-180.wdc.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152720epcas5p19653942458e160714444942ddb8b8579@epcas5p1.samsung.com>
 <20220308152105.309618-14-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-14-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_090905_284265_D2BE9E18 
X-CRM114-Status: GOOD (  10.67  )
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

On Tue, Mar 08, 2022 at 08:51:01PM +0530, Kanchan Joshi wrote:
>  	if (copy_from_user(&io, uio, sizeof(io)))
>  		return -EFAULT;
> -	if (io.flags)
> -		return -EINVAL;
> +	if (io.flags & NVME_HIPRI)
> +		rq_flags |= REQ_POLLED;

I'm pretty sure we can repurpose this previously reserved field for this
kind of special handling without an issue now, but we should continue
returning EINVAL if any unknown flags are set. I have no idea what, if
any, new flags may be defined later, so we shouldn't let a future
application think an older driver honored something we are not handling.

