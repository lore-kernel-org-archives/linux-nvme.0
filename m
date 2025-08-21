Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DBDCA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InAkVj+0f+oTzBZfDquhzuW4FV55ImDwZNuzKyalzN4=; b=em+pGEKWGhOrfE4RE8A+CWYLDA
	1qxLl5rXkbXZwOQvi9L6SVWCGHdrWLv6Crqm20hxVhqyohhGMu2BLAPB+10n1Zl+WUlRjs01rrl9X
	5ICGNkjSaJBpKXsNWrhCIURo1s/k6W2gS275XGilZB5X+DJoDVtUgayVw+p+ozOIayV80fc5atmfq
	wwXYd4VSt86fTC2V15Au2kI40BNM55UX4y3Fd9I77kszyp1szXs0oX7Er5Coo1bybFeVnJRCcmkJH
	AQD3icyYIngZeVZ3nYQDpouJ0QMPJ+31SRcShj9x5xLQzzWjAuU5bOQXQXND7oZB+ZYmxekYCPGFC
	WfkiGANg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up1lh-0000000GQAL-3kP1;
	Thu, 21 Aug 2025 09:39:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoz2I-0000000FzH1-0TIS
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 06:44:35 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79FD821B7A;
	Thu, 21 Aug 2025 06:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755758672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InAkVj+0f+oTzBZfDquhzuW4FV55ImDwZNuzKyalzN4=;
	b=EMg1YY39lUV1WnRRXT4Do5vuoHg8AYBnWDKrAlnrIAPhff+53QDtiVgglJKt8UFypl9BFC
	9sOeGxnIskDgeaG0Xifg5MuM5154G7KO+t+Gllf2IW/TrdhU+848VsExsCW2zjJx0l3k90
	EOn+VPll9JmEaVOa2XYhiqkvsiQsJOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755758672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InAkVj+0f+oTzBZfDquhzuW4FV55ImDwZNuzKyalzN4=;
	b=9XINEA2B79CDhHIc0UDQQnpP3zenhRVfr7vV2WuyJ3rOLpDc1eqHOB0BgIPJhcZ8w8PHBN
	mieu7sIekWCCG6BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755758672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InAkVj+0f+oTzBZfDquhzuW4FV55ImDwZNuzKyalzN4=;
	b=EMg1YY39lUV1WnRRXT4Do5vuoHg8AYBnWDKrAlnrIAPhff+53QDtiVgglJKt8UFypl9BFC
	9sOeGxnIskDgeaG0Xifg5MuM5154G7KO+t+Gllf2IW/TrdhU+848VsExsCW2zjJx0l3k90
	EOn+VPll9JmEaVOa2XYhiqkvsiQsJOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755758672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InAkVj+0f+oTzBZfDquhzuW4FV55ImDwZNuzKyalzN4=;
	b=9XINEA2B79CDhHIc0UDQQnpP3zenhRVfr7vV2WuyJ3rOLpDc1eqHOB0BgIPJhcZ8w8PHBN
	mieu7sIekWCCG6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2544B13867;
	Thu, 21 Aug 2025 06:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILJlB1DApmhmdgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 21 Aug 2025 06:44:32 +0000
Message-ID: <2b51c5ce-23cf-41ac-ba98-3eea7a67f1c0@suse.de>
Date: Thu, 21 Aug 2025 08:44:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
To: Chris Leech <cleech@redhat.com>, Eric Biggers <ebiggers@kernel.org>
Cc: hare@kernel.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20250820091211.25368-1-hare@kernel.org>
 <20250820091211.25368-2-hare@kernel.org> <20250820184633.GB1838@quark>
 <aKYmhusP6povB_TU@my-developer-toolbox-latest>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aKYmhusP6povB_TU@my-developer-toolbox-latest>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_234434_302833_6FB9B466 
X-CRM114-Status: GOOD (  18.81  )
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

On 8/20/25 21:48, Chris Leech wrote:
> On Wed, Aug 20, 2025 at 11:46:33AM -0700, Eric Biggers wrote:
>> On Wed, Aug 20, 2025 at 11:12:10AM +0200, hare@kernel.org wrote:
>>> From: Chris Leech <cleech@redhat.com>
>>>
>>> Provide an implementation of RFC 8446 (TLS 1.3) HKDF-Expand-Label
>>>
>>> Cc: Eric Biggers <ebiggers@kernel.org>
>>> Signed-off-by: Chris Leech <cleech@redhat.com>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   crypto/hkdf.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
>>>   include/crypto/hkdf.h |  4 ++++
>>>   2 files changed, 59 insertions(+)
>>>
>>> ...
>>
>> Does this belong in crypto/hkdf.c?  It seems to be specific to a
>> particular user of HKDF.
> 
> While this is needed for NVMe/TLS, it's a case of the NVMe
> specifications referencing a function defined in the TLS 1.3 RFC to be
> used.  I though it would be clearest to fix the open-coded implemenation
> by creating an RFC complient function, which is now no-longer specific
> to NVMe so I moved it out to crypto/hkdf.c
> 
> I don't know that there will be other users, it just seemed to make the
> most sense there.
> 
But having said that, we can easily move it into the nvme code, and let
others move it into crypto if there is a need.
Will be updating the patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

