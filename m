Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E78FC83030
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhuS84hSOQt0uRcZgKJ1vRg95j8tQVHeFUW1xUTAPH8=; b=SZqSTxinvZQqjexrNC48gvWQTq
	QwiNp8iYF+lYAbqaSlQHETdh4e69XfwhsFhAfEGsVxjrx1iTqHMFlUv87lm+pbOEOkelU2WZPhaxz
	xkaP3phYPGsRTHl5MX/eq70I/KaP3J9qP8W6ScE414US7uDFgIK3aEmcVGYk5gGMAurwrdOHiiasE
	OnbOIxPf+tb9APWDHIinSzMKh6fjIEdF3aYBq1jqNi7cSyYjyWvWMwL3jIyxrmEidWfZ1hqKIKFdL
	WOYP7TaQDIgimzetaM+PmhalpuycTSUj6E8vjqKhLbEK28+z94Rd46LAB2jXg3+Ys0AXd6+peRNJT
	W910nVmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYsmb-00000003Zbq-2Wbo;
	Mon, 07 Jul 2025 20:49:49 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYsmZ-00000003ZbT-2m96
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 20:49:48 +0000
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-7387f21daadso2887917a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Jul 2025 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751921386; x=1752526186; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhuS84hSOQt0uRcZgKJ1vRg95j8tQVHeFUW1xUTAPH8=;
        b=TDTsZJwUmpW/slBtba1S9hz3PQk/IB/3BYcFA8wzz5wOBSMNhH5CbWOFgdOhhIqo91
         jrLAJzU5xx+FTdC1FSnIt4bSv1BH7oGgQnaRWK+uJnGr4J3LBusqZ2i5zt72taIttbq0
         ZkR8Xi8QGLs89kFLFyKwKDxCFRpp3Ntm08G3XwMw7Kn6D841HUXwHFVf5jiLmdfn3fhp
         U0e29xm5/8/oAWhLXdDdN/3GoBjte+QyIMwxi/fs1H5eFy2/MXWsG9hjeSUeEQxv1hAN
         7ETapv+4iVtupeFnYe4+EDwLVHw/rySSmNREkyRVHyVoaWuHwp8H2rajOHp727lttxdX
         0ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921386; x=1752526186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhuS84hSOQt0uRcZgKJ1vRg95j8tQVHeFUW1xUTAPH8=;
        b=iySbLaesc4TP8G4dW+Mz+grmKN5yCoTvczQ5Zlc+bvxFnjme3D6EpyMTjHcydJO3U9
         x/ZEsWjd73UKxZ9KDllLfkWFzWNOD1XGe9Yn5wJDsFzfS2BKWDepMbK2xEjBnq/7l51m
         IEFa2logdBftOSbddwgsmu0gqV50cZingk5xaVzD4IVrnKAwtzGYxXLZ8ocl5CDO21ak
         JAo/LDmgswicS3jVwVuP2itQ/WQGtoMXSUWzS3RtWt1oCo79W2uzGJhLQoX7v4CBpw4g
         CLy1FQqDirbtKqMNNlmIHgiUIy31gGR56JY9ZBruBOXqpFrm1hCrhtTqs40iF3s+ZuDl
         bBPw==
X-Forwarded-Encrypted: i=1; AJvYcCWRfW/Qhv3jqVlKl1OgvLtu44rJcIT4TD7pICronioe9+TS++QqbAx33xPDUNzvlsko+1x55i+XFrk/@lists.infradead.org
X-Gm-Message-State: AOJu0YxCsMN8E6Vp/O00iBKz/6xppbZHexlwbfZQSQtRKUy0MaMKznv2
	ui36SJx0UrmXIXO2woHI6dwbDXQE9wykiqbqbX6sUh3qwhKNuXgzL9Ck
X-Gm-Gg: ASbGncvOLbxFnKnoNkmbCNIXjBpfAcQiJe8/xVUst71AfpewBBRMiPoCsPo8UDweNwH
	qi0WdZIWgY53tr2CKVse/lLgKof7jq1H8l6AyLnr8atZMuY+QeDIsnRP+RzwsW5BpcskF9aDWsw
	v5xub3oqgg5RsXu+jipiZbT1SrcvKDaLmThfeTrH3JQmI7QL+JdNlO7pX2lt6oS0SWArc+ctXME
	0Dz8qWb5/1eVZIU0XRVvQ2du1Es87/piByyWTwRgRf955HufI9L9HsykS61Z1YyLF+zC2HzUFyp
	/jyotG2F7iHWUlrZHsuDiiG7jAYFun4qcDOb7InemFhCGtLgOXNAKXc2ffNsmgpPOkgSknPFmvK
	mnSFyJXW+0pnlfTFvBJbUMsQyrv5BcMzIfqljTlV6cfGv1l0=
X-Google-Smtp-Source: AGHT+IE0m3KiMcrUCPn36GAt4PUQHG1cRife0ZxrezKMpHjq87MM6KoumROGi7AszjAdUQlehbGN4w==
X-Received: by 2002:a05:6830:3688:b0:73a:8a05:cd3d with SMTP id 46e09a7af769-73cd7774ca3mr176859a34.0.1751921386367;
        Mon, 07 Jul 2025 13:49:46 -0700 (PDT)
Received: from [192.168.1.7] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm1701930a34.44.2025.07.07.13.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:49:45 -0700 (PDT)
Message-ID: <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
Date: Mon, 7 Jul 2025 15:49:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: David Jeffery <djeffery@redhat.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>,
 Bert Karwatzki <spasswolf@web.de>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de> <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_134947_699943_D03D2387 
X-CRM114-Status: GOOD (  33.88  )
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

On 7/7/2025 10:34 AM, David Jeffery wrote:
> On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>>
>> On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
>>> On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
>>>>
>>>> On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
>>>>> On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
>>>>>> Address resource and timing issues when spawning a unique async thread
>>>>>> for every device during shutdown:
>>>>>>    * Make the asynchronous threads able to shut down multiple devices,
>>>>>>      instead of spawning a unique thread for every device.
>>>>>>    * Modify core kernel async code with a custom wake function so it
>>>>>>      doesn't wake up threads waiting to synchronize every time the cookie
>>>>>>      changes
>>>>>
>>>>> Given all these thread spawning issues, why can't we just go back
>>>>> to the approach that kicks off shutdown asynchronously and then waits
>>>>> for it without spawning all these threads?
>>>>
>>>> It isn't just an nvme issue. Red Hat found the same issue
>>>> with SCSI devices.
>>>>
>>>> My colleague Sultan Alsawaf posted a simpler fix for the
>>>> earlier patch here:
>>>>
>>>> https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
>>>>
>>>> Maybe this could be explored.
>>>>
>>>
>>> Unfortunately, this approach looks flawed. If I am reading it right,
>>> it assumes async shutdown devices do not have dependencies on sync
>>> shutdown devices.
>>
>> It does not make any such assumption. Dependency on a sync device is handled
>> through a combination of queue_device_async_shutdown() setting an async device's
>> shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
>> for a sync device when it encounters a sync device that has a downstream async
>> dependency.
>>
> 
> Yes, but not what I think fails. This handles a sync parent having an
> async child. It does not handle the reverse, a sync child having an
> async parent.
> 
> For example, take a system with 1 pci nvme device. The nvme device
> which is flagged for async shutdown can have sync shutdown children as
> well as a sync shutdown parent. The patch linked pulls the async
> device off the shutdown list into a separate async list, then starts
> this lone async device with queue_device_async_shutdown from being on
> the async list. The device then is passed to the async subsystem
> running shutdown_one_device_async where it will immediately do
> shutdown due to a zero value shutdown_after. The patch sets
> shutdown_after for its parent, but there is nothing connecting and
> ordering the async device to its sync children which will be shutdown
> later from the original device_shutdown task.
> 
>>> Maintaining all the dependencies is the core problem and source of the
>>> complexity of the async shutdown patches.
>>
>> I am acutely aware. Please take a closer look at my patch.
>>
> 
> I have, and it still looks incomplete to me.
> 
> David Jeffery
> 

Also, the way it is implemented, it could hang if there isn't enough 
memory to queue up all of the async device shutdowns before starting the 
synchronous shutdowns.

When you call async_schedule_domain() and there's not enough memory to 
allocate an async_entry, the async function will be run immediately. If 
that happens when queuing up the async shutdowns, it could easily hang 
if there if there are any dependencies requiring an async device 
shutdown to have to wait for a synchronous device to shutdown, since 
none of the synchronous shutdown devices have been scheduled yet.

Before your patch, all device shutdowns are scheduled in order such that 
if the call to async_schedule_domain() runs the function immediately, it 
will still be able to complete, it just won't get the benefit of 
multiple threads shutting down devices concurrently. The V10 patch 
maintains that--it just lets one thread shut down multiple synchronous 
devices instead of creating one thread for each synchronous device shutdown.

