Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F401C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=63MRWSbMP7SYVfgizOnowh5KAglO2xcLekFtLTOMMq0=; b=rfIhelr0yGQjVZaIWwwM/FiZlL
	q9WbYmByqVJnzcrGm04iAWuj52BatceEq2fCSuD2f80x69XTGsfFUSKi/t23XM9/k9gSVjXDus3WQ
	lZm4Q5xx+u+SVfpPgeJrtyQDrUvQ3QLbDWDlczdCo1fY5QOaxsxHlDK4EN19VXH7MqyOAgRS+cL2s
	QLC551SCGGOzqDKkZvS/Zjfmml533tOby388G1i8ZQRBMQ9gI8QXNjLa0xnvM6qHxVIa7xDotlfIu
	r3uEuwpXX6G3JDkrLHOGdBQKEAy6eTO1rrvWgzWbFaRbgLyqkVYEM08ZhVEMAOCoUW8Jh8p3pdgO8
	urCyQJ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nofoe-005Qbf-Vp; Wed, 11 May 2022 06:27:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nofoZ-005QaY-3u
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 06:27:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5E2A1F8CC;
 Wed, 11 May 2022 06:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652250433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63MRWSbMP7SYVfgizOnowh5KAglO2xcLekFtLTOMMq0=;
 b=VDpOhu69D+yy/Nh60/wz2gpJ8vfaaMXOor5SrI6mWfbai26L4OFHeYWYXhTlCmDIPpR0rS
 TYRqdZhstDsxfxiU9JgC0bHy03ABzNXGterX4U9TCnha9jqBik7fEhtsXtfL//JJF/IJ1i
 vkTyYokSD7EGMzSVaEJ2YEZd5ZxFEpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652250433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63MRWSbMP7SYVfgizOnowh5KAglO2xcLekFtLTOMMq0=;
 b=2eVHQtHBdPevRm9rMO9pkwOjKw4Qiei06uxS4SrVzGnT05B0fgMkWwm31YcJQLXdIh+hFI
 Ykno2ZrjyBpCMaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A9EF139F9;
 Wed, 11 May 2022 06:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id syQpHEFXe2JtNwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 11 May 2022 06:27:13 +0000
Message-ID: <37c5c6bd-ba3a-5ead-4d83-b38a880fd9f6@suse.de>
Date: Wed, 11 May 2022 08:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220420092730.35101-1-hare@suse.de>
 <20220420092730.35101-5-hare@suse.de>
 <2fadeb83-6670-14d6-71e3-c8a23ed7d9e8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvmet: expose discovery subsystem
In-Reply-To: <2fadeb83-6670-14d6-71e3-c8a23ed7d9e8@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_232715_339758_A067CE43 
X-CRM114-Status: GOOD (  23.51  )
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

On 5/10/22 20:59, Sagi Grimberg wrote:
>> Add a module option 'expose_discovery_subsys' to expose the
>> default discovery subsystem via configfs.
>> When this option is enabled the internal discovery subsystem
>> is disabled, and the admin has to create a discovery
>> subsystem manually.
>> The discovery subsystem then has to be linked into the ports
>> which should present the discovery subsystem.
>>
>> o- /
>>    o- ports
>>    | o- 2
>>    |   o- subsystems
>>    |     o- nqn.io-2
>>    | o- 3
>>    |   o- subsystems
>>    |     o- nqn.2014-08.org.nvmexpress.discovery
>>    |     o- nqn.io-1
>>    o- subsystems
>>      o- nqn.2014-08.org.nvmexpress.discovery
>>      | o- namespaces
>>      o- nqn.io-1
>>      | o- namespaces
>>      o- nqn.io-2
>>        o- namespaces
>>
>> So in this example the standard discovery service would be available on
>> port 3, presenting information about subsystem nqn.io-1.
>> Port 2 would not present a discovery service, but a controller can 
>> connect
>> to subsystem nqn.io-2 on that port.
> 
> So what is the behavior of this param?
> 
> expose_discovery_subsys=1:
> both default and unique discovery subsystems function and behave
> in the same way, i.e. user created, linked to dedicated ports and
> answers log page info with subsystems on all ports they are linked to.
> 
> expose_discovery_subsys=0:
> default discovery subsystem behaves like today but unique discovery
> subsystems behave differently (i.e. like first option?)
> 
> This will be confusing to users I think.
> 
> I would say that in case expose_discovery_subsys=0 unique discovery
> subsystems should still behave like the default discovery subsys,
> meaning return a log-page with only port local information.
> 
> This way default and unique discovery subsystems are consistent with
> each other. Then the modparam could be something like:
> 
> static int multiport_discovery_log_page;
> module_param(multiport_discovery_log_page, int, 0644);
> MODULE_PARM_DESC(multiport_discovery_log_page,
>           "Include subsystems from all linked ports in the "
>          "discovery log-page information. In this mode the "
>          "default discovery subsystem must also be created in "
>          "configfs like any other subsystem.");
> 
> Thoughts?

My idea here was that each discovery subsystem will be presenting 
informations about all ports it is linked in.
Consequently, to mimic the original behaviour you would create separate 
discovery subsystems such that each port has its own discovery subsystems.

Plus your suggested module parameter would influence the default 
discovery subsystem, too, right?
I tied it into exposed discovery subsystems on purpose, to allow the 
user to control which ports are exposed to which discovery subsystem.

So, in the end, I'm not sure which way to go.
I'm fine with your suggestion, but I like the current patchset, too ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

