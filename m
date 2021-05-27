Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA5C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 17:25:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8F2613C0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 17:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8F2613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RNgCpFLqdj2WUm8CMmf1iAuJEie7MmaokfA3asCs16o=; b=FWzbmeulhc8/Eb
	s3ACd6+nfFfRC4CewA2Zs80HeYNCi8qp9F1Lseu9HRU+DV9R1SzEfARwCS8BGMsJ/27v7om/ed+AL
	6RewC3pFca0RYWSx+5Jx3uOAII8vxcgh2keq1SiytlysXvbicyl/GxpDoL4VUl+WYIa4IWzSoeT+E
	/w5yzwwkRtBmIhsy9QynYUetEqFZvAVh5TzOFiMMoW0FVq692J/fsdwQ1eeIqIQGmWCHR6GDieN2n
	T8am0fK1Gkc6TOdu4vJlh2/74qdsxAcC2iy2e/Uv84O8Zud/PRnc5PEEST2ayL0PSCxv++/7X+mvP
	TxnKp0W9zxElKM76okvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmJkc-00842K-Pg; Thu, 27 May 2021 17:24:54 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmIKH-007NiE-0V
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 15:53:38 +0000
Received: by mail-ed1-x52c.google.com with SMTP id e24so1345159eds.11
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fYVdAhacRJ//+WAzu+UDR/rVhvkNj9TXAwohR4dvnrE=;
 b=Jmqcv3UEG7ZK8U2IO7dK5+yANob8v3gcX9PpbIlCfPdrBuOIAh5kynAnOqFRU6gjCG
 C1NQajEr9Rtu/+Uhb5ag+kAkJ4cfHdhGy0zc82nPJIjHb4YIosjTeX9ZpDoOGLmQFpj/
 QEcgA8Zd623tGlPZzUrSIWsuo2eW6+w5voZ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fYVdAhacRJ//+WAzu+UDR/rVhvkNj9TXAwohR4dvnrE=;
 b=sVDQ93Mv0O2fzzgZORBD019HTrTMlj4BKC6+ZzjlnSuXNJxBP2H5cr6TD4+131vBpM
 McxPLb243TX4SYvNnYDpZyaVsrmWWvvbG2QEc5yHBScuD8To/WmgIPKmPbwPs5mrCt81
 zvvbxnS6fg3tqj8IRlA9VJRYO86uVgB7VGtZMQqGrmElnyBeW47EowaWLSlJzReERnt3
 VX1WOw/UdHgAsH9I08f+/wmvuXNHrfLkH0VLFpeKyRYYEcwbd1qeUO2L0iBQF8zf1sIi
 FzmlJjert3MozbrY+8qiuS4SlrzzkxxjIq9j+El0jWCq0tqkarU8gTR3B4zQpBdbcv1l
 7L4Q==
X-Gm-Message-State: AOAM532Gmy/R7x+Yly4bXJbsKN9ApxbV2wOXjxCmjXb99AwlflD3zrgX
 +7RzdfOhmX30eHBFCU3uf4nJMdcRGaEYRw==
X-Google-Smtp-Source: ABdhPJx78pCzk/Xtnj8j8Ex6RVIjhFC9kcK7pXQ9jfSzYzRQcHCvC7WtkkTVdqyHlSqbEsXsANyRmQ==
X-Received: by 2002:a50:f744:: with SMTP id j4mr1502990edn.133.1622130814586; 
 Thu, 27 May 2021 08:53:34 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com.
 [209.85.218.41])
 by smtp.gmail.com with ESMTPSA id fe20sm893734ejc.108.2021.05.27.08.53.31
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 08:53:32 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id b9so795991ejc.13
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 08:53:31 -0700 (PDT)
X-Received: by 2002:a17:906:dfc1:: with SMTP id
 jt1mr4541325ejc.473.1622130811560; 
 Thu, 27 May 2021 08:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210527135941.7634-1-mario.limonciello@amd.com>
 <20210527143548.GA32170@lst.de> <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
In-Reply-To: <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Thu, 27 May 2021 09:53:20 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DmGp04Mu03_MKP8iCZFH-UtxbGG1nvW7WE_P1MSKmTzQ@mail.gmail.com>
Message-ID: <CAHQZ30DmGp04Mu03_MKP8iCZFH-UtxbGG1nvW7WE_P1MSKmTzQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, 
 david.e.box@linux.intel.com, Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, bhelgaas@google.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_085337_120330_F9B00F4E 
X-CRM114-Status: GOOD (  23.99  )
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

On Thu, May 27, 2021 at 8:44 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 5/27/2021 09:35, Christoph Hellwig wrote:
> > Adding Raul who has been asking for something like this as well.
> >
>
> I thought I already included him on CC.  Sorry if I munged the email or
> something.

I did get V2. Thanks for adding me. I tested this patch out on an AMD
platform that doesn't use the PXSX name and it works as expected.

Acked-by: Raul E Rangel <rrangel@chromium.org>

>
> > I'd also really like to move nvme_acpi_storage_d3 out of the NVMe
> > driver.  The Microsoft document that the original document references
> > makes it very clear that this is not NVMe specific, but also covers
> > at least AHCI.  On top of that the platform simply can't know what kind
> > of PCIe device is in any given slot.  Last but not least this will also
> > allow us to add quirks for devices that fail to properly mark this
> > misfeature in the ACPI tables.
> >
>
> +Bjorn
>
> Back when this feature was first submitted, that was actually the
> initial way that it was done, but Bjorn had preferred to see it move
> into the NVME driver directly:
>
> https://lore.kernel.org/linux-nvme/20200625173053.GA2694537@bjorn-Precision-5520/
>
> Bjorn, are you OK with this coming "back" to PCI based on Christoph's
> comments?

Just to add another data point, we currently use StorageD3Enabled on
PCI SDHCI controllers:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/coreboot/src/mainboard/google/volteer/variants/baseboard/devicetree.cb;l=504

I would be fine doing that refactor in a follow-up patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
