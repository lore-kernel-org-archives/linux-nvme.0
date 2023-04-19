Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53483C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qfmxrU7rqgnnhieg7x5c1b8MRuikfwddv02sfKrFJY=; b=qNsPUVfUW09GgDBviRumcT2yZe
	soE8fhkcGgrGJWqdKzNrYFaqwAiy5G88RIM21vdfUebSBksEueJQOqbtNLGUP7ve17pR8omv3ayPh
	B8L7d62Axsg6IYwC2QCgE3pPTrlbgBTpAKEZjZi6wk7LcW08HlUC+oUpD739Vr2ZDvvdg48/oxOzn
	iea8Z3HUm/ClBmqblKi0ITH3sWGqzfmipfhuMKunANdb4pN+4cFz9J2ox2oq6OADz5uElmdRJgZTs
	+iLUD0JLVTT6Sk9s+krdjoizZxLRWrgAfhiFYPXkpj2bBnrcfqZweBOhw8ovVZhF2tHDwKMbEavq1
	J4XLThsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp5Gf-0054RE-00;
	Wed, 19 Apr 2023 10:42:29 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp5Gc-0054Qd-0V
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 10:42:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B04152198F;
	Wed, 19 Apr 2023 10:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681900944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qfmxrU7rqgnnhieg7x5c1b8MRuikfwddv02sfKrFJY=;
	b=nLgX070cza+RuPu4YZP37+VLVfH6ak/LLTFRb/U1HF6XzHVeH/fW1RwLUU8a/vUEtx0iNT
	XNL+akAOACz4WakiT2lbQeYw0TzJXfv5b/gyUtRcV9sKI+UYHrNMshYJdmHhJMSbZfSIZA
	xgeADsGl1K8qpCfPZlS9GKDWq4wCx60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681900944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qfmxrU7rqgnnhieg7x5c1b8MRuikfwddv02sfKrFJY=;
	b=yl6kT564O47BeIeAbbUCpKJIOf6nSvnKUnH3AjGY0NHAr9fldXgBeIQXbQGRLfO9SwDait
	fcMkPOs9l6w35EAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A115F1390E;
	Wed, 19 Apr 2023 10:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2OBCJ5DFP2TENQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 10:42:24 +0000
Date: Wed, 19 Apr 2023 12:42:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Message-ID: <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_034226_339110_DCEBA600 
X-CRM114-Status: GOOD (  20.74  )
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

On Wed, Apr 19, 2023 at 12:44:42PM +0300, Sagi Grimberg wrote:
> 
> > Before we unload the module we should cleanup the fc resources first,
> > basically reorder the shutdown sequence to be in reverse order of the
> > setup path.
> 
> If this triggers a bug, then I think it is a good idea to have a
> dedicated test that reproduces it if we are changing the default
> behavior.

Right, though I would like to tackle one problem after the other, first get fc
working with the 'correct' order.

> > While at it also update the rdma stop_soft_rdma before the module
> > unloading for the same reasoning.
> 
> Why? it creates the wrong reverse ordering.
> 
> 1. setup soft-rdma
> 2. setup nvme-rdma
> 
> 2. teardown nvme-rdma
> 1. teardown soft-rdma
> 
> I don't think we need this change. I mean it is a good test
> to have that the rdma device goes away underneath nvme-rdma
> but it is good for a dedicated test.

I was woried about this setup sequence here:

	modprobe -q nvme-"${nvme_trtype}"
	if [[ "${nvme_trtype}" == "rdma" ]]; then
		start_soft_rdma

The module is loaded before start_soft_rdma is started, thus I thought we should
do the reverse, first call stop_soft_rdma and the unload the module.

