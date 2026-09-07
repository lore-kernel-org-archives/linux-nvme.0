Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18421C79FA0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6BAHzKGk625VaU0VDbi12RwRs6cH60WZt4A22q/m/k=; b=f+5U9MNFmv9CLIJNwUOKatc3kP
	5CI+SnHzN/2JIxkpscAlRLd+C7TTZ2s68hpg+Cwi1cgnag1J27Xz5nTw8wC18iNfkZhxI0uHK2mu6
	S4dsfR8m4aGOtFERTtIkXLOgfbKbpdawsGcEobiHmniLNTCKeUuj8fOUBczeoFRenVaqQDTvIuWBp
	5AIV8GbNXyOLkDy75IDrWG7E8OedFjfrRQdfUYXLxJwzXlw9Ep7UHVO4f2VRXu/3T0G/jSq3CNe0F
	h1rR9uWNKkkbWS83fJPL1DARRwEfBr45Hc7CSuDvNKfHSu82RIcpmsfJgjt6iqInZ7U9KRYYknm3K
	9w5RyGTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3aNq-000000073N7-1HXI;
	Mon, 07 Sep 2026 14:31:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3aNo-000000073LX-1OpC
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 14:31:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 322A52196E;
	Mon,  7 Sep 2026 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788791492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6BAHzKGk625VaU0VDbi12RwRs6cH60WZt4A22q/m/k=;
	b=PHdIYf96dLO5TQEu5MxjRI9GS9XXk3s887DtiqMfDnM+M7kMk+Ihuf/M4wF0uf2DBW642G
	e48+iFCbNK7e6OQ7DRxfWfZZepU+NjuAthtvk9fYa5RMLn+8C91iK5GVEJcpmSajXcblZv
	eh7gAfkHp4rIxTLYhYFj5lgPQOJbWPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788791492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6BAHzKGk625VaU0VDbi12RwRs6cH60WZt4A22q/m/k=;
	b=hvyg17em8UXFun3T/GY0dm6Xna9J6qz9bGHEiOYaJqJov1sU7joCPuX5P0TBm8QqFWRjAu
	Ofr4x6KtXzpLHQBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mTxj7yq0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0fShp0NU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788791488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6BAHzKGk625VaU0VDbi12RwRs6cH60WZt4A22q/m/k=;
	b=mTxj7yq0uH8Yo3J0jhrSiI3tys2b2xBBC2Dcqzo1u9/ICD1ZP77pGH6wwcqVhhYwTTcozO
	3uBDYT3hCtUTzvgFeJeNlwuCKEnECxCAjKOMm72t60Q1VgB283WilBgYtB4mBFfmx+0HOy
	8HXs+GKIaV9IKIbs3GSXCQX+knQnnH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788791488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6BAHzKGk625VaU0VDbi12RwRs6cH60WZt4A22q/m/k=;
	b=0fShp0NUXYSWt0TcmEx474mkrEd1D582YiLquJDuvV2OA2ksxAeIUE0PgFLv3N2bZ6N9xE
	LLEV+jDeDqIVS8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E0D1339B;
	Mon,  7 Sep 2026 14:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QIbgK7/KnmpPKgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Sep 2026 14:31:27 +0000
Message-ID: <e6397f5d-b565-4219-95ed-4ace5f23c37d@suse.de>
Date: Mon, 7 Sep 2026 16:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, dwagner@suse.de, kanie@linux.alibaba.com,
 jmeneghi@redhat.com, randyj@purestorage.com, martin.petersen@oracle.com,
 john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
 <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com>
 <2a03f032-3fed-454c-a960-ac332b4c3fed@grimberg.me>
 <77d16701-c829-4fd7-bc4f-8fb51138d9d6@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <77d16701-c829-4fd7-bc4f-8fb51138d9d6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 322A52196E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_073140_516605_59811DB6 
X-CRM114-Status: GOOD (  15.43  )
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

On 8/31/26 8:31 AM, Nilay Shroff wrote:
> On 8/31/26 3:23 AM, Sagi Grimberg wrote:
>>
>>
[ .. ]>> I would like to avoid introducing this as a config knob if it is
>> always behaves better.
>>
>> What do others think?
> 
> Good point, however my view is that we may not want to immediately 
> deprecate or remove queue-depth/round-robin. Based on my testing so
 > far, across a variety of workloads, including intermittent packet
 > loss, the latency policy has performed better than queue-depth and
 > round-robin. However, I would like to see it evaluated against a
 > broader set of workloads and scenarios, including cases that I > may 
not have considered/known.
> 
> Once we have broader evidence and establish that latency consistently 
> performs at least as well as queue-depth/round-robin without any
 > significant downside, then I think it would be reasonable to consider
 > deprecating those policies and  keeping only numa|latency.>
> Until then, I would prefer to keep queue-depth and round-robin as 
> baseline policies against which we can compare the latency policy.
> 
> But let's wait and see what others think.
> 
I think that we can deprecate round-robin now that we have
queue-depth and latency.
But I also think that we need both, queue-depth _and_ latency as both
latch on different properties, and there are use-cases where one might
have workloads which prefer one or the other.

Having a config option to select the default (and possibly disable some
I/O schedulers) would be completely fine with me, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

