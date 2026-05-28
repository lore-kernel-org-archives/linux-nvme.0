Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE97DCD5BD5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=; b=OQbT1j07xZGj0ZUuuT+l6fUIRf
	ONIvoc1eSJfYGbXNAslk/7e876FBAHdsy7a/15GiuClKhGXVRE3PhHzkSJZvsz2bOpnHAsSJTLkOm
	R9qMGocpSP0gwwlNxBqtZDuFMdgw2x0mGP/dBPtjaOwmu5fZcXSQXu4deUVHLMKGVUN1Vn6frPnd9
	YR6w3RkRlupcNtSd4/JHX8GbJLiO0XqZL2zvRsfhEUZc+mRd8qcnElGSElRIYYr1RsTL5jHZbhEPM
	xICSZQlZkztz/erQ25c2QRthD+nyW3w7+9DKMaswAhUdvpCa5svchX2INs6X4CveP1iry55TCpXLp
	yC7a1s0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSd9N-00000005x5X-2V7H;
	Thu, 28 May 2026 16:00:01 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSd9J-00000005x3s-0EMo
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 16:00:01 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-96387977596so658909241.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 08:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779983995; cv=none;
        d=google.com; s=arc-20240605;
        b=Bfhb19/vLaNpfv/rQXpjdDvL9A6hCMmrqPQ15SCgbzUxb/sSXfqhHzP7/Q+arb6+gs
         Dvr4xTFhwpV/DZD9jk6YLvlsnOB14ABeGo4lbP+Ne+94fu52m6fbKZmIukqYllf81mDo
         iBqe7Tgzj4i2HHmcpWl13PGchRI2+4PxZWI85qubOT7Fk6N1R0als89EnLIDbaYVAH8y
         oprCGmNUYN41fS1XKrXs9HzNZDgmbk8jFA7ebKUd2CW/LdjSXv0Odi/9fnKq2EnSv0Qp
         5eE80hUSDMaMGIJG5jK+gAWQIp9XRQAVrkXVwTMFnTNBUrKuFjtEChH6l2nmzkUL6SOl
         GgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=;
        fh=YvEseNOn1p/eNr3B1iCF/gaiJL/z4BDQZ2VJOydTDmw=;
        b=Rl7fpAIf3/RIsFcdB2Ahxxt3fYtLsVEuAb8Zg3fV8EFMG997DyjHcsEyfIhoaiNcK2
         lB07XrIhzTbH1hif1iA0UAMGmfsy90bKDJN1WTp/PoZFQhQP4GKOnwRhrYkKLqi+4PVj
         VXttVNsIb7vZJeg581QLYmQ6vXMAwtOdo+/tcVKoH/8c4izUEO5ES6WW3YVfLB+6SvfP
         EwpOpnbvFGSsa+JhLkkATRcb0s+TniHigd5AtvS/5FWG9ltV8WqDmEO8f3hQ/reKI0NM
         W4yrD0cNwvs5cjy3O5EttgO7QkVveM9hcg7zAmmWMR75lQJEB2MxOZ4sqTgtYBsBoyuT
         OSPQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779983995; x=1780588795; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=;
        b=cgjrrIdCBKObJlY9iIpciQMbwnNf10HYpKt1jaOwY/+Y2DIPadu5eVCmX+3NMfIFXj
         1wTedSQFJe1qf2jtsDYPfgx0c5IebcydsJOl41kOTTMBeeDXkf61MU8HYSovv3FH09Vy
         OG9g2mMWFtL0zly5m8dKoC0tlm4GD19gX0WnU9rC/yRhOQwdtL9TnHde2jIWJZlrCpYY
         tv/vDpDTfZqHJcyDPcVqb5iCpUW9Fw5i/lb1yJB8tQ2rCEzdcoXO9zh44HQTYm5x0trI
         gvBYtFCvlH6J00u6qXFtXBcV/V7wyN36FKFdbb4BkOLjc1O76NKAVtLKkvVjBZ0Bs+/P
         192Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983995; x=1780588795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=;
        b=G/brLUgQC1NWZmkC3g4QuYjFsW591KCAZvOV//Qpu5RZyQsOkw8eiZ1D4oZSpm0Mah
         cI0Qux+uuv2etsLkSo4MA9OrVt790FFS0Wf+2bK4nuMepYd2JKiTP/nDrjOCbnIHTDDZ
         XUtywg8APMXuGERrJsZvou1uWnq8SlCxA1wQYeOK3dktr8hck2iQ1+eHaB1RcZ7svS9B
         gzA2RLKptKVw4OkDQiqly3z3godEzdKLiJ5HdSnF+h1unUZs622nlGk99YNGmirnMKbA
         s8h1VVCSXxPiYm2u9VUB6T/nY2zaoZYNAa6NmftdUt4Ce2ZHY6xNSqN5y5KM+jmSCaDc
         UTwA==
X-Forwarded-Encrypted: i=1; AFNElJ9dtH1EOxk4iYfqITGR2/x3Uty20hn72Pc9irqjJo41E7z69EvThNXxPAeJra04mzQLlUrHJkCaOwyZ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4jFCXYXIEiAYHKIQg/lBdH32qmwqOrPAVPzC2iCpwdIA/UHdz
	zAhUij1vt2Br42vymas9QHuycgO7A5ArRSbBqch5vgKPeu3BUOJ9nzfsBkQv6A/CjdTr/1vocem
	C3DThugGRBBMorPtTTMkGwJvkjfdbVGKD0p+Yzpol9Q==
X-Gm-Gg: Acq92OE43xgCovHrfhdQhokgqpu/ED7AizghH5WbzLsW3CrL7Mc/rwE4JjGR0trk3xN
	e5CE775q9nLQdWa9fquNykFU3AfGc4fIhcT8ylJEo2pCyP7Ul9eA21zxLk+GmvSccagIJhFcTI7
	7ZSMgsK2QwHEyKRMzxbR51RtmfpN3VYYh8RtFiNh6hBKIlLWe0purh3fGjErlAmTkZO8/xLVevD
	nxZFXSp+RBr2IVvwkU/HchAKiKxUbQbhXkPk9ne2rO0CzwZkjU8vBUZEChwfr3mBU83yeouK1Te
	n6VFSpY5Smyy1FE9qbcQwOf1JZIRQgxNCXlMsWVty2O4svXDaW2ENqYP6rWATkXgvd+XlH2UnQ6
	ov/+k
X-Received: by 2002:a05:6102:5709:b0:62f:39a9:ae67 with SMTP id
 ada2fe7eead31-67c7ffec833mr13509717137.17.1779983995053; Thu, 28 May 2026
 08:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com> <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
 <ffc23fb3bc82988608237be48a3eea7fdd3a4dd7.camel@kernel.org>
 <6042b928aa8116d531c5e360ba19fa077af87bcc.camel@kernel.org> <f902be73f83291b732a8e33361bfcdb7e75a0afd.camel@kernel.org>
In-Reply-To: <f902be73f83291b732a8e33361bfcdb7e75a0afd.camel@kernel.org>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 28 May 2026 08:59:43 -0700
X-Gm-Features: AVHnY4Jl8y8OPVw7gHii_tacFLLUBi7Tm1lyVtD_jOzTv6GtL7YFYvt-fktFiEo
Message-ID: <CAPpK+O0i2S-_PZ4Spo6C-MXUV+2W3PaQbfw34D4LcYfAsB13qQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
To: Geliang Tang <geliang@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	=?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	mptcp@lists.linux.dev, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_085957_269957_7986F674 
X-CRM114-Status: GOOD (  11.92  )
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

On Tue, May 19, 2026 at 12:31=E2=80=AFAM Geliang Tang <geliang@kernel.org> =
wrote:
> Lossless network, comparison between TCP and MPTCP using the "queue-
> depth" policy - MPTCP and TCP show similar performance:
>
> # ./mptcp_nvme.sh tcp 4 queue-depth 0
>    READ: bw=3D456MiB/s (478MB/s), 456MiB/s-456MiB/s (478MB/s-478MB/s),
>                         io=3D4632MiB (4857MB), run=3D10169-10169msec
>   WRITE: bw=3D455MiB/s (477MB/s), 455MiB/s-455MiB/s (477MB/s-477MB/s),
>                         io=3D4666MiB (4893MB), run=3D10250-10250msec
>
> # ./mptcp_nvme.sh mptcp 4 queue-depth 0
>    READ: bw=3D446MiB/s (467MB/s), 446MiB/s-446MiB/s (467MB/s-467MB/s),
>                         io=3D4568MiB (4790MB), run=3D10249-10249msec
>   WRITE: bw=3D445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
>                         io=3D4563MiB (4784MB), run=3D10245-10245msec
This makes much more sense to me.  Have you tested where one path
is _not_ flaky but is slower?  (3 100GBps, 1 50GBps or something like that)

>
>
> Second set of tests: lossy network, path=3D4, loss=3D1. The tc output is =
as
> follows:
>
>   qdisc netem 8051: root refcnt 25 limit 1000 delay 5ms loss 0.5%
>                         rate 1Gbit seed 14946049878654165618
>
>
> Lossy network, comparison between TCP and MPTCP using the "queue-depth"
> policy - MPTCP is four times faster than TCP:
>
> # ./mptcp_nvme.sh tcp 4 queue-depth 1
>    READ: bw=3D168MiB/s (176MB/s), 168MiB/s-168MiB/s (176MB/s-176MB/s),
>                         io=3D2179MiB (2285MB), run=3D12965-12965msec
>   WRITE: bw=3D128MiB/s (134MB/s), 128MiB/s-128MiB/s (134MB/s-134MB/s),
>                         io=3D1590MiB (1667MB), run=3D12418-12418msec
>
> # ./mptcp_nvme.sh mptcp 4 queue-depth 1
>    READ: bw=3D425MiB/s (445MB/s), 425MiB/s-425MiB/s (445MB/s-445MB/s),
>                         io=3D4536MiB (4756MB), run=3D10677-10677msec
>   WRITE: bw=3D414MiB/s (434MB/s), 414MiB/s-414MiB/s (434MB/s-434MB/s),
>                         io=3D4447MiB (4663MB), run=3D10733-10733msec
>
>
> Conclusion: MPTCP achieves bandwidth aggregation comparable to that of
> NVMe multipath while offering better resilience against network
> interference.
This is interesting.  So, one path of 4 flaky reduces bandwidth to
1/4 bandwidth, effectively a penalty of 2 paths (I was expecting more of a
penalty), while tcpmp can shake it off. Do you have a
hypothosis/understanding of why?

I have a guess that selective retransmission might be kicking in (which
would be good), but how is that different than expected behavior for IP/NIC
bonding?  (which, I think, could be implemented without an
NVMe driver/protocol change?)  We generally point people away from
IP/NIC bonding; although, I am (personally) not sure why.

Sincerely,
Randy Jennings

