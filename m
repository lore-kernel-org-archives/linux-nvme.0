Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2442C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onz9ifwXkL45Z5MVbC+bMFcJp8WjTyTPYVHGjzctfo0=; b=MSGUcbDAwDBLWajLYYOZ8kIKFs
	JrHpQIbhxFmVG8pEhRtjJFYV9PbH2F4HGjR58X94V+/rLq5nYTShRisNKIC/brDBu8jRpXlP97wG8
	3Apn2TK1F0pyPBHL8Q1XEr4IIwMu3Am/08BZluEfIuv4H78ZTOK5TgNXa915u3yiGVHWtVrFjx1VR
	HJTriK1YPCX/YVZGLN1rQ1iOAQbZgMFTULhVx98H+uJRsfCD+8XO8xThfDv1ztA/s0m0jBa+AQOsw
	GBra32xlUtJH+svZVhpNpPdURDPTzmiejShIIdTX0ZxdbGTpTHF6mve3voubGdIt9bcvK4x4Scorq
	scVKLX6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxYv-00000001tfR-1LZ6;
	Wed, 19 Jun 2024 15:49:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxYp-00000001tcV-1CZc
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 15:49:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D86A1F7EE;
	Wed, 19 Jun 2024 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718812161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onz9ifwXkL45Z5MVbC+bMFcJp8WjTyTPYVHGjzctfo0=;
	b=HM4mzyJksraI0s38hJJ4EKX3cPARy+Wg2RWEZ+rlzsaHPM9a0UhOaGiK3teED58W9YzSu7
	/M9/+UPRfBqA4yWHm3YIWLBfYPyFSUu8Jrt3DUHMZ5MC0zbnmaDiP0652ufnAkbLx1ATHq
	h8rXk0EBAzZof6dvCSq8eiVOlI+uDCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718812161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onz9ifwXkL45Z5MVbC+bMFcJp8WjTyTPYVHGjzctfo0=;
	b=MBvBSxcx/GE+tnUfjrVzSQHgWi9DmnTx6oI6OvdqH+sbFWGxk3Vw0Nw0Z4WBXZtXOLOzF1
	k4KRLtuLndRApWAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718812161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onz9ifwXkL45Z5MVbC+bMFcJp8WjTyTPYVHGjzctfo0=;
	b=HM4mzyJksraI0s38hJJ4EKX3cPARy+Wg2RWEZ+rlzsaHPM9a0UhOaGiK3teED58W9YzSu7
	/M9/+UPRfBqA4yWHm3YIWLBfYPyFSUu8Jrt3DUHMZ5MC0zbnmaDiP0652ufnAkbLx1ATHq
	h8rXk0EBAzZof6dvCSq8eiVOlI+uDCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718812161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onz9ifwXkL45Z5MVbC+bMFcJp8WjTyTPYVHGjzctfo0=;
	b=MBvBSxcx/GE+tnUfjrVzSQHgWi9DmnTx6oI6OvdqH+sbFWGxk3Vw0Nw0Z4WBXZtXOLOzF1
	k4KRLtuLndRApWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F33F13AAA;
	Wed, 19 Jun 2024 15:49:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2ccwAgH+cmbfKgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Jun 2024 15:49:21 +0000
Message-ID: <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
Date: Wed, 19 Jun 2024 17:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_084923_908185_059DDD28 
X-CRM114-Status: GOOD (  24.30  )
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

On 6/19/24 17:43, Sagi Grimberg wrote:
> 
> 
> On 19/06/2024 18:23, Hannes Reinecke wrote:
>> On 6/19/24 16:59, Christoph Hellwig wrote:
>>>>       if (wq_unbound)
>>>>           queue->io_cpu = WORK_CPU_UNBOUND;
>>>
>>> None of the above computed information is even used for the wq_unbound
>>> code.  This would make a lot more sense if the above assignment was in
>>> the (only) caller.
>>>
>>> Yes, that probably should have been done when merging the wq_unbound
>>> option (which honestly looks so whacky that I wish it wasn't merged).
>>>
>> Ah, you noticed?
>>
>> This patch is actually got sparked off by one of our partners notifying
>> a severe latency increase proportional with the number of controllers.
>> With a marked increase when (sw) TLS is active; they even managed to run
>> into command timeouts.
>>
>> What happens is that we shove all work from identical queue numbers 
>> onto the same CPU; so if your controller only exports 4 queues _all_ 
>> work from qid 1 (from all controllers!) is pushed onto CPU 0 causing a 
>> massive oversubscription on that CPU and leaving all other CPUs in the 
>> system idle.
> 
> I see how you address multiple controllers falling into the same 
> mappings case in your patch.
> You could have selected a different mq_map entry for each controller 
> (out of the entries that map to the qid).
> 
Looked at it, but hadn't any idea how to figure out the load.
The load is actually per-cpu, but we only have per controller structures.
So we would need to introduce a per-cpu counter, detailing out the
number of queues scheduled on that CPU.
But that won't help with the CPU oversubscription issue; we still might 
have substantially higher number of overall queues than we have CPUs...

>>
>> Not sure how wq_unbound helps in this case; in theory the workqueue
>> items can be pushed on arbitrary CPUs, but that only leads to even worse
>> thread bouncing.
>>
>> However, topic for ALPSS. We really should have some sore of 
>> backpressure here.
> 
> I have a patch that was sitting for some time now, to make the RX path 
> run directly
> from softirq, which should make RX execute from the cpu core mapped to 
> the RSS hash.
> Perhaps you or your customer can give it a go.
> 
No s**t. That is pretty much what I wanted to do.
I'm sure to give it a go.
Thanks for that!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


