Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F2BC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYIRtiP+dfAUVHiEJIUF4wbXezTQfD1n5dWDaujBDOg=; b=XoQBcbRnMkBD8DPOex56gAN4rv
	Hxy8RlnNwq3DJXTtkckyefRgRCE1+Rv4LClFMehIJUKgzDcaNWXpP71Vcv8k45j3W4kp1AqEa5Eb9
	76PGvNLWnjZG4Ll4anaV3Qp1Epv3Fn4ofPh6mmM/Su7n8j46EbIYNAx4fXXvO09AreUJXDOPwHs51
	oPCt7y8PKHUFW1AO6T9bMxZzsfJc2F+YBUM7YBn5ifkNy+T0aMk4uSmx1hZS2p6G+H/3IxlgNvXvs
	cpm0iHPo9AKlJ9wwDD8ShFaXOL0d+8PqkiH72rfYDho8ksMdAyJIeuh9OOkXVoVpQRTCin9e+loEh
	bMjktVeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg4mh-00000000sxl-0Ksr;
	Fri, 01 Mar 2024 15:26:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg4mZ-00000000ssX-3qnb
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 15:26:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65E4233BD8;
	Fri,  1 Mar 2024 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709306800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYIRtiP+dfAUVHiEJIUF4wbXezTQfD1n5dWDaujBDOg=;
	b=o5i2ItEqK217Gcu+3tw2/cCbgbDveUZ5XA2qw6YqBTqUuaGhkhJlK2Kc5afGZA/ZvlUVf/
	q2JrTLuI7Nxr52gCJlTo0dRCMxaW8io0MQuiSYaF2Z1wwp/3oOOr4W9g0AC0zXRhWOhgQV
	U9au9ekbtZh31Uv4OIMFkijMywskdHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709306800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYIRtiP+dfAUVHiEJIUF4wbXezTQfD1n5dWDaujBDOg=;
	b=rydsH37iULMIpmPcg/Ww5uEl3u/ZTxewbZIVOFy72gOKkEYoldpqalnpp+rVpVi5xMIhI8
	lmOWEzyA4tDzQQBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709306800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYIRtiP+dfAUVHiEJIUF4wbXezTQfD1n5dWDaujBDOg=;
	b=o5i2ItEqK217Gcu+3tw2/cCbgbDveUZ5XA2qw6YqBTqUuaGhkhJlK2Kc5afGZA/ZvlUVf/
	q2JrTLuI7Nxr52gCJlTo0dRCMxaW8io0MQuiSYaF2Z1wwp/3oOOr4W9g0AC0zXRhWOhgQV
	U9au9ekbtZh31Uv4OIMFkijMywskdHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709306800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYIRtiP+dfAUVHiEJIUF4wbXezTQfD1n5dWDaujBDOg=;
	b=rydsH37iULMIpmPcg/Ww5uEl3u/ZTxewbZIVOFy72gOKkEYoldpqalnpp+rVpVi5xMIhI8
	lmOWEzyA4tDzQQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9A8713A80;
	Fri,  1 Mar 2024 15:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tVOPMa/z4WVEfQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 01 Mar 2024 15:26:39 +0000
Message-ID: <f511975a-822e-470a-a3a2-d7ed652e3cfc@suse.de>
Date: Fri, 1 Mar 2024 16:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-2-hare@kernel.org> <20240301131208.GA3586@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240301131208.GA3586@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o5i2ItEq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rydsH37i
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.19)[70.69%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 65E4233BD8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_072644_138486_15BE369D 
X-CRM114-Status: GOOD (  13.10  )
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

On 3/1/24 14:12, Christoph Hellwig wrote:
>> -	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>> -		return AUTHENTICATE;
>> -
>>   	if (blk_noretry_request(req) ||
>>   	    (nvme_req(req)->status & NVME_SC_DNR) ||
>>   	    nvme_req(req)->retries >= nvme_max_retries)
>>   		return COMPLETE;
>>   
>> +	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>> +		return AUTHENTICATE;
> 
> This part looks fine (although I'd word the commit message
> differently for it).
> 
>> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>   		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>   			dev_warn(ctrl->device,
>>   				 "qid 0: secure concatenation is not supported\n");
>> -			ret = NVME_SC_AUTH_REQUIRED;
>> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>   			goto out_free_data;
>>   		}
>>   		/* Authentication required */
>> @@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>   		if (ret) {
>>   			dev_warn(ctrl->device,
>>   				 "qid 0: authentication setup failed\n");
>> -			ret = NVME_SC_AUTH_REQUIRED;
>> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
> 
> 
> .. but the others should never use nvme status codes as they never
> go out onto the wire.
> 
Would love to, but to my knowledge we have the convention that NVMe 
status codes less than 0 should _not_ be retried. NVMe transport errors,
OTOH, _should_ be retried. 'connect_admin_queue' and 'connect_io_queue' 
now straddles the boundary: technically it's an NVMe command, but in
practice it's a transport command as there are quite a lot of steps
before we even can send the 'connect' command.

So, how do we handle the return codes from 'connect_admin_queue' ?
The NVMe core style (with not retrying negative errors) or the NVMe
transport style (with always retrying until we run out of retries)?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


