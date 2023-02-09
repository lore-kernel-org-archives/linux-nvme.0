Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E9C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 07:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JfG7Fq7QTrqm+Bhx3obY+oKw1b+mHM81yDdTUS7G6j8=; b=P8Z+N42uwu8lfELWn6OS+gM4YT
	k0XZMLdeYLiz/DTlF2PoIOZN5gGBMSs55m946HBHOgG26zxeXBQzqpcfiBuql78EolqWaMM5msPma
	wne/k9aqCRargd+JbNTFrQTWpLnM7Rm5uvKcHZQiX7qr5XB3s4GbRlwLYQRUKyL1gE9h4SMMDc1Cz
	piQlqL/5wHblyEzg4FwdoGP6oknd+ecqMhSqeU8Wo+VwfNGKnE68bNLFpOaUKTCfYZsEFOxQPwQAd
	3gXsIHK4g6DLwzjWqLn6Vtfyj8bDpqBycD/JG/TAWSqz9pg6SPuG9lmWv8t4Yd5t2pkGpuyKJdGmQ
	jihqaPcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ1pM-000UYp-Lb; Thu, 09 Feb 2023 07:58:44 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ1pJ-000UXX-2d
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 07:58:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 796B534E8A;
	Thu,  9 Feb 2023 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675929519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfG7Fq7QTrqm+Bhx3obY+oKw1b+mHM81yDdTUS7G6j8=;
	b=0+YXZ9Q4AHal8ddCtpMVJPv1gTz1hLEWQyvD639T8dNs3ENc76OV/2bTE2IcgTT1S+d1iF
	uXlvoH9JNU2zL/NPzJ6xWJ3g27+nkoHam5cqFl/5rv8g0CxGgqXsvaC7xfA6fglr2up+70
	23fjd739UkR5d/ywwP0wEPs4q+0C9Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675929519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfG7Fq7QTrqm+Bhx3obY+oKw1b+mHM81yDdTUS7G6j8=;
	b=Sfi24W/qVwaeznOo4Cu2MjjZhGV5t8Uqirldh73hRng65F/dChC/+byhB4d7xbwqxIdcC8
	wPERycfGk1DSCbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5348C13A1F;
	Thu,  9 Feb 2023 07:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AIuLE6+n5GPTBgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 09 Feb 2023 07:58:39 +0000
Message-ID: <2ecd52b7-3ea1-0fee-524b-1bf6e6a62097@suse.de>
Date: Thu, 9 Feb 2023 08:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] nvme: split __nvme_submit_sync_cmd()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20230208151720.109130-1-hare@suse.de>
 <20230208151720.109130-2-hare@suse.de> <20230209053330.GA8536@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230209053330.GA8536@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_235841_280039_E792755C 
X-CRM114-Status: GOOD (  26.71  )
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

On 2/9/23 06:33, Christoph Hellwig wrote:
> On Wed, Feb 08, 2023 at 04:17:18PM +0100, Hannes Reinecke wrote:
>> Split a __nvme_alloc_rq() function from __nvme_submit_sync_cmd()
>> to reduce the number of arguments.
> 
> But now everyone has to call both?
> 
Yes, that's the downside of it.

>>   6 files changed, 83 insertions(+), 45 deletions(-)
> 
> .. and the code is a lot longer.  So this doesn't really seem like
> much of a win?
>> +struct request *__nvme_alloc_rq(struct request_queue *q,
>> +				struct nvme_command *cmd, int qid,
>> +				blk_mq_req_flags_t flags)
> 
> Why the double underscore profix?  Why _rq instead of _request
> like blk_mq_alloc_request and nvme_init_request?
> 
Ok, will be renaming to nvme_alloc_request().

>>   {
>>   	struct request *req;
>>   
>>   	if (qid == NVME_QID_ANY)
>>   		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
>>   	else
>>   		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
>>   						qid - 1);
>> +	if (!IS_ERR(req))
>> +		nvme_init_request(req, cmd);
>>   
>> +	return req;
> 
> And I'd at very least split out the qid case as that is substantially
> different and only used in very specific places.
> 
>> + */
>> +int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
>> +			   void *buffer, unsigned bufflen, int at_head)
>> +{
>> +	int ret;
>>   
>>   	if (buffer && bufflen) {
>> -		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
>> +		ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
>>   		if (ret)
>>   			goto out;
> 
> This new __nvme_submit_sync_cmd now consumes the request, which
> is an odd calling conventions.
> 
> What do you think about:
> 
>   - passing the "union nvme_result *result" to nvme_execute_rq, and do the
>     conditional assignment to it there, where it fits along with all the
>     status management
>   - make blk_rq_map_kern handle a NULL kbuf gracefully instead of doing
>     that in a lot of the callers
>   - just open code __nvme_submit_sync_cmd using these building blocks.

Hmm. Let me see how this pans out.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


