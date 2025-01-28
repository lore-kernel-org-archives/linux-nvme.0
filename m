Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB9BC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvyfARdj0oso47mZ2fRubQRMy0gNclUKtj6lrGxRZ88=; b=c9pYMQiAjjtn74bLJlmrMYEbw9
	vV+dFJFFQYDngkYadrswUnIoyBoCD3jV2oKd2iTvfCDnPZZleA7CQhso8EoELkGNUsTuzfFJT6Ggb
	i7ZiqAJhpp4HkQKrvP02JFNAsEgdjGB7i1N+LVuME02IZAzoA6OWLEeYRA1mp5fqDZKYGn8u0UU8U
	RRW73JuQoU94N5UYPj9eqCmxWIE1mJYuXUfbEuA93TYxGOvfwqxVUrqIqcVjhbZYFvGf3OwLBCIhJ
	ngHCseWuue794ISN4o7RSpCHRzkNIfaIIJDgJ+RuYLNEPrrZz9b28hf8NHxtU5WqWyQ5o4N7NjvnT
	yT+DK9Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnam-000000059bc-1Yco;
	Tue, 28 Jan 2025 15:33:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnak-000000059aV-0gQS
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 15:33:31 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B0E521102;
	Tue, 28 Jan 2025 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738078408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyfARdj0oso47mZ2fRubQRMy0gNclUKtj6lrGxRZ88=;
	b=coCuOxFtMRQvN0Yonmw4i1FYtVSOhUXOv294t6UdV0K2jB5tgfAK1+yxhDE2JsMX+lTF9M
	SxTcAKAX+5J8GYfgUJ5Xw53BCBLbrKa9sbdEYq7j3Q3tg37xV/Cf7dHHj7ghXKR0y79plq
	c1p6XpR8FkslGwpYfquf1aw/CnL+Pqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738078408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyfARdj0oso47mZ2fRubQRMy0gNclUKtj6lrGxRZ88=;
	b=7lEhdiIuPbw29BieRPDF1mdLyUXJ+jWQHLltHyAV4wFmyyBuZ3eKU8Zuzo1XfS5Ak8T7/I
	spm2g1aLXtLDmaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738078408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyfARdj0oso47mZ2fRubQRMy0gNclUKtj6lrGxRZ88=;
	b=coCuOxFtMRQvN0Yonmw4i1FYtVSOhUXOv294t6UdV0K2jB5tgfAK1+yxhDE2JsMX+lTF9M
	SxTcAKAX+5J8GYfgUJ5Xw53BCBLbrKa9sbdEYq7j3Q3tg37xV/Cf7dHHj7ghXKR0y79plq
	c1p6XpR8FkslGwpYfquf1aw/CnL+Pqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738078408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyfARdj0oso47mZ2fRubQRMy0gNclUKtj6lrGxRZ88=;
	b=7lEhdiIuPbw29BieRPDF1mdLyUXJ+jWQHLltHyAV4wFmyyBuZ3eKU8Zuzo1XfS5Ak8T7/I
	spm2g1aLXtLDmaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4703F13625;
	Tue, 28 Jan 2025 15:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ibyFDsj4mGdqZAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 28 Jan 2025 15:33:28 +0000
Message-ID: <889ea62d-1ec1-4de5-a250-954b41015c6f@suse.de>
Date: Tue, 28 Jan 2025 16:33:27 +0100
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
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_073330_353349_A944AC3C 
X-CRM114-Status: GOOD (  18.42  )
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
Okay, I'll add a spec reference and improve the description.
And NVME_KEYRING is selected due to a kbuild failure for
some odd combination of build-in vs modular in host and target.

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
Okay.

[ .. ]
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
Sure, I can split it into a separate patch.

And promise to fixup of formatting :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

