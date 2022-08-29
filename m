Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D63ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICH9NshQsvudAKGwUro4ICxWPc3un3cdbsvJzIYEwHQ=; b=fx4ecrIxf8sFO8tQ3nZzJcQB1Z
	/7wC9lP0hh2h/amH9OSo+RjMUBcMDFsUaJBDg8FC/F47W3NTmD95n0Ipdv7yOBSm1tEJ65lV+fZSM
	aOEJthhrhF3osuE3BecLzgkdraO2BlmBrcWW90noVrTr+PFLjPNKWELla5cAekrqBcTzvzTFuS1vU
	VsqYSzL0gLCyTJvBe1Swbd8H25rWwVJw1zhi3sKKi4MRaCPGMxadDH6IzG3dTRHmq8m2sOf6szxO3
	vAQldptcRy9DOtCp4jkMP3frmYgdG6JlOAZkh7SyK6x6LluL1JWHTqou+BXL2nG+sOyo1X5hjKQ+P
	ginaE22w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb99-006lr7-Fg; Mon, 29 Aug 2022 09:33:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb81-006lK5-Ok
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:32:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FED8211C1;
	Mon, 29 Aug 2022 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661765540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ICH9NshQsvudAKGwUro4ICxWPc3un3cdbsvJzIYEwHQ=;
	b=TtrQd2F/5tZA1cmbj76Uy6I4AFKuPBOtBa1MeHKPG78mERYri1uRyOw1LkZu1WtLlXv2t1
	YHP0l5vuFPWjPACOTDIKZ2A/soSy+HjsN8NxRbuhntXqubyifDxMtI4XX8I7PUYUGOY4fX
	0khdDpfCduRy3AtaahIHTtMsPPxYxeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661765540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ICH9NshQsvudAKGwUro4ICxWPc3un3cdbsvJzIYEwHQ=;
	b=XPhvby6KYq6qDQH+2lq35K1j7+y4C1sK1LFoDm7qWJ/YO4dLzgkqCqejyWn5en+ex4B2N2
	kcWFswm/I0R1bAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EEB01352A;
	Mon, 29 Aug 2022 09:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XsU9E6SHDGMRLAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 09:32:20 +0000
Date: Mon, 29 Aug 2022 11:32:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
Message-ID: <20220829093219.6ii76hne6pjzxjws@carbon.lan>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
 <5cc0b557-7e56-36c9-cfe4-05ca76f5e83e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc0b557-7e56-36c9-cfe4-05ca76f5e83e@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_023222_098174_7C6491C9 
X-CRM114-Status: UNSURE (   8.50  )
X-CRM114-Notice: Please train this message.
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

On Mon, Aug 29, 2022 at 05:22:50PM +0800, Chao Leng wrote:
> > +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
> > +					ctrl->tag_set.nr_hw_queues + 1);
> > +	if (ret)
> > +		goto out_wait_freeze_timed_out;
> nvme_rdma_start_io_queues(ctrl, 1, nr_queues) need to clean.

the teardown path in nvme_rdma_stop_io_queus() is using

   test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags)

when iterating over all nr_hw_queues.

