Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC8BC77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HN7WP4srTKBD9WuELDCkXKXZzsfHn+v/Fy/ho69UcQU=; b=NCKoo4rmFq5L1Od5nEOdJU3hci
	rjps2yXN8wPEILcqXzcZw/m7uGxMio7Kj9SS837iDwSZ7gMoO04+1516u7lt7/9gnbBQW0LvZWIt5
	J39ekTG71pkuF1uifK9299EqzQ2jCknAYZ9TjDdngb/AJgdcYuWK+9MnQWbTAkezzJstIL9K0WECL
	Vik1tFDb6kQQg+gCvajyyahFw2u7gaH8wSKDH95B7BJAsQwxH2CdBsfS54Mog1AcrQ7+F79PA/68m
	ijjo7RHPO2LzBZaMXXvVyVNvkLNQG1s3olB+S7755gnzFptHrL61aBnsc8SS5lsDiblv6Ws5TQbms
	ZYMI4PBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poIL6-00F3MX-1l;
	Mon, 17 Apr 2023 06:27:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poIL3-00F3Lb-2w
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 06:27:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB5A71F86B;
	Mon, 17 Apr 2023 06:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681712862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN7WP4srTKBD9WuELDCkXKXZzsfHn+v/Fy/ho69UcQU=;
	b=BcHoCsHopk3OOFONWnpzkWu2GudGENSxy5w0CFn/fW9vKXghYOy6md7tU8pbjbF/um7o4t
	o5Pf5cnbt7nHXWuDWDpcdNVDH7ie2972AMv6rlMcY/Rs3iinN0m2k2CJE7/6M52UQRIt5n
	miM2lXqAuLKo7URLC0CWRKVBDth/MOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681712862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN7WP4srTKBD9WuELDCkXKXZzsfHn+v/Fy/ho69UcQU=;
	b=oLybQE5lDQokG1EThEWdAn3a822zgfKu94wb5ehQzGUqkNuTcTD+mqsfrgeoyyFDqMg0q7
	wr+6hG0ARVJAayCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 781E513319;
	Mon, 17 Apr 2023 06:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WLfbEt7mPGRVBAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 17 Apr 2023 06:27:42 +0000
Message-ID: <c9b07e76-9953-b34f-dac0-4a9762b4ac34@suse.de>
Date: Mon, 17 Apr 2023 08:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, 'Li Feng' <fengli@smartx.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "lifeng1519@gmail.com" <lifeng1519@gmail.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
 <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
 <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230416_232746_113790_74AAF948 
X-CRM114-Status: GOOD (  27.02  )
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

On 4/15/23 23:06, David Laight wrote:
> From: Li Feng
>> Sent: 14 April 2023 10:35
>>>
>>> On 4/13/23 15:29, Li Feng wrote:
>>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>>> have a bad performance.
>>>>
>>>> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
>>>> socket worker threads.  The parameter is a comma separated list of CPU
>>>> numbers.  The list is parsed and the resulting cpumask is used to set the
>>>> affinity of the socket worker threads.  If the list is empty or the
>>>> parsing fails, the default affinity is used.
>>>>
> ...
>>> I am not in favour of this.
>>> NVMe-over-Fabrics has _virtual_ queues, which really have no
>>> relationship to the underlying hardware.
>>> So trying to be clever here by tacking queues to CPUs sort of works if
>>> you have one subsystem to talk to, but if you have several where each
>>> exposes a _different_ number of queues you end up with a quite
>>> suboptimal setting (ie you rely on the resulting cpu sets to overlap,
>>> but there is no guarantee that they do).
>>
>> Thanks for your comment.
>> The current io-queues/cpu map method is not optimal.
>> It is stupid, and just starts from 0 to the last CPU, which is not configurable.
> 
> Module parameters suck, and passing the buck to the user
> when you can't decide how to do something isn't a good idea either.
> 
> If the system is busy pinning threads to cpus is very hard to
> get right.
> 
> It can be better to set the threads to run at the lowest RT
> priority - so they have priority over all 'normal' threads
> and also have a very sticky (but not fixed) cpu affinity so
> that all such threads tends to get spread out by the scheduler.
> This all works best if the number of RT threads isn't greater
> than the number of physical cpu.
> 
And the problem is that you cannot give an 'optimal' performance metric
here. With NVMe-over-Fabrics the number of queues is negotiated during
the initial 'connect' call, and the resulting number of queues strongly 
depends on target preferences (eg a NetApp array will expose only 4 
queues, with Dell/EMC you end up with up max 128 queues).
And these queues need to be mapped on the underlying hardware, which has
its own issues wrt to NUMA affinity.

To give you an example:
Given a setup with a 4 node NUMA machine, one NIC connected to
one NUMA core, each socket having 24 threads, the NIC exposing up to 32
interrupts, and connections to a NetApp _and_ a EMC, how exactly should
the 'best' layout look like?
And, what _is_ the 'best' layout?
You cannot satisfy the queue requirements from NetApp _and_ EMC, as you 
only have one NIC, and you cannot change the interrupt affinity for each 
I/O.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


