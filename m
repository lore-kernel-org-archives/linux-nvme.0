Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E539C02196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmA3JMFVCugjaIu8pMze5/kIhwWYMGJ3iCDbG3F/vlE=; b=4D3NOh9FNB/WpsFRRFnQWnbNNM
	2shfDtbFTLa/UAQgdwao/BJ4keIz9JwF5MH0or7FLSREUYOfVhwsSPMhQoVyLtHuPX3M0TvIc46Ix
	VMBMb7BAr5HUNsL5SMzsroHFh/DyI4z/menEAgdekZpvNy8Xk9atBBxkk/acwU7nmq79rQtOxcK/R
	8BN/zN/23+XZTaw4SGOq7j4XsY/qMLRnUfhc1j5lUrc6OUF9MgCiR6svBer+HpHejMIsnawm65GE7
	aNDSfoXbQsmJsQt04ts9HvStBJYQ6g9a8VFtJkb//FakDVdeHe+/dSQP/cQPBXrzj3Nml6THNDSQL
	WLmsJtLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tewvy-0000000FaFe-1X9l;
	Mon, 03 Feb 2025 13:56:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tewvG-0000000Fa7f-2bis
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 13:55:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0CEE21109;
	Mon,  3 Feb 2025 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738590928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmA3JMFVCugjaIu8pMze5/kIhwWYMGJ3iCDbG3F/vlE=;
	b=s5eRFBsyF6mXQ+ewAiMr5Omsh116PxtGnm7TpE/JrmkJHkiRILJlBJSMGwrQ9KSb0vIp1P
	uelkHI7qJ9FgTOEacHqCLGUgXUgxCFVFhBiYX5iR2pSHJDFmIFrK9LqTgIXYDA7jy83WKB
	mR4QsBkdHP0oXtiG0YW5eO35OTFBni4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738590928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmA3JMFVCugjaIu8pMze5/kIhwWYMGJ3iCDbG3F/vlE=;
	b=Nmg0NYd6wqmmyfX6dcC3EEMqWINneqkcxR32PNlZCKbioZJDswpaXN5vzWptw5K8RTYEtE
	28NH5DYALCCq4LDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YMqleeDm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7K+5JSQs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738590924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmA3JMFVCugjaIu8pMze5/kIhwWYMGJ3iCDbG3F/vlE=;
	b=YMqleeDmC9O/LT8ygHbLvZ5Oe2f/dRBqr71jq/H9wEcuEjPNkaxy8vYbIRVExm0xBx12bM
	8kc8HcAKhjcINSg3jS0LIutXYZjFuxmUXpk2d+GxIPzesxpiaiRYcfW9TGRyV/6EQla105
	1Htcns8owMHNQIotAli2Ro16X2LUfo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738590924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmA3JMFVCugjaIu8pMze5/kIhwWYMGJ3iCDbG3F/vlE=;
	b=7K+5JSQsNHBV2NUkgmrScYgL1tEdn1wfqZtoBuGLh1RYp+Evb2v0zgfUkxV3aJdrpO9hXI
	1eARetsZPlWKVkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F53013795;
	Mon,  3 Feb 2025 13:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zK0YIszKoGcwOQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Feb 2025 13:55:24 +0000
Message-ID: <0db4c42f-8fbb-4b78-bfdc-0e0789a53d02@suse.de>
Date: Mon, 3 Feb 2025 14:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] nvme-keyring: add nvme_tls_psk_refresh()
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
 <20250122165829.11603-6-hare@kernel.org> <20250128090044.GD25760@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128090044.GD25760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0CEE21109
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_055534_805331_3B69E5F6 
X-CRM114-Status: GOOD (  13.37  )
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

On 1/28/25 10:00, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 05:58:24PM +0100, Hannes Reinecke wrote:
>> +static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
>> +		const char *hostnqn, char *subnqn, u8 hmac_id,
>> +		u8 *data, size_t data_len, const char *digest)
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
> 
> Is this supposed to be -EOPNOTSUPP?
> 
Possibly.

> Also the later added callers treat this an an error.  Should this
> stub be reachable at all?
> 
Yes, and no.
The function is called unconditionally from drivers/nvme/host/tcp.c,
so we need to provide the stub when nvme-keyring is not available.
I could make it conditional depending on CONFIG_NVME_KEYRING, but
then Sagi wanted to reduce the usage of conditional compilations.
I don't mind.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

