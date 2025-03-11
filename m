Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5293BC28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 05:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=; b=sySiDEhh64jkaPnnEonWpaVeuZ
	BjXIMkh0hxNv+lbxfQD7MJ7TV8UwMJRBE029IEFl90SUDbFdM/ui99NecVw5PBCaVi1XeVTopGmRL
	8ZmbYidWc4fUlh1VDJqbAig933uWKIP3rjMCjeqNscSyHZr0t/XatCwDmzgnq5Aq2Wq6JTp75SkXF
	mQJywIsFmzfze5pPTM+qom8rfFL3StLL0+edueoPJg1+M3JUSLXtO9Lvjikfuf3THgO6I+67KALWq
	CtDsiJFFEnFRnBDwXrt7RUIeHFbLmUKy7/7pCn1mi/dRKgPgaxg4uuybIYMrpvp6V89hre+eSt0PA
	3naOmL8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trrn9-00000004cro-3mGf;
	Tue, 11 Mar 2025 05:04:35 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trrlb-00000004cdt-0XO2;
	Tue, 11 Mar 2025 05:03:00 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so7720863a12.0;
        Mon, 10 Mar 2025 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741669376; x=1742274176; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=;
        b=X9M7af3hUpnQd2v67IPP3NyO889qRXBOt4qer9THpuPoHrUW3onpcy69MRyIX3vgfE
         nMtsko4o5pynpZPL+NZm+s0aT/s1n0+pEreBsS9t1csrYLORfWBApOfKjOm0HWHLhqVU
         FA4SB7XL9nzHNdQ6VAlvTr6xf79Vfskx594/pPiTUglHRfD+S479ARtaj2y7134sEiOb
         frBEspV6MPi5DY8Utr89CFtiXIoWt61NYqZFsf6lPWk/sIloeSeMfiZNTevTe8+MvrQ8
         OsjxUGv4DAu/UGdBOt2MO9bhmqF3h8nEhk+/YnwrKqaJHOXNAoZkeaYtdHRUqNxbYthx
         1EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741669376; x=1742274176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=;
        b=CJdarwFpr2Ym2KgF0a37aQL+9MKwnmeIPYM6dFw++l9Cbf/lDkDO2mrl9nUo0RSSvB
         f1vEQYeBd5X/TNMWzXXjnnD4vYfeaiAyFs3wBTZwpJB6nhpn5Fc73vA9Pnhh7x9dIRMw
         5WlvIna3Xh+wVRIIxlMVwDpEdCFrBIxEycVXrM3mDzhWg3ioANoX9WKd0ovPl44Wfhhf
         Q1Ow82NDaf4cKgvSBvTFgUVRJrMJEWuw7RpqFDbEFRso07deIIr5S6cpHIM8GRuML0zA
         yreLenZYV4Debph7ebLPf1j956A+ernkzZCfiSQ51biieeJ8HzhxbsPK7X2C8rEshCrT
         c5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPy8buwJC4KohnLwUrDbJYzcR7EY3B8DxiX2WP6Q/9FKW7lcoJEOm46XdQNLsAF8VUVGkKXNDcx4ApeQ==@lists.infradead.org, AJvYcCVT5ck5j9a0DP3Miv1aRRT8kD9u4Qlcj5Tw76qh0QsC47pNO2ZghUFTiom9Pt2LDP9I1cQ41omG0NbD24BSnCj8@lists.infradead.org
X-Gm-Message-State: AOJu0YzVRNFu8IP48AOnVLUWOR1wzdeHqvSNvatzWZGJTcL+imK9cjoA
	Tm86CrD+SDKkD1utcSWP6fl0cPcS3oCusWiPdOyx8pYXd/OjIRXj/y8maWI/lAdcK3O9zWdbTz1
	9DDtt6n/G2XGn/7qtzhEMjVRbyPv10A==
X-Gm-Gg: ASbGnct2bvTCMjfXmj3p15dAQ1De/J2gpHQ8CU5AaYHBREB8ugqqrDEPeLOWqTgo4U5
	vO5nJWRD2r83oJlAnHIFNvXB5wgArcUQ98xaJKkFI9Fd8EMc16gx6Yb+Koc7dTHn2zEjPHd6zOK
	seNsnbcW7ubTCmPsh0PzubZzGM8A==
X-Google-Smtp-Source: AGHT+IE7p9ESJhaRtmTdHGCk8dKC1MDYNTTHcp542UMCynAJicglEY62j02PsiPON63nvymsVjYo1GJqTYgydaJ1MSA=
X-Received: by 2002:a05:6402:13d0:b0:5e5:c5f5:f5b with SMTP id
 4fb4d7f45d1cf-5e5e249af7bmr18994497a12.26.1741669376163; Mon, 10 Mar 2025
 22:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com> <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Mar 2025 13:02:44 +0800
X-Gm-Features: AQ5f1JqbCkxhn7T9fgxWWXH1RylAmKuYJRnbUWmBaNKkk8A2xfV5IxO-QOVV2tg
Message-ID: <CAJSP0QXZQWSVV60SWDey7i55VqAw7H+W9mQZ1uQyeOLK4TounA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Alan Adamson <alan.adamson@oracle.com>, virtualization@lists.linux.dev, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_220259_167729_3C044EA1 
X-CRM114-Status: GOOD (  16.17  )
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

On Tue, Mar 11, 2025 at 10:42=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") modified the evaluation criteria for the third argument,
> 'ioerror', in the blk_mq_add_to_batch() function. Initially, the
> function had checked if 'ioerror' equals zero. Following the commit, it
> started checking for negative error values, with the presumption that
> such values, for instance -EIO, would be passed in.
>
> However, blk_mq_add_to_batch() callers do not pass negative error
> values. Instead, they pass status codes defined in various ways:
>
> - NVMe PCI and Apple drivers pass NVMe status code
> - virtio_blk driver passes the virtblk request header status byte
> - null_blk driver passes blk_status_t
>
> These codes are either zero or positive, therefore the revised check
> fails to function as intended. Specifically, with the NVMe PCI driver,
> this modification led to the failure of the blktests test case nvme/039.
> In this test scenario, errors are artificially injected to the NVMe
> driver, resulting in positive NVMe status codes passed to
> blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
> batch. Hence the failure.
>
> To correct the ioerror check within blk_mq_add_to_batch(), make all
> callers to uniformly pass the argument as blk_status_t. Modify the
> callers to translate their specific status codes into blk_status_t. For
> this translation, export the helper function nvme_error_status(). Adjust
> blk_mq_add_to_batch() to translate blk_status_t back into the error
> number for the appropriate check.
>
> Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding cond=
itions")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/block/null_blk/main.c | 2 +-
>  drivers/block/virtio_blk.c    | 5 +++--

For virtio_blk:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

