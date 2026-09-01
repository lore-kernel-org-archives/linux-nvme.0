Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3E5C61DD3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGLXmiWD3F2Rj4zO7/urRtXBPDds1U+hE4xfuZQdhqo=; b=cGpJPjOzXRHjZ6VTB4kaGAjjex
	+OY7yNeY1o9QT7/5yF1MpZK+A28xyUqvrJPErawUfkuHlZNmYYxCieNsDeY1ZdUEbHBI4atSs04jJ
	DLlEUwb7yxZWmD7gtmSS8aGhgUCU4LfdaTe6fSjM24ADnnfIcuX1lPpzoJK8zBQyJkXO7QV7/kbJz
	ItDkMSSVKSy/CH5h2O5wR2By52OGZsYsc/N/p0erwfHtn2hzw+ViIKqRDeDTfgrttLo0zLv9+4Gpv
	U7L6jCMspChOy+6bpzd44qHsaTi44+kbsHpvQcCEDN1pJrPXV1ShhC5NKpsyuWh04crgOky/989t/
	2vhW55Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1LVR-0000000BWF0-3t7r;
	Tue, 01 Sep 2026 10:14:17 +0000
Received: from out-60.mta0.migadu.com ([2001:41d0:1004:224b::3c] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1LVO-0000000BWE7-1e2t
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 10:14:16 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=EfL6eJsS70peRFTEVxSWSFw/s+Va4s7Cj1R4SG1OHlU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788257651; v=1; x=1788862451;
 b=mvu1ypx7YnZEg32SqiuwKC90hdZFvSDj/NYbbSSUWTlubRD3OpWfUocMUmdBAODAtEsWRiYj
 F8xqwh2exp6QoSx7X7yHV0yyQDFwoVGlk5DiJKi6Gs5bi49nsP/BdMFBUfw9YUwC6YEfMwvM8aN
 rIe7lRCOVfsMlcPjC7NVE9XE=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id bdea76b3912144d3;
	Tue, 01 Sep 2026 10:14:11 +0000
X-Mizu-Trace-ID: bdea76b3912144d3
X-Migadu-Flow: FLOW_OUT
Message-ID: <374a2e7b-6232-469c-ab75-e9ddfa884085@linux.dev>
Date: Tue, 1 Sep 2026 11:14:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add reference counting for transport modules
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <eb76f8b4-3730-410c-bdcd-3a36c46686ab@linux.dev>
 <e45bf216-3853-4c52-8bf9-2835e0c65509@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <e45bf216-3853-4c52-8bf9-2835e0c65509@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_031414_581661_91E3775C 
X-CRM114-Status: GOOD (  14.94  )
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

> 
>> When the ctrl ops module ref counting was originally introduced, the 
>> commit message mentioned a crash which it solves.
>>
>> So far for this problem we have seen a report that if we remove the 
>> module, the mounted FS will have IOs fail. The same can be experienced 
>> if the admin unbinds the device from the driver. However, I have not 
>> seen a mention of a crash, kernel data corruption, a hang, etc.
>>
> Yes I have also not observed a kernel crash or data corruption.
> Regarding unbinding, this is triggered through the PCI/device-model
> unbind path. The driver unbind callback returns void so the NVMe driver
> has no way to reject or otherwise prevent the unbind operation from the
> driver side. 

There's suppress_bind_attrs, but I don't think that anyone using VFIO 
would be happy if that were set.

> The purpose of this patch is therefore to protect the 
> transport
> module from being unloaded while the multipath head is still open.


