Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D07C83F18
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jul 2025 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1WzB9T/HEA3zl1fSfSp4StlUkmpKLI9rc2lrqum55+I=; b=mXXHiDRcOyfFGxtrsRPdfCXU6b
	qZnlmpEH6mH0rJtNtd1pkXyMSwyKYJqoyOY+EnU+jcesVbkhpRx3Gr80ibHEjsSzigAn+r8mK37jn
	EK+nqtL2tYz/X0c5cTUxtK1pFneztIDVGut6pCeCHA256KmcU3A7ojmcE/f090budFoIeQ7flGXdK
	nf7EMl9RTfqKAUyOQomceKfZqXq23RKwKZLtGbGRxGS7/n5yPfnQP0FxhP6XMbNh7pxkEbMSBWCbx
	m/wcLb12U+WoMfq0gOQRhgvm8k8BiY/ajNVRNJClbI4vvLO0kyGEzaBGUkYocErP1uXBMqL9Bbadp
	tI4ee9MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZllQ-0000000B19X-2V4I;
	Thu, 10 Jul 2025 07:32:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZktF-0000000AtFJ-0rIa
	for linux-nvme@lists.infradead.org;
	Thu, 10 Jul 2025 06:36:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4C2A1F385;
	Thu, 10 Jul 2025 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752129374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WzB9T/HEA3zl1fSfSp4StlUkmpKLI9rc2lrqum55+I=;
	b=u/0DTwPmycwVQbP0oEdFapFe6BJx6KtLrGQwbBmlIeyOlgISfJKgncy0eRbkxp07nyhDSV
	GhjsHmWZxH2GTWa235EPq3BtG+m3mMPl+jpTlNIAhoNROst9QM67CULTortlLKhypDvzkz
	LY62HIWDbQJ7WB61c4vXIh3EqPGU+dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752129374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WzB9T/HEA3zl1fSfSp4StlUkmpKLI9rc2lrqum55+I=;
	b=9p6YPHnMD3A8ejIPXxj5WwnNJZpsBhBDAvWecoeo+YdimRaa2CrB6uVneDXOrENgIzDOD8
	nb9vdAzs2DZEdNAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752129373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WzB9T/HEA3zl1fSfSp4StlUkmpKLI9rc2lrqum55+I=;
	b=zfShDxLz1asSYa4ymdhFfOQJKtVnajWpgHhLZwBv+tdBmu0m59YQYPtCYyIft+MaSa/5PI
	RZOFdmW5WCUg+Z/+7M35KOGzxCqo/TnKh/OxxajVcgYGOqdxjEWHPkqMfeJNk4dmZV4rPe
	hOLmJTihI9ePj/sQcAX5k+i4wVUJbqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752129373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WzB9T/HEA3zl1fSfSp4StlUkmpKLI9rc2lrqum55+I=;
	b=4X/xWS7MzzmrvipbT++QlFIoCCe0JHh07Kirjbj9pFTeDYsLMQAOTsdtKDwe1VYC3x6jtF
	IZIGllbK0oClfGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66819136CB;
	Thu, 10 Jul 2025 06:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FJCdFl1fb2hnEgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 10 Jul 2025 06:36:13 +0000
Message-ID: <782942d7-41fe-41e2-9913-54108d44bcd3@suse.de>
Date: Thu, 10 Jul 2025 08:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] nvme-multipath: queue-depth support for marginal
 paths
To: John Meneghini <jmeneghi@redhat.com>
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Bryan Gurney <bgurney@redhat.com>
References: <20250709212652.49471-1-bgurney@redhat.com>
 <66a05f2e-f3fd-4347-9c7f-f8fbb715890d@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <66a05f2e-f3fd-4347-9c7f-f8fbb715890d@redhat.com>
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_233617_818856_F8308724 
X-CRM114-Status: GOOD (  14.62  )
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

On 7/10/25 00:03, John Meneghini wrote:
> Hannes, this patch fixes the queue-depth scheduler.  Please take a look.
> 
> On 7/9/25 5:26 PM, Bryan Gurney wrote:
>> From: John Meneghini <jmeneghi@redhat.com>
>>
>> Exclude marginal paths from queue-depth io policy. In the case where all
>> paths are marginal and no optimized or non-optimized path is found, we
>> fall back to __nvme_find_path which selects the best marginal path.
>>
>> Tested-by: Bryan Gurney <bgurney@redhat.com>
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> ---
>>   drivers/nvme/host/multipath.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/ 
>> multipath.c
>> index 8d4e54bb4261..767583e8454b 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -420,6 +420,9 @@ static struct nvme_ns 
>> *nvme_queue_depth_path(struct nvme_ns_head *head)
>>           if (nvme_path_is_disabled(ns))
>>               continue;
>> +        if (nvme_ctrl_is_marginal(ns->ctrl))
>> +            continue;
>> +
>>           depth = atomic_read(&ns->ctrl->nr_active);
>>           switch (ns->ana_state) {
>> @@ -443,7 +446,9 @@ static struct nvme_ns 
>> *nvme_queue_depth_path(struct nvme_ns_head *head)
>>               return best_opt;
>>       }
>> -    return best_opt ? best_opt : best_nonopt;
>> +    best_opt = (best_opt) ? best_opt : best_nonopt;
>> +
>> +    return best_opt ? best_opt : __nvme_find_path(head, numa_node_id());
>>   }
>>   static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
> 

Hmm. Not convinced. I would expect a 'marginal' path to behave different
(performance-wise) than unaffected paths. And the queue-depth scheduler
should be able to handle paths with different performance
characteristics just fine.
(Is is possible that your results are test artifacts? I guess
your tool just injects FPIN messages with no performance impact,
resulting in this behaviour...)

But if you want to exclude marginal paths from queue depth:
by all means, go for it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

