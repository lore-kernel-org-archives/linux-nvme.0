Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BD0C36008
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xgEexH4YlzNQooQdAkGITDiRNkQG2ag5mUu5UecmzPo=; b=lpp3QajmrjxbCZRQM4wdZoYCX8
	0TfPB0367I87YRjK7buiENb6x5f1Ut3GtWqhku9tdhJjYQQwZ8PBbXYoi85mexl4mybP6ZhejfjUx
	vW97bZfWCNdTthtLm/Te75eojGGoj0DYHYa6FExmF8sgLiftUYpP4oP2WfbkMIQhrOgczvUhBUPWJ
	IiIwxLv0/ZF2KnVFoa4ox9Ngtcy/yOhT/Gdalb129v5kyxVnaUHmJInZIxYc7+7YOmZAEh5wZBiGu
	86GhKcn4mYE5xEiNiR6M5scktDCVJba/JzpBFSfO+NN8Fy6Qo5uAWiDiWW+VCKYG8A9kITyRYgeSt
	uDuTxj+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjsA-0000000GLrQ-09jP;
	Fri, 21 Mar 2025 21:25:46 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjqk-0000000GLZw-2TPN
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 21:24:19 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so615742a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742592258; x=1743197058; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgEexH4YlzNQooQdAkGITDiRNkQG2ag5mUu5UecmzPo=;
        b=d5a51eMVIpNV7gbpaR2en593/k5Mr/1r46s03PQcBlA0725u19EPPGLMbDNPnHItDv
         3dlGf6OLExUwW18JeQrlYLlCmeGDFJklI6ppLxgCyGPXqJ04CRcQdrx4NLAhbp150TVz
         DF6X18u58qgX4O7GTdh/yWadTv16HoTHUShwFjvkqpyE3GRSAvZJ/WOGe9J+NseCAQGE
         JcwQn/mVJObLME7IOY1Z2rWfmj5Mjs7wowoMYFjeap/olLR+kjrYosz2G4sIgsKh0X9m
         LI45tB3DTMcoo+u+KIxa6RJ830h91NrXt5G+jETu03WizMYF7BJ7waYzCCq6WSfjAiZd
         3Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592258; x=1743197058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgEexH4YlzNQooQdAkGITDiRNkQG2ag5mUu5UecmzPo=;
        b=Loye8axKyngR0NQ/BIvRCBuSPaCXDjvs2lHa7uhypKBt2qdlVv35KCpM+LBHh2A226
         weBc9SmiU+rayeC2mRv8DMeW011Y0ylj5mAPT08sqzbU2XajZ1RLJGuKO1JfiVwLPZCW
         sW278ksZYo1Op+bl8armNuaQIBqAsfT1bhjRXHk31nViqVB6S+IUAJt6qB6U5JvM5b25
         Wu8ABQfDyveT/IVu20oMcaBIifcQcDbzDxQtG+wXYPLZNZaUYflpORyCmfy5ALK0w4Dd
         hGhgIdPPXWNj8m36700WoZzFAme4eEFX6M9C5bZuQw/eBPAsuKWge7K1T+Dxj+8jG+88
         P4xg==
X-Forwarded-Encrypted: i=1; AJvYcCVv6Ku/VRniv0RRmUOYe63qipV1qd+nW4f3tOKvsGnAlFi9SmKOYQR4Djlc3JX8DPg01QLiAeM90Q4d@lists.infradead.org
X-Gm-Message-State: AOJu0YxKQbxTpBRsym20X3ZBGq2wjRqPXFe7OQBBHDufmgJMXJxBwSDv
	q0Nc913c1lCBrqp8a/sprxMUhZLoA2q0JzDI7wgwjjiEjGh+iVGqbrbezh2jhh/5LeuRT3REor8
	ije01GQVh/6GST4/ydzNFem1nPBf2mCzW7nS+bA==
X-Gm-Gg: ASbGncs4XnMAzxWAJAFFMrmmGGFIqf6g91FwsAX6GDN9S7s7vm3Iwe0EdGS966XcoaU
	W8P8/mwfbbLlnCnZeoMJTRVKt5PRExgk4stKfQ2dRdpR+s2DiscJFtOe14SZ2qpyLbI0SNaWl8W
	ndbJdp+3Mg3bLATWDJEw6D20P6
X-Google-Smtp-Source: AGHT+IEWKjJGtm5ghineH2xwXYNT84KCnqIRLDNZSQSW8P28Btfs8lapQkXp4I96X8icAPuhtpGyDCSg8I4uBIG6u90=
X-Received: by 2002:a17:90b:3a86:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-3030fe6df4bmr2143070a91.2.1742592257499; Fri, 21 Mar 2025
 14:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250321184819.3847386-1-csander@purestorage.com> <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
In-Reply-To: <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 21 Mar 2025 14:24:06 -0700
X-Gm-Features: AQ5f1JovqdCIrHb51iECUiV7-0VxJPfIpPS2a0CZYqJvx9jgCUTe3TWJ9VOPsBk
Message-ID: <CADUfDZo5qKymN515sFKma1Eua0bUxThM5yr_LeQHR=ahQuS_wg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_142418_664054_33670827 
X-CRM114-Status: GOOD (  34.01  )
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

On Fri, Mar 21, 2025 at 1:23=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > To use ublk zero copy, an application submits a sequence of io_uring
> > operations:
> > (1) Register a ublk request's buffer into the fixed buffer table
> > (2) Use the fixed buffer in some I/O operation
> > (3) Unregister the buffer from the fixed buffer table
> >
> > The ordering of these operations is critical; if the fixed buffer looku=
p
> > occurs before the register or after the unregister operation, the I/O
> > will fail with EFAULT or even corrupt a different ublk request's buffer=
.
> > It is possible to guarantee the correct order by linking the operations=
,
> > but that adds overhead and doesn't allow multiple I/O operations to
> > execute in parallel using the same ublk request's buffer. Ideally, the
> > application could just submit the register, I/O, and unregister SQEs in
> > the desired order without links and io_uring would ensure the ordering.
> > This mostly works, leveraging the fact that each io_uring SQE is preppe=
d
> > and issued non-blocking in order (barring link, drain, and force-async
> > flags). But it requires the fixed buffer lookup to occur during the
> > initial non-blocking issue.
>
> In other words, leveraging internal details that is not a part
> of the uapi, should never be relied upon by the user and is fragile.
> Any drain request or IOSQE_ASYNC and it'll break, or for any reason
> why it might be desirable to change the behaviour in the future.
>
> Sorry, but no, we absolutely can't have that, it'll be an absolute
> nightmare to maintain as basically every request scheduling decision
> now becomes a part of the uapi.

I thought we discussed this on the ublk zero copy patchset, but I
can't seem to find the email. My recollection is that Jens thought it
was reasonable for userspace to rely on the sequential prep + issue of
each SQE as long as it's not setting any of these flags that affect
their order. (Please correct me if that's not what you remember.)
I don't have a strong opinion about whether or not io_uring should
provide this guarantee, but I was under the impression this had
already been decided. I was just trying to fix the few gaps in this
guarantee, but I'm fine dropping the patches if Jens also feels
userspace shouldn't rely on this io_uring behavior.

>
> There is an api to order requests, if you want to order them you
> either have to use that or do it in user space. In your particular
> case you can try to opportunistically issue them without ordering
> by making sure the reg buffer slot is not reused in the meantime
> and handling request failures.

Yes, I am aware of the other options. Unfortunately, io_uring's linked
operation interface isn't rich enough to express an arbitrary
dependency graph. We have multiple I/O operations operating on the
same ublk request's buffer, so we would either need to link the I/O
operations (which would prevent them from executing in parallel), or
use a separate register/unregister operation for every I/O operation
(which has considerable overhead). We can also wait for the completion
of the I/O operations before submitting the unregister operation, but
that adds latency to the ublk request and requires another
io_uring_enter syscall.

We are using separate registered buffer indices for each ublk request
so at least this scenario doesn't lead to data corruption. And we can
certainly handle the EFAULT when the operation goes asynchronous, but
it would be preferable not to need to do that.

Best,
Caleb

