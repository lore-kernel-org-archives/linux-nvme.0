Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D407C54ED1
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=; b=LZKaySGt/ErpT8umiQRyz5QuQp
	RSsOeWQMTs0Y0YXFL3U5jP6JvNb//KuHjGlDxLThT4h+Pu47ymNbuheyW2g3ElqoBZ/rhIf8QQUfD
	eagvF6RZ5ssE8LTNgz5RKzW1KlTegU+tHrXEyobl3Ms6YCG9T6gmBRfctH8zXR07RmSSOAdd2eocF
	2/8eMRsS7H6ZrIxX4fTHizdp7TBEadVz2lX/XHLYsyyZU7q2U61dSAwTTUx4tsMQW2RYnS9sWFW/E
	2gvzxRXMsJ3icjuh5Q7Rp6SXiWHlPjiPDRwfMy9rg4hUHwPT03Y/lp9eerc18UQW89ev1XMrFyNrN
	A4t5ywCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHghw-0000000FT2R-0BUw;
	Wed, 21 May 2025 10:29:56 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgON-0000000FPQX-2EJT
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 10:09:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865802090F;
	Wed, 21 May 2025 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=JlBM26suErECduo/NiesDgfnWAETytXGdEvIVlC34VVSfaasE9XErF9hZySxdjhmeZMho8
	w+sNbicoJ/pi3vVy46H+sXvz4T1FjE3f5YOyU921SqqBe8fFMX3s1FikWXjNKfWvRDYTQX
	9qFJ3Q/YffthB8SI7bPujl8CAVm5Djk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=kjgxIqumnz+LccUy5yZYNn5hO2wYwCeOQAk2mwbZWehT03u8MaLgCASxuhhZwzumzc6Hj0
	hBDzGeYTmmfxVJCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=JlBM26suErECduo/NiesDgfnWAETytXGdEvIVlC34VVSfaasE9XErF9hZySxdjhmeZMho8
	w+sNbicoJ/pi3vVy46H+sXvz4T1FjE3f5YOyU921SqqBe8fFMX3s1FikWXjNKfWvRDYTQX
	9qFJ3Q/YffthB8SI7bPujl8CAVm5Djk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=kjgxIqumnz+LccUy5yZYNn5hO2wYwCeOQAk2mwbZWehT03u8MaLgCASxuhhZwzumzc6Hj0
	hBDzGeYTmmfxVJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5388413888;
	Wed, 21 May 2025 10:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HY1XE2WmLWgoSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:09:41 +0000
Message-ID: <2f9aef5f-91c5-4501-ae83-0efcf2a79f2f@suse.de>
Date: Wed, 21 May 2025 12:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] net: introduce CONFIG_NET_CRC32C
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-2-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_030943_715352_74D6E1A6 
X-CRM114-Status: GOOD (  13.13  )
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

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a hidden kconfig symbol NET_CRC32C that will group together the
> functions that calculate CRC32C checksums of packets, so that these
> don't have to be built into NET-enabled kernels that don't need them.
> 
> Make skb_crc32c_csum_help() (which is called only when IP_SCTP is
> enabled) conditional on this symbol, and make IP_SCTP select it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   net/Kconfig      | 4 ++++
>   net/core/dev.c   | 2 ++
>   net/sctp/Kconfig | 1 +
>   3 files changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

