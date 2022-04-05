Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5619C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 00:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fA0agL2Sbpusf8UeGiygDVv9mbCsKBfNYdjDlIlCCs=; b=zGdc8Q4urt/dTFYbG2Kcd9NOmI
	FViEUnlRyQJsBqp1wFi4oMLnyKDcy2UenwQ5arvDr31RTP8gubPo5hFxZtNIqlKGVIanbUpTSYnG9
	xe58o1Z94J2HJbmQ/0Ix4GYanGmgRE6Mx6kIVCd8YA4o6R3Oz6Zij6YRLePYu9tA6K+S7gtUQzAbK
	jLDhred7gWtir4Hnlq8zurkptBo2dPAYhelEIdc4CY+LaFYeT/EDcrJXsmi8DaOBSUf3ndhbL6+wV
	t+si3SmV9DJNN5xyx12fTnmlMfHF9CnVLSBzk8Pcsw0KxDtYvkeILleZTbd6AZc7tuGNB5jq0NLaO
	k4DtW4Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbXI1-00GlJA-SE; Tue, 05 Apr 2022 00:43:21 +0000
Received: from out1.migadu.com ([91.121.223.63])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbXHw-00GlHy-Cd
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 00:43:18 +0000
Message-ID: <17ca93bc-3cb7-46d6-559e-e2dc0e3408bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1649119388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fA0agL2Sbpusf8UeGiygDVv9mbCsKBfNYdjDlIlCCs=;
 b=trE9FaYtPy7HHlJHh3iNTMKsAMMYtK9petckhrh1OVT5h56AazQqjuUfHbL1JnFHhOozVY
 IOUYBRF46YLim2W/pWZFsGKaK32EvY4INv+UUumSscoqp7ONHU8MkUm+cv742x3MBwrDu4
 A9mfnx8GLh9ClAULQ9DE7HQRPS7HjmY=
Date: Mon, 4 Apr 2022 18:43:01 -0600
MIME-Version: 1.0
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
 <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_174317_488775_BF15600E 
X-CRM114-Status: GOOD (  19.77  )
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



On 4/4/2022 2:30 PM, Keith Busch wrote:
> On Mon, Apr 04, 2022 at 01:34:38PM -0600, Jonathan Derrick wrote:
>>
>>
>> On 4/4/2022 11:02 AM, Keith Busch wrote:
>>> On Mon, Apr 04, 2022 at 04:39:06PM +0000, Alan Adamson wrote:
>>>>
>>>> [   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
>>>>
>>>> An error from the device (status=2/Invalid Field) when an Identify (0x6) command was issued. Prior to the patch,
>>>> the nvme driver didn’t display the error.
>>> And it's harmless. The driver is querying an optional identification and it's
>>> okay if the device doesn't support it, but the driver doesn't know if the
>>> device supports until it tries it.
>> I've had to field bug reports like this before, where it says error in dmesg
>> but is actually harmless.
> 
> Even before the kernel message was added, some implementations trigger error
> log events, which alerts smartd. :(
I haven't had too many smartd reports come my way, but 'error' in dmesg 
is a typical one. Usually due a language barrier issue or uneducated AE. 
But I suspect a lay-user without an AE might resort to kernel bz due to 
things like this.

>   
>> Maybe we could suppress the error and add a harmless print?
>> Eg, nvme0: blah blah command set not supported
> 
> The new print in the completion handler is pretty generic. I don't think it can
> readily tell the difference from a harmless error. Maybe pr_err is too high?
Could we pack RQF_FAILED in the req flags and reduce the severity in 
nvme_log_error?

> 
> Or maybe since enough people have been concerned about *this* specific
> identify, maybe it should be restricted to 2.0 devices where it's mandatory. I
> was reluctant to do that at first since the initial device I tested was 1.4,
> but it was a prototype and we should be fine without the non-mdts limits
> anyway.
Well I'm not sure about that. I'm not honestly sure what this specific 
identify is, but (I know you know) NVMe being forward compatible allows 
eg, 1.4 compliant devices/targets to support 2.0 features.

