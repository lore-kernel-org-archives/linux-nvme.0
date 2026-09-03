Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D923C61DD3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNUdEEWKQVjdN7q8W0TVhZs4T4y8jeYY4j1GTYsuFeU=; b=c2EWZ/iWMfze0BKO7eMhJd5JlY
	tdJSiEdD2ZnMehubO7bFoWYSQchL5ONn9XTlAYYdyCm8829FwKRgvndp1xJi636kaeymSwCQQ9ufE
	axa4t3dgRVklV540g+q7D3F/GMui+/gxYqeE0apDFsJ2jiJVxiBJvgeCrEzphNNuX0HvuJqnGfhMK
	zeDa/N4Ir5PtTY6a+5NfgO1c1Z/uB3TNzm2xZzJxccgEkyvapjjqirSk27CdqWsINm68Ctf8Q5MQG
	LwvA+laAgt2HY2YYNv62ucbtwsOhrYhIxMdEJYD0hH8Xk7apLPUbPmlV0MoYxLS6kbdcoNhc/KuPZ
	Cu8/th4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Bu5-00000000LFp-0657;
	Thu, 03 Sep 2026 18:11:13 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Bu3-00000000LFJ-0Iwq
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 18:11:12 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so1852455e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2026 11:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788459068; cv=none;
        d=google.com; s=arc-20260327;
        b=CrGlPHxAf3XH4oMufkgr5jLXsSEGd0Ap4SysTHu9RJupM2YL6PM0BQ1WezqpoUoWhs
         qin++FvL1skSTL6BdM+lQ4uWxYYqv806/7wTSR0w85SrMZKPdO/19jxZhVAaVYSPgUf/
         E65UVlI+k5VALHzQRIDTllLBeagalBzDa26RZG4oWskt2lizA53D9HnzRpidTSNPBjOh
         LhNOQfHjdiGAC1aTztYAVCMth7T3d1cdTQdnFA3MKyv/qzlmptgDPCB3g4ifafapYHaq
         MegnlFXE9glwImNQ/LYRUQ1TAbKAk7miAJFsLEBQInH8i96QoehJOqo6qFgDXuTDiL/F
         qD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GNUdEEWKQVjdN7q8W0TVhZs4T4y8jeYY4j1GTYsuFeU=;
        fh=uU0Hno8XItg40MfB5I068nIre4Ay+093k9tf88NajQQ=;
        b=If3CX+M/Ct3EogqCG4eyzcIYKyPMLHs0CMVi9I5sxbneECZmz3cPHrEzA3DWfqytBd
         scVX3TDJdEbzWKCEiQr6sXLTyVcSgWS1EXZHIGZcoSwHc8rhiMTkzGCcnI+Gr76Kgcoo
         7bj3brtt4PHpkAma6ak7S6tPbMZoaEXPUAYdeU9/F2q5WIKn58YuPjYJVcB6YGi6LETM
         5mwUwIAYE/a5KceaS2fDtdO1UXv0YBs3VW59Pfsxcqs+amemJDB6QY6sP5oNoSgmCpUE
         0le3p3KuPOq/cvIrNnIqiAqS8R9FzbGcbGPFbq3DCM1rDuhXZhv+Q0W0oc8Or05xpqg5
         wmew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788459068; x=1789063868; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GNUdEEWKQVjdN7q8W0TVhZs4T4y8jeYY4j1GTYsuFeU=;
        b=pWXbyfc7Hrx4dT8dJE2/n4ym16H6WBL8Zs3rj8+oew5lJ67SiufVQndPerkaJ1NfcT
         cDxLytuae/DbNt45MrEI8EWeC26muE68QzFjwdtycbfZgSKZJZTAOaKn3M5HCcmrljps
         Xn3zm7/gtX07+Mf2ol22tTIVUOwt0P8gaM9cfK5UZCUf3qkBWU6PURxl7PDdZdRISmCQ
         V2UkZ0gCWxT6co1IobQPD3Chv2zzGAwH1FM5QGPHGI6TpuQngRFzsAINeIdIVmG7BjXS
         2Er52eEfkdwIBIXw/HHyuZodcn6Df3sKTXyUvqwGQe8UPriwqTXEqOMMJXSQZEGY3j1l
         dgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788459068; x=1789063868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNUdEEWKQVjdN7q8W0TVhZs4T4y8jeYY4j1GTYsuFeU=;
        b=eeAiK3mRIq5nGf3hCo/IvCtWIbOgIRwmge8Qhqz1+eTJcY8TIcOAx0YpRwSEP570/X
         uiH6GxoFk3taZWyAaXUvS2ALCZUdBtCBxCi440H0fQye6FJzn3s8xegI2LudoIJshAji
         h0gSEp23lcUPxnZEm/ZLK6hqeCzGao9Vbyy6wPK/EVOd6yeM7R4vBek/bWoyK7Qo9cFL
         H5Zk9UgKUIRSx4iVXKUeGBge/8daqO7vZC2QX/kCoHoYQXC7ZckUS84sUilkBbteCTCb
         RmvDETN8XsGThEWet54I7Yj27hrzL5Fv7Sl7UD0UwUuZZjkCWPSHbeQIu1trl2icfRt5
         W+kA==
X-Forwarded-Encrypted: i=1; AKwUvByCTlivFKmvwOrODh0QJqbPEJ5ssf5kU81E1nIVyyi4SVjZSEWaD7oJdzLWctV17hOReCZ5o5v7CPX6@lists.infradead.org
X-Gm-Message-State: AFuF++mWpyRxt4ihL6NSjk7k4cTuQZASIby2GG7dpGLvf5ujw0s227W3
	xywwRP3fHkski1uFEM9GOXb0bqYYgANOtiQR5gKTsKOb181mjgVyHSmbJRM8NCnGovvg4+NH7im
	dcqsd5bkVNp1riUFNQwH2WqXAMOh8AuNKJGgjyN0=
X-Gm-Gg: AYBFou0LF4L8AvhO3dgc8uM8dZR/YwNYnT0lZYfNv0L9knXSwlvfkOsgEasF2IkBODZ
	1H8q8ifB8tPIwKrSv9rLsZlm2t+EeEAB3avabHBh7Aq9gGbHd9y9vINPxOMDCMesYu42v8PImhO
	+3z5RHuzRDxS8jtABt7s4XdOf6eRSfO/I4QkWQEycfjdVJ0ct4imlNUnTdD1txR8KKhtinyfwXS
	TZNGwYmJqB16C/mpv8pd6hl8YLQw8VCwqpR82XLLtgHGy0G0rvTEUwyD3Wk4ir9ucxWQ5eB3H2t
	pjxSKAUqiWMQgHT+XFU1Ti4IigfqyUokM33TOmCmPftp70vmD2VhJ9bilAObo+EScHxLFyTMOne
	MOZycI2wxWV+q6YEh++WQGC+KhvU=
X-Received: by 2002:a05:600c:3587:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49ce583bc25mr243260895e9.16.1788459068282; Thu, 03 Sep 2026
 11:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260902225708.2379840-1-csander@purestorage.com> <20260902225708.2379840-2-csander@purestorage.com>
In-Reply-To: <20260902225708.2379840-2-csander@purestorage.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 3 Sep 2026 11:10:56 -0700
X-Gm-Features: AcwNN1Wk1maw-DrWq2_P78Fm26WaqGkngFVI3rHwve7qSgVEiY7UO24DLet1Cpo
Message-ID: <CAJnrk1Z=JgOGH3m8aMRcK0fBRtnHLQutHGc5aqht3OU3uMQ_qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_111111_132235_22618925 
X-CRM114-Status: GOOD (  19.47  )
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

On Wed, Sep 2, 2026 at 3:57=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> In preparation for setting the io_uring NVMe passthru CQE results from
> the blk-mq request completion rather than the task work callback, split
> out functions io_uring_cmd_set_res{,32}() from __io_uring_cmd_done().
> io_uring_cmd_done{,32}() now call io_uring_cmd_set_res{,32}() and then
> __io_uring_cmd_done(). This allows __io_uring_cmd_done() to be made
> CQE-size-agnostic, with 3 fewer arguments.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
>  io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
>  2 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 331dcbefe72f..67f2ef700c43 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -50,19 +50,21 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd=
 *ioucmd,
>                                   const struct iovec __user *uvec,
>                                   size_t uvec_segs,
>                                   int ddir, struct iov_iter *iter,
>                                   unsigned issue_flags);
>
> +void io_uring_cmd_set_res(struct io_uring_cmd *, s32 ret);
> +void io_uring_cmd_set_res32(struct io_uring_cmd *, s32 ret, u64 res2);

nit: it doesn't look like anywhere else in the header omits the param
name for the cmd, so maybe worth also having it here (and below) for
consistency?

> +
>  /*
>   * Completes the request, i.e. posts an io_uring CQE and deallocates @io=
ucmd
>   * and the corresponding io_uring request.
>   *
>   * Note: the caller should never hard code @issue_flags and is only allo=
wed
>   * to pass the mask provided by the core io_uring code.
>   */
> -void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
> -                        unsigned issue_flags, bool is_cqe32);
> +void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);

Maybe worth adding a comment that any caller using this api needs to
set the res themselves before calling this?

Thanks,
Joanne

