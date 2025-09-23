Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48596CAC5A7
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 06:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9V+iZpd413Ovq8xhnE5LMvkqF9CJl/ZRPnPn0a4qLw=; b=q2Eb1Tycc4W3mHW+/bcyvQwbE8
	0NEhr++iRcdbouA7txH2pZP3tiwHpImw6NB0seQf3VtcK3X0SoxFSh+4UN9f3hclHdy+OtQ4/FmHa
	Z012rCoAKFbtRNF9oKjZyyPurhRHSjznGrrWSDksuG8G5C2UVJAHrgjNKTRPafJOOOaYjcExQh5z7
	HsKHAa2do63mjBvoiaTLd/t03Uow3F2wEH4r8QnlJBrnwF5B76prVS1Vf9SG5ZCkDoy4FwKdJqCr1
	dulzUNj523fQDjalEkF+AeNcFfORmAiYzETfa9cPGv8hAffMZqeU8+hG103JHjTZa8WunzXs7NUqq
	XxXspntQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0wXT-0000000CZVz-2yay;
	Tue, 23 Sep 2025 06:30:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0wXR-0000000CZVJ-11Gz
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 06:30:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8F2022367;
	Tue, 23 Sep 2025 06:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758609007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9V+iZpd413Ovq8xhnE5LMvkqF9CJl/ZRPnPn0a4qLw=;
	b=P9cjs3RtjFa7oPCxLy+6lH/0hO+P4ViGUgrsitRHNLdvI+u3Gp71cjOt279pgAkJOHZaip
	rs7wUdmjKZ/8jam/+1TAe2eUmz5dCKhVxtYr/tQcDEXyKFwfXhd+FFqlfX13qkc2OdsDlE
	XhHp5juSI8ZK4iqYWr4bClfLJLNzIHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758609007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9V+iZpd413Ovq8xhnE5LMvkqF9CJl/ZRPnPn0a4qLw=;
	b=g+pTHn7cJydwprBbLtojrFLpPU5esVcmseV5XfNkYrn0i9CbgpFpD4MatFiRCnEkzdlCp0
	gOnVtAJgvNeHVSDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758609006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9V+iZpd413Ovq8xhnE5LMvkqF9CJl/ZRPnPn0a4qLw=;
	b=XJtyYWaHaXgODPLzcr/WH5olQajQi+l1W8qp6W5fB1anlmeJ9U2Yl3erGgvxKXcrUzcmi4
	BmkBrxH1T/CEu5i+GJZjihfiIEHrJPoCaLP2L7LVYwgYJl6LShNtTVhO5Gic90PK9685UW
	jnnruMT1iycivulJzuo2x/qfGHmR4+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758609006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9V+iZpd413Ovq8xhnE5LMvkqF9CJl/ZRPnPn0a4qLw=;
	b=l93a8CEu6DLS7VU0HtMRe4sWq03oawAz7tHTd40YjoBMPawQNTOyo/7uGJCtuYtPWVc61Q
	TWVgiWevzfk4z7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8680132C9;
	Tue, 23 Sep 2025 06:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ira8Jm4+0mhBGwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 23 Sep 2025 06:30:06 +0000
Message-ID: <2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de>
Date: Tue, 23 Sep 2025 08:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250912115829.58669-1-hare@kernel.org>
 <20250922174149.GA14736@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250922174149.GA14736@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_233009_435874_26EB47A1 
X-CRM114-Status: GOOD (  17.26  )
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

On 9/22/25 19:41, Christoph Hellwig wrote:
> On Fri, Sep 12, 2025 at 01:58:29PM +0200, Hannes Reinecke wrote:
>> Switch to use recvmsg() so that we get access to TLS control
>> messages eg for handling TLS KeyUpdate.
> 
> That is a very spare commit message for a huge change.  Why did it not
> use recvmsg before?  I'm pretty sure there are some tradeoffs here.
> 
Well, main reason was that the iSCSI driver has been used as a template
for NVMe-TCP, and that one uses ->read_sock().

But technically the reason is that ->read_sock() is driven from the
ingress side; the callback is triggered for each skb received.
Which (theoretically) can drive down latency as the callback is
only invoked when data is to be processed.
Drawback is that we lose access to the control messages, as these
are only extracted by the recvmsg code, so we cannot handle any
specific control messages like TLS alerts or KeyUpdate messages.
And pacing of ->read_sock() invocation gets tricky with TLS,
as the TLS stream is overlaid on TCP segments, so the skbs
received by TCP are not the skbs seen by the ->read_sock()
TLS implementation (stream parser magic).

The recvmsg workflow has the benefit that we're getting full
access to the control messages, so we can handle things like
TLS alerts and KeyUpdate messages. And the recvmsg() call
is driven from the consumer side, so we can get a better
pacing between sendmsg() and recvmsg() calls, which is
particularly important for the NVMe-TCP workflow where
we need to wait for responses before we can continue
with sending more data.

Sadly all performance differences between those two
implementations are completely obscured by some
network buffering effects, so I haven't been able
to come up with a meaningful comparison here.

But I'll improve the description.

>> +static size_t nvme_tcp_ddgst_step(void *iter_base, size_t progress, size_t len,
>> +				  void *priv, void *priv2)
>> +{
>> +	u32 *crcp = priv;
>> +
>> +	*crcp = crc32c(*crcp, iter_base, len);
>> +        return 0;
> 
> And fix the whitespace damage while you're at it.
> 
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

