Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B519EB64D0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUttxPFr5axqv3puqoD2/8iu9sRLk+RMpE/RzmfX2qU=; b=FDifmvsySr3PstaUFXvi9rKp7Q
	sR+LCh+H9I2P386m5ZrcRtRKOaLbKAzxxiWbhvnYG26FZKIKHJjIWaxtQREVeVCQK3K8uldPM6dp4
	bq+AGY4EtPhtPZXXx0gg5o7Yy2/IgWhCDh5z6jhP63oeIemkcDezL31IZbz4ZM5iHPQMSJEq1YaiE
	7plOM1uBbns92xrywWzk/4C5L2j2XBcQ+vmnjA9Igq/dYlfz8lN8li4I9xRpIED2RAaRj/jinRNpF
	rWQM2xlQn0cTwHatE0O0b/KWlFmrDyin7J1y48slPZd8XL9+AUXAGUFI/YuEoIuhk8hlWPEUvqIey
	9m9xYgEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q98Qz-008nqu-0A;
	Tue, 13 Jun 2023 18:08:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q98Qs-008np6-1J
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 18:07:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BC11961ED8;
	Tue, 13 Jun 2023 18:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650EC433F0;
	Tue, 13 Jun 2023 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686679672;
	bh=bStpZzGOwnNjgB7buL3AsENNwCNpQ59qPTJrDmTXhMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYmmxkOPcLl/S5RBi3m56MtconN9iSMRL9SFJzzuIQWtQYQDeOWzWHM189VfXnQaG
	 uUVBMDL5GNwuopc/Pb8MvCLGIepqRPlAhE8fa12iplkZ/FKBolzallBEaZ+2zVrTGj
	 XLK4s73Sxwgg/mTfPwhNjHldzOuVSfye2buISCZCnaEuGRtximGLWzQGid/jMF0ziw
	 I8nsJFkSzxcK7Qv20LDikTZ2IGYdVaQqmpoaMgOpCEhgnOvNcYDAjwz6CrIxVkHprE
	 Rdbuot3bD1yQEj9TDqjloqlHVAW3wKuM7b2bkvRW/3bH/4HPGtjbef7D0Xi8ktBUML
	 8Wzf0zctEqBwg==
Date: Tue, 13 Jun 2023 21:07:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <20230613180747.GB12152@unreal>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIhvfdVOMsN2cXEX@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_110754_509694_D55F2FB7 
X-CRM114-Status: GOOD (  22.87  )
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

On Tue, Jun 13, 2023 at 10:30:37AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 13, 2023 at 01:43:43AM +0000, Shinichiro Kawasaki wrote:
> > > I think there is likely some much larger issue with the IW CM if the
> > > cm_id can be destroyed while the iwcm_id is in use? It is weird that
> > > there are two id memories for this :\
> > 
> > My understanding about the call chain to rdma id destroy is as follows. I guess
> > _destory_id calls iw_destory_cm_id before destroying the rdma id, but not sure
> > why it does not wait for cm_id deref by cm_work_handler.
> > 
> > nvme_rdma_teardown_io_queueus
> >  nvme_rdma_stop_io_queues -> chained to cma_iw_handler
> >  nvme_rdma_free_io_queues
> >   nvme_rdma_free_queue
> >    rdma_destroy_id
> >     mutex_lock(&id_priv->handler_mutex)
> >     destroy_id_handler_unlock
> >      mutex_unlock(&id_priv->handler_mutex)
> >      _destory_id
> >        iw_destroy_cm_id
> >        wait_for_completiion(&id_priv->comp)
> >        kfree(id_priv)
> 
> Once a destroy_cm_id() has returned that layer is no longer
> permitted to run or be running in its handlers. The iw cm is broken if
> it allows this, and that is the cause of the bug.
> 
> Taking more refs within handlers that are already not allowed to be
> running is just racy.

So we need to revert that patch from our rdma-rc.

Thanks

> 
> Jason

