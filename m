Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FAC3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 06:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oO/NN2VoGkfrCjl16EdWXxEe98Spa96VwcxhLYGYiF4=; b=IXYZ3UjiqUII78TX5o0lbfYEp3
	SDYwytQEWbZfiIfyUbAxqTpSiXB5a8AZ86NfhlBMW8dYx7eIaxz8yMuEJC9pNiij2wCPLj/7uoEfE
	SAdA7XLIxkdvJlA1EGy+Bngrg2dCs1E+r+2yihOibKHenksACWpBUBCNN2UmE5aDd3qB6Ei+/i70v
	pigDC1Phzz8MyMI0ZsPxR23XfeuiP1MqOltVjLAhO6r6NjkogTyXvIWCePTGUK+oJ/D4nEQ+LA7kc
	MrPdGpDLDsp0PPYR3jfegjykdV6b8u0R1IY/5dwZI3vlZzPRDd2yV656ZWcfvvIPnHm6d5k/U47zd
	3U3LF7jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgvH-00000001mn6-2YOk;
	Fri, 19 Jul 2024 06:16:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgvD-00000001mm9-0u1l
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 06:16:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6D691FCFB;
	Fri, 19 Jul 2024 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721369809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO/NN2VoGkfrCjl16EdWXxEe98Spa96VwcxhLYGYiF4=;
	b=O5HTQ372wImLCrx+Q1SyrX0ifymgAdzgeesKsRQR87/AcFlw52eoyo4Q4ei+Sr2HzeyNCm
	+WpUM1ii8Kjnux7t9ffS6clxqsFFlof0rzutx8QiFMs1PsfFcN3xmG3hc3x3G7JJMC1c99
	Ln5SSorANGN2xIPac5iYlEfd4ITStrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721369809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO/NN2VoGkfrCjl16EdWXxEe98Spa96VwcxhLYGYiF4=;
	b=Nx7K8nsn3yDYuRFLtWkDRyvdurpK7O00p9Yri5SCRkr1/DCbUJ9RE2Pb+yz5qnyT+RShDp
	BlO78+0ksuh2dXCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721369809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO/NN2VoGkfrCjl16EdWXxEe98Spa96VwcxhLYGYiF4=;
	b=O5HTQ372wImLCrx+Q1SyrX0ifymgAdzgeesKsRQR87/AcFlw52eoyo4Q4ei+Sr2HzeyNCm
	+WpUM1ii8Kjnux7t9ffS6clxqsFFlof0rzutx8QiFMs1PsfFcN3xmG3hc3x3G7JJMC1c99
	Ln5SSorANGN2xIPac5iYlEfd4ITStrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721369809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO/NN2VoGkfrCjl16EdWXxEe98Spa96VwcxhLYGYiF4=;
	b=Nx7K8nsn3yDYuRFLtWkDRyvdurpK7O00p9Yri5SCRkr1/DCbUJ9RE2Pb+yz5qnyT+RShDp
	BlO78+0ksuh2dXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88663132CB;
	Fri, 19 Jul 2024 06:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qvsXH9EEmmZTEAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jul 2024 06:16:49 +0000
Message-ID: <d3dee732-a499-49f7-8c6c-0c03f7ad7d56@suse.de>
Date: Fri, 19 Jul 2024 08:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvme-keyring: restrict match length for version '1'
 identifiers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240718144858.19074-1-hare@kernel.org>
 <20240718144858.19074-2-hare@kernel.org> <20240719053433.GA21535@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240719053433.GA21535@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_231651_430921_9DB2C851 
X-CRM114-Status: GOOD (  15.72  )
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

On 7/19/24 07:34, Christoph Hellwig wrote:
> On Thu, Jul 18, 2024 at 04:48:51PM +0200, Hannes Reinecke wrote:
>> TP8018 changed the TLS PSK identifiers to append a PSK hash value,
>> so to lookup identifiers we should just consider the length of
>> the match value, not the length of the identifiers to compare
>> against.
>> And we should modify the PSK lookup algorithm to prefer v1 identifiers
>> as they can be uniquely identified.
> 
> Can you reword this a bit to remove the weird "we should" and state it
> in terms of requirements / recommendations from the standard.  Bonus
> points for adding actual references to the specifications.
> 
Okay.

>> @@ -109,19 +107,38 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
>>    *
>>    * 'Retained' PSKs (ie 'generated == false')
>>    * should be preferred to 'generated' PSKs,
>> + * PSKs with hash (psk_ver 1) should be
>> + * preferred to PSKs without (psk_ver 0),
>>    * and SHA-384 should be preferred to SHA-256.
> 
> Please reflow this to use up 80 characters and make the paragraph easily
> readable.
> 
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


