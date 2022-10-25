Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98BFC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nCSyuyQGpNlpd6dhjpOf9Qc4lZVxImyObiEpJP1xQh8=; b=OSkc5z5txVElPIVsGTK7hCE0U8
	Fm/t/aU8n1y/5ytsRpn48iBAZ/mbOXKJNM1Q6ih6D/oyUd2xdnj0spVNjwtH+YN97/sJXRn6uw+mY
	BvEufVDR2C2fkVZQ/qi1+WcJg9+4VP01B/+7RASwhDVrWvX8G4SRy58po/a0uUod20uYPpIh3X01l
	Q6uZR97z2bM33mE4Q5pSQOh57Vz+x7lrSxVlWMigNfXwu4m94g22WS/2C1sh7eyG7mNus/5ElTXdX
	u5Yecw/1kuFDbO5LQ2SJOxZEqgOyL8KxmEVpyAaPQnjg8J2X3oUeqHem5i9bx22j4qqTxW+eG2CgN
	xP9CxbGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onGHB-004bHb-Vm; Tue, 25 Oct 2022 09:31:14 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onGGV-004avM-BN
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 09:30:33 +0000
Received: by mail-ej1-x62a.google.com with SMTP id n12so5581465eja.11
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCSyuyQGpNlpd6dhjpOf9Qc4lZVxImyObiEpJP1xQh8=;
        b=TwXVFt1/Pqv27w/D+1kMCKoXoabMRQO3isas+A0kXa7tJPb5eSctRVpxnD6mIKJ5Lg
         rIiT5zttRRLzyLSytPpELrTt9i32DE5wCsCN1QySp4Jrq8RpEunimrqfwbxX4djqw4sT
         fc/nfmk8md450r262nPGyJ1AQL5iT50wFMHWOaiR/kEfFCuu8vKxUxStCIz0GEUUyxqN
         h9oqYGBVrkj+06T9/wg2ZGv6ibRhd9Y3UT15FBHXzEEDtcbQgA80754Eoye65K3mZEyY
         bCjwdbP2CSk1hzhmOz1m73HHV9+aRmr3woxzvBplooS1t5QXgu9tNuiu/0FoHDIphwe+
         9w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCSyuyQGpNlpd6dhjpOf9Qc4lZVxImyObiEpJP1xQh8=;
        b=NWznKUzPF9lT2lutlLlRUDhK0XHHr1rysti/ObX0wtxdhHTanYOgFiU5bkqEhjop12
         OYlYTmgJYRS0FFjPFD3iERABFS7FRKYw1pGCP3ZWcixewbveY1M1OSgZzp+Ga8llp3BQ
         XJwBP8s3HkRrWTdvVY9aAThFMp38kK2WxeiyuUWYASywgAziJ2QFK2cbrls7bER25CIy
         sDxCbtOSSsLyULYDaBPV7DmmAW8y/V0q5uAgTsaNx+CPESirPYrqDmmLOtGK8B3Zk77D
         268YAg88L4WPWKmemIqQwmUqW2wAi/0ZABKueBc4tVKoRr1SVHrVYanE6Qw9xyMTKIVY
         8D1Q==
X-Gm-Message-State: ACrzQf3T0D74QO7bmZHOLZHEqCO+uY/G1Y8JmIqcq+bPO42exx5wCU+z
	xtJvciB1Tnm8J+9z0DKvfD8=
X-Google-Smtp-Source: AMsMyM4CXGFAEp1wVI6ujd95isc8QgYUQQBOGKhUFJZxr1hHQK+nnUiXH0R6Z9XX2ofECC5OY/TUxw==
X-Received: by 2002:a17:907:7245:b0:78d:ec9c:e743 with SMTP id ds5-20020a170907724500b0078dec9ce743mr32347841ejc.466.1666690228578;
        Tue, 25 Oct 2022 02:30:28 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b00788c622fa2csm1076361ejc.135.2022.10.25.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:30:28 -0700 (PDT)
Date: Tue, 25 Oct 2022 11:30:16 +0200
From: Nam Cao <namcaov@gmail.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Message-ID: <20221025092737.GA254308@nam-dell>
References: <20221022174635.15643-1-namcaov@gmail.com>
 <810f1de0-769c-ce67-4ec6-007ce25acfe0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <810f1de0-769c-ce67-4ec6-007ce25acfe0@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_023031_461466_E1B69CEC 
X-CRM114-Status: GOOD (  18.84  )
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

On Tue, Oct 25, 2022 at 12:58:41AM +0000, Chaitanya Kulkarni wrote:
> On 10/22/22 10:46, Nam Cao wrote:
> > In nvme_tcp_ddgst_update(), sg_init_marker() is called with an
> > uninitialized scatterlist. This is probably fine, but gcc complains:
> > 
> >    CC [M]  drivers/nvme/host/tcp.o
> > In file included from ./include/linux/dma-mapping.h:10,
> >                   from ./include/linux/skbuff.h:31,
> >                   from ./include/net/net_namespace.h:43,
> >                   from ./include/linux/netdevice.h:38,
> >                   from ./include/net/sock.h:46,
> >                   from drivers/nvme/host/tcp.c:12:
> > In function ‘sg_mark_end’,
> >      inlined from ‘sg_init_marker’ at ./include/linux/scatterlist.h:356:2,
> >      inlined from ‘nvme_tcp_ddgst_update’ at drivers/nvme/host/tcp.c:390:2:
> > ./include/linux/scatterlist.h:234:11: error: ‘sg.page_link’ is used uninitialized [-Werror=uninitialized]
> >    234 |         sg->page_link |= SG_END;
> >        |         ~~^~~~~~~~~~~
> > drivers/nvme/host/tcp.c: In function ‘nvme_tcp_ddgst_update’:
> > drivers/nvme/host/tcp.c:388:28: note: ‘sg’ declared here
> >    388 |         struct scatterlist sg;
> >        |                            ^~
> > cc1: all warnings being treated as errors
> > 
> > Use sg_init_table() instead, which basically memset the scatterlist to
> > zero first before calling sg_init_marker().
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> 
> Looks good to me, can you please share what version if gcc you are
> using ? my test setup did not catch this error and I'd like to update
> with the one that can catch these errors.

It was just gcc12. But strange enough I cannot trigger this error again.
I was doing randconfig test build. Probably only a specific combination
of configs that can allow gcc to detect this...

And sorry but I was just start doing randconfig test and didn't think
about saving that .config file.

Best regards,
Nam


