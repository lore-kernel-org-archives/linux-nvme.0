Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D90DC00A5A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 22:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScEkSv/4ujt+FscJGahMwM/oQgqzcSsBVgCxU70QRJI=; b=AaMiNaS0wqzIaeOrvNS8mmE0Dt
	YwfSiTpyfn2ojHnTXASs4tB2YWooySWZDV7YE9kT0NlO0XyYDueUxd+BHxxg1leqnZKvrfmo0WkIa
	NDBxFF/p4y+q/PpvgEhEKp8q1SfxEU+nkwAaZh1Ust/5WRLz29c5cNcHyWNav/2qD4rr+3OOspQpX
	hcpbc8nkXt+my9wv1ZwNMUc476a1ZcsJCN7/Ad8c8TxfQQG/5tfoJpb/DvMFF8gqm+mZpLSF9peHV
	l+hlxsKwaOCS8juotX6dqBKNUUAzQaAekfDRsYAeltJUBEE/HiV9HAlZCzfoGDV87e8Yx1VjTZus7
	zOiFQNXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHuTX-00G5jd-Db; Tue, 17 Jan 2023 22:30:39 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHuTU-00G5he-QO
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 22:30:38 +0000
Received: by mail-vs1-xe31.google.com with SMTP id q125so22126346vsb.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScEkSv/4ujt+FscJGahMwM/oQgqzcSsBVgCxU70QRJI=;
        b=g2jwoIxQwdTnr1B7YJPOxcb2LNHairUXX0OqXhUcefSUqfesJfyBh6TTKdZh2u/frr
         btO0PTYoDQPJuS1xetwC9tGF45q7xFo8K/czu2UqDUjOM5OPHWVkW/YMHlN/AkTRYQJ4
         NMOCD1DNUSXb/N07F+oIjlhs4p8j3Zb9YsAU+n0/Gt1R+PDRdr5E6zP7MJUcXC3Ukjuh
         yAqgC2od1nSX98bQRUs7rndYvCGOOwmIS8v/7raRWbYykEwv8WGVQUb2hyXYLbeR4R4/
         NQbmbUX1HjuteCKPj4XZ+/dOnefbi7/2I2+ij8iMNJlsEA7JjGV2J2LMUN61elv3nEzA
         wKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScEkSv/4ujt+FscJGahMwM/oQgqzcSsBVgCxU70QRJI=;
        b=I8pC94tnllSVuY+nw1r5eCL16+5nyDjD95wlcTE6tpLl9eh7/nGFnrm9ju5Qbl5BZq
         Sd++k9kf/gNmp4YQpiDS92TV7rrYVMzqGua11a7WGtAC6UUcFTwTr0aCxXmVb6smBH2n
         /pfpcTt29bmY71S5Udu4aIfuHVZ49sNuJ1fU0hBqEg+cBlvsHiJMGGjHryOMYcrfFP/Q
         JnPwCNM7MVRPl89h8utPKmcM6RsYd+ZMGZHdx3oU57L4AgEiAEt3pw97EogJj/QtKBAc
         NfPOjGM5yL/0mA09te8L5nszEBj8juldDKrWl5843htgxtjTo51Upta6IpGlPFYwRlnO
         rwQw==
X-Gm-Message-State: AFqh2kp+kqOFy78Q8qd3J6e6B29xRCas5Szd3cn0dlNRtq43oZ8Dw0ax
	lQQuwLRucz9olQDLUFY2gPkq0l2rVM/hPrGtqcay3A==
X-Google-Smtp-Source: AMrXdXsasxzFes28B36W71fU5Iue+c6SDhtfvo6j1Ld/ub9DRIvDly3xpJu8wO0cQ3K8NP967lAk53nFxEnNJD9i4tI=
X-Received: by 2002:a67:fb42:0:b0:3d0:d3fe:3d48 with SMTP id
 e2-20020a67fb42000000b003d0d3fe3d48mr557188vsr.32.1673994631663; Tue, 17 Jan
 2023 14:30:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
In-Reply-To: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
From: Enrico Granata <egranata@google.com>
Date: Tue, 17 Jan 2023 15:30:20 -0700
Message-ID: <CAPR809uYp6vGvCk4ugWOjbmd13WTm8fRg0f2Mdq3pxj6=d1McQ@mail.gmail.com>
Subject: Re: Virtio-blk extended lifetime feature
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, Jahdiel Alvarez <jahdiel@google.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_143036_864370_6589EF66 
X-CRM114-Status: GOOD (  17.65  )
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
I am going to add +Jahdiel Alvarez who is also looking into a similar
issue, and also I would like to hear thoughts of people who may have
worked with (embedded or otherwise) storage more recently than I have

One thought that Jahdiel and myself were pondering is whether we need
"type_a" and "type_b" fields at all, or if there should simply be a
"wear estimate" field, which for eMMC, it could be max(typ_a, typ_b)
but it could generalize to any number of cell or other algorithm, as
long as it produces one unique estimate of wear

Thanks,
- Enrico

Thanks,
- Enrico


On Sun, Jan 15, 2023 at 12:56 AM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> Hi guys,
>
> While trying to upstream the implementation of VIRTIO_BLK_F_LIFETIME
> feature, many developers suggested that this feature should be
> extended to include more cell types, since its current implementation
> in virtio spec is relevant for MMC and UFS devices only.
>
> The VIRTIO_BLK_F_LIFETIME defines the following fields:
>
> - pre_eol_info:  the percentage of reserved blocks that are consumed.
> - device_lifetime_est_typ_a: wear of SLC cells.
> - device_lifetime_est_typ_b: wear of MLC cells.
>
> (https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html)
>
> Following Michael's suggestion, I'd like to add to the virtio spec
> with a new, extended lifetime command.
> Since I'm more familiar with embedded type storage devices, I'd like
> to ask you guys what fields you think should be included in the
> extended command.
>
> Thanks,
>
> Alvaro

