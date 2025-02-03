Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98543C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Z2VvOaQLZH/GfVj6oa0kY6R9Si36r1fT/PUdv2issg=; b=Y1qLgFYLoutpWmUI0RE+/VY3Gd
	f+rx1xGvbP9dleUNIS5S4EhFbNWzW3R2sL/TL8iyUeEI/PDTqCYg4RPjTfF9wNCbgzteAA1YC4TVj
	EvSbOh9DSLXdrtB/BeakHMPMYUHny2rqdyRiOQ6Vw/2Jx5i8UoZHrh/MZxdxcWNtVxgtmMknjWZF4
	Er1fjqBKSy1QLHe1Q4Kd4GRCsukdngjCGyjR2P6kdfU7kN6Ck4DEnfkBs24nKqmOCfycgB0oA4phY
	ti/4Fe/nABuHtmNXpx/VwaiqcCi3cYprs914CGGhLUT/FPzL3JeH4s67BidMqgboloA8HD4QgAhTV
	Fe2gia/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tex6U-0000000FcIs-1QCg;
	Mon, 03 Feb 2025 14:07:10 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tex6R-0000000FcIE-2xYS
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 14:07:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF99F1F391;
	Mon,  3 Feb 2025 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738591622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z2VvOaQLZH/GfVj6oa0kY6R9Si36r1fT/PUdv2issg=;
	b=2FBKbXLlt2jMzz7Xb8afYrnVpcBevl0pQG0IofDyxp4WzhHyu45Ld0yior5GpxuwNRNURY
	fw5cZLwx119UxGY88Ok6gM/ON6Ax/xcnlnGYRvx6/KE5nMQfmaAIZT3WcjRd741HzyHmzQ
	lFc7yjYNFEQy3VWeO6RDa5tiHCTW7KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738591622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z2VvOaQLZH/GfVj6oa0kY6R9Si36r1fT/PUdv2issg=;
	b=aHWQEWxASe0Pfcz1t/9Lm3lpHPbbMjXlylRAKatUOtx7zu8cgpVlEs4zx68upI7qCybe0W
	0UyYzHZNvwxSWMAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738591617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z2VvOaQLZH/GfVj6oa0kY6R9Si36r1fT/PUdv2issg=;
	b=IMWa8JNMa97YeZlfwMLTdQAVYXvoeDy0IAOgx60yj34/zSuBYT7pRSYgEfLK6EfyHF4ROO
	5oaIa38MT083pBUZXAhBv3sa+9qgtgenPJWbHSQc2fqpsKynGUj/MXfO0kaSFGXDOHxw6e
	/8TA5PBuavBA7Vgmag77AKTx1qAcLVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738591617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z2VvOaQLZH/GfVj6oa0kY6R9Si36r1fT/PUdv2issg=;
	b=VSKMxI1cysaIEl9E/muwb4QC/JisVAriq31JsSTwABpNjnWS6txKy+RRPSSLvY4O5G6m8g
	f0I5FY77KGRIdFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B446013795;
	Mon,  3 Feb 2025 14:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jBlTK4HNoGc4PQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Feb 2025 14:06:57 +0000
Message-ID: <e435a745-0c47-460b-9930-7a43b76c4ac6@suse.de>
Date: Mon, 3 Feb 2025 15:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] nvme-tcp: request secure channel concatenation
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
 <20250122165829.11603-8-hare@kernel.org> <20250128091131.GF25760@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128091131.GF25760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_060707_887730_106EC033 
X-CRM114-Status: GOOD (  29.12  )
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

On 1/28/25 10:11, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 05:58:26PM +0100, Hannes Reinecke wrote:
>> Add a fabrics option 'concat' to request secure channel concatenation.
>> When secure channel concatenation is enabled a 'generated PSK' is inserted
>> into the keyring such that it's available after reset.
> 
> That's a very sparse commit message.  What is the point of doing this?
> What is the spec reference for the implementation?  What is the user
> interface?  Why does this now always select NVME_KEYRING?
> 
>> +	if (!ctrl->opts->concat || chap->qid != 0)
>> +		data->sc_c = NVME_AUTH_SECP_NOSC;
>> +	else if (ctrl->opts->tls_key)
>> +		data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
>> +	else
>> +		data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
> 
> Took me a while to unwind this.  Why not make this a little easier as:
> 
> 	if (ctrl->opts->concat && chap->qid == 0) {
> 		if (ctrl->opts->tls_key)
> 			data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
> 		else
> 			data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
> 	} else {
> 		data->sc_c = NVME_AUTH_SECP_NOSC;
> 	}
> 
> ?
> 

Ok.

>> +	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest, &tls_psk);
> 
> Overly long line.
> 
>> +	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl->opts->host->nqn,
> 
> Same.  Not going to mention more of that, but please fix it up.
> 
Will do.

>> +		if (ctrl->opts->concat &&
>> +		    (ret = nvme_auth_secure_concat(ctrl, chap))) {
> 
> 		if (ctrl->opts->concat) {
> 			ret = nvme_auth_secure_concat(ctrl, chap);
> 			if (ret) {
> 				...
> 
>> +	/*
>> +	 * Only run authentication on the admin queue for
>> 	 * secure concatenation
>> +	 */
> 
> The two lines of comment can be folded in one, and it's missing a period
> at the end of the sentence.
> 

Will be fixing it up.

>> +			/*
>> +			 * The generated PSK is stored in the
>> +			 * fabric options
>> +			 */
> 
> Missing period and not using up the line as well.
> 

Ditto.

>> +/*
>> + * The TLS key is set by secure concatenation after negotiation
>> + * has been completed on the admin queue. We need to revoke the
>> + * key when:
>> + * - concatenation is enabled
>> + *   (otherwise it's a static key set by the user)
>> + * and
>> + * - the generated key is present in ctrl->tls_key
>> + *   (otherwise there's nothing to revoke)
>> + * and
>> + * - a valid PSK key ID has been set in ctrl->tls_pskid
>> + *   (otherwise TLS negotiation has not run).
>> + *
>> + * We cannot always revoke the key, as we're calling
>> + * nvme_tcp_alloc_admin_queue() twice during secure
>> + * concatenation, once on a 'normal' connection to run
>> + * the DH-HMAC-CHAP negotiation (which generates the key,
>> + * so it _must not_ be set), and once after the negotiation
>> + * (which uses the key, so it _must_ be set).
>> + */
> 
> Another overly dense fomatting.  Are you trying to make up the
> extra width used in the first patches? :)
> 
Possibly. Will be fixing it up.

>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -1746,6 +1746,13 @@ enum {
>>   	NVME_AUTH_DHGROUP_INVALID	= 0xff,
>>   };
>>   
>> +enum {
>> +	NVME_AUTH_SECP_NOSC		= 0x00,
>> +	NVME_AUTH_SECP_SC		= 0x01,
>> +	NVME_AUTH_SECP_NEWTLSPSK	= 0x02,
>> +	NVME_AUTH_SECP_REPLACETLSPSK	= 0x03,
>> +};
> 
> Comments please to explain what fields this applies to.  Also we
> usuall try to split protocol definition additions into separate
> patches.
> 
> 
Ok.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

