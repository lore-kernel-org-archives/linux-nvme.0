Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69F6C001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlgEq4UH4vDTOZrzscCBubu+ZOjeAEIOmPqCH5Q/VA4=; b=X8bmyoYbG7VggU5lvkb9dYfUxl
	fWBDIWjmOiI0qd0yVMx04h3Io2Q1E2xsg1jYzeVG/u2nuzzCfvUGjEtdDAWPeeIu9xW9z1NiqZtpM
	3YBZiiotjm0xIgCUp7oa5uPSZgAikSEnhGgi99+FrE2eaqHD2cib0/gr8uhl2TJnz7+3WqQIkx9PJ
	AraPhJj5uWCGb2gyXILYUAn6QyaWiXG2n/5z4mQyCCOIRuy/BcCjcvUsFoc0v3qQWsx0BzAbzgbmP
	hb/V70xgDg4n4iXtnltvZeadXi24R1NONuuursW06deje7xvaegLTZN+anVqIUZ8XSfxiDXANP7fS
	FHXOnsRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGP2E-00BHI1-0F;
	Mon, 03 Jul 2023 19:16:30 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGP2A-00BHHM-2c
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 19:16:28 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-263253063f9so3488529a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688411784; x=1691003784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlgEq4UH4vDTOZrzscCBubu+ZOjeAEIOmPqCH5Q/VA4=;
        b=siqjtbELynGlxxIRUqqlm1qRIIGPI04SUqntEeyZ9DeXx8FwnRhhG/EMMubIceFYt7
         RRc7uebvlYi6FEe+8lMc6vsu5mreNBpTjxbiemcLNzjSRJHa47+8ElZ+ZrFSTMgC8SLF
         BdgsZU43OvuG+VFZfruUNF9AvzzruQwh8EtBS/bwmJpTm/c+JPYvgxaLxxfx8qiu1c3P
         t7b9zQnHnBx/ccB3g1NZG2DjONQLSTNCZOak+814Gk3OIZVIuE9lwn8CK76yHtvRnjf3
         DBGIWj/E2eMuYQAMN1bN26jfh/sw16Py4Qdwr82U39plffa37oiePNcacDwtOPVgGxP4
         Be5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411784; x=1691003784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlgEq4UH4vDTOZrzscCBubu+ZOjeAEIOmPqCH5Q/VA4=;
        b=cY2oh8hOR4yB0QccSw0Zq8zEYXowHcsx3fyURN2vDYIxmmP2G/4rcC7sRe+JZMLiZI
         hkO5mwBzT5KZFyk1IuxSS6VGE6zZO+mHSR3c54Yd6T/Hzqwk+4IMe3obP6e/N7MJP9uL
         dVd/ridKtC0XLJkF6mC7ypgbT3FFmcTXKJvNeIuFiWdUBXSeWJyCrjOn4WCD6xR2WWPQ
         Dv3kchWiih2nfpivmK3DERxwUIqulQI3RVPZJJ2ot3JhY3/Uhw7RDFvnNlSF0WXU/w1b
         F9LHVoNfZTxkTFcTrjMy+Pug7j9oEm0o4DcQJSrPKfSeYrN1MVpavc6IAcBuL6cvIIBV
         TK9Q==
X-Gm-Message-State: ABy/qLaIG+WkKdwNcFY+EXyiKNKNQZe+ASXCbOgZb/vq5qCwEDmS75aJ
	LgeWeVJvf9S1KpGwfI7zUGInjHjGWUhagw==
X-Google-Smtp-Source: APBJJlGqXCrlNyt1UNKb5/0hBKYxlCGcww0eRZOrxb28F+xvEtqrl67rC5Npro1ijOVvH/eEUA1PZQ==
X-Received: by 2002:a17:90a:6c06:b0:263:4156:97ec with SMTP id x6-20020a17090a6c0600b00263415697ecmr11464301pjj.34.1688411784312;
        Mon, 03 Jul 2023 12:16:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b0b9])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090aee8c00b00263418c81c5sm9054371pjz.46.2023.07.03.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:16:23 -0700 (PDT)
Date: Mon, 3 Jul 2023 09:16:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ofir Gal <ofir.gal@volumez.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Message-ID: <ZKMehaAF0v-nV1qt@slm.duckdns.org>
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
 <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_121626_871393_ECAB3C3E 
X-CRM114-Status: GOOD (  25.67  )
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

Hello,

On Mon, Jul 03, 2023 at 04:21:40PM +0300, Sagi Grimberg wrote:
> > Thorttiling files and passthru isn't possible with cgroup v1 as well,
> > cgroup v2 broke the abillity to throttle bdevs. The purpose of the patch
> > is to re-enable the broken functionality.
> 
> cgroupv2 didn't break anything, this was never an intended feature of
> the linux nvme target, so it couldn't have been broken. Did anyone
> know that people are doing this with nvmet?

Maybe he's referring to the fact that cgroup1 allowed throttling root
cgroups? Maybe they were throttling from the root cgroup on the client side?

> I'm pretty sure others on the list are treating this as a suggested
> new feature for nvmet. and designing this feature as something that
> is only supported for blkdevs is undersirable.
> 
> > There was an attempt to re-enable the functionality by allowing io
> > throttle on the root cgroup but it's against the cgroup v2 design.
> > Reference:
> > https://lore.kernel.org/r/20220114093000.3323470-1-yukuai3@huawei.com/
> > 
> > A full blown nvmet cgroup controller may be a complete solution, but it
> > may take some time to achieve,
> 
> I don't see any other sane solution here.
> 
> Maybe Tejun/others think differently here?

I'm not necessarily against the idea of enabling subsystems to assign cgroup
membership to entities which aren't processes or threads. It does make sense
for cases where a kernel subsystem is serving multiple classes of users
which aren't processes as here and it's likely that we'd need something
similar for certain memory regions in a limited way (e.g. tmpfs chunk shared
across multiple cgroups).

That said, because we haven't done this before, we haven't figured out how
the API should be like and we definitely want something which can be used in
a similar fashion across the board. Also, cgroup does assume that resources
are always associated with processes or threads, and making this work with
non-task entity would require some generalization there. Maybe the solution
is to always have a tying kthread which serves as a proxy for the resource
but that seems a bit nasty at least on the first thought.

In principle, at least from cgroup POV, I think the idea of being able to
assign cgroup membership to subsystem-specific entities is okay. In
practice, there are quite a few challenges to address.

Thanks.

-- 
tejun

