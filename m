Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4CFC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BC5yrkChWUQbJFGjjzDK0lNh1OmKLWo7WflUpnzTV8U=; b=3T+1NhckOdIl2Ut/QKYYbumYOq
	jYRm8c49iE1/LYyNolx8BYYHi7HyOIFF9MyowWCZKZ3CIjphxS+c90HEGOv7CpAZnBq3Bvyx6gHmd
	CDk0T9pEK5Si4/eUNt5zq3CZ41cjxCIN1fXwn21+MPu/jYofkGCAYiM43EOY+d/G28i/DBbx3hKJZ
	3xLABG6Lp79DGSJfKPt/16Hg+O1Ynzusr4hgB6L7BdnF6A3e0Y0NMVfHm7mBZC9qoWFT607SzEn5B
	5I6565FO5uPNU+rMKWmZmtiLRg36tBt9PrUxu9NToye0OY55XOceBOz2ZWNavpvwIuRSIVB6LMJ7N
	x8/bcg1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXq04-0000000C2an-3jyQ;
	Wed, 07 Feb 2024 22:02:36 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXq01-0000000C2Z1-44Sg
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 22:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=BC5yrkChWUQbJFGjjzDK0lNh1OmKLWo7WflUpnzTV8U=; b=fgFz0NIptrxvgy17mLTwyoYQxG
	RQMJNK/Mx0uW75eWDynaiYuubTNevA90TQLaq9zs4uE3RoedtBKivZhzDRcJP5GpVRZMrR1DVUenK
	SkitgHQCencNcEF3jJZ3olUMXVk86a3Q5SGPWiQzbf9zp2+TgalscRvJDTiVH6L5fuq0gYXLxhb7J
	0Vw2Zbs9FzhHQxTyYXBsQW0lpHTfPm2WdEGCTHeQ4RgoOoXa32Bxu28JRs5w0Br1p8A0QW66IQnQ0
	buqtvU7Z5iNWSU+KGrbpsi+GisqRuewylMonrVMkwjI+R9E2wWSrK/pLBWj2cT7SaX7lwUa8UM13s
	Kh/XBE68yWjoBUhPzDw9U1M+cuYtkVpofl0Xo01DLB+Um3gXkbQWH3xfCJN3wq16Ry8FXurIR8OqQ
	9EWqZwG8+pOc3RdVvSCPUW3Jtlq//5Bi40KothuG+17s0UEnHyG3S3zBacXOuYT3aS5KmliootUXX
	oOyXfk9oL+PK9F+Q1ddky4FZ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rXpzx-00C1bl-18;
	Wed, 07 Feb 2024 22:02:29 +0000
Date: Wed, 7 Feb 2024 14:02:25 -0800
From: Jeremy Allison <jra@samba.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] PCI: Support two-pass shutdown
Message-ID: <ZcP98d0iDMWlUse7@jeremy-HP-Z840-Workstation>
References: <20240207214044.2374295-3-jallison@ciq.com>
 <20240207215950.GA919764@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240207215950.GA919764@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_140234_033817_677DFBF9 
X-CRM114-Status: GOOD (  15.19  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 07, 2024 at 03:59:50PM -0600, Bjorn Helgaas wrote:
>On Wed, Feb 07, 2024 at 01:40:41PM -0800, Jeremy Allison wrote:
>> From: Tanjore Suresh <tansuresh@google.com>
>>
>> Enhance the base PCI driver to add support for two-pass shutdown. Add
>> shutdown_wait() method.
>>
>> Assume a device takes n secs to shutdown. If a machine has been populated
>> with M such devices, the total time spent in shutting down all the devices
>> will be M * n secs if the shutdown is done synchronously. For example, if
>> NVMe PCI Controllers take 5 secs to shutdown and if there are 16 such NVMe
>> controllers in a system, system will spend a total of 80 secs to shutdown
>> all NVMe devices in that system.
>>
>> In order to speed up the shutdown time, a two-pass interface to shutdown
>> has been implemented. The caller calls the shutdown method for each device
>> in turn to allow a shutdown request to be sent, then the caller walks the
>> list of devices and calls shutdown_wait() to synchronously wait for the
>> shutdown to complete.
>>
>> In the NVMe case above, all 16 devices will process the shutdown in
>> parallel taking the total time to shutdown down to the time for one NVMe
>> PCI Controller to shut down.
>>
>> This will significantly reduce the machine reboot time.
>>
>> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>> Signed-off-by: Jeremy Allison <jallison@ciq.com>
>
>I already acked this, so you can include that ack in subsequent
>revisions unless you make significant changes:
>https://lore.kernel.org/r/20240130175430.GA527253@bhelgaas
>
>Thanks for rewrapping the commit log!

Thanks, I'm still learning the right conventions. I'll
add the ack's for the next version.

