Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5DC2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:07:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59928613C3
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59928613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DrCQ5ctewXBYGRE9p9nBURSEotkaetNHkbceZpnvfQI=; b=vusG8M/N8h29SIXHCRh1OpqLKY
	rpmerxOP3+BBCm8WBFAvUK04RP2n7iRhYT9+SeAn/wvyL2VxlxhAD+5r5EVchyLQvakaQvafzAtt6
	5BGcUs/nSazDXZilReLb/wZrMIDZlSyrvVhAhaXtKvqLi6+EZKHweDqgKNOyqEtQSB3i27QqUZFZU
	EafvxsFhVtiaeYiFU5hw4PVrlyH9H4v4HPbxHBVzYg2XZ+4ehNzPn60U/xdXx4RXoUmYRtduKNx/H
	ye3g0hVOTN8V58L3xQQJGW4ojKRM9qcVwyL4hD/7Xg5KtD1WyMvc4BCWj9hIFSMCMlEZTvo85KSzc
	pz1BEs+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llpVd-00CjhR-4e; Wed, 26 May 2021 09:07:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpHO-00Cdb1-H9
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622019161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQPfSnETSseVWiExkFA/etHdPSwB4Ni3KHdyItnko7w=;
 b=Vejo8xOY+aV/4nmVpWJRmDgOtOvFyPgOIA3nzilM5cMBYOJzq8Ttk3TYaQXL2VcD2Gnb3V
 dOt/n+vqD3U1fHatt8i6EHYixkXs7/bXusT7XOjr+TjxCyBe2HfCxysMhCVn6V8Xw+guzO
 V7Od0CQeScZw8y+v5VyfNlwj7b5Uuzs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-wBzUWfeUM4a8xF9Bl-aYdw-1; Wed, 26 May 2021 04:52:37 -0400
X-MC-Unique: wBzUWfeUM4a8xF9Bl-aYdw-1
Received: by mail-ed1-f71.google.com with SMTP id
 w1-20020aa7da410000b029038d323eeee3so160509eds.8
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 01:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KQPfSnETSseVWiExkFA/etHdPSwB4Ni3KHdyItnko7w=;
 b=TLvDEjW0aMkenInnq8njGjFfZY125HS/HVGrne//qBNYlb/3fvPfucwM86i73q/FEp
 G0HGlvEFvJD/zQIAuT0qy1uJXT6fNk4kusTurKNAE7l+d/Z3NFhWQoa9+qljOis87CCf
 yxm8OsOevVAbkPsuJJCQjHInlgpfHhGPMVwz9oNFEeFxfU3tTVFOE0mGm5Db1jCGYzRS
 AerI6T6d2GdsdAkk/3h9BJbn9JZIhLwLfxg6UNcwuddtdBpKmoTiVYi7KtOfX6jyyoKZ
 jvoR5SHf43qMCmeZxVyyVXiJiOooVdGLX4AbjUG9xCNpYPo6VbQPmOyFgerYfzc5zBVd
 S3aA==
X-Gm-Message-State: AOAM532CXvhrervsteY/nEi0Lq4HBh5kbrwNfKMItPEg8MKAGj7k+xZ7
 +SpZZ4rRxEXgMPqLmnYkdzLARGPCjiSUE1QbRmiu5dF5wPPriSeeLTE3cqcjlHURMqwcGW0D0ah
 CEBgfqRapPZz6NY5InmJHldJNQ7M=
X-Received: by 2002:a17:906:2f91:: with SMTP id
 w17mr33052757eji.443.1622019156597; 
 Wed, 26 May 2021 01:52:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtv352g2axqGmXcG8/thVikDg9HEquY/khCwSnrdKWIiZ9DaaQqYnGBOnyLLZgyQVOUq04IA==
X-Received: by 2002:a17:906:2f91:: with SMTP id
 w17mr33052733eji.443.1622019156286; 
 Wed, 26 May 2021 01:52:36 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id a21sm10111025ejy.85.2021.05.26.01.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 01:52:35 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
Date: Wed, 26 May 2021 10:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_015242_722097_3C8CD60D 
X-CRM114-Status: GOOD (  28.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 5/25/21 5:18 PM, Limonciello, Mario wrote:
> [Public]
> 
>>
>> I think what we're all missing here is that the concept of requring devices
>> to go to D3 for suspend to idle is a higher level concept.  
> 
> Ah.. so your argument being we should keep it a higher level concept in Linux
> kernel too.  IOW maybe even nvme_acpi_storage_d3 shouldn't be living 
> in drivers/nvme/host/pci.c, but somewhere else more acpi platform oriented.
> 
>> AFAIK this
>> comes from this microsoft document:
>>
>> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
>>
>> and spread from there.  Note that this document explicitly mentions AHCI
>> in addition to NVMe.  It also has some issues that I can spot:
>>
>>  - PCIe slots are not specific to storage device, so this really needs to
>>    apply to all devices
> 
> I don't disagree here but I'll point out that on the Windows side that page
> mentions that there is also:
> 1) A "global" registry key option
> 2) A hardcoded allowlist
> 
>>  - it generall is a rather bad idea to start with as each shutdown not
>>    only causes media progam/erase cycles, but also is not very power
>>    efficient.
>>
>> So what we need is a way for a driver to figure out if for a given
>> device it should shut down the device fully or just do something that
>> is efficient for saving as much as possible power.  That can be either
>> in form of a flag 
> 
> So how about a publishing a notification chain that a platform driver can
> optionally pick up and set that flag when the device is probed?  Coming
> back to my idea to throw this in amd-pmc, that could also potentially
> mean moving out the Lenovo DMI quirk and let something like
> thinkpad-acpi behave as a notifier and handle it too.
> 
> Hans, would appreciate your thoughts here.

I see that the discussion has already continued without my thoughts (good),
reading the further discussion I see that pm_suspend_via_firmware() and
pm_suspend_no_platform() have already been mentioned. Using these (or
introducing something similar for this use-case) was also my first
thought on this (after the previous options were shot down).

So I think that looking at those is going in the right direction. I notice
that Rafael Wysocki is missing from the Cc (I've added him now) I believe
that this is something which is right up his alley and he might have some
ideas on this.

Mario, can you provide a summary of the discussion so far for Rafael
(I believe you have a better picture of this then I do).

Regards,

Hans


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
