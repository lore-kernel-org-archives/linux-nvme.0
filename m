Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACCDC7EE29
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTZxN5m13ruXfj1B8m/Bn5YhWNHFY++7NFGSmz/Butk=; b=F8hTPBIgTdbRfrJrjWA+6ULB6m
	U7ieDAQ5E/DmnxtYRB/5Uhu6wuPXN4wktkMbSTs1DPTR31AliTRyQ5Tar16d+EdXx2fDfp2ZFkwEK
	dj1MTpRMAswAPAEBP1j/hIgrxJNWIuGe1Iyv5qecRmA7FI8V2FI7bXjj+ShvqLQV5cY0nXyrJnwlW
	qvi9uhHwwt9mD34PRV+d7kD8+KcjlIELSGdUT4F65gyTqowJCThk7gzhBIiPVEPN6XX6Et5+yaNmc
	g3qx2Bs40Fo2Na0848eSW/h1gWbxs5/NcRAhfoJ5IYHKRyeNz40EZabSKa7EhlH+YLgBqEEwyrGYz
	nhQI/P2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q942d-008Ay9-2H;
	Tue, 13 Jun 2023 13:26:35 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q942a-008AxY-1i
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 13:26:34 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f7373b5499so9289525e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 06:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662790; x=1689254790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTZxN5m13ruXfj1B8m/Bn5YhWNHFY++7NFGSmz/Butk=;
        b=NW340WYgNT6gh2In+Sin+rmTPMXDefi3MSOPg/yt591toQvSb3/5msdFMK6BEM0LCd
         Dm3iKjiQSB/Xf/QuyHGuiqLrINqAUb9x4AZOQ9ApLOr5MXu6Ir22mZo2AXGl1OSh/Wkh
         vDhNx3IGBL68RMi1BY9qGXbbuWAfUpGVpkFgUkTPyWQ2wfOI6qB62I4l+bNw1s47EvZz
         r9+h5FBIw623jnuo3YJwjf7h19UBYNNFiuip3m3T+qdsNksBY8LQKZZuZ5DQDDagB8Yz
         eynPROf+lLIY7tYoqhV+DINeGRIQ2ZQkwrNPfH3AzZ2dDmIy5FV4m8HChqcSY6bD6fms
         bdSw==
X-Gm-Message-State: AC+VfDxeaUUK4JMuTa6sbdI1HezSbF8xQF2kPbiIBA1EYOAO7mWuoa09
	f7NjzgYVMEBddzwLMGyj/7U=
X-Google-Smtp-Source: ACHHUZ4YWQOvQmvc9An+icPA01JC1DVn5JfT/ZQJz9hAkUTqkSdi8LV739uDhC8WEloaUqseYBzVcg==
X-Received: by 2002:a05:600c:4e01:b0:3f6:c88:c318 with SMTP id b1-20020a05600c4e0100b003f60c88c318mr10343960wmq.4.1686662789691;
        Tue, 13 Jun 2023 06:26:29 -0700 (PDT)
Received: from sagi-Latitude-7490 (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x19-20020a1c7c13000000b003f7aad8c160sm14423161wmc.11.2023.06.13.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:26:29 -0700 (PDT)
Date: Tue, 13 Jun 2023 16:26:27 +0300
From: Sagi Grimberg <sagi@grimberg.me>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIhugyimdWoW7bU+@sagi-Latitude-7490>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <c850f479-36b9-3478-6400-95faea095467@grimberg.me>
 <ZIhtJ3PjJYMWXS04@ovpn-8-16.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIhtJ3PjJYMWXS04@ovpn-8-16.pek2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_062632_565434_53E85CD4 
X-CRM114-Status: GOOD (  15.53  )
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

> > > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > > index 0eb79696fb73..354cce8853c1 100644
> > > --- a/drivers/nvme/host/rdma.c
> > > +++ b/drivers/nvme/host/rdma.c
> > > @@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> > >   		goto out_cleanup_tagset;
> > >   	if (!new) {
> > > +		nvme_start_freeze(&ctrl->ctrl);
> > >   		nvme_unquiesce_io_queues(&ctrl->ctrl);
> > >   		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> > >   			/*
> > > @@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> > >   			 * to be safe.
> > >   			 */
> > >   			ret = -ENODEV;
> > > +			nvme_unfreeze(&ctrl->ctrl);
> > 
> > What does this unfreeze designed to do?
> 
> It is for undoing the previous nvme_start_freeze.

ok.

