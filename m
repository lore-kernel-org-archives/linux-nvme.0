Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E619C021BB
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fw4Fd+6HSYd5NJSuD7z9oLB/kBQO1MCXob4U6dVAS3w=; b=bnIoPHJfqqC7RCF6tUUws4tIx6
	mmZ6nNit7+HoAqC4DBQVSH4+pi5+VdheDMD0avumgKAcp3+1JlP8yP4yUKl60jgZapW4/zT9J+4/M
	lSSkofC0uZnzmPnwLmYnp76mxjO7QvWG2P5ytiUJ0cftdlbK5q6OJ2fTxAngnzJV5KZM06NbfB5In
	bVFDWWAyttlOwG4GcsPiy2Fb0y5OkpJVEpM1IdDlqOuMyMTp8a4w8iXZ+IqY6obANP98IAtpG2ZRq
	RSMZTPGhrOBSn2uLqwiq+dk91P9eyx9ctmOClMFY4mNaShDb9YxtnyAzG9rJHuc9cuu9d1d69st6b
	9h+l0JZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbrZ-0000000EXdl-2GIZ;
	Mon, 24 Feb 2025 17:03:25 +0000
Received: from [2a07:de40:b251:101:10:150:64:1] (helo=smtp-out1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbrW-0000000EXcf-40bx
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 17:03:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B2F6211A7;
	Mon, 24 Feb 2025 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740416601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fw4Fd+6HSYd5NJSuD7z9oLB/kBQO1MCXob4U6dVAS3w=;
	b=QpKUdAjaGnbjaJatL0cJmu/qn7XrZCTh4C1T59zo0P9jScvmxHZEUGMQnD1/LDqFMYjQod
	QoQ3KE6tjjgcO+3vUjzBUrai2FcXW1UPHXx3UsWMAXX5i/9nm8YyRcaGRc2/xtjFXf2m4V
	RQl0LECBHnV0ZfdW4Hgr9YoVR1qp88U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740416601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fw4Fd+6HSYd5NJSuD7z9oLB/kBQO1MCXob4U6dVAS3w=;
	b=0I2JdrEnSyZ2dPYul1Em069aymy5m2axE58waU2SHNWEByFlSiDHOhzjLQpHqFbXoF887q
	4NQmiCYTLWCbF8Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QpKUdAja;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0I2JdrEn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740416601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fw4Fd+6HSYd5NJSuD7z9oLB/kBQO1MCXob4U6dVAS3w=;
	b=QpKUdAjaGnbjaJatL0cJmu/qn7XrZCTh4C1T59zo0P9jScvmxHZEUGMQnD1/LDqFMYjQod
	QoQ3KE6tjjgcO+3vUjzBUrai2FcXW1UPHXx3UsWMAXX5i/9nm8YyRcaGRc2/xtjFXf2m4V
	RQl0LECBHnV0ZfdW4Hgr9YoVR1qp88U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740416601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fw4Fd+6HSYd5NJSuD7z9oLB/kBQO1MCXob4U6dVAS3w=;
	b=0I2JdrEnSyZ2dPYul1Em069aymy5m2axE58waU2SHNWEByFlSiDHOhzjLQpHqFbXoF887q
	4NQmiCYTLWCbF8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5CF913332;
	Mon, 24 Feb 2025 17:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60qTJlimvGdLegAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Feb 2025 17:03:20 +0000
Message-ID: <c0b813ab-c39a-4cf6-bbb4-abdd3bdf8d1a@suse.de>
Date: Mon, 24 Feb 2025 18:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hare@kernel.org
References: <20250214190012.311960-1-mlombard@redhat.com>
 <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
 <D80R3XYM3OZ0.K8YLZIQ7XUDW@bsdbackstore.eu>
 <0e3af565-f8e6-4647-89c3-6757f6bae3a6@suse.de>
 <D80TVRHC1LFG.RHYVKMPXX3DF@bsdbackstore.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <D80TVRHC1LFG.RHYVKMPXX3DF@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B2F6211A7
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_090323_143939_70259CFB 
X-CRM114-Status: GOOD (  14.84  )
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

On 2/24/25 17:48, Maurizio Lombardi wrote:
> On Mon Feb 24, 2025 at 5:04 PM CET, Hannes Reinecke wrote:
>> I really wouldn't be doing that, as we need to terminate the queue upon
>> fatal error and don't really want to delay that (eg by waiting for the
>> transfer to finish) and
> 
> I did some tests and it seems to work with MSG_DONTWAIT as well.
> 
> I am just wondering if calling kernel_sock_shutdown() could
> in some cases race with MSG_DONTWAIT, preventing the packet from
> being effectively sent.
> Not a big problem anyway because, as you said, it's a kind
> of best-effort thing.
> 
'xactly.
If in doubt we should prefer latency over correctness; and especially
when running over a more complicated network setup (or doing TLS) it's 
anyone's guess if the entire stack is still operational by the time
we're trying to send the c2hterm.
Part of the reason why it wasn't implement initially I guess :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

