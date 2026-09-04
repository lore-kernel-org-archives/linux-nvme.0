Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B16C624DE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WIcM0Ila/fL0qXdyT+6C5ZW2M8LEsnOQ1TQjy3IHFIY=; b=HIx6vUlIDo0pnryV6hxs7d1OYb
	BImO2c8bJjjqFjuX25BJ/C15DioikngEhuKGKOOnfm3CpEnw3WSPFpNiXNSz7qv/tU5Esrlt+yRSh
	OfekpZAvxBePUiKAeDQKgVpvXDVw7uBFcW9F9jZgNO+Qwp+jIaLxA8WuEMCa+AIGKK+6kzIz2eFea
	GYnJ+teYvLjlHURhbkZVQ8wPq4l5jV92ky0McwkMTzgCjiHQfC1B4wyrTreQRpqR8y6193B2HlkDa
	tKglz27ytY3/nE70XD4FcfTje3YIjFYEDsNdowELMW3wnfKas9ZFtCdlttSmDYMKjag+XoXRsH1Ar
	lL9qQCig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2VQc-00000002SnC-03MN;
	Fri, 04 Sep 2026 15:02:06 +0000
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2VQR-00000002Smc-0uL9
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 15:01:59 +0000
Received: by mail-oo2-x0f.google.com with SMTP id 46e09a7af769-7f4bdf26365so53105a34.3
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 08:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534113; cv=none;
        d=google.com; s=arc-20260327;
        b=A3aFk/3OaHjkgmmipyoi8wN3cgLo8UqvjqQw+P6vSPS7fis/9+2uB+kBT4lyLUfExc
         coIcvoCLKzLwCM7SOrZY/o7tMITbd6WA+g25FRjkemYHo8b/hDKAOeTMbY7J8vhITqzA
         Bx8AxIap9I41LbVtwOJW02Jh9JO0+V0GutO9NZ93V2e9GBD5IjUm60ukYbRlNmqulLi6
         GAjr2FuvpjT1OdHmeSgccA/boBJM5C0gd3eiuu//JedW9NxnIFqAy/HXRTghVAjudKLT
         RcbpAi8L0qf4nrbskKhgp6PHIg6tt8WaByUC1nAUHkSeiuB8jDKEnAOParTaCuM/4oPu
         0qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WIcM0Ila/fL0qXdyT+6C5ZW2M8LEsnOQ1TQjy3IHFIY=;
        fh=gbuudIPwmKD+y+1JKRFQbQA8KOlUc/neqen3Rp4+Nhc=;
        b=Q9uxrr/RchyFKwBVPOPCXvqGAxZndA1bm+sqTLiZO+EWsmHI1MA1LMqXBVkfL+eMST
         sUVUJoiG8p17RGEW/L4U4tg60fVKcD0MH430haK0D5OcNHvY97k9PTsGYh4MUDvRAjVW
         D3VY+87aFwcRf+O0x+k6PjXzLeVGYyRTFbFM9u8kWqjX97lEoSslmBDliV+wEVZLNFjA
         skKtE9UKYEpFY/+GsHoXvJrbT8ZECS4E6AEFfeimqhRVyAk8PHcKwyEY+ph37J2F5BCR
         PKACReDgWFgIgTyadwMtJ6+95LPJWJZJOSFH7kePqTgfMkPnE+o9zNdSzC5IDznbS4Ph
         HEMQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788534113; x=1789138913; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WIcM0Ila/fL0qXdyT+6C5ZW2M8LEsnOQ1TQjy3IHFIY=;
        b=TE8JSQqGwcVczJ5pola6R/Z9IzPGurK/mbWcnnY52MAxYYKc2GH/BQ3p6BTeXQpQ0s
         Vgqevu6JRiGr6LMaiB9TG6InNeNe8Tob4E4uZfeJcITgRUaxiWvD6KyYOwbce+wBclaD
         arg9jTNp42it8O3vc2QAwr7CscDf5Gxv4H4t/OlZqJWO4gOMhVHPQGfvcdGR+GPxgY6Y
         SWSMRJBIhQ0qITx2LKcjUNYnrbr8f8tyRbZq6Fofpssabb1akUIxUbIGJEJeZhLjAxth
         uuIyeqvjQkKj5MFQlRl3yBXP96eZMb6vN8/xy9E6b8krbL9WqVGzR611tF8qeJF7Wxv7
         CK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534113; x=1789138913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIcM0Ila/fL0qXdyT+6C5ZW2M8LEsnOQ1TQjy3IHFIY=;
        b=GPaXFrsJOxr2pDQpoUsrY2gqSvT1N7Vf2k0L4duJkNtGGZ1bvT6A/ubRklKZ2seicB
         e38T43oRFEZMOrNHR9t0tnsP9/s9A2VgKNvBUGwPknhinlPrCIe39UEJ/gHv197g1EsI
         cUbzTSmEIwsIolqoXSb/qURZYG7aJiq2JcjRIRdxSRmRFxg+wFe8qvx9Nzg3mn6CC9UJ
         EKmaH8ke/p3+/vWFgCANwiFL6E8Y0L5tXuZlHrrwwLssxxXJBYwTozR/kjkF5Sa5I9NJ
         x5o5hD6CQsFGoB7v4Qh8fmXS9eTAAcKZxwCoGpLUpHEBOE4qZF235SXSl4p10ZCIt+t0
         y2tQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2olo8/ARzduWE0qhtrq5pz2ABVmIo+nKedrWeva7XolKN/HG+Oz0oJaW6OfcPAbid0R3g79rYAsxH@lists.infradead.org
X-Gm-Message-State: AFuF++k7sG4dLtoZptrVFvGgoZfcVlXrGBN7hAc19IsBgvAaqO9WMkGR
	UWh4zOrQw/Xb8XqFwRNNWhXcZ6Oi7XoR4MAYIOB5G+w4I8xQp+9/W4EMu2pGdBgRkVcmB8Pz80X
	BjAg5mRVFa9SlhPnipCbXrrZfaTuZkE+tAaN9Z77PcnnAVAv6JXlg+KQ=
X-Gm-Gg: AYBFou213S3czZSSjyh9Yh531h8j5ZEHJxLn//DbudLxj87EMQMVTiu2SjQlTesSnWm
	xOu7kNKPyBpal/Xgj0gsDR+Qt/OkH7D1Fu3l8ZUIzDdQN0Dd2UjuIPo0fNZDsmuJkEQ7/YyDRjn
	bRuYeebNaJoeQiB412SSZwC51bEKrgyqkp0NSKXE/pr8XN3+jWoH/dp0W4uk3yiNd96nI3TpYiH
	htFjhtsmO+Y++gptcy4lc6v3VlDp1U5qqUXOJYt8HOycU2AFmpBcWvs6pPUTFHUV31HKqy09c9/
	TM/OykilSIkrsfb4oYy6VBUq8jB0ILL89y9zd0j4qVUK
X-Received: by 2002:a05:6830:668c:b0:7e6:6f9f:7445 with SMTP id
 46e09a7af769-7fa438c3fb7mr2967139a34.3.1788534113297; Fri, 04 Sep 2026
 08:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260902225708.2379840-1-csander@purestorage.com>
 <20260902225708.2379840-2-csander@purestorage.com> <CAJnrk1Z=JgOGH3m8aMRcK0fBRtnHLQutHGc5aqht3OU3uMQ_qw@mail.gmail.com>
In-Reply-To: <CAJnrk1Z=JgOGH3m8aMRcK0fBRtnHLQutHGc5aqht3OU3uMQ_qw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 4 Sep 2026 08:01:42 -0700
X-Gm-Features: AcwNN1Xah8sd8LB6WNip_SsEfqly8NYatZhdOo3fb9Luj2iVfa_QtBKTXyBpkbU
Message-ID: <CADUfDZp2K5_E=PZ6rcyOzRPmRWSboKvTADmNT_L4W5mqoguX_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_080155_458923_5500D538 
X-CRM114-Status: GOOD (  23.70  )
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

On Thu, Sep 3, 2026 at 11:11=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Sep 2, 2026 at 3:57=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > In preparation for setting the io_uring NVMe passthru CQE results from
> > the blk-mq request completion rather than the task work callback, split
> > out functions io_uring_cmd_set_res{,32}() from __io_uring_cmd_done().
> > io_uring_cmd_done{,32}() now call io_uring_cmd_set_res{,32}() and then
> > __io_uring_cmd_done(). This allows __io_uring_cmd_done() to be made
> > CQE-size-agnostic, with 3 fewer arguments.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> > ---
> >  include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
> >  io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
> >  2 files changed, 35 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 331dcbefe72f..67f2ef700c43 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -50,19 +50,21 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_c=
md *ioucmd,
> >                                   const struct iovec __user *uvec,
> >                                   size_t uvec_segs,
> >                                   int ddir, struct iov_iter *iter,
> >                                   unsigned issue_flags);
> >
> > +void io_uring_cmd_set_res(struct io_uring_cmd *, s32 ret);
> > +void io_uring_cmd_set_res32(struct io_uring_cmd *, s32 ret, u64 res2);
>
> nit: it doesn't look like anywhere else in the header omits the param
> name for the cmd, so maybe worth also having it here (and below) for
> consistency?

IMO the name "cmd" or "ioucmd" doesn't add anything on top of the
argument type. But I can include it if people prefer it.

>
> > +
> >  /*
> >   * Completes the request, i.e. posts an io_uring CQE and deallocates @=
ioucmd
> >   * and the corresponding io_uring request.
> >   *
> >   * Note: the caller should never hard code @issue_flags and is only al=
lowed
> >   * to pass the mask provided by the core io_uring code.
> >   */
> > -void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
> > -                        unsigned issue_flags, bool is_cqe32);
> > +void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
>
> Maybe worth adding a comment that any caller using this api needs to
> set the res themselves before calling this?

Sure, that's a good idea.

Thanks,
Caleb

