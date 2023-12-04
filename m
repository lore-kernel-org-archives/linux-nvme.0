Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBB0C10DC1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJWDbiPu4qvL/JC0PNIHJ3Asj8egnHDhDvdQ4O4EMiE=; b=K+Fvc81F4vM5ZLMoa0R0RzzouU
	sty2hcW6CgHUZdUguSp7+UXO0apLbjRAhDgpY/Z2L8RXc35sfuE5kRPZoMSFX6gcUkjyH1SKP2hLF
	LrdOlxap/6RTZxeUqrY+F94C+jCnB6b/qyN9344QlNOUOdRvR0FlgXpCZaCSri6ZZjjKsy5CVsihH
	I3LosJN2CTS8Ez/8dk/zYTDv3fUo9p3FGOTjePxLi+5jAgZJnuqwZZb4i5jD1o6WX2Zt2xxUSooto
	CBtavqVcZLtYzxMN9XRBDUOVudw1TUq6Mli5efkFw2kiGmYt4EAO//Wn07GIo/97AnFpNXhXv6sfm
	EXk0Kj1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rADuM-005Lf0-0a;
	Mon, 04 Dec 2023 18:43:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rADuJ-005LeO-0G
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 18:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701715381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJWDbiPu4qvL/JC0PNIHJ3Asj8egnHDhDvdQ4O4EMiE=;
	b=aKE3cHeYlNvJRRfGa3cmuCTr1jmXXzUbvklDhgCdZvIYCsCYU6m28e65tm2EBRbIB0clEL
	/zGR0h3QH8qE8z/5s/qkDxAUZrgQDS4abYo6cpUTs4pJGxgNiEXlog+bcsNGGH5T8/0EP7
	CoCrLL4JBH/qNuxphZIBQtxKjoqY9/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-CG4HhxtwPnq28LHp2Gv-Ew-1; Mon, 04 Dec 2023 13:41:00 -0500
X-MC-Unique: CG4HhxtwPnq28LHp2Gv-Ew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8931C85A59D;
	Mon,  4 Dec 2023 18:40:59 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.10.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12E2A2026D4C;
	Mon,  4 Dec 2023 18:40:59 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: <linux-nvme@lists.infradead.org>,  <io-uring@vger.kernel.org>,
  <axboe@kernel.dk>,  <hch@lst.de>,  <sagi@grimberg.me>,
  <asml.silence@gmail.com>,  Keith Busch <kbusch@kernel.org>,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
References: <20231204175342.3418422-1-kbusch@meta.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 04 Dec 2023 13:40:58 -0500
In-Reply-To: <20231204175342.3418422-1-kbusch@meta.com> (Keith Busch's message
	of "Mon, 4 Dec 2023 09:53:41 -0800")
Message-ID: <x49zfypstdx.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_104303_275768_86ABBD01 
X-CRM114-Status: GOOD (  23.17  )
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

I added a CC: linux-security-module@vger

Hi, Keith,

Keith Busch <kbusch@meta.com> writes:

> From: Keith Busch <kbusch@kernel.org>
>
> The uring_cmd operation is often used for privileged actions, so drivers
> subscribing to this interface check capable() for each command. The
> capable() function is not fast path friendly for many kernel configs,
> and this can really harm performance. Stash the capable sys admin
> attribute in the io_uring context and set a new issue_flag for the
> uring_cmd interface.

I have a few questions.  What privileged actions are performance
sensitive?  I would hope that anything requiring privileges would not be
in a fast path (but clearly that's not the case).  What performance
benefits did you measure with this patch set in place (and on what
workloads)?  What happens when a ring fd is passed to another process?

Finally, as Jens mentioned, I would expect dropping priviliges to, you
know, drop privileges.  I don't think a commit message is going to be
enough documentation for a change like this.

Cheers,
Jeff

>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/io_uring_types.h | 4 ++++
>  io_uring/io_uring.c            | 1 +
>  io_uring/uring_cmd.c           | 2 ++
>  3 files changed, 7 insertions(+)
>
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> index bebab36abce89..d64d6916753f0 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -36,6 +36,9 @@ enum io_uring_cmd_flags {
>  	/* set when uring wants to cancel a previously issued command */
>  	IO_URING_F_CANCEL		= (1 << 11),
>  	IO_URING_F_COMPAT		= (1 << 12),
> +
> +	/* ring validated as CAP_SYS_ADMIN capable */
> +	IO_URING_F_SYS_ADMIN		= (1 << 13),
>  };
>  
>  struct io_wq_work_node {
> @@ -240,6 +243,7 @@ struct io_ring_ctx {
>  		unsigned int		poll_activated: 1;
>  		unsigned int		drain_disabled: 1;
>  		unsigned int		compat: 1;
> +		unsigned int		sys_admin: 1;
>  
>  		struct task_struct	*submitter_task;
>  		struct io_rings		*rings;
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 1d254f2c997de..4aa10b64f539e 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3980,6 +3980,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
>  		ctx->syscall_iopoll = 1;
>  
>  	ctx->compat = in_compat_syscall();
> +	ctx->sys_admin = capable(CAP_SYS_ADMIN);
>  	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
>  		ctx->user = get_uid(current_user());
>  
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 8a38b9f75d841..764f0e004aa00 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -164,6 +164,8 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>  		issue_flags |= IO_URING_F_CQE32;
>  	if (ctx->compat)
>  		issue_flags |= IO_URING_F_COMPAT;
> +	if (ctx->sys_admin)
> +		issue_flags |= IO_URING_F_SYS_ADMIN;
>  	if (ctx->flags & IORING_SETUP_IOPOLL) {
>  		if (!file->f_op->uring_cmd_iopoll)
>  			return -EOPNOTSUPP;


