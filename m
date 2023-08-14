Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99953C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3UJyFzkhfPV1LXyzB0ge0qlS62RRiQrpMwsiRYTQDRI=; b=bz8RbfAGnULMDIcwM2dMs/s/bj
	Y5RdIzD66/Po8txx4RNe3wCf/9mLGvG7sDkCgxggAWQPkEZxIqsKRSPogq59OJuGzG2Zx0VkJP2rm
	j1L2jaNhc4OVOssTUDFPldZ21AZdTaloWfUOunjxS/BIGarYNhTcuprQ84IfHNGwaaqi0gJvIuxL6
	7W2RR1cZR46EbxOkHpTemTH4BNXdJGA6Z960XWGIHm4VNzJ5BszCZFkVxprvROI83xHPi8w/ospf+
	6PRR5eqyPjXH/YKppbnkGFHxcacF56j1D+NBSAtV8BN7VWOzjLMa5a0KQxeqUfAfXUUrNAt4dd1q5
	USZIZnXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVatl-00Hb2s-0j;
	Mon, 14 Aug 2023 16:58:33 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVatj-00Hb1j-0P
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 16:58:32 +0000
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9cf1997c4so3881781a34.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692032309; x=1692637109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UJyFzkhfPV1LXyzB0ge0qlS62RRiQrpMwsiRYTQDRI=;
        b=FDNjxoV6HizyNME4qceOyz2W/T/QvxPUaeKiIaQ5S2HaIiL+mCb5lwmFEqCKAXCfNC
         hF45qfgBBL/md9Xsf7IYuuqBRy8X8CUaK08JDJ6eXBGVA8kUIOltMVr7G1LMW0zlwVUD
         0U2Jq5THfYuI4WsaWaLl3g/YI8wEFKWf+uHsvTpWWM3i1BOpPiyHsrW7ALDkfsNv6DTX
         8l8ecOKJrGy/qVCNP8+95c96htmtisRcfZmhYjvWsBRaToCisEc898dWFyYLHeEdVsKS
         nk71Rg2gxhsYhI1yHLGmHjv/txtoYtA+pttVNlloNW7utArWjbcdjDTNPDKI31KHuDHH
         ck6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032309; x=1692637109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UJyFzkhfPV1LXyzB0ge0qlS62RRiQrpMwsiRYTQDRI=;
        b=SIB31Ior1iD3l2+59JZpn+V6VrCuv6mQFPIj50E6yA9s+lryK94nHTHPQkWxRX5XtU
         REFx7jD/HDKEq396tnFsvtgjfTrH9j001jWQTHtF6iOTr/WDRtgXfaqUZWL6ywVuGSdS
         a4iMWwgC/HfXEz25oJOhos71tey3FxCuI75uNlA0XhuqpevAK0jKnUYbsE7MDbYKzcpY
         st2zJazYQx0P8c6cwvYjxU8bxtPAeoqAy+idiQZQUO63ZOHEp7K3V2tRlICKA0LT2KnY
         4c1qRFL2Pc7/yrJ2U2As+VuCmCQ8Ni4mrlUihhAN0e2Yo0bzwToK64+kyyk6MkRNluym
         wDAw==
X-Gm-Message-State: AOJu0YwAyDx3bm/BQe4mZKy+QyvX1e170ETbPt04+OjGWpz8rFjaFLHy
	wEVDffeQXxJRlXQ8VV5qRLoYodBUKvuIUwpvPxbhQTlmabo=
X-Google-Smtp-Source: AGHT+IE9LDZ83v2hgug7emDF5KyYh5EtftbM06X5OK/zdRBDKO/Jg4fRYrCeL75t5wx91fwlfKtCCIuFBCXTW1QrU9s=
X-Received: by 2002:a05:6830:4dc:b0:6b9:bd9d:e333 with SMTP id
 s28-20020a05683004dc00b006b9bd9de333mr10451524otd.3.1692032309587; Mon, 14
 Aug 2023 09:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230811105300.15889-1-nj.shetty@samsung.com> <CGME20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6@epcas5p3.samsung.com>
 <20230811105300.15889-5-nj.shetty@samsung.com> <57558d7b-4444-b709-60bf-5a061cd6c3e9@acm.org>
In-Reply-To: <57558d7b-4444-b709-60bf-5a061cd6c3e9@acm.org>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Mon, 14 Aug 2023 22:28:18 +0530
Message-ID: <CAOSviJ13RJd4gTL2dzXrijXLaPUCB-pGG6x+_8ouW=7REO6e7g@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 04/11] block: add emulation for copy
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Vincent Fu <vincent.fu@samsung.com>, martin.petersen@oracle.com, 
	linux-doc@vger.kernel.org, gost.dev@samsung.com, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_095831_162499_49E0CE49 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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

On Sat, Aug 12, 2023 at 4:25=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/11/23 03:52, Nitesh Shetty wrote:
> > +     schedule_work(&emulation_io->emulation_work);
>
> schedule_work() uses system_wq. This won't work for all users since
> there are no latency guarantees for system_wq.
>
At present copy is treated as background operation, so went ahead
with the current approach.

Thank you,
Nitesh Shetty

