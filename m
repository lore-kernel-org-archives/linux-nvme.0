Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B04C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DfhB8jvaZ+NX5O/W6U8PGiRnsQleUaLd7heHBLzUhM=; b=GyFTXAkpziIetDR35R4cii3xrJ
	ez/SOB0Z+BMPbmqFovwCLpUSFo6LDaS56M7xMtxSGFcRZI7ZDb7CLjf4Ky8t2u9kSY4/6BMVOvZvk
	jLtvQ30rbRMxx1i6vm2LPJ8bailb2tVgxUx7NpuSoT3O9h6+uvGYVSGvgeoDE9Vzj15d8F9xy7624
	WnvmArARIgXboOYxrA6q/GCKiQwIjsBwcdXfNlrwfgu8tccVrskNzZ7JscSi3rd80+YleNmySxS9g
	CrhABNEru4KRf34T4prwsTsmYneoy9nnyyY9XeJJfJAYKITuh6omqUjFq5gmr8I9sQz+hPsT3FPYm
	JLVRKWkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogkAr-008Ubx-HT; Fri, 07 Oct 2022 10:01:45 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogkAl-008UZu-HJ
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 10:01:40 +0000
Received: by mail-lj1-x231.google.com with SMTP id d24so904370ljl.9
        for <linux-nvme@lists.infradead.org>; Fri, 07 Oct 2022 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DfhB8jvaZ+NX5O/W6U8PGiRnsQleUaLd7heHBLzUhM=;
        b=B2Hr7KIYLqdlgqBWIF1ylrBnKIo+/FHDGnjhpVzD/cDbwWuGodJu4KPh9dgmn8SQje
         cSWbK8apPRkKJngwKUOj57nvX0niu7SaBe2+S2UkTZgv7aHiIUVLWRBWf1Xao4CZMUJ1
         l90GwXLAT71HdT3sD+Q0ecH2xGGMH6O5/0GCHqLU4DiGh+FTAr95k6pbgFjgYdgVq1VU
         aENrX2Qgojj+t4h1WTdqqempffi8neDZvZiYehbzTJBWiriSSLOavgwwdIIHwYwGqIqC
         B5mwyxVzT6BT9WE+RcHxURFL3+dGO1Hlm+vhislFn8LaqdQumNJO+W9fjJfW0X/ZTu36
         m05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DfhB8jvaZ+NX5O/W6U8PGiRnsQleUaLd7heHBLzUhM=;
        b=L7kkvvMFp0ZjyepJ/z43EsEWkV6UdUHvuwvnXSQjm5+xNoPxMPm+0xjwpxhUmLDNcT
         1Xu8OWAXLQ1r8IjPTY+2bNVfFSfQRkBCrc7Wi/c5pnm9lVo8c753ZKg6hLaVHt0oyccd
         BYPww8o/xJ8rKuEj9CZX20bfot75fbesKE/2GO/HSlckqtcZFLmAr3V2eCTKxHusdzbE
         9is3C58MRd1VLdWpfl47oMony36K8X65KLnHhEAOfzJpKatD432wXtzx1iCduOB8J5Qh
         K9cteCNbCs5wIMGDel92uNqQtFGLyUlCBqT0CaTbM5Q2G1axDambGbvPW3FDZ+2TpRkO
         GiaQ==
X-Gm-Message-State: ACrzQf1tzfR/FWhPEhKRz1AbCAmgxiQOEzWh8BSkpTlvPKpmYd+W+DVW
	OtjbeOY1JaGujGY42y+RK3OsKTPn0XnKRg==
X-Google-Smtp-Source: AMsMyM5EtI1u2e5hy90i1u5NHtzhbsVaZ4Dvovfk7AKn3YGsZDBUpI9TUw2FGcfwqq/BxjYyUpI+FQ==
X-Received: by 2002:a2e:7804:0:b0:26c:463c:493c with SMTP id t4-20020a2e7804000000b0026c463c493cmr1417457ljc.521.1665136896974;
        Fri, 07 Oct 2022 03:01:36 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p18-20020a19f012000000b00499bf7605afsm235115lfc.143.2022.10.07.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:01:36 -0700 (PDT)
Date: Fri, 7 Oct 2022 13:01:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <20221007100134.faaekmuqyd5vy34m@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
 <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
 <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
 <YzxueNRODpry8L0/@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxueNRODpry8L0/@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_030139_616976_0D71E0BD 
X-CRM114-Status: GOOD (  39.01  )
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

On Tue, Oct 04, 2022 at 11:33:44AM -0600, Keith Busch wrote:
> On Tue, Oct 04, 2022 at 05:50:49PM +0300, Serge Semin wrote:
> > > 
> > > This particular condition for hwmon is not something that prevents us from
> > > making forward progress.
> > 
> > If you consider the hwmon functionality as optional (AFAIU you are),
> > then just ignore the return value no matter the reason. 
> 
> That is not an option. This function does IO, and the controller may not be
> usable on the other side of that, which means initialization must abort. We
> can't just ignore errors; we just don't need to report errors that don't
> prevent forward progress.
> 
> > If the problem
> > caused the hwmon initialization process to fail turns to be critical
> > it will be raised in some other place which is required for the NVME
> > driver to work properly. Otherwise the hwmon module initialization may
> > still cause the probe procedure to halt, which makes it not optional.
> > That's what I meant when was saying about "the function and its
> > caller semantics not implying that".
> > 
> > >  
> > > > > The
> > > > > driver can participate in memory reclaim, so failing on a low memory condition
> > > > > can make matters worse.
> > > > 
> > > > Yes it can, so can many other places in the driver utilizing kmalloc
> > > > with just GFP_KERNEL flag passed including on the same path as the
> > > > nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> > > > either finished or executed in background anyway in all cases. 
> > > 
> > > This path is in the first initialization before we've set up a namespace that
> > > can be used as a reclaim destination.
> > > 
> > > > Don't
> > > > really see why memory allocation failure is less worse in this case
> > > > than in many others in the same driver especially seeing as I said
> > > 
> > > The other initialization kmalloc's are required to make forward progress toward
> > > setting up a namespace. This one is not required.
> > 
> > Anyway what you say seems still contradicting. First you said that the
> > hwmon functionality was optional, but the only error being ignored was
> > the no-memory one which was very rare and turned to be not ignored in
> > the most of the other places.
> 
> > Second you got to accept the second
> > patch of the series, which introduced a one more kmalloc followed
> > right after the first one in the same function nvme_hwmon_init(). 
> 

> My comments on this patch were intended to be applied to all similiarly added
> uses.

How could I've possibly got that from your "The rest looks good,
though." and nacking only this patch with the message "The hwmon is
not necessary for the rest of the driver..." ?

Anyway due to all these uncertainties it's better to have a second
opinion on the patches before re-spining the series.

@Christoph, since you've already started reviewing the pathchset could
you have a look at the patches #1 and #2 of the series? Please note
the @Keith' comments regarding the memory allocation failure handling
in there.

-Sergey

