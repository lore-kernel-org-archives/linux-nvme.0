Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C59CC77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KVawbQRzJyzIOZpz7W6tsAHPXn8J+K2I2Vy2kuKD+TY=; b=QPRzAwL2vwA4QQSVQGJW4BUxzC
	g2/75i87FapBNZWA/xddYiJLpQh9luOyrrZ2+iK6Jf7t3X/5x93lrbJWOFtppfbaZVyDIN1NYvd66
	s9nlNXWtAwOceuSYKJOP8MVFeZtHmyDue1hq0g2HXsobqqtzBJ2nzLwi4Bulpjt/lo710bXGc/6l4
	E4z1gvpyLyqmKdn1eqr7haOukP3ILPQDsbVMdkNzp6CoIjQt8oa0d/NntPPWq/FHErYHT0Yow5hlb
	uCjAoWhp68s/AYu9jVqW7G26AGP1WO/vl56A6S9TC3SpEUet2IKifiWIx0pshu/Wk0jCvEoLEk45d
	mOrKfsqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyt5B-005c8N-36;
	Tue, 16 May 2023 11:43:09 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyt59-005c4a-22
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 11:43:09 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4501ca552a3so7462993e0c.2
        for <linux-nvme@lists.infradead.org>; Tue, 16 May 2023 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684237366; x=1686829366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVawbQRzJyzIOZpz7W6tsAHPXn8J+K2I2Vy2kuKD+TY=;
        b=GE+1XfGpRhmsxgdP9CBWijSHCOfxDy+doCCPTlEKkqVSE4W7e7ym5oHwAm0T6+TULn
         K5jRZLV7LOArn+gRtVVmdJWK2YL9k3XEclQRTezVCI2efKXmF9NIWdXTjgKW8x7hXwBq
         DQHUPDq+dqRMMhc7WzHqV9kr4RNzn0b8YHcnUceeaN6XLg+O/q8/1kTKfh7SKjFzJV0l
         lsp0QrhezU1FNPHoCydO8vrKir1LbISk2SGyZ59fNUNtAySYrM3NCqKIvwv+z6bYO59U
         1THPcm9pMKgjzcJadSpbFwR55/xvACyfVS874ZtDShqA3avbmusDCGaV5U/CDzUglI8i
         1zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684237366; x=1686829366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVawbQRzJyzIOZpz7W6tsAHPXn8J+K2I2Vy2kuKD+TY=;
        b=CssjW90NbZMU5aqvK1GVEgOeORornCaTn+gub6DzAr0W2+ZYM/7l3ZBzFIgvw8KLYt
         L1NJwGDAy30MLw/NkNOZw0XEsVJwVQJqCJ44EYCQ0OpqgqPzABWxNM/0TOwnaO4TK/jf
         48U7ZMSuGbIWy2wvbQwxfWD8yy7TKp4jBb7pPhP6VJrMVVHHUasxbFajo6/TiQXfMtr/
         Jk9dZ9/6k+mZikqB9ENlu3B4hsL4PODD83FV+pByfwC8Q/ikG1JgePhs9C1Fatm686Wd
         liSk7sF3ILO8weDOENxhw/f3iRcYXPWf2cVd77CNpV75iTZiS0Uc2exJY/Q16ihBeULy
         c9Bg==
X-Gm-Message-State: AC+VfDzFZZXBG+JY77gs7+aTNH6eKnVEvBjc2wlz2NHJBtC09Ke4o7bU
	mmQrLKfrJ0ynxvjNWy+ysxfq0HGoAMoAMXWDAuzKAbSaG7OR
X-Google-Smtp-Source: ACHHUZ5kGng/vXSFDLNoSG/RfpGoOQuOl75CpGICyD3XF5aV6Lo94+7eB9YCkzKQYcog+GOpakZ5PSHUdlxMbtIng6Y=
X-Received: by 2002:a1f:54c1:0:b0:456:5823:92c1 with SMTP id
 i184-20020a1f54c1000000b00456582392c1mr3304272vkb.9.1684237365669; Tue, 16
 May 2023 04:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684154817.git.asml.silence@gmail.com>
In-Reply-To: <cover.1684154817.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 16 May 2023 17:12:08 +0530
Message-ID: <CACzX3Av9yOkAK16QRJ7npQUVAiTjA-nqLR2Doob9p6nYYYkyOg@mail.gmail.com>
Subject: Re: [PATCH for-next 0/2] Enable IOU_F_TWQ_LAZY_WAKE for passthrough
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_044307_674105_62845EB0 
X-CRM114-Status: GOOD (  15.64  )
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

On Mon, May 15, 2023 at 6:29=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Let cmds to use IOU_F_TWQ_LAZY_WAKE and enable it for nvme passthrough.
>
> The result should be same as in test to the original IOU_F_TWQ_LAZY_WAKE =
[1]
> patchset, but for a quick test I took fio/t/io_uring with 4 threads each
> reading their own drive and all pinned to the same CPU to make it CPU
> bound and got +10% throughput improvement.
>
> [1] https://lore.kernel.org/all/cover.1680782016.git.asml.silence@gmail.c=
om/
>
> Pavel Begunkov (2):
>   io_uring/cmd: add cmd lazy tw wake helper
>   nvme: optimise io_uring passthrough completion
>
>  drivers/nvme/host/ioctl.c |  4 ++--
>  include/linux/io_uring.h  | 18 ++++++++++++++++--
>  io_uring/uring_cmd.c      | 16 ++++++++++++----
>  3 files changed, 30 insertions(+), 8 deletions(-)
>
>
> base-commit: 9a48d604672220545d209e9996c2a1edbb5637f6
> --
> 2.40.0
>

I tried to run a few workloads on my setup with your patches applied. Howev=
er, I
couldn't see any difference in io passthrough performance. I might have mis=
sed
something. Can you share the workload that you ran which gave you the perf
improvement. Here is the workload that I ran -

Without your patches applied -

# taskset -c 0 t/io_uring -r4 -b512 -d64 -c16 -s16 -p0 -F1 -B1 -P0 -O0
-u1 -n1 /dev/ng0n1
submitter=3D0, tid=3D2049, file=3D/dev/ng0n1, node=3D-1
polled=3D0, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D64
Engine=3Dio_uring, sq_ring=3D64, cq_ring=3D64
IOPS=3D2.83M, BW=3D1382MiB/s, IOS/call=3D16/15
IOPS=3D2.82M, BW=3D1379MiB/s, IOS/call=3D16/16
IOPS=3D2.84M, BW=3D1388MiB/s, IOS/call=3D16/15
Exiting on timeout
Maximum IOPS=3D2.84M

# taskset -c 0,3 t/io_uring -r4 -b512 -d64 -c16 -s16 -p0 -F1 -B1 -P0
-O0 -u1 -n2 /dev/ng0n1 /dev/ng1n1
submitter=3D0, tid=3D2046, file=3D/dev/ng0n1, node=3D-1
submitter=3D1, tid=3D2047, file=3D/dev/ng1n1, node=3D-1
polled=3D0, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D64
Engine=3Dio_uring, sq_ring=3D64, cq_ring=3D64
IOPS=3D5.72M, BW=3D2.79GiB/s, IOS/call=3D16/15
IOPS=3D5.71M, BW=3D2.79GiB/s, IOS/call=3D16/16
IOPS=3D5.70M, BW=3D2.78GiB/s, IOS/call=3D16/15
Exiting on timeout Maximum IOPS=3D5.72M

With your patches applied -

# taskset -c 0 t/io_uring -r4 -b512 -d64 -c16 -s16 -p0 -F1 -B1 -P0 -O0
-u1 -n1 /dev/ng0n1
submitter=3D0, tid=3D2032, file=3D/dev/ng0n1, node=3D-1
polled=3D0, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D64
Engine=3Dio_uring, sq_ring=3D64, cq_ring=3D64
IOPS=3D2.83M, BW=3D1381MiB/s, IOS/call=3D16/15
IOPS=3D2.83M, BW=3D1379MiB/s, IOS/call=3D16/15
IOPS=3D2.83M, BW=3D1383MiB/s, IOS/call=3D15/15
Exiting on timeout Maximum IOPS=3D2.83M

# taskset -c 0,3 t/io_uring -r4 -b512 -d64 -c16 -s16 -p0 -F1 -B1 -P0
-O0 -u1 -n2 /dev/ng0n1 /dev/ng1n1
submitter=3D1, tid=3D2037, file=3D/dev/ng1n1, node=3D-1
submitter=3D0, tid=3D2036, file=3D/dev/ng0n1, node=3D-1
polled=3D0, fixedbufs=3D1/0, register_files=3D1, buffered=3D1, QD=3D64
Engine=3Dio_uring, sq_ring=3D64, cq_ring=3D64
IOPS=3D5.64M, BW=3D2.75GiB/s, IOS/call=3D15/15
IOPS=3D5.62M, BW=3D2.75GiB/s, IOS/call=3D16/16
IOPS=3D5.62M, BW=3D2.74GiB/s, IOS/call=3D16/16
Exiting on timeout Maximum IOPS=3D5.64M

--
Anuj Gupta

