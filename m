Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:52:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B6E64F55
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B6E64F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6w0A7jrIFpBEav5eGZeii9Wuyt1cTC74i6jaNwVd2l0=; b=v9YUghEhhUgYR2jTQ0TXhhT8j
	SbArh/nFCFiwJz6kSHeXaQQEnlAcSFaoRlpC2/GMVMrLBc6lLus/lg86LkI9T7/heR5CJvUwV1ebr
	oWIcHR0Jt5Sh6DQAkSQEx/ndRy3NdsLagSuodki9VRVaHLQUxEyZUzzyzkIggnpFr9J9MJX+d/oqH
	J5JLE4vEKDNoQdSocShILw+KdaNMEe1WvG8paZB6kclYmJlKqnCJ76a6OnwJcl9Isw/aMfVoCSlWk
	glQ8Um4fvy+s4tM3ZzgpOsVm/pU6dGty5cCwx8lImDsUQ1jQsMLeoHE7tI7HQh3fL6fhstV0EAjCl
	HAZDCMkvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7ZQu-0000Df-DX; Thu, 04 Feb 2021 07:52:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ZQs-0000Cf-87
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:52:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F2D6FAC97;
 Thu,  4 Feb 2021 07:52:04 +0000 (UTC)
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
To: Martin Wilck <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <60846bb5-c0df-ac23-260b-b53afd48f661@grimberg.me>
 <d8956cf973867ad7cc6c4d968682ec3db3054aa3.camel@suse.com>
 <d8e35845-31d3-a46d-b464-728d751d0b33@grimberg.me>
 <26138a83eee9362b1769940f6da86387716ab2d8.camel@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1d039cca-ce24-f8c8-1d75-9056747e2ffe@suse.de>
Date: Thu, 4 Feb 2021 08:52:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <26138a83eee9362b1769940f6da86387716ab2d8.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_025206_509125_060F5973 
X-CRM114-Status: GOOD (  35.20  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/29/21 9:27 PM, Martin Wilck wrote:
> On Fri, 2021-01-29 at 12:08 -0800, Sagi Grimberg wrote:
>>
>>>>>
>>>>> This method for discovery and autodetection has some advantages
>>>>> over the
>>>>> current udev-rule based approach:
>>>>>
>>>>>  =A0=A0 * By using the `--persistent` option, users can easily
>>>>> control
>>>>> whether
>>>>>  =A0=A0=A0=A0 persistent discovery controllers for discovered transpo=
rt
>>>>> addresses should
>>>>>  =A0=A0=A0=A0 be created and monitored for AEN events. **nvme monitor=
**
>>>>> watches known
>>>>>  =A0=A0=A0=A0 transport addresses, creates discovery controllers as
>>>>> required,
>>>>> and re-uses
>>>>>  =A0=A0=A0=A0 existing ones if possible.
>>>>
>>>> What does that mean?
>>>
>>> In general, if the monitor detects a new host_traddr/traddr/trsvcid
>>> tuple, it runs a discovery on it, and keeps the discovery
>>> controller
>>> open if=A0--persistent was given. On startup, it scans existing
>>> controllers, and if it finds already existing discovery
>>> controllers,
>>> re-uses them. These will not be shut down when the monitor exits.
>>
>> And if it doesn't run with --persistent it deletes them? even if
>> these
>> weren't created by it?
> =

> No, not those. That's what I wanted to express with "These will not be
> shut down when the monitor exits."
> =

> It's not trivial to determine reliably which controller the monitor
> created and which it didn't. The current code assumes that all
> discovery controllers that didn't exist at startup were created by the
> monitor. We can improve the intelligence of the tool in that area, of
> course. Currently it makes this dumb assumption.
> =

>>
>> And, if none exist where does it get new discovery controller
>> details?
>> Today we use discovery.conf for that.
> =

> As I said, this can be done with a separate "nvme connect-all" call,
> which could be run from an ExecStartPre or from a separate service.
> Or we can integrate the functionality in the monitor. I don't have a
> strong opinion either way. I can adapt to what you guys prefer.
> =

>>
>>> This allows users fine-grained control about what discovery
>>> controllers
>>> to operate persistently. Users who want all discovery controllers
>>> to be
>>> persistent just use --persistent. Others can set up those that they
>>> want to have (manually or with a script), and not use --persistent.
>>>
>>> The background is that hosts may not need every detected discovery
>>> controller to be persistent. In multipath scenarios, you may see
>>> more
>>> discovery subsystems than anything else, and not everyone likes
>>> that.
>>> That's a generic issue and unrelated to the monitor, but running
>>> the
>>> monitor with --persistent creates discovery controllers that would
>>> otherwise not be visible.
>>>
>>> Hope this clarifies it.
>>
>> Well, How do people expect to know if stuff change without a
>> persistent
>> discovery controller? Not sure if people may see more discovery
>> controllers this is a real issue given what they are getting from it.
> =

> You're right. At this very early stage, I wanted to give users the
> freedom of choice, and not force dozens of discovery controller
> connections upon everyone. If there's consensus that the discovery
> connections should always be created, fine with me.
> =

> =

I would make the monitor code to always create persistent discovery =

connections.
(Or, at least, _attempt_ to create persistent discovery connections.)

_if_ the user starts the monitor he will have a reason for it; and that =

reason typically is that he _wants_ the system to react on discovery =

changes.
And that is precisely why persistent discovery controllers exist.

Plus there is a provision in the spec allowing the controller to reject =

persistent connections, so if the controller is worried about increased =

resource consumption he can just disallow persistent controller connections.

Similarly, I would keep the created discovery connections after exit.
Currently the simple reason is that we don't store the information from =

the created discovery connections, so if we tear them down on exit we =

won't be able to recreate them once we restart the monitor.

This situation might change with once we have mDNS integration; and, of =

course, for FC figuring out this information is trivial.

>>> I agree. But it's not easy to fix the issue otherwise. In the
>>> customer
>>> problem where we observed it, I worked around it by adding the udev
>>> seqnum to the "instance name" of the systemd service, thus allowing
>>> several "nvme connect-all" processes to run for the same transport
>>> address simultaneously. But I don't think that would scale well;
>>> the monitor can handle it more cleanly.
>>
>> Still changing the entire thing for a corner case...
> =

> It's just one puzzle piece.
> =

And it's actually not a corner case, but a real issue we're seeing in =

our (or rather, our customers) deployments.
AENs are being received at the same time, causing 'nvme discover' to run =

in parallel with the same information.
A very nice exercise in finding all race conditions in the code.
And completely pointless to boot.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
