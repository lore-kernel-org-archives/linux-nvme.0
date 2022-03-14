Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304D8C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZpxuttbwKow/Z0kqApTGYaW7moCIuKJs+JGqfcJDvtQ=; b=lHxtkBO/oEcH6T6CbXfKOA/wwL
	j4uv/LwSvAu2Fy5Gqji8owSKe/5tPb7nVZcfNnq4eWYnN0Q2KXeJIQ6GvQo1Fuc6KQCigAHnuQKzd
	jUS0+a+L34li7ZbsBvotnS/ldU3gSRoEItlsvW92OxDB2Cl2fe9UjI4qZUdPestNSYuBLAulIxJ0J
	/W4heCFNJVAw1fWiIlN9FdQDNAjVs7Bdho3b3iMJbQJ69qdpZBPEfaGhYWuKLdR3nFI9XcB+OXghX
	3mL6dJ90Cso8775d2rzEckgZ3WLIG+j4Y9S/XC80CttovPI1uNw/e4YwFaJC4sXmBYtZIH5ySZUTb
	hTvz4nPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTrL7-006nOy-Ag; Mon, 14 Mar 2022 20:30:49 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTrL2-006nNB-UB
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 20:30:47 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20220314203041usoutp02044e252abdab00f5251620273718f920~cWWIs1c5g0567605676usoutp02L;
 Mon, 14 Mar 2022 20:30:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20220314203041usoutp02044e252abdab00f5251620273718f920~cWWIs1c5g0567605676usoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647289841;
 bh=ZpxuttbwKow/Z0kqApTGYaW7moCIuKJs+JGqfcJDvtQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=cMhawn4p7xPcV7tvp8/3rC8ccF9/eNxl8jwzCh/fQ7fn4vV/+0wyuobXYSPBuMOaw
 k4uSxqmvkS0o322iGOdg0LOXJPODZp7oZgjz5hP6MTm8/ld7rXOyz0Ghhp8fgZalp7
 OxsvNYQGPNGcvvNjZpEgHRI1RpBx4HdgCat41toU=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220314203041uscas1p2e3ca25dd62ace0d3057b54c67d1228b7~cWWIitEQw0453604536uscas1p2Y;
 Mon, 14 Mar 2022 20:30:41 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 5A.08.10104.1F5AF226; Mon,
 14 Mar 2022 16:30:41 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220314203041uscas1p1ffe9fa1fd864780a38861498f940039e~cWWIK2bb41325113251uscas1p1r;
 Mon, 14 Mar 2022 20:30:41 +0000 (GMT)
X-AuditID: cbfec36f-315ff70000002778-91-622fa5f1cb05
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 96.3C.10042.1F5AF226; Mon,
 14 Mar 2022 16:30:41 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Mon, 14 Mar 2022 13:30:40 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
 SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
 15.01.2242.008; Mon, 14 Mar 2022 13:30:40 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, "Keith
 Busch" <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "sbates@raithlin.com" <sbates@raithlin.com>, "logang@deltatee.com"
 <logang@deltatee.com>, Pankaj Raghav <pankydev8@gmail.com>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>, Anuj Gupta
 <anuj20.g@samsung.com>, "j.granados@samsung.com" <j.granados@samsung.com>,
 "j.devantier@samsung.com" <j.devantier@samsung.com>
Subject: Re: [PATCH 00/17] io_uring passthru over nvme
Thread-Topic: [PATCH 00/17] io_uring passthru over nvme
Thread-Index: AQHYMwMGkOxasisH10Kgb51ozZAKiKy40f0AgAAatgCAAgGiAIAAcwUAgAAwNQCAAa5ZgIAClCMA
Date: Mon, 14 Mar 2022 20:30:40 +0000
Message-ID: <20220314203033.GA35883@bgt-140510-bm01>
In-Reply-To: <CA+1E3rJNcqFT58eg1O+wDFyAkhCjHjnN6Hntms6jQxhLt1gtaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B82CD83EA2E6134F9A41A98416F976AE@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djXc7ofl+onGUy5qWExZ9U2RovVd/vZ
 LFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saEp4wWa24+ZbH4
 fGYeqwOvx7Orzxg9ds66y+7RvOAOi8fls6Uem1Z1snlsXlLvsftmA5vHtsUvWT0+b5IL4Izi
 sklJzcksSy3St0vgyjjefoSl4Ityxemjz1kaGP/JdDFyckgImEi8WTmBpYuRi0NIYCWjxJmf
 71lAEkICrUwSHx/YwRTdeDWJDaJoLaPE7RdboTo+MkocWnqZGcI5wCjR/2A7K0gLm4CBxO/j
 G5lBbBEBdYkv6ycyghQxCzxllZjTc40NJCEsYCZx6nszO0SRucTvRRNYIewoiRVH1zKC2CwC
 qhI9XUfBBvEC3fF82xOw+zgFAiV6z68E62UUEJP4fmoNE4jNLCAucevJfCaIuwUlFs3ewwxh
 i0n82/WQDcJWlLj//SU7RL2exI2pU9ggbDuJhyvfskDY2hLLFr6G2isocXImxF4JAUmJgytu
 gL0vITCfU+LJhh5WiISLRMfC+1CLpSX+3l3GBFG0ilFiyrc2dghnM6PEjF8XoKqsJf51XmOf
 wKgyC8nls5BcNQvJVbOQXDULyVULGFlXMYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525iBCbB
 0/8O5+9gvH7ro94hRiYOxkOMEhzMSiK89RX6SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5l2Vu
 SBQSSE8sSc1OTS1ILYLJMnFwSjUw6RW8KkhZf5R3YRX/JX85U9dF7SYcx6OfRHCILfwc+i3T
 9vZf8//Lg0ttYv9ra/mtqDaMmvvPZjnj97Pls2wyJHdU3j/EkbKzWOGYToHirmlC7/V3rk6/
 89Dq6iu/JtfeexJpOz8snL5u9brME6Xcf3tN93JVPos6uSYgRfnQjbJ7yd3h1yXb/5+r1Lz0
 YNayxQ+UF33fvbZgyvk+X7/DHZff+99m3fXU/KxSf5m/wMGOiRdPPZyr9dBmEa+Hw/3ZyaUH
 Lpz4z5Eckuf4d1turaF0e9WHuJIbjz37Goo/lhzZuWJa8O8rd+PzV2zOvzKL1fqtXKVryfub
 0hXHHx1m3uciHmW+9kBodvyEH4/09imxFGckGmoxFxUnAgBj7WeV8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWS2cA0SffjUv0kg2vPZS3mrNrGaLH6bj+b
 xcrVR5ks3rWeY7HoPH2ByeL828NMFpMOXWO02HtL22L+sqfsFktaj7NZ3JjwlNFizc2nLBaf
 z8xjdeD1eHb1GaPHzll32T2aF9xh8bh8ttRj06pONo/NS+o9dt9sYPPYtvglq8fnTXIBnFFc
 NimpOZllqUX6dglcGcfbj7AUfFGuOH30OUsD4z+ZLkZODgkBE4kbryaxdTFycQgJrGaUODDt
 NyuE85FRYuO1E1DOAUaJ/k/3mUBa2AQMJH4f38gMYosIqEt8WT+REaSIWeApq8ScnmtsIAlh
 ATOJU9+b2SGKzCV+L5rACmFHSaw4upYRxGYRUJXo6ToKNogX6I7n256wQGzbwyyx5OkDsCJO
 gUCJ3vMrwQYxCohJfD+1BuwKZgFxiVtP5jNBPCEgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIer1
 JG5MncIGYdtJPFz5lgXC1pZYtvA11BGCEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CM
 moVk1AJG1lWM4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiB6eP0v8PROxhv3/qod4iRiYPx
 EKMEB7OSCG99hX6SEG9KYmVValF+fFFpTmrxIUZpDhYlcd6XURPjhQTSE0tSs1NTC1KLYLJM
 HJxSDUzW+yPntc8rzup+3mlr2nrq4Ics6c0rDQ5v6nGX6orbkcf4tNn7zye7xyL7ZXgeT1zE
 lX9F71L4Hfevztf+z3nanlaml2Btl9x7y6qtODhU6EMgQxP/bDuv+OtHZ3x0//76hI5X0j0J
 9ej9zV/lXf0DXLxNbi6J/77snqxWVsLlP7PzuWwm/jiVu2D2MXOPvr99sZpyYTpua0y8/fJ3
 hJ/4+00qJL+s8UipvpKvIuPRzwUrj75z0YvvTLtT27JRqiUj/VqL2yKXLcm9b88eKHNZJm7s
 kem6NjHpwpOKyxlyXFdnX/mz/lzEU+miNbahS9//5Ew5kXeHvZX9zf69B69rvTS5XjLnzf07
 Vpe5liixFGckGmoxFxUnAgCk4g55jgMAAA==
X-CMS-MailID: 20220314203041uscas1p1ffe9fa1fd864780a38861498f940039e
CMS-TYPE: 301P
X-CMS-RootMailID: 20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696
References: <CGME20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696@epcas5p1.samsung.com>
 <20220308152105.309618-1-joshi.k@samsung.com>
 <20220310082926.GA26614@lst.de>
 <CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com>
 <Yit8LFAMK3t0nY/q@bombadil.infradead.org>
 <20220311233501.GA6435@bgt-140510-bm01>
 <20220312022732.GA10120@bgt-140510-bm01>
 <CA+1E3rJNcqFT58eg1O+wDFyAkhCjHjnN6Hntms6jQxhLt1gtaQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_133045_219963_1B0D3B96 
X-CRM114-Status: GOOD (  38.70  )
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

On Sun, Mar 13, 2022 at 10:37:53AM +0530, Kanchan Joshi wrote:
> On Sat, Mar 12, 2022 at 7:57 AM Adam Manzanares
> <a.manzanares@samsung.com> wrote:
> >
> > On Fri, Mar 11, 2022 at 03:35:04PM -0800, Adam Manzanares wrote:
> > > On Fri, Mar 11, 2022 at 08:43:24AM -0800, Luis Chamberlain wrote:
> > > > On Thu, Mar 10, 2022 at 03:35:02PM +0530, Kanchan Joshi wrote:
> > > > > On Thu, Mar 10, 2022 at 1:59 PM Christoph Hellwig <hch@lst.de> wr=
ote:
> > > > > >
> > > > > > What branch is this against?
> > > > > Sorry I missed that in the cover.
> > > > > Two options -
> > > > > (a) https://urldefense.com/v3/__https://protect2.fireeye.com/v1/u=
rl?k=3D03500d22-5ccb341f-0351866d-0cc47a31309a-6f95e6932e414a1d&q=3D1&e=3D4=
ca7b05e-2fe6-40d9-bbcf-a4ed687eca9f&u=3Dhttps*3A*2F*2Fgit.kernel.dk*2Fcgit*=
2Flinux-block*2Flog*2F*3Fh*3Dio_uring-big-sqe__;JSUlJSUlJSUl!!EwVzqGoTKBqv-=
0DWAJBm!FujuZ927K3fuIklgYjkWtodmdQnQyBqOw4Ge4M08DU_0oD5tPm0-wS2SZg0MDh8_2-U=
9$
> > > > > first patch ("128 byte sqe support") is already there.
> > > > > (b) for-next (linux-block), series will fit on top of commit 9e9d=
83faa
> > > > > ("io_uring: Remove unneeded test in io_run_task_work_sig")
> > > > >
> > > > > > Do you have a git tree available?
> > > > > Not at the moment.
> > > > >
> > > > > @Jens: Please see if it is possible to move patches to your
> > > > > io_uring-big-sqe branch (and maybe rename that to big-sqe-pt.v1).
> > > >
> > > > Since Jens might be busy, I've put up a tree with all this stuff:
> > > >
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/ke=
rnel/git/mcgrof/linux-next.git/log/?h=3D20220311-io-uring-cmd__;!!EwVzqGoTK=
Bqv-0DWAJBm!FujuZ927K3fuIklgYjkWtodmdQnQyBqOw4Ge4M08DU_0oD5tPm0-wS2SZg0MDiT=
F0Q7F$
> > > >
> > > > It is based on option (b) mentioned above, I took linux-block for-n=
ext
> > > > and reset the tree to commit "io_uring: Remove unneeded test in
> > > > io_run_task_work_sig" before applying the series.
> > >
> > > FYI I can be involved in testing this and have added some colleagues =
that can
> > > help in this regard. We have been using some form of this work for se=
veral
> > > months now and haven't had any issues. That being said some simple te=
sts I have
> > > are not currently working with the above git tree :). I will work to =
get this
> > > resolved and post an update here.
> >
> > Sorry for the noise, I jumped up the stack too quickly with my tests. T=
he
> > "simple test" actually depends on several pieces of SW not related to t=
he
> > kernel.
>=20
> Did you read the cover letter? It's not the same *user-interface* as
> the previous series.
> If you did not modify those out-of-kernel layers for the new
> interface, you're bound to see what you saw.
> If you did, please specify what the simple test was. I'll fix that in v2.

I got a little ahead of myself. Looking forward to leveraging this work in =
the=20
near future ;)

>=20
> Otherwise, the throwaway remark "simple tests not working" - only
> infers this series is untested. Nothing could be further from the
> truth.
> Rather this series is more robust than the previous one.

Excellent, to hear that this series is robust. My intent was not to claim
this series was untested. It is clear I need to do more hw before making an=
=20
attempt to help with testing.

>=20
> Let me expand bit more on testing part that's already there in cover:
>=20
> fio -iodepth=3D256 -rw=3Drandread -ioengine=3Dio_uring -bs=3D512 -numjobs=
=3D1
> -runtime=3D60 -group_reporting -iodepth_batch_submit=3D64
> -iodepth_batch_complete_min=3D1 -iodepth_batch_complete_max=3D64
> -fixedbufs=3D1 -hipri=3D1 -sqthread_poll=3D0 -filename=3D/dev/ng0n1
> -name=3Dio_uring_256 -uring_cmd=3D1
>=20
> When I reduce the above command-line to do single IO, I call that a simpl=
e test.
> Simple test that touches almost *everything* that patches build (i.e
> async, fixed-buffer, plugging, fixed-buffer, bio-cache, polling).
> And larger tests combine these knobs in various ways, QD ranging from
> 1, 2, 4...upto 256; on general and perf-optimized kernel config; with
> big-sqe and normal-sqe (pointer one). And all this is repeated on the
> block interface (regular io) too, which covers the regression part.
> Sure, I can add more tests for checking regression. But no, I don't
> expect any simple test to fail. And that applies to Luis' tree as
> well. Tried that too again.

Looks like you have all of your based covered. Keep up the good work.

>=20
>=20
> --=20
> Joshi=

