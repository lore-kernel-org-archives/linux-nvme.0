Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD6C63697
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 19:16:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D6620728
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 19:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ES+PZ6pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D6620728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XBOljFGSEXZbtAruBlXreJBngorcssyL1nCJjlX69D8=; b=ES+PZ6pEsThUqjyt7n+r9Zo4r
	OPm0SHyk1IE504scmqcOKhU4dNCsE5WUUCCbs1zpIOBPOReK3hxPsMk564QNnNYpQWQNJ8fCCUX5s
	FvazF6cY5s06nsL8rwLm++cPWvejdd/WXRRG5821z/aXUAlGRtJEvF5S8+R3aG6macwMbOYr60uHf
	7pntigW4T2bUDA6RkO4dcc3dk9OgHP52kjPdqpmuNlI7qWXP1xA30qVHKrWaBq4jGauToEiVCP0h9
	v0LlHnxj081beLmXr18kmrEH95NTbnij7E03k8dw8efQFC8eK2yPSK1eJSLizRfspWIoLE2P3uCrR
	GXmnsbzhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khHKD-0003Ck-Is; Mon, 23 Nov 2020 19:16:33 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khHK8-0003BC-Vz
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 19:16:31 +0000
Received: by mail-pg1-f193.google.com with SMTP id t3so1307068pgi.11
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 11:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iHdQ/dqF6lJlhd6c8wySzTyfKEPwWj6+ClMXdWdubdc=;
 b=PnTBFv2TnV8HOiuwTHWVyS+EaZzvBb/py23gaN5CQ4Xn8myAv7cBY3jyEjYwdVkE7v
 O+yyOUv8FVjgVrzpEQt9ehi31U0sE3LtHWDtt47N2xdmDrQ8DEmy2/9RkQ1S6tm8UkdD
 kdZOjrXT0xRTOJjuRpiLOHvb1Rh8kwzCE4O1a2r6Gr8fUwRlVEhygenl/V5DLZeGvxHB
 azz+U5324FB8KeX+Jh2uX6E/0QxQ90rfvIqznkKHgJJop6TgnPn/87TIRqTAJb9kiL73
 q5Rw5hlXpu0B4L2ed5KrtjI13COdPi4gm8pLJZEmfNmjx/Zbibp7DT6r2miBkZ1/b6/8
 4XwA==
X-Gm-Message-State: AOAM530dWp28/D+jNv2ySOPHZfFkKFPWaiATputh9T+1s6LzEixdhE9Y
 R3UFTX7C6k6iaMgLImFDqsg=
X-Google-Smtp-Source: ABdhPJzht3n4C7Jf2plb2ilx6nM+DKv9qTIyCfbQGodGGPQapuctwir00xWh5a3JnrWC85SW5XE6mA==
X-Received: by 2002:a63:f404:: with SMTP id g4mr807826pgi.144.1606158986446;
 Mon, 23 Nov 2020 11:16:26 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a898:646a:3c66:ef0f?
 ([2601:647:4802:9070:a898:646a:3c66:ef0f])
 by smtp.gmail.com with ESMTPSA id g6sm453357pjd.3.2020.11.23.11.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 11:16:25 -0800 (PST)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f2afd4dc-dd4b-d7d0-7421-11daac94b61c@grimberg.me>
Date: Mon, 23 Nov 2020 11:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_141629_055059_360A5978 
X-CRM114-Status: GOOD (  22.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "George, Martin" <Martin.George@netapp.com>,
 Anton Eidelman <anton@lightbitslabs.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> How can the namespace reference an ANA group that we haven't been
>>>> notified about using the NVME_AEN_CFG_ANA_CHANGE AEN before?
>>>
>>> Well, I think that could be possible for a newly created namespace,
>>> which happens to belong to a new ANA group. To quote the 1.4 spec in
>>> context of Asymmetric Namespace Access Change under the Asynchronous
>>> Event Information - Notice (Figure 147):
>>>
>>> "A controller shall not send this event if:
>>> a) the change is due to the creation of a namespace (refer to section
>>> 5.20); or
>>> b) the change is due to the deletion of a namespace (refer to section
>>> 5.20),
>>> as the Namespace Attribute Changed event is sent for these changes."
>>>
>>> So it looks the NVME_AEN_CFG_ANA_CHANGE AEN is not required here for
>>> such cases, but instead the NVME_AEN_CFG_NS_ATTR AEN would do.
>>
>> For the newly created namespace to beong to a newly created ANA group
>> the controller first needs to send NVME_AEN_CFG_ANA_CHANGE to announce
>> the ANA group, it then send NVME_AEN_CFG_NS_ATTR to announce the
>> new namespaces.  But the new namespace can't reference an ANA group
>> that didn't exist, that is a separate event.
> 
> That sequence would have a group with no namespaces, which I is okay,
> but we can tolerant targets that don't use that sequence without much
> difficulty. This ought to do it:

This looks like a good simple solution to me...

> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 74896be40c17..300cff8c616d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -667,6 +667,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		if (desc.state) {
>   			/* found the group desc: update */
>   			nvme_update_ns_ana_state(&desc, ns);
> +		} else {
> +			nvme_read_ana_log(ctrl);
>   		}
>   	} else {
>   		ns->ana_state = NVME_ANA_OPTIMIZED;
> --
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
