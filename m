Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82CEC30653
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=; b=jOZpZOQUk87RInabckYUxATTl8
	ID8SdKQg1M9gTjUDDqKZr6oIPnsIHs+NjR1xNjctc7E66AMDjsVyKmDjLXF6j1sw1rFP4IFxYrT/r
	amCst7Yfbj0I/VuhcqS9Nhfl3jybFJrSeJ4h1kcSci5Fa/WscnshjokpNqQzIEUIfMjBrw5945vfD
	tj9YLYVRfnSm7fVjNgVlz6t0I5oDxiqBYNxvKFSX2ObmKGDATzTzyHCyJTCIf7t8V0bouas6zqrCw
	5RIE+wOfbDkpVJMCy7o3MayfvFBl4m/uIOQyJ2bgZE5yw32W1IHuyKZ3Pxg2o3jfru5AhqteqAnl3
	SIgdzvtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOCXs-00000002Fsy-3k2p;
	Mon, 01 Jul 2024 08:37:56 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOCXl-00000002Fri-0Qub
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 08:37:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 554D61F828;
	Mon,  1 Jul 2024 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=I4nV9YlxxlyjG/h5r5LzjIf7h2qFyFqvx/O9b+qHa99f8UkdKIk0TSBP69R9kIxT7JHWJF
	vAalYwkgBNgDY2knEl7kSO0KRWNlnjhR88QteYNQyNWG9HYEXkYuVRZDwlTJblW1YHhMfL
	vPAg8v5D3FhLHx8UoVrjWaf2hp5wUXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=ZB9v+kpZzynlkxKGMNtUnbBqh1TdA3BpO8r9sMxxxYvExhTj3YqmpuT61AbhLrxjikjaWY
	ojozBkXhdgY3uDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=I4nV9YlxxlyjG/h5r5LzjIf7h2qFyFqvx/O9b+qHa99f8UkdKIk0TSBP69R9kIxT7JHWJF
	vAalYwkgBNgDY2knEl7kSO0KRWNlnjhR88QteYNQyNWG9HYEXkYuVRZDwlTJblW1YHhMfL
	vPAg8v5D3FhLHx8UoVrjWaf2hp5wUXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=ZB9v+kpZzynlkxKGMNtUnbBqh1TdA3BpO8r9sMxxxYvExhTj3YqmpuT61AbhLrxjikjaWY
	ojozBkXhdgY3uDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF05113800;
	Mon,  1 Jul 2024 08:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLZzLtpqgmbmBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jul 2024 08:37:46 +0000
Message-ID: <c797bdc1-b949-4d88-a65f-904d909755dc@suse.de>
Date: Mon, 1 Jul 2024 10:37:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoIPzQNEsUWOWp3f@fedora> <1a1a4684-a55d-4c27-8509-9bf61408872f@suse.de>
 <ZoJWXRgycA8UeYB3@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoJWXRgycA8UeYB3@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_013749_458931_A08BE9EB 
X-CRM114-Status: GOOD (  17.01  )
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

On 7/1/24 09:10, Ming Lei wrote:
> On Mon, Jul 01, 2024 at 08:43:34AM +0200, Hannes Reinecke wrote:
>> On 7/1/24 04:09, Ming Lei wrote:
[ .. ]
>>>
>>> Since this patch, some isolated CPUs may not be covered in
>>> blk-mq queue mapping.
>>>
>>> Meantime people still may submit IO workload from isolated CPUs
>>> such as by 'taskset -c', blk-mq may not work well for this situation,
>>> for example, IO hang may be caused during cpu hotplug.
>>>
>>> I did see this kind of usage in some RH Openshift workloads.
>>>
>>> If blk-mq problem can be solved, I am fine with this kind of
>>> change.
>>>
>> That was kinda the idea of this patchset; when 'isolcpus' is active any
>> in-kernel driver can only run on the housekeeping CPUs, and I/O from the
>> isolcpus is impossible.
>> (Otherwise they won't be isolated anymore, and the whole concepts becomes
>> ever so shaky.).
> 
> Userspace may still force to run IO workload from isolated CPUs when they do
> not care CPU isolation, and kernel still should complete IO from isolated CPUs,
> and can't run into hang or panic meantime.
> 
> And we do support this kind of usage now, then regression is caused by
> this patch.
> 
Hmm. Guess we need to modify the grouping algorithm to group across all 
cpus, but ensure that each group consists either of all housekeeping 
CPUs or all isolated cpus.
Daniel?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


