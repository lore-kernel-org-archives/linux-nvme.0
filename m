Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E71EE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxPXPMibTU/WQCgXGbiL/szHxJfWSieTNiAS+pJX5EQ=; b=AvF9XAvlaUmM/Rh4nNH/QYXrWB
	xAK/7WJRFSVhPjkOV+0S0F7B2KX/Qouh5JjCLAWt6sSkjfuIOSdzHNdGATQqg081hP1d2kNTBWM7m
	C78CB7Gdgl2TlIhrpIM+f1618uaN9yXht8uOrMH1Kp+33ypeT53wai+IR6qBS2rG09l+LMQAjxpV4
	BeaiwQW2HUNevJZPOACz3HMz1pBbtvVXCNFQq+LoMf/SDuyT9F6isTgCl19TamvfF4sSsGNAak7F6
	PqYjWG6l7ja7Wthn87MBVyJK7ZZxpj0eN/5nPW16v57SzWIwoVHZGwFdhE+t6KQvgcbUVeaA6o3xK
	evgYiRqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfdpO-0005zA-0s;
	Mon, 11 Sep 2023 10:07:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfdpM-0005yi-0K
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 10:07:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 378722184D;
	Mon, 11 Sep 2023 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694426846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxPXPMibTU/WQCgXGbiL/szHxJfWSieTNiAS+pJX5EQ=;
	b=IrV7P1MJYIzyfQEKZuvm1I05jsHjizYTsIAn5GC1c1BRO7qOHymsF9qNvbtxbMqmcHfw61
	9txiRa419pMLFZfNc4TlmZxbXwTEmb8WCz9W5sEnYdadhwls5j95bNlIcCoJrcgeRG3/Gr
	gym0kEONOjdlFXYpJBEsIrXpsx6KH+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694426846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxPXPMibTU/WQCgXGbiL/szHxJfWSieTNiAS+pJX5EQ=;
	b=Vu3Ink0bNrUEvNZM4E/2cRG9LbDABx7hW8SY59QWX7iG0+QM59YIRKKrYssWfxENqngtla
	ADEfDmlp8inithDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28D0F139CC;
	Mon, 11 Sep 2023 10:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1CboCd7m/mRZPQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 10:07:26 +0000
Date: Mon, 11 Sep 2023 12:08:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 3/4] nvmet-fc: untangle cross refcounting objects
Message-ID: <kl45f37ubitdm7djwb37zxox22e4bieoqdyetxibgb4dtmaevc@jafhs7q2ajy2>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-4-dwagner@suse.de>
 <69c8e29a-cba6-4bd4-adfe-81f507415d5f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c8e29a-cba6-4bd4-adfe-81f507415d5f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_030732_301155_019E736D 
X-CRM114-Status: GOOD (  17.04  )
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

On Wed, Sep 06, 2023 at 01:22:28PM +0200, Hannes Reinecke wrote:
 >   	destroy_workqueue(queue->work_q);
> >   	kfree_rcu(queue, rcu);
> > @@ -1100,6 +1093,11 @@ nvmet_fc_delete_assoc(struct work_struct *work)
> >   		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
> >   	nvmet_fc_delete_target_assoc(assoc);
> > +
> > +	/* release get taken in nvmet_fc_find_target_assoc */
> > +	nvmet_fc_tgt_a_put(assoc);
> > +
> > +	/* final reference from nvmet_fc_ls_create_association */
> >   	nvmet_fc_tgt_a_put(assoc);
> >   }
> That feels wrong. If we're having to do two put in a row it seems that
> we're taking one reference too many here.

When the association is created the first reference is taken. This is
the one we want to release here. But as nvmet_fc_find_target_assoc
always takes a reference we have to drop that one too. One possibility
would be to introduce a lookup function which doesn't take the
reference.

 > +	/* prevent new I/Os entering the queues */
> > +	for (i = NVMET_NR_QUEUES; i >= 0; i--)
> > +		rcu_assign_pointer(assoc->queues[i], NULL);
> > +	list_del_rcu(&assoc->a_list);
> > +	synchronize_rcu();
> Watch out for 'list_del_rcu()'. That does _not_ modify the pointer for the
> element in question, only those from the list.
> So to avoid concurrency with nvmet_fc_alloc_target_assoc() I guess we need
> to get the tgtport lock here.

Yes, we need to protect from concurent write access obviously.

