Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022ACC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 08:28:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71DA60F70
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 08:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B71DA60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wn78fynHqzzqK9oLkjQur1rrQ0XtF8R4gQu85YZBNtk=; b=Sf3TQMW+/SyGQLyrSLvKmEnWfI
	romvy8kV0F78tnD3RgjWcn0voGR1OBQW5sa1zuDk/w+M2sijVEcBA9hbjOM4eGhFj9Q0/82AKXj5t
	BPcfx5QHGhiucffOPntegYLwD5mJJFSla78rOBuAtBou3Ydr+vjvF/XCJvgCcrCKqiR0rzWRJDSuH
	P0gRbNJSXJG7TmoYjNMSLY6WGxU7Pwcf4hnhyOSzQNw9XwevCYvi4R9bF1dnUWgNTltq40/n+QY3x
	2Fjyu261Lfd6S+usTAqqMd/oEWZYlyvAy83CgLUozT3AsmrT/DweskxDblu5FZyZ1Cz9QWh3nFeFA
	FBgdWenQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhp9V-000vKi-2p; Tue, 02 Nov 2021 08:28:17 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhp9R-000vJf-K9
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 08:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1635841693; x=1667377693;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6BNFMArPqUkcHX31A6B4ZL1TPKt4qt1EntfIO4YdB6k=;
 b=jLMeUeRy/hePxRsrrvLo8ZE1MCpkUN/dhA3m02nxUWJjj8/HHcCgTrE9
 7trkT2XPQjxXKQOYF09fHsK7w+e2aQZ8scdjMtqOVONd/gKB0hxxeCeQH
 MgbCZCc3RAz7N1wx18s2+V/cKvJedg0QTYEJU+sjhZPyBDzK8ZrWZ5ppQ
 diVSRMxE8FzCiZsFAGPE0qgSFlka6XF3Zd0+gaP6125JTO+uo0CF/BVpR
 L6P/XRh4fleGDf+plAwKpfNGth/IxbDOtZD28md1fyz8T0S0je2C0HCuW
 ttXDrNX0/SFKrEAxxr8zXGg7K2H6TQPBSbnTDP3N7O2hSBJT+kuqiOaCQ g==;
X-IronPort-AV: E=Sophos;i="5.87,202,1631548800"; d="scan'208";a="183472698"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 16:28:10 +0800
IronPort-SDR: lQoBsDm2szoysc+uy4JMRSdcSMcZ1/C8iaSjpQEq15gVmBPiOPUTZbcPEDt1wIZWFVBpi73emh
 VXjUTarUnuwbZPXZpMv7H40+aJLLDWTGph7agqnUezFKQrQ11JIr4Wsfzb9JWx/izarqF//rnl
 QLJFqNQ6VmU4xHM18fgsXL/6sMCwFrQaFb8g6LlVMrrIZGgKIfUbc6f0hZgUtrQ9kMb18w9D5b
 lEReLwm7xlfEk1PJkagEtv7hAhdqptCTuUdyEGClIbhYr1V0d1SsVAVPwOYEOr8hoZPgFjJTnM
 SAc+kmF54oqzt+cu5FhueVLi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 01:03:31 -0700
IronPort-SDR: BhHUEWUTqzCN/59HpC1jR9JFIVukgPG5DA1inVAosSsdlTUhCxS3LDXcEAyoe2KZxpAyKgljd3
 nH8iqL+lBgkbfRyH1vK1kC4WGB4QasIv0RYWRx8dCxymXW9EbdpL0D1K2iEeJJsOrki8o+kC/Q
 dWpZ9xd5xjbGiL6Cc6IzPizPkWQbDhLVTDVN2RortGb42gJMtGyw5sYSaPRi30NVyxNvJBGH34
 2eETH6MzuZE++LlaaCBUvuTTSx9xOl/ejOLBFZA3F7iq0nQUsjjWIKjyDU74aYJWzY8j/8zcnW
 nDg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 01:28:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hk32219h8z1RtVx
 for <linux-nvme@lists.infradead.org>; Tue,  2 Nov 2021 01:28:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1635841689; x=1638433690; bh=6BNFMArPqUkcHX31A6B4ZL1TPKt4qt1Entf
 IO4YdB6k=; b=ueclccTtZezrM9WcEA9gba0C5TpcXmHEapyCUlGQLxpYKQ4HSqh
 J3Cc+Vq/mmjNnt+1qJMVMTj0C4uzyKlN5fuSDtgUBRZATrxG82qCu6xPMxmJvTxZ
 PUKyiySiGLldX2OCy+rC6DvFg5mjG8cSBuSZAv3cODUioegA0xibnx8b7uvaX/Jr
 3IWINneWrOmsqgJvCe/qoOPDpjICqQEBDKgA6P9Xf8h23JA1w+eBoCrhCi3lQ/Mr
 9OKxldyESpuxgbBHFFRdE+m78p1tWohLLezI0fIcrRZxKEZNoQZMIxvyIVQbNH6S
 LmHmqA4ySJTbzDZ6/lKaGCm/GdcUNL4gp0w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id URqMzW33pwj3 for <linux-nvme@lists.infradead.org>;
 Tue,  2 Nov 2021 01:28:09 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hk3201dMjz1RtVl;
 Tue,  2 Nov 2021 01:28:07 -0700 (PDT)
Message-ID: <4e6c0a41-b70f-bcc2-31f3-761b7c8dcd3a@opensource.wdc.com>
Date: Tue, 2 Nov 2021 17:28:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev>
 <9e22ece3-d080-945d-5011-b0009b781798@nvidia.com>
 <20211102081929.s6eyxawq32phvufr@shindev>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211102081929.s6eyxawq32phvufr@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_012813_824232_0366716E 
X-CRM114-Status: GOOD (  24.17  )
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


+linux-nvme (Keith and Christoph)


On 2021/11/02 17:19, Shinichiro Kawasaki wrote:
> On Nov 02, 2021 / 03:07, Chaitanya Kulkarni wrote:
>>
>>> The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name space and
>>> a regular name space, and the hang is observed with both name spaces. I have
>>> not yet tried other NVME devices, so I will try them.
> 
> I tried another NVMe device, WD Black SN750, but it did not recreate the hang.
> 
>>>
>>
>> See if you can produce this with QEMU NVMe emulation (ZNS and NON-ZNS
>> mode), if you can then it will be easier to reproduce for everyone.
> 
> Chaitanya, thank you for the advice. I have managed to reproduce the hang with
> QEMU NVMe emulation. Actually, ZNS mode is not required. I tried some device
> set up configuration with QEMU, and the hang was recreated when a single NVMe
> device has two namespaces. With single namespace in a single NVMe device, the
> hang is not observed.
> 
> So it looks like that the number of namespaces may be related to the cause. The
> WD Black SN750 without hang has single namespace. I reduced the number of
> namespaces of the U.2 NVMe ZNS SSD from 2 to 1, then the hang was not observed.
> 
> FYI, the QEMU command line options that I used was as follows. It prepares
> /dev/nvme0n1 and /dev/nvme0n2, and the block/005 run on /dev/nvme0n1 recreated
> the hang.
> 
> -device nvme,id=nvme0,serial=qemunvme,logical_block_size=4096,physical_block_size=4096 \
> -drive file=(path)/nvme0n1.img,id=nvme0n1,format=raw,if=none \
> -device nvme-ns,drive=nvme0n1,bus=nvme0,nsid=1 \
> -drive file=(path)/nvme0n2.img,id=nvme0n2,format=raw,if=none \
> -device nvme-ns,drive=nvme0n2,bus=nvme0,nsid=2
> 
> Regarding the two image files, I created them beforehand with the command below:
> 
> $ qemu-img create -f raw "${image_file_path}" 1024M
> 
> Hope this helps.
> 



-- 
Damien Le Moal
Western Digital Research

