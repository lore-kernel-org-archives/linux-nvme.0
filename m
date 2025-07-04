Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E84C83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wE7oak/uBM6EUSDVgy+XtmbCECV3TQygZEt/UPH51hU=; b=aAa5y5wzCbDF5kiTO+Q6jIB07P
	UnRorT5VgNmQ/lQWCUufSbzVE/Q3ptsVmFg6AmdS+aL66M8PaezsowZ4+BAJw/zAeRIEvBuzj9lno
	eLSPtKR6qnJ5laA2dtRw/DC9+nlldcT2mgVZzyq/xVgxqy1G5wx1iRXhHJQQK9ygvVYph5cU+9V/C
	F8p8hYjZmp+TYmB2cBquNX3h3vAHpzHmm41ltasQKBi7dBh8CCTKnTZ0nYnWa4L/QJ73WRjOWFUG+
	6oUk0CTt5Ij38blvPOfSoCDk6XB+DeG9TdM4KXjxChGCnXfQB7o3+4xPddymDDM+HH2Z9g8xaAxTJ
	fHeuLSUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXeRW-0000000EBHv-1uyg;
	Fri, 04 Jul 2025 11:18:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXdf3-0000000E3ML-35zJ
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 10:28:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D27C821197;
	Fri,  4 Jul 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F4CE13A71;
	Fri,  4 Jul 2025 10:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SWmdEuKsZ2gINwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 04 Jul 2025 10:28:50 +0000
Message-ID: <c06d0ef2-6bd2-4f5d-895f-0255415b2a24@suse.de>
Date: Fri, 4 Jul 2025 12:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] scsi: Use block layer helpers to constrain queue
 affinity
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, storagedev@microchip.com,
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-5-557aa7eacce4@kernel.org>
 <d95de280-8cd7-4697-933a-37dc53f4c552@suse.de>
 <2e7576e4-442f-4000-817d-6253374f5818@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2e7576e4-442f-4000-817d-6253374f5818@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D27C821197
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_032854_070024_2F628978 
X-CRM114-Status: GOOD (  26.37  )
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

On 7/4/25 11:37, Daniel Wagner wrote:
> On Thu, Jul 03, 2025 at 08:43:01AM +0200, Hannes Reinecke wrote:
>> All of these drivers are not aware of CPU hotplug, and as such
>> will not be notified when the number of CPUs changes.
> 
> Ah, this explains this part.
> 
>> But you use 'blk_mq_online_queue_affinity()' for all of these
>> drivers.
> 
> All these drivers are also using blk_mq_num_online_queue. When I only
> used cpu_possible_mask the resulting mapping was not usable.
> 
Yeah, I'd imagine so. Quite some drivers have 'interesting' ideas how
the firmware interface should look like.

But it also means that there is a very high likelyhood that these
drivers become inoperable under CPU hotplug.
Is there a way of disabling CPU hotplug when these drivers are in use?

>> Wouldn't 'blk_mq_possible_queue_affinit()' a better choice here
>> to insulate against CPU hotplug effects?
> 
> With this mask the queues will be distributed to all possible CPUs and
> some of the hardware queues could be assigned to offline CPUs. I think
> this would work but the question is, is this okay to leave some of the
> perfomance on the road?
> 
It really shouldn't be an issue when the cpus are distributed 
'correctly' :-)
We have several possibilities:
-> #hwq > num_possible_cpus: easy, 1:1 mapping, no problem
-> num_online_cpu < #hwq < num_possible_cpus: Not as easy, but if we
    ensure that each online cpu is mapped to a different hwq we don't
    have a performance impact.
-> #hwq < num_online_cpu: If we ensure that a) the number of online cpus
    per hwq is (roughly) identical we won't have a performance impact.
    As a bonus we should strive to have the number of offline cpus
    distributed equally on each hwq.

Of course, that doesn't take into accound NUMA locality; with NUMA 
locality you would need to ensure to have at least one CPU per NUMA node
mapped to each hwq. Which actually would impose a lower limit on the
number (and granularity!) of hwqs (namely the number of NUMA nodes), but 
that's fair, I guess.

But this really can be delegated to later patches; initially we really
should identify which drivers might have issues with CPU hotplug,
and at the very least issue a warning for these drivers.

> I am not against this, just saying it would change the existing
> behavior.
> 

Oh, sure. No-one (except lpfc on Power) is testing CPU hotplug actively.

>> Also some drivers which are using irq affinity (eg aacraid, lpfc) are
>> missing from these conversions. Why?
> 
> I was not aware of aacraid. I started to work on lpfc and well let's put
> it this way, it's complicated. lpfc needs a lot of work to make it
> isolcpus aware.

Yeah, I know. Sorry ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

