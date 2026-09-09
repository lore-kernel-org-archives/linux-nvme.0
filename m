Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83384C79FA1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 01:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hmw9mHUujeHSHQsiGBgyx28Z2MxCV5kUwvQrLiZ0yQ8=; b=WX/okOnqFmlcLREn7wL90gw/mJ
	y1kO/nIaDIXCumorpfL86cCMfS8wcyGTQHTbg+mH5rb7b5il3t3IjcQxg7M8KJjAoFQ1q5xYdHK7Z
	ytqC4J28JFIoOMCq+LuuTDuleJh3RLBMmA7DxmsJ35Pu1JQFLT3CIWeVT8ZxgECiUSwCEop/OvsnO
	2J4MSB/fhDvA0Fvk/ePk/I0reopqgeTvlRHSFg3UbnUuc/9uD4N3re5AJHJRV732PONNg99vAVUpy
	7QRgWRUw8ZTxfjr2p1q/DOGkDEAkgQz7bWqJt5UJ0O6ZJ2/2Y3FRpNkQg4IaT9S001GXCew+E+iFB
	JFmB9Mbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46vf-0000000AadI-453q;
	Wed, 09 Sep 2026 01:16:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46vd-0000000Aacz-3FL6
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 01:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Hmw9mHUujeHSHQsiGBgyx28Z2MxCV5kUwvQrLiZ0yQ8=; b=OcFGWxCgQlIBNxFYNdtGo8zu5k
	Noke5PalhZrj8FbWr7nDq/tTnzNCPBaw6cGztJW81PAHlOCk8tbO6wuUU+nJIzjzip395muETZE1k
	2JLLqXKZjnabaeKhoEeD8SUeE/k090BcohAZh687Qq77jvvlsbcrSqZ8vorXlh+4El7s7r6OeyACL
	JrQrw8zlH2hL6LO6exCPFqMZ1wqR72fCWvAV0EdlaQz31wntmWlsojERuag4BnJw3oaGQrmkUtvrv
	sKehhClSfk2dG/6taOoC/iBXqsg8ON6WhFAe85d/5wOtDFIkUKuJTaOHekJn6/Ib15BgMZICs3Idk
	vO6yyCTQ==;
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x46va-00000000aVA-2QTn
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 01:16:44 +0000
Received: by mail-oi2-x10.google.com with SMTP id 5614622812f47-4b37a30eb3bso498587b6e.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2026 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788916600; x=1789521400; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hmw9mHUujeHSHQsiGBgyx28Z2MxCV5kUwvQrLiZ0yQ8=;
        b=gi3tdPsnoptZ35IWrUTkkUmT/8hA+i41XBy2/lNQ2D3Z/nPjFv/dWxjeVfADQBwyeT
         A1GSp3WvySzvST6PbeOtWPWiZFEyiWXeFYm1kzYhc0XEBw1DD29y7zdHLHZ5vOnJ55Zy
         FogavCyXt/2SifcR2FTjLGa3T376dCJCc/2ZBBS/TKKia5yarca7eWoF1WQ93sfst02y
         m8SoVQN2kAtisONFlr+RNtozA7pwjqzMWlYKjfQhz7h5eHjlv2n7zUNxqeRNuCB08ghT
         HmjdGR6TKY4ptsZ8YfY1o8/X1zSclr6gaoMAHqr0X9cmuNg33o0zXScY49E+fwJnV0dH
         SCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788916600; x=1789521400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hmw9mHUujeHSHQsiGBgyx28Z2MxCV5kUwvQrLiZ0yQ8=;
        b=RnYkHTlYwAYvWt4tYdEitWpVQD/CYIXa3mu4E5KEb0qXRM8oA8x0TnTV7Y+64CowAK
         nkD1zbS+TAtd4vLjSUrs1lhWzwKzoBI3QMBGetjUnVvX7J2UzzZnXcd+eQsNotOIKEUt
         0RAERSLf7iRa/hh0eOWMafDWPP0kSrjBw9AQnTTo8E1KoPj6d1OBbwjpq7IWtAJluCQK
         EuJAF+aB+1tAMP0EFcuF9AnL62Lb9xu+y/y2xgBpGorz8p02PLXaIylWXuxlIi4UpzWP
         Oj8exBQ6ZRxQOZXHOI2wxIm2PgkzeC3k7kOkJ4Qs+24GPHMTrLCJmpN/CsL3g813cUQR
         eQhw==
X-Forwarded-Encrypted: i=1; AKwUvBxU1jk34Nv+1ZIvz4OLVkwPQPgGsYQ6L1xOjw0M9VrKEDSxJ9R+7LBq8busmdRr9WuWjHTNGnxJIfkg@lists.infradead.org
X-Gm-Message-State: AFuF++m+eOe8dws06j569tXmGRi1bU9WV2CrFVfw+Tu3aNirzeAph1IC
	kdtWgvK2BMrJdvT0kBf5jv1jDxeU7BWSJLcweEXq7MHHyUYIzkDYA2spX/S+eOEfAWs=
X-Gm-Gg: AYBFou1YcNWjSs0J36BcjpjV1R9OCDY01DM7nvNeVD1sGE+Xw995XyS8ojzyobBkP1Q
	3cmF2N3GU+IWVCZGfPX87ENx2ZQz3mgLyxz9qqHV98pn+IkuUVvhOBWOUdJkGihRCXvCqlMbPk/
	YreaUvJcle7MWjB8LphDV5rgdvZsBXprV4jTjdA+UPLtSLsGrNb2Si6RbXIhHxQNFfplPbumi2D
	jjQ5nf5VdpPRxIXVF1Z/nGG3bBOYSMoRyR2665qydaJEWxMRteGZoCJvlb9OTYHfBOUoi8KLArc
	K2khnFSQ9jpOAXiDsFiqZX69xctj5PIoXy7lXZxjxXON3PN68xy36B9CynEMyGkwgqlr9WKOtiF
	mUEdDr1mkKFtXjDe5+ePAOxe7SVkvnQZHoz1J55I2jnZSZVMg5jI9ZRqN8cUdJtQhMaqZDTHNRM
	FXynGLTIFwCSw/eWI8jsv+yuKfIlgYBATQ9QsR8304Sd+AisbMLL6WIwcYcGuNJDcp1ccoZnL0E
	Xrs7LLfjIagzgHDyDw/vGfEIw6GWBrpiTaz3GToRDF5xZSDBql00gO6Vw==
X-Received: by 2002:a05:6808:199b:b0:4b3:7a14:6b25 with SMTP id 5614622812f47-4c0250d649emr3573933b6e.14.1788916599799;
        Tue, 08 Sep 2026 18:16:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971675a96sm15488974b6e.11.2026.09.08.18.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 18:16:38 -0700 (PDT)
Message-ID: <c21acbbb-6558-48d4-9379-c1a952acf1e4@kernel.dk>
Date: Tue, 8 Sep 2026 19:16:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] io_uring/cmd: split io_uring_cmd_set_res() from
 io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Joanne Koong <joannelkoong@gmail.com>,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902225708.2379840-1-csander@purestorage.com>
 <20260902225708.2379840-2-csander@purestorage.com>
 <CACVXFVOKGOEmefHmZpsBX-7uxGjzbaJiueYMvka8TDjccOuFjg@mail.gmail.com>
 <CADUfDZqFLMS08wq0bJWQwKpJL5k9ty1bruVFQFcV6juFVB-9AQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZqFLMS08wq0bJWQwKpJL5k9ty1bruVFQFcV6juFVB-9AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_021642_883690_F00014A1 
X-CRM114-Status: GOOD (  21.59  )
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

On 9/3/26 11:34 AM, Caleb Sander Mateos wrote:
> On Wed, Sep 2, 2026 at 6:02?PM Ming Lei <tom.leiming@gmail.com> wrote:
>>
>> On Wed, Sep 2, 2026 at 6:05?PM Caleb Sander Mateos
>> <csander@purestorage.com> wrote:
>>>
>>> In preparation for setting the io_uring NVMe passthru CQE results from
>>> the blk-mq request completion rather than the task work callback, split
>>> out functions io_uring_cmd_set_res{,32}() from __io_uring_cmd_done().
>>> io_uring_cmd_done{,32}() now call io_uring_cmd_set_res{,32}() and then
>>> __io_uring_cmd_done(). This allows __io_uring_cmd_done() to be made
>>> CQE-size-agnostic, with 3 fewer arguments.
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> ---
>>>  include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
>>>  io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
>>>  2 files changed, 35 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
>>> index 331dcbefe72f..67f2ef700c43 100644
>>> --- a/include/linux/io_uring/cmd.h
>>> +++ b/include/linux/io_uring/cmd.h
>>> @@ -50,19 +50,21 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
>>>                                   const struct iovec __user *uvec,
>>>                                   size_t uvec_segs,
>>>                                   int ddir, struct iov_iter *iter,
>>>                                   unsigned issue_flags);
>>>
>>> +void io_uring_cmd_set_res(struct io_uring_cmd *, s32 ret);
>>> +void io_uring_cmd_set_res32(struct io_uring_cmd *, s32 ret, u64 res2);
>>> +
>>>  /*
>>>   * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
>>>   * and the corresponding io_uring request.
>>>   *
>>>   * Note: the caller should never hard code @issue_flags and is only allowed
>>>   * to pass the mask provided by the core io_uring code.
>>>   */
>>> -void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
>>> -                        unsigned issue_flags, bool is_cqe32);
>>> +void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
>>>
>>>  void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>                             io_req_tw_func_t task_work_cb,
>>>                             unsigned flags);
>>>
>>> @@ -105,12 +107,19 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
>>>                                                 int ddir, struct iov_iter *iter,
>>>                                                 unsigned issue_flags)
>>>  {
>>>         return -EOPNOTSUPP;
>>>  }
>>> -static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
>>> -               u64 ret2, unsigned issue_flags, bool is_cqe32)
>>> +static inline void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
>>> +{
>>> +}
>>> +static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret,
>>> +                                         u64 res2)
>>> +{
>>> +}
>>> +static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
>>> +                                      unsigned issue_flags)
>>>  {
>>>  }
>>>  static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>                             io_req_tw_func_t task_work_cb, unsigned flags)
>>>  {
>>> @@ -171,17 +180,19 @@ static inline void *io_uring_cmd_ctx_handle(struct io_uring_cmd *cmd)
>>>  }
>>>
>>>  static inline void io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret,
>>>                                      unsigned issue_flags)
>>>  {
>>> -       return __io_uring_cmd_done(ioucmd, ret, 0, issue_flags, false);
>>> +       io_uring_cmd_set_res(ioucmd, ret);
>>> +       __io_uring_cmd_done(ioucmd, issue_flags);
>>>  }
>>>
>>>  static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 ret,
>>>                                        u64 res2, unsigned issue_flags)
>>>  {
>>> -       return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, true);
>>> +       io_uring_cmd_set_res32(ioucmd, ret, res2);
>>> +       __io_uring_cmd_done(ioucmd, issue_flags);
>>>  }
>>>
>>>  int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
>>>                             void (*release)(void *), unsigned int index,
>>>                             unsigned int issue_flags);
>>> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>>> index 726a659f38c3..917b32a921e6 100644
>>> --- a/io_uring/uring_cmd.c
>>> +++ b/io_uring/uring_cmd.c
>>> @@ -136,40 +136,43 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>         req->io_task_work.func = task_work_cb;
>>>         __io_req_task_work_add(req, flags);
>>>  }
>>>  EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
>>>
>>> -static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
>>> -                                         u64 extra1, u64 extra2)
>>> +void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
>>>  {
>>> -       req->big_cqe.extra1 = extra1;
>>> -       req->big_cqe.extra2 = extra2;
>>> +       struct io_kiocb *req = cmd_to_io_kiocb(cmd);
>>> +
>>> +       if (ret < 0)
>>> +               req_set_fail(req);
>>> +       io_req_set_res(req, ret, 0);
>>>  }
>>> +EXPORT_SYMBOL_GPL(io_uring_cmd_set_res);
>>> +
>>> +void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2)
>>> +{
>>> +       struct io_kiocb *req = cmd_to_io_kiocb(cmd);
>>> +
>>> +       if (ret < 0)
>>> +               req_set_fail(req);
>>> +       io_req_set_res32(req, ret, 0, res2, 0);
>>> +}
>>> +EXPORT_SYMBOL_GPL(io_uring_cmd_set_res32);
>>
>> Both the two helpers can be inline, can't they?
> 
> I also wanted to do that, but req_set_*() are defined in
> io_uring/io_uring.h, an io_uring-private header, whereas
> include/linux/io_uring/cmd.h is a public header. Perhaps the inline
> functions could be moved to include/linux/io_uring_types.h or
> include/linux/io_uring.h. If not, I think we'll have to rely on LTO to
> inline these calls. I'd be curious to hear Jens's thoughts.

Let's just move them to io_uring.h instead.

-- 
Jens Axboe

