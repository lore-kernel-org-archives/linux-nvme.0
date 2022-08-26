Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EFBECAAD2
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 06:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elrkesJi92gL6lorcwW2KwRlSomaC1d9Fab/M0m0PeE=; b=GZbFixT/J9Ei4mjHAdbAQbtQtR
	RNZh/Hk3ogn19kszn3XK0smsAZ/4JiZcf3xgentNeDwr0/4Ni8dHRC9mIQ9LxDyuYRkFuBy/xOR0P
	KA1kRoSmYd6q4MESYLl763Pr5yHL7ndDh+P+A2mbTU0eNFNDhOLulWCOF8lVjK94pxBOIMyAKCeOt
	IHd3k8zDIlyYjYJCOx0zrbH6XkulYR8PaJ+RGkUd2DDY6OKF8oVMAeuFxKzx/masLuT3AzWCFQJpZ
	ZrJ7MYVIkWdnQh6SCHlO6cCMo43lz+nxuifd/Fi85YBMXLJ0nvpjXnGMym5sJnKuD9zh3slt03thF
	3FIlH1jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRSrQ-00Eera-Vx; Fri, 26 Aug 2022 06:30:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRSrN-00Eelu-OB
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 06:30:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24E0D1FA84;
	Fri, 26 Aug 2022 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661495425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elrkesJi92gL6lorcwW2KwRlSomaC1d9Fab/M0m0PeE=;
	b=LZNOrzG4XgJZVOAZJ/fuov/j4KUqq2AL/J5mgOPOnS4C7i0GDu16lQ2X/IvCZPCNhWGJ14
	uc638PVqzaO2nVskZLYxdWt2ccsOQ6U+Uk8EkmEmZv1keH2Tj2YKLcyuckg0KcGQPrkFgK
	yk7346rKZgsTt3Pa2i0GO+du4zhLI9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661495425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elrkesJi92gL6lorcwW2KwRlSomaC1d9Fab/M0m0PeE=;
	b=tHQp62299Uu/fJsSKapraq5hZ246lNIrbMlAqofe4U8vwcdCcVm3lGo0YAe1XwqH2z8cPF
	KRo5JtLOAxowCJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 164C613A7E;
	Fri, 26 Aug 2022 06:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pwVnBYFoCGOMdgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 26 Aug 2022 06:30:25 +0000
Date: Fri, 26 Aug 2022 08:30:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
Message-ID: <20220826063024.tndzjp7j6xhx3234@carbon.lan>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
 <20220825105550.3hxjveuex4nmup54@carbon.lan>
 <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_233029_951265_0A8B3CD0 
X-CRM114-Status: GOOD (  20.21  )
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

On Fri, Aug 26, 2022 at 09:10:04AM +0800, Chao Leng wrote:
> On 2022/8/25 18:55, Daniel Wagner wrote:
> > On Thu, Aug 25, 2022 at 06:08:10PM +0800, Chao Leng wrote:
> > > > +	/*
> > > > +	 * If the number of queues has increased (reconnect case)
> > > > +	 * start all new queues now.
> > > > +	 */
> > > > +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
> > > > +					ctrl->tag_set.nr_hw_queues + 1);
> > > > +	if (ret)
> > > > +		goto out_cleanup_connect_q;
> > > > +
> > > Now the code looks weird.
> > > Maybe we can do like this:
> > > first blk_mq_update_nr_hw_queues, and then nvme_rdma_start_io_queues.
> > 
> > We have to start the exiting queues before going into the 'if (!new)'
> > part. That's why the start of queues is splited into two steps.
> Indeed it is not necessary.
> It's just a little negative: some request will failed, and then retry
> or failover. I think it is acceptable.

The first version made nvme_rdma_start_io_queues() re-entrant and hence
we just could call nvme_rdma_start_io_queues() twice without the max
queue logic here.

After seeing both version I tend to do say the first one keeps the
'wierd' stuff more closer together and doesn't make the callside of
nvme_rdma_start_io_queues() do the counting. So my personal preference
is to go with v1.

Maybe there is another way but I haven't figured it out yet.

