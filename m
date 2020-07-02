Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B307CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:14:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EEB2077D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LQYug8R5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yItMbcct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EEB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=412cxse70mgHYvH1zoBoiK4O1VcEdS8DMsITeHv6oJs=; b=LQYug8R5TdWhtYHtR5V3SwY9d
	xnnQQfthdtae6nP77Nw2kzhDHw4Pl9r8WNvsyw2uE3qnCZm108IxW85TxDIixxCNMIS8Q7DQXJHqF
	lcDgN++oVeTF+mu27x2pc0Hs97kZDy9R1SCsfZfQq1UdXLSsw2fwQvBkkd5HYuuoOAiGMIrwNg4rn
	QiQ2o9M0YHzZCcMcNXPWxz0AjH0+I4e0NmzJfo5jMCOGHCT0ZCQNlClL2onCTV2O+oIrw7me3ZZLe
	xe8CubsT8c2WNSOMLDXQclWbZbdrYXZU6F/+W4zIx2pq/paFPMIcdByPi/F6feqo1wf3Sa6ktGDgS
	MEIAKOQEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqsUj-0001ui-LL; Thu, 02 Jul 2020 06:14:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqsUf-0001ts-0H
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 06:14:46 +0000
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31C74208B8
 for <linux-nvme@lists.infradead.org>; Thu,  2 Jul 2020 06:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593670483;
 bh=TRjOq0ioBsI/lLgnqh3WHyq3NuAIqhAPdkGT9KrgKH8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=yItMbcctXfs5o3K3a0Uwam0VmikvvsUcR4rDa/JwGQwZB8Uz/Yhp2jGzCMiYmIUEm
 4zPuCUnKKcbVFIxEfBWBqPKPHn5qsYIgU9hyGcq8vCgJNY75/6RU7God1Ttp8qeL9G
 H4psw2naqAuo1p/prO5iO6oUyZzGm17MB9ZSYIN4=
Received: by mail-lj1-f177.google.com with SMTP id s1so30252244ljo.0
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 23:14:43 -0700 (PDT)
X-Gm-Message-State: AOAM5324duY4O7LnWj0y4XMRbTdXppAG+bh8m6pDP6pdX9f/T5ugE5Ij
 FzL8yYEwwVVZkY2CWpF28+NFRaPXuyPH0IbOoy0=
X-Google-Smtp-Source: ABdhPJyW7ZQG/gxodV+UBsSp8muv8lWxec/bTY9tvW0qqCeZQo8oSQL9G2bg+h67AMeeX8NyXrYP1bqMgId6X08X7/E=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr11256607ljk.27.1593670481513; 
 Wed, 01 Jul 2020 23:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200701085947.3354405-1-hch@lst.de>
 <20200701085947.3354405-13-hch@lst.de>
In-Reply-To: <20200701085947.3354405-13-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Wed, 1 Jul 2020 23:14:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5=055Eo-b3fjC_b-nJz-fg1FGwy_aqrNNtHm-U8vut-A@mail.gmail.com>
Message-ID: <CAPhsuW5=055Eo-b3fjC_b-nJz-fg1FGwy_aqrNNtHm-U8vut-A@mail.gmail.com>
Subject: Re: [PATCH 12/20] block: remove the request_queue argument from
 blk_queue_split
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_021445_119855_20B0A8D0 
X-CRM114-Status: GOOD (  10.80  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
 open list <linux-kernel@vger.kernel.org>,
 linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
 linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 1, 2020 at 2:02 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The queue can be trivially derived from the bio, so pass one less
> argument.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[...]
>  drivers/md/md.c               |  2 +-

For md.c:
Acked-by: Song Liu <song@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
