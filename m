Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAFAC4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 06:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Rfu1OCnf/sitL8sGq5PkA51LgNyfPI7YKJqeO+W9YA=; b=CZmNtispDobBGZGj66aw4swAm+
	CLxgBI5tpcrGLLUOcGonIQseeXG23NZebdOlD2cm6hc+sO89ZVsiCmi5kdoXqggLRTf7NWkzgWeZ0
	7uawebOJlg/PBk3dJCXfT9QHu3cRo+Spm+f7nQ/46bqdkIhYnn0ThEbTGD0UGgAiZNlwG64unHMy1
	4BU6Bdpa9K5NgZEgMGRUsafX7sKtbLAi8obo6bxPtlvAzRyEk+o6YjwJeXDjUt/q7muZpMAW7+d8a
	9znrYDbW2NFVcqn5+rJyLCGyb0UuWlSUZJIJy57J5cnSvCw8zsbQqE8dWkK0nY7UUwyiBa30+W5mw
	pAb8d6Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2PZh-0000000BbFg-1y27;
	Thu, 02 May 2024 06:05:45 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2PZc-0000000BbDw-0fpg
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 06:05:43 +0000
Received: from [10.50.1.206] (unknown [89.187.201.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 061BD61E5FE35;
	Thu,  2 May 2024 08:04:47 +0200 (CEST)
Message-ID: <1c826b9a-4b21-43c8-9064-c3ab095307c5@molgen.mpg.de>
Date: Thu, 2 May 2024 08:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK hynix
 PC300 NVMEe
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
 <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
 <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
 <ZjK8IjHfwpAMQajT@kbusch-mbp>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZjK8IjHfwpAMQajT@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_230540_521113_CC41BADB 
X-CRM114-Status: GOOD (  21.64  )
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

Dear Keith,


Thank you for your quick reply.

Am 02.05.24 um 00:03 schrieb Keith Busch:
> On Wed, May 01, 2024 at 10:58:05PM +0200, Paul Menzel wrote:
>> Am 01.05.24 um 09:58 schrieb Keith Busch:
>>> Exactly. Unless the device reports a lower D3 entry latency, then this
>>> sounds like everything is working-as-designed.
>>
>> Maybe according to the spec, but I have a hard time to believe, that disks
>> should take longer to shut down than coreboot to initialize a mainboard.
> 
> That doesn't seem too hard to believe to me. A safe shutdown can often
> take a while time for an SSD. I've seen other implementations orders of
> magnitude worse than what you're showing.

But why? Due to physics or due to “slow” firmware?

> You could do an unsafe shutdown instead, but the device will just
> take even more time to enable on its next power-on.

Indeed, that is does not sound good.

>> In the end, in my opinion, users cannot make an informed decision, if these
>> things are hidden. If it would be visible somehow in the logs - maybe not
>> warning but info level - then even not so technical users could inform
>> themselves and factor this in their buying decision.
> 
> What good is it to advertise a shutdown time when vendors are clearly
> unreliable at reporting an accurate value? If you need to see the driver
> report it from emperical testing, then you've already bought the device,
> right?
> 
>>> You can check your device's advertised shutdown time (assuming your
>>> device is nvme0):
>>>
>>>     nvme id-ctrl /dev/nvme0 | grep rtd3e
>>>
>>> The value is reported in microseconds. If it shows 0, then the device
>>> doesn't report an expected shutdown time.
>>
>> Thank you for sharing. It´s 60 ms:

I added some debug prints:

```
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..76857d5e8a1a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2335,6 +2335,10 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, 
bool shutdown)
  {
         int ret;

+       dev_err(ctrl->device,
+                       "XXX Enter nvme_disable_ctrl with shutdown %s\n",
+                       shutdown ? "yes" : "no");
+
         ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
         if (shutdown)
                 ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
@@ -2346,14 +2350,24 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, 
bool shutdown)
                 return ret;

         if (shutdown) {
-               return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+               dev_err(ctrl->device,
+                               "XXX before nvme_wait_ready, 
shutdown_timeout %u\n", ctrl->shutdown_timeout);
+               ret = nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
                                        NVME_CSTS_SHST_CMPLT,
                                        ctrl->shutdown_timeout, "shutdown");
+               dev_err(ctrl->device,
+                               "XXX after nvme_wait_ready\n");
+               return ret;
         }
         if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
                 msleep(NVME_QUIRK_DELAY_AMOUNT);
-       return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
+       dev_err(ctrl->device,
+                       "XXX before nvme_wait_ready, shutdown_timeout 
%u\n", (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2);
+       ret = nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
                                (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2, 
"reset");
+       dev_err(ctrl->device,
+                       "XXX after nvme_wait_ready\n");
+       return ret;
  }
  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
```

and got for “cold boot” and from ACPI S3 suspend and resume:

```
[    0.955837] nvme nvme0: XXX Enter nvme_disable_ctrl with shutdown no
[    0.955898] nvme nvme0: XXX before nvme_wait_ready, shutdown_timeout 128
[    0.961861] nvme nvme0: XXX after nvme_wait_ready
[    1.637251] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is 
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[   27.785752] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data 
block query control method not found
[   29.811581] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
[   62.697526] nvme nvme0: XXX Enter nvme_disable_ctrl with shutdown yes
[   62.697538] nvme nvme0: XXX before nvme_wait_ready, shutdown_timeout 5
[   63.110008] nvme nvme0: XXX after nvme_wait_ready
[   63.308385] nvme nvme0: XXX Enter nvme_disable_ctrl with shutdown no
[   63.308394] nvme nvme0: XXX before nvme_wait_ready, shutdown_timeout 128
[   63.308399] nvme nvme0: XXX after nvme_wait_ready
```

So this confirms the ftrace findings. Excuse my ignorance, so the 
time-out is in seconds? And how does this relate to the rtd3e value (410 
ms ≠ 60 ms ≠ 5 s(?)?


Kind regards,

Paul

