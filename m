Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B3CD1292
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 03:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJIujaH3RXIktcRv88URJI4c3MW1XPtMbHZWqI5VmXc=; b=KeseeDw0f5/hh0qxMrku5RE6/q
	Z3PvbrVbmgpjYXs+W1GoTpia6SIjb1Yk3XLBrlnM1xP4yKOYC31XxRuDEPpbZkl37JtejSHzK6WVT
	OllzZGu+EHEiw3ljmZUgxQGYFCRiCzDUq/qY8lEIG2O3Wir8b5xenzcd5LtSD61Nv+iBo/h2j7du3
	4YC51ATut+MfOF2M53CsmrxwCzTh9P+T5L3NtHvlZTZA0JxXdOuO0IzBZW/ObPV9vyVfST+jaFom7
	8bhRJPF46pGZcBnmI6O4qIc2CHzhbJhePSeIb/Gj9s2CZjRAUnu504x+2tB7E6qudkeyCvrsNcc/0
	/7YOO2Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rukx9-0000000A7Yh-3nJh;
	Thu, 11 Apr 2024 03:18:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRK7-00000005MBg-1Un9
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 06:20:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A4D3349E5;
	Wed, 10 Apr 2024 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712730040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJIujaH3RXIktcRv88URJI4c3MW1XPtMbHZWqI5VmXc=;
	b=DRH5op6+qgu/ZbeaZUaYpnIYWqjeWpHK8OW0+kwvqDCMEwaguq5aqaXafgAjwJ6zywhusF
	tsgFsWgaCMMY4NaTEaGk3lDtHCR73mjQ4SRA1LnqLj9EF0l+PnSJ2BlijBLHcS98VKUP8t
	Vf4bNVGD5TMPNXoHOH52Hod45ruzXX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712730040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJIujaH3RXIktcRv88URJI4c3MW1XPtMbHZWqI5VmXc=;
	b=0jV/eoo4drBjtHKjxE/GtnE1W1+NVg3WllILQl+VLv9gNYfTXrOGjwpUFYpLOwg0GRsGjF
	4Wxv4HCZCDpVodDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712730040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJIujaH3RXIktcRv88URJI4c3MW1XPtMbHZWqI5VmXc=;
	b=DRH5op6+qgu/ZbeaZUaYpnIYWqjeWpHK8OW0+kwvqDCMEwaguq5aqaXafgAjwJ6zywhusF
	tsgFsWgaCMMY4NaTEaGk3lDtHCR73mjQ4SRA1LnqLj9EF0l+PnSJ2BlijBLHcS98VKUP8t
	Vf4bNVGD5TMPNXoHOH52Hod45ruzXX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712730040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJIujaH3RXIktcRv88URJI4c3MW1XPtMbHZWqI5VmXc=;
	b=0jV/eoo4drBjtHKjxE/GtnE1W1+NVg3WllILQl+VLv9gNYfTXrOGjwpUFYpLOwg0GRsGjF
	4Wxv4HCZCDpVodDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CECBE13691;
	Wed, 10 Apr 2024 06:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id InaALLYvFmaJGQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Apr 2024 06:20:38 +0000
Message-ID: <94d6d88b-b0e7-491d-94e8-dc9e5fba5620@suse.de>
Date: Wed, 10 Apr 2024 08:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] block atomic writes
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Pankaj Raghav
 <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, axboe@kernel.dk,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
 ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
 <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
 <ZhYQANQATz82ytl1@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZhYQANQATz82ytl1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLusjj3u5c53i6g8q6enupwtij)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,samsung.com,kernel.dk,kernel.org,lst.de,grimberg.me,linux.ibm.com,zeniv.linux.org.uk,redhat.com,suse.cz,vger.kernel.org,lists.infradead.org,mit.edu,google.com,kvack.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_232043_615065_9F80BC21 
X-CRM114-Status: GOOD (  32.23  )
X-Mailman-Approved-At: Wed, 10 Apr 2024 20:18:15 -0700
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

On 4/10/24 06:05, Matthew Wilcox wrote:
> On Mon, Apr 08, 2024 at 10:50:47AM -0700, Luis Chamberlain wrote:
>> On Fri, Apr 05, 2024 at 11:06:00AM +0100, John Garry wrote:
>>> On 04/04/2024 17:48, Matthew Wilcox wrote:
>>>>>> The thing is that there's no requirement for an interface as complex as
>>>>>> the one you're proposing here.  I've talked to a few database people
>>>>>> and all they want is to increase the untorn write boundary from "one
>>>>>> disc block" to one database block, typically 8kB or 16kB.
>>>>>>
>>>>>> So they would be quite happy with a much simpler interface where they
>>>>>> set the inode block size at inode creation time,
>>>>> We want to support untorn writes for bdev file operations - how can we set
>>>>> the inode block size there? Currently it is based on logical block size.
>>>> ioctl(BLKBSZSET), I guess?  That currently limits to PAGE_SIZE, but I
>>>> think we can remove that limitation with the bs>PS patches.
>>
>> I can say a bit more on this, as I explored that. Essentially Matthew,
>> yes, I got that to work but it requires a set of different patches. We have
>> what we tried and then based on feedback from Chinner we have a
>> direction on what to try next. The last effort on that front was having the
>> iomap aops for bdev be used and lifting the PAGE_SIZE limit up to the
>> page cache limits. The crux on that front was that we end requiring
>> disabling BUFFER_HEAD and that is pretty limitting, so my old
>> implementation had dynamic aops so to let us use the buffer-head aops
>> only when using filesystems which require it and use iomap aops
>> otherwise. But as Chinner noted we learned through the DAX experience
>> that's not a route we want to again try, so the real solution is to
>> extend iomap bdev aops code with buffer-head compatibility.
> 
> Have you tried just using the buffer_head code?  I think you heard bad
> advice at last LSFMM.  Since then I've landed a bunch of patches which
> remove PAGE_SIZE assumptions throughout the buffer_head code, and while
> I haven't tried it, it might work.  And it might be easier to make work
> than adding more BH hacks to the iomap code.
> 
> A quick audit for problems ...
> 
> __getblk_slow:
>         if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
>                          (size < 512 || size > PAGE_SIZE))) {
> 
> cont_expand_zero (not used by bdev code)
> cont_write_begin (ditto)
> 
> That's all I spot from a quick grep for PAGE, offset_in_page() and kmap.
> 
> You can't do a lot of buffer_heads per folio, because you'll overrun
>          struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
> in block_read_full_folio(), but you can certainly do _one_ buffer_head
> per folio, and that's all you need for bs>PS.
> 
Indeed; I got a patch here to just restart the submission loop if one
reaches the end of the array. But maybe submitting one bh at a time and
using plugging should achieve that same thing. Let's see.

>> I suspect this is a use case where perhaps the max folio order could be
>> set for the bdev in the future, the logical block size the min order,
>> and max order the large atomic.
> 
> No, that's not what we want to do at all!  Minimum writeback size needs
> to be the atomic size, otherwise we have to keep track of which writes
> are atomic and which ones aren't.  So, just set the logical block size
> to the atomic size, and we're done.
> 
+1. My thoughts all along.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


