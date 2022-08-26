Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E3CECAAD4
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHt6BjmfMZwIRuzx2hlfMkr4ivxryo7wW7bhUQb6ZSU=; b=U7ZEihDBxBlY69HxobMJQQyRTy
	qYwnhfi2RRsKO1F5nqZel1f9Oq6fdIQKl095Vicul/Dc4XIq6IfXZ28bwQPTZphNGW8ITXE2Gvoo3
	vr1JLgn14f2D35L01eq815GzkxZt/U2JSoR3MQuH2L8qPJY9kLxhnAmwBtmgg48pIXLQVezmQh5T9
	hcyfzrIC6NqoGci7gumu7iTPAJ+bItH1SSRLsjoMVS0WQ9j3ajGjv7QQvSfyU4+JuqxRjf+tVXOjH
	xm88GliTTN+HyNbEMjLNrxXY5aNiI/WdUrYT4R3LrG1O+7vJAOotVz7KXAMFeAQGfIPXtvMVKcJeO
	salL91jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRXaw-0022aF-KU; Fri, 26 Aug 2022 11:33:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRXau-0022W7-3e
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 11:33:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DED91F8E5;
	Fri, 26 Aug 2022 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661513622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHt6BjmfMZwIRuzx2hlfMkr4ivxryo7wW7bhUQb6ZSU=;
	b=OdDiAe247qN/QNai55bv1yXK2ed7yxv3L62R6dQOmoS7jH8YModGxej/CAhvj6OnEtgr51
	OThh5ZYnk0RZQ7Rg4Lvi+ZoxV86C4yl1GJ6k9ZDfaUQfiBXo6ISFyirD1bQu+KhVQSfAF6
	76nRt9MlCicbtR9ALr9qVUSwoyhcyYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661513622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHt6BjmfMZwIRuzx2hlfMkr4ivxryo7wW7bhUQb6ZSU=;
	b=N+NIRd4y10Uhe4elvBvXIDGOxVJOhwnjRtBEV1/WWWyXGlpbOYBEYiugh0/liQPItIqAmt
	KYabTCnem/FetjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D51113421;
	Fri, 26 Aug 2022 11:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Sv6bGpavCGMHeQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 26 Aug 2022 11:33:42 +0000
Date: Fri, 26 Aug 2022 13:33:41 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
Message-ID: <20220826113341.nac4rgu3goa4enfq@carbon.lan>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
 <20220825105550.3hxjveuex4nmup54@carbon.lan>
 <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
 <20220826063024.tndzjp7j6xhx3234@carbon.lan>
 <e9caacd6-033a-3f93-e9d5-2ad80fa07cfe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9caacd6-033a-3f93-e9d5-2ad80fa07cfe@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_043348_333465_BAEA4BFA 
X-CRM114-Status: GOOD (  18.08  )
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

On Fri, Aug 26, 2022 at 03:31:15PM +0800, Chao Leng wrote:
> > After seeing both version I tend to do say the first one keeps the
> > 'wierd' stuff more closer together and doesn't make the callside of
> > nvme_rdma_start_io_queues() do the counting. So my personal preference
> I don't understand "do the counting".

Sorry. I meant we fist start only queues for which have resources
allocated (nr_queues in my patch). And then we only need to start
potentially added queues.

> Show the code:
> ---
>  drivers/nvme/host/rdma.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 7d01fb770284..8dfb79726e13 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -980,10 +980,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>                         goto out_free_tag_set;
>         }
> 
> -       ret = nvme_rdma_start_io_queues(ctrl);
> -       if (ret)
> -               goto out_cleanup_connect_q;

Again, these need to start so that...

> -
>         if (!new) {
>                 nvme_start_queues(&ctrl->ctrl);
>                 if (!nvme_wait_freeze_timeout(&ctrl->ctrl,

... this here has a chance to work.

