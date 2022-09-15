Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0393AC6FA86
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Sep 2022 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EvVlNBmNPN9VEv5z6nXP0RbnFLpt+bFT6fi9F9/mQl0=; b=pT9EaP4N/UKg8C8E72p7E052Ye
	hRZrH/WnJp/2aT0r3eCbSW6pFxWw93VA+4ozRFyyRPB8/D9Dc/hXTNZ5Yu9jY2BFG4g8INDd4KDwG
	WY9rIEJlG3VIVDiRiC3ApZxzyC149TwhY1HXVfablhaN1+53fR5xr+Rf0gEC4I/9Oqe4nuaHnu888
	olMOpWvB59CNT/z4TagYYTlp6Oiwlwj4lsmoHvWGdOpNi7G/gENvBIGBVkJzSrJz/vovoR0ZK4oJQ
	il7eEjCStpGRB3M0pdPY5vnZaG1D0G4SyVQy3c/LeOHNXkrmexubzSMetW38p7S4Z0E5hfDwKQmPR
	5u6G0spw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYt16-00EeZw-U8; Thu, 15 Sep 2022 17:51:12 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYt14-00EeTj-86
	for linux-nvme@lists.infradead.org; Thu, 15 Sep 2022 17:51:11 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id d1so14832444qvs.0
        for <linux-nvme@lists.infradead.org>; Thu, 15 Sep 2022 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=EvVlNBmNPN9VEv5z6nXP0RbnFLpt+bFT6fi9F9/mQl0=;
        b=J626aibaU8NveRplSMyN9BZ+5vWLtoZC57ekodItvsQ7JbcIDD6RemywionBqDZhIa
         /AVsih0wFzwtG1rOn1PHZ4fANR1NsJ0z5vGJHwImbFwEdkgP8w5FYWrR1UUabJ9MM4SF
         pcYEA14N35BWqV9HDUwFaPm2gPUIzBdyIO2BGYSBK2oN5pqSrwN7+57iCKHvE+MU1yvd
         RrxcDeYUycVbU8X93m93FKh//9nCXfbo+IinhGs2taydmTx/wu35aZAXiSEVqUqtAGDA
         ID5YxpqIDy+MIk1TNauZuNfpc2UbsduifPH8CUYgdqu9MRLtToy48XYWihHnDBxz6ixJ
         JBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EvVlNBmNPN9VEv5z6nXP0RbnFLpt+bFT6fi9F9/mQl0=;
        b=g5AORs3IwuwJ+z5FlQM4AZdUkehhkmxATqSbSYhwoS04ONRJEOFIVUcQc4v20ke4QT
         IY8TvR0wX05hR6O1UA4aGHZvsaE+/glmDkE5e+If9C15uEDiiHDh6AtrblYtbH9I0oqI
         hTDEsLJnuhes0mQnvmwND2z7VT9X99vFMF4fi4+OGGB8ikVeBsKPtOruOA8ar/6qcxWs
         M5J0XqWY4EEi8FwXz2LhzpD6GjitfVpGUjly03yi2uzacV7kZv3GJKtD88FlB0Ck+A0W
         zQd7bQPOqBt4ZEmVBMXxNqfTLm/o3mo6Tu3/Fb1aH8rtoRD3sFi0+DI3vLaMvQw8rJSy
         ZH1A==
X-Gm-Message-State: ACrzQf2A/tTHPqD0c26BmKVqPnLVpH+2jB6slQ0HO248jcGA/udJBB4w
	sEf8KQnnUERJACyBoa7uzNriA+lh+S/3u2MLF9WXM9rE03+Aog==
X-Google-Smtp-Source: AMsMyM5OadOIOG/SO32Rl+bR0eMYlz9dZ0/fkq90LkFJuEU39JBRdoYcweeROY8NR/dyUmE9EbKhYZtxw0lR95oo7fw=
X-Received: by 2002:a05:6214:2425:b0:4aa:9e6a:3d25 with SMTP id
 gy5-20020a056214242500b004aa9e6a3d25mr754160qvb.22.1663264265881; Thu, 15 Sep
 2022 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <CADqNVTpcFuPh8w3Gcx2ftYh_4EjObxpenA2Ps2y=055W0o13=A@mail.gmail.com>
In-Reply-To: <CADqNVTpcFuPh8w3Gcx2ftYh_4EjObxpenA2Ps2y=055W0o13=A@mail.gmail.com>
From: Nick Neumann <nick@pcpartpicker.com>
Date: Thu, 15 Sep 2022 12:50:54 -0500
Message-ID: <CADqNVTp0KfQsegsEQn09-Tuc0b76_jWuir9UbDCe44o+rHr=0w@mail.gmail.com>
Subject: Re: smartctl "kills" specific drives on kernel 5.13 but works fine on
 5.15 - why?
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_105110_354882_52151034 
X-CRM114-Status: GOOD (  23.37  )
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

On Wed, Sep 14, 2022 at 2:44 PM Nick Neumann <nick@pcpartpicker.com> wrote:
>
> I'm running ubuntu 20.04 LTS with HWE, which reports kernel 5.13.0-51
> generic . Both a crucial P5 1TB and Crucial P5 2TB behave rather
> poorly. With one drive installed, running
>
> sudo smartctl -x /dev/nvme0
>
> will output some info, then hang for a while, and then print
> "NVME_IOCTL_ADMIN_CMD: Interrupted system call"
>
> From that point on, the drives are gone from the system until I cut
> and restore power (reboot is not enough).
>
> Running smartctl against the drives works fine in windows and in
> Ubuntu 22.04 LTS, which reports kernel 5.15.0-43
>
> I thought for sure I'd find that a quirk for the drives had been added
> between kernels 5.13 and 5.15, but alas, I don't see one. The PCI
> Vendor/Device ID is 1344:5405 for the 1TB model, and while the crucial
> P2 has a quirk in drivers/nvme/host/pci.c, it has a different vendor
> ID altogether (c0a9).
>
> Any thoughts on where I can look or what I might compare to try to
> figure out what changed to get the Crucial P5 drives behaving? I was
> hoping there was some setting I could tweak to get them going without
> having to move to 22.04 LTS. (I've tried
> "nvme_core.default_ps_max_latency_us=0" and various values for
> "pci_aspm" with no luck.)

Figured this out. It isn't a linux kernel change, but rather a
smartctl change. (In hindsight I should have started digging there
first.)

The issue was https://www.smartmontools.org/ticket/1404, fixed by the
7.2 release (and Ubuntu 20.04LTS is on 7.1). The fix in smartmontools
was to change to reading logs 4KB at a time, just like nvme did in
https://github.com/linux-nvme/nvme-cli/commit/465a4d. (The device
advertises that it has an MDTS of 9 so, as far as I understand,
reading in 4KB chunks should not be necessary; the smartmontools
author was not certain where the blame for the issue really belonged,
but changing to work like nvme-cli avoids it.)

For now I'll avoid reading the error log via smartctl on problematic
drives until I can move to a later smartmontools version.

Thanks,
Nick

