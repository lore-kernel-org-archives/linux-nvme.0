Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C01AFD3760
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDGoRbFwi59wkjaTBq22SJrezhT/LmUgXlUFU/n+8Fo=; b=hXIofQh2t4LIHjZpBIPnLc5dOo
	HmdOQ449SwCxLOrRiHjMqe6SW6vbrLQxwsznMpKESdg93pxH8B7RKyK/j6NgIu8Wigi8zvI29uYDl
	FAoTTRAXvoS82jFrNinKwcGQB0HTFVxeutyTSePrS3nvrjjMeTdqXtE2MsC2CpI+bj2e3lAT7BPox
	KSZXPcuCXBinegrGnKNY5aqhK6zb1zt3akiLR91AsYD29s4Abpczh1l1caStupmkeq/y3QrrOcqh1
	BroSXVmhxmuaOQeHtNyC6eWvijKGtI2HDUonjSK/ebHjWmhptImrXlYfFV5kRRHOCnivJH3YA7W5S
	tdjtcoJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGPg-00000004F2q-2riR;
	Wed, 25 Feb 2026 15:02:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGPd-00000004F1f-3db7
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 15:02:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0CB54D3F6;
	Wed, 25 Feb 2026 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772031771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDGoRbFwi59wkjaTBq22SJrezhT/LmUgXlUFU/n+8Fo=;
	b=qq61S6weL00FHL+LNbGD88lh7RuFPCIHZ9Cf5zn4p2PkYnOR+MxL/snPrrVx028Y8gddEg
	1qv2b7xkmrjevwSxJ5DHxVJklIv+sKRoiCOG+3eqrYoReST4uQWFFxKTupN60EKqU3Wf/j
	IGuyF1Kx1fCv8LRDbAUx/0DeeDBmXuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772031771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDGoRbFwi59wkjaTBq22SJrezhT/LmUgXlUFU/n+8Fo=;
	b=tiLQfzq3T4jWo5RgZCFJ8V+7XrHDUWSbvMearxtwOirWI5nIjK48HTTZ7H/cv+aTGD9r9q
	Ikq42ITnyyE1w8AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772031770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDGoRbFwi59wkjaTBq22SJrezhT/LmUgXlUFU/n+8Fo=;
	b=e/OEumQy8i6F0fRvJvrVxkPwL3JH8YE/+47QCJ2G9dAWHsHZZjZ2xi3/J+5IhNMMTrGA8Z
	feGP3Wt3cPndUo0s1vK/4JGS+KW7XepTxt9hUaAartwi+AZwRliW1i2JDfmZLQB8FH8vZZ
	vdG5veAnMHvhlpbgrfc0GB+u3PRjL7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772031770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDGoRbFwi59wkjaTBq22SJrezhT/LmUgXlUFU/n+8Fo=;
	b=8v4twwLyzx42zZSEc9ceu+Gtv+A8a/Xwi6qiPRdldI1cSLagko/uUG+aXXE2MMdb+/GEw8
	plFY7S+fBLTlFeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6984B3EA65;
	Wed, 25 Feb 2026 15:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H0U1GBoPn2m3fAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Feb 2026 15:02:50 +0000
Message-ID: <d21a9ad8-24d6-4210-8779-0cc91175f57c@suse.de>
Date: Wed, 25 Feb 2026 16:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
To: Alistair Francis <Alistair.Francis@wdc.com>, hch <hch@lst.de>,
 "hare@kernel.org" <hare@kernel.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250912115829.58669-1-hare@kernel.org>
 <99c9b1f7d8bbeca3681bb2f8502fe6af1374df8d.camel@wdc.com>
 <b778bc2f-5911-431c-9b65-1fbaea68fd4d@suse.de>
 <8c3fd4f7f9c0074ec35fb15d1573ad2e3155cbe1.camel@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8c3fd4f7f9c0074ec35fb15d1573ad2e3155cbe1.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_070254_060445_8CB8CE43 
X-CRM114-Status: GOOD (  27.67  )
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

On 2/25/26 14:15, Alistair Francis wrote:
> On Wed, 2026-02-25 at 12:41 +0100, Hannes Reinecke wrote:
>> On 2/25/26 11:56, Alistair Francis wrote:
[ .. ]
>>>
>>> This doesn't work unfortunately.
>>>
>>> The problem is what happens if queue->data_remaining is smaller
>>> then iov_iter_count(&req->iter)?
>>>
>>> queue->data_remaining is set by the data length in the c2h, while
>>> the length of the request iov_iter_count(&req->iter) is set when the
>>> request is submitted.
>>>
>>> If queue->data_remaining ends up being smaller then
>>> iov_iter_count(&req->iter) then we need to read less data then the
>>> actual count of req->iter.
>>>
>>> So we need a iov_iter_truncate(), but then we end up overwriting
>>> the data on the next iteration as we have no way to keep...
>>>
>> Question is, though: what _is_ in the remaining iov?
> 
> Which remaining iov?
> 

Well, if queue->
>> The most reasonable explanation would be that it's the start of the
>> next PDU (which we haven't accounted for, and hence haven't set
>> up pointers correctly).
> 
> The next PDU seems fine, it's just the next data that goes on the
> current (and correct) IOV, just overwriting the previous data as there
> is no offset.
> 

The offset is in the iov (ie you advance the iov iter to capture the offset)

>> I can see this happening for TLS when the sender doesn't space
>> the records correctly (ie if the PDU end is not falling on a
>> TLS record boundary).
>>
>> But yeah, I can see the issue. While we can (and do)
>> advance the iterator to complete the request, we still
>> have the remaining data in the iterator.
> 
>> What we can do, though, is to copy the remaining data over
>> to 'queue->pdu' (as we assume it's the start of the next PDU),
>> set up pointers, and let it rip.
> 
> Ah, I think that's the other way around of what I'm talking about. That
> sounds more like you overflow the current iterator. I'm talking about
> an underflow, where we don't transfer enough data to complete a
> request. So when we continue the transfer we overwrite the previous
> data.
> 
To my understanding queue->remaining is the number of bytes left
for _this_ PDU (actually, for the PDU data; digests are counted
separately).
And the iterator points to the iovec storing the eventual data.
So in your case iov_len() is _larger_ than queue->remaining.
How so? iov_len() is calculated from the request, and that
should have the correct length set.
So the only way I see how we could arrive in the situation
where iov_len() is larger thatn queue->remaining is when
we have a short read.
But really, both values are setup right at the start
before we even start receiving data.
Shouldn't we catch this issue there?

I guess I'm still confused how you could end up in a situation
where queue->remaining is smaller that the iovec length...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

