Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2630EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2HCgTW6tUM7DEFamof1h4tm/dHfLYbO8BtWVBOKqMwU=; b=oIGVZNi8E0o/KFAhQ0o6xT6OSu
	708y/t8b2dIOKgysBGij+1PIw4f/5B1HHEh57FES5Jgvyvtpt5Ne5Wwc7nswVhl2uU/GqBZ4dj5xg
	0+cmixfho259/BslFhjJUi691VcpnrSTsTBumgFuUgXm85nzGFDjXROVc3Hu36J1Ptimu7WYJjGt7
	8hsgXUxECqY2rqND4IDCqO4a8s64hBCavAQOcMDjK4ocl6msRcpDaBf1Gwt6fA2MMz6UAmEJ4Xe7K
	sfPvaUdzlw1sAzq1AiRLom7xJTEXSX4UP78yfXhmftpN8XLJNBM5frX66WuDhoqEehUOkji7vugMO
	Pp5wOyGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSHJb-00ChTD-7e; Thu, 10 Mar 2022 11:50:43 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSHJY-00ChRo-BN
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 11:50:42 +0000
Received: by mail-lf1-x136.google.com with SMTP id bu29so9055452lfb.0
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 03:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2HCgTW6tUM7DEFamof1h4tm/dHfLYbO8BtWVBOKqMwU=;
 b=qjSfnZolpLXexD4ysKMJx7z2iy7RSLmEydG1gUF0kZ6pnev5NF4zCn/mc2ym6OXH1h
 zrDf2WEDTBODUV9dGZHLbkh0nxcrk6skioLy2gvwGhzkOSdfJGfUYaYgl5q+tZfQSezQ
 nNktgy9uE0lrm09glMwhuHw4gb+bLrj3va6vCteSorTizOgxZ0rmHJ3HWAvpE5nIAu0C
 8M2Md7Bx3eDT8XXKDZE3zoSpTgsmKEu7HqFAMLWc3YXI48Gu1qtXKAXCJDnuPALg1Itz
 lygCOlnVNb5jSPmbgPIOAkIGVnIx6ZhAeClUQP99iLzaEAbeeJYGd+fpQg63IPK7JasX
 jdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2HCgTW6tUM7DEFamof1h4tm/dHfLYbO8BtWVBOKqMwU=;
 b=elHB4N8/Jidlpp0KKKMjB0zVOMNh0x+hRYaQaVZZqMHHiQR+JPWIsTqo7tQKsbY0V1
 xlDPTYTU5SY6NXPMkGBLrCmoU2Um52Qjb6uME39pYGfaGmz7HZ+aKSd20K8JyAPHwZUn
 Ph2jFCBO1kukE2lB+tBunykF6lx99ZDpL13zC/EqFq/aCE+U/C6WlWF0cL3ZcMazd9B3
 8qUR77feyWDMtIlBWtxqaq9iA4A69nizyMRxdKre2hzOyeYZpsLIQMKLd7aXQj/ueRY/
 QlqSMwGh8Z1ssfL+j7KbjHLaI8IlnJfMoVaD7Cy8WRWPwvqIIBLPI/jb1w8zsCClKUMP
 LFsw==
X-Gm-Message-State: AOAM531zOoDo7EcInCwkJIIUfr2Rr2KQzq08XaezTsM1qwDCP0zB+3LQ
 udD4zOkeMtKlcoeTbVqKsbEHg/OAQCoT9Zqt1Rk=
X-Google-Smtp-Source: ABdhPJyjVMSSENplit9xn7OPOjyV+zTxySFK+J9bgJ4QXkoieP+kCGLzFuJAzf/aP0M1vQ3ynfDAfGm0lc6zuCTIu+Y=
X-Received: by 2002:a05:6512:16a8:b0:448:6188:f8a8 with SMTP id
 bu40-20020a05651216a800b004486188f8a8mr1835823lfb.650.1646913038539; Thu, 10
 Mar 2022 03:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
In-Reply-To: <20220310083652.GF26614@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 10 Mar 2022 17:20:13 +0530
Message-ID: <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
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
X-CRM114-CacheID: sfid-20220310_035040_440091_62BD66B5 
X-CRM114-Status: GOOD (  18.90  )
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

On Thu, Mar 10, 2022 at 2:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 08, 2022 at 08:51:05PM +0530, Kanchan Joshi wrote:
> > From: Anuj Gupta <anuj20.g@samsung.com>
> >
> > On submission,just fetch the commmand from userspace pointer and reuse
> > everything else. On completion, update the result field inside the
> > passthru command.
>
> What is that supposed to mean?  What is the reason to do it.  Remember
> to always document the why in commit logs.

I covered some of it in patch 6, but yes I need to expand the
reasoning here. Felt that retrospectively too.
So there are two ways/modes of submitting commands:

Mode 1: inline into sqe. This is the default way when passthru command
is placed inside a big sqe which has 80 bytes of space.
The only problem is - passthru command has this 'result' field
(structure below for quick reference) which is statically embedded and
not a pointer (like addr and metadata field).

struct nvme_passthru_cmd64 {
__u8 opcode;
__u8 flags;
__u16 rsvd1;
__u32 nsid;
__u32 cdw2;
__u32 cdw3;
__u64 metadata;
__u64 addr;
__u32 metadata_len;
__u32 data_len;
__u32 cdw10;
__u32 cdw11;
__u32 cdw12;
__u32 cdw13;
__u32 cdw14;
__u32 cdw15;
__u32 timeout_ms;
__u32   rsvd2;
__u64 result;
};
In sync ioctl, we always update this result field by doing put_user on
completion.
For async ioctl, since command is inside the the sqe, its lifetime is
only upto submission. SQE may get reused post submission, leaving no
way to update the "result" field on completion. Had this field been a
pointer, we could have saved this on submission and updated on
completion. But that would require redesigning this structure and
adding newer ioctl in nvme.

Coming back, even though sync-ioctl alway updates this result to
user-space, only a few nvme io commands (e.g. zone-append, copy,
zone-mgmt-send) can return this additional result (spec-wise).
Therefore in nvme, when we are dealing with inline-sqe commands from
io_uring, we never attempt to update the result. And since we don't
update the result, we limit support to only read/write passthru
commands. And fail any other command during submission itself (Patch
2).

Mode 2: Non-inline/indirect (pointer of command into sqe) submission.
User-space places a pointer of passthru command, and a flag in
io_uring saying that this is not inline.
For this, in nvme (this patch) we always update the 'result' on
completion and therefore can support all passthru commands.

Hope this makes the reasoning clear?
Plumbing wise, non-inline support does not create churn (almost all
the infra of inline-command handling is reused). Extra is
copy_from_user , and put_user.

> > +static inline bool is_inline_rw(struct io_uring_cmd *ioucmd, struct nvme_command *cmd)
>
> Overly long line.

Under 100, but sure, can fold it under 80.


-- 
Kanchan

