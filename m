Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD805E68958
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 07:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+oNJ9zgvwReQZwBfspUT4exKSxjfTDtM5LX1HRxOPH0=; b=kFu9RWfB83o1270HnFwwMzVpff
	GRdf9+kxAFOtkComiWsSKiLs88WM1Ob8Daf+xGZnOpayLRA19K75JTMt3oMjz11ALcLkvd32+IneT
	tbYRJbhWZNyxFCV+75gHarONQy/hQRdsmurhwERaZ/0lLfAV0gPzdHDdSSWZLdqd6ClrvXt0mR8Wj
	grZuRwvCMFT54FNLyPDHgajGXGiCutn5mH0YUr1GK2qDdDCYPUna5bOuAcKwv07hcIMQoTetW/97S
	EOrw+uOzBnmoQqHLD2ZIL/aSoR9nVCLhXlrZTKImrr0+3PNwBzPxzB4aMpxlS7uGvGjMVnLolR4W+
	H6EKgYjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6PAP-00000002k86-04Tt;
	Thu, 31 Oct 2024 07:00:25 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6PAM-00000002k7a-1tFb
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 07:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730358019; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+oNJ9zgvwReQZwBfspUT4exKSxjfTDtM5LX1HRxOPH0=;
	b=BkCMQefN7lXs4gf1JilRDCYh+42gwDheQ9pnhQSZBPqEV1O6e0FiepXpu89cw0EubCg2nqzktihLW/ocdBJHKfnS8h/AT2ptxcAyZxpLAZMwcMsIPninEwsYDHni7BuCPr5o9YlQC+EPG3Eb+uqGA5CbJLKzEuBCEuXDwi87R44=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIHPVmF_1730358017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 15:00:18 +0800
Message-ID: <be589714-9cd1-45fd-8187-8480afb81128@linux.alibaba.com>
Date: Thu, 31 Oct 2024 15:00:17 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241031022720.27202-1-kanie@linux.alibaba.com>
 <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com>
 <74fd4aa7-5d58-4493-a718-673143611989@linux.alibaba.com>
 <019d19a4-cf4e-4405-8672-b371f116da22@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <019d19a4-cf4e-4405-8672-b371f116da22@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_000022_679844_2EF34790 
X-CRM114-Status: GOOD (  12.09  )
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


在 2024/10/31 14:50, Chaitanya Kulkarni 写道:
> On 10/30/24 23:38, Guixin Liu wrote:
>> Thanks for tunning the commit message, the new content looks good,
>>
>> but I see some words are joined together, "coresto" -> "cores to",
>>
>> "interferenceand" -> "interference and", and so on.
>>
>> Please change this when you applying the patch.
>>
>> Best Regards,
>>
>> Guixin Liu
> Here is the updated one :-
>
> In some complex scenarios, we deploy multiple tasks on a single machine
> (hybrid deployment), such as Docker containers for function computation
> (background processing), real-time tasks, monitoring, event handling,
> and management, along with an NVMe target server.
>
> Each of these components is restricted to its own CPU cores to prevent
> mutual interference and ensure strict isolation. To achieve this level
> of isolation for nvmet_wq we need to  use sysfs tunables such as
> cpumask that are currently not accessible.
>
> Add WQ_SYSFS flag to alloc_workqueue() when creating nvmet_wq so
> workqueue tunables are exported in the userspace via sysfs.
>
> with this patch :-
>
> nvme (nvme-6.13) # ls /sys/devices/virtual/workqueue/nvmet-wq/
> affinity_scope  affinity_strict  cpumask  max_active  nice per_cpu
> power  subsystem  uevent
>
>
> -ck
>
Looks good now, my deepest gratitude for the tunning.

Best Regards,

Guixin Liu


