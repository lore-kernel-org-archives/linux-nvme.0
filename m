Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9FCC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTalr6Pg3F2/2+cacFsBsNozWQqUkCIZIMTm6+AC2o8=; b=BQUQ2DPkMGZcCWrtB/lJ9NiNUa
	t/W0lW54+CGs5LKjZPa6S7MjkIHP95rqyaihDZsAQeUPSuMZlkzYqq8aYNB0aig0RRQqMYXpwoM05
	sgK0ilxKPdzf97cBVEKZXsZ34r0wqF0XxfChz+/6bPtn9XxuS6T6lJLZXvw0v8NmiWXTa/5Hlz/Ng
	4ourmwJwCIq57+vt9EIYGKNjfaiwdKF/l8Y8DTV6kQoyl5duVa4M1+HwEE3L96dhVoQsb0Oahyjik
	KbQhoqJN1Y2LK+Ku03oMCEGZ3wk6Hen0HmcK+qAylw1XofBRi/OILsGMX7+FClCu6U/oh1KcPZijA
	RnEN+Rwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbql-00G9Tg-F0; Thu, 05 May 2022 13:48:59 +0000
Received: from us-smtp-delivery-74.mimecast.com ([170.10.129.74])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbqi-00G9R8-AU
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:48:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651758533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sTalr6Pg3F2/2+cacFsBsNozWQqUkCIZIMTm6+AC2o8=;
 b=Yulct/t38ycEuxzicAZx0EHTYRzJiZBl75yDajun+8MzBPQR9fv90hwBgYecDhM8dIcKIH
 +9umr0oTfsW5lPnXOiRqG6xzmcc0uyHQn8gHoSAcn1lG7qyZUHP5xuqq9hqhHOnWZtdSUN
 t5koQjwzN1prTKW/nJBCU945jGLAg2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-8vY9OnD9NfGyWiCbQLWgAA-1; Thu, 05 May 2022 09:48:50 -0400
X-MC-Unique: 8vY9OnD9NfGyWiCbQLWgAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AC10185A7A4;
 Thu,  5 May 2022 13:48:50 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F274C28103;
 Thu,  5 May 2022 13:48:43 +0000 (UTC)
Date: Thu, 5 May 2022 21:48:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 1/5] fs,io_uring: add infrastructure for uring-cmd
Message-ID: <YnPVtiRbYBYCGkCi@T590>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061144epcas5p3821a9516dad2b5eff5a25c56dbe164df@epcas5p3.samsung.com>
 <20220505060616.803816-2-joshi.k@samsung.com>
 <f9051783-5105-45ba-99b3-bc5d9254656d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9051783-5105-45ba-99b3-bc5d9254656d@kernel.dk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_064856_484111_DB663BAD 
X-CRM114-Status: GOOD (  28.26  )
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

On Thu, May 05, 2022 at 06:52:25AM -0600, Jens Axboe wrote:
> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> > 
> > file_operations->uring_cmd is a file private handler.
> > This is somewhat similar to ioctl but hopefully a lot more sane and
> > useful as it can be used to enable many io_uring capabilities for the
> > underlying operation.
> > 
> > IORING_OP_URING_CMD is a file private kind of request. io_uring doesn't
> > know what is in this command type, it's for the provider of ->uring_cmd()
> > to deal with. This operation can be issued only on the ring that is
> > setup with both IORING_SETUP_SQE128 and IORING_SETUP_CQE32 flags.
> 
> One thing that occured to me that I think we need to change is what you
> mention above, code here:
> 
> > +static int io_uring_cmd_prep(struct io_kiocb *req,
> > +			     const struct io_uring_sqe *sqe)
> > +{
> > +	struct io_uring_cmd *ioucmd = &req->uring_cmd;
> > +	struct io_ring_ctx *ctx = req->ctx;
> > +
> > +	if (ctx->flags & IORING_SETUP_IOPOLL)
> > +		return -EOPNOTSUPP;
> > +	/* do not support uring-cmd without big SQE/CQE */
> > +	if (!(ctx->flags & IORING_SETUP_SQE128))
> > +		return -EOPNOTSUPP;
> > +	if (!(ctx->flags & IORING_SETUP_CQE32))
> > +		return -EOPNOTSUPP;
> > +	if (sqe->ioprio || sqe->rw_flags)
> > +		return -EINVAL;
> > +	ioucmd->cmd = sqe->cmd;
> > +	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
> > +	return 0;
> > +}
> 
> I've been thinking of this mostly in the context of passthrough for
> nvme, but it originally started as a generic feature to be able to wire
> up anything for these types of commands. The SQE128/CQE32 requirement is
> really an nvme passthrough restriction, we don't necessarily need this
> for any kind of URING_CMD. Ditto IOPOLL as well. These are all things
> that should be validated further down, but there's no way to do that
> currently.
> 
> Let's not have that hold up merging this, but we do need it fixed up for
> 5.19-final so we don't have this restriction. Suggestions welcome...

The validation has to be done in consumer of SQE128/CQE32(nvme). One way is
to add SQE128/CQE32 io_uring_cmd_flags and pass them via ->uring_cmd(issue_flags).


Thanks,
Ming


