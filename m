Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52EEC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nzg7mG2tzqYQWADFYsYA4s0IahSoZhlLxp2ix9ybtxM=; b=wgyritCGSgQX/StJxemkhV+NYV
	WHHRd/NJ0LnWlg/jGp6092DlqFVVBVyrRmaIDdQhHCX95EGsC0b4RkDk3w7aCJQoJ3sVH2bijYhRy
	JKikUaCPwC8WvPv4ts4J4I4PCa2teb39cq/T+CNrNGFrfgK+D7XfyQ1LMRg5SQfmkD6JgcvqlY+Wz
	+dUvZ9Oo/ge5Mbn4nR3a45ePJ/nyXDwA+q7FMarQVqW7M/M14dY6KeDDC03Qj83FIg207v/jrzy3/
	D0RaQ7TMUXcvbXOHAoULAdtchO0nlkRLNhJx4S93RNiXWUOnURdLjBrp+nCuaCseiwtHwPrPJFLQE
	lZb8l5PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxAQ-00000001mqg-1hst;
	Wed, 19 Jun 2024 15:24:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxAK-00000001mp7-3uBP
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 15:24:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0FCC1F7EA;
	Wed, 19 Jun 2024 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718810642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nzg7mG2tzqYQWADFYsYA4s0IahSoZhlLxp2ix9ybtxM=;
	b=c1XWfhfDcEkIbk9y195gOK+LcmMvKf14DBuTi+HSmh5vC4pts9LY06ws4mxojl+BLNZDO4
	xX+/RsDWZWQ3ngBHOgHyrYoBAHSKIVF9Xzfd9/A+xTsmyT2/Bn+KYWyhq40dYQ9UCTK+LQ
	SzlwMMzCUDRRb1QRsC1weLOlwve+VzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718810642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nzg7mG2tzqYQWADFYsYA4s0IahSoZhlLxp2ix9ybtxM=;
	b=HWbj+oEPHLgw8jgp0zcoCikU6Wuclep+shbJE/fI5nGAzCe65R+YEmE46X/K1iWdq2/BmQ
	fLV0Lxa3A1tELgDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c1XWfhfD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HWbj+oEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718810642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nzg7mG2tzqYQWADFYsYA4s0IahSoZhlLxp2ix9ybtxM=;
	b=c1XWfhfDcEkIbk9y195gOK+LcmMvKf14DBuTi+HSmh5vC4pts9LY06ws4mxojl+BLNZDO4
	xX+/RsDWZWQ3ngBHOgHyrYoBAHSKIVF9Xzfd9/A+xTsmyT2/Bn+KYWyhq40dYQ9UCTK+LQ
	SzlwMMzCUDRRb1QRsC1weLOlwve+VzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718810642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nzg7mG2tzqYQWADFYsYA4s0IahSoZhlLxp2ix9ybtxM=;
	b=HWbj+oEPHLgw8jgp0zcoCikU6Wuclep+shbJE/fI5nGAzCe65R+YEmE46X/K1iWdq2/BmQ
	fLV0Lxa3A1tELgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 885BE13668;
	Wed, 19 Jun 2024 15:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hv7HHxL4cmbDIgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Jun 2024 15:24:02 +0000
Message-ID: <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
Date: Wed, 19 Jun 2024 17:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240619145958.GA2254@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0FCC1F7EA
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_082405_335947_144E3278 
X-CRM114-Status: GOOD (  13.53  )
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

On 6/19/24 16:59, Christoph Hellwig wrote:
>>   	if (wq_unbound)
>>   		queue->io_cpu = WORK_CPU_UNBOUND;
> 
> None of the above computed information is even used for the wq_unbound
> code.  This would make a lot more sense if the above assignment was in
> the (only) caller.
> 
> Yes, that probably should have been done when merging the wq_unbound
> option (which honestly looks so whacky that I wish it wasn't merged).
> 
Ah, you noticed?

This patch is actually got sparked off by one of our partners notifying
a severe latency increase proportional with the number of controllers.
With a marked increase when (sw) TLS is active; they even managed to run
into command timeouts.

What happens is that we shove all work from identical queue numbers onto 
the same CPU; so if your controller only exports 4 queues _all_ work 
from qid 1 (from all controllers!) is pushed onto CPU 0 causing a 
massive oversubscription on that CPU and leaving all other CPUs in the 
system idle.

Not sure how wq_unbound helps in this case; in theory the workqueue
items can be pushed on arbitrary CPUs, but that only leads to even worse
thread bouncing.

However, topic for ALPSS. We really should have some sore of 
backpressure here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


