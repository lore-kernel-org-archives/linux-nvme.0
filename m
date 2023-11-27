Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E760C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjDfbqtxJd4B7b6GnzfJoMeJiKNkrI+WFMXjJWpclGc=; b=PT6lpnJO0OuBxMli8F+lw426Xy
	BC9Ma4u2VYtwEYHbaElQtU5cSc0Ch2Pq/7UY0Wz3GjevgCyB0vykRARN/XYm7P/cuFwjIW+4Ax0LG
	dDEW41EAgbB9P6TiLVs7maKwo75IGQD++f4LbvEhxhGE68Lw2e6lxgOk8AxGhR3MdrcsmAUmzfydr
	6dmRjSGVYSpJwwgF8BQKNIX/kTSbfOpze6rHKU6ZwS/W5sFApYwMFTlQEBamqQzr7syVmTwOVu9G4
	SbVV+OZJiJdw1Y2/SNN+v6nb1uk7Oar/vm9AGiuAeOc36TQJYB/AlfvzBVvz801HlVYXadJUN7++e
	tL9uR1kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7aMg-002Ppp-0h;
	Mon, 27 Nov 2023 12:05:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7aMc-002Pp4-1x
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 12:05:23 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12C5021AB8;
	Mon, 27 Nov 2023 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701086721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjDfbqtxJd4B7b6GnzfJoMeJiKNkrI+WFMXjJWpclGc=;
	b=0D1wdA2Yhe8Y6Men9zk8WwEFEUPs9PHa6OJmUgl4g4HV5DcVj7/q0TbnmbP7MryCtROVnT
	hJYrgsVxAd2mXHRuQz3zr862AhCVv7aBLcqXlXG9o9FXiJcaCatC0w4lm4mkHqXzZJU5CE
	YHxkTWk4OZW4OP1C9WEGGy4f40J6VlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701086721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjDfbqtxJd4B7b6GnzfJoMeJiKNkrI+WFMXjJWpclGc=;
	b=OJMQoSpIp/rvkObCjNgBSJE4U7dkGfmC8Ag+kjFUYlCvcnqDEchO1pdUc2fsGqJe8Us1/l
	CG3CKYRSxoaAHHAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F2BA313440;
	Mon, 27 Nov 2023 12:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2kfPOQCGZGW5GQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 27 Nov 2023 12:05:20 +0000
Date: Mon, 27 Nov 2023 13:07:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <mwen6fl5yszmk5nh2hbsqtu5pu76ir6rh6jpdfppbczsov7qfz@vivqeew6y7wk>
References: <20231127103208.25748-1-dwagner@suse.de>
 <ZWRy-4Bhqw0Gxo4c@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWRy-4Bhqw0Gxo4c@kbusch-mbp.dhcp.thefacebook.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(2.96)[0.987];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.05%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_040522_797612_AA117C51 
X-CRM114-Status: GOOD (  18.47  )
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

On Mon, Nov 27, 2023 at 03:44:11AM -0700, Keith Busch wrote:
> On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> > libnvme is using the sysfs for enumarating the nvme resources. Though
> > there are few missing attritbutes in the sysfs. For these libnvme issues
> > commands during discovering.
> > 
> > As the kernel already knows all these attributes and we would like to
> > avoid libnvme to issue commands all the time, expose these missing
> > attributes.
> 
> The id namespace 'nuse' field can be quite volatile: it can change on
> any write or discard command, so caching it may quickly get out of sync
> with the actual value.

libnvme itself is also cashing this value and exposes it via the
nvme_ns_get_lba_util() getter. I'd say libnvme shouldn't cache it
either. Instead the function should just issue the ns command to report
the current nuse value.

I'll drop the nuse sysfs entry.

Unfortunately, 'nvme list' is using the 'nuse' field for showing the
currently used space. I was hoping to get 'nvme list' working without
issuing any commands.

