Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B28CD1292
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/i43E58+aCBA9LI9RN5Qdnl9rrLo4HjYFDmLIprYxs=; b=S+ItTSD7SRSVHsmczlWFygn3fr
	mKoEBqtBoy29UCdzqhp4qipOEZu0tXc/GiIlP+8VHhaAS///Gm+OznTQf9L3+l00DPUyAdUF6qRZ3
	EulM/aGd67wPS/9Qw7nMDQr0Hd8sE7BOyN65R8zLTfml2/ftrHXIzUjuuclzJ8Z+etkYa8EalV1cO
	3FnXiKs6b3IS8P7s5Ug36kd6cj67RglTxT7xiDXoXPz0lVR+AjPR5y5hAVQKYGQSHpPYOcylVFt8P
	OhOtg1pUClWh5ZRJAQeR8zcqp2EhTKC4woIHICSmGUnY5nbyeFvP5l8Ray0Ww/BOJ6Ja5stgk+SV+
	fYVWt5wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruobL-0000000AmCG-1w6A;
	Thu, 11 Apr 2024 07:12:03 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruobF-0000000Am8A-2bts
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 07:12:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3BA134DDD;
	Thu, 11 Apr 2024 07:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712819513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/i43E58+aCBA9LI9RN5Qdnl9rrLo4HjYFDmLIprYxs=;
	b=mAQvW3b6v6vNTlrLw9JlXN4fWVu6RwaGMR6FeMtgUx8RbgY4SRdJoj41RbSlOM4uyuOX8e
	VcMVMcFICMYHc8dn3gSYIkR8CKeTjsx+U0f3Y2z6FLVVXEui8HcaWupOLLPKJmXCDzrZqZ
	UjQKTH/rWBVv10h/AKIIPEIEIONoGGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712819513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/i43E58+aCBA9LI9RN5Qdnl9rrLo4HjYFDmLIprYxs=;
	b=V1YpjD1guo2TLyuusYsOGV+mDjkp94O7STnGHPg8/sl/5T2VWfp8kxSyJTtdGy8gi5crZY
	wikQwCk8jYAQlYAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TWcFk6W7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OAIDrv6v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712819512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/i43E58+aCBA9LI9RN5Qdnl9rrLo4HjYFDmLIprYxs=;
	b=TWcFk6W75ZdPxA38+GpYZ/FT2f10qs7QbAcR6w26jIKCLSwqojnUi1tPghthIgvH/lepAq
	8pcc93NXaNZqfPEE3WGysLCGAdAiYBMcFoDPblUazLNnk7/ttC4YLMcjrT/Z2F/x+IUG+W
	LwgDT1sP9DVRwX6KnUl6tMO3T5k2JvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712819512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/i43E58+aCBA9LI9RN5Qdnl9rrLo4HjYFDmLIprYxs=;
	b=OAIDrv6vvDVm0mQDuOVXvnr3wMxKsyihY0yb4rhPh4eK65CdPEKxuxTjxh1KpI+ScdbahZ
	pSbGJegjtHUX3hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 545EC13685;
	Thu, 11 Apr 2024 07:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jWtfEDiNF2bGLQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 11 Apr 2024 07:11:52 +0000
Message-ID: <88684d2f-8b36-40c4-99c8-ea07f42dd805@suse.de>
Date: Thu, 11 Apr 2024 09:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
 <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
 <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
 <959e5458-4c4d-4ab4-b9c2-8740156005cc@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <959e5458-4c4d-4ab4-b9c2-8740156005cc@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A3BA134DDD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_001157_921779_81A1F326 
X-CRM114-Status: GOOD (  27.03  )
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

On 4/10/24 15:50, Sagi Grimberg wrote:
> 
> 
> On 10/04/2024 15:05, Hannes Reinecke wrote:
>> On 4/10/24 12:21, Sagi Grimberg wrote:
>>>
>>>
>>> On 10/04/2024 9:52, Daniel Wagner wrote:
>>>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>>>
>>>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>>
>>>>>> Any authentication errors which are generated internally are always
>>>>>> non-retryable, so use negative error codes to ensure they are not
>>>>>> retried.
>>>>> The patch title says that any authentication error is not 
>>>>> retryable, and
>>>>> the patch body says "authentication errors which are generated locally
>>>>> are non-retryable" so which one is it?
>>>> Forgot to update the commit message. What about:
>>>>
>>>>    All authentication errors are non-retryable, so use negative error
>>>>    codes to ensure they are not retried.
>>>>
>>>> ?
>>>
>>> I have a question, what happens if nvmet updated its credentials (by 
>>> the admin) and in the period until the host got his credentials 
>>> updated, it
>>> happens to disconnect/reconnect. It will see an authentication
>>> error, so it will not retry and remove the controller altogether?
>>>
>>> Sounds like an issue to me.
>>
>> Usual thing: we cannot differentiate (on the host side) whether the
>> current PSK is _about_ to be replaced; how should the kernel
>> know that the admin will replace the PSK in the next minutes?
>>
>> But that really is an issue with the standard. Currently there is no
>> way how a target could inform the initiator that the credentials have
>> been updated.
> 
> I'd say that the sane thing for the host to do in this case is to reconnect
> until giving up with hope that it may work. This seems like a better 
> approach
> than to abruptly remove the controller no?
> 
>>
>> We would need to define a new status code for this.
>> In the meantime the safe operations model is to set a lifetime
>> for each PSK, and ensure that the PSK is updated on both sides
>> during the lifetime. With that there is a timeframe during which
>> both PSKs are available (on the target), and the older will expire
>> automatically once the lifetime limit is reached.
> 
> That is a good solution, and will also prevent a loss of service until
> the host credentials are updated as well.
> 
> But regardless I have a feeling that simply removing the controller upon
> an authentication error is not the right thing to do here.

Guess what; that's what I tried to do initially. But then Christoph 
objected that we shouldn't generate NVMe status codes internally.
But if we can't do that then we'll have to invent yet another way to 
return a retryable error, leading to even more band-aid.
So I am not quite sure how we could achieve that, short of making 
_every_ error retryable...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


