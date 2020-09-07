Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D67C43461
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 11:24:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D0E21473
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 11:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2LjLrwnU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzUc11E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D0E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H0aOhvxynKxu8tastdjvnYknDxogAgrs9qIV9iRF88g=; b=2LjLrwnU5EvESHGVA2tNtylyf
	dwiswPL3iPY6EyvsEpL7FcHP1/hDkJsIDUEnfSaMFanB+Ua1QclOfANueLGTNhYK3MqhIiCZHYM0P
	yfi3UEKNc6c3o8T7huuz42ayoPPqyqe7CNMsDSOSRylmFc5RnDOXjP1JSw4hXi9d9cTXQWK3n+d0X
	jtWcxuTvG71PN2TULEYQR3MxkWnAo60VRA0tgcXj6n+VNiYP4ZLSiQnXoaQK0gQwcxH5aduxKdUFO
	GNSw+QuZuqrNohkyxeThyfIXHbLL3zietUX6M3eRk4JuZnTuBoi1XZQFc4QykVP77R7z/meRtR0MT
	17z7855iA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFFFz-0006Fc-9s; Mon, 07 Sep 2020 11:24:19 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFFFv-0006Ev-ED
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 11:24:16 +0000
Received: by mail-wr1-x443.google.com with SMTP id m6so15456802wrn.0
 for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2020 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bNFvxhnA0NnzUC7lrNJrUKsLLmz7/HC2qOyPmU9vUl0=;
 b=uzUc11E0gok7gl6O5NNy2E0O4w9nQRfSU0c4U5Pb0vlWerd2W52/oGEaCOOf21VZvz
 qbUWgc2jjvIpozWCfp5pFMHduvVHPw9c48sqGnfyIUUgJG8BtPryhVoO1vbQrZt1/2t5
 BGv5rA9Q15nMiYW8wLCBNm91gw329WdwEEbDzBSo09EzeCoL4z5eMUY/Mab/sG1oaIfF
 7eTtOIxJhimNEA8xKA/QRtsNsbmswuWJftIDEE+4nua2bEgR1PPGWBqjJRJd5dr51Jy+
 m2vaxKwhT9k2SZY3Dh7QIltaGj2udCVRKw+lhS67Vb9tGQFVsD564QdWXYAzA5u+OU1S
 EBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bNFvxhnA0NnzUC7lrNJrUKsLLmz7/HC2qOyPmU9vUl0=;
 b=V8GbeGHlKWkCa2KewIQ57+WNl1yoNpFcWwg2KHXqf7eHDmYgmZOopOnfFZSdFeMlT6
 R+93gx5fiurtxqOucqi6BQ4DHnmOu6ojsDrvP891Nxm9GRoyWPsqKKayztIg8wdH+S87
 BkofRBHR0yCyjypfJpAkoLOTJMd5Qe93J5KQLN+9sVesNmtc5Qd0GWEIVBtG4QAi5hEc
 fYsgZ11W2bkowEI7ozsI/aas4CFb72JU19Dr74JBE8BuV2JCN0iiKJbQdwGwb0Z8Wpy4
 2y7t0fjFEl9tWb9i8+pCC09LDMfQq/JymrcOTTPeuZXx24mRhPxMYEoz21EmKlGOn8EA
 VCOg==
X-Gm-Message-State: AOAM5312wpUD1pvGsq0obw+G2ptcW8Hwn8YfeABHE3d75q3VpjbKyg41
 xXYvbBqQqSQIv16WqDdoNbry28vPBg15nrs9aBg=
X-Google-Smtp-Source: ABdhPJy8sgbC/sJ9Rm/BrKqEAwV59GWXOOZ8VFQbp18vsLtPw1wPlO3O6XyZjZZQOJ5PDx5K8cjviVYWAdsvQNWMSFI=
X-Received: by 2002:a5d:630a:: with SMTP id i10mr20495093wru.137.1599477853937; 
 Mon, 07 Sep 2020 04:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
 <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 7 Sep 2020 16:53:47 +0530
Message-ID: <CA+1E3r+sN8n6-ibJ1v_S5HEdfhbJ8yAYTm5ja=0M8ng2ujLZ4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_072415_583207_20D9AD51 
X-CRM114-Status: GOOD (  21.90  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Selvakumar S <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/09/07 16:01, Kanchan Joshi wrote:
> >> Even for SMR, the user is free to set the elevator to none, which disables zone
> >> write locking. Issuing writes correctly then becomes the responsibility of the
> >> application. This can be useful for settings that for instance use NCQ I/O
> >> priorities, which give better results when "none" is used.
> >
> > Was it not a problem that even if the application is sending writes
> > correctly, scheduler may not preserve the order.
> > And even when none is being used, re-queue can happen which may lead
> > to different ordering.
>
> "Issuing writes correctly" means doing small writes, one per zone at most. In
> that case, it does not matter if the block layer reorders writes. Per zone, they
> will still be sequential.
>
> >> As far as I know, zoned drives are always used in tightly controlled
> >> environments. Problems like "does not know what other applications would be
> >> doing" are non-existent. Setting up the drive correctly for the use case at hand
> >> is a sysadmin/server setup problem, based on *the* application (singular)
> >> requirements.
> >
> > Fine.
> > But what about the null-block-zone which sets MQ-deadline but does not
> > actually use write-lock to avoid race among multiple appends on a
> > zone.
> > Does that deserve a fix?
>
> In nullblk, commands are executed under a spinlock. So there is no concurrency
> problem. The spinlock serializes the execution of all commands. null_blk zone
> append emulation thus does not need to take the scheduler level zone write lock
> like scsi does.

I do not see spinlock for that. There is one "nullb->lock", but its
scope is limited to memory-backed handling.
For concurrent zone-appends on a zone, multiple threads may set the
"same" write-pointer into incoming request(s).
Are you referring to any other spinlock that can avoid "same wp being
returned to multiple threads".

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
