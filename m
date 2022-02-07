Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2769C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:To:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=df8sxcLTXgR03V+plT/A1KonDjmoTHxtiA6bzdG/I1M=; b=1nwmMUYlCLo1RtDkvTuD2fKkuw
	Bwb/sV3jGJeK/4syf/ho+NjaMAjQ7G8sCnV5WVrx+3W3348dHMOffHwOvLuRzlfR+EuxzAjl9ZqOa
	QerYqmwJwrO1gG1xrpafstfdvZsxFxtIAQ0oz45k/v56iRZkeEMrLQLqOx4RrD/DD6J300rdAdZ9L
	WQHdpME9/OPwmZZAcw3aFTiQ7OPTsJkmitGmwJDZivtGGNYYT65XTb2LSazlCffQyUViMnNk1CQ+A
	ZP7hPC4L6Xr/3/PZ2sexmQ1vRSmZE+lGYYUmFJ+9SQ4xEdEg0c1hDAvkNZsDwLXkqF0uSO64cRaU5
	B0pSbLsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH0b8-009cVx-Hl; Mon, 07 Feb 2022 09:46:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH0b4-009cUN-Sj
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 09:46:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE8D0210F9;
 Mon,  7 Feb 2022 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644227168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=df8sxcLTXgR03V+plT/A1KonDjmoTHxtiA6bzdG/I1M=;
 b=QZVWwURL8XTg/RIF3K3hhTX7vqmq9pvGrK8j7Zi+vQYRMMh+29gnB1BHSgV0UU64ILQp5s
 zGT//VLxrbFgGSdgYQARZ3hyKBniQJgl6FMoDSSYkQ+RFNOoCcLaLEuiv/GZUoNiwA7daN
 VImWx3oF43WRo/ETHLCAIGTKpfRD5wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644227168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=df8sxcLTXgR03V+plT/A1KonDjmoTHxtiA6bzdG/I1M=;
 b=kYfSIArbglClxwSDzsKnzQiRGEdyVsum3EAvJ+JWi/DLXLfzsEIpvBrIF4NGbxffQqNKZ9
 w7Anosh80QkscQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E435D13B2D;
 Mon,  7 Feb 2022 09:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7P9YN2DqAGK+JQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 07 Feb 2022 09:46:08 +0000
Message-ID: <b800341f-b8f2-741b-1405-4dfcf888199e@suse.de>
Date: Mon, 7 Feb 2022 10:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
In-Reply-To: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_014611_105749_49FB07B1 
X-CRM114-Status: GOOD (  45.41  )
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

On 2/6/22 14:59, Alex Talker wrote:
> Recently I noticed a peculiar error after connecting from the host
> (CentOS 8 Stream at the time, more on that below)
> via TCP(unlikely matters) to the NVMe target subsystem shared using 
> nvmet module:
> 
>  > ...
>  > nvme nvme1: ANATT timeout, resetting controller.
>  > nvme nvme1: creating 8 I/O queues.
>  > nvme nvme1: mapped 8/0/0 default/read/poll queues.
>  > ...
>  > nvme nvme1: ANATT timeout, resetting controller.
>  > ...(and it continues like that over and over and over again, on some 
> configuration even getting worse with greater iterations of reconnect)
> 
> I discovered that this behavior is caused by code in 
> drivers/nvme/host/multipath.c,
> in particular when function nvme_update_ana_state increments value of 
> variable nr_change_groups whenever any ANA Group is in "change",
> indifference of whether any namespace belongs to the group or not.
> Now, after figuring out that ANATT stands for ANA Transition Time and 
> reading some more of the NVMe 2.0 standards, I understood that the 
> problem caused by how I managed to utilize ANA Groups.
> 
> As far as I remember, permitted number of ANA Groups in nvmet module is 
> 128, while maximum number of namespaces is 1024(8 times more).
> Thus, mapping 1 namespace to 1 ANA Group works only up to a point.
> It is nice to have some logically-related namespaces belong to the same 
> ANA Group,
> and the final scheme of how namespaces belong to ANA groups is often 
> vendor-specific
> (or rather lies in decision domain of the end user of target-related 
> stuff),
> However, rather than changing state of a namespace on specific port, for 
> example for maintenance reasons,
> I find it particularly useful to utilize ANA Groups to change the state 
> of a certain namespace, since it is more likely that block device might 
> enter unusable state or be a part of some transitioning process.
> Thus, the simplest scheme for me on each port is to assign few ANA 
> Groups, one per each possible ANA state, and change ANA Group on a 
> namespace rather than changing state of the group the namespace belongs 
> to at the moment.
> And here's the catch.
> 
> If one creates a subsystem(no namespaces needed) on a port, connects to 
> it and then sets state of ANA Group #1 to "change", the issue introduced 
> in the beginning would be reproduced practically on many major distros 
> and even upstream code without and issue,
> tho sometimes it can be mitigated by disabling the "native 
> multipath"(when /sys/module/nvme_core/parameters/multipath set to N) but 
> sometimes that's not the case which is why this issue quite annoying for 
> my setup.
> I just checked it on 5.15.16 from Manjaro(basically Arch Linux) and 
> ELRepo's kernel-ml and kernel-lt(basically vanilla versions of the 
> mainline and LTS kernels respectively for CentOSs).
> 
> The standard tells that:
> 
>  > An ANA Group may contain zero or more namespaces
> 
> which makes perfect sense, since one has to create a group prior to 
> assigning it to a namespace, and then:
> 
>  > While ANA Change state is reported by a controller for the namespace, 
> the host should: ...(part regarding ANATT)
> 
> So on one hand I think my setup might be questionable(I might allocate 
> ANAGRPID for "change" only in times of actual transitions, while that 
> might over-complicate usage of the module),
> on the other I think it happens to be a misinterpretation of the 
> standard and might need some additional clarification.
> 
That's actually a misinterpretation.
The above sentence refers to a device reporting to be in ANA 'change', 
ie after reading the ANA log and detecting that a given namespace is in 
a group whose ANA status is 'change'.

In your case it might be feasible to not report 'change' at all, but 
rather do an direct transition from one group to the other.
If it's just a single namespace the transition should be atomic, and 
hence there won't be any synchronisation issues which might warrant a 
'change' state.

> That's why I decided to compose this message first prior to proposing 
> any patches.
> 
> Also, while digging the code, I noticed that ANATT at the moment 
> presented by a random constant(of 10 seconds), and since often 
> transition time differs depending on block devices being in-use 
> underneath namespaces,
> it might be viable to allow end-user to change this value via configfs.
> 
> Considering everything I wrote, I'd like to hear opinions on the 
> following issues:
> 1. Whether my utilization of ANA Groups is viable approach?

Well, it certainly is an odd one, but should be doable.
But note, there had been some fixes to the ANA group ID handling;
most recently commit 79f528afa939 ("nvme-multipath: fix ANA state 
updates when a namespace is not present").
So do ensure to have the latest fixes to get the 'best' possible 
user-experience.

> 2. Which ANA Group assignment schemes utilized in production, from your 
> experience?

Typically it's the NVMe controller port which holds the ANA state; for 
most implementation I'm aware of you have one or more (physical) NVMe 
controller ports, which hosts the interfaces etc.
They connect to the actual storage, and failover is done by switching 
I/O between those controller ports.
Hence the ANA state is really property of the controller port in those 
implementations.

> 3. Whether changing ANATT value change should be allowed via configfs(in 
> particular, on per-subsystem level I think)?
> 
The ANATT value is useful if you have an implementation which takes some 
time to facilitate the switch-over. As there is always a chance of the 
switch-over going wrong the ANATT serves as an upper boundary after 
which an ANA state of 'change' can be considered stale, and a re-read is 
in order.
So for the linux implementation it's a bit moot; one would have to 
present a use-case where changing the ANATT value would make a difference.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

