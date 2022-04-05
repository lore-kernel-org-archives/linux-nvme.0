Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDEFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gazqUG+Dd4HAfEzq0bCcGBdkUiG9lqiXFZ2ZpuXyXOo=; b=TCNSglTwkFwlpSWxS5TdWb94jg
	KiNWsxeeZcYzjWiQG+kjPxto/LHMM9Xj8PGesXT8CVtqVVlVqcRQnpejhxMbjKWWGsJHaRrisJXBm
	Bf1R56eDOIvdVVbLMI+LdQmHPffct81EpG93+IRHA7lJH7asmEybKiiZDFCGdNcPKK/D2SLrEywPb
	BDsa6Bo1PW6eltTnpg+ttgiszwFyEGCXD4ifUrcfvlgxqsobsMbBytHddLdn+sU+e43iS7QAg1SRs
	Kz84Q/3XecofpoAy7tqxce/dQV91IAYF1BvbzlYQ7ZmqjbSKCYY+DjoHXMoyeJnMSjVDc5Oo5nk5W
	AfD/vnBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbgwg-000jKe-7b; Tue, 05 Apr 2022 11:01:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbgwc-000jKA-Q7
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 11:01:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 955E91F390;
 Tue,  5 Apr 2022 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649156511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gazqUG+Dd4HAfEzq0bCcGBdkUiG9lqiXFZ2ZpuXyXOo=;
 b=jcsaJrcdeM8ONFpSh53YxIvnx+B2kSHPVDVACPBgvcJv3tk0+ROpmooSygetMFx5PvwyCO
 //RQBaZDt70V60/oYKw5SKm0hprgH6QxC4L/u7UwbAi0225B47E1lILF1IlA1jj6ZpJPne
 E3rbfH0GpIh5MzBUpVs3a8PHSSsiDak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649156511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gazqUG+Dd4HAfEzq0bCcGBdkUiG9lqiXFZ2ZpuXyXOo=;
 b=F1TgnYI83bY24VxAfgDd+dvSIv2HKoZEk0L8WFwzTAPczyZKcmlc2JlDZIWtPUjoJNYoyT
 B6prHJcjNnXSFNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8295113522;
 Tue,  5 Apr 2022 11:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id saztHp8hTGK/YwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 11:01:51 +0000
Message-ID: <4d4b58e1-f0db-aa55-78b4-a01df62c2a56@suse.de>
Date: Tue, 5 Apr 2022 13:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
 <15910553-e0a6-3513-ae43-fc1cb634b1b0@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <15910553-e0a6-3513-ae43-fc1cb634b1b0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_040155_034594_984259D7 
X-CRM114-Status: GOOD (  13.09  )
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

On 4/5/22 12:41, Sagi Grimberg wrote:
> 
>>>> To make it configurable.
>>>> Unique discovery controllers show up in configfs just like any other
>>>> subsystems.
>>>> And with that we need to clarify the relationship between the discovery
>>>> subsystem and the other subsystems, ie which subsystems should be 
>>>> presented
>>>> by this discovery subsystem.
>>>>
>>>> Linking the discovery subsystem into a given port makes it obvious that
>>>> a) this port will be presenting a discovery subsystem
>>>> and
>>>> b) that the discovery subsystem will be presenting all subsystems
>>>> configured on that port.
>>>>
>>>> The built-in mechanism for discovery subsystems was okay as long as the
>>>> discovery subsystem was built-in, too.
>>>> But with this patchset we're moving to an explicit configuration.
>>>
>>> Shouldn't we just require anything to be manually listed for this
>>> case similar to how we configure referrals for the well known
>>> discovery controller?
>>
>> Which is what I've tried with this attempt.
>> I did _not_ want to create a new configuration mechanism, but rather 
>> use the existing ones.
>> And the existing mechanism we have is linking subsystems to ports.
>>
>> If we want to treat discovery subsystems differently (as you proposed) 
>> we sure can have a different mechanism on how to configure it.
>> But I wasn't sure if that's the direction we want to go.
> 
> What is the concern here? that it will break existing users with
> introducing an additional configuration step?

Yes. It would break backward compability.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

