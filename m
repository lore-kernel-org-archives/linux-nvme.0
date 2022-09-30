Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BFDC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOCd7tTS2CqybsW7eGXhNjjeU9+qsp4u73DlpNnCnDE=; b=l7+2PKtnn4lvIxilcehd1uglk2
	ITD9tasd865TooIu7IlXFy2erhd4GYo8o2N7+V2MnC1RiD31uxTWW2NqvP0shcXaiUOq6TnAXk6fl
	XJRJJOu7U7AfOF65mGPXTGSysLtJ9IBqEFh00N3HWbA4iMZI34msigObRf9U306MfoZtSfGqUWJKA
	D9/n0NVWKyOakVg+X/Dx3HPdOEKVgsUouMBt/g1Kd7RASo9ua/Myo0JSUsMB743Hy/TVuxxk5dRyN
	Y88OBXY/4tNw49B9MgNX3MFycRaxMw8bX0qzg4KIFH5X2S/MpJijgDM6sAPC10rWlG9J5n7Pfi94k
	OH1oUCfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHhb-00A4xT-RZ; Fri, 30 Sep 2022 15:13:23 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHhZ-00A4w7-6J
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 15:13:22 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 65so5627206ybp.6
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nero-im.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DOCd7tTS2CqybsW7eGXhNjjeU9+qsp4u73DlpNnCnDE=;
        b=JfFZlSOID+Tno3B5HyVmwe3gc7ilnyrYhEqlSRGL0igyIuZEdGKrUIWFTiiYKwmw9G
         PFhe0NullFAAISnebI6YR7z/3UKDHrLPLosREimfYBcZ7bSxMTen5Rr0ycIkXsj13TuX
         TKD3JsiN2iA33Ms1Gsat77BfFbBinf1aHg3dJiR48d0OkHtsVv9LxLj9EsJyTXpz1bRt
         cLSi9FodsE0KfiBFTXU7/BzXXDGwEevbFf4V2W8GhuYTz0kBLqkkvyRyQlmeGx95pnSP
         139gtMWtLUj91NDDtjIdKckRL/DZ8yAkdnc44p5+G8fu0HaiCtJNIU5JA/81Bog0xtZ7
         6z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DOCd7tTS2CqybsW7eGXhNjjeU9+qsp4u73DlpNnCnDE=;
        b=yQkFCHZWuD0g6jq/5T71GB/APBL70HycKOqjdpjK1GjSVRCyx7wItUZwHNtoz+f85q
         AANrL5+YkzAPAJzi7w1VdMjba4TbaBhvbXbq5eK2mq1UoMixY+GHw65mEuoBMO4PNsZr
         bgS6D+8tqX+ov8lJghZ9prOp8TZBq8bqfKTeuK2wAASQBMEuO/t8UiLPVpbXepDbzTuL
         XTMH8ACqGSjcjY8sy/pZygtg75NjEk+beynNouAwJ/KqCPb3zTgAdqQwfB8zJ+GS2pQQ
         WURSuyFPk8DqE8QP7ZfiUNT3rIbP51ZHCEHBb3gn2a9eIt4pNmxGxuQTAnC8F/d8tltI
         Fbuw==
X-Gm-Message-State: ACrzQf3W9e7QVjm9z47H/QECOhdhcVJ/xRqkUjedUACXmUcwphTTRaSy
	9pdToYYtkc6zNkdrRjRGWZhgmkWCkPczp9x5B4bqvp6jnmPHT2Ku
X-Google-Smtp-Source: AMsMyM5kSIem3WszEnPJHRBPKcQMSb1c6bgiOofXWokE2unz/izOnx0DnxtdreTg9dUEeaIut18PoYiMynLllEkbrdw=
X-Received: by 2002:a25:c907:0:b0:69f:cba0:72b1 with SMTP id
 z7-20020a25c907000000b0069fcba072b1mr9067106ybf.518.1664550795631; Fri, 30
 Sep 2022 08:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAF9DR03RxNagB37S=F__JUhOf0m=M8vwCJ=kv93mQYXDGTJN7Q@mail.gmail.com>
 <YzcGICHQRR3NPjed@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YzcGICHQRR3NPjed@kbusch-mbp.dhcp.thefacebook.com>
From: Neerav Kumar <me@nero.im>
Date: Fri, 30 Sep 2022 10:13:04 -0500
Message-ID: <CAF9DR02G-wrRD_AyNzoW4yRoch7_5+LJC=8knBxz-8TT1CZEVw@mail.gmail.com>
Subject: Re: add NVME_QUIRK_BOGUS_NID for Intel P4608
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_081321_275762_DBC9721A 
X-CRM114-Status: GOOD (  19.17  )
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

 lspci -nn|grep NVM
09:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
0a:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]

So, it seems to be the broken 2x4?
I only have access to a P4608 so I have not tested this on other
device ids, if there is a way to narrow down the patch to P4608 I
would be happy to do that.

On Fri, Sep 30, 2022 at 10:07 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 09:58:36AM -0500, Neerav Kumar wrote:
> > Intel P4608 reports bogus eui64 non-unique values so apply the
> > namespace quirk to it too.
>
> Is this specific to the 4608 with its broken "2x4" pretending to be a 1x8, or
> are all the 0a54 device id's similarly affected?
>
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 9f6614f7dbeb..ed4002109122 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3432,7 +3432,8 @@ static const struct pci_device_id nvme_id_table[] = {
> >      { PCI_VDEVICE(INTEL, 0x0a54),    /* Intel P4500/P4600 */
> >          .driver_data = NVME_QUIRK_STRIPE_SIZE |
> >                  NVME_QUIRK_DEALLOCATE_ZEROES |
> > -                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> > +                NVME_QUIRK_IGNORE_DEV_SUBNQN |
> > +                NVME_QUIRK_BOGUS_NID, },
> >      { PCI_VDEVICE(INTEL, 0x0a55),    /* Dell Express Flash P4600 */
> >          .driver_data = NVME_QUIRK_STRIPE_SIZE |
> >                  NVME_QUIRK_DEALLOCATE_ZEROES, },
> >

