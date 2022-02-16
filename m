Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059D8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IpbsKRx5MK7pTS8h4JIdmUw7Nev/8eSNSW1Ca4FEU/s=; b=ivHlWQx4bf2o3hbFqShtJEtSeM
	jAS5U4Qcd4OG5lgMxIHYSBFogbSP38I62ThLL1R4uvJengP1cp0yeD6fG67nbodR1WezQM+Qmk995
	QbzIAWR8X1WAkvcHKIkHy5fFtAdgKWuCRsoojupLGtZwLGZdFHJKQMYAPLT2RpbRj8nYw6usPkvpm
	StJkSGHgtjou0G5jY5d2ZxUMOEsyUuTs7Dzkwq3zXqvgNCwB4O/qINR+MM+TJXrjpN8msxd81t3or
	ibD6z73r1YESy4s/WnRCE9oVsxGI/RMIh/y+CcVP58yuv6KKY2MDuZDe84DON03qlHMb67tL3x7b+
	a6P8tiCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKJjZ-006znt-4O; Wed, 16 Feb 2022 12:48:37 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKJjW-006zn9-7G
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 12:48:35 +0000
Received: by mail-pl1-x632.google.com with SMTP id i10so1943429plr.2
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 04:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IpbsKRx5MK7pTS8h4JIdmUw7Nev/8eSNSW1Ca4FEU/s=;
 b=XdXWxbzNNlh+ZXoMn2niMWNs5v4Bv6SjEjN7Yke+p7fAXlDPbDpvdFjAW9tbTdgbmn
 fBY/jt6hfKuUjiObcO2co2djL8/MGxPYFsleAu62Xo+6QibGrGWAgP8rX46rCstiVM9t
 HV0V+jiIAKfkLH2TKOFFN3cRsGLCEmxNDpsbM/6ANxZVTamNfI95FmlC2bKtLa349ZzI
 H3M/o5bWdnIkr9hptFFVgStbI1J7RUwEIIPjjbhU0wVt9M5e/A3qgxnulc2CAbJtsldC
 4gKgcppBT+Bgru3uafKwd13vKCkl2ONwr40b6s5MfDyg2LrP9xEhigUDAJR9LtSFzkiK
 LhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IpbsKRx5MK7pTS8h4JIdmUw7Nev/8eSNSW1Ca4FEU/s=;
 b=Y2dFdFZUCeGobV836JmVkFAo1bGbCHudEazH/4A/S4Afh7DEN/1DDxErs1W+l8iTFE
 1x4MO0GRbe06MWfn+g/RhZ+szBZhMJCCoQZQ1msaH4VCFC3NKwUBbHZCLK4V4V0mD8CP
 kDWP2faJH8VWLxuThdnWy7iMjwukgg5+hJbyLOQwnSIkQbg1iwkTfsF2J6jmTjBq+8Oy
 JOb2uPnNRVmHs9olTCFt8OrwhZ2SLbypAGLRYaHyNj3VV8TYoB/eQScGqw8cKOOLpaQ+
 VOKCf4b2zeV1X36EREAES/BO3JMh1X0gxqNsEcVkGiaBfcNHS6ST/dzAhYeQeG+o7TvU
 3KYA==
X-Gm-Message-State: AOAM533DrXKEf3CMJVj+c1dMk+JbqPosi/nkOuoDrRNX3/0e6qO/wGFF
 PhsGKr3uXTo4+1Ej0Tu5w1dWnTcryVsbVWbPHP4=
X-Google-Smtp-Source: ABdhPJwkV37z4zismJAtC4QAUyP7OBovZkU6ybaWHbCdTBcRabidLx8FjFo/wTWraooANT5abAFZmZmWhhu5iYL5uLo=
X-Received: by 2002:a17:90b:3806:b0:1b8:e628:d88 with SMTP id
 mq6-20020a17090b380600b001b8e6280d88mr1584957pjb.32.1645015712644; Wed, 16
 Feb 2022 04:48:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
 <20220216061305.45360-1-joshi.k@samsung.com> <20220216081148.GA10851@lst.de>
In-Reply-To: <20220216081148.GA10851@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 16 Feb 2022 18:18:06 +0530
Message-ID: <CA+1E3r+3ra2sr3hHx4b2QEq-tsQ6sfLp+hVvPz0a+Q_8G84QKg@mail.gmail.com>
Subject: Re: [PATCH] nvme-multipath: fix multipath path scan
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, dwagner@suse.de,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, Adam Manzanares <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_044834_287141_A0C2B2B3 
X-CRM114-Status: GOOD (  11.28  )
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

On Wed, Feb 16, 2022 at 1:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 16, 2022 at 11:43:05AM +0530, Kanchan Joshi wrote:
> > commit e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> > introduced NVME_NS_READY flag. nvme_path_is_disabled() declares path/ns
> > to be disabled if this flag is not found to be set.
> > This causes side-effect on namespace for which block-interface is not
> > fully up.
>
> Hmm. This means for non-bdev namespaces we error out somewhere in
> nvme_update_ns_info.  Where do we fail here, nvme_configure_metadata?

In nvme_update_zone_info, but nvme_configure_metadata is also possible.
Moved setting the flag before both these.


-- 
Kanchan

