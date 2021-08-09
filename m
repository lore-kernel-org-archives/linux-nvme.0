Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E88C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 10:03:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CA36108C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32CA36108C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iBbozqNjhdr5WPIzAOSyAsGM665ybrAyU1uIz96akTM=; b=hEYkfqRzMcyqtZ
	ajgksUkWKQfQGugcmjXFPAyPoeORV26SobBIpNwJKrEE46QoLTpE4AWlQz8vZmpiSCXNSRSk/1QpI
	UyebrQ5RCgW5mOdgnTIrakMhAiHWSeV7RJ0nLIWeh4iPyybXwy/tPfQ8z3fTsmrQ2EYZ5EaWNeYqG
	bHsEnjLqOmyQ3nbBRJPWWQoImJiu1cB9zOMVUi7STFXG81mKjxCwk1QU8lc8kUi9jQ7qQCC9fh4Q1
	FoqIyk+fEakb4IDXbvBTL9aHVLJT1Geo6y0VB00jELqhKF+OQkjZKvCY89uvw9tX8L8QDNEaFe6SW
	eLWMKW6N3d6BfwfWdnjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD27r-0008Mw-T2; Mon, 09 Aug 2021 10:03:19 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD27p-0008MD-7v
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 10:03:18 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAwPZ-1mOGOP1u9Z-00BNve for <linux-nvme@lists.infradead.org>; Mon, 09 Aug
 2021 12:03:12 +0200
Received: by mail-wm1-f46.google.com with SMTP id u15so10169826wmj.1
 for <linux-nvme@lists.infradead.org>; Mon, 09 Aug 2021 03:03:12 -0700 (PDT)
X-Gm-Message-State: AOAM5339hpiRfyLJYQ3757zEH3GG4iYbYS4pnCgOtwH8SL4bbK0T22mP
 8GiZrlRJJS33I4FaeXQ9rtkKx3nm7cYTSFeF8fI=
X-Google-Smtp-Source: ABdhPJxMSNfokjmxSD/HWz7CwSnIAHLPusz4+tBGMuun5FVme/H32OwPqx9/s8fNtUy3bTLzDKCj9Sr1PMCmmntXkac=
X-Received: by 2002:a05:600c:3b08:: with SMTP id
 m8mr33050223wms.84.1628503391981; 
 Mon, 09 Aug 2021 03:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <202108051646.vdMMUBea-lkp@intel.com>
 <YQ7GVu1TqpqbHZOb@infradead.org>
In-Reply-To: <YQ7GVu1TqpqbHZOb@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Aug 2021 12:02:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
Message-ID: <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
Subject: Re: [asahilinux:nvme/dev 13/17] drivers/nvme/host/pci.c:2249:2-3:
 Unneeded semicolon
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sven Peter <sven@svenpeter.dev>,
 linux-nvme@lists.infradead.org
X-Provags-ID: V03:K1:GCYlJigOSqzk+pYGQNsroNXYy9cvAf37j3VdixGsLvUmJv0or3M
 qZCTT365QQBNmbD2oDYSP+emT6Av+5uWQdBLXx5UFHOMUqlpLx6cmv7MLRFXn7eotIXPtNz
 njuH9gmom3futphZHEiAiCzsiPoyJUq7XPAPtxvLyc489y0ZlZl9TU4tU3eIwzLSOkFnmar
 +3JghYMi0x6G4+UtEvg8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bvMFGmrabDg=:LWLOkiS7BbTUPOVjD3+Iqo
 Rhl7dFp+er/mlts59CGinLkGGLpaq4VBQ4Z89IB6fqXRGlO9BazP4r4u1D/sfWMTRQddfUmt1
 X0PW+akToxUGpr2vuk+zI4RIicyIoPn/+/ztQaAEoYuyhjXjLSG8HaahImUoJHVpIPDJayJgL
 TIufSRCCldgKPAduT1rqIILItf4t1Kp1tiCsF9N6lpw1hB/6ift6oTet8etCviHzjYWJaKx6s
 qSFGw9zOub4pAL7ZpGblBzlrATStziugYwSLKu8TVScEPGRNuNw2MajDzZurxtiU5lJr5Oku+
 3z/MnLKtqAQnK/NwImjqtF5naVv/Y/n8+69dGubAPUoM92G/hfy151ZqBhxa4Js80H8sSrEtc
 frW+ZDYnbBlNfkW93U32OehhU351a9PxMsw35LfV5DwPubQ2RfStNyxoCmQ8W6r1rJqKTwV84
 dAh8tWQJBV+01bWIK0gIk+oPuv8oAw6H1D6zkrbw8fOLtvac/hEO6bMwVzBpu5q5IPA9C1Ef6
 nfsGkKFhtxMho/KJQNWQAqT637yfoP7YYFzwdceb2nupFbiBDctqsjXHJ9Lwld+FJxM/4BGeP
 pt8LqeT1E+kWwUY3fXkdsJx/nFnhSxEZ14PBCTWEny968oW2+pMEGNAMzIdVDlIQAhJI59Nuj
 4B8Hicjwmn0VJXpKLNGnk+jOs0rODSNoxTwCzzZh0A8rRS2Xzji6FwiXNC8DF/UhCp3zmeLb2
 K72YL6R71g36CwjMH2gvVvTT5o5Z5+aS3Q2qyfvDvMzrPDarFM4vZiHWwsdk2/BSIphvzBoAL
 6/KQpJ5zeGyCbpYlLq+XtrdKz+jhOweyTFvKN1X3SKMESwPiKVEs6QXZ/uKooZ+29KIKCmf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_030317_627897_CE05A8C4 
X-CRM114-Status: GOOD (  23.32  )
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

 + On Sat, Aug 7, 2021 at 7:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> FYI, I think the approach to mess up the nvme-pci driver in this
> branch is completely unacceptable for upstream.
>
> Please create an entirely separate driver plugging into nvme_ctrl_ops.

Hi Christoph,

I wrote the initial version of the series with the intention for testing
out how much of the code can be shared between the pci_driver
and the platform_driver version.

I tried to avoid moving around or duplicating code for this, to make
it easier to rebase until we have decided what the final code should
look like. It would be fairly easy to take the version that sven is
testing, and then remove all the PCI bits from that driver to get
to a separate nvme_ctrl_ops implementation, but that does mean
a great deal of duplication. I initially planned to send my patches
as an RFC to the list, but I never managed to get it working before
I lost access to the machine I had. Sven got it working fine with a
little rework then.

Out of the 3557 lines for the combined pci/platform driver, I ended
up with 475 lines that are specific to the PCI version, and 104
lines that are specific to the platform driver. There are probably
a few more bits that could be removed from a platform-only version,
but I still expect the majority of the code to be the same, which is why
I was hoping we could rearrange the code in a way that puts those
into a library module, either as part of the existing nvme-core.ko,
or a new nvme-mmio.ko that is used by both pci and platform
front-ends.

Simply moving the common functions into a separate file, and
exporting the symbols would work, but probably won't lead to
the best structure without some more rework.

Do you have any further suggestions? Should we just duplicate
the driver and then simplify the platform version as much as possible
as you suggested above, or try to share some of the code according
to my original plan?

      Arnd

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
