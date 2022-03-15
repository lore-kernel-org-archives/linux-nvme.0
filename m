Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E91DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 10:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpPUaaiu61HwAOHvCElEXkLUSivTZtnEv/qE95WrH0g=; b=k8VR8vbgMsxGjQ+ykFxDBF9fD5
	6nGO0HQeCKF4K8Gx3CQTMSDqLWkNlkSlAJWqAhdpFkGdW5PkDECIGgnHI7Gra5p/m9t8poyDCMG7r
	6d2MynCNXo87FQv38WNfgDEEJSj1oViJF3koPrzQLtvgnRiL6tVhaVz8vckiR9B+vmH+2b4TsJ8Gk
	rNaCGcXzc9BeDp7298mmg+/YIDfs9Lr55ASQNThLT3bGHH1kCwQS8YllmyaxJFIS6Eb6KCBs0Qr2j
	pjzets4ODKr5tYLRbkifpyF8S7abwZMvkodI+XNEVJa4lUgV+ANyPUX/L0WTNaAfaF8o7KMFBcfGD
	fynR22ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU4ZB-008k6V-GO; Tue, 15 Mar 2022 10:38:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU4Z8-008k5S-IX
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 10:38:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB4F1210FC;
 Tue, 15 Mar 2022 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647340688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpPUaaiu61HwAOHvCElEXkLUSivTZtnEv/qE95WrH0g=;
 b=uaRK4U+gv0E83zZZ6LgO4f3GUKSJiuh/OAu63yNwq0xHpgp7YmlQsbXm1w1i12+ezgR38F
 dlDWsU88h1WUi8oQt6yYbbJ9vZMrjHqQIbHdhjeU3E8jv0kPWrxHk7Hqd7xEmrMMnKrBX3
 etCzJQRpJnH4TUx591kVkbRWcVQ1lgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647340688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpPUaaiu61HwAOHvCElEXkLUSivTZtnEv/qE95WrH0g=;
 b=ud+T6HWkgTsT1SPIRx0G4Yy5zuBmEjoX3qIURCIl75F8yRsRUD+zQ9YXNWTZU3QIgySC5c
 jGY28BPvvbF7y0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF7FC13B59;
 Tue, 15 Mar 2022 10:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ICRmMpBsMGLpIQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 10:38:08 +0000
Message-ID: <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
Date: Tue, 15 Mar 2022 11:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
In-Reply-To: <20220315094950.GA5322@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_033810_787690_6753E234 
X-CRM114-Status: GOOD (  29.41  )
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

On 3/15/22 10:49, Christoph Hellwig wrote:
> On Tue, Mar 15, 2022 at 10:06:26AM +0100, Hannes Reinecke wrote:
>> The core question really is: do we _want_ to expose the discovery subsystem
>> in configfs?
> 
> Well, if you want a freely configurable one we kinda have to, right?
> 
>> Unfortunately, exposing the discovery subsystem and trying to configure it
>> with configfs does _not_ match with the way discovery is implemented today.
>> While we currently only have a single discovery subsystem, it will only
>> ever return the subsystems visible from this particular port.
> 
> Well.  The original Fabrics spec had this concept of that magic discovery
> NQN, which implies that there is one subsystem (or many pretending to be
> one).  And that is what the implementation followed.  The varipus 80?? TPs
> then made a complete mess off that.
> 
>> Hence this rather simple approach, having the 'normal' discovery subsystem
>> exposed, and let the admin configure it accordingly.
>>
>> I can look at keeping the internal implementation, and only expose unique
>> discovery controller (ie those with a unique subsystem NQN).
>> That would remove the need to having the 'discovery_nqn' attribute, and
>> address Christophs concerns.
> 
> I suspect if we want to support all the new mess from the FMDS group
> (and maybe we need to question the why a little more), then we should
> so something like:
> 
>   (1) keep the existing global NQN-based discovery as-is.
>   (2) maybe add a per-port known to allow disabling it if people really care
>   (3) allow creating additional discovery subsystems with non-default
>       NQNs that do not automatically get anything added to them and will
>       just be configured as needed through configfs
> 
Yeah, that's the line I'm following.

> But maybe first we should take a step back and figure out what supporting
> TPAR8013 even buys us?

Properly supporting persistent discovery controllers.

The current problem we're having (on linux) is that we cannot identify 
discovery controllers. Each discovery controller has the same subsystem 
NQN, and hence that's not sufficient to identify the subsystem
Which resulted in linux to always create a new 'nvme_subsystem' instance 
when creating a new nvme discover controller.

Problem now starts when you try to use persistent discovery controllers; 
it's quite easy to _create_ a persistent discovery controller, but less 
easy to _use_ an existing one; how would you know which one to pick?

More importantly, as linux will always create a new nvme_subsystem for 
each discovery controller you'll end up with several 'nvme_subsystem' 
instances which in fact all refer to the very same subsystem.

nvme-cli tries to work around that problem by requiring the user to 
specify the device name, but that requires quite some knowledge from the 
admin side, and making that work in a scripted fashion is a pain.

So with TPAR8013 we now _have_ distinct discovery subsystems, can create 
unique subsystem, won't have duplicate subsystems, and can automate 
nvme-cli to pick the correct existing persistent discovery controller 
even if the user does _not_ specify the device name.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

