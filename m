Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C864C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 03:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YaIEkbUvmBmnvGkVRFuCDWCFMloy3MqNAMsorICZX0=; b=Ul2Xqk4xEvcqcF6hfz23Z0WWqd
	uBT0GJe2vzUbYnttPHaE/UQ8KRuLLPNos6uIgDv9AnPnmt52P2ohlA4e9ADTUKub/bS4zi0PJT1m2
	18ANO9L8xZNnxZDIAbfo+NgGQ4789R01xKAAyuUVlQ8bsVfB3QSHK1cBhhBqKU+SjU/r4X4vbqsK4
	o5jhzueDMNTzYB8UWOG+09K6Z34I6i3WWcWUfh3SXe1aqWJZgM2gi/jAd8rz7Y8V0GanGxRN/NebC
	DHISWrWj9Ljpb7PP+XKPMu9iKKIERrt75qMas7xT61ogZrbvV8Ho93L/xaQC4BuxHXVkD2MOzB9ZD
	JGxHWl0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9cw0-00000001uLa-3Wqj;
	Wed, 22 May 2024 03:46:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9cvx-00000001uKx-1VVH
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 03:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YaIEkbUvmBmnvGkVRFuCDWCFMloy3MqNAMsorICZX0=;
	b=N7wDw7Kmo+GfqOb1bK38+JJC/MwRlKyNKyiW5H2o88cQpBsjce1cekId3GrkGtr58tt85C
	/qBGSWrJjQosBp5B+AC8zaBN6wQqlsYomN8zUwuoyydw0tBsDyu1zqyd0mmpxrJG2vgPub
	pquvd7xEdhR+w1PEkgX5GroSOvQ6c9s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-7B0qlu_WNKawRxDnmxL2ig-1; Tue, 21 May 2024 23:46:26 -0400
X-MC-Unique: 7B0qlu_WNKawRxDnmxL2ig-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cf35636346so10404250a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 20:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349585; x=1716954385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YaIEkbUvmBmnvGkVRFuCDWCFMloy3MqNAMsorICZX0=;
        b=Wn2JE99N1bncyc0PxufyEdwW5Cd7SzVsUH2ktwo+4PFncykYP7lsoTdvVK3wnOZkto
         +Lm9pv2ak8mLPz6Znll5N5XrKvBM/wbbRfjVfLGuJg8L2Rv6pdoEIJwfBLOeSM7mP26k
         AfbfIloGWbGIENlFnSeI9ILlmGcIGVig+0b5aCuQXAma/X7vAIXg4rfwM+sUWQwk2+GQ
         IIweOQ++6vIWO8zu+TnZZyj2vnDfHWT2TpG9Sc9hiUYwMLCrx1AFQekOChzSfvW9H/9G
         LJUycBhD9NMPcOxHrUq/uklQn6oXei8MfXo42mhjBaRBQ1aGdB0vHzH6rEFzdpp+zlXE
         ho6w==
X-Gm-Message-State: AOJu0YzLU5dIm6yPFFFczZUJaO8zp9uk4NS8grIUmYU1G6iT7+CTxDYL
	dl4RM9lnZ3VoANnQFKwG6+n41aI/8QMxgaaiaWxz6uiHnllUVOduWk9QPxCLttjUPFciPwqB5Gy
	rCIBQ1RoDIzBwQqgEkhYlPjdMjPMPJNEryWG9cYgwLw6TAaT/mGcY8U4pzuQlgVNEG9KJI1j77H
	/rOFKW5ynsnHAM4YPnrWS8p6f82YlrLDqKVqw0msE=
X-Received: by 2002:a05:6a21:8183:b0:1af:fff9:30e6 with SMTP id adf61e73a8af0-1b1f879c5abmr845685637.15.1716349584916;
        Tue, 21 May 2024 20:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnxA5q6sQySyLYL+QwWfkYzcjWbnxng0WrOIcngYfDAFbWaMN2X3gW7TFzYEQy1OIEC0G45avVxRojwRgxtmc=
X-Received: by 2002:a05:6a21:8183:b0:1af:fff9:30e6 with SMTP id
 adf61e73a8af0-1b1f879c5abmr845673637.15.1716349584473; Tue, 21 May 2024
 20:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240521085623.87681-1-sagi@grimberg.me> <ecb4dc5f-df4d-4c49-94ba-3fb8c3818fcd@grimberg.me>
In-Reply-To: <ecb4dc5f-df4d-4c49-94ba-3fb8c3818fcd@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 22 May 2024 11:46:12 +0800
Message-ID: <CAHj4cs_+roXMOrGacxNbP-G6y6jxSKpAEr1ZtN6BF9Mi26+D0w@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme: add regression test for concurrently
 enable/disable nvmet ns
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_204633_496196_1356320C 
X-CRM114-Status: GOOD (  20.57  )
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

Hi Sagi

Some note from shellcheck
$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
tests/nvme/051:25:20: note: $/${} is unnecessary on arithmetic
variables. [SC2004]
tests/nvme/051:26:12: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/051:27:12: note: Double quote to prevent globbing and word
splitting. [SC2086]

On Tue, May 21, 2024 at 6:08=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Forgot to CC Shinichiro...
>
> On 21/05/2024 11:56, Sagi Grimberg wrote:
> > Reproduce a hang in nvmet when concurrently disabling/enabling
> > an nvmet namespace.
> >
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> >   tests/nvme/051     | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/nvme/051.out |  2 ++
> >   2 files changed, 50 insertions(+)
> >   create mode 100755 tests/nvme/051
> >   create mode 100644 tests/nvme/051.out
> >
> > diff --git a/tests/nvme/051 b/tests/nvme/051
> > new file mode 100755
> > index 000000000000..ddc097310dd7
> > --- /dev/null
> > +++ b/tests/nvme/051
> > @@ -0,0 +1,48 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2024 Sagi Grimberg
> > +#
> > +# Regression test for kernel hang when enabling/disabling nvmet
> > +# namespace concurrently
> > +
> > +. tests/nvme/rc
> > +
> > +DESCRIPTION=3D"test nvmet concurrent ns enable/disable"
> > +QUICK=3D1
> > +
> > +requires() {
> > +     _nvme_requires
> > +     _require_nvme_trtype_is_fabrics
> > +}
> > +
> > +set_conditions() {
> > +     _set_nvme_trtype "$@"
> > +}
> > +
> > +ns_enable_disable_loop() {
> > +     local ns=3D"$1"
> > +     local iterations=3D200
> > +     for ((i =3D 1; i <=3D ${iterations}; i++)); do
> > +             echo 0 > $ns/enable
> > +             echo 1 > $ns/enable
> > +     done
> > +}
> > +
> > +test() {
> > +     echo "Running ${TEST_NAME}"
> > +
> > +     _setup_nvmet
> > +
> > +     _nvmet_target_setup
> > +     ns=3D"${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
> > +
> > +     # fire off two enable/disable loops concurrently and wait
> > +     # for them to complete...
> > +     ns_enable_disable_loop $ns &
> > +     ns_enable_disable_loop $ns &
> > +     wait
> > +
> > +     _nvmet_target_cleanup
> > +
> > +     echo "Test complete"
> > +}
> > diff --git a/tests/nvme/051.out b/tests/nvme/051.out
> > new file mode 100644
> > index 000000000000..156f0687aab2
> > --- /dev/null
> > +++ b/tests/nvme/051.out
> > @@ -0,0 +1,2 @@
> > +Running nvme/051
> > +Test complete
>
>


--=20
Best Regards,
  Yi Zhang


