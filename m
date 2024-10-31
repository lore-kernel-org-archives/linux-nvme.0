Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EBFE68956
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LwgMkb8ut4jTxsyEaRBZMFM0/cuzsA9ibolCS88Td+g=; b=iJsiZgkjeS9dawnEpLG8vI6gin
	zFRn3hBew3o1grQsmi4ALW8qMgCFZfdjQZkwkZVk5/iyeIY+x9KvuOLqDtWIHMG4EJUJmB3LPhn32
	mHFXDbVYg9Q8ytLoyHrY0vswMd1rWhDH7owK/fWhJBPEF4MEXiQN+qaFzhlal8SG3rAqG0eMgyqDz
	b5kQ13vGaEIhr8k6l8j+MwUalTGsgqO6K/clNrCaRTbwKKG0ucvVSUIclYAeT2VX1YTdCV/u5Fspe
	AWdMjKt7S3OsMvms8KSckiN2zQ9f9/wJXR5hwwtMq9nRQLl8gNaN/WQVxKjtM1Rl2m6vblyuqjlcB
	XXU6FD+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P5r-00000002jDq-2Oq3;
	Thu, 31 Oct 2024 06:55:43 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P5o-00000002jDL-0yO0
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730357735; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LwgMkb8ut4jTxsyEaRBZMFM0/cuzsA9ibolCS88Td+g=;
	b=TtTiMngmoXD78rFJS6d+w1A5ziBK6DXNxh66yBXVFZYtym9YxWx+scMHhvakoc13prOXYzxr3IbFnUDdYg/Ul8VLghfdG5ZSpkyTqlzbhrp4JgX0T/ai5TIO43krhzWX8nUEmzMBRCrHOYHyfeCcMS80Hn+MTyZJnrdSfSmNCxw=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIHUZfB_1730357731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 14:55:32 +0800
Message-ID: <ecf925c2-cbdf-4f09-8842-f8d4ab1137a1@linux.alibaba.com>
Date: Thu, 31 Oct 2024 14:55:31 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
 <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
 <1996168e-be7b-4811-91dd-c7782e955b30@nvidia.com>
 <ff0840eb-5b41-48df-9887-3539275761a1@linux.alibaba.com>
 <8A92B3EF-64FF-4ED0-BF4E-5BB6680B8FA8@nvidia.com>
 <613fd580-6faa-4b1f-96e9-ce306da27fdc@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <613fd580-6faa-4b1f-96e9-ce306da27fdc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_235540_746353_84A602B2 
X-CRM114-Status: GOOD (  13.11  )
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


在 2024/10/31 14:39, Chaitanya Kulkarni 写道:
> On 10/30/24 19:45, Chaitanya Kulkarni wrote:
>>> I will send the v2 with our usecase to expain why we should restrict the cpumask,
>>>
>>> I'm concerned whether blktests can handle such complex tests, as it relies on deploying
>>>
>>> many Docker containers and services. Should it only test the case of setting the cpumask
>>>
>>> with fio?
>>>
>>> Best Regards,
>>>
>>> Guixin Liu
>>>
>> For now just cpumask and fio is sufficient so that when we upstream this patch we have some sort of testing done via sysfs.
>>
>>
>> -ck
> based on my very limited understanding I've written a rough blktest
> for your patch see if this helps, it's bit rough and totally
> untested  :-
>
> #!/bin/bash
> # SPDX-License-Identifier: GPL-3.0+
> # Description: Test `nvmet_wq` cpumask sysfs attribute with NVMe-oF and
> fio workload
>
> . tests/nvme/rc
>
> DESCRIPTION="Test nvmet_wq cpumask sysfs attribute and verify with fio
> on NVMe-oF device"
>
> requires() {
>       _nvme_requires
>       _have_fio
>       _require_nvme_trtype_is_fabrics
> }
>
> test() {
>       local cpumask_path="/sys/devices/virtual/workqueue/nvmet_wq/cpumask"
>
>       # Check if cpumask attribute exists
>       if [[ ! -f "$cpumask_path" ]]; then
>           SKIP_REASONS+=("nvmet_wq cpumask sysfs attribute not found.")
>           return 1
>       fi
>
>       # Save original cpumask value
>       local original_cpumask
>       original_cpumask=$(cat "$cpumask_path")
>       echo "Original cpumask: $original_cpumask"
>
>       # Set a new cpumask (e.g., CPU 0)
>       echo 1 | tee "$cpumask_path" > /dev/null
>       local new_cpumask
>       new_cpumask=$(cat "$cpumask_path")
>
>       if [[ "$new_cpumask" != "1" ]]; then
>           echo "Test Failed: cpumask was not set correctly"
>           return 1
>       else
>           echo "Test Passed: cpumask set to $new_cpumask"
>       fi
>
>       # Set up NVMe-over-Fabrics target
>       echo "Setting up NVMe-oF target"
>       _setup_nvmet
>       _nvmet_target_setup
>       _nvme_connect_subsys
>
>       # Locate the NVMe-oF namespace
>       local ns
>       ns=$(_find_nvme_ns "${def_subsys_uuid}")
>
>       # Run fio with data verification on NVMe-oF device
>       echo "Starting fio workload with verification on NVMe-oF device"
>       fio --name=nvmet_wq_test --filename="/dev/$ns" --direct=1
> --rw=randwrite \
>           --bs=4k --size=100M --numjobs=1 --verify=crc32c --verify_fatal=1 \
>           --time_based --runtime=30s --iodepth=16 --ioengine=libaio
> --group_reporting
>
>       # Disconnect and clean up NVMe-oF target
>       echo "Cleaning up NVMe-oF setup"
>       _nvme_disconnect_subsys
>       _nvmet_target_cleanup
>
>       # Restore original cpumask
>       echo "$original_cpumask" | tee "$cpumask_path" > /dev/null
>       restored_cpumask=$(cat "$cpumask_path")
>
>       if [[ "$restored_cpumask" != "$original_cpumask" ]]; then
>           echo "Failed to restore original cpumask."
>           return 1
>       else
>           echo "Original cpumask restored successfully."
>       fi
> }

The script looks good, thank you for adding the new test to my patch.

Best Regards,

Guixin Liu


