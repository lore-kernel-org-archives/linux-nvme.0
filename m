Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9541710F9304
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w6sq7yH6rB9V7WOiF9G5rleHwipGeDPS1b2iK9xuWMQ=; b=f9J/6faJcBetB7Qf8HwLe+2njy
	C6WksufWC+mxAe4VFNTQKPwZwuK01Py+XD84euwf/iZ1IBoOUGifkJ9juaKE0XK6PcAlcQ0w8/WHo
	puAYn7BH6MPuTe8nZcQ0JPDzFoA+BJ9gIM7PXFXOGcjnhvJO3dpT3AagZ2BiU9lh9qLjp1MWCjT1D
	DuKixv9l3ivtL/Ysj3W9cp5vjpRYxZ+DB/GJZ+iuNW36JJWyEEM+IjgnL+VtfdHs1UxvtyT1HG3Bg
	r8o4ods0/OAlYT0iOlCzb141S9XjEX0gB1xzEN7qcma37wyuVFxdEskQ7R7951YI9LPd4WlvHcbs3
	Vrl00wsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7gtq-0000000Db3J-2eQa;
	Tue, 31 Mar 2026 21:45:26 +0000
Received: from se.sotapeli.fi ([2a13:7c81:40::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7gtm-0000000Db2W-2p0E
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 21:45:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99F0B181AA12;
	Tue, 31 Mar 2026 23:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sotapeli.fi; s=dkim;
	t=1774993514; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=w6sq7yH6rB9V7WOiF9G5rleHwipGeDPS1b2iK9xuWMQ=;
	b=zb75EJP2+TNIzPTycD72FqAZ+Z3t7K+FCGv++/xIxD+8WP+PxoHu2DVdhobYuA/BtjRvtZ
	4Hko7jQYwoxl1+Uj2HvWTjUvaA/1RHsksd9aXh8YYol9FFGC0MFhoFuuZSEXxVydFVC0qe
	tB0KTLTcjf+9mQAXT2AvLlAATIyhCMD48vX8787Qfd+la1h0WjlXIFzEvp0K2q2Mp2++K6
	VN9r/mdRvwe4z/GYot+CE5XNvwzk2Q7Z5Emi/bE8G2doG375BgxLJUN/StCOEV4cjHEORe
	dVbsSR5ZxRtfx3jfCIqcTeAYNS9lrWeh1UOCuPBvkHJlGl2SIiQA6y9M+0+ziA==
Message-ID: <8512d83c-5653-44d6-be90-45e349cdde69@sotapeli.fi>
Date: Wed, 1 Apr 2026 00:45:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 4 TiB WD SN700 drives drop off of Sonnet Card
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-raid@vger.kernel.org
References: <CAO9zADxDnb5OVVVZWj64ac70SACH=-G5TC+2F+vfuDmLbZECQA@mail.gmail.com>
Content-Language: en-US
From: Jani Partanen <jiipee@sotapeli.fi>
Autocrypt: addr=jiipee@sotapeli.fi; keydata=
 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
In-Reply-To: <CAO9zADxDnb5OVVVZWj64ac70SACH=-G5TC+2F+vfuDmLbZECQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_144523_347707_F5C4D002 
X-CRM114-Status: GOOD (  12.07  )
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

Hi, if you are running them with 4K LBA format, switch back to 512k. 4K 
LBA cause issues to many WD drives. WD also know this, its been reported 
years ago and it never got firmware fix so its quite safe to say that 
they have harware flaw what cause it and cannot be fixed by firmware.

If you are running your drives with 512k LBA, then this is some other issue.


// Jani

On 01/03/2026 13.39, Justin Piszcz wrote:
> Hello,
>
> Kernel: 6.12.73
> Distribution: Debian Stable Trixie
>
> There are long outstanding issues with these WD Red SN700 4TiB drives
> with an ASUS FlahsStor Gen1.
>
> I have 16 drives on two x8 Sonnet boards and the same issue is
> occurring across two different platforms.  Are these drives completely
> defective when used in a software raid configuration?
>
> Does anyone have a specific kernel parameter to make these drives work
> without dropping off the bus— or is it time to retire/replace these
> drives?  On various forums the below parameters had been tested
> previously and did not help.
>
> [Sun Mar 1 00:30:58 2026] nvme nvme0: controller is down; will reset:
> CSTS=0xffffffff, PCI_STATUS=0xffff
> [Sun Mar 1 00:30:58 2026] nvme nvme0: Does your device have a faulty
> power saving mode enabled?
> [Sun Mar 1 00:30:58 2026] nvme nvme0: Try
> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off"
> and report a bug
> [Sun Mar 1 00:31:03 2026] nvme 0000:03:00.0: Unable to change power
> state from D3cold to D0, device inaccessible
> [Sun Mar 1 00:31:03 2026] nvme nvme0: Disabling device after reset failure: -19
> [Sun Mar 1 00:31:03 2026] md/raid:md0: Disk failure on nvme0n1p1,
> disabling device.
>
> Justin
>

