Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A35C3601E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YYdAssA5CZHDHNnO359XOHqGZEqUyxiEuaVj0NqkiS4=; b=2XhLO7jzSLWYU6uZdXO/PsGN0G
	vS5m0SlLcqIffvTF9moI50j//o5dySdmHMxwOd/vXBniTTC+KC0q243LzjV4u1q/7Jq/aG9iXx0ZS
	nqUq6svkY1NqL7HBnMij9QAbKOzcH+AQazz9Pnk7P3z8xkAa8V7nHd/FzwlStowq5dK4signwSeZZ
	1NzV7gkCfbe+LwjWw0hUqeKx26isWBXKFIFbP5uO8S7b655xw29W/IDbB224bujMNuOs81RY9lxhn
	Zay2K+Npzl69514fQqQsji6d3qeOVxHqPNpnZ7UL4Rt10Y04aPxbEL4pwa9eQDEmpfQMa5BiJiFf1
	AdHZ4QbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4DCo-00000000mat-2qME;
	Mon, 14 Apr 2025 06:22:06 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4DCl-00000000maS-3AzD
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 06:22:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55A2B1F397;
	Mon, 14 Apr 2025 06:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744611720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYdAssA5CZHDHNnO359XOHqGZEqUyxiEuaVj0NqkiS4=;
	b=iCBD3+8mWs/4GUp7u/eV6HtpAKBmKbiYcIuxLn5iuGFgK12vcdfJII6CBmwgyzRZ4KYAHf
	f1QE9CcTd3ShjrIqeYu3GTyMoZm4CjXdlmNd4iBjlsLlkjKGlUWXP3CKBHfW26mfTa39tv
	UkF/QR2YAWG9khD/fsmWKh/jPbk639w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744611720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYdAssA5CZHDHNnO359XOHqGZEqUyxiEuaVj0NqkiS4=;
	b=GrsCjS+ToXK2NXFJ5pZCpshX23EEoAnegjeqexbkKic2CXHL5mqINQHpV2MFA8PTW33mKu
	/jycE559ABW+7HCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744611720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYdAssA5CZHDHNnO359XOHqGZEqUyxiEuaVj0NqkiS4=;
	b=iCBD3+8mWs/4GUp7u/eV6HtpAKBmKbiYcIuxLn5iuGFgK12vcdfJII6CBmwgyzRZ4KYAHf
	f1QE9CcTd3ShjrIqeYu3GTyMoZm4CjXdlmNd4iBjlsLlkjKGlUWXP3CKBHfW26mfTa39tv
	UkF/QR2YAWG9khD/fsmWKh/jPbk639w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744611720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYdAssA5CZHDHNnO359XOHqGZEqUyxiEuaVj0NqkiS4=;
	b=GrsCjS+ToXK2NXFJ5pZCpshX23EEoAnegjeqexbkKic2CXHL5mqINQHpV2MFA8PTW33mKu
	/jycE559ABW+7HCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 152391336F;
	Mon, 14 Apr 2025 06:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CPz5Aoip/GeIdwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 14 Apr 2025 06:22:00 +0000
Message-ID: <09aca7f3-4911-4a6f-a49d-25da590bf8c6@suse.de>
Date: Mon, 14 Apr 2025 08:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <ee4379d7-53f8-4399-ba94-be9113b11b48@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ee4379d7-53f8-4399-ba94-be9113b11b48@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_232203_951768_E73332EC 
X-CRM114-Status: GOOD (  22.22  )
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

On 4/14/25 01:09, Sagi Grimberg wrote:
> 
> 
> On 03/04/2025 9:55, Hannes Reinecke wrote:
>> When the socket is busy processing nvme_tcp_try_recv() might
>> return -EAGAIN, but this doesn't automatically imply that
>> the sending side is blocked, too.
>> So check if there are pending requests once nvme_tcp_try_recv()
>> returns -EAGAIN and continue with the sending loop to avoid
>> I/O stalls.
>>
>> Acked-by: Chris Leech <cleech@redhat.com>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 1a319cb86453..87f1d7a4ea06 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct work_struct 
>> *w)
>>           result = nvme_tcp_try_recv(queue);
>>           if (result > 0)
>>               pending = true;
>> -        else if (unlikely(result < 0))
>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>               return;
> 
> The way that the send path was done - is that EAGAIN returns 0 (success 
> returns >0, failure returns <0)
> Perhaps we can make recv do the same?
> 
I guess we can.

>> +        if (nvme_tcp_queue_has_pending(queue))
>> +            pending = true;
>> +
> 
> Something is not clear to me, this suggest that try_send was not able to 
> send data on the socket, shouldn't a .write_space() callback wake you when
 > the socket send buffer gets some space? Why> do you immediately try 
more even if you're sendmsg is returning EAGAIN?
> 
But that's precisely the point: sendmsg() did _not_ return -EAGAIN.
recvmsg() did.

We just imply that nvme_tcp_try_send() will return -EAGAIN once 
nvme_tcp_try_recv() did.

Which is wrong; -EAGAIN on reception can be due to a number of factors,
and does _not_ imply in any shape or form that sending will exhibit
the same error.

> This is specific to TLS I assume here?

Not necessarily; I've seen it with my performance testing on 10GigE
with normal TCP, too. TLS is just an easier way to reproduce it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

