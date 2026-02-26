Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26036FC5910
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vuhhCHkrM5MNOyV5ne8rC1h5pJTNjvnIs9RSLKiaXR4=; b=LjgckW+JjylbGZQajavJybXquW
	NjoAhuqycwPyGIIdAbjfhCSoMowwNthGauZ/41hk6ao8k1e4f3Urg8ybmCU1wKmOHS0e/tFz9egPx
	DEe6H9gI7kitbQLt7Kwj7nfQ0XwHfM5D4yYOUtljHo8qXPtMyvaKqNs6D2iMd/aYJk6XCfBrumtEc
	YhwIoQvQlT/gDMQRpCXYU/gB4sspNXwJhmHLKH6IVbcnYd2Ns2yeP/Viwpx/OmbDzuudR1zCL72Z7
	l/ZE3LLsBzmpYldZac6zFIetFUbiaC7xtRgTpgZ4ThA2IAY70eppuOdIXDJFo8wXAHMO0zc7UnKXB
	RPQUWysQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvWv2-00000005fWj-48qM;
	Thu, 26 Feb 2026 08:40:24 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvWuz-00000005fVr-39Jd
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 08:40:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8C325D692;
	Thu, 26 Feb 2026 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772095217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuhhCHkrM5MNOyV5ne8rC1h5pJTNjvnIs9RSLKiaXR4=;
	b=GZjScamC3o5vPVcFGJ9lcrWusiuCSC8kxY1q3dn5MfdyUsvZr97QSUXPRpnhXcGcLonROI
	so1cTPVaunFmI9p3R8hGUIaKhV6DV3wu9DI/E/oGEvIzTG8Fg8g9QoQQ0XZTQFsXMn2fPz
	lvYPqqlpcKX4xFQMU2Y1sCSmEWubX1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772095217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuhhCHkrM5MNOyV5ne8rC1h5pJTNjvnIs9RSLKiaXR4=;
	b=JqltRf73o28P+TauhIWCpg1COf28EEkzzKn7ddvEWfBvlXDXJSyssz/N1HV2N+eN62GmQf
	y8/fHnuOjFgGRgCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Za8ctweV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ew9SiHuQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772095216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuhhCHkrM5MNOyV5ne8rC1h5pJTNjvnIs9RSLKiaXR4=;
	b=Za8ctweVmyo3mgoLtkuNtGMUlAPqg4m6cXE5x7G+fKjAHIM05vD2QGmFg8zGyJ0YcZHE6N
	HmJroI3OrZJJ+ahnmvQIvQIxdDsznvHpeJhLJJ3EzBdZRZWByPHoMmxyWRPWZWP0YgaMl2
	t0C8kaZoLTL57sQAiFtDZDYXS86ttFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772095216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuhhCHkrM5MNOyV5ne8rC1h5pJTNjvnIs9RSLKiaXR4=;
	b=Ew9SiHuQcrER6QPt00p26dxHwlguABzQ+UsK1LAa5tdS3FOIaUUsC7kak1rSJ4gmuR4Ysy
	CBO8Asuw+lmrb6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B41C53EA62;
	Thu, 26 Feb 2026 08:40:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DBXGKvAGoGktIgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 26 Feb 2026 08:40:16 +0000
Message-ID: <141f8748-9f31-4bb1-93f4-7709f68c3eea@suse.de>
Date: Thu, 26 Feb 2026 09:40:16 +0100
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
 <d21a9ad8-24d6-4210-8779-0cc91175f57c@suse.de>
 <3739383d428d75ca1eda44ae61716057e20488d0.camel@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3739383d428d75ca1eda44ae61716057e20488d0.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: E8C325D692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_004021_944363_79A875EF 
X-CRM114-Status: GOOD (  28.16  )
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

On 2/26/26 00:37, Alistair Francis wrote:
> On Wed, 2026-02-25 at 16:02 +0100, Hannes Reinecke wrote:
>> On 2/25/26 14:15, Alistair Francis wrote:
>>> On Wed, 2026-02-25 at 12:41 +0100, Hannes Reinecke wrote:
>>>> On 2/25/26 11:56, Alistair Francis wrote:
>> [ .. ]
>>>>>
>>>>> This doesn't work unfortunately.
>>>>>
>>>>> The problem is what happens if queue->data_remaining is smaller
>>>>> then iov_iter_count(&req->iter)?
>>>>>
>>>>> queue->data_remaining is set by the data length in the c2h,
>>>>> while
>>>>> the length of the request iov_iter_count(&req->iter) is set
>>>>> when the
>>>>> request is submitted.
>>>>>
>>>>> If queue->data_remaining ends up being smaller then
>>>>> iov_iter_count(&req->iter) then we need to read less data then
>>>>> the
>>>>> actual count of req->iter.
>>>>>
>>>>> So we need a iov_iter_truncate(), but then we end up
>>>>> overwriting
>>>>> the data on the next iteration as we have no way to keep...
>>>>>
>>>> Question is, though: what _is_ in the remaining iov?
>>>
>>> Which remaining iov?
>>>
>>
>> Well, if queue->
>>>> The most reasonable explanation would be that it's the start of
>>>> the
>>>> next PDU (which we haven't accounted for, and hence haven't set
>>>> up pointers correctly).
>>>
>>> The next PDU seems fine, it's just the next data that goes on the
>>> current (and correct) IOV, just overwriting the previous data as
>>> there
>>> is no offset.
>>>
>>
>> The offset is in the iov (ie you advance the iov iter to capture the
>> offset)
>>
>>>> I can see this happening for TLS when the sender doesn't space
>>>> the records correctly (ie if the PDU end is not falling on a
>>>> TLS record boundary).
>>>>
>>>> But yeah, I can see the issue. While we can (and do)
>>>> advance the iterator to complete the request, we still
>>>> have the remaining data in the iterator.
>>>
>>>> What we can do, though, is to copy the remaining data over
>>>> to 'queue->pdu' (as we assume it's the start of the next PDU),
>>>> set up pointers, and let it rip.
> 
> I think I understand this part a bit more now. I'm currently using
> iov_iter_truncate() to reduce the count of req->iter to match queue-
>> data_remaining, so I don't see this.
> 
> If there was no truncation then the req->iter would fill up with the
> current data and the next PDU. This is where we could copy that data
> over and let it rip.
> 
> But it still has the same issue in that we can't add future data to an
> offset in the req->iter. At least not that I can figure out.
> 

Ah, I think I see it now.
The iovec might indeed be larger than queue->remaining
(data underflows are not that uncommon), and then recvmsg
might indeed fill the iovec with more data than the PDU
requires.

The old code had that bit:
  		/* we can read only from what is left in this bio */
		recv_len = min_t(size_t, recv_len,
				iov_iter_count(&req->iter));
(with recv_len being set to queue->data_remaining) to prevent that
from happening.
So we should do a

if (iov_iter_count(&req->iter) > queue->remaining)
    iov_iter_truncate(&req->iter, queue->remaining)

before issuing recvmsg. That should take care of things.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

