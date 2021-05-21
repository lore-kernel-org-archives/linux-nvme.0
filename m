Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382BC04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A116109F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A116109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8zG6xMYKTSaBamabvApSjLXVwRqj1fvmT/yVoA0ifU=; b=dQVvrqAN0dD2sq
	MevsKV/m0SS6fz5M342kai29YunJH9PcWASOz0w9v7xTPiwZA6eh/jYh3VDAywTLce7zU0XWTUkNN
	9wZcjaNNfKlMsMXIMR9aqWDUgJbx+mFmTz2J00v8IA9YDH4GeNdh+BxHPCFShmdGDTWuBPCjYQOG3
	FGzxlZN6LxfuqViEM+B/QMIThuNDw51L3cGHHgozjpqA2DuO6du0+4ED3tozk1KcBm+siswnJ7eZl
	T7xOD0QZnjD3s49BXNbgdgn+1xGm2KQ9A7JvAjK2duXsWOOfevy4pAq17mwqQm44CFE6MNWL3jPwL
	bLL4Dma2gb7gbnjUl+cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGWj-001jPw-3l; Mon, 24 May 2021 19:46:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8mq-000S7D-ML
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PKUzbY5iIGLiRwydllRSQJCscB+6IrSLbJrzulbqCPE=; b=ZOBdd7EEKTH3Q4ZRkd0xwwRTyZ
 hR11v0D2UkPqBnuFt+dlv11/K26QyDt1998JMttDZMYUJCUDVtjnZiV0tkJZCUMmvM+Ly84CqQD54
 8CZJp3wBTGybSsZ/t6dpEyx/ZD3Y3gHosViK/4z8oOsGF6holy3rtuMjpGarWbuzuQ0MmM4ABAXHi
 meobFF9+PVOgrY9DtvXEt0UMnBFWJ1SwLanMlvCTtKF0xWQ149PdRAkTt+tKGiJvYSUZqapJ74C4t
 bMbfje8FBDLRjbtGTvmzUj/Ske/BVou1NOoCUr76I6yGWyPJbWkx4eS6Aa9VbU1ygxBC32g3n2l2Y
 Cy10RHYw==;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8mo-00HIyi-9C
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:18:11 +0000
Received: by mail-pj1-f45.google.com with SMTP id kr9so3243249pjb.5
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 10:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PKUzbY5iIGLiRwydllRSQJCscB+6IrSLbJrzulbqCPE=;
 b=p8w3ZziHnRc+OCCYW+YLJlidVdwnaUVGvBPWPXxTdLAJEF1IlCKFlfMKvfcLEpQAVI
 mWKyvXVLoBStcuwEt5cr9+Ci1aOwBCa3FaIxOf9/vX8IytnTYQ/ocnMqnNYiwV3CpUbT
 kYMTFodSjURbvS4lXCNFirwBmfn+GPk5E3bdHp5VglpMexZ2C94ab5AZqGBkGdok4s1k
 ke5hWztvsosK13Rz/YdSBdxRLSBNFe53t0rWHT30TsWvmqiUFE7xbu0sgMBgpP9Z0Lcp
 a+fUQUU+2wokcMj2YCAmHh+QRR/mL/CRyXLDdmBBWAaw18Rcd4H2mef8kulSdiJEpXAk
 S45w==
X-Gm-Message-State: AOAM533J6G3B64vF6ciImCd8WmUeSDlX69z40lNHYr4nXtXO5sbYKGtT
 wVGh5E7moA6n4Z9CAvVTcyU=
X-Google-Smtp-Source: ABdhPJwK8NtIAa5B5/oxZS0IR7nB67qYtN97nOKjvFJRfkRjUCvWO1h3QwEBBuBpXaKTLAx6Ca3tYw==
X-Received: by 2002:a17:903:30c4:b029:f0:ad43:4ca with SMTP id
 s4-20020a17090330c4b02900f0ad4304camr12902892plc.70.1621617489433; 
 Fri, 21 May 2021 10:18:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id f5sm9178273pjp.37.2021.05.21.10.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:18:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 29A6B423A3; Fri, 21 May 2021 17:18:07 +0000 (UTC)
Date: Fri, 21 May 2021 17:18:07 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-xtensa@linux-xtensa.org, linux-m68k@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@tron.linbit.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [dm-devel] [PATCH 02/26] block: move the DISK_MAX_PARTS sanity
 check into __device_add_disk
Message-ID: <20210521171807.GA25090@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_101810_339723_E3E66C7E 
X-CRM114-Status: GOOD (  11.73  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

On Fri, May 21, 2021 at 07:50:52AM +0200, Christoph Hellwig wrote:
> Keep this together with the first place that actually looks at
> ->minors and prepare for not passing a minors argument to
> alloc_disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
