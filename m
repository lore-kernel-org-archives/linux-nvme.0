Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47898CA0EEB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXcc8Qi3I7erKPfKf0vjWVMReCyCUrsBEQ+Ly40WZ7Y=; b=DRbxigFiAcHHmW96TXIvAZ8T/w
	Nlxj2CYD8XGCsHyaz50iYZcQnlMDqcs0beB/bGQtNadK7Wvf5i5GrRp+ZhMQIOmMapkNHVTS8oFAy
	RPWgclCV8nxQhVCa0GIv/zrLjo0fIJAF6C11dlyfFDECeGauyYhK6rE6SI1qrf91bHpcC/JrnPq9i
	zXqRHQuvr+8qdZE60pVvNFJyGw3OaB/rsYTk52VwWGgt+cpl1vTnsuc2z9hVWqvxkQVqtcSiIYOhe
	Lxbj7dxZZ4H9BvAvRcTffEI2By5iqQHAXIlu2j3SUHtbdaQzQlXDkkQdb/l/CVYhxnpSCekoAd0rd
	2JRRGBtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upSau-00000002kOm-3HS3;
	Fri, 22 Aug 2025 14:18:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upKxT-00000001ewT-0AzW
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 06:09:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C48411FBB7;
	Fri, 22 Aug 2025 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755842939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXcc8Qi3I7erKPfKf0vjWVMReCyCUrsBEQ+Ly40WZ7Y=;
	b=P4UU85s6tdpJGQ9qRi35Fef56l7A+jr6/EohcBGcZvACxP8Orczujhykvmky5iZ6hYNJBv
	zdWY/c49U9xwAC59HAW1uwbaMewVku5v3/52ybWkf43UTqSCsikQ9LES3XjUKWrWj8AIW3
	bgCRxK9P3hQsqiferpEmCHZ0//VLmlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755842939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXcc8Qi3I7erKPfKf0vjWVMReCyCUrsBEQ+Ly40WZ7Y=;
	b=vWKflsghuu8xC+9omqIuL5unM/8RKWihh4INQ9+FUp5ctXr0a1es4PfLipI4d0ZgFUXUPw
	bVfZUCbk3joDMiBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755842939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXcc8Qi3I7erKPfKf0vjWVMReCyCUrsBEQ+Ly40WZ7Y=;
	b=P4UU85s6tdpJGQ9qRi35Fef56l7A+jr6/EohcBGcZvACxP8Orczujhykvmky5iZ6hYNJBv
	zdWY/c49U9xwAC59HAW1uwbaMewVku5v3/52ybWkf43UTqSCsikQ9LES3XjUKWrWj8AIW3
	bgCRxK9P3hQsqiferpEmCHZ0//VLmlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755842939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXcc8Qi3I7erKPfKf0vjWVMReCyCUrsBEQ+Ly40WZ7Y=;
	b=vWKflsghuu8xC+9omqIuL5unM/8RKWihh4INQ9+FUp5ctXr0a1es4PfLipI4d0ZgFUXUPw
	bVfZUCbk3joDMiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DCF713931;
	Fri, 22 Aug 2025 06:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fgRGXsJqGgfcQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Aug 2025 06:08:59 +0000
Message-ID: <c2aa9eed-7207-4018-b5dc-b1b3c3e0fa34@suse.de>
Date: Fri, 22 Aug 2025 08:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvme: fixup HKDF-Expand-Label implementation
To: Eric Biggers <ebiggers@kernel.org>, Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20250821204816.2091293-1-cleech@redhat.com>
 <20250822010923.GA2458@quark>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250822010923.GA2458@quark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
X-CRM114-CacheID: sfid-20250821_230903_229350_63B80BDB 
X-CRM114-Status: GOOD (  14.87  )
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

On 8/22/25 03:09, Eric Biggers wrote:
> On Thu, Aug 21, 2025 at 01:48:14PM -0700, Chris Leech wrote:
>> As per RFC 8446 (TLS 1.3) the HKDF-Expand-Label function is using vectors
>> for the 'label' and 'context' field, but defines these vectors as a string
>> prefixed with the string length (in binary). The implementation in nvme
>> is missing the length prefix which was causing interoperability issues
>> with spec-conformant implementations.
>>
>> This patchset adds a function 'hkdf_expand_label()' to correctly implement
>> the HKDF-Expand-Label functionality and modifies the nvme driver to utilize
>> this function instead of the open-coded implementation.
>>
>> As usual, comments and reviews are welcome.
> 
> Well, it's nice that my review comment from last year is finally being
> addressed: https://lore.kernel.org/r/20240723014715.GB2319848@google.com
> 
Yeah, because I misread your comments, and was only focussed on the
'length' field (which is a 16-bit field at the start), and not on the
length fields of the individual vectors.

Reading specs is hard...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

