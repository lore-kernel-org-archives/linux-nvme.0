Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94811C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=COKFQTKQosvNZzR6NiNDAcWi2tt2dVz/zpebkiOz99Y=; b=h+4ODtG/1rJQube2DSE933Yg1n
	CLn4oRrk1n0ilpAP3MMG66KTsp1a8PPwtXdOvAv9TMgp+8EINdGeAY4K98fVKxSXHO2N0KBR7bFdI
	5EguOQacT5LxwIdPh3n/9/cDVSL92PQBdV+/ZPq9LUbnm6YFsJKxuaHzACKNoOsiwaroM9AJ5wwIO
	1UpAabFwL4o+7fQraJUUpvuq+xIHZbyYyEWqfAMYOlaIYJQq5aD2Tf3F24xkyNDlbz001ZKms1Brf
	NsUWR2/GViA2Ko3WJevuc2tF2rAa8E4BeHRYgugsir2SidrTMHJbHFHUbGlYUQ08rKtXH9xvQ43ZP
	7lhY+A0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSWey-001jFv-2C;
	Wed, 24 Jan 2024 06:22:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSWev-001jEl-22
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 06:22:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 108E121F44;
	Wed, 24 Jan 2024 06:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COKFQTKQosvNZzR6NiNDAcWi2tt2dVz/zpebkiOz99Y=;
	b=juZp0ik7BIOhBbD548EnFVchd+AN9s+BE1+/JKcd4m5AsYSjxcMm+G9IqyYrUJIHRF8y9a
	EfDFUqYIiikbQYzFPc619POmR4ZUanvVxKr1qGpvTSAsBbLO+EENzmTfNRUcUN4IXeUcLI
	a6retV1PPVe1oqG3hTSaQyHH8wffTNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COKFQTKQosvNZzR6NiNDAcWi2tt2dVz/zpebkiOz99Y=;
	b=XaJSeZsDlT6DrNax/cbU/9ZflknJdBwrLAcWJe3zHquN/upHwQlv9LWzyQMmt9Es/t+GvC
	ttv9CM1sNw2r8ZAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COKFQTKQosvNZzR6NiNDAcWi2tt2dVz/zpebkiOz99Y=;
	b=juZp0ik7BIOhBbD548EnFVchd+AN9s+BE1+/JKcd4m5AsYSjxcMm+G9IqyYrUJIHRF8y9a
	EfDFUqYIiikbQYzFPc619POmR4ZUanvVxKr1qGpvTSAsBbLO+EENzmTfNRUcUN4IXeUcLI
	a6retV1PPVe1oqG3hTSaQyHH8wffTNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COKFQTKQosvNZzR6NiNDAcWi2tt2dVz/zpebkiOz99Y=;
	b=XaJSeZsDlT6DrNax/cbU/9ZflknJdBwrLAcWJe3zHquN/upHwQlv9LWzyQMmt9Es/t+GvC
	ttv9CM1sNw2r8ZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37E211333E;
	Wed, 24 Jan 2024 06:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OxhC7essGWZSQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:22:47 +0000
Message-ID: <baa5f405-4289-4b5c-acd3-ea5d5d3b9e32@suse.de>
Date: Wed, 24 Jan 2024 07:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] loop: use the atomic queue limits update API
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-16-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=juZp0ik7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XaJSeZsD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.23)[89.43%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 108E121F44
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_222249_816097_B5B1FB3D 
X-CRM114-Status: GOOD (  10.98  )
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

On 1/22/24 18:36, Christoph Hellwig wrote:
> Pass the default limits to blk_mq_alloc_disk and then use the
> queue_limits_{start,commit}_update API to change the limits in an
> atomic way on existing loop gendisks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/loop.c | 41 +++++++++++++++++++++++++----------------
>   1 file changed, 25 insertions(+), 16 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


