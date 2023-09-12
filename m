Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E664CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/iMs+ptgawKOXViIHlc/IyZEiOIVhHG2kbWyDW4Das4=; b=tv7VoRZOay0k2OSb68Jdd2oxwa
	g+qN1NTnLaCSDwRHHGi+5a+WILb6qlPXBJwGHWzsxSxBKbpyqgLVV3oqYZjr3MUkNHTFnyxuafeWd
	erspw5kuuy+QcKZfvZv7LbJ2F/Dc0vDoK/eOLeneOs1dNgnm7bfITBBf6Luf+PgyFew9BlhiwzPdI
	ZhuWWRnIbQAa/bXbE4CNbq1TYRhpIBZzT7t4MrZj5hAdiUz17R4UrHNWfMCyotqBMA1iBF0A/Oxe9
	bbhkPgTz6GpLLD13F3F4IHQAwcQBW+lU8fUX2GoWX+m039Jr51nELTnmt2P31muqw9zITS/T4IZ/x
	+i+tL9bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfx2B-002I5g-1K;
	Tue, 12 Sep 2023 06:38:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfx28-002I49-1A
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 06:38:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C476216DC;
	Tue, 12 Sep 2023 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694500676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iMs+ptgawKOXViIHlc/IyZEiOIVhHG2kbWyDW4Das4=;
	b=IcAbjPwb8dQXTD0bcfZaxuSMIOarHcVwj+AvuFG5XGoZ89zcF1M1yIgt62DdHT284tI0f6
	5MlmXf0MSjhVl5ZctSLsU13/ZkJRobup3xpRCDfJfwwLxAN1vZ6iBp6o68SSciv0/chYwu
	cIaMD/y5cldwQCK50piyfkWHXn7GD3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694500676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iMs+ptgawKOXViIHlc/IyZEiOIVhHG2kbWyDW4Das4=;
	b=ZRQZheB1CxZqrQKIreGZ/tG12kTOnyw5Gb124em9HWjoN0m6n4TtCOnxb+T4+fxrqFMvAu
	mP6ABwZvuVfae/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E100139DB;
	Tue, 12 Sep 2023 06:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id I+cTD0QHAGWHZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 12 Sep 2023 06:37:56 +0000
Date: Tue, 12 Sep 2023 08:38:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>, g@flourine.lan
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
 <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
 <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_233800_547330_484DE81D 
X-CRM114-Status: GOOD (  13.77  )
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

 > We have 3 association:
> > 
> >  assoc 0: systemd/udev triggered 'nvme connect-all' discovery controller
> >  assoc 1: discovery controller from nvme/005
> >  assoc 2: i/o controller from nvme/005
> 
> Actually, assoc 1 is also a i/o controller for the same hostnqn as assoc
> 2. This looks more like it assoc 0 and 1 are both from systemd/udev
> trigger. But why the heck is the hostnqn for assoc 1 the same as the
> hostnqn we use in blktests? Something is really off here.
> 
> The rest of my analysis is still valid.

I figured it out. I still used an older version nvme-cli which didn't
apply the hostnqn correctly. We fixed this in the meantime. With the
latest git version of nvme-cli the second I/O controller is not setup
anymore and the crash is gone. Though we still don't cleanup all
resources as the kernel module complains with

[41707.083039] nvmet_fc: nvmet_fc_exit_module: targetport list not empty

