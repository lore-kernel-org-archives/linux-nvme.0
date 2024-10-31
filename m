Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39648E68956
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwqcbDZniNJTa4+zYOZiBWlp3GvB0JL1yPG2eDRFz3U=; b=uzYJ7METRhFHsmpl7Gyl5j/8ji
	Jfg/hlfQayiYi+n4w0gCMegeHoFMlCCQPLzLEsGgdKbYuYQ5TawqFX/vmSb0RlXncXVs1y+qt713j
	/+hcgio6FI6lt8aLnV7v3UcYMnkbv3KopURx5UWdxiyCWIf6v5hE/23Q5jteZXFAMSODO8sxBcfxl
	Q2uReFUu/9B37pzOjIuUjKfuGJUjcnHncNkFU88q05an5RRTyO41LxanECAd1ER7RGKau3MjdkAz5
	+MsPIty6Z3OaZ7guKH0oDxX/yYqDZG3327caK61dlw1lVQwJKdHRrcHdtcR669eGq259RgHhBOWET
	xE19X24g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6OpG-00000002hbo-1AMn;
	Thu, 31 Oct 2024 06:38:34 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6OpD-00000002hb3-2Z1v
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730356709; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nwqcbDZniNJTa4+zYOZiBWlp3GvB0JL1yPG2eDRFz3U=;
	b=HB5e3h4pFr3IYZbl1JlOfc0nowvlBdyQMuaHCOIeb2KNqvqYXe81nkhhXoWj/Ayez6E/2hQcT2zjbC7moedlxS8xkWp8rxg0h6PZT2WlwePGoPacBLFA6kMilUXlW3EBQhWeu9bfSBWV70bsJszlI+RSQUhD8TahCCCXliy9KNA=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIHJON4_1730356706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 14:38:28 +0800
Message-ID: <74fd4aa7-5d58-4493-a718-673143611989@linux.alibaba.com>
Date: Thu, 31 Oct 2024 14:38:25 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241031022720.27202-1-kanie@linux.alibaba.com>
 <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_233831_878196_C97D3671 
X-CRM114-Status: GOOD (  13.13  )
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


在 2024/10/31 14:23, Chaitanya Kulkarni 写道:
> On 10/30/24 19:27, Guixin Liu wrote:
>> In some complex scenarios, we deploy multiple tasks on a single machine
>> (hybrid deployment), such as:
>>     1. Docker containers for function computation (background processing).
>>     2. Docker containers for real-time tasks.
>>     3. Docker containers for monitoring, event handling, and management.
>>     4. An NVMe target server.
>> Each of these components is restricted to its own CPU cores to prevent
>> mutual interference and ensure strict isolation. Additionally, we make
>> the nvmet_wq visible in sysfs, allowing for tuning its attributes
>> through sysfs, such as cpumask.
>
> How about following ? no need to send V3 can be done at
> the time of applying the patch if you are okay with it :-
>
> " In  some complex scenarios, we deploy multiple taskson  asingle  machine
> (hybrid deployment), suchas  Docker containersfor  function  computation
> (background processing), real-time tasks, monitoring,event  handling,
> and  management, alongwith  an NVMe target server.
>
> Each  of  these componentsis  restrictedto  its own CPU coresto  prevent
> mutual interferenceand  ensurestrict  isolation.To  achieve this level
> of  isolation for nvmet_wq we needto  use sysfs tunables such as
> cpumask that are currently not accessible.
>
> Add WQ_SYSFS flag to alloc_workqueue() when creating nvmet_wq so
> workqueue tunables are exported in the userspace via sysfs.
>
> with this patch :-
>
> nvme (nvme-6.13) # ls /sys/devices/virtual/workqueue/nvmet-wq/
> affinity_scope  affinity_strict  cpumask  max_active  nice  per_cpu
> power  subsystem  uevent
>
> "
>
> With that looks good.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
Thanks for tunning the commit message, the new content looks good,

but I see some words are joined together, "coresto" -> "cores to",

"interferenceand" -> "interference and", and so on.

Please change this when you applying the patch.

Best Regards,

Guixin Liu


