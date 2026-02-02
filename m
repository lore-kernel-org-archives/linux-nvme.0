Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72315E7FDE0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=; b=Kxm5QrMf0gLmLRaQFj1YG7W3HI
	jb9W7+YZRrssaLzjJGb7xxlI63prDN9ZqWPJkQ2bDjKekkKKJh27Q/KCzssGLFjnHvn+UWRYipp3Q
	4J2SkGseF7J2njYot1DgHGut5evHd7ewzIYV7xgJ2wAdZJUQSXuhIao24etxZA/pDZI8L7QBvF2Bs
	g+W8ha0pTZYKE/9F3s1g+qItAgszkMddXMCKMZwM0PP0Yhd+idYUEsv1PNXTxNPw5d8GDbFK7y5gE
	dX8BvzimwiAFGIYoFQ9YSp9UjpsQmwOvG51qJeYYgJPBOgihCXQX4tGXSxTYSnvvcP02+aUi8inAA
	38m/l79g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn33e-00000005kBg-12SB;
	Mon, 02 Feb 2026 23:10:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn33c-00000005kBJ-1kmR
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 23:10:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D2795BCC6;
	Mon,  2 Feb 2026 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770073810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=NY6cDX1fRxXC91VFhwyMcSrqNmpZyKXVEoJpDx6QoPAk18sOLOn6JL5jdXdQKwpFrNTA07
	nAEH8CLvLIHhMz+rp49khXMwH0L00mnN3DsNe4Q7mr6LoQRxuN2sPlbAjRBtlmtbu2THTz
	/zNaHuLyLkPEfCs56XtTi0gWOPIC3dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770073810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=8NFBPb4nVpHm63yWrEnWj+nh7OhDZdeuEBHeFaUK84+np1CG2kS5CLPUS79v6AQ7Vp74kR
	5CIczzZJ9hDvK8BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770073810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=NY6cDX1fRxXC91VFhwyMcSrqNmpZyKXVEoJpDx6QoPAk18sOLOn6JL5jdXdQKwpFrNTA07
	nAEH8CLvLIHhMz+rp49khXMwH0L00mnN3DsNe4Q7mr6LoQRxuN2sPlbAjRBtlmtbu2THTz
	/zNaHuLyLkPEfCs56XtTi0gWOPIC3dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770073810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=8NFBPb4nVpHm63yWrEnWj+nh7OhDZdeuEBHeFaUK84+np1CG2kS5CLPUS79v6AQ7Vp74kR
	5CIczzZJ9hDvK8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F91C3EA62;
	Mon,  2 Feb 2026 23:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bl7sNtAugWnuNAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Feb 2026 23:10:08 +0000
Message-ID: <2257486e-a52d-4b11-bf09-e2adedf2decb@suse.de>
Date: Tue, 3 Feb 2026 00:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Bart Van Assche <bvanassche@acm.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <923b3b4d-a84e-4a19-8767-6bca59204ff1@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <923b3b4d-a84e-4a19-8767-6bca59204ff1@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_151012_610569_36ED9EC8 
X-CRM114-Status: GOOD (  12.49  )
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

On 2/2/26 18:27, Bart Van Assche wrote:
> On 2/1/26 9:06 AM, Hannes Reinecke wrote:
>> While we could easily terminate the controller, the specification
>> also requires us to terminate all outstanding commands.
> What specification is the above referring to?
> 
> Regarding terminating outstanding commands, doesn't how to do this
> depend on the storage protocol? Isn't the recommended procedure for
> NVMe to delete and re-create all I/O submission and completion queues?
> This procedure doesn't require support in the block layer for aborting
> individual commands.
> 
Sure, all drivers/subsystems implement a similar mechanism. But this is
pretty much implementation specific, and typically wrapped into the
device teardown path.
But that typically also involves tearing down and re-creating the device
node which doesn't lend itself for some configurations.

This proposal is to ensure that all I/O is flushed from the device
without having to reconfigure anything; typical use-case would be
when this device is used as a backing device for a nvmet namespace.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

