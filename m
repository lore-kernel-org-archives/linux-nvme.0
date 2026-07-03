Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7635C43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2yEE9aSuAYNTlLUERCCbpWasGhGYL1h93kMurCCK5q8=; b=3oRMmKDPRHh8sXZMq/DbZEV2xJ
	juQXR/3VZIGM8YmYiJkpd5axMBjn9fNyF+noMfPUIAaRwgQs96CWhe5zm4Hu3lrlRLsofylqlxe7b
	gBJOC4psqSfZ5StQMDr1wHf3lUHdHVeuRmaNS6LmSiv35LO3noSdfp1hiNqRE2T3FftWoAAnQYFbm
	XOpfOQDZW86aTssIh4Txb4LhsIkeSqRbv/91zj8Q7de0T3Reh64/x2aI1JbveSQALbOFoc1nUAQkI
	XhUVnJgYBscEj++A6mJvuj6OyBZllvtOmopuKcyor7SA0DKfRbDWuKm+nib8v2od8ISSsQAo0smw/
	dJXhTkEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXRz-00000006Afa-413d;
	Fri, 03 Jul 2026 06:32:35 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXRx-00000006Aen-0yQ8
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 06:32:35 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B9B174755;
	Fri,  3 Jul 2026 06:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783060351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yEE9aSuAYNTlLUERCCbpWasGhGYL1h93kMurCCK5q8=;
	b=d338gZdkqAKEEFlDtJTU6+rbYNlQu9x81o3vIcF3muPGZg/BFZB5GWmEwYxBslbS4KX/jc
	yQWK7ZCQYYAxhoeS7COhESdnNIOQWTV81aqgmyT/BV1uushHc7cGMTWkmPFQwFNaO1KKRu
	MigIE3c9pTtvs/LgVJoI98yhFu/Ia8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783060351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yEE9aSuAYNTlLUERCCbpWasGhGYL1h93kMurCCK5q8=;
	b=Se+eS5OzN8oYGWhaPv5WLIPg1mGcL3nOa62lLci62Hc51lpPjzpBItVxTzUel5wKvIOIua
	JuYhlSEAOZXbGwBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783060351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yEE9aSuAYNTlLUERCCbpWasGhGYL1h93kMurCCK5q8=;
	b=d338gZdkqAKEEFlDtJTU6+rbYNlQu9x81o3vIcF3muPGZg/BFZB5GWmEwYxBslbS4KX/jc
	yQWK7ZCQYYAxhoeS7COhESdnNIOQWTV81aqgmyT/BV1uushHc7cGMTWkmPFQwFNaO1KKRu
	MigIE3c9pTtvs/LgVJoI98yhFu/Ia8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783060351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yEE9aSuAYNTlLUERCCbpWasGhGYL1h93kMurCCK5q8=;
	b=Se+eS5OzN8oYGWhaPv5WLIPg1mGcL3nOa62lLci62Hc51lpPjzpBItVxTzUel5wKvIOIua
	JuYhlSEAOZXbGwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FB7779AA;
	Fri,  3 Jul 2026 06:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lhZN35XR2q7RQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 Jul 2026 06:32:30 +0000
Message-ID: <ef9a4e21-a0ec-409b-aa11-fb47c535ae77@suse.de>
Date: Fri, 3 Jul 2026 08:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme: add ABI documentation for host sysfs
 interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260702095541.1145128-1-kanie@linux.alibaba.com>
 <20260702095541.1145128-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702095541.1145128-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_233233_416353_31778545 
X-CRM114-Status: GOOD (  11.19  )
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

On 7/2/26 11:55 AM, Guixin Liu wrote:
> Add Documentation/ABI/testing/sysfs-nvme documenting all NVMe host
> sysfs attributes, covering controller attributes under
> /sys/class/nvme/nvmeX/, namespace attributes under
> /sys/block/nvmeXnY/, and subsystem attributes under
> /sys/class/nvme-subsystem/nvme-subsysX/.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v1->v2:
>   - Group all TLS attributes together (move tls_key and tls_mode next to
>     tls_configured_key and tls_keyring).
>   - Reorganize the file by device class (controller, namespace,
>     subsystem), keeping related attributes grouped within each class.
>   - Split the combined passthru_err_log_enabled entry into separate
>     controller and namespace entries.
> 
>   Documentation/ABI/testing/sysfs-nvme | 450 ++++++++++++++++++++++++++-
>   1 file changed, 440 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

