Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C43CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5Xoe55vmetX/K5/lmhHWjp+pQxbmE7CkYgBOpJVzmg=; b=j4HjGXr85zNimbPLckWYyItEWX
	fUd9mDeQ7wRmAfMQGGsIliNTrkz2Me3QSmroMkBrPoTI1UDEe12WrzXyi9MYbQL4zDLaNJUaeM+nt
	Dmbcic36Xr/xLoYVVC9uNUi9ZIXeY/Kmu0pF/xuysO7Ktjp8Jdn6ywCa6uINSQ3JkDMvqnUenxdEO
	fs+zngUAnot83uiQI7W/MKzotNLzbB/YI6orCg9D46Bli3FA0nJg9K0kirN4j29lWdOvFdash/hnx
	+qrk9WjxGB8x2f0++8mi5ImV2mrFyjhKPun1hWxm7sPhTzrBr1k8ukQt0ZPxGhWBcGEa0liUuqp9D
	ym+MmuFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG7x-00000000jng-34t0;
	Tue, 19 May 2026 08:48:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG7u-00000000jmv-1bHp
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:48:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ACAE6B050;
	Tue, 19 May 2026 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5Xoe55vmetX/K5/lmhHWjp+pQxbmE7CkYgBOpJVzmg=;
	b=fhDTchMoOY1Pzlq7YxH7/QlZ9hbX2yZv3AZ8mB6hZ7WpzqTj9/uyUlpff9+KtPP4OWiz70
	fhmOhxdxg7QdJBIbX/uzQt/0DRqog3C4rinEPBpKNn0hrs2MCbNREqdzaEWKNhFMPfsjhV
	/M012WxtQztJEcCbjsQHOZ6f8iT42+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5Xoe55vmetX/K5/lmhHWjp+pQxbmE7CkYgBOpJVzmg=;
	b=5gCl3cpINNyNfT7rZQiY6GGNCDnjqIwtIVfaZQBcsDFCAsmzZqlpHZAm9OTf+ec2/PQAiL
	ritfRcyQ45GVcNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fhDTchMo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5gCl3cpI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5Xoe55vmetX/K5/lmhHWjp+pQxbmE7CkYgBOpJVzmg=;
	b=fhDTchMoOY1Pzlq7YxH7/QlZ9hbX2yZv3AZ8mB6hZ7WpzqTj9/uyUlpff9+KtPP4OWiz70
	fhmOhxdxg7QdJBIbX/uzQt/0DRqog3C4rinEPBpKNn0hrs2MCbNREqdzaEWKNhFMPfsjhV
	/M012WxtQztJEcCbjsQHOZ6f8iT42+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5Xoe55vmetX/K5/lmhHWjp+pQxbmE7CkYgBOpJVzmg=;
	b=5gCl3cpINNyNfT7rZQiY6GGNCDnjqIwtIVfaZQBcsDFCAsmzZqlpHZAm9OTf+ec2/PQAiL
	ritfRcyQ45GVcNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40420593A8;
	Tue, 19 May 2026 08:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LO7eDuAjDGqZIQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:48:32 +0000
Message-ID: <d1830701-d2a7-4776-9381-4b4c1f761508@suse.de>
Date: Tue, 19 May 2026 10:48:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/7] nvme: remove redundant timeout argument from
 nvme_wait_freeze_timeout
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-3-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260514083255.41109-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,purestorage.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,purestorage.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7ACAE6B050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_014834_589664_175B9281 
X-CRM114-Status: UNSURE (   9.56  )
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

On 5/14/26 10:32, Maurizio Lombardi wrote:
> All callers of nvme_wait_freeze_timeout() currently pass the exact same
> NVME_IO_TIMEOUT default as their timeout argument.
> 
> Remove it and use a local variable.
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

