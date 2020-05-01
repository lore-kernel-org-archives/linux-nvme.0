Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6AC47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:27:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63A3208C3
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TR6x3Vbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63A3208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=All-Bits.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cmd3Lkcw6InxL5/QNu8YyqiyvB+dqIydCQ320ggJdrk=; b=TR6x3VblMucBUo
	h29jf8Z7UXXJcBazeNmzAYJGygOBth/njk4KmPWa8eVSdLIt/oeMYJuk12wUcQEVzlnXYvQv09FIA
	uXykSccNoeq4SrwVhoiBcxybcbiXk+ordftuoO8aE4g9MU+GNKuCGp7cZkxXyYQrgjQ90qdMz1DP5
	9IPmM70V6j3bg1DiNyZQHbnmdIqcKJLQYbDJ1ttsrnbJvwsvtkwN7aXQCC4k7vBNiqDe3L6nIhXEu
	iKx/DIk89d95OHG6WUURll9clh7qXidj4tAdmKaNfQHQdroH2mleWejYIGcBN0wRGUCJEE5EaeiZ7
	Tl7PJ6uLr+WZwGabD6bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUWdN-00075k-1L; Fri, 01 May 2020 14:27:21 +0000
Received: from smtp.cryptz.com ([24.229.7.147])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUWdI-0006xx-0e
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 14:27:19 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 SMTP.Cryptz.com 49DF2C0TfhzGsvJw
X-AllBits-MailScanner-eFa-Watermark: 1588948033.80182@mA9kEdn1SjSjB64a2jHFWg
X-AllBits-MailScanner-eFa-From: galbitz@all-bits.com
X-AllBits-MailScanner-eFa: Found to be clean
X-AllBits-MailScanner-eFa-ID: 49DF266jLQzGsvJw
X-AllBits-MailScanner-eFa-Information: Please contact cryptz@cryptz.com for
 more information
Received: from Mail.Cryptz.Com ([10.10.10.18] [10.10.10.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (no client certificate requested)
 by SMTP.Cryptz.com (MailScanner Milter) with SMTP id 49DF266jLQzGsvJw
 for <linux-nvme@lists.infradead.org>; Fri,  1 May 2020 10:27:11 -0400 (EDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 SMTP.Cryptz.com 49DF266jLQzGsvJw
Authentication-Results: SMTP.Cryptz.com;
 dmarc=none (p=none dis=none) header.from=All-Bits.com
Authentication-Results: SMTP.Cryptz.com;
 spf=fail smtp.mailfrom=GAlbitz@All-Bits.com
DKIM-Filter: OpenDKIM Filter v2.11.0 SMTP.Cryptz.com 49DF266jLQzGsvJw
Received: from FROST.PSC.Net (10.10.10.18) by FROST.PSC.Net (10.10.10.18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.595.3; Fri, 1 May 2020
 10:27:10 -0400
Received: from FROST.PSC.Net ([fe80::4988:c04c:dcc6:f34f]) by FROST.PSC.Net
 ([fe80::4988:c04c:dcc6:f34f%15]) with mapi id 15.02.0595.003; Fri, 1 May 2020
 10:27:10 -0400
From: Grant Albitz <GAlbitz@All-Bits.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMET Target with esxi 7
Thread-Topic: NVMET Target with esxi 7
Thread-Index: AQHWH72r2sq5DQXIv0Kj735jydy+waiTitUA//++XSo=
Date: Fri, 1 May 2020 14:27:10 +0000
Message-ID: <4ae82f486cac431caa6928e56fe5e452@All-Bits.com>
References: <a28d8b24ece54f8db6e21c78f0bb5aab@All-Bits.com>,
 <711adc2d-dda7-d58f-0884-2c6578e6c333@mellanox.com>
In-Reply-To: <711adc2d-dda7-d58f-0884-2c6578e6c333@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.10.21]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_072716_163979_0AEC29ED 
X-CRM114-Status: GOOD (  15.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Max, but as indicated with the inbox nvmt and rdma drivers the targe=
t is n ot discoverable by esxi 7. Curious is it has been tested at all. As =
indicated the mlnx ofed variant fails to load due to symbol errors, but i h=
ave had the outlined experience of discovering the namespace but not the pa=
th with the inbox drivers. At the moment I have abandoned the mlnx drivers =
and am trying to use the inbox ubuntu 19.10 ones.




From: Max Gurtovoy <maxg@mellanox.com>
Sent: Friday, May 1, 2020 10:20 AM
To: Grant Albitz; linux-nvme@lists.infradead.org
Subject: Re: NVMET Target with esxi 7
=A0   =

Hi Grant,

In case you're having trouble with MLNX_OFED drivers and configuration - =

the mailing list it not the place to introduce it.

Please work with the correct channels.

In case you have 1 linux server you can try doing a loopback connection =

using RDMA transport and see if it works for you.

-Max.

On 5/1/2020 4:47 PM, Grant Albitz wrote:
> Hello, wondering if anyone can lend some advise. I am trying to discover =
a nvmet target from esxi. My config is below, from esxi i can discover the =
controller, it sees the namespace and shows the correct size of the drive. =
The paths are dead and the HPP path  driver comes back and states the path =
is unsupported. I suspect there is some check that is failing but I am not =
sure what. I havent been able to get anymore logging out of esxi then what =
is below.
>
> A side note is no matter what i do on ubuntu the mellanox version of nvme=
t and nvmet-rdma give symbol errors. I have tried it with the inbox ubuntu =
19.10 and 20.04 drivers and they both have the behaivor above.
>
> Config:
>
> I used the pure nqn just because i was concerned esxi my reject a simple =
namespace name. The iqn below came out of another demo from pure that worke=
d, i have tried simple iqns such as testiqn with the same result.
>
> modprobe nvmet
> modprobe nvmet-rdma
> sudo /bin/mount -t configfs none /sys/kernel/config/
> sudo mkdir /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorag=
e.flasharray.1f3d6733c48eadcb
> cd /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasha=
rray.1f3d6733c48eadcb
> echo 1 | sudo tee -a attr_allow_any_host > /dev/null
> sudo mkdir namespaces/1
> cd namespaces/1/
> echo -n /dev/nvme0n1> device_path
> echo 1 | sudo tee -a enable > /dev/null
> sudo mkdir /sys/kernel/config/nvmet/ports/1
> cd /sys/kernel/config/nvmet/ports/1
> echo 10.10.11.1 | sudo tee -a addr_traddr > /dev/null
> echo rdma | sudo tee -a addr_trtype > /dev/null
> echo 4420 | sudo tee -a addr_trsvcid > /dev/null
> echo ipv4 | sudo tee -a addr_adrfam > /dev/null
> sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorag=
e.flasharray.1f3d6733c48eadcb/ /sys/kernel/config/nvmet/ports/1/subsystems/=
nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
> sudo mkdir /sys/kernel/config/nvmet/ports/2
> cd /sys/kernel/config/nvmet/ports/2
> echo 10.10.12.1 | sudo tee -a addr_traddr > /dev/null
> echo rdma | sudo tee -a addr_trtype > /dev/null
> echo 4420 | sudo tee -a addr_trsvcid > /dev/null
> echo ipv4 | sudo tee -a addr_adrfam > /dev/null
> sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorag=
e.flasharray.1f3d6733c48eadcb/ /sys/kernel/config/nvmet/ports/2/subsystems/=
nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
>
>
> dmesg error if using ofed modules (i realize not really your problem just=
 putting it here)
> [ 2498.908659] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
> [ 2585.306697] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
> [ 2678.580571] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
> [ 2764.312226] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
>
> esxi error when using inbox modules. I have a ticket open with vmware but=
 its as if they never heard of nvmeof. Best guess is they support a handful=
l of vendor appliances and not linux.
>
>
> 2020-04-30T15:29:09.255Z cpu3:2097454)HPP: HppCreateDevice:2957: Created =
logical device 'uuid.8301e535a182473c96414d4bfe1652cc'.
> 2020-04-30T15:29:09.255Z cpu3:2097454)WARNING: HPP: HppClaimPath:3719: Fa=
iled to claim path 'vmhba65:C0:T0:L0': Not supported
> 2020-04-30T15:29:09.255Z cpu3:2097454)HPP: HppUnclaimPath:3765: Unclaimin=
g path vmhba65:C0:T0:L0
> 2020-04-30T15:29:09.255Z cpu3:2097454)ScsiPath: 8397: Plugin 'HPP' reject=
ed path 'vmhba65:C0:T0:L0'
> 2020-04-30T15:29:09.255Z cpu3:2097454)ScsiClaimrule: 1568: Plugin HPP spe=
cified by claimrule 65534 was not able to claim path vmhba65:C0:T0:L0: Not =
supported
>
>
> I realize this may be a vmware issue, but any advise would be appreciated=
, I am sort of stuck at this point. I did confirm that on the nvmet server,=
 with the inbox module i can mount the nvme target on the same host. So its=
 working in that sense. Unfortunately  I dont have another linux server to =
test, just the esxi hosts from a seperate client perspective.
>
>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
>  https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=3D02%7C01%7Cmaxg%=
40mellanox.com%7C440c15ee412f4ce8397308d7edd62e8d%7Ca652971c7d2e4d9ba6a4d14=
9256f461b%7C0%7C1%7C637239376473706085&amp;sdata=3D1Z%2FL7bQJyAsG8HT3HYDrIB=
zLPVZlq36ppn%2F2RwB%2FEnM%3D&amp;reserved=3D0
    =

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
