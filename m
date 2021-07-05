Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024EC07E98
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 07:44:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDE16115A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 07:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDE16115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pYr+AeiwL1UFnrLf8uvcmD3o5BPw1yZlMIQFClUWOPk=; b=1aPrPlVQTss5/6
	NDZsJQ1xV6FRX52UxUTHK+9zUftAZ+cLkIn6Vgkn9cMMLuGcSuftxtSvsNR6TaGjd2C98uF9mM2z5
	6patqFdySOMfRUthLCh8on+QX4ogg1y1lZlv0kz/KhZeUakbMecTiANwR0PP+sAs9ZDAiAv7q0/ag
	QxlkEyvNK9LLrZEqLUkV6moWs1TQjneCH6LjiPsTL8ANuRadr4e8S0w8MtYmiTY9hmNN9qt9HLlge
	a//5zGrTLElYqGnkBWYdL2TuVvO+CFIUlRlRp9nyb7VCoIAfPoY5K6ds1B99kC+EmU7Htxj3vXRAD
	F3GdxvAvf9uINRN3u1Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0JGk-0086l0-LR; Mon, 05 Jul 2021 07:43:54 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0JGi-0086if-EE
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 07:43:53 +0000
Received: by mail-il1-x12b.google.com with SMTP id f12so10190869ils.11
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e9iEkxWZXOgkQfN6wkWjUvTW+hd6y+OZGeUrfDYSv1M=;
 b=MNgNKwi4IqsC9hsZePUiKUxwI+tuua/vMJa8ZfEi6VnaZsC2euBU68wze5rJps6Mxd
 7g4YJ7p53XxQZa5OI2sMRNiwBQAj/TRR4kC79fAGEb+jRZuV1nrtWY7XI91uc9mgmMlH
 3RIUeQ+6yOeabLdZ2Sqy6mU2bP5sbyUFffJpMxlHVmPNlfvu+t+oxpFQjGl3j5zGTHWE
 +hxfRoubrUlfJT8QLuy2tj528kSMPUxEVPI2zSHCpBvC50uXaIcokYUsAj/YBrt1dXyG
 Z9IWEAlVe7j/ADJ3OKJ5pzz9HoVGv1mnTsSsF0mWwsOgXcXHLiZdOyyKWBUDxhE3UH/y
 jieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e9iEkxWZXOgkQfN6wkWjUvTW+hd6y+OZGeUrfDYSv1M=;
 b=Dmou6jB1osFNnmnZrZgwFVUyRuZ/t/fDZRKBAUBbsSy0Io/b9lrVPQn4CSpRTAH9k8
 IAGe5IEj8je67JvHbERXeJLtZT3M/KeHm1/0Runu9lbfd1gsFilfETOn2WQ8ECSnIYQr
 sjC3KPOog9jjiW4ooSJZ1RFo0FweItBhJ7muosNDXjHpp0IfOosINxbM2EzRQhLyTavf
 SpDFNJD+6bFBeRUMcEj09ZKlgZB3KLpdYEKdMtmwxGBsfhpptGqd52IK54CQNLhXWrry
 xgXtfCdqrDCEGKWH3TG715Ul7V5WoN4wS6cCeG4DaTtLiAQmd+MmTDW7ao2pbe0pm7bb
 RFVA==
X-Gm-Message-State: AOAM533jm2cukVEDAxaag/Tjy3yyE+oFYsSf3S4FvfyZgMrYw46Yqcso
 zrtbUWJLJtipbhrk/ogXOnOMupnaT1TNtde6Sx4=
X-Google-Smtp-Source: ABdhPJwSWO6HWUtzAcsBy+fVjAwey07hk80RYwIRKecpZDJqgaU8GGEzh6BceYkQVq7Qko4MlUSnfmp91lgRo3VbpKs=
X-Received: by 2002:a92:3f08:: with SMTP id m8mr9654532ila.104.1625471016960; 
 Mon, 05 Jul 2021 00:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210705031529.36001-1-houpu.main@gmail.com>
 <20210705031529.36001-2-houpu.main@gmail.com>
 <42d62146-3837-ff05-9e56-1c4c87d1ade9@nvidia.com>
In-Reply-To: <42d62146-3837-ff05-9e56-1c4c87d1ade9@nvidia.com>
From: Hou Pu <houpu.main@gmail.com>
Date: Mon, 5 Jul 2021 15:43:26 +0800
Message-ID: <CAKHcvQicg2Voq0y8d7F8KAzBqjE-vT8sOvm_aCgvp5oPKJuYLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add set feature tracing support
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org,
 maxg@mellanox.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_004352_541306_478FB16F 
X-CRM114-Status: GOOD (  22.64  )
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

On Mon, Jul 5, 2021 at 3:16 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 7/5/2021 6:15 AM, Hou Pu wrote:
> > A nvme connect command produces following trace.
> >
> > Before:
> > /sys/kernel/debug/tracing# cat trace | grep feature
> >      kworker/5:1H-98      [005] ....  3221.294844: nvme_setup_cmd: nvme0: qid=0, cmdid=25, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=07 00 00 00 07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
> >      kworker/4:1H-124     [004] ....  3222.009186: nvme_setup_cmd: nvme0: qid=0, cmdid=17, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=0b 00 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
> >
> > After:
> > /sys/kernel/debug/tracing# cat trace | grep feature
> >      kworker/0:1H-253     [000] ....   196.060509: nvme_setup_cmd: nvme0: qid=0, cmdid=29, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0x7, sv=0x0, cdw11=0x70007)
> >      kworker/0:1H-253     [000] ....   196.763947: nvme_setup_cmd: nvme0: qid=0, cmdid=29, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0xb, sv=0x0, cdw11=0x900)
> >
> > Using ',' to separate different field like others in
> > nvmet_trace_admin_get_features.
> >
> > Signed-off-by: Hou Pu <houpu.main@gmail.com>
> > ---
> >   drivers/nvme/host/trace.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> > index 6543015b6121..2a89c5aa0790 100644
> > --- a/drivers/nvme/host/trace.c
> > +++ b/drivers/nvme/host/trace.c
> > @@ -72,6 +72,20 @@ static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
> >       return ret;
> >   }
> >
> > +static const char *nvme_trace_admin_set_features(struct trace_seq *p,
> > +                                              u8 *cdw10)
> > +{
> > +     const char *ret = trace_seq_buffer_ptr(p);
> > +     u8 fid = cdw10[0];
> > +     u8 sv = cdw10[3] & 0x8;
> > +     u32 cdw11 = get_unaligned_le32(cdw10 + 4);
>
> By the spec cdw10, 11, 12, 13, 14, 15 are used by set features command.
>
> At least lets print cdw11-cdw15 as raw data and not only cdw11.
>
> We don't want to loose information.

Yes, it's better to keep these although currently only cdw11 is used.
Will change it in v2. Thanks.

>
> > +
> > +     trace_seq_printf(p, "fid=0x%x, sv=0x%x, cdw11=0x%x", fid, sv, cdw11);
> > +     trace_seq_putc(p, 0);
> > +
> > +     return ret;
> > +}
> > +
> >   static const char *nvme_trace_admin_get_features(struct trace_seq *p,
> >                                                u8 *cdw10)
> >   {
> > @@ -80,7 +94,7 @@ static const char *nvme_trace_admin_get_features(struct trace_seq *p,
> >       u8 sel = cdw10[1] & 0x7;
> >       u32 cdw11 = get_unaligned_le32(cdw10 + 4);
> >
> > -     trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
> > +     trace_seq_printf(p, "fid=0x%x, sel=0x%x, cdw11=0x%x", fid, sel, cdw11);
>
> This can be done in separate commit.
>
> Also if you can fix the current status and print also cdw14 since it's
> used by get features by the spec (in separate commit).

OK. Thanks for the comment.

>
>
> >       trace_seq_putc(p, 0);
> >
> >       return ret;
> > @@ -201,6 +215,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
> >               return nvme_trace_create_cq(p, cdw10);
> >       case nvme_admin_identify:
> >               return nvme_trace_admin_identify(p, cdw10);
> > +     case nvme_admin_set_features:
> > +             return nvme_trace_admin_set_features(p, cdw10);
> >       case nvme_admin_get_features:
> >               return nvme_trace_admin_get_features(p, cdw10);
> >       case nvme_admin_get_lba_status:

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
