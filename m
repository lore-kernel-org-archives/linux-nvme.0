Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E7BCCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JF7G8YV+qX4oM+REL+J9uv0EDqVmR6RzkmUzp2y138A=; b=yGCk7evblLYuoEpw/3Hg8Yd2VZ
	GC0GpjJ0CCVI17gjzYASHW1F+LXAjaBWZtxvq6jth1V/f+brAd3xykfN9MiB7POh/3Xro4BqrqT3g
	7kFKCZrlMm4jiLbexPqcdJ0377ltQlqmHrNlYIzD35zD+nhHC8rf7PJK8uZ5eUfYeqRkhPZeXefxb
	CWReDsx/vbgnl/BTTvXYW8eirUQQmUx70EEhzYWmr8puRKix7W3Rg0MGdMP5x34Flw5FcdCzjYmS1
	LvKY4NcvQkE+UZJaYBwTmMIKJWtKO185rN1EL1BscqCGaiufoRvC/k461v92+80MIV2PM1OOXS0n1
	iDE4gu0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIUX-0000000C18v-3BKI;
	Tue, 04 Nov 2025 14:58:37 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIUV-0000000C13k-0gQr
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 14:58:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5377C1F387;
	Tue,  4 Nov 2025 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762268313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7G8YV+qX4oM+REL+J9uv0EDqVmR6RzkmUzp2y138A=;
	b=Xy/IbDoxRbVlG+X6a88sTa3F6+Dc7x96dwA+qgiPRD3Acd+0+MvwlttsWvoij2uFLDN8pb
	imWTW0As/9MFrJaERlfeUNZoBPMj4RE4FDrZ0T3OZUedcloB8xGXGimvRKrq1J+bwvrSyf
	vyZHGfJ4IJFvQC462GPqyCRTJdEaOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762268313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7G8YV+qX4oM+REL+J9uv0EDqVmR6RzkmUzp2y138A=;
	b=21UMorj5rUI6jz4lmL9BbUSX6zBKHBDaizdo0NPFAn28bUYmTYVP1P8FcHci5xUlMw5lyH
	yiWYlxX1MLGXuUBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762268313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7G8YV+qX4oM+REL+J9uv0EDqVmR6RzkmUzp2y138A=;
	b=Xy/IbDoxRbVlG+X6a88sTa3F6+Dc7x96dwA+qgiPRD3Acd+0+MvwlttsWvoij2uFLDN8pb
	imWTW0As/9MFrJaERlfeUNZoBPMj4RE4FDrZ0T3OZUedcloB8xGXGimvRKrq1J+bwvrSyf
	vyZHGfJ4IJFvQC462GPqyCRTJdEaOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762268313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7G8YV+qX4oM+REL+J9uv0EDqVmR6RzkmUzp2y138A=;
	b=21UMorj5rUI6jz4lmL9BbUSX6zBKHBDaizdo0NPFAn28bUYmTYVP1P8FcHci5xUlMw5lyH
	yiWYlxX1MLGXuUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E5C3139A9;
	Tue,  4 Nov 2025 14:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xleaCpkUCmlNawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 14:58:33 +0000
Message-ID: <0c7c6758-e7cf-449a-9055-55d694c1e1a0@suse.de>
Date: Tue, 4 Nov 2025 15:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv4 5/6] nvme-multipath: add debugfs attribute
 adaptive_weight_timeout
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, dwagner@suse.de,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20251104104533.138481-1-nilay@linux.ibm.com>
 <20251104104533.138481-6-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104104533.138481-6-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-CRM114-CacheID: sfid-20251104_065835_389033_F18829F4 
X-CRM114-Status: GOOD (  12.79  )
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

On 11/4/25 11:45, Nilay Shroff wrote:
> By default, the adaptive I/O policy accumulates latency samples over a
> 15-second window. When this window expires, the driver computes the
> average latency and updates the smoothed (EWMA) latency value. The
> path weight is then recalculated based on this data.
> 
> A 15-second window provides a good balance for most workloads, as it
> helps smooth out transient latency spikes and produces a more stable
> path weight profile. However, some workloads may benefit from faster
> or slower adaptation to changing latency conditions.
> 
> This commit introduces a new debugfs attribute, adaptive_weight_timeout,
> which allows users to configure the path weight calculation interval
> based on their workload requirements.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  1 +
>   drivers/nvme/host/debugfs.c   | 40 ++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/multipath.c |  7 ++++--
>   drivers/nvme/host/nvme.h      |  1 +
>   4 files changed, 46 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

