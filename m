Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EF8D111A8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXbTrxgsAlnqrGC2bq20QGI2tFLVjFLDF+rh984/Uts=; b=WdRQkOeRkXMfnnbYK+qOJ+bOAy
	SG3X60vGokBVZFSPXBPtyKwjhLdOl/nxQVawdHxsgao311nqFf/7FcrZGYijlAyI1TX2mpePqeNAR
	pGQO97lV6fURhomyt49E7cTD1jR9ZDRVWQIXcvA19smp0wANJxP3NiiD3NIQXoW8p8LDZz/5TYdJ3
	28K/DrRk0BIbixFo4lOh349kOoawKhYbKuuzNzBAkMkaDjAzBSADbCcLeOyOwBzkK3x+LsmGr3wsX
	1PnSNOYl9eB7PQ8H8QA2vCr2QBikQn9s+6PcfRhX5blWHL+x+ELK/YA6D35KViWzLeyif4bKc0FYe
	Lrkuq4/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzak-000000039bL-3jP1;
	Mon, 01 Dec 2025 08:49:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzai-000000039at-0Ufn
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 08:49:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD7D83378E;
	Mon,  1 Dec 2025 08:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764578940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXbTrxgsAlnqrGC2bq20QGI2tFLVjFLDF+rh984/Uts=;
	b=Licv5f/lBku4xVHwbxKBAO1ViPhcgbVothScHPwR+B7ayQAza93DJ11y9gagQ0c+yxZbX1
	c6efWpzb5jWFWi+X5y9KO6nL9PGo5MS65EGLIlbDqPGLonWZMtsn6PSq+/xgC68rhadb6N
	rFyRnGmqO0kOT6jTVHIlAvD1PQ/zTAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764578940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXbTrxgsAlnqrGC2bq20QGI2tFLVjFLDF+rh984/Uts=;
	b=F5eIAHdFfOnTMwe36b0+9qeysj29IWt1HTMol/5SYgabLw8ZHZyFaV+mMEJl3RgbhhtT0k
	TMIwdOrF/Ab4BeCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764578940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXbTrxgsAlnqrGC2bq20QGI2tFLVjFLDF+rh984/Uts=;
	b=Licv5f/lBku4xVHwbxKBAO1ViPhcgbVothScHPwR+B7ayQAza93DJ11y9gagQ0c+yxZbX1
	c6efWpzb5jWFWi+X5y9KO6nL9PGo5MS65EGLIlbDqPGLonWZMtsn6PSq+/xgC68rhadb6N
	rFyRnGmqO0kOT6jTVHIlAvD1PQ/zTAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764578940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXbTrxgsAlnqrGC2bq20QGI2tFLVjFLDF+rh984/Uts=;
	b=F5eIAHdFfOnTMwe36b0+9qeysj29IWt1HTMol/5SYgabLw8ZHZyFaV+mMEJl3RgbhhtT0k
	TMIwdOrF/Ab4BeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74D8D3EA63;
	Mon,  1 Dec 2025 08:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kyi7GnxWLWk3NAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 08:49:00 +0000
Message-ID: <00a6f9f6-7850-4f85-a67f-09192484a381@suse.de>
Date: Mon, 1 Dec 2025 09:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
 <aebb3431-2216-4ccf-88e8-ba499417892c@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aebb3431-2216-4ccf-88e8-ba499417892c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_004904_305861_41B897CF 
X-CRM114-Status: GOOD (  23.47  )
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

On 11/30/25 22:35, Sagi Grimberg wrote:
> 
> 
> On 27/11/2025 9:52, Hannes Reinecke wrote:
>> On 11/26/25 08:32, Sagi Grimberg wrote:
>>>
>>>
>>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>>> The nvme-tcp code is using the ->read_sock() interface to
>>>> read data from the wire. While this interface gives us access
>>>> to the skbs themselves (and so might be able to reduce latency)
>>>> it does not interpret the skbs.
>>>> Additionally for TLS these skbs have to be re-constructed from
>>>> the TLS stream data, rendering any advantage questionable.
>>>> But the main drawback for TLS is that we do not get access to
>>>> the TLS control messages, so if we receive any of those message
>>>> the only choice we have is to tear down the connection and restart.
>>>> This patch switches the receive side over to use recvmsg(), which
>>>> provides us full access to the TLS control messages and is also
>>>> more efficient when working with TLS as skbs do not need to be
>>>> artificially constructed.
>>>
>>> Hannes,
>>>
>>> I generally agree with this approach. I'd like to point out though
>>> that this is going to give up running RX from directly from softirq 
>>> context.
>>
>> Yes.
>>
>>> I've gone back and forth on weather nvme-tcp should do that, but never
>>> got to do a thorough comparison between the two. This probably shuts
>>> the door on that option.
>>>
>> The thing with running from softirq context is that it would only
>> make sense if we could _ensure_ that the softirq context is running
>> on the cpu where the blk-mq hardware context is expecting it to.
> 
> What is this statement based on? softirq runs where the NIC interrupt
> happens, which eliminates the context switch to the workqueue io_cpu
> which is not guaranteed to affinitize where userspace is, in fact it often
> isn't in nvme-tcp...
> 
My thinking was that if we were to split TX and RX paths it would make
sense to align RX paths with the blk-mq CPU mapping. But that is not
a simple operation, and quite often not possible.
But if that wasn't the goal then fine, ignore my comment.

>> Not only would that require fiddling with RFS contexts, but we also
>> found that NVMe-over-fabrics should _not_ try to align with hardware
>> interrupts but rather rely on the driver to abstract things away.
> 
> I did not expect anyone to fiddle with RFS for softirq context. The main
> benefit of softirq context RX (outside of latency reduction) is that it
> makes io_work handle ONLY TX, which is probably somewhat more efficient.

But we still could do that, right?
We can easily split the current io_work() into two parts, the TX part 
driven from queue_rq(), and the RX part driven from the data_ready()
callback, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

