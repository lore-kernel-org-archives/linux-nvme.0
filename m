Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F860A263C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I2dpHFpb;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DKvWZxwz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yhpd7nZe;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DKvWZxwz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yhpd7nZe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/PT46a5OQHjLVPNOL9vrXw1V6oTcz8SAwynmCtaEe1c=; b=I2dpHFpbCanoul
	8HXHos07h1VBhiHseBcjruHaji1jGdF+kjI3rpxWpqv5859CLD+P404aJj9Yi6csWGgtqYLBGHnaf
	kxq5zqhtjgqr9hQvVERkjS0OG8ul+9NXuLcC8luG42LkgbM4mWJ7/Cmu3DM73KOzZJRNiiVQnV2ml
	PnLHtYatfyuvGIMI/ZAcSdtq3BBpMZCxUOGFP3A+AX4rab9cqLIvwJCjOCBrG07coF0OT56EsnYJb
	XLjm/eGmQPS7nt9a0aaDshoj8EjEQJsHTp3vy3XABWv73pDsRSKiNchW/l+yrygbt0INmDU0T5KpP
	R9pVsokrEAnRAXEtM5dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4ZT-00000007CDg-2XES;
	Wed, 28 Oct 2026 14:24:07 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4ZR-00000007CCh-02JW
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:24:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93661220FB;
	Wed, 28 Oct 2026 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793197442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PT46a5OQHjLVPNOL9vrXw1V6oTcz8SAwynmCtaEe1c=;
	b=DKvWZxwzDkJbXDy0P6+jx85xmx9QUxpVMKD/2y0AEWF1zrDPHC+zE6BZYMiDslmjxbaOe5
	RX+yalO8CLnYWAJblkPgZiv1gJ6jIBh2rkE3iBxHULAqetrV5cZSxrEId6nnp+Bo+kJSfu
	ZFKdr2Dquf8m14DTOwaE3S/CEVPzFWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793197442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PT46a5OQHjLVPNOL9vrXw1V6oTcz8SAwynmCtaEe1c=;
	b=yhpd7nZezvjAErq4Q29OG2O8kgwoRgVCaV++xl/JvxbNR1vYV8GeDPbPUdHp8QQ6TIvJHm
	IgiohLDKGqycfkAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DKvWZxwz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yhpd7nZe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793197442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PT46a5OQHjLVPNOL9vrXw1V6oTcz8SAwynmCtaEe1c=;
	b=DKvWZxwzDkJbXDy0P6+jx85xmx9QUxpVMKD/2y0AEWF1zrDPHC+zE6BZYMiDslmjxbaOe5
	RX+yalO8CLnYWAJblkPgZiv1gJ6jIBh2rkE3iBxHULAqetrV5cZSxrEId6nnp+Bo+kJSfu
	ZFKdr2Dquf8m14DTOwaE3S/CEVPzFWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793197442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PT46a5OQHjLVPNOL9vrXw1V6oTcz8SAwynmCtaEe1c=;
	b=yhpd7nZezvjAErq4Q29OG2O8kgwoRgVCaV++xl/JvxbNR1vYV8GeDPbPUdHp8QQ6TIvJHm
	IgiohLDKGqycfkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CD781342D;
	Wed, 28 Oct 2026 14:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3PfsOIEF4mqHcwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 Oct 2026 14:24:02 +0000
Message-ID: <ebb1aa06-60cf-415c-9001-0d8267db81c0@suse.de>
Date: Wed, 28 Oct 2026 15:24:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 5/5] selftests/tls: add KeyUpdate tests
To: martin.nvme.dev@gmail.com, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <20261028-keyupdate-rfc-v2-5-eb5143b4c487@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028-keyupdate-rfc-v2-5-eb5143b4c487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93661220FB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_072405_336534_2F81CAC5 
X-CRM114-Status: GOOD (  14.46  )
X-Spam-Score: -2.1 (--)
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

On 10/28/26 2:52 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> Test the in-kernel KeyUpdate on a bidirectional connection with both
> traffic secrets registered on each socket:
> 
> - registration errors: wrong length, missing key, TLS 1.2, SM4, the
>    RX secret before the TX secret, and a secret that does not give the
>    installed key;
> - KeyUpdates in both directions with data around them;
> - a data record, a KeyUpdate and another data record queued before
>    the first read;
> - update_requested: the peer answers before its next data, and a
>    second request waits for the answer;
> - splice() across a KeyUpdate;
> - a key installed with TLS_TX removes the registered secrets;
> - after a key installed with TLS_RX, a new update_requested is
>    accepted;
> - TLS_TX_KEY_UPDATE on a shut down socket does not raise SIGPIPE;
> - more than 8 KeyUpdates in one second, and an invalid
>    request_update value, end the connection.
> 
> The keys are derived from the secrets with HKDF-Expand-Label, with the
> HMAC of the kernel through AF_ALG.
> 
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   tools/testing/selftests/net/config |   4 +
>   tools/testing/selftests/net/tls.c  | 412 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 416 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Cheers,

Hannes

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

