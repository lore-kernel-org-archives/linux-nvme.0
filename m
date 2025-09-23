Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C42DCAC5B0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mqwJ8xsnV8dCD4c1RLTq7zMKeO2ni7iqVo0XoJYoLd4=; b=zY3TJwJryhHE0eyL8cH6r+BJFU
	8VCxXFgb0+yfjYCXyYAQjA06tChhxtNJmGi3Bj8FiscBYGoknTeDw+0DyrwLHtcS0lhhEa1rx05qy
	T5qR2pMXQdrbdCLUAbly4t+q50oIyus80/PaC5l+Zjakf9ggPAgma8lzaV243uFpuIx69fy3IsUFl
	E5T/dtkBI5ExA4QAesgY6Z4Wn9eYypt678v4NsxNdY0VkI9R1RQKfMZepNDJg3rTGcoedk01ER0Ik
	vQ+XtWx67W9nIFcwkb0hZu3U7akUFfUfSyFfCGcDCA2/mf57UAKTUU9Kp+0a1ZBbiu8wGjedLH1Ml
	m35rPjUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10FQ-0000000D3BP-0wlE;
	Tue, 23 Sep 2025 10:27:48 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10FN-0000000D3Am-06pF
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 10:27:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90C4C1F7DE;
	Tue, 23 Sep 2025 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758623261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqwJ8xsnV8dCD4c1RLTq7zMKeO2ni7iqVo0XoJYoLd4=;
	b=c4e/cYMsL8f+5r53xFbEdAwU9p5kHUUx/Kj2ySPFmLGbLuXAEBPYVfm1/oZoK/GPxaa9+t
	bBOJT86ULF/FJuorulTFBfpDBGQgLGPrTZCehKQ6+8Ie9QNjQWfZdo1dVbnEoYKyUMJKiA
	9JLZ6d8db8PnKtF68SfanE/+vJlQk/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758623261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqwJ8xsnV8dCD4c1RLTq7zMKeO2ni7iqVo0XoJYoLd4=;
	b=is9Q+zYhvMwdGfzMKTyBDyQiKyyfUom5cav5ks64MLyxxyHuDqxFcv8W2gpqtG8tLVueeW
	CmI001rBDTYELMAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758623261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqwJ8xsnV8dCD4c1RLTq7zMKeO2ni7iqVo0XoJYoLd4=;
	b=c4e/cYMsL8f+5r53xFbEdAwU9p5kHUUx/Kj2ySPFmLGbLuXAEBPYVfm1/oZoK/GPxaa9+t
	bBOJT86ULF/FJuorulTFBfpDBGQgLGPrTZCehKQ6+8Ie9QNjQWfZdo1dVbnEoYKyUMJKiA
	9JLZ6d8db8PnKtF68SfanE/+vJlQk/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758623261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqwJ8xsnV8dCD4c1RLTq7zMKeO2ni7iqVo0XoJYoLd4=;
	b=is9Q+zYhvMwdGfzMKTyBDyQiKyyfUom5cav5ks64MLyxxyHuDqxFcv8W2gpqtG8tLVueeW
	CmI001rBDTYELMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 651AE132C9;
	Tue, 23 Sep 2025 10:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FLOvFx120mgpbAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 23 Sep 2025 10:27:41 +0000
Message-ID: <7021edf0-b459-4f0c-a309-3948ef588c71@suse.de>
Date: Tue, 23 Sep 2025 12:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] nvmf-tcp: add support for retrieving adapter link
 speed
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-5-nilay@linux.ibm.com>
 <bacb5186-b3f6-45fe-967c-0472df746b4f@suse.de>
 <67abba19-5b81-48bf-a279-fd4c520f2d29@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <67abba19-5b81-48bf-a279-fd4c520f2d29@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_032745_211265_B265EF24 
X-CRM114-Status: GOOD (  25.39  )
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

On 9/23/25 11:33, Nilay Shroff wrote:
> 
> 
> On 9/22/25 1:08 PM, Hannes Reinecke wrote:
>> On 9/21/25 13:12, Nilay Shroff wrote:
>>> Add support for retrieving the negotiated NIC link speed (in Mbps).
>>> This value can be factored into path scoring for the adaptive I/O
>>> policy. For visibility and debugging, a new sysfs attribute "speed"
>>> is also added under the NVMe path block device.
>>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>    drivers/nvme/host/multipath.c | 11 ++++++
>>>    drivers/nvme/host/nvme.h      |  3 ++
>>>    drivers/nvme/host/sysfs.c     |  5 +++
>>>    drivers/nvme/host/tcp.c       | 66 +++++++++++++++++++++++++++++++++++
>>>    4 files changed, 85 insertions(+)
>>>
>> Why not for FC? We can easily extract the link speed from there, too ...
>>
> Yes it's easy to get the speed for FC. I just wanted to get feedback from
> the community about this idea and so didn't include it. But I will do that
> in the future patchset.
>   
>> But why do we need to do that? We already calculated the weighted
>> average, so we _know_ the latency of each path. And then it's
>> pretty much immaterial if a path runs with a given speed; if the
>> latency is lower, that path is being preferred.
>> Irrespective of the speed, which might be deceptive anyway as
>> you'll only ever be able to retrieve the speed of the local
>> link, not of the entire path.
>>
> Consider a scenario with two paths: one over a high-capacity link
> (e.g. 1000 Mbps) and another over a much smaller link (e.g. 10 Mbps).
> If both paths report the same latency, the current formula would
> assign them identical weights. But in reality, the higher-capacity
> path can sustain a larger number of I/Os compared to the lower-
> capacity one.
> 
That would be correct if the transfer speed is assumed to be negligible.
But I would assume that we do transfer mainly in units of PAGE_SIZE,
so with 4k PAGE_SIZE we'll spend 400 ms on a 10Mbps link, but 4ms on a
1000Mbps link. That actually is one of the issues we're facing with
measuring latency: we only have access to the combined latency
(submission/data transfer/completion), so it's really hard to separate
them out.

> In such cases, factoring in link speed allows us to assign proportionally
> higher weight to the higher-capacity path. At the same time, if that same
> path exhibits higher latency, it will be penalized accordingly, ensuring
> the final score balances both latency and bandwidth.
> 
See above. If we could measure them separately, yes. But we can't.

> So, including link speed in the weight calculation helps capture both
> dimensions—latency sensitivity and throughput capacity—leading to a more
> accurate and proportional I/O distribution.
> 
Would be true if we could measure it properly. But we can only get 
thespeed on the local link; everything behind that is anyone's guess, and
it would skew measurements even more if we assume the same link speed
for the entire path.

Cheers,Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

