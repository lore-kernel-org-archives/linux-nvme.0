Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CF5CF9C7A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2faGZGNjV/Ol4dCxT3b6jGEV1WM/yda0rsC63QluSdQ=; b=Ti7RfBoEbvoPomM0wmZEWcn0dV
	VCnbxkxgzfcBO2Smaa6mG/6KAr5XN1QksUfuAPyqTBxOChsjihFj4RDUwI9caZ78swI8ZLLhC/uWl
	CjFGpCHZEqEdOtgXr/AzCfdKqGdV43k9gxQTPax0T2PNQcS5Nab9t9ZsvPRo9MKkAa70LdHoVIMfv
	ZkvQ0PYp322vwRlpmABTBjCphwW01yZe1oCnWNdNipGCTYBQoQL9c55KTPhCX1tII7ooe2268aywC
	iBrzDpyC1uMJK5dzJXs6T9FpjH2H5n7ZiKit9XxC2BOjD1hZ5lVCVKtMzMXhYfUKPtPehrMXJYe2x
	w29wx7YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stCOI-00000003HFX-2qYw;
	Tue, 24 Sep 2024 20:44:10 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stCOF-00000003HEh-22rm
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 20:44:08 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso6982789e87.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Sep 2024 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727210645; x=1727815445; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2faGZGNjV/Ol4dCxT3b6jGEV1WM/yda0rsC63QluSdQ=;
        b=it5dCQ3h4vHUFaywbfYY97GSBBKPSczVBNfn1iyf56Fnpl+wQl6tGU1JnjW5wrjsbi
         29muEpIAU7VGfDfqW4uY9RIAFLwYWuH1Q3vydTZmav1Pcu7SE+LAkbAaqH0FkcBikkVH
         4/t/GBd+oQmVy5MWq0sc8cKSwDiMRemimI8fjfb7NnhdgxfMGv8WSMF08gRalDic+Jmg
         NFbCipSSJdNhHGnc4EcR2C5OMx2houRFZysPGjHziwc8CdQ6s9Ipj5pqT5UsR+J2kLEx
         T1oRA5D2VKSCCQ8NQ2shpjPLDxi3XTXQSnBtTA0atJi61NY+Y4/VYwbYlgqnjH7Xd97f
         qMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727210645; x=1727815445;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2faGZGNjV/Ol4dCxT3b6jGEV1WM/yda0rsC63QluSdQ=;
        b=NLJV9LNAvBzt5CWfOp/3OnWYF5URfuaDBKapHdXEwk9OypD2EG6UdvZzpG2uyp5bw4
         CxtJqB4WSB6gI73dQhhsTCqS0JEPCHwQf0YLK/A3ks4N/qU8szlmToLawZ9S7vIF4jjl
         F3oYOmDJ4K9gf3mJ+MtwVRJW0c4emXyzZUERR1j73FflKWZAZAJeoH/BMCSNDufCaMuZ
         YAvGJVG/LaUfJ0SG5o9oYGg0bFuXE2ABfP1DyChhtY7FxIfxOn/WPKTwMGpjuQWCAJbo
         45NOnUjXsbgk0R9can9vLnaVkYlCgVxoUVp+CZx2Vn0kD6FmzCXqZvm1AtI2Cd+zgoZU
         vxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXGxMrEiIjxCHtL/A8lTljAi6mwhjRwYLGbc5JKUes2XhjYiMKttu2/7v4gmZzl7nUfa5F9ecf8Yf8@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1dzCJkWd+yUtR6gbjJs+eQvBRWazRAO7+aZu4vscjywhUgZe3
	8IFeLdt9GJLlOj8H0TdhP1FDLgPY7C5lyZS/Y/7hfcq0Wc31m4jX
X-Google-Smtp-Source: AGHT+IE66lH2TWaoR0Wn1kL/JkKwaihDSp/X6Fc9tJ9Phu/UUJM1E1L/IMzsW1415EulINyviGdhPQ==
X-Received: by 2002:a05:6512:6cf:b0:52e:f77b:bb58 with SMTP id 2adb3069b0e04-53877538ce4mr178528e87.36.1727210644749;
        Tue, 24 Sep 2024 13:44:04 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864da87sm327296e87.268.2024.09.24.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 13:44:04 -0700 (PDT)
Date: Tue, 24 Sep 2024 23:44:02 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <ZvMkkhyJrohaajuk@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <ZvHUn1Q2R8FumZ20@skv.local>
 <2024092440-embattled-magical-64bc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024092440-embattled-magical-64bc@gregkh>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_134407_565842_11E9154F 
X-CRM114-Status: GOOD (  35.63  )
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

Hi,

On 24-09-24 11:23, Greg Kroah-Hartman wrote:
> On Mon, Sep 23, 2024 at 11:50:39PM +0300, Andrey Skvortsov wrote:
> > Hi Stuart,
> > 
> > On 24-08-22 15:28, Stuart Hayes wrote:
> > > Add code to allow asynchronous shutdown of devices, ensuring that each
> > > device is shut down before its parents & suppliers.
> > > 
> > > Only devices with drivers that have async_shutdown_enable enabled will be
> > > shut down asynchronously.
> > > 
> > > This can dramatically reduce system shutdown/reboot time on systems that
> > > have multiple devices that take many seconds to shut down (like certain
> > > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > > without this patch to 55 seconds with the patch.
> > > 
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > ---
> > >  drivers/base/base.h           |  4 +++
> > >  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
> > >  include/linux/device/driver.h |  2 ++
> > >  3 files changed, 59 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > index 0b53593372d7..aa5a2bd3f2b8 100644
> > > --- a/drivers/base/base.h
> > > +++ b/drivers/base/base.h
> > > @@ -10,6 +10,7 @@
> > >   * shared outside of the drivers/base/ directory.
> > 
> > This change landed in linux-next and I have problem with shutdown on
> > ARM Allwinner A64 device. Device usually hangs at shutdown.
> > git bisect pointed to "driver core: shut down devices asynchronously"
> > as a first bad commit.
> > 
> > I've tried to debug the problem and this is what I see:
> > 
> > 1) device 'mmc_host mmc0' processed in device_shutdown. For this device
> > async_schedule_domain is called (cookie 264, for example).
> > 
> > 2) after that 'mmcblk mmc0:aaaa' is processed. For this device
> > async_schedule_domain is called (cookie 296, for example).
> > 
> > 3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
> > parent->p->shutdown_after is updated from 263 to 296.
> > 
> > 4) After sometime shutdown_one_device_async is called for 264
> > (mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
> > code calls first async_synchronize_cookie_domain for 297.
> > 
> > 264 can't finish, because it waits for 297. shutdown process can't continue.
> > 
> > The problem is always with a MMC host controller.
> 
> If you take the patch here:
> 	https://lore.kernel.org/r/20240919043143.1194950-1-stuart.w.hayes@gmail.com
> does it solve the problem?

Unfortunately not. I've applied the patch to next-20240920 and tested
latest next-20240924 with patch integrated already. In both cases
shutdown hangs.

-- 
Best regards,
Andrey Skvortsov

