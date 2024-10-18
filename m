Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB255D3C54C
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 06:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxjZYDm5Sal3TUEKTCPWe6UuJfYo/CaIotpuIZcHjQc=; b=jvM+IwRKk2L78qqF0IesqDyQoM
	33EAV6IwB60nsnidfGn4K8MKklTt7T9PeSGjNSXqLT0sllHbHhTi1ImcmsqT1DR2QAcrrWFzI1bDH
	jdRPi6dOuRbhQAwdHgVa4evOxfJgEEgwwLqKkMfu29PlmF2d6EOCmqgbA/HT12u9k8Y2VKzz0jnEN
	d6gouVLzSaccqY95EIPcmJdlCiYVEddNaJXLLufBgotPr13lGwI4l1E2Q4/2Nep7XmJeiVe5OtBZG
	Im+7FEp53asqAa+vrlHrMoetmYKcXtQqHJaE6m8Xjr4Fm55Y0hO1/TeTHLdZYCRovdOTHrOtxwHyu
	pYj5Y5aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1g6V-0000000H5Wf-0iXq;
	Fri, 18 Oct 2024 06:04:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1g4r-0000000H56q-0ndn
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 06:03:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21FA71FD95;
	Fri, 18 Oct 2024 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729231387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxjZYDm5Sal3TUEKTCPWe6UuJfYo/CaIotpuIZcHjQc=;
	b=wA7LwORPmt0YgtSGCykW67fZojpam67J/6r+9UIEHG2+3xlQSog7YgGtA64FlF1LiV36XI
	NXcycda+B/SAhfSnO09qo+aAA+CoiM8gvvVWHc/ZPbacWSaa8wU6F3fIYwAZY6MWkc0T9M
	rfFqEwLTYsiTj9Vp9CUOXVIheKuVopk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729231387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxjZYDm5Sal3TUEKTCPWe6UuJfYo/CaIotpuIZcHjQc=;
	b=+iSKMZb/oOFPIihIhNGIyIFKAxbonL2mvNTkQufH/7pfDCufmtUkA+tUOBw+4qaWBRP7Y5
	SdqR9SljN+g2SKCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wA7LwORP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+iSKMZb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729231387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxjZYDm5Sal3TUEKTCPWe6UuJfYo/CaIotpuIZcHjQc=;
	b=wA7LwORPmt0YgtSGCykW67fZojpam67J/6r+9UIEHG2+3xlQSog7YgGtA64FlF1LiV36XI
	NXcycda+B/SAhfSnO09qo+aAA+CoiM8gvvVWHc/ZPbacWSaa8wU6F3fIYwAZY6MWkc0T9M
	rfFqEwLTYsiTj9Vp9CUOXVIheKuVopk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729231387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxjZYDm5Sal3TUEKTCPWe6UuJfYo/CaIotpuIZcHjQc=;
	b=+iSKMZb/oOFPIihIhNGIyIFKAxbonL2mvNTkQufH/7pfDCufmtUkA+tUOBw+4qaWBRP7Y5
	SdqR9SljN+g2SKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B229C13680;
	Fri, 18 Oct 2024 06:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z/nRKRr6EWfeHAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 18 Oct 2024 06:03:06 +0000
Message-ID: <a56e6324-ea8c-488e-85b5-28c77d2d326d@suse.de>
Date: Fri, 18 Oct 2024 08:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 4/6] fs: introduce per-io hint support flag
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-5-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241017160937.2283225-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21FA71FD95
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_230309_407544_5FF3AC58 
X-CRM114-Status: GOOD (  10.47  )
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

On 10/17/24 18:09, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A block device may support write hints on a per-io basis. The raw block
> file operations can effectively use these, but real filesystems are not
> ready to make use of this. Provide a file_operations flag to indicate
> support, and set it for the block file operations.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/fops.c       | 2 +-
>   include/linux/fs.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

