Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF4C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9s+SXp+g+AQAQz+vbZSb/AohbwUDoxoz67Iq0buTOXQ=; b=GTRgtiRqqfkrhvC1vWe5AsJwyi
	3wvnAUIWR/TuxrCqSbeieJ2m6ZEzlQMPG4nuPQoB6Hd1SajXCag68Q+Ozv/8T0KYaIqpHcWq9CUih
	ST8891gUP0WpHC/19ZyFJ0O4g8jSQ4HBY0ZrmJI5cPXojA92Xk/DHC/qLR4uTJLkleMYWHtvincde
	rSVoSTJwzIKXJmnP+kULU9fs18RLtA+2stsWUZxLexODDM9PFD87zOvBwUptQ5Pns8cm+tR6gnbWH
	cyDzjg1eepFJb3JuK8k6FbVx/LgCzcfg/KjHOP8c/3i5Vwza9ujdRUxEzS38fV93ple/xc6xAXTuH
	TPfqJlWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwJCf-00000007nwE-2SO2;
	Mon, 15 Apr 2024 10:04:45 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwJCY-00000007nv8-1a6I
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 10:04:44 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4165a253b39so331315e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Apr 2024 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175476; x=1713780276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s+SXp+g+AQAQz+vbZSb/AohbwUDoxoz67Iq0buTOXQ=;
        b=cTrk0xV0D3BkZtUC9X+Q6IKzj4CBvAtHLDKs81OfiRMI7D2D7Cf1HquVy+hyCajAVC
         fRppiINW6WK7M0W6strORSoL9n80oyDwf8D/lUYJjYFRWiEDqM0qx7I8sPkptJOpt94h
         otmr/7E1LjIKdpcZkzxw48RwF8Y8lnBKEpX3TLJ4OR0sM/02lRCVuHx1Gok2Ow6ZJqT9
         uG/7x65+zKztmZ7ZBYQ5RH1TSf4zqAIxT7nNrEGodQMsucJUodVzW0u3cPTj8IaIQDUx
         b/RVs1TnAaV2ph+NInFw7A42mHUABaOQyHTr47vAWbBCVS/k9m/Wpwkq1Ov0erMAHEDS
         6JnA==
X-Forwarded-Encrypted: i=1; AJvYcCXwNdiSqyiM6GgcE6dxfC8O31JmyKachJ8J9UyTkAC+CoBCP0kpxdeVpExG28Fo6khOMHY8VdR1tNP93AXll1MO6QjpTx/dygimdnTQjyE=
X-Gm-Message-State: AOJu0YwAmPFw7OkXprsGJmqd+s5BYnSQTTGMqL58SnVA5o3KAuQft+EQ
	5pdRypIj5rElXlQkBAJQ+CaBRjiBn1ieu0O3rBWub3NA4OcvCB67
X-Google-Smtp-Source: AGHT+IEH85n7dr5xCVs6ujtnrfaWXfQ4+Mnb9uu6eJ3YMg6RfuAfnJb1bxoDHWque+EOPiVRNmTVrg==
X-Received: by 2002:a05:600c:3b1f:b0:416:7b2c:df05 with SMTP id m31-20020a05600c3b1f00b004167b2cdf05mr6928244wms.1.1713175476107;
        Mon, 15 Apr 2024 03:04:36 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b00417e5b71188sm14119075wmo.34.2024.04.15.03.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 03:04:35 -0700 (PDT)
Message-ID: <c9c454ea-075a-40f0-bee9-42eaa5f1b427@grimberg.me>
Date: Mon, 15 Apr 2024 13:04:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, gjoyce@linux.ibm.com, axboe@fb.com
References: <20240413090614.678353-1-nilay@linux.ibm.com>
 <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
 <ffcfbe15-8e6f-422a-87cd-52c30ebf726c@linux.ibm.com>
 <81a64482-1b02-43b2-aacd-9d8ea1cea23c@grimberg.me>
 <7b188849-5c3f-45ff-9747-096ffdaff6ee@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7b188849-5c3f-45ff-9747-096ffdaff6ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_030438_548412_ABF7F0AD 
X-CRM114-Status: GOOD (  20.00  )
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



On 15/04/2024 12:30, Nilay Shroff wrote:
>
> On 4/15/24 14:25, Sagi Grimberg wrote:
>>
>> On 14/04/2024 14:02, Nilay Shroff wrote:
>>> On 4/14/24 14:00, Sagi Grimberg wrote:
>>>> On 13/04/2024 12:04, Nilay Shroff wrote:
>>>>> On numa aware system where native nvme multipath is configured and
>>>>> iopolicy is set to numa but the nvme controller numa node id is
>>>>> undefined or -1 (NUMA_NO_NODE) then avoid calculating node distance
>>>>> for finding optimal io path. In such case we may access numa distance
>>>>> table with invalid index and that may potentially refer to incorrect
>>>>> memory. So this patch ensures that if the nvme controller numa node
>>>>> id is -1 then instead of calculating node distance for finding optimal
>>>>> io path, we set the numa node distance of such controller to default 10
>>>>> (LOCAL_DISTANCE).
>>>> Patch looks ok to me, but it is not clear weather this fixes a real issue or not.
>>>>
>>> I think this patch does help fix a real issue. I have a numa aware system where
>>> I have a multi port/controller NNVMe PCIe disk attached. On this system, I found
>>> that sometimes the nvme controller numa id is set to -1 (NUMA_NO_NODE). And the
>>> reason being, my system has processors and memory coming from one or more NUMA nodes
>>> and the NVMe PCIe device is coming from a NUMA node which is different. For example,
>>> we could have processors coming from node 0 and node 1, but the PCIe device coming from
>>> node 2, and we don't have any processor coming from node 2, so there would be no way for
>>> Linux to affinitize the PCIe device with a processor and hence while enumerating PCIe
>>> device kernel sets the numa id of such device to -1. Later if we hotplug CPU on node 2
>>> then kernel would assign the numa node id 2 to the PCIe device.
>>>
>>> For instance, I have a system with two numa nodes currently online. I also have
>>> a multi controller NVMe PCIe disk attached to this system:
>>>
>>> # numactl -H
>>> available: 2 nodes (2-3)
>>> node 2 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>> node 2 size: 15290 MB
>>> node 2 free: 14200 MB
>>> node 3 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>>> node 3 size: 16336 MB
>>> node 3 free: 15075 MB
>>> node distances:
>>> node   2   3
>>>     2:  10  20
>>>     3:  20  10
>>>
>>> As we could see above on this system I have currently numa node 2 and 3 online.
>>> And I have CPUs coming from node 2 and 3.
>>>
>>> # lspci
>>> 052e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
>>> 058e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
>>>
>>> # nvme list -v
>>> Subsystem        Subsystem-NQN                                                                                    Controllers
>>> ---------------- ------------------------------------------------------------------------------------------------ ----------------
>>> nvme-subsys3     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme1, nvme3
>>>
>>> Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces
>>> -------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
>>> nvme1    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0          nvme-subsys3 nvme3n1
>>> nvme3    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0          nvme-subsys3 nvme3n1, nvme3n2
>>>
>>> Device       Generic      NSID       Usage                      Format           Controllers
>>> ------------ ------------ ---------- -------------------------- ---------------- ----------------
>>> /dev/nvme3n1 /dev/ng3n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
>>> /dev/nvme3n2 /dev/ng3n2   0x2          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme3
>>>
>>> # cat ./sys/devices/pci058e:78/058e:78:00.0/numa_node
>>> 2
>>> # cat ./sys/devices/pci052e:78/052e:78:00.0/numa_node
>>> -1
>>>
>>> # cat /sys/class/nvme/nvme3/numa_node
>>> 2
>>> # cat /sys/class/nvme/nvme1/numa_node
>>> -1
>>>
>>> As we could see above I have multi controller NVMe disk atatched to this system. This disk
>>> has 2 controllers. However the numa node id assigned to one of the controller (nvme1) is -1.
>>> This is because on this system, currently I don't have any processor coming from a numa node
>>> where nvme1 controller numa node could be be affinitized.
>> Thanks for the explanation. But what is the bug you see in this configuration? panic? suboptimal performance?
>> which is it? it is not clear from the patch description.
>>
> I didn't encounter panic, however the issue here is with accessing numa distance table with incorrect index.

Yes, I agree its not guaranteed that all arch implementation would have 
a correct bounds check.

