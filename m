Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11735E9B354
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pKVIpPmX1xfasrJV1zTkUu9jiTfhDgI2idm7xFSgSE=; b=HFN0jejtS6h/3gR4TPMUdZHVmW
	KI5/0fBdunhvbXmcbIsMOgBQaYEPtp16mecbi4An7caZ1e2u0moS6Fg9fJh+wnHCNNWscoMFVmy4d
	HM3qY21Cpg4XTbmotIfeiA+V4OfL5ZRBOtTLUzFcAuQVto2WVIweg6/my+b3vEIGaGcPVjX4onhYU
	HziqnSl6RQCtIrVE1jGGY/DxgRSo6VZyd8zmCtbBD92oWip+0WnkKx4hliupQbgsk+YBIqBQ2mw9V
	MD13TFsNslwLD6dxqdAVEQs9gpV9y7ScFo/Hq8F1fumF6ZTo4QxXGVVEnqIzKqlRjiRVfcFIyDFcf
	JWa+7Thw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx08u-0000000Cekz-2CCv;
	Mon, 02 Mar 2026 10:04:48 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx08r-0000000CekR-3CCo
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 10:04:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9C9E3F99E;
	Mon,  2 Mar 2026 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772445883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pKVIpPmX1xfasrJV1zTkUu9jiTfhDgI2idm7xFSgSE=;
	b=c383eBSu14qZi3PY6ELAs/xn/+p1KtjM9MV+wiqWStjU6ctMpNRM8YMLQKS766e2Fih+G/
	e8BQmHc4svJAeLPww79UvPkRueufXj5sDJMGEd+1+hBYhHqsAUHFhHcV3gn9IuZAO+54U+
	M5xuDcbRo0lflnePdCHhrAR7jPmHMDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772445883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pKVIpPmX1xfasrJV1zTkUu9jiTfhDgI2idm7xFSgSE=;
	b=kuxV0+QUKgbUccGdoHSspDY6yYPyxA+kiVP+sOMRBTzxH+FniVSt3Gno70oZFfawms2BNn
	RokmAO7fl0hjPPCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c383eBSu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kuxV0+QU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772445883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pKVIpPmX1xfasrJV1zTkUu9jiTfhDgI2idm7xFSgSE=;
	b=c383eBSu14qZi3PY6ELAs/xn/+p1KtjM9MV+wiqWStjU6ctMpNRM8YMLQKS766e2Fih+G/
	e8BQmHc4svJAeLPww79UvPkRueufXj5sDJMGEd+1+hBYhHqsAUHFhHcV3gn9IuZAO+54U+
	M5xuDcbRo0lflnePdCHhrAR7jPmHMDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772445883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pKVIpPmX1xfasrJV1zTkUu9jiTfhDgI2idm7xFSgSE=;
	b=kuxV0+QUKgbUccGdoHSspDY6yYPyxA+kiVP+sOMRBTzxH+FniVSt3Gno70oZFfawms2BNn
	RokmAO7fl0hjPPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C5F73EA69;
	Mon,  2 Mar 2026 10:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VJezJbtgpWlYGQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 10:04:43 +0000
Message-ID: <1de7ef59-4236-4372-81f6-60d5a4f1e253@suse.de>
Date: Mon, 2 Mar 2026 11:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] nvme-auth: common: add KUnit tests for TLS key
 derivation
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-5-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-5-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B9C9E3F99E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_020446_106593_9A9BD833 
X-CRM114-Status: GOOD (  14.86  )
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

On 3/2/26 08:59, Eric Biggers wrote:
> Unit-test the sequence of function calls that derive tls_psk, so that we
> can be more confident that changes in the implementation don't break it.
> 
> Since the NVMe specification doesn't seem to include any test vectors
> for this (nor does its description of the algorithm seem to match what
> was actually implemented, for that matter), I just set the expected
> values to the values that the code currently produces.  In the case
> of SHA-512, nvme_auth_generate_digest() currently returns -EINVAL, so
> for now the test tests for that too.  If it is later determined that
> some other behavior is needed, the test can be updated accordingly.
> 
Nice.
You are correct, test vectors really would have been a good idea.
There are some attempts to specify values in the spec, but these
are woefully underspecified.
I'll see if we can fix that up.

Which discrepancies do you see between the specified algorithm
and the implementation?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

