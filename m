Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEB6C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VtfEIAjd48jETIJcQPnAL2DBpu6My/6zZfVyytCFvWM=; b=OLgW2YIZEYG+YZp1mE5Nu5wIPt
	UJZgqKSEPqFvq06cBxXeudOvizBdbwRWDukkDOuBkxszn63TBz3+N3rvyNBqqGcslUkyU6zO37tD2
	XZVwujvv2/KB5nDxvXSqndNmS5juDWH08OqFpzoR/lCBrenHXZVcgTGrhPPLruJtWlvqG4pHCgWDc
	SKMDa5KKeB3iklPh/AsGxvd6jpH03720ZSHo5x9xhD/YHAjXaiF8DYzsA1+lHp4vtz9l8T47/l9/U
	6pD5f6cZRTwuCn9jcIYz9846Jl6pf4HvM77B++wKCuzlJ0PApVqhuXZej3j/lYMp3vTCo43jgxSNA
	nzlxIidQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTegU-00406e-21; Mon, 14 Mar 2022 07:00:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTegQ-00405h-Qo
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:00:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 812C11F388;
 Mon, 14 Mar 2022 06:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647241197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtfEIAjd48jETIJcQPnAL2DBpu6My/6zZfVyytCFvWM=;
 b=XpqR2YKviQNXFsz20voOVslCmwQSHv85o7Dqbt3DH1tksK1831DVpWXYnNwAXzDXhSG5iy
 8KBxVK8n0R5ZIzjZlaXxN3Cij1IpOwUckPgk0XwMMasrSiHXKwMFjQtG1KnelIEvpQ5zgO
 NkJNHAAsCP4elfgnFNBSs8EMgt+ZeDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647241197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtfEIAjd48jETIJcQPnAL2DBpu6My/6zZfVyytCFvWM=;
 b=GnQrLqzVRtvlb5KJBBuq3BWv0LJSsbdV4Vpkd3reAbPYeIUkidQrbcGVbwKA+bjOcbyaNo
 G2J2geIERsoCT6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 662F913ADA;
 Mon, 14 Mar 2022 06:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2AQUF+3nLmIsNAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 14 Mar 2022 06:59:57 +0000
Message-ID: <7e294198-b8ef-2d4f-944c-353792cc27d9@suse.de>
Date: Mon, 14 Mar 2022 07:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Nvmet discovery implementation. Questions and a patch / proposal.
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1B761FBE-58C8-4A52-9747-42ED84A6D383@primelogic.nl>
 <5109f07b-b99d-5e3b-f5b3-410fbbbdfcd4@suse.de>
 <2cc90ad6-6422-0ef0-005e-a1ec09caf894@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2cc90ad6-6422-0ef0-005e-a1ec09caf894@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_235959_040783_B14C3B3B 
X-CRM114-Status: GOOD (  25.06  )
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

On 3/13/22 22:25, Sagi Grimberg wrote:
> 
> 
> On 3/1/22 09:05, Hannes Reinecke wrote:
>> On 2/28/22 17:39, Mark Ruijter wrote:
>>>
>>> The current discovery implementation only works after a subsystem has 
>>> been created and has been linked to a port.
>>> As a result, 'nvme discover' from an initiator will only show a 
>>> discovery device after the first subsystem has
>>> been exported.
>>>
>>> The patch that I propose adds these features:
>>> A. Make discovery work immediately after the target port has been 
>>> configured, without needing to configure
>>>    subsystems first.
>>> B. Move the discovery_nqn configuration option to the port instead of 
>>> having the same configuration option
>>>    duplicated in every subsystem.
>>> C. Allow to enable and disable a target port without needing to 
>>> unlink target subsystems.
>>>
>> The current nvmet discovery implementation was designed to the 
>> original NVMe spec, where a discovery controller could only return 
>> informations about the attached subsystems.
>> But with the recent changes to the spec a discovery controller can now 
>> return information about itself (ie which port it's running on), and so
>> it does makes sense to have it enabled even with no subsystems attached.
>>
>> But: the current implementation only has a _single_ discovery 
>> subsystem (nvmet_disc_subsys), which is shared across all configured 
>> subsystems.
>> And there's a filter when generating the discovery log page such that 
>> only the information for the current subsystem is returned (cf 
>> nvmet_execute_disc_get_log_page()).
>> So in effect each subsystem has its own discovery subsystem.
>>
>> Moving the discovery nqn to the port will only confuse matters, as 
>> then it's quite unclear what will happen if you change the discovery 
>> subsystem nqn on a per-port basis; with the current design you would
>> change it for _all_ discovery subsystem ...
>>
>> So if you want to do something like this, you'd need to change the 
>> implementation to have a discovery subsystem per port, and also change 
>> the logic in drivers/nvme/target/discovery.c such that the discovery
>> subsystems will return informations for _all_ configured subsystems.
>>
>> It's actually something I wanted to do, too, as I didn't like the 
>> current implementation :-)
> 
> Why aren't we just creating the discovery subsystem as a static configfs
> subsystems and just link it to different ports?
> 
We could be doing that, but that would imply a change in behaviour.
Currently we have one distinct discovery controller per subsystem.
Switching to a static configfs discovery subsystem would inevitably 
result in a _single_ discovery subsystem for all configured subsystems.
Not that I'm against it (quite the contrary), but it should be mentioned.

> The port listener on first linkage is a different matter afaict, don't
> see a strong argument to make the port listener without any subsystems
> exported anyways... maybe if discovery log change event is being used...

Actually, we can just leave the existing mechanism as-is; ports would 
need to be linked explicitly to the discovery subsystem.
Reasoning: Not every port needs to present a discovery subsystem, and we 
might want to have ports which will _only_ present the discovery subsystem.

Hmm. Should be pretty easy to code ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

