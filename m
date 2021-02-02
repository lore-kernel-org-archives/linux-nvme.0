Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140EAC433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:12:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ACA64DA3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ACA64DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PECVa0FTc9MfqOXq+zr0jGkRdQCaxIi3YGi++I7b6cQ=; b=kkhATONWc5XlssfT+L8/isImE
	n3aXaXh1uuTU0RqAFME6/Co6fDrW6k1xCaXx0MjngI4NwkZQk6t2+glIwaQaFUU5O4D8eMXrqCbt5
	8bMfNuYG2ZSoXHx4UpnVw9kAGon6hqc+aVIi6yLRLidTQEX8g5+ERRELG20aYPm2GxvHmdYsBWJge
	qkaHgvEGK02n7FDR9Qg4+vc5+yCEB5LVE3C7imTZWoLP9BtOVy9DjZiktDLcMi9pnjxiJXm46GRKD
	nWB9hAsIr5azIgmF72p7paw4LIbvu66zYGJ78x1TXY/Krq1qm62X5A9PG2yqdOFDFsbLGSvXMe9wX
	Z3x8zDh8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jIf-0005PZ-8i; Tue, 02 Feb 2021 00:12:09 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jIc-0005Ow-2C
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:12:06 +0000
Received: by mail-oi1-x232.google.com with SMTP id x71so20872535oia.9
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 16:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SmHGIngOZeUrAahfaDVfuGgpv8akL47E4u3p5WZDk+g=;
 b=KJtnAjfMbcGKZFbSMkp1YoKXl9iMva59/FyWHVIEl9Z8KX8Iz7xdb75uCP33gQYoKZ
 er/Myc8K5a6WEO/mezJyCKYoD4McAuJvBm58D8xNzVXDyjfgV54IGyXoVF7+IHe6clif
 80wa/Uxns/cG2MRhNbRJyX2c2EBkCDgfsTIIoKttY8gQLa57F8qKPDfEhupAUIN+Wvco
 ILKTK3A6Ed/cAYPT4ffC0+gBjQiCnOC6h3FZ4HScaUi/oivtZvYKe2WNcJwXfSLnNNg2
 wlNW3aWHdxpOLdXCm6xPpruP2e5LNNC0SznAJUVP2bgP0TkmFxfs1h4shgu+O1/21BD7
 6mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SmHGIngOZeUrAahfaDVfuGgpv8akL47E4u3p5WZDk+g=;
 b=abf7bqmrNB6egUQ9rxuMYe3Wk/9Bjnd5zw8dMR5AvlvA3Hanoaic/fkFAjQvqxkF0X
 x0AyO11zStqflsKO05Dy8JGmXEH1AQeSxxugDy4gUtqTDAfMDl4b56Kq+5o7sToduawI
 dy/Rh/cFpfbXSJWInn7luNjsQ79YlRp+2FhVsJIOqQ5rKx55x9+xv4/LJSESxb7k5yDn
 ImT6qGIJGzokIuJVDzHCzMn7M2bvDiMVPQOZ2lKwufbeDOhsSeljDkPKB0EpMZc/E0pZ
 dYScEN0cYKlGrjBrT6fYZ12dMVqbx8ja4n+qVhaQxV6asa9snEIFpy3jC2pkZSs9JNDR
 TJSQ==
X-Gm-Message-State: AOAM532k+avoBpMuf4IXyi5+Vz0k+4M03WHzVrdEDtSpT6zWryOSmc/Z
 sNEpqTxt/jaMwDfe+Y+1N0N5CyDifMbc7T94Z1s=
X-Google-Smtp-Source: ABdhPJxfxs1NEyuIPF9UR74LLphSz4gkfD89XA59Q+ST5ee7ZtkGYczaJ+U9zNhH+ELPPYnwFWE/rpEYZmLzg2DkrRM=
X-Received: by 2002:aca:d5c5:: with SMTP id m188mr975289oig.114.1612224724260; 
 Mon, 01 Feb 2021 16:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201210822.6501-1-claus.stovgaard@gmail.com>
In-Reply-To: <20210201210822.6501-1-claus.stovgaard@gmail.com>
From: Amy Parker <enbyamy@gmail.com>
Date: Mon, 1 Feb 2021 16:11:52 -0800
Message-ID: <CAE1WUT7vHzzVXpx5vKbEKb+63G6RmM0s39EtmUgYDdANkveRYQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Mark Phison E16 (Corsair MP600) as
 IGNORE_DEV_SUBNQN
To: Claus Stovgaard <claus.stovgaard@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_191206_148512_6CDF02AF 
X-CRM114-Status: GOOD (  18.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 1, 2021 at 1:11 PM Claus Stovgaard
<claus.stovgaard@gmail.com> wrote:
>
> Tested both with Corsairs firmware 11.3 and 13.0 for the MP600 and both
> have the issue as reported by the kernel.
>
> nvme nvme0: missing or invalid SUBNQN field.
>
> Signed-off-by: Claus Stovgaard <claus.stovgaard@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 81e6389b2042..41b1b0731cbd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3242,6 +3242,8 @@ static const struct pci_device_id nvme_id_table[] = {
>         { PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
>                 .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +       { PCI_DEVICE(0x1987, 0x5016),   /* Phison E16 (Corsair MP600) */
> +               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>         { PCI_DEVICE(0x1d1d, 0x1f1f),   /* LighNVM qemu device */
>                 .driver_data = NVME_QUIRK_LIGHTNVM, },
>         { PCI_DEVICE(0x1d1d, 0x2807),   /* CNEX WL */
> --
> 2.26.2
>

Can't test this - don't have an MP600 of my own to test with - but it
should work just fine. If anyone else has an MP600 to throw at this
that'd be great.

Acked-by: Amy Parker <enbyamy@gmail.com>

Best regards,
Amy Parker
(she/her/hers)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
