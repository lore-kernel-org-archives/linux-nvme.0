Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF28BC54E90
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=; b=eYfGj3tjOXORl3yHUeoUBhFkNZ
	3vLcxgOFVNIr/7D/CDtm9NTBUY8t7e4nuH/IGTkNmeT/DEWgU1RmZlzbrbZLpgQroAzUrxCUFaH9i
	b8jO2jMkSZbIdr7E+tDTcSZK+3zUbSUUN2EfDMagdu+98+gL6lhSwGVxdnc1EqBst9vMYj/Sqz2t5
	bsL064AhGc0Vf6/P8v8y4+P8LhJcFZsf263BcqAprBIEQ4cYx6gVghiD1X4S08TOvelyqwJpFIK5n
	o4cyBjuObONve4+AAQcNfK9aMAbhClQ6UGspDinLdiYMahXkT6NUsa2VVcI+NMnyl6B/tZWqA95Tt
	G8gQCQNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgi2-0000000FTDi-2dfv;
	Wed, 21 May 2025 10:30:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgRe-0000000FPuf-2SBw
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 10:13:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2709F20922;
	Wed, 21 May 2025 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=Cmi+n+YBZA+ZZOwbg22YbtkbpAvJkjXoXQGRfTxHu6cMDhQ/X3gEGiRavHs4gQe7ZwxxmF
	K9Y2u5jD3UXRzNIXLDOpfHXO+IsXVd08vs8ywrRrxBWfsPokerRmW4LcU67NLbDLiyyJcQ
	tsNG/z5NZGZMyWssyz8GnZK5iTvKyYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=vrAuruo2cIf9bjUYr46d33GAeCYFFd+6NfNcwBLii7Ci+VFyxwAZaYa9vEnCzQu4Ka9Sog
	vWxtJFA3aLdqu2Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=Cmi+n+YBZA+ZZOwbg22YbtkbpAvJkjXoXQGRfTxHu6cMDhQ/X3gEGiRavHs4gQe7ZwxxmF
	K9Y2u5jD3UXRzNIXLDOpfHXO+IsXVd08vs8ywrRrxBWfsPokerRmW4LcU67NLbDLiyyJcQ
	tsNG/z5NZGZMyWssyz8GnZK5iTvKyYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=vrAuruo2cIf9bjUYr46d33GAeCYFFd+6NfNcwBLii7Ci+VFyxwAZaYa9vEnCzQu4Ka9Sog
	vWxtJFA3aLdqu2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E835C13AA0;
	Wed, 21 May 2025 10:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJLFNzCnLWguTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:13:04 +0000
Message-ID: <c5807d92-3820-4d82-8937-06cd2ecd3d1d@suse.de>
Date: Wed, 21 May 2025 12:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] net: use skb_crc32c() in skb_crc32c_csum_help()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-4-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_031306_772520_769811E6 
X-CRM114-Status: GOOD (  10.70  )
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
> Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C, just call the new function skb_crc32c().  This is faster
> and simpler.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   net/core/dev.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

