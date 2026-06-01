Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358A1CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 06:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXRXEQf/nRa17XmwGzcQ02I9v+pXoFho2XQT7cZB3sQ=; b=rcuwp157ImaOUZHqlF++RZBP92
	WvAo0Qyo21N1z2KHIUbBw3kfXITk05n064hbHiCTb3iA69kase/i2+5v8tl38i6zzUhgmtkQEuzJo
	YMadb+T0krPshLlmOyU8t1zWOVN2IVXzSEXrCGPjXAuBqwJQOB+7OX3O5nNuuR/ZcTSt7hAYX3rj0
	GXx5MmS7fg2S2bml5QZ7oAto1A0VxtyDKJkAtWH/ltRFNGXu21C0xhsGxCnSZpj8j8UuMGG1BlsOs
	XdHMNkED88WFPXY3A8qSxe658uxwjg7hy/3/MrDOODBEDIwiM+wzL6OvuypEemDid2PRGthr3X8V2
	wOjpAb+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTw01-0000000ABww-2amk;
	Mon, 01 Jun 2026 06:19:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTvzy-0000000ABw1-3Fx1
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 06:19:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12B5E67FE6;
	Mon,  1 Jun 2026 06:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780294779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXRXEQf/nRa17XmwGzcQ02I9v+pXoFho2XQT7cZB3sQ=;
	b=LXfcE/HolnHW721n/QU2wH9DQPGhNLCra/yOcHe+0xO/C0AB8BkGkVbGzbpiDov7mBipgW
	uLn/a3rp21tlMo4kKNXq8TfXHdNK3+9NblpW9uKR691q5UZpGoMTIzf66XF5mpgUbc07SV
	zF/rgtLIwvDHjrr5GaWoTl8HqmaEidw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780294779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXRXEQf/nRa17XmwGzcQ02I9v+pXoFho2XQT7cZB3sQ=;
	b=3aB0hBmILa7yEqhQBv8lZf7rbNH4kX5d6qltiVKV6axOLsw7aoMAAfo+G0b9WIrrVwejsn
	SGjn4LvaEb5rj4Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780294778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXRXEQf/nRa17XmwGzcQ02I9v+pXoFho2XQT7cZB3sQ=;
	b=AZ7agGnVIYHJoPFkpDVDbLw/oypozXrRsCGKRqmfrJ8IpEHSoLYuQFS9l7FchG/0LnzKWL
	m+KmPYZ8u2fiel04WT0ZuiG3dXpikrfOOPPl8JaynOlLnMHjS1u+hRaujQJ/GsZNSN/hhE
	Mgku+G0Z7FXxjj1PURyYfb+ruuCgJ1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780294778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXRXEQf/nRa17XmwGzcQ02I9v+pXoFho2XQT7cZB3sQ=;
	b=4cYIG6pko2tCvl9M4uGEihcfrlOtfNmLsuDqxVKp/JnEByXGii1m10rmoIG/Tup6QAok48
	BRQDcOgwG8XAnSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2703779A7;
	Mon,  1 Jun 2026 06:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aoXIMXkkHWqcEQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jun 2026 06:19:37 +0000
Message-ID: <959eccd1-38eb-407d-92f3-96ec54a7d85a@suse.de>
Date: Mon, 1 Jun 2026 08:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: validate reply message payload bounds against
 transfer length
To: Tianchu Chen <tianchu.chen@linux.dev>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_231942_992963_7A079A8C 
X-CRM114-Status: GOOD (  12.61  )
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

On 5/29/26 16:18, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> nvmet_auth_reply() accesses the variable-length rval[] array using
> attacker-controlled hl (hash length) and dhvlen (DH value length) fields
> without verifying they fit within the allocated buffer of tl bytes.
> 
> A malicious NVMe-oF initiator can craft a DHCHAP_REPLY message with a
> small transfer length but large hl/dhvlen values, causing out-of-bounds
> heap reads when the target processes the DH public key (rval + 2*hl) or
> performs the host response memcmp.
> 
> With DH authentication configured, the OOB pointer is passed directly to
> sg_init_one() and read by crypto_kpp_compute_shared_secret(), reaching
> up to 526 bytes past the buffer. This is exploitable pre-authentication.
> 
> Add bounds validation ensuring sizeof(*data) + 2*hl + dhvlen <= tl before
> any access to the variable-length fields.
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

