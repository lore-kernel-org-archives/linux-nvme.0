Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69794C47258
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 13:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF012051A
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IMwcSCo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF012051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=All-Bits.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Al8FgX2ZRm54DDE2P3P+3Kfh9jdIfCbiC3U3j0H/9Mg=; b=IMwcSCo06mns8P
	cCwPdcFfSaeLpd/JEdsnA3JoCwToAo2gy7KPvr1Y2xJFe2B7z4G4VvslCjfn82I4uLPLhOGC8BkoA
	bT4rnbe2ooLlpgWNM8SMcxB7T6uSwtGMke7DWpZuMhSO2Mav9uDUdJTp9jIfgbp9prN7EOeCg4B/A
	405BJgJjwJ0EVL5ffol/88+/r5eCnZ0Wm2MfVdHeN/6DaMkYdF70bfywSV6M+3qBjGU6O4WTJT4El
	95oM3FTEG9ccu5hj3G+JWtThgmEW5C3RIYrNbdbDLJAYnlnLPJDEgQZwzPv3PDmi7AdiQ2F4mTcUc
	zr76xLqfCYeBof0LjaaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUW0g-0002nU-9M; Fri, 01 May 2020 13:47:22 +0000
Received: from smtp.cryptz.com ([24.229.7.147])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUW0d-0002lg-6p
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 13:47:20 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 SMTP.Cryptz.com 49DD830KqjzGsK45
X-AllBits-MailScanner-eFa-Watermark: 1588945629.77136@cl2f02qF42Agwo3kSY+JhQ
X-AllBits-MailScanner-eFa-From: galbitz@all-bits.com
X-AllBits-MailScanner-eFa: Found to be clean
X-AllBits-MailScanner-eFa-ID: 49DD7s32LGzGsK45
X-AllBits-MailScanner-eFa-Information: Please contact cryptz@cryptz.com for
 more information
Received: from Mail.Cryptz.Com ([10.10.10.19] [10.10.10.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (no client certificate requested)
 by SMTP.Cryptz.com (MailScanner Milter) with SMTP id 49DD7s32LGzGsK45
 for <linux-nvme@lists.infradead.org>; Fri,  1 May 2020 09:47:06 -0400 (EDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 SMTP.Cryptz.com 49DD7s32LGzGsK45
Authentication-Results: SMTP.Cryptz.com;
 dmarc=none (p=none dis=none) header.from=All-Bits.com
Authentication-Results: SMTP.Cryptz.com;
 spf=fail smtp.mailfrom=GAlbitz@All-Bits.com
DKIM-Filter: OpenDKIM Filter v2.11.0 SMTP.Cryptz.com 49DD7s32LGzGsK45
Received: from FROST.PSC.Net (10.10.10.18) by GLAZE.PSC.Net (10.10.10.19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.595.3; Fri, 1 May 2020
 09:47:01 -0400
Received: from FROST.PSC.Net ([fe80::4988:c04c:dcc6:f34f]) by FROST.PSC.Net
 ([fe80::4988:c04c:dcc6:f34f%15]) with mapi id 15.02.0595.003; Fri, 1 May 2020
 09:47:01 -0400
From: Grant Albitz <GAlbitz@All-Bits.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: NVMET Target with esxi 7
Thread-Topic: NVMET Target with esxi 7
Thread-Index: AQHWH72r2sq5DQXIv0Kj735jydy+wQ==
Date: Fri, 1 May 2020 13:47:01 +0000
Message-ID: <a28d8b24ece54f8db6e21c78f0bb5aab@All-Bits.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.10.21]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_064719_479005_A6153D1B 
X-CRM114-Status: UNSURE (   7.79  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello, wondering if anyone can lend some advise. I am trying to discover a nvmet target from esxi. My config is below, from esxi i can discover the controller, it sees the namespace and shows the correct size of the drive. The paths are dead and the HPP path driver comes back and states the path is unsupported. I suspect there is some check that is failing but I am not sure what. I havent been able to get anymore logging out of esxi then what is below.

A side note is no matter what i do on ubuntu the mellanox version of nvmet and nvmet-rdma give symbol errors. I have tried it with the inbox ubuntu 19.10 and 20.04 drivers and they both have the behaivor above.

Config:

I used the pure nqn just because i was concerned esxi my reject a simple namespace name. The iqn below came out of another demo from pure that worked, i have tried simple iqns such as testiqn with the same result.

modprobe nvmet
modprobe nvmet-rdma
sudo /bin/mount -t configfs none /sys/kernel/config/
sudo mkdir /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
cd /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
echo 1 | sudo tee -a attr_allow_any_host > /dev/null
sudo mkdir namespaces/1
cd namespaces/1/
echo -n /dev/nvme0n1> device_path
echo 1 | sudo tee -a enable > /dev/null
sudo mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1
echo 10.10.11.1 | sudo tee -a addr_traddr > /dev/null
echo rdma | sudo tee -a addr_trtype > /dev/null
echo 4420 | sudo tee -a addr_trsvcid > /dev/null
echo ipv4 | sudo tee -a addr_adrfam > /dev/null
sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb/ /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
sudo mkdir /sys/kernel/config/nvmet/ports/2
cd /sys/kernel/config/nvmet/ports/2
echo 10.10.12.1 | sudo tee -a addr_traddr > /dev/null
echo rdma | sudo tee -a addr_trtype > /dev/null
echo 4420 | sudo tee -a addr_trsvcid > /dev/null
echo ipv4 | sudo tee -a addr_adrfam > /dev/null
sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb/ /sys/kernel/config/nvmet/ports/2/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb


dmesg error if using ofed modules (i realize not really your problem just putting it here)
[ 2498.908659] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
[ 2585.306697] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
[ 2678.580571] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
[ 2764.312226] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)

esxi error when using inbox modules. I have a ticket open with vmware but its as if they never heard of nvmeof. Best guess is they support a handfull of vendor appliances and not linux.


2020-04-30T15:29:09.255Z cpu3:2097454)HPP: HppCreateDevice:2957: Created logical device 'uuid.8301e535a182473c96414d4bfe1652cc'.
2020-04-30T15:29:09.255Z cpu3:2097454)WARNING: HPP: HppClaimPath:3719: Failed to claim path 'vmhba65:C0:T0:L0': Not supported
2020-04-30T15:29:09.255Z cpu3:2097454)HPP: HppUnclaimPath:3765: Unclaiming path vmhba65:C0:T0:L0
2020-04-30T15:29:09.255Z cpu3:2097454)ScsiPath: 8397: Plugin 'HPP' rejected path 'vmhba65:C0:T0:L0'
2020-04-30T15:29:09.255Z cpu3:2097454)ScsiClaimrule: 1568: Plugin HPP specified by claimrule 65534 was not able to claim path vmhba65:C0:T0:L0: Not supported


I realize this may be a vmware issue, but any advise would be appreciated, I am sort of stuck at this point. I did confirm that on the nvmet server, with the inbox module i can mount the nvme target on the same host. So its working in that sense. Unfortunately I dont have another linux server to test, just the esxi hosts from a seperate client perspective.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
