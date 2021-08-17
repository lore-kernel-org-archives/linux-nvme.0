Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE050C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 14:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E6F60F14
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 14:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80E6F60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZuQ42vVLN99qNNx8QORBGplM0hp6uHV7sjcNFlPoIGw=; b=hPapPT9QTdWBfh
	kQBRDbXKiWqnkjvoE0oXNQrhi/DWLww9tIZl8wioA6QgGyfqfOVpkVY+CRwDXDBbb8Z1UW2sBdOaF
	OXRTFCPvCi6rHsgolb1Zb1WRj3F/8fj94PN08RaAYGyLWLFETOghjTP18OBERDv3OZhDWGRdh8okZ
	bVQMwaPgpAv3nsFDAP3P+9IBeCdS/L1c5vomQSang66EbithsgopVpbj9gLgrH7arbQTf/7QAdnK5
	Ac+7AT64fZsFWpVGgxLWKKT/SPMYE8skgO7y7yNj8XmxB50mDqrQc4ywm4ffNJTMHXTD6iqNFS8zv
	xhi+Ijz1S1j3bmkIPLXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG0Io-002i2h-8T; Tue, 17 Aug 2021 14:42:54 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0Il-002i1l-Ji
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 14:42:52 +0000
Received: by mail-lf1-x12f.google.com with SMTP id i9so21093916lfg.10
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IYqEXJfiN18yCZI6p8+AKI7fLyyfIF/2Rhy4MgWxORs=;
 b=Cgp4XiI/ioCeNTwNFXQjYKGi8WTg8i/ZA62xg8W1eygB/LANHDdvZYsFESebJx2ZAc
 Vargn/+b9VLuUwubXGGnlicEBibS6etHatqnaIU46lk8Nq4ropCtsNzo8bJysznslVR/
 wxrsfuZgKKLdz9lgV/gyyFiPtIi4v8V+10nDlf7NMCO+44d/2+1PPh90WTFfpJKbOmGl
 ljZkn5z+W5MYjMdGbe4Nl5SivKnId+8q4e5yaJF0d+uINN/2D2+AhT+2iYqLyVZcTl3n
 vQGsm5l8HGzrRuV1JEUYDn8d1QuhzCYgcUEdGYERT0cWlFGVVOUKaQrHF8eE813oKSvP
 EfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IYqEXJfiN18yCZI6p8+AKI7fLyyfIF/2Rhy4MgWxORs=;
 b=QyegOxeGc5L0ySOcbjk/64APPQs8duxHN9hWeair71UEN05zgoK62KFVjdA42QO+IE
 QqX7ZTOy/BO8i6LMRUIyFUol5rsyUNNnGyS/s+HYeSKgdeQlVYw+Hrfvtx/dSF1tHL+v
 j/S1chLUuuO3Gq5hmXjsY3Btmjx1Os76Td63fUG2I123V+odO1ejnX8f0xydr2q3YLBG
 UBSgdrGBUY/KxrOAluiB6eI5ia1O4hdDtT7tEjwDrtuxrLnhrsF3IWU2dIgD5XPBxFXP
 41OAr3BuRW5jEWh4mWVYpzHakSuZhKN/2TjrZ8JnUwN0/OK4SYA812OeitT0zVAiA+cG
 odpw==
X-Gm-Message-State: AOAM533G+/YilbtSZ9X01j5AOkJPRVyNCCB9Zq6mO5KBVPy36+PMDd6p
 afy13BjJPbuHtuRv7ovyZuK1sofQxwevYbmhKDo=
X-Google-Smtp-Source: ABdhPJzaMq7CWUOoMolITqe/TuYuwS1QvR8N16pqlMH4rqZKY4UMF98ZToXGodeF25valw2giFNpcKQdBw8IOwnP8Gc=
X-Received: by 2002:ac2:5b9d:: with SMTP id o29mr2734522lfn.26.1629211368980; 
 Tue, 17 Aug 2021 07:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101753epcas5p4f4257f8edda27e184ecbb273b700ccbc@epcas5p4.samsung.com>
 <20210817101423.12367-3-selvakuma.s1@samsung.com> <YRu02+RgnZekKSqi@kroah.com>
In-Reply-To: <YRu02+RgnZekKSqi@kroah.com>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Tue, 17 Aug 2021 20:12:37 +0530
Message-ID: <CAOSviJ3tziyBmeP5Op_NAPhyt5vDprjPLaGH8Fu_rbK8UcQYPA@mail.gmail.com>
Subject: Re: [PATCH 2/7] block: Introduce queue limits for copy-offload support
To: Greg KH <gregkh@linuxfoundation.org>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 dm-devel@redhat.com, kbusch@kernel.org, axboe@kernel.dk, 
 damien.lemoal@wdc.com, asml.silence@gmail.com, johannes.thumshirn@wdc.com, 
 hch@lst.de, willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com, 
 mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org, 
 snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com, 
 nj.shetty@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_074251_729018_CCA48C36 
X-CRM114-Status: GOOD (  11.61  )
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

On Tue, Aug 17, 2021 at 6:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 17, 2021 at 03:44:18PM +0530, SelvaKumar S wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> >
> > Add device limits as sysfs entries,
> >         - copy_offload (READ_WRITE)
> >         - max_copy_sectors (READ_ONLY)
> >         - max_copy_ranges_sectors (READ_ONLY)
> >         - max_copy_nr_ranges (READ_ONLY)
>
> You forgot to add Documentation/ABI/ entries for your new sysfs files,
> so we can't properly review them :(
>

Sorry, we will update the documentation in the next version.

Thanks,
Nitesh Shetty

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
