Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF53DCDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xHJcZu1bgZMSOtJcLmzf/C1viqUT3ZpBLIx/Hxz6KbA=; b=QcKVW/kMo/C02aoHQEqo2Uww7L
	rnGgUIyNhZOSjsznW/gNEggOBlQUNPqGjbMyeIkNYGZq21LoN7slN2Kx8UiXgdxQDTf/cYvrY7unL
	nC8NxnGIJ8BFiYdXwGoMF+B6zhPtCcHHEbuitqPEZXXUd2xGtD/JKINM+K9F7y46JusKHIsfu+Ots
	sWgVp1rhz0a/jTGjFML/F1o9mPBPHfCo/ir9PZJ7eagnn8UJKLYG1HS5z2dIvfCl9bwiOJsV4z5O1
	7tkBJiifNU46cSsECqtSXEHA0lcIL6LDlHq+jJOkhihiHCgpP2kC2EsY74NprTNOVS7jBPKEcujuL
	DyvJ2SbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtNGn-00GagC-0K;
	Thu, 19 Oct 2023 07:16:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtNGk-00Gafn-1R
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 07:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697699792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHJcZu1bgZMSOtJcLmzf/C1viqUT3ZpBLIx/Hxz6KbA=;
	b=YL+HJM4Tr8YEwzlPXEAZ/N679MPgqoHLGjL7o2hq5rJpkPZxrX89Yw4G2KHNSithl5I0U2
	xV2BKqyo9a/mzCuLiIn/DI4BWZYAVnexnj2Dee1Wn6Mhyc9nazgD/Wmz8xjXESl4Ryx6Kh
	tHFFQIEEQPq+YkNygt4KYekfpjPtg70=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-cy6y7uWvNAKCKdxE1N9Pqw-1; Thu, 19 Oct 2023 03:16:25 -0400
X-MC-Unique: cy6y7uWvNAKCKdxE1N9Pqw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e990f0629cso10446959fac.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 00:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699785; x=1698304585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJcZu1bgZMSOtJcLmzf/C1viqUT3ZpBLIx/Hxz6KbA=;
        b=SGL7R1lXAyHos//66Ia7KLbNvflohFV40AonY86Ough7gLbLvW2V2211aPAVHWqk+B
         bB4BocBIHr/FOoIgdh5ikGH2WApUz1hMr1Ep9YOv+g6gPDW3Hoc1zkBqrkMJtmibecCU
         E4pDyi0Si6xpk/m2oXYL42p3lfw98S8/EWFpDpPoRRsQr1ZiyoTUMzYGEVuVqEc3LFxp
         whljBNofj1oU8pRMFuHZX8FJTNiKLJ9/0cU7ugTQpuQvccH3JxtT/lVBNiOVyJ2V207B
         WVw6J8eNw3aHYePFQv8+P3Ls7pgmu5yUjqL5WF92Mov8w9CLMq/KtIKvtLnPOdHAfcmt
         B15Q==
X-Gm-Message-State: AOJu0YzEuivE/3vQBQF29b6GXhosSQWQJREDJieauGJI59AZr0OfedJH
	hZFPsHclWznDBvOD3m3w6UPjeoSDW6b6WuA0l/zpujD4FKv+OFjRVUGYjszQd4/6GI3ccmdNa8I
	2LAesgUMtJpvaFsh23sUOheZEMTEJNff5ux9lUcDwWIc=
X-Received: by 2002:a05:6870:8a24:b0:1e9:54a3:9884 with SMTP id p36-20020a0568708a2400b001e954a39884mr1804692oaq.15.1697699785113;
        Thu, 19 Oct 2023 00:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFctZqZZ+bT7uBFh0uztVUPwCwtBGtBIayvNkFmHfDUpc2UDDf9XigvO//Gh/P1uvkMHOoskeKA/bgOfGRyEi0=
X-Received: by 2002:a05:6870:8a24:b0:1e9:54a3:9884 with SMTP id
 p36-20020a0568708a2400b001e954a39884mr1804688oaq.15.1697699784906; Thu, 19
 Oct 2023 00:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
In-Reply-To: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 19 Oct 2023 15:16:13 +0800
Message-ID: <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
To: Hannes Reinecke <hare@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_001634_587585_1D545089 
X-CRM114-Status: GOOD (  13.53  )
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

Hi Hanns

Bisect shows it was introduced with this commit.

commit d680063482885c15d68e958212c3d6ad40a510dd (HEAD)
Author: Hannes Reinecke <hare@suse.de>
Date:   Thu Oct 12 14:22:48 2023 +0200

    nvme: rework NVME_AUTH Kconfig selection

    Having a single Kconfig symbol NVME_AUTH conflates the selection
    of the authentication functions from nvme/common and nvme/host,
    causing kbuild robot to complain when building the nvme target
    only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
    host bits and use NVME_AUTH for the common functions only.
    And move the CRYPTO selection into nvme/common to make it
    easier to read.

On Wed, Oct 18, 2023 at 2:57=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hello
> Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
> latest linux-block/for-next[1],
> from the log I can see it was due to authentication setup failed,
> please help check it, thanks.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log=
/?h=3Dfor-next
> e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
> 'for-6.7/block' into for-next
>
> [2]
> # ./check nvme/041
> nvme/041 (Create authenticated connections)                  [failed]
>     runtime  3.274s  ...  3.980s
>     --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
>     +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
> 02:50:03.496539083 -0400
>     @@ -2,5 +2,5 @@
>      Test unauthenticated connection (should fail)
>      NQN:blktests-subsystem-1 disconnected 0 controller(s)
>      Test authenticated connection
>     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>     +NQN:blktests-subsystem-1 disconnected 0 controller(s)
>      Test complete
>
> # dmesg
> [ 2701.636964] loop: module loaded
> [ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
> [ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 2702.447496] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> with DH-HMAC-CHAP.
> [ 2702.447707] nvme nvme0: qid 0: authentication setup failed
> [ 2704.099618] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> with DH-HMAC-CHAP.
> [ 2704.099688] nvme nvme0: qid 0: authentication setup failed
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


