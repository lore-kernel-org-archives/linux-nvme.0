Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015F9C77B73
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bW019hZw2m79ekhK1VWnhrvbjoWfN5CPvgTC/Quxs28=; b=gLzv07UFrFHwYa91+P8TDXG8VO
	7AN1oUJE4NEMTWNZJgyMwgOA95x3+FaINNUL6WlPSLoxq2LYOxrYcb3VjCl2VphDiMG41WWGt183C
	fEnGHTOqLk1u6nZsgxTIocWVDy2BZGk2p8t6mj4Z7AHfRjNAJnC+Dma5OA+Hx0rdlbFf0JW0COSQ6
	M1aOjp/XRhAIij5xXuWVtMTIzxFsKxWHynf+BFE084dp3dLif1AQ3oyAczKtw5zmWHCS05S8wBBjQ
	wCWvl/MJs/46Cbb6FyAWMlwTlehT1gdTNIYGBRQq1Ny/Ajfwp3cUQyIONSrvd+/u3dI9b8phFdTBr
	6r4lVXNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psC69-007uJa-0P;
	Fri, 28 Apr 2023 00:36:29 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psC66-007uIu-34
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 00:36:28 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50674656309so14118758a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682642184; x=1685234184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bW019hZw2m79ekhK1VWnhrvbjoWfN5CPvgTC/Quxs28=;
        b=nHPNhWm3zuJ4uL+EV/oXR/SjLUuEL/AzIVB6kuDloezKq+vwzwqNouiVUMBG6iwfKh
         woel1UImsgXPhHmrkzDcl4vbvflLw8kEnrEugrYUqId5Yr1c9Xssk9mc09kIUePBleth
         bWwk3tvy9Vxd2OCu/j+JpXp8rc1u4uWa7dkGtA7yPi+eQSLTah8yt3VRDiXavKyzr3Eb
         P0VEw77LioOCtNM6Og5yEBC6pyDjCBLK28X3Tv5IuhI4Rkavp66n7zvSJilNtpGlVexx
         vrtO7+LazLzX/Fa5mUNVoe+WVJZ2cEyQozfXA2x0UyaAwvXxQnyTMBWasBKv4/db0hpD
         ZpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642184; x=1685234184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW019hZw2m79ekhK1VWnhrvbjoWfN5CPvgTC/Quxs28=;
        b=HcQzZlQHsDU43aMPB+qK/TwBotASpP11r3NVkrKu7x7F01lN9lyNuS2lmbL86fIMEi
         5u62WO7srrpCBqBZA+Ce+dBdOmNlYsjH8TG/WlSObL3sbdAAbMACMFprO2DMdeQckr67
         64uaa8+SmQnE1jy+PZOAoVcq0eU3fhH5oM+/LIEX6mRPxTIKitcRqAkCYwDKdkhcnxM3
         buJl6XhDfUBeiUyl79tUHTi2Sj6+quqCgureywS9GSGJ2ztV3k5GUGjdakxkSPyA2FXa
         EVgJpcSCvMiQahJoCsYHLxdyH4Nx+5oC8RpFP0T1CudrD2STlLSRt3wTw2LbgqzZ+JZm
         vK6g==
X-Gm-Message-State: AC+VfDwAlN4M97KeePQIs3iaYjUKK4WESghXm6PImpq1VPfmQLoQe+4f
	kS/8+FLml4kpTxGFfYvp8ZlieeKaDT3YEvhvv25h8nCnhlQ=
X-Google-Smtp-Source: ACHHUZ758CjLd8TFCzk8vXIrcKshzsrPBVasrAa0YYZ6y1EB2pR4JEPoIFQ0lBRCgmSB6WktGi1AvvdIvEtxfmsAH/U=
X-Received: by 2002:a17:907:628a:b0:94f:80d6:b825 with SMTP id
 nd10-20020a170907628a00b0094f80d6b825mr3596397ejc.19.1682642184253; Thu, 27
 Apr 2023 17:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com> <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com> <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
 <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com>
From: Wang Yicheng <wangyicheng1209@gmail.com>
Date: Thu, 27 Apr 2023 17:36:12 -0700
Message-ID: <CAPiksxOu2W62bP9fFuHvxjACz+cvxH58fEkoFvALKFdHax3Tcw@mail.gmail.com>
Subject: Re: Seeking for help with NVMe arbitration questions
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_173627_014261_9B2DC5FB 
X-CRM114-Status: GOOD (  16.56  )
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

Thanks a lot Keith! This is very helpful!

1. Then do you see a way to prioritize a specific set of IOs (favor
small writes over large writes) from the IO queue's perspective?
Initially I was thinking of WRR, which later turned out to be not
supported. If I want to leverage the IO queues to achieve the same
goal, from what I understand I can simply send small writes to poll
queues, and allocate more of those queues. Say on average small writes
take up 20% of the total IOs. And if I distribute 40% of total queues
as poll queues, in some sense I give more weight to small writes and
thus prioritize them.

> > 3. Say I have only 1 default queue and I submit an I/O from some CPU,
> > then there can be a chance that the I/O would need to cross CPUs, if
> > the default queue happens not to be on the same core right?
>
> If you only have one queue of a particular type, then the sysfs mq
> directory for that queue should show cpu_list having all CPU's set,
> so no CPU crossing necessary for dispatch. In fact, for any queue
> count and CPU topo, dispatch should never need to reschedule to
> another core (that was the point of the design). Completions on the
> other hand are typically affinitized to a single specific CPU, so
> the complete may happen on a different core than your submit in
> this scenario.

2. You mentioned that completions are affinitized to a single specific
CPU. And this is exactly what I observed in my test. This also seems
to cause worse performance. Is there a way to query that affinity or
is it invisible from outside?

Best,
Yicheng

