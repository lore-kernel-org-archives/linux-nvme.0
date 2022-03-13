Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04C8C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 05:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BiP1OUgw5aMNucxm0wSc1yXQNpiaVLQclFLothq1kwU=; b=22p8saItxI18sOpBY5Xkk1K0Wj
	wGqdbmeq6sg9enr8OW2ehcmvZzNzBJYtRvZuGnICwnYHENYljIEHBIaSoI40NnTipTBp6xMmsjuiT
	6KMxsNmHMup5k6QQy8ffqpPMyxfvb4ncLN4EZZSmEti29t2K2hl03+Gdu8xobsmOtUOgCe/NhkxD+
	nFMF9Pf4NIeLmFJ0f6iKi7IAM6c54AdydGbPbbv7FzwqcQhtln4CQozv/YVmMpBGbn9y0Wr6dbVfG
	KwiX+zM6/nCauaOrMUZAPhQJ7KgD8NOC6pyco0hywwjyoUV9bX10R8o9AIWFLfvBTJnaZN+WWjD1O
	v2aFZO1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTGSz-002Dqe-FK; Sun, 13 Mar 2022 05:08:29 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTGSr-002DqI-KQ
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 05:08:23 +0000
Received: by mail-lf1-x131.google.com with SMTP id w7so21731027lfd.6
 for <linux-nvme@lists.infradead.org>; Sat, 12 Mar 2022 21:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BiP1OUgw5aMNucxm0wSc1yXQNpiaVLQclFLothq1kwU=;
 b=Ss1L0ikV9i0k+OZf4hcnVQONh5gAxa9mCIbxgzbbvHs6gZpJePfUoB4Vp0odXC9Kgd
 ckCJ2uL8jEU4HY2qfePYe0rpC9/kYhvDEjKKSKFw2Y9hnzoowl/xJ3GAgzj1WqhfjH0t
 2QRN0zgyFpKGRdnJHwT2lRkKdAXJW5ZmxujnpdYV5FZ3GQWmWFKbjo/J2hWSCrsKKRpp
 PrLr+4tlIs2nt/6BT5ucOK5djhwTgQCjySrRrLCVcoenR6m/apY7Z8cCIfAvfFZ5Oqbi
 KbKrjDLF9MpKuED+E2GjcxsQSixg2ut+2QJT3ef9UCLYWPQ/4ZU/70bgKqoo2dCwCXLs
 OIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BiP1OUgw5aMNucxm0wSc1yXQNpiaVLQclFLothq1kwU=;
 b=SjaVCqgPIzI8f81RAKasAA3T/RBphcR79RJ/mC7uodopM0Q+bSbtDVNp/oolTJgVPx
 mLTndVQjTSlING1W1mb1/c9bmPM16fV28NaVNSC/eJxMXkn6QQdqvsy0xgmM0mxn+s+h
 /DTEBhOo+CT0yVj/12HadgljT9IEjAVFwrVxUaRuWNuxQy9i1VXkBENgTVTmY85FtQU8
 HrJhKQKCr9y1pqnaBbcouKwZt6zIw0tGGffhhPHaSTbWlaXNiTrMFqJWfM9i23JY95gX
 ZsctywDHJpN28KPJZQ3DJvWBg9/ns+axz7fO6n9LREFYZrAIQlMU3ZL7Jiin+yPUj02Y
 AFhA==
X-Gm-Message-State: AOAM532adj0gdl7jlbukkgdVqHyrXmJ/D2bNngz/vgG/zaIKGUEqq6s3
 lB22gRNSrW6tGshDIqdeVNqqBhPYi5QeKXKiF9Q=
X-Google-Smtp-Source: ABdhPJwrUwptvnntJjKKmQAoOAj6ki9tc0LvmQ/gWmmAjOyI57JWLkVTze+Hnv9ASkKQtPTKp4s13NpRiD3hNW3SDvU=
X-Received: by 2002:ac2:5e2f:0:b0:443:671b:cead with SMTP id
 o15-20020ac25e2f000000b00443671bceadmr9896398lfg.306.1647148099036; Sat, 12
 Mar 2022 21:08:19 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696@epcas5p1.samsung.com>
 <20220308152105.309618-1-joshi.k@samsung.com> <20220310082926.GA26614@lst.de>
 <CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com>
 <Yit8LFAMK3t0nY/q@bombadil.infradead.org>
 <20220311233501.GA6435@bgt-140510-bm01>
 <20220312022732.GA10120@bgt-140510-bm01>
In-Reply-To: <20220312022732.GA10120@bgt-140510-bm01>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Sun, 13 Mar 2022 10:37:53 +0530
Message-ID: <CA+1E3rJNcqFT58eg1O+wDFyAkhCjHjnN6Hntms6jQxhLt1gtaQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] io_uring passthru over nvme
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Kanchan Joshi <joshi.k@samsung.com>, 
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "sbates@raithlin.com" <sbates@raithlin.com>, 
 "logang@deltatee.com" <logang@deltatee.com>,
 Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>, 
 "j.devantier@samsung.com" <j.devantier@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220312_210821_710742_CD299A51 
X-CRM114-Status: GOOD (  30.63  )
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

On Sat, Mar 12, 2022 at 7:57 AM Adam Manzanares
<a.manzanares@samsung.com> wrote:
>
> On Fri, Mar 11, 2022 at 03:35:04PM -0800, Adam Manzanares wrote:
> > On Fri, Mar 11, 2022 at 08:43:24AM -0800, Luis Chamberlain wrote:
> > > On Thu, Mar 10, 2022 at 03:35:02PM +0530, Kanchan Joshi wrote:
> > > > On Thu, Mar 10, 2022 at 1:59 PM Christoph Hellwig <hch@lst.de> wrot=
e:
> > > > >
> > > > > What branch is this against?
> > > > Sorry I missed that in the cover.
> > > > Two options -
> > > > (a) https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url=
?k=3D03500d22-5ccb341f-0351866d-0cc47a31309a-6f95e6932e414a1d&q=3D1&e=3D4ca=
7b05e-2fe6-40d9-bbcf-a4ed687eca9f&u=3Dhttps*3A*2F*2Fgit.kernel.dk*2Fcgit*2F=
linux-block*2Flog*2F*3Fh*3Dio_uring-big-sqe__;JSUlJSUlJSUl!!EwVzqGoTKBqv-0D=
WAJBm!FujuZ927K3fuIklgYjkWtodmdQnQyBqOw4Ge4M08DU_0oD5tPm0-wS2SZg0MDh8_2-U9$
> > > > first patch ("128 byte sqe support") is already there.
> > > > (b) for-next (linux-block), series will fit on top of commit 9e9d83=
faa
> > > > ("io_uring: Remove unneeded test in io_run_task_work_sig")
> > > >
> > > > > Do you have a git tree available?
> > > > Not at the moment.
> > > >
> > > > @Jens: Please see if it is possible to move patches to your
> > > > io_uring-big-sqe branch (and maybe rename that to big-sqe-pt.v1).
> > >
> > > Since Jens might be busy, I've put up a tree with all this stuff:
> > >
> > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kern=
el/git/mcgrof/linux-next.git/log/?h=3D20220311-io-uring-cmd__;!!EwVzqGoTKBq=
v-0DWAJBm!FujuZ927K3fuIklgYjkWtodmdQnQyBqOw4Ge4M08DU_0oD5tPm0-wS2SZg0MDiTF0=
Q7F$
> > >
> > > It is based on option (b) mentioned above, I took linux-block for-nex=
t
> > > and reset the tree to commit "io_uring: Remove unneeded test in
> > > io_run_task_work_sig" before applying the series.
> >
> > FYI I can be involved in testing this and have added some colleagues th=
at can
> > help in this regard. We have been using some form of this work for seve=
ral
> > months now and haven't had any issues. That being said some simple test=
s I have
> > are not currently working with the above git tree :). I will work to ge=
t this
> > resolved and post an update here.
>
> Sorry for the noise, I jumped up the stack too quickly with my tests. The
> "simple test" actually depends on several pieces of SW not related to the
> kernel.

Did you read the cover letter? It's not the same *user-interface* as
the previous series.
If you did not modify those out-of-kernel layers for the new
interface, you're bound to see what you saw.
If you did, please specify what the simple test was. I'll fix that in v2.

Otherwise, the throwaway remark "simple tests not working" - only
infers this series is untested. Nothing could be further from the
truth.
Rather this series is more robust than the previous one.

Let me expand bit more on testing part that's already there in cover:

fio -iodepth=3D256 -rw=3Drandread -ioengine=3Dio_uring -bs=3D512 -numjobs=
=3D1
-runtime=3D60 -group_reporting -iodepth_batch_submit=3D64
-iodepth_batch_complete_min=3D1 -iodepth_batch_complete_max=3D64
-fixedbufs=3D1 -hipri=3D1 -sqthread_poll=3D0 -filename=3D/dev/ng0n1
-name=3Dio_uring_256 -uring_cmd=3D1

When I reduce the above command-line to do single IO, I call that a simple =
test.
Simple test that touches almost *everything* that patches build (i.e
async, fixed-buffer, plugging, fixed-buffer, bio-cache, polling).
And larger tests combine these knobs in various ways, QD ranging from
1, 2, 4...upto 256; on general and perf-optimized kernel config; with
big-sqe and normal-sqe (pointer one). And all this is repeated on the
block interface (regular io) too, which covers the regression part.
Sure, I can add more tests for checking regression. But no, I don't
expect any simple test to fail. And that applies to Luis' tree as
well. Tried that too again.


--=20
Joshi

