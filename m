Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFFDCA5FC4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+g55zivLAPi5Ym2/z1B2f2BHuoLUMbgfcwJXaLB5Tc=; b=i2w4QPaDxLWfVoBFA41bu56frL
	zkWwAnmDUiOOWAt1jEvLs/YfXVcov1VWFwCs1th/RExDtOziP7IUEyOHbFx+mkjgz+J9pc1oSytTM
	sCUgTro+Fjetlav/iEpnP8QzFqOX1psItI6FOKYskQRLh+Lm/5Cc+bHwun/GZSfjVZdZ3buqiXmlf
	xMO9df5XwNRyLySTKC+93pRV0G8/4pG3/FZPKr9036d06KeuIWzKZFykHDZMPiQIxUPQI/Nb9L6Pg
	4h5tLmMTd0bkZHSEki4LOSJVtifrkknlsPvVUSuGLIXpazJ5iQGg8A60RFQmY9eCdh/uX7oGF5Rcd
	7ecs9geg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCZkA-0000000BB9T-3wpt;
	Fri, 02 Oct 2026 09:39:54 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCZk8-0000000BB8V-0T8P
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 09:39:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3313121E26;
	Fri,  2 Oct 2026 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790933986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+g55zivLAPi5Ym2/z1B2f2BHuoLUMbgfcwJXaLB5Tc=;
	b=vFiDZwygbS92eNQhFX3Zbjj4kfjn0MQVOuAlq+hyPyPkLNlDmTSMdq/2/ewjaTMqfEO4CI
	sND+bmIHRdz1to6koDszPz7WHdyjwwol5E8h9L6XlO/ptRFqtsdtZclseHf5YJ++F86ili
	fRdjcWwnGaQUdxeDaC4DDppKpWs0xh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790933986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+g55zivLAPi5Ym2/z1B2f2BHuoLUMbgfcwJXaLB5Tc=;
	b=FGNbjVkhgO7HDaCuiBJS0Km1f6OcJvPjJnDI1YRx2ftGKeNP4huVJWQ5coOzFSKI7+NWew
	CUI8x4yRD6R83xCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790933982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+g55zivLAPi5Ym2/z1B2f2BHuoLUMbgfcwJXaLB5Tc=;
	b=oemxnBZMmt67bCICoTWOw7JE8EPt08JjlcCXWEwhBuFMIYP2bPJZ7NQYeaxGyfI6WfuBq6
	y7zgiX6mJEjFvmBlMuH6SGNZKjP07ahIoctDVJ3qLqH4IIc0axS90iZAqS8FRwnCNhxZM7
	qZDYY22uqWRtI67UZ3+BTNZUWomrTKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790933982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+g55zivLAPi5Ym2/z1B2f2BHuoLUMbgfcwJXaLB5Tc=;
	b=ASr+/e7OtJzzJsWtYFL7zbD/yBE0zmxV1ctTE+1a98syU2/7BJhv4uqsSCz7mMQmn6ljzw
	NAELqHslU1nXJRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD07813BEC;
	Fri,  2 Oct 2026 09:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KheGLN17v2r3BwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 02 Oct 2026 09:39:41 +0000
Message-ID: <4a4e228f-7143-4d5a-b773-2c6238852503@suse.de>
Date: Fri, 2 Oct 2026 11:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] nvme-multipath: add fail_if_no_path sysfs
 attribute
To: Krishna Iyer <kiyer@crusoe.ai>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com, saravanand@crusoe.ai, sjpark@crusoe.ai
References: <20261001094857.74567-1-kiyer@crusoe.ai>
 <20261001094857.74567-3-kiyer@crusoe.ai>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261001094857.74567-3-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,crusoe.ai:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_023952_357919_DB48A894 
X-CRM114-Status: GOOD (  18.85  )
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

On 10/1/26 11:48 AM, Krishna Iyer wrote:
> When no usable path exists, I/O on a multipath namespace is queued
> until a path returns. With ctrl_loss_tmo=-1 that can be forever:
> during a long fabric outage any process waiting on the I/O is stuck in
> D state. We hit this on virtualization hosts, where a SIGKILLed VM
> process cannot exit while draining I/O to an unreachable NVMe/TCP
> target.
> 
> Nothing can fail this I/O without tearing something down: controller
> deletion takes every namespace on the controller with it.
> 
> Add a fail_if_no_path attribute on the ns-head disk: a persistent
> per-namespace policy to fail parked and newly arriving I/O instead of
> queueing it when no usable path exists. It is the namespace-scoped
> counterpart to the controller-scoped fast_io_fail_tmo: the trigger is
> an event userspace observes (a consumer known to be gone, for us a
> SIGKILLed VM the host must reap), not a duration picked up front, and
> sibling namespaces behind the same controllers keep queueing and ride
> out the outage.
> 
> A CONNECTING controller stops counting as an available path, and with
> no controllers left the policy overrides the delayed_removal_secs
> queue-if-no-path window; the two are opposites, so fail_if_no_path takes
> precedence when both are set. ANA change and controller resetting still
> queue, since both are transient. Controller state is untouched and
> reconnects continue. Like dm's fail_if_no_path, the policy is transport
> agnostic.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
> ---
>   Documentation/ABI/stable/sysfs-nvme | 16 +++++++++
>   drivers/nvme/host/multipath.c       | 50 +++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h            |  2 ++
>   drivers/nvme/host/sysfs.c           |  4 ++-
>   4 files changed, 69 insertions(+), 3 deletions(-)
> 
I do get the problem, but I think that 'fail_if_no_path' is a misnomer.
Problem is that we already have a 'QUEUE_IF_NO_PATH' setting, so 
'FAIL_IF_NO_PATH' really sounds like the inverstion of that.
Only that it isn't.
Maybe rename to 'FAIL_ON_CTRL_LOSS' to make it clear that the two 
settings really describe different use-cases?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

