Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E92C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 06:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1OTkEPS5AMRm9VEeOYPgTpV7I20sNwaudAazdwpCpPM=; b=KOcV8jAhpUCl5jO1kT7jw4TDvj
	Kt+pNqzr6vXN0fGfA3j2JCt289gcbpjIe23I+85Jr8iPialROktGtPbDPPh1mCwBvb038h8nsEBcf
	n+lMGqjHOPNyLLrm3LNisB0GHlgUqUpUqE9ds+QZlDeOFYF3Gwfo9/AT5UqJUuo5HaKi+G69jHCcZ
	q5/6upHoCKtw4wzo+FqtWqoJaCe7sHrunY/eU+HuUdIl9Ptimf9J+fie//RFQLnVrJcU3XxVYc4IZ
	CCS28IEW4zM52eMXz7k/my4zbTXlnE+AHsKbCKm2gPzw3lBmkOdUWKE0nvl/fz7cpqh2gBL+iqxWG
	hVqifArQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pesRM-00Ex2O-1M;
	Wed, 22 Mar 2023 06:59:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pesRJ-00Ex1r-2L
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 06:59:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEBFA20A7B;
	Wed, 22 Mar 2023 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679468353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OTkEPS5AMRm9VEeOYPgTpV7I20sNwaudAazdwpCpPM=;
	b=azBTR29QzBaDBi7vZ+av9Knli1c0xMn/yiH/sC/VKHtPyztV2vZbllql9UhR8fXDOiru6C
	eWjHD8+/gych7trr4BwIIeC1s4kH5K7jy0KNLktrDeTHGfVLqHUOiNdIwFG2gMttONPwzL
	/+8qJz0qq/fvYghliOGTj2lvefd6/rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679468353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OTkEPS5AMRm9VEeOYPgTpV7I20sNwaudAazdwpCpPM=;
	b=i8PHLrs5uwNffO3jm/VRckKahZK7CDKFa9+A1heo4lWHDOjimnzCmdRLvD7pTi6L6NwF1Y
	/YeiEL1cG5Tir0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D9C213416;
	Wed, 22 Mar 2023 06:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xRXhJUGnGmRHXgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 06:59:13 +0000
Message-ID: <2dbd26ec-c384-866c-8d76-38364fa3330e@suse.de>
Date: Wed, 22 Mar 2023 07:59:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
Content-Language: en-US
To: Chris Leech <cleech@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
 <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
 <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de> <ZBpJQENvFoyGortp@localhost>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZBpJQENvFoyGortp@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_235917_936433_2CE126C1 
X-CRM114-Status: GOOD (  23.63  )
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

On 3/22/23 01:18, Chris Leech wrote:
> On Tue, Mar 21, 2023 at 03:09:06PM +0100, Hannes Reinecke wrote:
>> On 3/21/23 14:44, Sagi Grimberg wrote:
>>>
>>>> Call the original data_ready() callback in nvme_tcp_data_ready()
>>>> to avoid a receive stall.
>>>
>>> Can you please improve the description to include what is the stall?
>>> For example, does the stall exist today? If it is, I would like to
>>> separate such patches from this set and include them asap.
>>>
>> That is actually particular to the TLS implementation, as it uses the
>> 'data_ready' callback to produce the data which can be read by eg recvmsg().
>>
>> Without this call there's no data to peruse for recvmsg().
>>
>> But I'm not _that_ deep into networking details to know whether this is TLS
>> specific or an issue with any data_ready callback.
>> I assume the latter, but then again, who knows.
>>
>> Hence the slightly vague description.
> 
> This looks like the socket callbacks end up hooked in the wrong order.
> Ideally it would be tcp -> tls -> nvme_tcp, while this currently looks
> like tcp -> nvme_tcp and then this call back to tls for decryption.
> 
Well, problem is that I need not one but two sets the callbacks.
One callback is for waking up userspace (took me weeks to figure that 
out), and needs to added before calling the userspace helper.
The other is the 'normal' nvme-tcp callback:

tcp->nvme-upcall->tls->nvme-tcp

So really the problem is not so much an inversion, but rather the fact
that the nvme-upcall callback is really only needed for the duration
of the handshake. And hence I thought that we should remove the callback
once we're done with the upcall.
Turns out that we can't, and the best we can do is to disable the 
functionality, leaving the callback itself in place.

> I'm not quite sure how to untangle this; nvme_tcp can't just set it's
> own callbacks before initializing kTLS, becuse that's being done by
> tlshd which is going to need the userspace socket API callbacks working.
> 
Correct.
So for now I'll leave the callbacks in place, even though they are 
pointless after the upcall.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


