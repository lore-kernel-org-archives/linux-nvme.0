Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2kQQWoGvuzCNOwjCUHmsQiT1YFlZWmN+JspGoJIih0=; b=k4PR7VWF5f9YXy0CuezeLRLS2j
	SDxEGQVPau73Bq+RjIS0XraT7OEyaksNVtJ8idU9c0kNg2H1X11E3eGtnqDvfpkIrrZEVWcr68T1w
	KmEByOJAWAyNBAS+890nh9gRqrw9lt5IbXCcDsXie0dkokCllW/4X0NW588dHA/KvPnIS1vfOiW05
	iewaNfMjL9PH//MvocEGBfbzBIIBep+myesmzMaU6Gm0+Ik3JSKvU3klVRXbouhlP2O4gqJXjN5un
	yxlD2/CnYPGO69gyEflhPNFSO3VojCq/BNfcdU0e7xfCyGpTD2ed0OLm2px84H514YGi2ESCepBsx
	kEj9IquQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nThkj-004tnb-Q1; Mon, 14 Mar 2022 10:16:37 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nThkh-004tmB-6T
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 10:16:36 +0000
Received: by mail-lj1-x22a.google.com with SMTP id z26so21053703lji.8
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g2kQQWoGvuzCNOwjCUHmsQiT1YFlZWmN+JspGoJIih0=;
 b=YYqjj7+S3GqSJBq9m6ML8fw6ENbwQ1C/XWkiDQj2yHu56ewmkX9IZ9vj8EVgD4OjTI
 WajUYxbk4LBdICy7HjinH37zpRvejN6liVIW1ZmghZSNQJIxNtRFrvRQ+BiPNrlG0B/x
 di/g6+ee4yxwJHTCtIyhRV8eA+iBgEBj3ACLJqmOOauRC6xi56AqL383tApYngiTD0px
 7Bru39Ifrxu7bDqNkJOfYlXi3NkQUnuiz9yZJqWW7n7DiPJUhjzWYE1akrxHCnj9mZlJ
 5MiP85uhjXuoTbbI7iUdFcrWlt7zVmuJeyJAMbzGSaWCZcIoNsHBG72+5DChhNlwQ03v
 FllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g2kQQWoGvuzCNOwjCUHmsQiT1YFlZWmN+JspGoJIih0=;
 b=0cYa6VcUoRtZuLcbIB56C9afzPcdymp6lFvqf4OMaPpIBsh3iWqSZdsGOPST+LZP8a
 ksbssQkPmwuQI8pT7YVjYl/N7n1lRPnWbMLTX8GDUPN9158UYVwua0V83B/ruaCjMOl3
 xPI+5YGahMHqANUqH1IX9e9SNbztz/f5SMqquQVTokLjYABk8blQ4u7LdjCGl68MtDBD
 GJic8B56wKAoMqdOLmcVo3iz9LJJrezPOGyqi4qXhj/Sg1DLzzcKghB0Nlf6QFxvFHKO
 y5xiCAkAaoK/GeBfNzdFxlzcDEPMU/TuJZpzgf+2B/4fqaSllLdKmRZQihLMNi7GPW3O
 bMDg==
X-Gm-Message-State: AOAM530IWyaHgPMBKPYryQqnkY+w8XOReNN/23/G9M0KGl2jXoBmnVoE
 HE5yqiXhOsfRa51juKtiX8/Ayvs6wk9H+/BVBrY=
X-Google-Smtp-Source: ABdhPJzgJYIjQH+0jeYRbDg1V9Ghvt/wr18ldnhnYbEGosFiu3tJA4Gv3/AFX2+8vkkE+/syD1C9PBAz7mj6J7oTP/I=
X-Received: by 2002:a2e:808d:0:b0:23e:f35:506b with SMTP id
 i13-20020a2e808d000000b0023e0f35506bmr14196580ljg.285.1647252992365; Mon, 14
 Mar 2022 03:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152723epcas5p34460b4af720e515317f88dbb78295f06@epcas5p3.samsung.com>
 <20220308152105.309618-15-joshi.k@samsung.com> <20220311065007.GC17728@lst.de>
In-Reply-To: <20220311065007.GC17728@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 14 Mar 2022 15:46:08 +0530
Message-ID: <CA+1E3rKKCE53TJ9mJesK3UrPPa=Vqx6fxA+TAhj9v5hT452AuQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] io_uring: add polling support for uring-cmd
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_031635_272715_4A8AD913 
X-CRM114-Status: GOOD (  14.28  )
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

On Fri, Mar 11, 2022 at 12:20 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 08, 2022 at 08:51:02PM +0530, Kanchan Joshi wrote:
> > +             if (req->opcode == IORING_OP_URING_CMD ||
> > +                 req->opcode == IORING_OP_URING_CMD_FIXED) {
> > +                     /* uring_cmd structure does not contain kiocb struct */
> > +                     struct kiocb kiocb_uring_cmd;
> > +
> > +                     kiocb_uring_cmd.private = req->uring_cmd.bio;
> > +                     kiocb_uring_cmd.ki_filp = req->uring_cmd.file;
> > +                     ret = req->uring_cmd.file->f_op->iopoll(&kiocb_uring_cmd,
> > +                           &iob, poll_flags);
> > +             } else {
> > +                     ret = kiocb->ki_filp->f_op->iopoll(kiocb, &iob,
> > +                                                        poll_flags);
> > +             }
>
> This is just completely broken.  You absolutely do need the iocb
> in struct uring_cmd for ->iopoll to work.

But, after you did bio based polling, we need just the bio to poll.
iocb is a big structure (48 bytes), and if we try to place it in
struct io_uring_cmd, we will just blow up the cacheline in io_uring
(first one in io_kiocb).
So we just store that bio pointer in io_uring_cmd on submission
(please see patch 15).
And here on completion we pick that bio, and put that into this local
iocb, simply because  ->iopoll needs it.
Do you see I am still missing anything here?

-- 
Kanchan

