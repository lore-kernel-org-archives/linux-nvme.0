Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A5AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Jul 2022 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5E1STY2I+/7mXkcX8L02pPOuZ21yDio+q3U7WSM6ic=; b=FqyiAxLpInAeVBsXe6AETB+7cV
	jaulKU/ZLODJkCjmQyrLKF4hCvwW2IUeQ4Z05HwBdsmLWn1sNteXGVkhu5Qj4oGDt2nz/t3r7OMZ0
	aDledLu/QkNm7ZzPRvlzQWKDOEysCCTbqJog3GJNQimTUpVtQ6h9APgTT1K6hbuf9Tfi7vm8i8IFM
	GS31BxyYgWrySvhEcyX6MJvZgFOZqJqb5ru+LAYdrSdN10EV5lWyYU088q1gv5VwQjtF6f22sePcQ
	72DgbRzvXJrY4aj8E49amdczhkP/Zb/vPVEaEDbTqTAMKAwv54diu0d3kwH+oeO/6HHKEnkzj9sQ4
	izK1OcAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oD799-007jPl-A6; Sun, 17 Jul 2022 16:29:31 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oD793-007jPH-G9
	for linux-nvme@lists.infradead.org; Sun, 17 Jul 2022 16:29:26 +0000
Received: by mail-pg1-x534.google.com with SMTP id e132so8660404pgc.5
        for <linux-nvme@lists.infradead.org>; Sun, 17 Jul 2022 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t5E1STY2I+/7mXkcX8L02pPOuZ21yDio+q3U7WSM6ic=;
        b=Q3Ur3IHdBrASeOGzdZdUkj1LfhyscT1DYiTlIiabg7lUNUNbHfxhWUns+JHNIE++gL
         fyPn+BdqaQA6d+wTaI+gubXqfbP7G+kXkeJqXHjxoweE4N+JX8BmRRnWaynQ30YHb/gH
         FBkN3zNFow+he1/vq493ERS7qy1uObqli/ILEhTVOuaNlkBgkA3/lO6kDlegzN7NwnPU
         6p5beqB/MXIwDpRUrVFxzO5zWLK6nBdMd4ArxBioTKqtIcYkzBhOP/CwPh7eKMxWLM4b
         VduxgtWSJOdnQBE16jQ7RRcLZbgxfrPxhTT70F2ul/8XZTqi80JGQUX3oRMEg/TEU5na
         8a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t5E1STY2I+/7mXkcX8L02pPOuZ21yDio+q3U7WSM6ic=;
        b=mLrxWwef3x8E0rOi11Lyjjj9lIlIBK9+S2fthiW4mHVJ0M6R9L1CcEKRulB02zA6iu
         zqkatCXarFXuUoS55tpEwNRVwJuFKwgjRMv9JsTylhWT6OwnA2HvjMsGaHu29UF3rtqg
         6ciyfjclEd1Td3hv5khP/FmCAVzngE1j9rB68MrC5EUHOPWGaZSrdrs9DVN8isow2p/l
         vvc+zX+XScXZR1nosZWaAY6fgmHKsU1WKYBppRjceAqZZ6OoXxfw0CHTidgBu42aRpY4
         DbZl4fYFH8yY5P/qaJ80mgUmRGs86iYBUzGLkMRsDlQ1HFMIGAJsMEGSvLsjUfve27oO
         01NA==
X-Gm-Message-State: AJIora8XelM+4NO6a2+/Pn2dmuiq0kDONwWt56ntMFxxb0xkIeK7ES1h
	nll/N+1C8jAhmWE1dRx6QZ8=
X-Google-Smtp-Source: AGRyM1tcQtvtBVYaraqqJ05GcbDqUMYaur+6aaqtFMS59YgVz34HzWma9Px11tgXm88kB92k4QUb4w==
X-Received: by 2002:a63:4722:0:b0:40d:289e:8637 with SMTP id u34-20020a634722000000b0040d289e8637mr21012337pga.362.1658075363374;
        Sun, 17 Jul 2022 09:29:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5-20020a621e05000000b0051b32c2a5a7sm7451740pfe.138.2022.07.17.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 09:29:21 -0700 (PDT)
Date: Sun, 17 Jul 2022 09:29:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 10/11] nvmet-auth: Diffie-Hellman key exchange support
Message-ID: <20220717162920.GA710870@roeck-us.net>
References: <20220627095207.105201-1-hare@suse.de>
 <20220627095207.105201-11-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627095207.105201-11-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220717_092925_555282_E8E22933 
X-CRM114-Status: GOOD (  14.82  )
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

On Mon, Jun 27, 2022 at 11:52:06AM +0200, Hannes Reinecke wrote:
> Implement Diffie-Hellman key exchange using FFDHE groups for NVMe
> In-Band Authentication.
> This patch adds a new host configfs attribute 'dhchap_dhgroup' to
> select the FFDHE group to use.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
[ ... ]

> +
> +int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
> +				u8 *buf, int buf_size)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	int ret = 0;
> +
> +	if (!ctrl->dh_key) {
> +		pr_warn("ctrl %d no DH public key!\n", ctrl->cntlid);
> +		return -ENOKEY;
> +	}
> +	if (buf_size != ctrl->dh_keysize) {
> +		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
> +			ctrl->cntlid, ctrl->dh_keysize, buf_size);

This results in :

drivers/nvme/target/auth.c: In function 'nvmet_auth_ctrl_exponential':
include/linux/kern_levels.h:5:25: error:
	format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t'

on 32-bit builds.

Guenter

