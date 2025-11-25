Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C8FD0E6CD
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6H3ZohGhsJTuXJwPtJPtAzAFvIuUq1M/+91P5tuAAAM=; b=M8QS1Utgx+lEjL0S4dCVDcjiv2
	P1M1bnuEnNRo64CkWHzfbMQESbgX2TRmlBW+DwGUWAtmCfCLSD8zUSARlK+qK3yZhsIul1rvOp7Jh
	m8jES5qUPKqlVRlukbMz8JXsWT6ivT41dvtg+xnM3eNkXlvhTTxChnJ53Er0vtdDNygWQp74wKV+W
	dXsXN2KvyWdIsfoXB3MINepROqGwZTKY/zi11o1V6S0642g9dM8WaWxaSE86vhmc+S/NZO/SkCcGc
	7HEsHGQrlwJyyuwHIfEMGc8Y3oezOGlekKQHx9omGPNpavdygpAYxNZu4v5pJyksLy1xoEpKdA96U
	gnOsK55w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsEz-0000000DHql-1MDo;
	Tue, 25 Nov 2025 12:33:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsEw-0000000DHqC-13lt
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 12:33:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 843325BE71;
	Tue, 25 Nov 2025 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764074026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3ZohGhsJTuXJwPtJPtAzAFvIuUq1M/+91P5tuAAAM=;
	b=uLChw0LO71V8jndqtzmCZ7btu5AMbJbgubtEdv0GIKDaqoHjwVDgBBqkT80YhxrmY41/3A
	I4NaNNP9hPTA9aNe+m2aMs1ITNji68siNBFjSprR8c9yh5KSLeApJ3dzK7yNnOw6WmJMre
	sJAj3AD6gk99KhiMA7rWm6GZLKI/2Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764074026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3ZohGhsJTuXJwPtJPtAzAFvIuUq1M/+91P5tuAAAM=;
	b=BWJrJ9zBNbn0awaKiCsT2NIXmz/r5xo6ywZ8pzCZ6GPksVfOP9fK57rWvgFjYSJi70Lo8D
	lsHJmjos8g2rsjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uLChw0LO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BWJrJ9zB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764074026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3ZohGhsJTuXJwPtJPtAzAFvIuUq1M/+91P5tuAAAM=;
	b=uLChw0LO71V8jndqtzmCZ7btu5AMbJbgubtEdv0GIKDaqoHjwVDgBBqkT80YhxrmY41/3A
	I4NaNNP9hPTA9aNe+m2aMs1ITNji68siNBFjSprR8c9yh5KSLeApJ3dzK7yNnOw6WmJMre
	sJAj3AD6gk99KhiMA7rWm6GZLKI/2Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764074026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3ZohGhsJTuXJwPtJPtAzAFvIuUq1M/+91P5tuAAAM=;
	b=BWJrJ9zBNbn0awaKiCsT2NIXmz/r5xo6ywZ8pzCZ6GPksVfOP9fK57rWvgFjYSJi70Lo8D
	lsHJmjos8g2rsjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22FA83EA63;
	Tue, 25 Nov 2025 12:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g5PzAymiJWkIdAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Nov 2025 12:33:45 +0000
Message-ID: <718aae86-a8dd-4b1d-9666-8d3a2bc5bc49@suse.de>
Date: Tue, 25 Nov 2025 13:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
To: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>, "wagi@kernel.org"
 <wagi@kernel.org>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>, "xni@redhat.com"
 <xni@redhat.com>, "linan122@huawei.com" <linan122@huawei.com>,
 "bmarzins@redhat.com" <bmarzins@redhat.com>,
 "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
 <aSVMXYCiEGpETx-X@infradead.org>
 <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
 <0caa9d00-3f69-4ade-b93b-eea307fe6f72@linux.ibm.com>
 <20251125112111.GA22545@lst.de>
 <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
 <20251125113009.GA22874@lst.de>
 <c6e88bc3-8cc9-4503-a472-7692468ac218@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c6e88bc3-8cc9-4503-a472-7692468ac218@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 843325BE71
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,kernel.dk,redhat.com,huawei.com,oracle.com,google.com,davemloft.net,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLykmtnuwwt3p9ueb9muqcqoc7)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_043350_601601_458C8905 
X-CRM114-Status: GOOD (  17.89  )
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

On 11/25/25 12:54, Nilay Shroff wrote:
> 
> 
> On 11/25/25 5:00 PM, Christoph Hellwig wrote:
>> On Tue, Nov 25, 2025 at 04:58:32PM +0530, Nilay Shroff wrote:
>>> >From git history, I see that was added to avoid memory reclaim  to avoid
>>> possible circular locking dependency. This commit 83e1226b0ee2 ("nvme-tcp:
>>> fix possible circular locking when deleting a controller under memory
>>> pressure") adds it.
>>
>> I suspect this was intended to be noio, and we should just switch to
>> that.
>>
> Yeah, I agree that this should be changed to noio. However, it seems that
> this alone may not be sufficient to fix the lockdep splat reported here.
> Since the real work of fput() might be deferred to another thread, using a noio
> scope in this path may not have the intended effect and could end up being
> redundant.
> 
> That said, I noticed another fix from Chaitanya [1], where fput() is replaced
> with __fput_sync(). With that change in place, combining the noio scope adjustment
> with the switch to __fput_sync() should indeed address the lockdep issue. Given
> that both problems have very similar lockdep signatures, it might make sense to
> merge these two changes into a single fix.
> 
> [1] https://lore.kernel.org/all/20251125005950.41046-1-ckulkarnilinux@gmail.com/
> 
Yes, we should.
Both address similar symptoms, and I wouldn't be surprised both turn out
to address the same issue.
(Frame #0 from here is basically identical to frame #2 in the referenced
issue).

So please roll both into one patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

