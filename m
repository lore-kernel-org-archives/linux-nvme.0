Return-Path: <SRS0=5HbI=KR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59734C2B9F2
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 14:28:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8628611BD
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 14:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8628611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eN+HLwi3Tr9GNV6fb/kjwVa9/6u9sHARS6DanhB0x20=; b=qV5B1gSNuuiY6S2gYN7XVwoU3t
	Vx25bqWVGJOGufTb2WzUG0gjmSORUUFRGsA+YgXFog068ARIJ17GRyPflAqTZPhlSWisa5bpqhxWJ
	VXl3oGuyV+D311muYeCK3+/G9/en6DNJaYGOHmcnXkOIO65JHsBK5TdQeVnpSscumJimMOLWF+vGJ
	62GWAucl39q+L4HIysZtg1xr7CAYJNEMhNzy7MqwJByYPNNG6a3Wnch4m4EXhzS3FEpTVGR15BmxE
	Oo96+gD/j8SjGU2xRPPN9TROtBlb2S0RV1RcHrYscNMQchdMl45IBxbzrpp8LIvy1SrDMLy+cTQmz
	028/prgw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkSbv-002dvj-O8; Sat, 22 May 2021 14:28:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkSbo-002duW-1c
 for linux-nvme@desiato.infradead.org; Sat, 22 May 2021 14:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4wFByJYK5mMqbC9JdACHFVDqdKhx50YtVK3BkmRNj7w=; b=EkAjDA9vOEDqq5XhRJ+YouD2yj
 b6rjm6RrfiI8pZQVTgpe0gC6GJ/uceIB+1/hInTTv0TIQsH9NASMi/SsZ4dRg/tfgSW27dD1KadHO
 OPr6T9aruJ2kpkCEBdX1gSpHutcJq5fQxsepOZdcCpXF+cjFJ9H1cfJ1Gq9X9EawxqjVvTzqBd0Ow
 19d20nTU+3MYgUd2VYA7Ngd3aS+nC5Ds6DwEv4DbLC+LMXkbumWwMLUj+rkMeJq8HTXQc+bsZfETj
 E6vFvJOFnbAvWRMCVt+truFflWngIkL4235CmbRcICrzi4etw+Iz+Lt63rDupKlIp7lLT8r9E49dy
 0LlAwzcw==;
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkSbl-0008An-4x
 for linux-nvme@lists.infradead.org; Sat, 22 May 2021 14:28:06 +0000
Received: by mail-il1-x12e.google.com with SMTP id l15so15652165iln.8
 for <linux-nvme@lists.infradead.org>; Sat, 22 May 2021 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4wFByJYK5mMqbC9JdACHFVDqdKhx50YtVK3BkmRNj7w=;
 b=Dp7RncSomiloucHvb8Zx2quHncQCA9fTaykb6VpjynJYQTsaW695nU/7gBcrg59AUA
 CmgAPjauu1QCrE05Tfy62vLTz2x3i/NZ7/r/ppR8SNACXAqJFyh2o1d914zFV9768IjG
 fbTf1jSx+sfunC5ZvmTd+WwPFxcHqxwD1ZAfq9LQ07zkM5iK/i/b+Jnugo9FzYCsEKyJ
 qmZzJ3xNTh9fNlvA5dQZcj/KdzwkVAwhbNQ3SSSidNmvl/NWAVQaSqxikwJEIMKNE/to
 v/albEw0/k9Msu4xlZuJO8FdnOX1AhB17P8Do8aXSGu8tXfRJRrnWTO3atRhQmP068Ez
 3Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4wFByJYK5mMqbC9JdACHFVDqdKhx50YtVK3BkmRNj7w=;
 b=EqeAvqF7lcTYjW2Xg78zlrWNfZYZpnxktd47k2UFF8JbBhtLrQgA6CJN3VwHOgX/NA
 DPW51IoQgQ8Xn6e7+ndVqVt4J+ccKVxupQTPpdzxwsrcbScRU4SIWCnZ27R1iBLzRT0n
 Fp5K07WJh9HkYneZx6DsAdZ2rrnaRFeecjEeUnimvzCVkwwl5SLa5feoYHrES7yWjatR
 k4BFCOhTPaR7k8gnAmz05awri2mOfXFXqaAcxgRVPh1p9GgIIQcYrG6Ym8Wgk4YMC/8S
 jFH3mMNvG+AGCCyX+UsIXvLnWN8nPqKnMqp4+GgSiJih0hA3b29AOK3F4TiOEKZbIzpY
 mUFg==
X-Gm-Message-State: AOAM532Qus9jz6qg0+MA6KSZOYnn9l2wqQhwF2+STAjSydNc/an6737Y
 Ul548TKr2fAzhVaXTyp70kLzk4RfyeudAGIdFHE=
X-Google-Smtp-Source: ABdhPJwIU2l7xRle/nEejWwtV390Lho3J4boAgXhNFDLCIB18vuhkbgRHCDUJrNAMSUckCtenJyhUNsDZgfvO4dBi5c=
X-Received: by 2002:a05:6e02:1348:: with SMTP id
 k8mr5465225ilr.104.1621693682969; 
 Sat, 22 May 2021 07:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520113046.27821-1-houpu.main@gmail.com>
 <20210520113046.27821-3-houpu.main@gmail.com>
 <417493d4-a78f-ea89-8536-0b391ef95f08@grimberg.me>
 <CAKHcvQgYDcS4sOZ9SBaZ_9gK2EHz5LwLHXo77UDqDTyjjNJzZw@mail.gmail.com>
 <2d4ae6a7-72f1-4dd4-df58-366e6f53c5cf@grimberg.me>
In-Reply-To: <2d4ae6a7-72f1-4dd4-df58-366e6f53c5cf@grimberg.me>
From: Hou Pu <houpu.main@gmail.com>
Date: Sat, 22 May 2021 22:27:52 +0800
Message-ID: <CAKHcvQiNL2ft4cZGf98+HDHD_g0XW4MgHHFEcc3iv8y0LZqrnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmet-tcp: fix connect error when setting
 param_inline_data_size to zero.
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, 
 larrystevenwise@gmail.com, maxg@mellanox.com, 
 "Grupi, Elad" <elad.grupi@dell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210522_072805_242966_82AA7800 
X-CRM114-Status: GOOD (  24.07  )
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

On Sat, May 22, 2021 at 2:04 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> +static inline int nvmet_tcp_inline_data_size(struct nvmet_tcp_cmd *cmd)
> >>> +{
> >>> +     struct nvmet_tcp_queue *queue = cmd->queue;
> >>> +     struct nvme_command *nvme_cmd = cmd->req.cmd;
> >>> +     int inline_data_size = NVME_TCP_ADMIN_CCSZ;
> >>> +     u16 qid = 0;
> >>> +
> >>> +     if (likely(queue->nvme_sq.ctrl)) {
> >>> +             /* The connect admin/io queue has been executed. */
> >>> +             qid = queue->nvme_sq.qid;
> >>> +             if (qid)
> >>> +                     inline_data_size = cmd->req.port->inline_data_size;
> >>> +     } else if (nvme_cmd->connect.qid)
> >>> +             inline_data_size = cmd->req.port->inline_data_size;
> >>
> >> How can a connection to an I/O queue arrive without having the ctrl
> >> reference installed? Is this for the failure case?
> >
> > Hi Sagi,
> > AFAIK after the host finishes setting up the admin queue,
> > it connects to the io queue and sends the io-connect command. At this
> > point the nvmet_tcp_queue is firstly allocated and does not have a valid
> > queue->nvme_sq.ctrl. It is assigned after io-connect in nvmet_install_queue().
> > So this function tries to find the correct queue number before or after a
> > fabrics connect command.
>
> Why do you need the inline_data_size before the connect? its only
> relevant for nvme I/O..

From my observation, the host always sends an admin-connect command with
nvmf_connect_data as inline data (by setting sg type to NVME_SGL_FMT_DATA_DESC).
This is fixed from the host side.

For io-connect command, the host sends nvmf_connect_data according
to ioccsz. If the size of nvmf_connect_data is smaller than ioccsz*16
it is sent as inline data. ioccsz is obtained by identifying the controller and
is controlled by param_inline_data_size from the target side.

If param_inline_data_size is set to zero, admin-connect will not
be received by target correctly. As target side thought there is
no inline data (by looking param_inline_data_size), but in fact
admin-connect has inline data.

This patch is trying to make param_inline_data_size only affect io-queue.
and admin-queue always allow 8k inline data. This is what the host
side do currently and also what the specification says AFAIK.

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
