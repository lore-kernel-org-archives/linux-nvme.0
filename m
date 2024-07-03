Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73028C30653
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0da+BB2sN+SouYMqFnSNNrb8n64F7dLJxPa5qnOlpwQ=; b=pFG+ygCRkp1Vh0+6H5/MeSRYqf
	OL9O0xS3Vk3HFfkkNm2UjCmxGWS8DxMlVMk/S9mTP4UhkQmivkfHfMV98mlTHyQgaeCnCGemfYMQP
	VxHW9Q5IxtoSkk/F5ATmMdq2OgcOxLcU5RhltdcCs1MJ3ELYsbuu1yenpF9xHFEzjp2x6spC3vNeU
	4Pbzv+6bel4t9wWB7buqnYPabEq5dTBfGXzaZN5cne0jJ0rzEhrenfzWcFYeHYlEZvUIxJqdGe2Pd
	p6E434cDNvcOr2nLgTtDI4Tg8GaVbrtzLHY5GGYSNcvrdC5TZAUcD/1ZKPC3Ckg7/joTEuGaAENdU
	CVFB59Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1MZ-0000000AXx8-1qIO;
	Wed, 03 Jul 2024 14:53:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1MU-0000000AXvy-188G
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 14:53:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 211A721BDB;
	Wed,  3 Jul 2024 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720018412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0da+BB2sN+SouYMqFnSNNrb8n64F7dLJxPa5qnOlpwQ=;
	b=D+d3eJuV13JjvdkOHzOMolsBt9llzJr+I4PnXAUJzBnQMfqM7eo7wMk9e+GZyoAn630MC3
	0rQ69MUGnYH0HRaHGJidoNiWM8Kg3gRviINMxHA9pm2ZhovoQWcjBzfS5geUahWw7CKaHc
	GCn1o2tCI3NasM/+MwUy+M7z0CNqGpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720018412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0da+BB2sN+SouYMqFnSNNrb8n64F7dLJxPa5qnOlpwQ=;
	b=8YCbstxOTX74nYC1oEjNHKmQ2i+SL4tGK0wh6XFEBwAg+zY4R7+SJOfCtkBcnuwKvQwp0M
	ssA8gP/Wz4WIxJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720018412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0da+BB2sN+SouYMqFnSNNrb8n64F7dLJxPa5qnOlpwQ=;
	b=D+d3eJuV13JjvdkOHzOMolsBt9llzJr+I4PnXAUJzBnQMfqM7eo7wMk9e+GZyoAn630MC3
	0rQ69MUGnYH0HRaHGJidoNiWM8Kg3gRviINMxHA9pm2ZhovoQWcjBzfS5geUahWw7CKaHc
	GCn1o2tCI3NasM/+MwUy+M7z0CNqGpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720018412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0da+BB2sN+SouYMqFnSNNrb8n64F7dLJxPa5qnOlpwQ=;
	b=8YCbstxOTX74nYC1oEjNHKmQ2i+SL4tGK0wh6XFEBwAg+zY4R7+SJOfCtkBcnuwKvQwp0M
	ssA8gP/Wz4WIxJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD9F413889;
	Wed,  3 Jul 2024 14:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jQx3NOtlhWYIRgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jul 2024 14:53:31 +0000
Message-ID: <11c0b02b-03a3-4097-948b-651b14baa0cf@suse.de>
Date: Wed, 3 Jul 2024 16:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
 <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_075334_485297_8B299E5F 
X-CRM114-Status: GOOD (  18.75  )
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

On 7/3/24 16:19, Sagi Grimberg wrote:
> 
> 
> On 03/07/2024 16:50, Hannes Reinecke wrote:
>> When 'wq_unbound' is selected we should select the
>> the first CPU from a given blk-mq hctx mapping to queue
>> the tcp workqueue item. With this we can instruct the
>> workqueue code to keep the I/O affinity and avoid
>> a performance penalty.
> 
> wq_unbound is designed to keep io_cpu to be UNBOUND, my recollection
> was the the person introducing it was trying to make the io_cpu always be
> on a specific NUMA node, or a subset of cpus within a numa node. So he uses
> that and tinkers with wq cpumask via sysfs.
> 
> I don't see why you are tying this to wq_unbound in the first place.
> 
Because in the default case the workqueue is nailed to a cpu, and will 
not move from it. IE if you call 'queue_work_on()' it _will_ run on that 
cpu.
But if something else is running on that CPU (printk logging, say), you 
will have to stand in the queue until the scheduler gives you some time.

If the workqueue is unbound the workqueue code is able to switch away 
from the cpu if it finds it busy or otherwise unsuitable, leading to a 
better utilization and avoiding a workqueue stall.
And in the 'unbound' case the 'cpu' argument merely serves as a hint
where to place the workqueue item.
At least, that's how I understood the code.

And it makes the 'CPU hogged' messages go away, which is a bonus in 
itself...

>>
>> One should switch to 'cpu' workqueue affinity to
>> get full advantage of this by issuing:
>>
>> echo cpu > /sys/devices/virtual/workqueue/nvme_tcp_wq_*/affinity_scope
> 
> Quantify improvement please.

I'll see to get some number.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


