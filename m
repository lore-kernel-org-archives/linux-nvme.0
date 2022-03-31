Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2775FC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Mar 2022 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OtRqqJsGZabTr8ykV3o87td1KdWyzGvuSkxqwUlvOV0=; b=qeaIWCVdPdsBpX5TWOuOqJ75MD
	5tujA2eGQ+bsRvhbquCyCsvvK9qMQcUWvuPbxmOTJe+UwZhzZ6hlfZu/i5zC7SQO3rne9CIEnYkJH
	q+hSpFHm+INe/kDx4EcT8Yp3vt373a3Zm83Ck8Bzb5He1xDs5xN7fOAno4JxZPBVPsPyGy5f8YGHm
	bvU3+nbIYYVA1Y79AUnZyFsUpz9HrMcNX5+OP/WQUhdbRi6PUra8/pnuQc1AHTi5OQ3Psvj3d1F6h
	Kwj0AcsYnPRAnbZBUcCma8KAfl8gdkRMWhppIY6jqTd1nejjxL+R5uADW4zFKI59nR21b30RPplLx
	4NS+wFBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZy7N-0032BN-Ci; Thu, 31 Mar 2022 16:57:53 +0000
Received: from out2.migadu.com ([2001:41d0:2:aacc::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZy7I-00329N-Ia
 for linux-nvme@lists.infradead.org; Thu, 31 Mar 2022 16:57:51 +0000
Message-ID: <b43c542a-0cc6-0f60-3f7b-b16078984c4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1648745862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtRqqJsGZabTr8ykV3o87td1KdWyzGvuSkxqwUlvOV0=;
 b=TyiTmwAP7X1MRB16PXjj8l3f6KYq0MhJKsdt6gT4Ek1tYBPWA56Q0SERovHBl2K4ssOANq
 NjgiyDegx6nNsXqqkz3G0pdqVnV+zVi3uh1Snlr01HvrHVRzwHpVijFNThCUjDu7Jw2ssV
 79LisqoCftc4kqElqmLqN0x6Hx1eP3g=
Date: Thu, 31 Mar 2022 10:57:40 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
Content-Language: en-US
To: Oliver O'Halloran <oohall@gmail.com>, Tanjore Suresh <tansuresh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-pci <linux-pci@vger.kernel.org>
References: <20220328230008.3587975-1-tansuresh@google.com>
 <20220328230008.3587975-2-tansuresh@google.com>
 <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_095749_989923_981595D8 
X-CRM114-Status: GOOD (  29.42  )
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



On 3/28/2022 6:19 PM, Oliver O'Halloran wrote:
> On Tue, Mar 29, 2022 at 10:35 AM Tanjore Suresh <tansuresh@google.com> wrote:
>>
>> This changes the bus driver interface with additional entry points
>> to enable devices to implement asynchronous shutdown. The existing
>> synchronous interface to shutdown is unmodified and retained for
>> backward compatibility.
>>
>> This changes the common device shutdown code to enable devices to
>> participate in asynchronous shutdown implementation.
> 
> nice to see someone looking at improving the shutdown path
> 
>> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>> ---
>>   drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
>>   include/linux/device/bus.h | 10 ++++++++++
>>   2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 3d6430eb0c6a..359e7067e8b8 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>> *snip*
> 
> This all seems a bit dangerous and I'm wondering what systems you've
> tested these changes with. I had a look at implementing something
> similar a few years ago and one case that always concerned me was
> embedded systems where the PCIe root complex also has a driver bound.
> Say you've got the following PCIe topology:
> 
> 00:00.0 - root port
> 01:00.0 - nvme drive
> 
> With the current implementation of device_shutdown() we can guarantee
> that the child device (the nvme) is shut down before we start trying
> to shut down the parent device (the root complex) so there's no
> possibility of deadlocks and other dependency headaches. With this
> implementation of async shutdown we lose that guarantee and I'm not
> sure what the consequences are. Personally I was never able to
> convince myself it was safe, but maybe you're braver than I am :)
> 
> That all said, there's probably only a few kinds of device that will
> really want to implement async shutdown support so maybe you can
> restrict it to leaf devices and flip the ordering around to something
> like:

It seems like it might be helpful to split the async shutdowns into 
refcounted hierarchies and proceed with the next level up when all the 
refs are in.

Ex:
00:00.0 - RP
   01:00.0 - NVMe A
   02:00.0 - Bridge USP
     03:00.0 - Bridge DSP
       04:00.0 - NVMe B
     03:00.1 - Bridge DSP
       05:00.0 - NVMe C

NVMe A could start shutting down at the beginning of the hierarchy 
traversal. Then async shutdown of bus 3 wouldn't start until all 
children of bus 3 are shutdown.

You could probably do this by having the async_shutdown_list in the pci_bus.

> 
> for_each_device(dev) {
>     if (can_async(dev) && has_no_children(dev))
>        start_async_shutdown(dev)
> }
> wait_for_all_async_shutdowns_to_finish()
> 
> // tear down the remaining system devices synchronously
> for_each_device(dev)
>     do_sync_shutdown(dev)
> 
>>   /*
>> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
>> index a039ab809753..e261819601e9 100644
>> --- a/include/linux/device/bus.h
>> +++ b/include/linux/device/bus.h
>> @@ -93,6 +101,8 @@ struct bus_type {
>>          void (*sync_state)(struct device *dev);
>>          void (*remove)(struct device *dev);
>>          void (*shutdown)(struct device *dev);
>> +       void (*shutdown_pre)(struct device *dev);
>> +       void (*shutdown_post)(struct device *dev);
> 
> Call them shutdown_async_start() / shutdown_async_end() or something
> IMO. These names are not at all helpful and they're easy to mix up
> their role with the class based shutdown_pre / _post
> 

