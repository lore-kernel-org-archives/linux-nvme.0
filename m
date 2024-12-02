Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64BBD7832E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTh1/8GoFT5hK13E7UkueN4Gy5+UjardUeWSIX5FzJc=; b=bMd6fxNmFunLSVa/XE+d4DEodf
	PAv6AcFMdD+8BB569tTSOY5Zk/8TXnK8PIfJMz8P3cNLW3nRpeIW9EOmoQxA98biXO4/ARpEQm+Gq
	rSPYBkMboMaUcZL9P3RwlhroTePJYgwDfKCCfrp44ERCAT4+qps36ZIeE5LWX3lrSYLFhui7bNa5s
	8UR5XCZxVo8Fp/BP0bw7gGZNBZD+Y6hiVLg87Wj0qEwIZVjg6M9hmdNX3rxsaHEr91F8aOCYip2nk
	8uL08wGbs8Ep1+KoJq2MULFcBvuZYwnsc1Gbl3pY5lLEDTT+LB6pcN//2Oi/XZlHjJTzHoOGrTxqc
	BBtYFMeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI896-00000006bf8-3Cy7;
	Mon, 02 Dec 2024 15:15:32 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI893-00000006be4-3Aik
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 15:15:31 +0000
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 898FE61E6477C;
	Mon, 02 Dec 2024 16:15:03 +0100 (CET)
Message-ID: <3a851b3a-dfad-4796-94cb-42ced213e901@molgen.mpg.de>
Date: Mon, 2 Dec 2024 16:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `nvme nvme0: using unchecked data buffer`
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20241118155738.2737423-1-kbusch@meta.com>
 <20241118155738.2737423-4-kbusch@meta.com>
 <ed59976f-d8ef-411a-b159-0bb1c6bdfa8c@molgen.mpg.de>
 <Z03Mq9xaMXbJtm0d@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Z03Mq9xaMXbJtm0d@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_071529_939283_89705679 
X-CRM114-Status: GOOD (  21.20  )
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


Thank you very much for your quick reply.

Am 02.12.24 um 16:05 schrieb Keith Busch:
> On Mon, Dec 02, 2024 at 08:56:03AM +0100, Paul Menzel wrote:
>> Am 18.11.24 um 16:57 schrieb Keith Busch:
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> If the device supports SGLs, use these for all user requests. This
>>> format encodes the expected transfer length so it can catch short buffer
>>> errors in a user command, whether it occurred accidently or maliciously.
>>>
>>> For controllers that support SGL data mode, this is a viable mitigation
>>> to CVE-2023-6238. For controllers that don't support SGL, log a warning
>>
>> For the layman, what is this security problem?
> 
> The passthrough interface can't validate buffer lengths against the
> command's actual payload. NVMe traditionally did not have explicit
> buffer sizes encoded in commands, so this only works correctly if the
> device and host both agree on what the implicit transfer size actually
> is. More recent NVMe features fixed that problem with explicit buffer
> sizes in the commands.
> 
> Whether by accident or on purpose, user space can request a smaller
> buffer than the device is going to transfer into it. That will corrupt
> memory.

Does the Linux kernel know the buffer size?

>>> -	if (has_metadata && !supports_metadata)
>>> -		return -EINVAL;
>>> +	if (!nvme_ctrl_sgl_supported(ctrl))
>>> +		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
>>
>> Linux logs this on the Dell XPS 13 9360 with PC300 NVMe SK hynix 512GB
>> (firmware revision 20004A00).
>>
>>      [   14.399238] nvme nvme0: using unchecked data buffer
>>
>> What should a user do about it?
> 
> Nothing for a user to do. This is an indication that the passthrough
> interface has been used with a device that can only use implicit
> transfer lengths. It's more of an indication that improper use of this
> interface might be the cause of memory corruption observations.

Could it be fixed by a firmware update?

I wonder if the level should be reduced then to info, or if it can be 
elaborated. Maybe:

The PC300 NVMe SK hynix 512GB can only use implicit transfer length. 
Improper use might be the cause of memory corruption observations.


Kind regards,

Paul

