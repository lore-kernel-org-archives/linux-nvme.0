Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A67D3B7E8
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4e2coGB4JneKnowJ5d4777cwCSD/2jagIPFE+xQQTxE=; b=rehIFyQZdXll+TncvwClP5ZW15
	YyHfqdSUmOX//eI3i2UZWLUCHQYVaZixOtxdXT081WavM5ROLHbxakDYeVDqbqXO7q0COOVLux5h4
	wfTsNxhmE9YupH1g1Zk/xwcX3EI1X5Z96rtDiv4yXfnA7daJJB/Yy+2Cuiqw4+ivHK0Vucvu27Hnw
	d5BzWv/uQxRxHcMuwWFSYjMmq9NaoUvRwU9pUAl0K9LhU+ZiTMnz1DOzhaFNbYcYwnXyhKLOWtqFr
	8bkOEqZHsXsPDbJ+XN3xG7h9xSEkGMM1GvJs6D1k9gPSCooxEdPHM/OH2BIlSvLgOhH+aK3LJPGBG
	sBV4Djqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSbeT-0000000D9Ib-2Kpg;
	Mon, 08 Dec 2025 13:51:45 +0000
Received: from amazon.4net.co.rs ([2a01:4f8:1c1c:6668::1] helo=amazon.4net.rs)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSbeO-0000000D9Hv-3mVC
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 13:51:43 +0000
Received: from localhost (amazon.4net.co.rs [127.0.0.1])
	by amazon.4net.rs (Postfix) with ESMTP id 718FF6308DA0;
	Mon, 08 Dec 2025 14:37:03 +0100 (CET)
X-Virus-Scanned: amavis at 4net.rs
Received: from amazon.4net.rs ([127.0.0.1])
 by localhost (amazon.dyn.4net.co.rs [127.0.0.1]) (amavis, port 10024)
 with ESMTP id c40x0zj6lut3; Mon,  8 Dec 2025 14:37:02 +0100 (CET)
Received: from mail.4net.rs (unknown [10.188.221.8])
	by amazon.4net.rs (Postfix) with ESMTPS id A042663BDF66;
	Mon, 08 Dec 2025 14:37:02 +0100 (CET)
Received: from localhost (green.4net.co.rs [127.0.0.1])
	by mail.4net.rs (Postfix) with ESMTP id 305871633FFB2;
	Mon, 08 Dec 2025 14:37:02 +0100 (CET)
X-Virus-Scanned: amavis at 4net.rs
Received: from mail.4net.rs ([127.0.0.1])
 by localhost (green.4net.rs [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D96YLVV6DII3; Mon,  8 Dec 2025 14:37:02 +0100 (CET)
Received: from mail.4net.rs (green.4net.co.rs [127.0.0.1])
	by mail.4net.rs (Postfix) with ESMTP id DC0C01633FFB5;
	Mon, 08 Dec 2025 14:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=4net.rs; h=message-id:date
	:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; s=4netrs; bh=pqkYUpxP99
	g7m4wI5duKbEN1Cdw=; b=DB7GjMhs5twu1DuhVF3rvU0DFhUaSLpTd1/I94vHfx
	nzme1SWve5KQFEWGycuUZuBY7u4Z1IEmaatFxhtr1idtc2Qm9CJvLocnxK/1QN3H
	uNKSPa7oWwM5Lh/NZzVDa4kdIiIleWnLmoLq2ayBb6izx/I4GFQNYAOSMb4DhZWr
	s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=4net.rs; h=message-id:date
	:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=4netrs; b=U0fF
	Olc1ZVTgEwman5lm4k7ywl1sIaRwJZiSiKQpzXUVL7tfdH+2yMxKzW8po/MlMi5e
	yDt8MKRClQldi2HCKoKje8V9NdN0Q7v61Ikfy/AXVITpmLvIpdjKt03S/HZ3zhNd
	MNWGodHTWEfTrMPXHFnd3jLhHILOBaOmR79Cp80=
Received: from [192.168.11.2] (unknown [192.168.222.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.4net.rs (Postfix) with ESMTPSA id B03461633FFB2;
	Mon, 08 Dec 2025 14:37:01 +0100 (CET)
Message-ID: <fe363c33-b42a-4613-a633-694edcebb2ee@4net.rs>
Date: Mon, 8 Dec 2025 14:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Content-Language: en-US
To: Paul Rolland <rol@as2917.net>, =?UTF-8?Q?Dragan_Milivojevi=C4=87?=
 <galileo@pkm-inc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-raid@vger.kernel.org
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
 <20251125175704.2dc57a76@riri>
From: Sinisa <sinisa@4net.rs>
In-Reply-To: <20251125175704.2dc57a76@riri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_055142_934447_66302910 
X-CRM114-Status: GOOD (  17.34  )
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

Hello Dragan (and others),

Just to add my ¢2: I have also had NVMe drives dropping out of md RAID10, after reboot SMART says that they are perfectly fine and I am able to re-add them to 
RAID, just for the same situation to happen a few weeks/months later again.

I have seen this on consumer grade motherboards from ASUS, MSI and Gigabyte, but also on Supermicro servers (actually on only one Supermicro SYS-6029P-TR, but 
multiple times, as far as I can remember).

Affected drives are Samsung 980 Pro and Samsung 990 Pro, but I think there were also some Kingston ones (I have replaced them all in the meantime).

Now, I try to always run the latest stable kernel on those machines/servers, so all of them are now on 6.17 and I think that I haven't seen this problem since I 
upgraded to it.


Btw.

nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off

didn't seem to help, I have tried with those parameters before, but the problem would appear after some time, although maybe less frequently.


Btw2.
I don't know if that is related, but I have also had this happen with rotating SATA disks, most recently yesterday on my home/office "server" (MSI PRO B650-P 
WIFI (MS-7D78), 128GB RAM, kernel 6.17.9):
[Sun Dec  7 10:12:18 2025] [    T772] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[Sun Dec  7 10:12:18 2025] [    T772] ata6.00: failed command: FLUSH CACHE EXT
[Sun Dec  7 10:12:18 2025] [    T772] ata6.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 3
res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
[Sun Dec  7 10:12:18 2025] [    T772] ata6.00: status: { DRDY }
[Sun Dec  7 10:12:18 2025] [    T772] ata6: hard resetting link
[Sun Dec  7 10:12:24 2025] [    T772] ata6: link is slow to respond, please be patient (ready=0)
[Sun Dec  7 10:12:28 2025] [    T772] ata6: found unknown device (class 0)
[Sun Dec  7 10:12:28 2025] [    T772] ata6: softreset failed (device not ready)
... (repeat last 4 rows 4 more times)
[Sun Dec  7 10:13:19 2025] [    T772] ata6.00: disable device
[Sun Dec  7 10:13:19 2025] [    T772] ata6: EH complete
[Sun Dec  7 10:13:19 2025] [     C14] sd 5:0:0:0: [sdb] tag#5 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=123s
[Sun Dec  7 10:13:19 2025] [     C14] sd 5:0:0:0: [sdb] tag#5 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
[Sun Dec  7 10:13:19 2025] [     C14] I/O error, dev sdb, sector 2064 op 0x1:(WRITE) flags 0x9800 phys_seg 1 prio class 2
[Sun Dec  7 10:13:19 2025] [     C14] md: super_written gets error=-5
[Sun Dec  7 10:13:19 2025] [     C14] md/raid10:md3: Disk failure on sdb1, disabling device.
md/raid10:md3: Operation continuing on 1 devices.
[Sun Dec  7 10:13:19 2025] [     C14] sd 5:0:0:0: [sdb] tag#6 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
.... (many, many I/O errors)

So this morning I just ran (without reboot):
     for I in /sys/class/scsi_host/host*/scan
       echo "- - -" > $I
     done
and the drive is back, no errors logged in SMART, re-added to RAID, currently re-syncing.


Srdačan pozdrav / Best regards / Freundliche Grüße / Cordialement / よろしくお願いします
Siniša Bandin


On 11/25/25 5:57 PM, Paul Rolland wrote:
> Hello,
>
> On Tue, 25 Nov 2025 16:19:27 +0100
> Dragan Milivojević <galileo@pkm-inc.com> wrote:
>
>>> Issue/Summary:
>>> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
>>> drop out of a NAS array, after power cycling the device, it rebuilds
>>> successfully.
>>>   
>> Seen the same, although far less frequent, with Samsung SSD 980 PRO on
>> a Dell PowerEdge R7525.
>> It's the nature of consumer grade drives, I guess.
>>
> Got some issue long time ago, and used :
>
> nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off
>
> to boot the kernel. That fixed issue with SN700 2TB.
>
> Regards,
> Paul
>


