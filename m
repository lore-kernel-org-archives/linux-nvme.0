Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5031C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5KLPAXOU7O9Zmy/g/FuaV4GngJI7olAqvrZ4Kvt6hI=; b=RWGarUXtAVxrPG7EidjZo4qMiV
	ztXIFlM9HnvECG512UlYiJaGKeQsbCwpX57O3Cn33tUy/HncZvCKj6I7Dt4D2UGN2O9nj26k+UUFL
	5wJyiJuT3qScAcbGVhhN1g7uStvSQ+2wzBDH6YaadS+IOFRA7cdBDbCZS/LSmGPqN/2NPXeeGXlIq
	quUqVyOKDU/8tOjse6GKbARQyE805RjVNc8oMw4CV/+BaWFAMtfK3XI95OGNtAM7uDu2DMVKQaC8K
	HTiInR2N+X07uDJh0HYTj5yg6CxaUe1GJbhNair+Ie/nv/2gZgoqc+nuJ8LJ4m2NkxlK966A3AoKA
	YiEy4vaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE6qJ-0000000GhJJ-1vUp;
	Mon, 03 Jun 2024 12:31:15 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE6qD-0000000GhI4-1QIE
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 12:31:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C15D2003F;
	Mon,  3 Jun 2024 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717417866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5KLPAXOU7O9Zmy/g/FuaV4GngJI7olAqvrZ4Kvt6hI=;
	b=paHICZLCGp80ONqknHFalzAt1kkCRlR0Z9QSlZS4VszonEOlvJ3549kiqbSPbi/sSKXb4z
	cIvqTWDSWb2+YFpYGCicZX7c8WhDo+fYxDHtiofhOfjyxWj+kv/rj+7rJekm3sBbVedKQe
	GqKVeKKc4GyC6Ca/ZZrc7Lg+P01viXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717417866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5KLPAXOU7O9Zmy/g/FuaV4GngJI7olAqvrZ4Kvt6hI=;
	b=f3qWbxyI4YiJPerFsADqhlSLCuCoSY8XWlG2k6PmVp9TDTJfvqlv86qzZ+wwguEc0UK4CB
	87xNqQZoJmCVJODQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WHXig8Ks;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AcmevNMq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717417865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5KLPAXOU7O9Zmy/g/FuaV4GngJI7olAqvrZ4Kvt6hI=;
	b=WHXig8KsBN2t3SUFevfVGyCz0n3zjib6BofjLAXbEnk6I9rI6rY0tt89NkEzGzcndOh6nB
	UIvvKPubgrTlcdXvJ+wG4Za5mTVoOg3crxM+lrDIK1+QBFEsH97TaFYt1ffeBMABV7MQVC
	IndNek6ci1hwNLbIPlnx60PaK1ItRSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717417865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5KLPAXOU7O9Zmy/g/FuaV4GngJI7olAqvrZ4Kvt6hI=;
	b=AcmevNMqwwEvq6QfSVtCAq/epBZVDnBBs4orcsVinsWji4hpwhqC922nY+0+DXu+wAcwvZ
	4hSsbwob3Wki4FCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27F5313A93;
	Mon,  3 Jun 2024 12:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 28xHCYm3XWb7PAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 12:31:05 +0000
Message-ID: <ee20a47d-3131-41c2-a2fc-39017f535527@suse.de>
Date: Mon, 3 Jun 2024 14:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] block: Add core atomic write support
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
 ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com,
 willy@infradead.org, Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20240602140912.970947-1-john.g.garry@oracle.com>
 <20240602140912.970947-5-john.g.garry@oracle.com>
 <749f9615-2fd2-49a3-9c9e-c725cb027ad3@suse.de>
 <a84ad9de-a274-4bdf-837a-03c38a32288a@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a84ad9de-a274-4bdf-837a-03c38a32288a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6C15D2003F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mit.edu,google.com,linux.ibm.com,kvack.org,gmail.com,infradead.org,oracle.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RL7q43nzpr7is614unuocxbefr)];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_053109_558534_8FFFCEDD 
X-CRM114-Status: GOOD (  18.00  )
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

On 6/3/24 13:38, John Garry wrote:
> On 03/06/2024 10:26, Hannes Reinecke wrote:
>>>
>>> +static bool rq_straddles_atomic_write_boundary(struct request *rq,
>>> +                    unsigned int front_adjust,
>>> +                    unsigned int back_adjust)
>>> +{
>>> +    unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
>>> +    u64 mask, start_rq_pos, end_rq_pos;
>>> +
>>> +    if (!boundary)
>>> +        return false;
>>> +
>>> +    start_rq_pos = blk_rq_pos(rq) << SECTOR_SHIFT;
>>> +    end_rq_pos = start_rq_pos + blk_rq_bytes(rq) - 1;
>>> +
>>> +    start_rq_pos -= front_adjust;
>>> +    end_rq_pos += back_adjust;
>>> +
>>> +    mask = ~(boundary - 1);
>>> +
>>> +    /* Top bits are different, so crossed a boundary */
>>> +    if ((start_rq_pos & mask) != (end_rq_pos & mask))
>>> +        return true;
>>> +
>>> +    return false;
>>> +}
>>
>> But isn't that precisely what 'chunk_sectors' is doing?
>> IE ensuring that requests never cross that boundary?
>>
> 
>> Q1: Shouldn't we rather use/modify/adapt chunk_sectors for this thing?
> 
> So you are saying that we can re-use blk_chunk_sectors_left() to 
> determine whether merging a bio/req would cross the boundary, right?
> 
> It seems ok in principle - we would just need to ensure that it is 
> watertight.
> 

We currently use chunk_sectors for quite some different things, most 
notably zones boundaries, NIOIB, raid stripes etc.
So I don't have an issue adding another use-case for it.

>> Q2: If we don't, shouldn't we align the atomic write boundary to the 
>> chunk_sectors setting to ensure both match up?
> 
> Yeah, right. But we can only handle what HW tells.
> 
> The atomic write boundary is only relevant to NVMe. NVMe NOIOB - which 
> we use to set chunk_sectors - is an IO optimization hint, AFAIK. However 
> the atomic write boundary is a hard limit. So if NOIOB is not aligned 
> with the atomic write boundary - which seems unlikely - then the atomic 
> write boundary takes priority.
> 
Which is what I said; we need to check. And I would treat a NOIOB value 
not aligned to the atomic write boundary as an error.

But the real issue here is that the atomic write boundary only matters
for requests, and not for the entire queue.
So using chunk_sectors is out of question as this would affect all 
requests, and my comment was actually wrong.
I'll retract it.

Cheers,

Hannes


