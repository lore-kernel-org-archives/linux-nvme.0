Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D400BC982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eocv3+CyE8Q3Pw2FFGy3jXMj6dAV64/waqi6O7npLqY=; b=VeD4Qt/JdERuczwSxMh8DxF5Bb
	LoVNn4dLcioF5DgT6jTRnqAxWTs0kic+SFxr/Z84qURG1pgCQX7XhIIYUPBKWmKJUr6CiJ0s1EZwA
	nLe737HOwW98JZ4XSCfQunX2Iq0v1NAPMMUVv43jqrqQJivmIWP6Epee3K6+Mwhj5kYvkaBk+fdlO
	hOCG7OioWwWzibh8MNfZc+FRFedczAtcG/SM6ozAstjOEpts1IgrmcBIxgqgO5vBOhjXhhwQxLBk3
	Bp7PY06axYhefVgsyX8EgVCUcunZ0/BhnLAN0lsWgkgLefgGEBRyKzlUzN4oH1bzNHRHPMkcdZNjl
	Tw5gTKCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z9A-00000001JRD-0X31;
	Mon, 21 Sep 2026 08:13:08 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z98-00000001JQo-1EOW
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:13:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C0371F810;
	Mon, 21 Sep 2026 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eocv3+CyE8Q3Pw2FFGy3jXMj6dAV64/waqi6O7npLqY=;
	b=wIjM55/rgO0dTHy41UbA/FYYX1vy+V3da5WhNJmSKpt3S0XT3E1mGbeAvCdMUP8jxBOsOp
	7AZ6IbMTjhujHxKdhi32Y1wQqmCrSK2aCWA0WuMTbRaG2pn8liuhy/0uDwPsR+45lKCoZV
	cS0iMwfEyebg3kNcEE5Fr7kMsRx1iFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eocv3+CyE8Q3Pw2FFGy3jXMj6dAV64/waqi6O7npLqY=;
	b=GVBroZHab8IP+Eyzyg96gczapRXJMr3sr4ODGRaHyxvlbSnZkpaZ+HjGdCpS4nDfy8QMd7
	chx/Vy8CRBGcP5Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G0y/1Jme";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j71dVwbu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eocv3+CyE8Q3Pw2FFGy3jXMj6dAV64/waqi6O7npLqY=;
	b=G0y/1JmeuhIEUtM3+kr+AYxjIduJ8hlesNZdxqCkva3Aqw3Ea3NkyX0hd3CfHeod0Qpwbl
	wcTqpz2tRvyk0TTa+v1yGU4PfSotklcasyoCLo7kKbA+Wn6v4xpiD2uxGSEYCPyEq1Zod0
	Zc79C+hqer4ORSz1EDRKGDPf9x5DkFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eocv3+CyE8Q3Pw2FFGy3jXMj6dAV64/waqi6O7npLqY=;
	b=j71dVwbuFhvNPBJn4C+zExxs5XL1a1uf1kpROpFtaX0wq2mmpRUbFNQCNLnfKVb8ovL/9x
	PEVY0CGROJkgvPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB99139D0;
	Mon, 21 Sep 2026 08:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8C10FAfnsGo4IgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 08:12:55 +0000
Message-ID: <ad652a54-a1b4-4a47-91da-d1e6922904d2@suse.de>
Date: Mon, 21 Sep 2026 10:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] nvme: let controller deletion wait out a fencing
 window
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
 <20260918181614.3947933-19-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260918181614.3947933-19-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C0371F810
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,purestorage.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_011306_510279_85305C70 
X-CRM114-Status: GOOD (  17.07  )
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

On 9/18/26 8:14 PM, Mohamed Khalfella wrote:
> DELETING is not reachable from FENCING or FENCED, so during a fencing
> window nvme_delete_ctrl() fails with -EBUSY. Its callers assume
> deleting a live controller cannot fail: a sysfs disconnect is silently
> dropped after the delete_controller node is already gone, rdma device
> removal returns with the controller still holding resources on the
> outgoing device, and module unload leaks live controllers.
> 
> Fencing is time-bounded and always ends in a state that allows
> deletion. Add nvme_delete_ctrl_wait(), which waits on ctrl->state_wq
> for the fencing window to end and retries, and use it in the tcp/rdma
> module exit paths and rdma device removal. Make nvme_delete_ctrl_sync()
> wait the same way so a sysfs disconnect during fencing is delayed
> instead of dropped.
> 
> nvme-fc's remoteport unregister with dev_loss_tmo == 0 keeps the
> non-waiting call since it runs under rport->lock; it does not need to
> wait, as dev_loss_end has already expired and the reconnect path
> deletes the controller once fencing completes.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c |  4 ++--
>   drivers/nvme/host/tcp.c  |  2 +-
>   4 files changed, 43 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

