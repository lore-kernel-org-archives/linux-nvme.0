Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB488C388F7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 13:25:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265952474B
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 13:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rb6FyyTv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXVlrJKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265952474B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lvUuVnfGIKnB8Uuqfq+y6NilYoEtpowbfkomgy84tgs=; b=rb6FyyTvD2ryPrgPNZtNG3rmt
	Us30Unak0h6XqG4iMBS90wJFyxbK1NF4zJfOWKMjfh31dNgJK+MAKR4l90HGWMmErmdq35qrg/gxC
	lAWCe+IPKGHQXASZhPFmF5ZhmN89gcaNtGcuLPuMDw5Yhviu3IFGUiPqyGtVUuXKvFOKXlgALIecj
	eDI3Xi9XJPCrJaKkzxNE3QIeZk/3Js0/DIaRydUe20YtSx4+yPfmEOZ6ynFVsoMLJwpqTg66WwDd0
	i8Nu4p5QK7tdVC5ixyqbR1L+NTMoW/QFPUQsMDYlkp4raqBLbhHDUUBojyh/JB4irZvP5+N4g2/bW
	d6RwiKjHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXlSU-0001Vk-Rl; Wed, 28 Oct 2020 13:25:46 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXlSQ-0001UV-Fa
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 13:25:43 +0000
Received: by mail-yb1-xb42.google.com with SMTP id f140so4266449ybg.3
 for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2020 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/UJW3oTJeJGDMX7K/0/CVivyPUf3llQVj0vn62KpEN0=;
 b=kXVlrJKCGjn3OGEdo1PVU1VTJifddWS9oGG8IZUOcdmujqH5iohfFCuYM1nkOX37Ze
 OoLTcyUsBxosJuLRPeS0At98N+c0lSi1mQd+1Z0ctAtTjmrNHabblD5gBeVtE1xkQ66l
 2aFNXJnqtfO/sUWUQACinFhAmdhdKs/ttVirguWOi+5MXKICJHwUta07TsfhpdkSM6Yl
 QvRUB0PtKPAFQn6nwHFvYP+lGj+R7820+xONDIIJdFyHHLPIqpjfNAuAEQHgJ5pq5aJx
 gnqRR+FY+paZtd+Yr1hpjvmk3fqlmHVmZVOqQ1pRsmL/Qw0E98v2lJLaeeqlumIwAtEN
 00yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/UJW3oTJeJGDMX7K/0/CVivyPUf3llQVj0vn62KpEN0=;
 b=MCgxwfTHT2wuQNpUqiIWevm28khhSwwcRMDxvp8wecW/SMkXIh7DQycNeBwJAAvlpx
 7suSLOPP/9D4VAKNzteZm4QYbff8Brbe/wHjj5H1MEgpF1FBwfq0ZKmv2OboAifj1K43
 YKWOJKtO5xEEdj0shNGsee1MaT+2uRtIvvjYhmIABqYh1wfaE/jhl1I4BV9FOFjxg/ye
 TcLFhdxJSqnswaA8A04bkYdimTPxYj05Kv8t88NlbPxk+x9zcrIJQ1RAUwCwXyjamDF0
 HdYDMoKwgjgsWvMaCRKPIVi+CrvjxMlR5wm6g7jCq0N6inMabBLUJwcFChKsXdH/UIys
 xCmA==
X-Gm-Message-State: AOAM530MgEnbAsn/jZce4/nNtu+j7IGv46HpzcS0JXuBqTkG8m365B48
 n3CFx+F//JttEr1kFtO2v3Gmy8jH8kiaRpOHx64=
X-Google-Smtp-Source: ABdhPJx3o1Chww40Qgc8hH82jL4slZ5sSbkkTElGKTyBCghdG8cociIISNPDlrhYuYIrdwWVGYi6L8He8DKzkukDWiA=
X-Received: by 2002:a25:c042:: with SMTP id c63mr10240219ybf.465.1603891538810; 
 Wed, 28 Oct 2020 06:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201022021452.10971-1-lengchao@huawei.com>
 <aba13cb9-a3d4-490b-4d1d-1deb60eafff6@redhat.com>
In-Reply-To: <aba13cb9-a3d4-490b-4d1d-1deb60eafff6@redhat.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 28 Oct 2020 21:25:27 +0800
Message-ID: <CACVXFVMk3MWELDLFv44B=oAgwFnmuDCnSDe4QYE-+ipkxeZzLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] avoid race for time out
To: Yi Zhang <yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_092542_643973_B1D2379B 
X-CRM114-Status: GOOD (  11.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@fb.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 28, 2020 at 7:38 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> This series fixed the WARNING issue I reported [1], but now the nvme/012
> [2] will be hang there and never finished, here is the log[3]

Hello Yi,

Please try the following patch against Chao's patches and see if the
hang issue can
be fixed:

https://lore.kernel.org/linux-block/20201020085301.1553959-2-ming.lei@redhat.com/T/#u


Thanks,
Ming Lei

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
