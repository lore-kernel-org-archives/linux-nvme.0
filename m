Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC487C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qe89/vg5nG05IIBAyfWxHqPGRPxBPh6WHsIJO2x/U9c=; b=3NTgMzCuTprGlrxOTkrgLDSLgQ
	CL2dAJ3UWxZMYktZDVd+Za52vjW8mNCfqlD3qIy8xSwgofJXmTl+MCVquua8dnHYiKdJFrUUyjN6w
	qQYFwyv09BHr0Fv0Iz3wAITsUsFK5ZbAZ5aY6ZxaKmJ2hXpAe52WEypzY+xGgQhVdi4ywrvRy1Ej7
	n2J5a2K485yZ5w8mJfkTo7cN8wHmSl59ggrRioyaRXXTX/upDsNaRHmNfgWH+nefuCDYMYkHEMRW2
	wOCwA9T/q5Mm0IBFSGuOEYL9vTVMHOJUsZ8qVvJmTWnabMS67aCDJfnBVazfBcjac4e5c3UzgkFMR
	NPRi9WMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwNUx-00000008jTA-0nNd;
	Mon, 15 Apr 2024 14:39:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwNUs-00000008jS1-1NuQ
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 14:39:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD7D1371F1;
	Mon, 15 Apr 2024 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713191986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe89/vg5nG05IIBAyfWxHqPGRPxBPh6WHsIJO2x/U9c=;
	b=QtMUlQ5fkDD8DYZ44o6HBHvMHqUCJnCOOGhYadrjf3zNyprrwmFP/LoldMVxVzgGOBEZm2
	GxAs0KABV/L5JTsP4Apnz5G096Gfq4MDvcBkwrwY0AO5ERggbAK5IfUohhhjXbh7dtL1qd
	pTUc4LTyEq8pEt6NY4kEhvoI1V4rMfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713191986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe89/vg5nG05IIBAyfWxHqPGRPxBPh6WHsIJO2x/U9c=;
	b=XH/h+LUmTaA0hiwFlcA/gIQt4AUKcg5NcJ3GpfujLKkKMPFF7biAlfee8gI1yc4pZtu0GK
	08WjlBGojxd9AsDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hwGWCeha;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TggeeOtc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713191985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe89/vg5nG05IIBAyfWxHqPGRPxBPh6WHsIJO2x/U9c=;
	b=hwGWCeha4MSiCK5CAnnP+oplsAPpcOntv5Esqrh8IqgKJl/H4axixW6im9Zfpmo3eIcXdA
	6PKyWx10dnGY5KeHbM62uWsIsZRQaFARzF5HMWyxfwrrXwTmJaSBcBn3D7WtnkWhJrD3tA
	cEmyCy5cnz7hKxciyqzTi8fUTmPnPL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713191985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe89/vg5nG05IIBAyfWxHqPGRPxBPh6WHsIJO2x/U9c=;
	b=TggeeOtcgmPqo4OWqKeWtnVDYcb8RLNGVtdHRtsMtiWIrQrDQk82LDjh3ACxPv4bSz6WgN
	o8mHbovjakvGjsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B6C1386E;
	Mon, 15 Apr 2024 14:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILLjHTE8HWaPLAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Apr 2024 14:39:45 +0000
Message-ID: <05dbae65-2cc2-40d7-9066-a83cdfdc47be@suse.de>
Date: Mon, 15 Apr 2024 16:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, gjoyce@linux.ibm.com, axboe@fb.com
References: <20240413090614.678353-1-nilay@linux.ibm.com>
 <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
 <ffcfbe15-8e6f-422a-87cd-52c30ebf726c@linux.ibm.com>
 <81a64482-1b02-43b2-aacd-9d8ea1cea23c@grimberg.me>
 <7b188849-5c3f-45ff-9747-096ffdaff6ee@linux.ibm.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7b188849-5c3f-45ff-9747-096ffdaff6ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CD7D1371F1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_073950_694286_0F16F7EF 
X-CRM114-Status: GOOD (  28.28  )
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

On 4/15/24 11:30, Nilay Shroff wrote:
> 
> 
> On 4/15/24 14:25, Sagi Grimberg wrote:
>>
>>
>> On 14/04/2024 14:02, Nilay Shroff wrote:
>>>
>>> On 4/14/24 14:00, Sagi Grimberg wrote:
>>>>
>>>> On 13/04/2024 12:04, Nilay Shroff wrote:
>>>>> On numa aware system where native nvme multipath is configured and
>>>>> iopolicy is set to numa but the nvme controller numa node id is
>>>>> undefined or -1 (NUMA_NO_NODE) then avoid calculating node distance
>>>>> for finding optimal io path. In such case we may access numa distance
>>>>> table with invalid index and that may potentially refer to incorrect
>>>>> memory. So this patch ensures that if the nvme controller numa node
>>>>> id is -1 then instead of calculating node distance for finding optimal
>>>>> io path, we set the numa node distance of such controller to default 10
>>>>> (LOCAL_DISTANCE).
>>>> Patch looks ok to me, but it is not clear weather this fixes a real issue or not.
>>>>
>>> I think this patch does help fix a real issue. I have a numa aware system where
>>> I have a multi port/controller NNVMe PCIe disk attached. On this system, I found
>>> that sometimes the nvme controller numa id is set to -1 (NUMA_NO_NODE). And the
>>> reason being, my system has processors and memory coming from one or more NUMA nodes
>>> and the NVMe PCIe device is coming from a NUMA node which is different. For example,
>>> we could have processors coming from node 0 and node 1, but the PCIe device coming from
>>> node 2, and we don't have any processor coming from node 2, so there would be no way for
>>> Linux to affinitize the PCIe device with a processor and hence while enumerating PCIe
>>> device kernel sets the numa id of such device to -1. Later if we hotplug CPU on node 2
>>> then kernel would assign the numa node id 2 to the PCIe device.
>>>
>>> For instance, I have a system with two numa nodes currently online. I also have
>>> a multi controller NVMe PCIe disk attached to this system:
>>>
>>> # numactl -H
>>> available: 2 nodes (2-3)
>>> node 2 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>> node 2 size: 15290 MB
>>> node 2 free: 14200 MB
>>> node 3 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>>> node 3 size: 16336 MB
>>> node 3 free: 15075 MB
>>> node distances:
>>> node   2   3
>>>     2:  10  20
>>>     3:  20  10
>>>
>>> As we could see above on this system I have currently numa node 2 and 3 online.
>>> And I have CPUs coming from node 2 and 3.
>>>
>>> # lspci
>>> 052e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
>>> 058e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
>>>
>>> # nvme list -v
>>> Subsystem        Subsystem-NQN                                                                                    Controllers
>>> ---------------- ------------------------------------------------------------------------------------------------ ----------------
>>> nvme-subsys3     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme1, nvme3
>>>
>>> Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces
>>> -------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
>>> nvme1    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0          nvme-subsys3 nvme3n1
>>> nvme3    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0          nvme-subsys3 nvme3n1, nvme3n2
>>>
>>> Device       Generic      NSID       Usage                      Format           Controllers
>>> ------------ ------------ ---------- -------------------------- ---------------- ----------------
>>> /dev/nvme3n1 /dev/ng3n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
>>> /dev/nvme3n2 /dev/ng3n2   0x2          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme3
>>>
>>> # cat ./sys/devices/pci058e:78/058e:78:00.0/numa_node
>>> 2
>>> # cat ./sys/devices/pci052e:78/052e:78:00.0/numa_node
>>> -1
>>>
>>> # cat /sys/class/nvme/nvme3/numa_node
>>> 2
>>> # cat /sys/class/nvme/nvme1/numa_node
>>> -1
>>>
>>> As we could see above I have multi controller NVMe disk atatched to this system. This disk
>>> has 2 controllers. However the numa node id assigned to one of the controller (nvme1) is -1.
>>> This is because on this system, currently I don't have any processor coming from a numa node
>>> where nvme1 controller numa node could be be affinitized.
>>
>> Thanks for the explanation. But what is the bug you see in this configuration? panic?
>> suboptimal performance?
>> which is it? it is not clear from the patch description.
>>
> I didn't encounter panic, however the issue here is with accessing numa distance table
> with incorrect index.
> 
> For calculating the distance between two nodes we invoke the function __node_distance().
> This function would then access the numa distance table, which is typically an array with
> valid index starting from 0. So obviously accessing this table with index of -1 would
> deference incorrect memory location. De-referencing incorrect memory location might have
> side effects including panic (though I didn't encounter panic). Furthermore in such a case,
> the calculated node distance could potentially be incorrect and that might cause the nvme
> multipath to choose a suboptimal IO path.
> 
> This patch may not help choosing the optimal IO path (as we assume that the node distance would be
> LOCAL_DISTANCE in case nvme controller numa node id is -1) but it ensures that we don't access the
> invalid memory location for calculating node distance.
> 
Hmm. One wonders: how does such a system work?
The systems I know always have the PCI slots attached to the CPU
sockets, so if the CPU is not present the NVMe device on that
slot will be non-functional. In fact, it wouldn't be visible at
all as the PCI lanes are not powered up.
In your system the PCI lanes clearly are powered up, as the NVMe
device shows up in the PCI enumeration.
Which means you are running a rather different PCI configuration.
Question now is: does the NVMe device _work_?
If it does, shouldn't the NUMA node continue to be present (some kind of 
memory-less, CPU-less NUMA node ...)?
As a side-note, we'll need these kind of configuration anyway once
CXL switches become available...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


