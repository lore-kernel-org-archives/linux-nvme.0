Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7797BC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aKU2RucgHG5r2K+USs7oGpLoRusbziFS1BeFTZfjKM=; b=Ij3VU47YMsWI6w4WAa9NNfZhm2
	DtvMknOPNLNwlRkjafp1qAQxU38mPeeT5PIapnL49vJngFfleFGXfExQL1i+0/YSAgHsPFUHVKgBA
	CYlGJzPeseY3II7/k5F6oj8B3EvxjawgpegdeE/f4r2yylGGh4HdZuyOMGY9FaD7UIrpB+SlUc3Z9
	xLJBo4IjE7UQhbi6VkL+afCaZc0EiJ/tDaER9YjoHJC6rrAO1zdKi7eHzlc+TIICqEk3+np0X7Flj
	y4vFQ3OdplBygLd5Ue7lmaPDoqf74TuAJO+bqvn4LR7fqg/X3afaIpKc8NNPt+DTP656Dkp1Yyd84
	9BEHiL8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o46pl-00CASq-Ug; Wed, 22 Jun 2022 20:20:17 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o46pj-00CARf-8Q
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 20:20:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B9138B820EF;
	Wed, 22 Jun 2022 20:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033E8C34114;
	Wed, 22 Jun 2022 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655929209;
	bh=OIZIuBNv2Er+CiC4wCVSqM6UE6BgaSSl/xl3Ms4IKbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ezx+5R9Qaz+izl0vEnVmZSYNg7ozR0jus4LRoGRfpFw2cIqJ/iVtrnWd+q+3u95+i
	 ArxnjkjvsUrfkyMEl8PkgOoM9fAjG2cLsGBMVVKfVpryuXUV1v3RfOBCX9lX9G2CTD
	 6hBkj3k5QHcMOEWjgAYkUNZkWGnX8if7MnxdU50nyYmwMSmQrfoSHcu8Iur+RWkXpJ
	 eMSGNQCE1iYIhJAC7TyGK/m4oHGBhxy+YWACS6cOdCvMjM0gY4dgOgL0+Brzb3sc+3
	 Kh8JKBpE5onSym4Jv3BouSlrasdjH00b1PKxj5mPJy71ldAXs3V3ONicTm7OtKXmtv
	 /ud8LIZBar5ow==
Date: Wed, 22 Jun 2022 14:20:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, joshi.k@samsung.com,
	gost.dev@samsung.com, k.jensen@samsung.com
Subject: Re: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <YrN5dWNZkUnFpjSH@kbusch-mbp.dhcp.thefacebook.com>
References: <20220622135556.2185991-1-j.granados@samsung.com>
 <CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
 <20220622135556.2185991-3-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622135556.2185991-3-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_132015_489835_C8E7A378 
X-CRM114-Status: GOOD (  10.73  )
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

On Wed, Jun 22, 2022 at 03:55:56PM +0200, Joel Granados wrote:
>  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns_ids ids = { };
> -	struct nvme_id_ns_cs_indep *id;
> +	struct nvme_id_ns_cs_indep *id_indep;
>  	struct nvme_ns *ns;
> -	bool ready = true;
>  
>  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
>  		return;
>  
> +	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
> +		return;
> +

There's no check that the command-set-independent namespace identification is
supported, so an error should be expected for many controllers instead of
abandoning the namespace.

