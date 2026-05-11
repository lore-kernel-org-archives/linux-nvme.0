Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C03CD3427
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQqH88Pb3+wAcX4x9LJqQxTMgjsFW1n+h6RB2OKupEw=; b=pXycMk2VdlzLnp9dBEpE0HNbAe
	7b/3rkO+ShTI35tY2NGJ2/CpbI98blhV76jnGp9Ni53OFIf4ohzUJCaU5JmAIGEjGehjQXPgrpMJj
	vg03hDNhHNTqdVOuPM2OJ8quaji7H5lp3LIE27hpj9XnjgRcKdDIurubW8Dft2hE5zPgd7XevXF60
	2McKAA5Q9dAM7UXmnNNJdQ5xiHHpYVAh4xP8mPaFUomQw6iRNd7S6hSsFmZ59Zdk35k3644CK5yKH
	wQCTTLuihw3U15EEacQPsaWKMeedYsMk7XKvYcIq10CDWh38VZDZfGXBMgQB7RCBgDcuG/gK+s5Sh
	mHcIfrMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNI0-0000000D0nD-3IaI;
	Mon, 11 May 2026 09:51:04 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNHy-0000000D0m3-0bCb
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:51:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E213C6A94E;
	Mon, 11 May 2026 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778493060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQqH88Pb3+wAcX4x9LJqQxTMgjsFW1n+h6RB2OKupEw=;
	b=GbqARzuWafwQnwP8o68cll/zGvsCcJNDwpcUMGHM26nRipuc0VYKDLL0Cf62SgXX7rjg20
	0CJUBQB7+3tDH7BA6hlemYI/86am8Z3QFDwZkK2Ttn10ycx0JUlsN7Jr6ibbsjJbsbRviC
	Nd8Beui1QydUQYxRQ2VKTRgEtCQgXZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778493060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQqH88Pb3+wAcX4x9LJqQxTMgjsFW1n+h6RB2OKupEw=;
	b=43Xlbq+FISg7DNRjgIJbCPWyrVvM0zRK9IwH8uipXaaRULM9FTgnooeXYPHtPXeZvRhIwG
	2q5rNYyIo25n8mAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RUChAEXq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zdwfNy6t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778493059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQqH88Pb3+wAcX4x9LJqQxTMgjsFW1n+h6RB2OKupEw=;
	b=RUChAEXqxamTxJ2W2KZAjfVLN+Y8/Xufc4gkFu0gImSuPTzz4DMbyB59IJR5aORTAcaAI8
	P8JlAPDo7wNKGNNyJw5HcZVsdwEbYKB33lx1hjp86SexV0C3tS2GuKaa/3pC59CeQRHDQy
	v5EctxjEhkf1nbWBzeagT/omtmNZdic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778493059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQqH88Pb3+wAcX4x9LJqQxTMgjsFW1n+h6RB2OKupEw=;
	b=zdwfNy6tXVmLOgV3P7TwuwdcVxQwGwgtxjUbYmv1iLrUN2OANK+C7GT3oTxHEMt8mr6sWq
	mI0I/Dg5iUm1o5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2816593A3;
	Mon, 11 May 2026 09:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f8wLL4OmAWozRQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 May 2026 09:50:59 +0000
Message-ID: <b7f7d6ca-3b13-47ff-a40f-5bb6912a31e1@suse.de>
Date: Mon, 11 May 2026 11:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/9] nvme: use per controller timeout waits over
 depending on global default
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-7-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260508133335.98612-7-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E213C6A94E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_025102_326379_4918223A 
X-CRM114-Status: UNSURE (   8.20  )
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

On 5/8/26 15:33, Maurizio Lombardi wrote:
> Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
> nvme_wait_freeze_timeout, use the controller's preferred timeout.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/apple.c | 2 +-
>   drivers/nvme/host/core.c  | 3 ++-
>   drivers/nvme/host/nvme.h  | 2 +-
>   drivers/nvme/host/pci.c   | 2 +-
>   drivers/nvme/host/rdma.c  | 2 +-
>   drivers/nvme/host/tcp.c   | 2 +-
>   6 files changed, 7 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

