Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF3D2069E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9R5uIroVqXXx3QtUxVOQW3D+wg8+A9m7sxTYmWRD9pc=; b=GWin+rKdM/MaHxd9j1+fPLD2a+
	LX+AgeWiql8CWWkYgk1DeHNV6hG+JbGv6fa8Jg1s1e1IGp4CN2o2DcKKbl9V9PEKQWkq3iMdKNC62
	C4iIfxiFv6LHgwNzg4Du5ZKrqbvnH7u7AaLivLX8MppSSFLHtung0q0DRZQSLGZPRwRPxJeM2Tq4a
	EKTuvLHwMBmTYWncUTt47kh1RUu7SpeCH4hLzfPe/7Fz6q/UOlqoc15+zKbs61QvFH5PX98lTlwAj
	1SM4ZKCUbWkyYs2wIO0f4rphI+6a+yXo52tqkOJGb7jaKz5xuTiLHpcLqcdwt3LL0w+pRRBmTGlJR
	NL0a9xtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0xiW-0000000AhyC-0Sow;
	Wed, 16 Oct 2024 06:41:08 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0xiK-0000000AhvI-3bWj
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 06:41:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E388B1F839;
	Wed, 16 Oct 2024 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729060855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R5uIroVqXXx3QtUxVOQW3D+wg8+A9m7sxTYmWRD9pc=;
	b=BHzVj3fWpvSNZdtCEKm1649cqZgMa7zbtVlfjriDRKG0eVlEG+yODrjDZHLbO13Mcta3Zr
	coY6TGATHNvXqftjHzlvw58fXepuy5KqSSKFTHEBQQUiCpHPOzZvJ4MJ8H7AsKl0n0kKge
	HQm7Eah1koVHFGNYMExjADQNs7t7HC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729060855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R5uIroVqXXx3QtUxVOQW3D+wg8+A9m7sxTYmWRD9pc=;
	b=gmyfamEOqo5i4uOrqZUmxcYXXjtgva84L1x5aMlvtpUzXuY6k9IjdrngvKRq/nH5SvfN4Y
	8OCp9wSsDonA0pCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uBkRXVx3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Oj1rxwVH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729060854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R5uIroVqXXx3QtUxVOQW3D+wg8+A9m7sxTYmWRD9pc=;
	b=uBkRXVx3ybptv43P25tpsq6Nq8+gU8Phr9pC0E9BZVI5K1U4QmXv/OLSoYHJiQ5/HBGwCb
	+08J2dIxTR55WfXfNNPc95fsuX3yc9LnQEa+dMQdS+HJtUY/RC9HDQIJ5PUn9s0xFynqUJ
	GTnxPj1qEmcv+kPHxYb9pcvO37375ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729060854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R5uIroVqXXx3QtUxVOQW3D+wg8+A9m7sxTYmWRD9pc=;
	b=Oj1rxwVHhTuCe+gpjFgJ6PyggTy8rMk6nKryEWb4qiizMfxMS8T+Oga2S/Gue34I1Q7p8s
	NtSaN9pJnGuXnOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9931613433;
	Wed, 16 Oct 2024 06:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id esS1I/ZfD2fdBQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 16 Oct 2024 06:40:54 +0000
Message-ID: <83934544-0e4e-42eb-a15b-8189a46273c7@suse.de>
Date: Wed, 16 Oct 2024 08:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20241011155430.43450-1-hare@kernel.org>
 <20241011155430.43450-2-hare@kernel.org>
 <20241014193814.GB1137@sol.localdomain>
 <e9ea2690-b3ac-47f0-a148-9e355841b6d0@suse.de>
 <20241015154110.GA2444622@google.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241015154110.GA2444622@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E388B1F839
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_234057_079218_715ECE33 
X-CRM114-Status: GOOD (  15.05  )
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

On 10/15/24 17:41, Eric Biggers wrote:
> On Tue, Oct 15, 2024 at 05:05:40PM +0200, Hannes Reinecke wrote:
>> On 10/14/24 21:38, Eric Biggers wrote:
>>> On Fri, Oct 11, 2024 at 05:54:22PM +0200, Hannes Reinecke wrote:
>>>> Separate out the HKDF functions into a separate module to
>>>> to make them available to other callers.
>>>> And add a testsuite to the module with test vectors
>>>> from RFC 5869 to ensure the integrity of the algorithm.
>>>
>>> integrity => correctness
>>>
>> Okay.
>>
>>>> +config CRYPTO_HKDF
>>>> +	tristate
>>>> +	select CRYPTO_SHA1 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
>>>> +	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
>>>> +	select CRYPTO_HASH2
>>>
>>> Any thoughts on including SHA512 tests instead of SHA1, given that SHA1 is
>>> obsolete and should not be used?
>>>
>> Hmm. The original implementation did use SHA1, so I used that.
>> But sure I can look into changing that.
> 
> If you're talking about fs/crypto/hkdf.c which is where you're borrowing the
> code from, that uses SHA512.
> 
Actually, I was talking about the test vectors themselves. RFC 5869 only 
gives test vectors for SHA1 and SHA256, so that's what I've used.
I've found additional test vectors for the other functions at
https://github.com/brycx/Test-Vector-Generation/blob/master/HKDF/hkdf-hmac-sha2-test-vectors.md
so I'll be using them for adding tests for SHA384 and SHA512 (TLS on 
NVMe-over-TCP is using SHA384, too) and delete the SHA1 ones.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


