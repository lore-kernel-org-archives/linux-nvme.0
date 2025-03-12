Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6411DC28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PI/V00Rr6DPJrc/FGnbrXOU9pvoeGLpPcjdVxGwPVk=; b=vEJtFqppuvNs6Ec/MawU9BlmhZ
	c4lrFb4jTLF+peZ+vnfC/Q3x72IDITYjgh2onsTM+i6jroY5pY6YqmpEglUiQVZXvTbHFYHoTznqH
	Hhos5Wo3xfLdUTUaA7wNEbAXVQjL0B7yRVOlcIFcRNGyIedF9YZbepmarCauD3vzDmF0MGxNJz8aZ
	BMVAKTCCdnsviDnTrigBDAktwkOt72krYM+d912SqB8t+Pd80bk3UYA30KzmJR99uknOXRCyCGu4J
	pPVMtDWC337QtL+KiSKLN0okjf/+eM5ssxveDlAacqc3vpBOBgWY7eBgctS3wP74BLB0Ck2al4cjN
	NTUg6Tmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHEa-00000007o2U-1IPJ;
	Wed, 12 Mar 2025 08:14:36 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHEW-00000007o0y-3kPx
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 08:14:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B66721169;
	Wed, 12 Mar 2025 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741767269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PI/V00Rr6DPJrc/FGnbrXOU9pvoeGLpPcjdVxGwPVk=;
	b=R0a+0S7c5EMg2MuaSOnSeuwypRw/uyl58Bi+44DNvLk0AixdRMNssruiZ3R9Gz8M0BpoIl
	oRTBxm89wLqlZkc5ms+nlkhid0Pt6kESs32xsUrC5YW9uzWdJao4oY1IZ9in4IBiAE/9+7
	yzf+VbALP39UrFmL1IhXf63ci9jdAGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741767269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PI/V00Rr6DPJrc/FGnbrXOU9pvoeGLpPcjdVxGwPVk=;
	b=ahB2FpPNwvRc4acjDCYuf1rfpec4QYgT2VtKRMA1vNa6rGCy0ni5J2JqVpMlNMZl8Ci9Hx
	QF/DQBBWSythAuDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741767269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PI/V00Rr6DPJrc/FGnbrXOU9pvoeGLpPcjdVxGwPVk=;
	b=R0a+0S7c5EMg2MuaSOnSeuwypRw/uyl58Bi+44DNvLk0AixdRMNssruiZ3R9Gz8M0BpoIl
	oRTBxm89wLqlZkc5ms+nlkhid0Pt6kESs32xsUrC5YW9uzWdJao4oY1IZ9in4IBiAE/9+7
	yzf+VbALP39UrFmL1IhXf63ci9jdAGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741767269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PI/V00Rr6DPJrc/FGnbrXOU9pvoeGLpPcjdVxGwPVk=;
	b=ahB2FpPNwvRc4acjDCYuf1rfpec4QYgT2VtKRMA1vNa6rGCy0ni5J2JqVpMlNMZl8Ci9Hx
	QF/DQBBWSythAuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 665C21377F;
	Wed, 12 Mar 2025 08:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vRwtF2VC0We3eAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Mar 2025 08:14:29 +0000
Message-ID: <405d3d34-7129-4a1c-8429-cfc6462f1ceb@suse.de>
Date: Wed, 12 Mar 2025 09:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: avoid inline sending when handling R2T PDUs
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250307132802.111513-1-hare@kernel.org>
 <20250307132802.111513-2-hare@kernel.org>
 <Z9CDs7Vhl6R1aVFM@my-developer-toolbox-latest>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z9CDs7Vhl6R1aVFM@my-developer-toolbox-latest>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_011433_081311_8C0D30A1 
X-CRM114-Status: GOOD (  14.16  )
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

On 3/11/25 19:40, Chris Leech wrote:
> On Fri, Mar 07, 2025 at 02:28:00PM +0100, Hannes Reinecke wrote:
>> When handling an R2T PDU we should not attempt to send consecutive
>> PDUs as we are running from an softirq context, and sending PDUs
>> from the receive context will mess up latencies.
>> So just queue it and let the io_work workqueue function do the work.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
> 
> Am I missing something, or does this patch not actually change anything?
> With sync=false nvme_tcp_queue_request will queue io_work, so what is
> removing that flag and open coding in handle_rt2 accomplishing?
> 
Yeah; actually I wanted to reduce the complexity of the conditional in
nvme_tcp_queue_request(), and to emphasize that r2t handling should not
start sending PDUs.

Probably better to modify the patch description.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

