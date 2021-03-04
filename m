Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F5C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 11:16:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E55964EC0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 11:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E55964EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QWXOa+jc3xD5M0EeUNrLHU1n3uEpHVFSrY6A6GhUb0U=; b=M8RntICq2RRs0xOn28qyvnJFL
	/80fvznN+XnyNraf8e+TIaKDuuUrgmrv//U4f4phII/WqcGkR6KGvRZMOAr4BPmpIFWpxKG3qEccd
	6B8lmzye16f9VZdiyuzUxtIxZQc7wZWGx68u8avcNFbZlhsFfMVaJ8C/yVWW6eyBpFjmAzETRM55Q
	7L55iUAZNPDrHhvVLN7XIor/SP0zZNtkc/PRUMBQFuw1gPOy09JiFSCgA0eYQXHdbte0zjZdu2DTY
	b/V8/KojhACEA/B3ys4MCuu6UXhUPq8aYNj6bpDDhkFgBaCZ9vHgIr+Z1ZGLtdJfE0alp0M+k11hX
	SNQ6XFeCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHlxr-008R2t-J0; Thu, 04 Mar 2021 11:16:23 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHlvd-008Qny-Lm
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 11:15:06 +0000
Received: by mail-wr1-x433.google.com with SMTP id w11so27151653wrr.10
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XHyKrwKq5fM3r5AB9uFmBKte7bjeOG4uqO0BOTAF9iM=;
 b=t0+/ozwJOMXGEwWqXoKLUJbZqK+mDJmV77TlWnFnbAsMQTn7g4lw29sBgVmBneyB3Y
 lVZT6snMo/Iy1Degs5UxnKjV/FWU9VdVqpmp4LwNUwY67W5Qh47GPbjWjUmOJsrw+iK3
 eKcFMASTtZJFcCBgdmiL+MBNpRYo3FYktADMATtPNIeBN1twpUbGK5q9qoL7PbJFE1fT
 JNfL0g7/MOai8LhTWTq7R7yOy0PzpphvUWqYF/wQj+R3vZvCW93GONOnV/PyMvq/d1HN
 uadfKpNP187UYv45lI8EFq20hRInPhVVsK3oppPRgI+33y7P0M3a8KjdEChfvyEqWICs
 n2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XHyKrwKq5fM3r5AB9uFmBKte7bjeOG4uqO0BOTAF9iM=;
 b=G5foVu+zcDP67V0IT3dPtH7NqJCpUWZZNHTfndg5HqeXOrA0nP0j+yxqUlg0b8ifHJ
 67O5JVoRQX0wNHfKYPmcj3RsAW2ymEh/W0CTc8OpBNAmt4qRPNDdbmuskhX4Qs2Ltb+h
 +jb47x83mqj3xsYdK/DLgciZ1mSbPq639rp1AeY3i4Oi//mUmVN5kyF9RpzlGbJX+KUA
 gyL2zPR9biN7jF2S+1Q73MJ4Ey1wRrcTKKGjPexPXatrSfFuvK4XlwnnEbGIeT/kpFHj
 MMufJ86vKCcfCwn3o87WXnnb1YbOsRU3cd2NPtFUFGH9haLIqwoj1UH00lmhf56MEcQx
 h6Kw==
X-Gm-Message-State: AOAM530NKxJeyJUQPauMXupiDRCnwvRZqQK9dXCe9767VdrWwh1kg5eC
 XSJHVM1KL50BEE80//bUk51DKL94MYg6R6q7LUw=
X-Google-Smtp-Source: ABdhPJxvnPsChJuZZkZHA7KIyT8WcIkX1Wnhrb+H3ITh1Q2I09oASAvRbI09lvplRSkwhHVHI5XSPf7PG641Utl7wyk=
X-Received: by 2002:a5d:4286:: with SMTP id k6mr3456316wrq.278.1614856437853; 
 Thu, 04 Mar 2021 03:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc@epcas5p2.samsung.com>
 <20210302160734.99610-3-joshi.k@samsung.com>
 <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 4 Mar 2021 16:43:30 +0530
Message-ID: <CA+1E3rLCSWDmLa1rrZ986xnbx6fcsGgBE6NPP59eJj4swY+gQg@mail.gmail.com>
Subject: Re: [RFC 2/3] nvme: passthrough helper with callback
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 3, 2021 at 8:52 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 3/2/21 23:22, Kanchan Joshi wrote:
> > -void nvme_execute_passthru_rq(struct request *rq)
> > +void nvme_execute_passthru_rq_common(struct request *rq,
> > +                     rq_end_io_fn *done)
> >  {
> >       struct nvme_command *cmd = nvme_req(rq)->cmd;
> >       struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> > @@ -1135,9 +1136,17 @@ void nvme_execute_passthru_rq(struct request *rq)
> >       u32 effects;
> >
> >       effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> > -     blk_execute_rq(disk, rq, 0);
> > +     if (!done)
> > +             blk_execute_rq(disk, rq, 0);
> > +     else
> > +             blk_execute_rq_nowait(disk, rq, 0, done);
> >       nvme_passthru_end(ctrl, effects);
>
> This needs a detailed explanation in order to prove the correctness.

Do you see something wrong here?
blk_execute_rq() employs the same helper (i.e. nowait one) and uses
additional completion-variable to make it sync.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
