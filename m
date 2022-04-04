Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6ADC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtiMNVEoYZXoi1GNMLStyUsaBQPuI1mPKxVFdAdwSEw=; b=QGVG5+gcMdumIsrdxphwxLprcq
	XdDhaI4io7DsODlLu7y1/QG57VewWCUXWmyqndb3FR/nwlTd7bGxaqghYht8DJ8/xgU0faViVSHEd
	abi54fD6gkC+3KsTJvzbjYTLb/0z9fGyltDy6IOb0cMCdW2uFdsA72ALH5WMz5sx11qB1IuJt89YZ
	aNRafjbTGT5g+hBg6WNMqMGJs/l2Vjm134EBO65XsIMUoYawVnXFMDpCr+uf77pqwXrBhSeg4RNWM
	XaU0LBs5PR/KHc4bD0cy8Xbx6JRx9jnntwtEVGqepDwFpHsabCOufFYWCUZA7KrAyggg+x9AH3THP
	fQEFDfgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbOEB-00FTPL-9l; Mon, 04 Apr 2022 15:02:47 +0000
Received: from mail-oa1-f46.google.com ([209.85.160.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbODx-00FTIc-WF; Mon, 04 Apr 2022 15:02:36 +0000
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-e1e5e8d9faso5682300fac.4; 
 Mon, 04 Apr 2022 08:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vtiMNVEoYZXoi1GNMLStyUsaBQPuI1mPKxVFdAdwSEw=;
 b=Jdsk/DlmneWWRoiVgdqLxVxRXm8f6m/iGe3Rr8Cxr1kUr8tDqKQqYdzWNpK1Cd4nVf
 FFxRcqVqnSkoZHHLuF2cTR6BXQaNmE1sarwpPOKeWd350BNsuE9G+okBndJcGtYPBpQ1
 veFX0ZOqS3hCYcTBVaKi0y/OWJ2HrouMWKgXKRNQ6HCIn9uLrTR8wpBXDBPcdTsfcnwF
 VybWT10PpspIEcpPL3kkNox+jE4pp1R+SWKwaxvNhklRAhmKu2tmuJaId3iP+0UEjIFj
 ZYHg849LDIM48QVBCN+frKazDMnuGvDzRyYdPwu9OlQaz2TveowW2P2K17/tUz8VaDk4
 oGfQ==
X-Gm-Message-State: AOAM531MUTukhzT+zg/ORwu8Vo4mmh+ramYU4oCBi2R3fFnF+haxgj4s
 5BcMBMJf76eQzpAZcWlwpw==
X-Google-Smtp-Source: ABdhPJxE84xSZeC7rzs41J9r830YaWpOHzkIguHr+Y1O8sOgXGMHMwvgtdOZDcMpMkcvMM7Alx9j8w==
X-Received: by 2002:a05:6870:f109:b0:da:b3f:2b4c with SMTP id
 k9-20020a056870f10900b000da0b3f2b4cmr11024410oac.235.1649084550501; 
 Mon, 04 Apr 2022 08:02:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 bm51-20020a0568081ab300b002da5c44e0bdsm4200166oib.28.2022.04.04.08.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 08:02:30 -0700 (PDT)
Received: (nullmailer pid 1321618 invoked by uid 1000);
 Mon, 04 Apr 2022 15:02:29 -0000
Date: Mon, 4 Apr 2022 10:02:29 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Message-ID: <YksIhWQIUHsoWEMi@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
 <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_080234_058164_C2E7C92A 
X-CRM114-Status: GOOD (  22.61  )
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

On Sat, Apr 02, 2022 at 03:51:46PM +0200, Sven Peter wrote:
> On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
> > On 21/03/2022 17:50, Sven Peter wrote:
> >> Apple SoCs such as the M1 come with multiple embedded co-processors
> >> running proprietary firmware. Communication with those is established
> >> over a simple mailbox using the RTKit IPC protocol.
> >> 
> >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> >> ---
> >>  drivers/soc/apple/Kconfig          |  13 +
> >>  drivers/soc/apple/Makefile         |   3 +
> >>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
> >>  drivers/soc/apple/rtkit-internal.h |  76 +++
> >>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
> >>  include/linux/soc/apple/rtkit.h    | 203 +++++++
> >>  6 files changed, 1284 insertions(+)
> >
> > Isn't this some implementation of a mailbox? If so, it should be in
> > drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
> > Linux is organized. To drivers/soc usually we put drivers which do not
> > fit regular subsystems.
> >
> 
> I put this into soc/apple because I don't think it fits within the mailbox
> framework very well.
> (It actually uses the mailbox framework for the actual communication
> with the hardware with a driver that's already upstream.)
> 
> Essentially, the mailbox subsystem provides a common API to send and
> receive messages over indepedent hardware channels and devicetree bindings
> to describe the relationship between those channels and other drivers.
> 
> One of the features that doesn't really fit is that we need to be able
> to start, shutdown and re-start these co-processors. The NVMe driver

remoteproc does that. Did you look at it? Most remoteproc drivers use 
some combination of mailboxes and shared memory.

Rob

