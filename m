Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDFAE77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=; b=qAaxGHXskQX2zR7l0s/qKfcv3y
	F8KzDtBdX20ZqaDbk40ifxLSV7Tcm4uGrIub0ZQhw3Z3iI18jqCK/Jt5zIduZJTF+0ISKzpHvfRPB
	A5ZdoZ0DaDi8MdvWbArBypXf/3yxzrRkPpbF6OC6byw2o6K2zXLe2MF6gjB816vZSy+5ErzVI8Ydx
	El3N1zZuwFniGgXkRxZIvImJ4ZHTKs8attjgnmrsWw6u2Sox/D+01WGQsUDqJOKS0zIwhIetEDq20
	mmWsIHUNZHXxyQ0rENrUoyjvfDhDCSstChNItxIbGD/QKjnSF9k0E1U0Cggfa+zjbSGP0IhIpFkZj
	0lAPqEXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKaHf-000000077F4-0DcE;
	Mon, 09 Dec 2024 09:42:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKaHd-000000077EY-1JYY
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 09:42:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 599A521102;
	Mon,  9 Dec 2024 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733737346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=ROVWqHs3eX2jxddbAJcSeaVF9VPcdDPjibTWlDoJ51YYPKFll2L+vbTCLNEJd033bkDwv4
	IbhMu5XKOkZ+zqmISMMqx2BSu2MekIgmLn6icB+0+/yp9f29+jMwYPQYr8VkXe7LEw1z7I
	R37xBp1fgRVBnDjV9+iChjbPZ8RimWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733737346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=K6/il/9y2rYJNgrfcwHFshevRCOQUhZccARRG5++Eu3DQVGGe+zawpPvgOjUnpSE4T5x28
	u+SXh3r8qV4vmkDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733737346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=ROVWqHs3eX2jxddbAJcSeaVF9VPcdDPjibTWlDoJ51YYPKFll2L+vbTCLNEJd033bkDwv4
	IbhMu5XKOkZ+zqmISMMqx2BSu2MekIgmLn6icB+0+/yp9f29+jMwYPQYr8VkXe7LEw1z7I
	R37xBp1fgRVBnDjV9+iChjbPZ8RimWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733737346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=K6/il/9y2rYJNgrfcwHFshevRCOQUhZccARRG5++Eu3DQVGGe+zawpPvgOjUnpSE4T5x28
	u+SXh3r8qV4vmkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46E32138D2;
	Mon,  9 Dec 2024 09:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hEOVEIK7VmeOJQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 09 Dec 2024 09:42:26 +0000
Date: Mon, 9 Dec 2024 10:42:17 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 0/8] blk: refactor queue affinity helpers
Message-ID: <c5f7f562-c8b0-422b-bb51-744ecba7ecee@flourine.local>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_014229_500549_2BD83274 
X-CRM114-Status: GOOD (  15.46  )
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

Hi Jens,

On Mon, Dec 02, 2024 at 03:00:08PM +0100, Daniel Wagner wrote:
> I've rebased and retested the series on top of for-6.14/block and updated
> the docummentation as requested by John.
> 
> Original cover letter:
> 
> These patches were part of 'honor isolcpus configuration' [1] series. To
> simplify the review process I decided to send this as separate series
> because I think it's a nice cleanup independent of the isolcpus feature.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

I've based this work on top of your tree as I think it should go your
tree. If this should go via different tree, let me know which one.

And in case the series didn't hit your inbox, I really don't know what I
am doing wrong. I've switched over to use b4 and korg for sending the
patches and on my side all looks good and the mails also appear on lore
completely normal.

Thanks,
Daniel

