Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FEEC83F10
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vmal4hn0XBHdSL8GzE89VF+dr7kcGENPa2m8SJGidbg=; b=KpHhg63x5YptfPCs7FSXvDBc3y
	YY5IF/ps3/h5GOwVSCo2Hac8FBhJ1n/YiV4pGQNUl5vhh/oU5Ah3Qb3AeuYyyCcc3jgzsAQ6G+QmT
	7pf9AEgFuZpxRsq9QjVBL56+RA6JGb8cA4l5K83/9h0N4VRYkAvkOsprij/XnVf4pnIu5cgFZ/jyq
	DMxQ1HtkvzRzmF4SzsrvSpfHvFCkaAFIZiUegyucMnlxaXnwBPL/J02Vgp1AFs9mUl9PXdDU8Qm0C
	SNFnocAI5/7JGID1t2z/1E7SOhz5c9YTRHJoRGLTtXiWDyu/EHzpcJu3xBo+i0s2k30tjrEdKRh1P
	ngUdujug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaQai-008eWC-0i;
	Mon, 28 Aug 2023 00:58:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaQad-008eVP-0S
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 00:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693184323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vmal4hn0XBHdSL8GzE89VF+dr7kcGENPa2m8SJGidbg=;
	b=bAyEj4y6/c6GsNB6VrZQRXcAoxHI0Gye3lZZtDjRZKM6pB3mky6KChOOdMDgpLe3QswSDB
	gj33awiXTFHYMwANeqPqfrwQZMrKaVvt3x2dcAQ9Pb5+HFP6ZRxDMzSMvQyuP7fmv7UT84
	c59X4XzyRo81S42jgMbMkJnqe4x9+PU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-lJWpz4JOO7qD_QSYfbPT_g-1; Sun, 27 Aug 2023 20:58:41 -0400
X-MC-Unique: lJWpz4JOO7qD_QSYfbPT_g-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-48fa8d86dedso217397e0c.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Aug 2023 17:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693184321; x=1693789121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vmal4hn0XBHdSL8GzE89VF+dr7kcGENPa2m8SJGidbg=;
        b=BvVLkVEB6ZxRGZMoC17iSzxhhTrbQyuvFaJGN0JZ0NpodwIqiaQEd/Pu42vFO65xBQ
         2fK0WzhPxadZTYdSRY7309ZqCJN/+wC5DwKsCkUdDBx/98vA/vCSIY/mnQMrdx8xVNHm
         DZRvp2NwwIkpy32mVeMYVtqhdtx8wk5gi1e70GZ9JkM1iSXuGfyJZ7vKkiXENjmSdYPN
         /UCR2sXhI/wSqBUqf3dtTsO85BekvzDFR885lT4tiohOkkFRggnYb8tTDL8eJvchLVBd
         quwqBswmBQ/KjkDmG7ApjfwbJTJ3fGsV3rKXUbDNTN1NYiMcndoMfZrPAeYxjjNHgVzZ
         jThw==
X-Gm-Message-State: AOJu0Yy3cHuSBjTUADh1bMLIhWBXDHn1E3/zJ+xg4+dQCUIs3VzGOx8V
	uB8yav/BcuV4wtfMbrd3CDyIFnXPFg4etfQMmjXSGFbFM9p906ceG4yog2ReOpZJbDUakyJg+/j
	VbPTN+GwkqQjaGwwrurEvonaa8eF4Ay/VxigVdMNAAtw=
X-Received: by 2002:a05:6102:3082:b0:44d:626a:f079 with SMTP id l2-20020a056102308200b0044d626af079mr11011475vsb.3.1693184319865;
        Sun, 27 Aug 2023 17:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk8x4y0ZS8y62BRq47uQm/s83tXzZyWyVZwGWwniyN2eYrb2TIg9cR3GcQ+RXT4nTqSvOaZ2XdGbeTF7tcLfI=
X-Received: by 2002:a05:6102:3082:b0:44d:626a:f079 with SMTP id
 l2-20020a056102308200b0044d626af079mr11011470vsb.3.1693184319657; Sun, 27 Aug
 2023 17:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230818140145.1229805-1-ming.lei@redhat.com>
In-Reply-To: <20230818140145.1229805-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 28 Aug 2023 08:58:28 +0800
Message-ID: <CAFj5m9LGi4zxvDYqTvSHYh=Ra3YHUMe3nePZqJsMfEXttbrgMA@mail.gmail.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
To: Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_175847_266795_5EB5CA10 
X-CRM114-Status: GOOD (  15.17  )
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

On Fri, Aug 18, 2023 at 10:01=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
>
> Then dead lock is caused:
>
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
>
> 2) error handler is waiting for CPU hotplug lock
>
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
>
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly()=
,
> in which two stage spreads are taken: 1) the 1st stage is over all presen=
t
> CPUs; 2) the end stage is over all other CPUs.
>
> Turns out the two stage spread just needs consistent 'cpu_present_mask', =
and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.
>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-block@vger.kernel.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
>         - reuse `npresmsk`, and avoid to allocate new variable, suggested=
 by
>         Chengming Zhou

Hello Thomas and Jens,

Ping...

Thanks,
Ming


