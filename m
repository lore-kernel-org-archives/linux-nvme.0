Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF9606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PJGPPVm0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KkVLFtlG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V93KzKEf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KkVLFtlG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V93KzKEf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hZS4X6YTtXHQIZj1zUaeI9YGeu92/9OMhUSF11D9lCs=; b=PJGPPVm0OVMhX3
	egCVrEBVLKweGYeFiR2Nl8/Y3VP2CufFC1PdiyfRFzACGtfTFJKzx+RnaUEU404fmkmWRfVmFbXso
	EINBZtN4WSWmNRqEZuEBcsmFGKeH1ifB9UNA+MLWVi3cSfokGNTCAwFLe7dpFAvtP2CcpXL9w/NEZ
	XT2FNOTKBq1oqyV55cYuhuIL7b3JIWTvAFRvc304NYX2hZ/qmdFsUq+sPN5FISDTWhIqSPjKYRRAC
	vXXY7W/GZfUpOs8E1RNuH55qw210RxmG4XSponDGx9IjcXRvJynjFQpnJ6QJiXrxpMDAQVKmkXhy7
	b8UHWr/aemF2kIUol3bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrZN-00000001UAU-1XlX;
	Mon, 16 Nov 2026 07:56:05 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrZK-00000001U7o-2bDq
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:56:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54BA922246;
	Mon, 16 Nov 2026 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794815760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZS4X6YTtXHQIZj1zUaeI9YGeu92/9OMhUSF11D9lCs=;
	b=KkVLFtlGH62SO/gmI4fLLLpBqMfY4cIcz1fm3XuFRvf64jayAR8TDFyInG3PEbCYkfpJns
	2r/ml2SarRRNYJY9wziGIF5HJFA6oYrH0S+isvD7zl+dkcoQrJkjzpf7WlTHo1Zza6lG/q
	d8AFpWXjqdJstUTTV0WDGfnx6EQIFMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794815760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZS4X6YTtXHQIZj1zUaeI9YGeu92/9OMhUSF11D9lCs=;
	b=V93KzKEfiH3vh/s0ATOUIeWI3ZK1XppRLy4jxuUnSKyRY0NIX89Dx31GaZkgPljUKK6wQd
	KCBESYOq1d9wdlAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KkVLFtlG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V93KzKEf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794815760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZS4X6YTtXHQIZj1zUaeI9YGeu92/9OMhUSF11D9lCs=;
	b=KkVLFtlGH62SO/gmI4fLLLpBqMfY4cIcz1fm3XuFRvf64jayAR8TDFyInG3PEbCYkfpJns
	2r/ml2SarRRNYJY9wziGIF5HJFA6oYrH0S+isvD7zl+dkcoQrJkjzpf7WlTHo1Zza6lG/q
	d8AFpWXjqdJstUTTV0WDGfnx6EQIFMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794815760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZS4X6YTtXHQIZj1zUaeI9YGeu92/9OMhUSF11D9lCs=;
	b=V93KzKEfiH3vh/s0ATOUIeWI3ZK1XppRLy4jxuUnSKyRY0NIX89Dx31GaZkgPljUKK6wQd
	KCBESYOq1d9wdlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D57321334C;
	Mon, 16 Nov 2026 07:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F5TdKg+3+mpVRQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 07:55:59 +0000
Message-ID: <780c512e-52c0-48d5-9fa3-bd39edf440f1@suse.de>
Date: Mon, 16 Nov 2026 08:55:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/17] nvme: Add support for CQT to nvme host
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-18-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261114030454.2836543-18-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,suse.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,purestorage.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 54BA922246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_235602_957205_5D1C75AA 
X-CRM114-Status: GOOD (  14.94  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 4:04 AM, Mohamed Khalfella wrote:
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> limit for attempting Cross-Controller Recovery. Add ctrl->cqt, read its
> value from controller identify response, expose it via sysfs, and have
> nvme_fence_timeout_ms() account for it.
> 
> Use CQT to drive time-based recovery in fc, rdma, and tcp transports.
> Add a fenced_work delayed work to each transport controller. If CCR
> fails, fencing_work switches to error recovery immediately if CQT is not
> supported. Otherwise it schedules fenced_work after the remaining fence
> timeout, which also switches to error recovery when scheduled.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   Documentation/ABI/stable/sysfs-nvme | 10 +++++++++
>   drivers/nvme/host/core.c            |  1 +
>   drivers/nvme/host/fc.c              | 33 +++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h            |  5 +++--
>   drivers/nvme/host/rdma.c            | 32 ++++++++++++++++++++++++++--
>   drivers/nvme/host/sysfs.c           |  2 ++
>   drivers/nvme/host/tcp.c             | 32 ++++++++++++++++++++++++++--
>   7 files changed, 107 insertions(+), 8 deletions(-)
> 

Might be an idea to make the 'cqt' sysfs attribute R/W; this would
allow to restore the original behaviour and/or tweak systems which
do not expose the CQT value.
Otherwise:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

