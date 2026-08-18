Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C28C5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/wbL1+SE+ksHe5t9mse0VA4gf4msWrjpt/QHOCY2mhg=; b=XTb+HUpnwq5uGJ9o9WOGA1gqSq
	IzJbCaYpa7DSFBiTcK7ili8zAF9haYKsVbYlCJjfG+hRrpD2qmM1fJG16feFn7nLh/PffFRwCj1pa
	+uJbN9ZHUyjMb6YTQeiLoMlwiCVwj+vuMEmX35/aHCJondQNqyQO1uP+/P88g0wMIg41544tVeSnN
	kr3bFiBg+zC0JDbNAeQpXGfZIExV67KQeG9KkjgvjDZ5l/2X/cihge97ANOHxoshyupnre2xli8ty
	ci7JhDOSBf1MX7EEXNcs5p1og3t6bagK/f1x+DTs8uflCD7Owp03ht0PE8Wdg3zHe7jgzzwCDO9+t
	dSsvPOTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwGb6-00000007gdn-2hht;
	Tue, 18 Aug 2026 09:59:08 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwGb4-00000007gd0-2rWS
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 09:59:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05A233E48;
	Tue, 18 Aug 2026 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787047140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wbL1+SE+ksHe5t9mse0VA4gf4msWrjpt/QHOCY2mhg=;
	b=zCY/k+GgLoBOHb3UGVxa4vSjyCDqrPDk1CRoPUiblOFPwQVHolPuaGig1Ku/iTXMGI4mtu
	J4vVMbs/oAysUW3aJ5rwLhSmOA3m/vaAwjq5Te2cqqyaNVgc6cxCl9Owe0D7ZYC+EIfBTh
	xO+o3NIfkmLNbUncQGMJACJDPod5h4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787047140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wbL1+SE+ksHe5t9mse0VA4gf4msWrjpt/QHOCY2mhg=;
	b=bFpegPRycb0cuHXjw553+5hM4eWXNt1eqogD42G6/cuWshkjE9cMnk+xtInfNxblDBYR4q
	iacg2f1ssYpzNxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787047136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wbL1+SE+ksHe5t9mse0VA4gf4msWrjpt/QHOCY2mhg=;
	b=naOBDlcF22sqNkJv1THOrzJdpWw7JHr8JQqn6GtoGg/6rKdfxLVXnMXQXaNg+jWUu5TOMb
	rdw0Bxa9MZra6oxOuNIenctdAgi0/eepWP6rvv+QuQmS3J9EGviZuj4NYyPLCGkyAnLfLd
	T9C3cQCitNjtWwxASNUKDf5xjZI169w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787047136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wbL1+SE+ksHe5t9mse0VA4gf4msWrjpt/QHOCY2mhg=;
	b=B3Ir3s47y1lu855PobnpqXFA1V79iF1I1/lMQPbHK797ihoF+nD9CK487ubizl1W2CHi4x
	3wIHQzezV8A1WJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D526022BA;
	Tue, 18 Aug 2026 09:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XOJxM98shGqNdgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Aug 2026 09:58:55 +0000
Message-ID: <d11d3377-a4b3-45dc-b812-9dd06c8a2a38@suse.de>
Date: Tue, 18 Aug 2026 11:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] block: support nesting for blk-mq flag
 QUEUE_FLAG_SAME_FORCE
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <20260815173502.1185929-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260815173502.1185929-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_025906_879340_0BB4CE45 
X-CRM114-Status: GOOD (  18.47  )
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

On 8/15/26 7:34 PM, Nilay Shroff wrote:
> QUEUE_FLAG_SAME_FORCE is currently used when setting rq_affinity
> through sysfs as well as by UFS mediatek driver while configuring scsi
> parameters. A subsequent patch adding a latency-based I/O policy
> for NVMe multipath will also use this flag.
> 
> With multiple users able to set and clear QUEUE_FLAG_SAME_FORCE, the
> flag needs to support nesting so that one user clearing the flag does
> not inadvertently disable it for another user.
> 
> Add a nesting counter, q->same_force_depth, for QUEUE_FLAG_SAME_FORCE.
> The flag is set when the first user acquires it and the nesting counter
> is incremented for each subsequent user. Similarly, each user releases
> its reference by decrementing the counter. The flag is cleared only
> when the last user releases it and the counter reaches zero.
> 
> Preserve the existing sysfs rq_affinity semantics with a new
> q->same_force_sysfs flag. When userspace enables QUEUE_FLAG_SAME_FORCE
> by writing 2 to rq_affinity, mark q->same_force_sysfs as set and
> increment q->same_force_depth by one. Subsequent writes of 2 to
> rq_affinity while q->same_force_sysfs is already set are ignored, so
> repeated writes of 2 from userspace do not increase q->same_force_depth.
> Similarly, writing 0 or 1 decrements the q->same_force_depth and if
> nesting counter reached to 0 then clears the QUEUE_FLAG_SAME_FORCE.
> This ensures that multiple writes of 2 to rq_affinity do not require
> multiple writes of 0 or 1.
> 
> This change ensures that sysfs interface retains its existing set/clear
> semantics while also allowing other kernel users to hold or release
> QUEUE_FLAG_SAME_FORCE.
> 
> Added two new APIs blk_mq_same_force_set() and blk_mq_same_force_clear()
> to set and clear QUEUE_FLAG_SAME_FORCE respectively. Also, updated
> existing call paths using these new APIs which toggles
> QUEUE_FLAG_SAME_FORCE.
> 
Yikes. Is this really necessary?
The flag can be set by different subsystems/drivers, sure, but from
what I've seen each user is mutually exclusive.
I'd rather disallow modifying this flag if the driver sets it, to
avoid upper layers or sysfs modifying it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

