Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488AEC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 01:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ESfjQ0jWiBunyG2uBniDMtDH4nMEu78Nkty9LDM7sw=; b=j/OKjtNzwfEw0xLJ5yezGfsROO
	vOT5cjqsGo2X89AfQzWmdWNGMj/+AwcSgtYcXOdsnNpDITPsYCQ+IKFFc3TNmyYvuv4nZ4AGAvD17
	b1KUr67BuNHmhuCG9YFeX/78LEAeHlFmnfHgzCKfZALpYrW7FZMtzX6a4hXykcr+BR110q2G2ca8i
	T83O/L3zOEj+WbtdWqo5Q5Z6ojXoU/CxuLdru7BYJXO/EIG5INzyEfMtBDjp3Vg68vc/Nc7Ko0/97
	vVn3VEY9HgDsAzxZhLMznnpSM1B1lvYE5vyohyVO+apg1RuDGZ0i7ZyXLruhU5UVGeTLaYrxdYcgq
	bPzPfKqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNjp0-00FE7q-3B;
	Thu, 11 Jan 2024 01:25:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNjoy-00FE4s-0U
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 01:25:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704936319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ESfjQ0jWiBunyG2uBniDMtDH4nMEu78Nkty9LDM7sw=;
	b=MwkgIMCJVxai1XbfUYD5a0o6s8AvXaErFq28QnaFugBjcrZZRJaqjskaRi6gTLbSM/qgfN
	bawCJjt9o6MICB/7gPlcNCrNmMHI98bcsWfrpEcbtldBkANmtJSJCvEQsB56/K+mRMiHN4
	LR4wmaSEia4RSw+SbwsNkVHR3EDHGdk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-lBvX26xSO6Cpi5eDJ8uA5Q-1; Wed, 10 Jan 2024 20:25:18 -0500
X-MC-Unique: lBvX26xSO6Cpi5eDJ8uA5Q-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso2691190a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 17:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704936317; x=1705541117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ESfjQ0jWiBunyG2uBniDMtDH4nMEu78Nkty9LDM7sw=;
        b=Stuqd220iAInv+lz4QwkbZwmeLQG1WnFmhPb23ZwbU4iB11wRh+ZQV+MJZfENnfZY0
         YpELpjnwQY/fPQ033YqhtOrhMdAk4iujPE7f6b5WSZgRdh8HDNE4X90emLEbSEGrj3B9
         +jfwhTs2O8tPcSrHAnSAo9XwJILooN3igZMvQtASfYkeK92WU1wLUIriG7vaZ8op7v10
         JFFcDYHXhDgpnujdXav9lzBQAM2kVNfZcfSwhgHNP+y3xHkSaenjdQlWpdwAPOjUvab0
         lY8gKXfE2UJ0oZL2JoPJJ04KpRM4OrpL6KIW7LPDj4lJlge2kdMFJfst/aTuxKQ8Q5CO
         gDog==
X-Gm-Message-State: AOJu0Yzo8paEAD9BH0BJ4shLdOjRCh6OXDnosv1mTE+2fw8S3IDQTBIp
	wslm8z+mUwlYA7drg5egvznS6b/nGlmdUvQWpkB8tJhfjpdAjIssgJ8EkX7GPm5aZqi73C/yDdD
	/cgDMdlx6l/HJKOFOqZGnzi3JvaZwrh0potfn3DBRSSTzX70EjuZT7yywSH26KQ98
X-Received: by 2002:a05:6a20:1449:b0:19a:4fac:3e52 with SMTP id a9-20020a056a20144900b0019a4fac3e52mr132620pzi.106.1704936316962;
        Wed, 10 Jan 2024 17:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtPYYA8HYaVG8BNNUf2wiSlku54LRcIV6lAA2JAekRYHR9QOTY0DX907K3pIDfg8Ow+RkrC0nHuhxF9OD5bYc=
X-Received: by 2002:a05:6a20:1449:b0:19a:4fac:3e52 with SMTP id
 a9-20020a056a20144900b0019a4fac3e52mr132613pzi.106.1704936316678; Wed, 10 Jan
 2024 17:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20240110035756.9537-1-kch@nvidia.com>
In-Reply-To: <20240110035756.9537-1-kch@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 11 Jan 2024 09:25:04 +0800
Message-ID: <CAHj4cs__ObsuA_hXHeSRPwHy-uSc558sxQy-jD2J85gQEg4BXw@mail.gmail.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	shinichiro.kawasaki@wdc.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_172524_256584_1CBBFEBA 
X-CRM114-Status: GOOD (  16.82  )
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

On Wed, Jan 10, 2024 at 11:58=E2=80=AFAM Chaitanya Kulkarni <kch@nvidia.com=
> wrote:
>
> Trigger and test nvme-pci timeout with concurrent fio jobs.
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  tests/nvme/050     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/050.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nvme/050
>  create mode 100644 tests/nvme/050.out
>
> diff --git a/tests/nvme/050 b/tests/nvme/050
> new file mode 100755
> index 0000000..ba54bcd
> --- /dev/null
> +++ b/tests/nvme/050
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Chaitanya Kulkarni.
> +#
> +# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout fun=
ction.
> +#
> +
> +. tests/nvme/rc

How about restricting this test to pci only? just like nvme/032 did.
nvme_trtype=3Dpci

> +
> +DESCRIPTION=3D"test nvme-pci timeout with fio jobs."
> +
> +requires() {
> +       _require_nvme_trtype pci
> +       _have_fio
> +       _nvme_requires
> +}

Check the test dev is nvme:
device_requires() {
        _require_test_dev_is_nvme
}

> +
> +test() {

Use test_device() here.

> +       local dev=3D"/dev/nvme0n1"
> +
> +       echo "Running ${TEST_NAME}"
> +
> +       echo 1 > /sys/block/nvme0n1/io-timeout-fail
> +
> +       echo 99 > /sys/kernel/debug/fail_io_timeout/probability
> +       echo 10 > /sys/kernel/debug/fail_io_timeout/interval
> +       echo -1 > /sys/kernel/debug/fail_io_timeout/times
> +       echo  0 > /sys/kernel/debug/fail_io_timeout/space
> +       echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
> +
> +       # shellcheck disable=3DSC2046
> +       fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D$(nproc) =
\
> +           --name=3Dreads --direct=3D1 --filename=3D${dev} --group_repor=
ting \
> +           --time_based --runtime=3D1m 2>&1 | grep -q "Input/output erro=
r"
> +
> +       # shellcheck disable=3DSC2181
> +       if [ $? -eq 0 ]; then
> +               echo "Test complete"
> +       else
> +               echo "Test failed"
> +       fi
> +       modprobe -r nvme
> +}
> diff --git a/tests/nvme/050.out b/tests/nvme/050.out
> new file mode 100644
> index 0000000..b78b05f
> --- /dev/null
> +++ b/tests/nvme/050.out
> @@ -0,0 +1,2 @@
> +Running nvme/050
> +Test complete
> --
> 2.40.0
>
>


--=20
Best Regards,
  Yi Zhang


