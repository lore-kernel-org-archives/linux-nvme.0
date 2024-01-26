Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E4FC47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fs/S1JT+nGbK5utVGseSOG49kNzybl7iuUC+qp6NvH8=; b=crlO07/+dVIvD6DJ+yqOIcpuoD
	4mq+nBr4svrft91xlPwBUoVdAW+cMD5p8ZhqY9+M9kupWHGNKifIhH1OszzMegEq3myZ9QAh7VKwo
	yaL+Lr1YT0DBfjU7h9C7edq+SVSt5V91b560J3jVoMVRKFD1V9etTSOqpvbUh3fMcZxDcYsNoC7Dt
	PePpNHM+4e2IyHa1e4TKHTuJRai1mr9onydU5EpVT20qr+6V7KfIoX4rHdCpYz9Pi7VcEduA6IpEs
	rDwAfNDBFquRdHvTalcwUZzUMvyTQxNoSBUIm43VWlRUZaVHWgDCeE/HuTcGXTGI5R3rEqLKFRFiL
	I7kiSAxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOmR-00000004crK-2mzp;
	Fri, 26 Jan 2024 16:10:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOmM-00000004cqJ-2ZHp
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 16:10:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E89A71F749;
	Fri, 26 Jan 2024 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706285404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs/S1JT+nGbK5utVGseSOG49kNzybl7iuUC+qp6NvH8=;
	b=Sx6G0mg8eMqfg/itYg2mxpG4XOH74tFXADQMrpd3vWW9cQl+rQhWnOd67sQ1Aq62LzHj8R
	X+/qJAkWambNwUc4Zxyq4HSS/UQGnCN2Yo1JxZDXUox9UTKYCOBvYQ5A2psGSyyvw/6KSw
	CYqGagbyrhS4AGniBWuhzjSxYDWR7Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706285404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs/S1JT+nGbK5utVGseSOG49kNzybl7iuUC+qp6NvH8=;
	b=5viXJ49tJb/OSB6onYCf0SOtyR6V9298/fQzhgejGk0y1y+O3UDEZaV+oiwmBTNEpkAVH+
	CWw7EiETMPRY8KBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706285403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs/S1JT+nGbK5utVGseSOG49kNzybl7iuUC+qp6NvH8=;
	b=mHytsqOKVv88OE2jHL20fbE2Rdrfzph7lnPeI5T0rDez9VKQixq53T4oZgc1jM1qmXEpuB
	kbUTO+xzcRIxrh/5emHmIUoAmmSYDJ07a7uoTn3xmMkV9QL5F4ofCjdtECkcZnGIfXfFbr
	cFca0wTXB+B9ZbXmCAZdaMQaS4XnXmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706285403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs/S1JT+nGbK5utVGseSOG49kNzybl7iuUC+qp6NvH8=;
	b=hHxK0GDSfc5Jgclr61IUuyGQzYqEa3KDpRXfYWU6ej9wUb7+b5RmVZezWzuuTN4ZBenRS/
	e3K1lR2UFtmesQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6E1B13A22;
	Fri, 26 Jan 2024 16:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EjJIJ1vZs2VWEgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 26 Jan 2024 16:10:03 +0000
Message-ID: <81eab1cc-cac9-4f0b-966c-aa360ef916aa@suse.de>
Date: Fri, 26 Jan 2024 17:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: enable retries for authentication commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Martin George <marting@netapp.com>
References: <20240126063709.123814-1-hare@kernel.org>
 <20240126134937.GA3016@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240126134937.GA3016@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.98%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_081006_824333_F5086C92 
X-CRM114-Status: GOOD (  12.87  )
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

On 1/26/24 14:49, Christoph Hellwig wrote:
> On Fri, Jan 26, 2024 at 07:37:09AM +0100, hare@kernel.org wrote:
>>   #define nvme_auth_flags_from_qid(qid) \
>> -	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
>> +	(qid == 0) ? NVME_SUBMIT_RETRY : \
>> +	NVME_SUBMIT_RETRY | NVME_SUBMIT_NOWAIT | NVME_SUBMIT_RESERVED
>>   #define nvme_auth_queue_from_qid(ctrl, qid) \
>>   	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
> 
> Please just open code these two obfuscating macros with a single user
> each to make the change easily reviewable.  That also means after that
> you only nee to assign NVME_SUBMIT_RETRY once and not in both side of
> a ternary operator.
> 
Ok.

>>   	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>> -				     qid == 0 ? NVME_QID_ANY : qid,
>> -				     0, flags);
>> +				     qid == 0 ? NVME_QID_ANY : qid, flags);
> 
> And then split addition the calling convention change for the request
> submission helpers from the actual behavior change into a well documented
> prep patch as well.
> 
Let's see about the 'well-documented', but I'll try.
Ok.

>> +enum {
>> +	NVME_SUBMIT_AT_HEAD  = (__force nvme_submit_flags_t)(1 << 0),
>> +	NVME_SUBMIT_NOWAIT = (__force nvme_submit_flags_t)(1 << 1),
>> +	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
>> +	NVME_SUBMIT_RETRY = (__force nvme_submit_flags_t)(1 << 3),
> 
> Maybe write some comments explaining the semantics while you're at it?
> 
Maybe.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


