Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A658C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8wZgU8UvZmckDD6XyjCSOwNe0fm/wzNV87CQKI4JyQ=; b=b3XT1CuXGM37lOviMIhYn+07QJ
	UxDd3UFbfmEh1yjIBirFMD6xnlYQYpwHKY8PRJCK0+w+qOSm6k+ILVvvKykqAjS0TLmV1CeDiNofl
	89vHZ076pXFmOo5jLmJ4VcUllmKfczRniQbXiPthjko3WoIOz3T/flTL+Rb2dngJObe1okmfUGt4c
	tv0XC2p44BMgfcuZ7q5UxJ0hHBLWGdi52lQGnm1owHAYdTJuEeEmZQskp/j1TX28qj0Xfw83XUOrn
	5ulmwTWmtv+G0eJ0sm86PJ+Nl+TL2XRjB2AcSIMKQBlyzhnPbBUdOcdk+eXPznPO1YpiMW0ssE2Jl
	rD9YFJLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noQmm-002Vx7-By; Tue, 10 May 2022 14:24:24 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noQmj-002Vuv-Fk
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 14:24:23 +0000
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-ed8a3962f8so18463495fac.4
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H8wZgU8UvZmckDD6XyjCSOwNe0fm/wzNV87CQKI4JyQ=;
 b=HYUku0OB1BO6au16AbfhELM3xx7b9xUXKdpFDm0I58f4tun6q2dBn2jRYh6uhyYcm8
 rt0lQeKckkRmSSo3DyIZJBywihDGOPJYgjIvqAfkprtgwkjQpi9tppcjTA7da0aJoSPD
 PxIHSD1bABTWWRH9u+/re6wzIgIhtw3hpiJQ3wFKR8ubXnVWZdhaZiuMQOSKAGoz37np
 cWB1PTneD/sjMEVpvpKrcoluKNrye7V3dYwFG5xdbM0hFccolqM5Sa7zHm/eyg88wEaY
 +6phBg5Y1FRkSsdCljSQOZjGIn7khCH7jXo9ctbw/1wYdVNrfmiPG6lUhtxxRNXXwdgO
 McOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H8wZgU8UvZmckDD6XyjCSOwNe0fm/wzNV87CQKI4JyQ=;
 b=gQBYm3Pr8jyKYvqSN6XTCJtS6a6cQg55YudtAOTCUui/oIvVUL2/uliGtMIDD8Gb7j
 X0Qs7l6gfKBVecGfXfWyO587ukw6aeBjXOO3ZVDn8OfXIt7VuS/PwXViOCnNDntiYuc+
 KuYZlvy0/90uD2YRmq54xclJ/Ofc02PH8czV8vjGePOSuGdRffvaRj2YryWS4bM7jjbr
 999VAqyr9CpnqWZXki0Auh5EMva+lyQbrCYs8/Wr3IUQO+qos0fIpm3uvyUeIPCaFu4D
 gopcmVE4fsRwF96NxO8F6N7YCPnRV6C64rvEF0Yz+5QYedB6eefYVu2tK3ccmEvnWzHD
 u+wg==
X-Gm-Message-State: AOAM530H9MS0irL7HyQmrMopG+7M9KmxtysbKF4r9YTAM1tPqeFZIpWV
 UfQCqk/jNhItJ2mLeDOXEPcO0Qr/efvBhmmhIe4=
X-Google-Smtp-Source: ABdhPJzRfni1auhMC02gcn9MizbEEslal9V5Y98Pt/yQeQaEf4FgqtJf6KUyCMjcsHW9tVOoEoniGI9PYmVjSDjhtrI=
X-Received: by 2002:a05:6870:c392:b0:e9:f20:fa8a with SMTP id
 g18-20020a056870c39200b000e90f20fa8amr175116oao.15.1652192659312; Tue, 10 May
 2022 07:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061144epcas5p3821a9516dad2b5eff5a25c56dbe164df@epcas5p3.samsung.com>
 <20220505060616.803816-2-joshi.k@samsung.com>
 <1af73495-d4a6-d6fd-0a03-367016385c92@kernel.dk>
In-Reply-To: <1af73495-d4a6-d6fd-0a03-367016385c92@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 10 May 2022 19:53:53 +0530
Message-ID: <CA+1E3r+airL_U0BzmLhiVPVkWdbiAXxxyHXONy9bGx4uuJFhdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fs,io_uring: add infrastructure for uring-cmd
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Stefan Roesch <shr@fb.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_072421_561088_6CD03011 
X-CRM114-Status: GOOD (  22.30  )
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

On Thu, May 5, 2022 at 9:47 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
> > +static int io_uring_cmd_prep(struct io_kiocb *req,
> > +                          const struct io_uring_sqe *sqe)
> > +{
> > +     struct io_uring_cmd *ioucmd = &req->uring_cmd;
> > +     struct io_ring_ctx *ctx = req->ctx;
> > +
> > +     if (ctx->flags & IORING_SETUP_IOPOLL)
> > +             return -EOPNOTSUPP;
> > +     /* do not support uring-cmd without big SQE/CQE */
> > +     if (!(ctx->flags & IORING_SETUP_SQE128))
> > +             return -EOPNOTSUPP;
> > +     if (!(ctx->flags & IORING_SETUP_CQE32))
> > +             return -EOPNOTSUPP;
> > +     if (sqe->ioprio || sqe->rw_flags)
> > +             return -EINVAL;
> > +     ioucmd->cmd = sqe->cmd;
> > +     ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
> > +     return 0;
> > +}
>
> While looking at the other suggested changes, I noticed a more
> fundamental issue with the passthrough support. For any other command,
> SQE contents are stable once prep has been done. The above does do that
> for the basic items, but this case is special as the lower level command
> itself resides in the SQE.
>
> For cases where the command needs deferral, it's problematic. There are
> two main cases where this can happen:
>
> - The issue attempt yields -EAGAIN (we ran out of requests, etc). If you
>   look at other commands, if they have data that doesn't fit in the
>   io_kiocb itself, then they need to allocate room for that data and have
>   it be persistent

While we have io-wq retrying for this case, async_data is not allocated.
We need to do that explicitly inside io_uring_cmd(). Something like this -

if (ret == -EAGAIN) {
if (!req_has_async_data(req)) {
if (io_alloc_async_data(req)) return -ENOMEM;
io_uring_cmd_prep_async(req);
}
return ret;
}

> - Deferral is specified by the application, using eg IOSQE_IO_LINK or
>   IOSQE_ASYNC.
For this to work, we are missing ".needs_async_setup = 1" for
IORING_OP_URING_CMD.

