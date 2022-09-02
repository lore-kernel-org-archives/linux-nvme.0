Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A40ECAAD2
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJXkmWS8fs1OJFQDlt9uEZ42yIaPYlfbQFXo4qcCOho=; b=C+SpkDnaeO8witR6edHOum/VxE
	uEx+lx/NPeBxbGdF8gByHDcCHrmmlxDXq6creIuxfY8338gE2BCcY/C4Rg9P7XIqvkxMx02n4gZJz
	W0YrVZn/TGFRwhdw+WBo8DL/dz2znnYmKSgOmLfqYipYJWhUL69jQgg3EAynfwyqZLcjJRqMJlmRS
	/Iihaihd+k7AvfVGmFbVKgOp8gkfhbSh4FOdLabOSc/LHVPkhvMd4JU+t/sssCWOST49i37WiMICS
	tmP0+VPmMI6y0Jri5uJE8BcdkKayt2r8tL/r9DJc67cH0Aluy+NXzBVSlGXo9hdeiTM+uSCfr0gJy
	8wMRxQDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuOn-00G7BD-E8; Fri, 02 Sep 2022 00:19:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuOk-00G79k-Le
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 00:19:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662077941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJXkmWS8fs1OJFQDlt9uEZ42yIaPYlfbQFXo4qcCOho=;
	b=dAd1kWETJDKJlMAuIX+7ZHQG6oW6xHyuPWEFXcM1SA7JtRcxz3+HbH6FHnlnzbNDY9QQq+
	5UE0NCd7CV36tE/qmEPFjQFXeMNIKpgG9QdnY/h6bnxFpvgLoVWcb6yN9ojAcUT2SNTnvk
	5v/UFnFkr1mgbTrvZZJuLZwdepX87SU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-JAVG_g42OwSr8JnRikvs9g-1; Thu, 01 Sep 2022 20:16:28 -0400
X-MC-Unique: JAVG_g42OwSr8JnRikvs9g-1
Received: by mail-qt1-f198.google.com with SMTP id ci6-20020a05622a260600b0034370b6f5d6so397603qtb.14
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 17:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BJXkmWS8fs1OJFQDlt9uEZ42yIaPYlfbQFXo4qcCOho=;
        b=AAOyKz3UTGMrWj4OczynKVPIeBdpx1y5xJ4SQPb0n07IsNIMiIVJSqIFB8nntpFf1I
         oCYVPFFs71vQc0JauAUTx8aPmDhJd7jpuE3o2MHu1Fmc9gXWfg2iVHq0oztHxndoBK4h
         CcQS+ftJW1/G2sqdJIOecKsfBPCyPxFrE3i/Rdwb0qDcIMmoiLkgEBt3hpuslEnycKCW
         1PnKHR1NdENuqs1q8I0NGX3dUpJNSBEuJBnxSX8SH6FKsY5RbxaV/MLAVOlrm6/XGX0a
         lO4aiDOskfZK46kCn/tRcAqg/OQQvrCQsnVJkt85HFQtjxglXhLOeGGvSy0kowF+dacL
         nq2Q==
X-Gm-Message-State: ACgBeo2bcnWrQEym+IRFTWu4c0ldiLXBgwkS2g8m4mj3WqooNghldwVi
	GEKn0udHmjWXVKwmv+9TnHJwHyjw25vhHyoOkycfMRY9G3InfXoKTWp2Fl7hV1VX4NFZUnS+IiY
	pLxumfmRPN3jYSeUt5YkDH0FFrg==
X-Received: by 2002:ac8:5a09:0:b0:344:69c7:d405 with SMTP id n9-20020ac85a09000000b0034469c7d405mr26543407qta.158.1662077787626;
        Thu, 01 Sep 2022 17:16:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xfpUx4j6Jfald4N7jmwOFuH/AS+dP1NbvYV//P7CHrd0ECl3dDoJBwQdLGwkp4TF0/VDNjg==
X-Received: by 2002:ac8:5a09:0:b0:344:69c7:d405 with SMTP id n9-20020ac85a09000000b0034469c7d405mr26543381qta.158.1662077787384;
        Thu, 01 Sep 2022 17:16:27 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b006b5cc25535fsm297002qko.99.2022.09.01.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:16:26 -0700 (PDT)
Date: Thu, 1 Sep 2022 20:16:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
	pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v12 08/13] dm-zoned: ensure only power of 2 zone sizes
 are allowed
Message-ID: <YxFLWcY/xSqyqORO@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf@eucas1p1.samsung.com>
 <20220823121859.163903-9-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220823121859.163903-9-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_171902_803940_E128602F 
X-CRM114-Status: GOOD (  10.52  )
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

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> support for zoned devices with non-po2 zone size is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


