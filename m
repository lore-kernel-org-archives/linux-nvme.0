Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C86C47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF7720757
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMJuP4pT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tRL98TgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HnTQpWTraZoAliXvsEyh8zlfrNKAd+dRKSVqsXXsUq4=; b=OMJuP4pT5UcS6saieZRoVjBFF
	34i95bNRi8jAyJyn9ONChB1CUnwhWWfrm3wMreChjzApviiBH0sjxSTKPYWnFAI0T1pO7jvVN+Op3
	5bfJP2AvFEoxK/+mKFS2TVT4mM4LpEFks0m91a5FWuIvjZF0e/6g386tRud2OeYBw1L+y3hrAvHOH
	7Mv1PT4D7yyEHsgykg31wQnMLaROWBrg27/VOKb1qeEvR9N0elVPbVfJlIMCDpRJx9Tmc1sxoPLJp
	kxGMMf18umstrNSnzS+/whZGrDSHU0TXGlWyjqnEeu9kD3c/ImP/x6MzcI2w0L18eZdsF/gLw36uc
	ebuQvf1Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUWWq-0002ep-6i; Fri, 01 May 2020 14:20:36 +0000
Received: from mail-db8eur05on2042.outbound.protection.outlook.com
 ([40.107.20.42] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUWWm-0002cP-Sq
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 14:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOQGdFAG50YtOHb8D2CMQADZKV3grjMYD2t9T0EAfaHUOjFiMUHYPW5DD6GUKDp06+UhclCsoZbJCK3DDJ+Mo2Q+0sdQdHC5vUUe8xDVahYDO/DwcD1tjruyHsfZyOctYW7IdtgHlhHRRjB+5faMiPtnLKESiM7ZbMzys73SZ8XDSSowaW2x/ulShUFWNr9VAUs07pNnVAE7ZvqbmVeOPn6p+t+0Xs9yZRh9sqc6TZvuNIrHBgOwakGKVtgWrtadA6cxH+yAFiCfbWl/B0YLMSp/0Z26vo6IngCbUQimyJY18ngjE2GzT4mCuQCIOdmtTXJwujsfldj6ILPGj5qMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyICMSlWR4QzOLNA4qzqc0FbfokBnRr+JDbft82KbdY=;
 b=BJk9HNAAaBU1L5gttLOoaVKPz4vVVdA9UTSFi1GQPnwygPyJ8t4MgYVTp8OgFcYqsI1a4vXWYc+H5ANLv+G6KIS8DE6aNVXUA0RGsyVYuwBu4EZUoUk4vXohQLwgRQTrQEFEJR4Bo63NBNxwFpGhpHoLwVSe7LEtSUvtNMUbj3IS1FDGk32VYV5IcLc/7h9FPQVI2g5ZfhnB99Hxc+I9GKqOjthSmm9Im95LvIvMn82Vqacfuf0wP0E/2gEFdqTiHFs2EcQAh27FWVjzXWZ6vO56AWTbC+RVUDsYZybNpDQgAI2OHnjn8jnL3RuYDK+83FewL/VBzoncXAqHqT62TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyICMSlWR4QzOLNA4qzqc0FbfokBnRr+JDbft82KbdY=;
 b=tRL98TgUoIscvsfYHdrjKD4v4ImOaAWRf/dCkG2UJp66d1oTXRzMUuvGg15gdFyTUo36BKKbZgX5nGztrXmepQfrYwGFAk+L6eeb+xDviOg/K7HwBloAdalAoiKJr+Ru1fPC3OxAwz0F4aYTaWtYpxjwn9LrD7Uu3tra2wdbqzU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4241.eurprd05.prod.outlook.com (2603:10a6:208:61::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 1 May
 2020 14:20:27 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2958.020; Fri, 1 May 2020
 14:20:27 +0000
Subject: Re: NVMET Target with esxi 7
To: Grant Albitz <GAlbitz@All-Bits.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <a28d8b24ece54f8db6e21c78f0bb5aab@All-Bits.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <711adc2d-dda7-d58f-0884-2c6578e6c333@mellanox.com>
Date: Fri, 1 May 2020 17:20:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <a28d8b24ece54f8db6e21c78f0bb5aab@All-Bits.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 14:20:26 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b9246ae-63a3-4dce-ad50-08d7eddacb73
X-MS-TrafficTypeDiagnostic: AM0PR05MB4241:
X-Microsoft-Antispam-PRVS: <AM0PR05MB42417EB403B5AFFBE95D53D7B6AB0@AM0PR05MB4241.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0390DB4BDA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(66946007)(2906002)(16576012)(8676002)(478600001)(316002)(86362001)(5660300002)(66556008)(66476007)(6486002)(45080400002)(26005)(2616005)(956004)(31696002)(186003)(53546011)(16526019)(6666004)(8936002)(36756003)(52116002)(966005)(110136005)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q6eKkTZvipklgvmCxl9XhYBrfUWu973Rn0LJiGQN3lcc0oOr7p+Uz0geNXw9gO9DbNIrHieYzz3eOxmQTZ8+KRicyixVbKoYDZCkyxWUbhzqlbgYMMea4fMX4OEjToSsx6K6g37PxBN45gAaYfwaIsFYGSEpuP0IljWtxZTETtWM0p0FybOZxwLX5jz0Q1QMkVo7UUEOBORALTd8NXlxUXMKGAArgTAB64GpQRpnDYeK4GiNIt5eDkl0lq9e1W2Svds56tHD4z+ePagU9nTVejnLirBkQ+Eg7yteEIZEMJpdFtD9dVWNEZDyM0zMgdWC6/KyO5HKM3dNEvjze5RALVWMVi/1RGfWMhoe/93LDZJ4rT0E16D3rVQ4tlafL8nwjpuwNVsD6GKBNe5zdjoVeDdu+THlCUGCvqDYPE+4E45S336EbRBgA7uLuzfviOiH4TCkeCscVFFa/ycFN+ZgmtkAz/PMr5mBJV1k9GR9VVbd2SRHORb58rypTIsSRvHpyPD2XKljM7BHOcrvpBXxg==
X-MS-Exchange-AntiSpam-MessageData: A/bbIoNT9CWa3JKRRqlPG+TY/J32VQtA1ORtlMb3q/yhzLb9/i9nZJZ9S5R+P9WgSuB34jBKQO/ssi/I8S8ePjRcl9ClnABxkjMIXXsRo96KFU0Bxiy6WKnWu+5YXKUNJ42Pf3ZoYz/TPXkOm7lm/DBbHBzS0zXPNiG3eDuHFqIKpsg9va2h1o/nW1n1c3e3ndtVqY4CezCkOv8ByZQzfRPVOHyyvroXxG2vqOFBs05VvtOzl7xwkahLkzUzQ7mkAbq1ktfUAvNzYJ+uYmKe4rgTf6wjvusnSPJupms3beH0K9zoOdRM/HwJdcngvhtoMCld0sXQ3UJQ02hYS2ZpuSGpjkBsiBpsY56PrJlG5n0q+YetW2KlC87SjQAERUJxPkxvdvHG6/YFYL59YF2tXpsCPRbVMiBLgpjnbYvnwCOkzbgCZz6JyiWkUYAPYo7Cr8mOK7aJ/7ya8PJgw/763UlmR0iFBkVlg73UyFnDe0mxwLw6HhVW2q5VzopmA0jG0LomNSgXa9iduqAWSLCq5G3jZfXBDM/qRs2fpP65tz4ZFQ9iS38niRYb/TAeZEiU34fsN0kckO4MtPCLkvbqEQvJNYDAWQd/BDUgXFKaY0sE2tWBhmlkneYK/2g+cY7gF31kDELPzE1UAfbu8IBgqUCbo+mp11onU3VSo/AqUG36PyhmuUdxcuhLm9VrNk3yrSr22cmYX4I7hhIZlvUjx2aHTWgpPwdjhQZqYFM/u1S57XGeD1MSzqd2jak6eACkygNSC6VqkpL487/wLpO8if3tl4lPorb03nzcHp3Dwbc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9246ae-63a3-4dce-ad50-08d7eddacb73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 14:20:27.0642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3gwVQZDD/usZSjjMSgcvMSP2QV9tQtpMOULnXonWVK2QpfLfB2XBi7yIG1v+ZxXPB2XX7yUX0OkrS5vusibhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_072032_992152_15C221C0 
X-CRM114-Status: GOOD (  17.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Grant,

In case you're having trouble with MLNX_OFED drivers and configuration - 
the mailing list it not the place to introduce it.

Please work with the correct channels.

In case you have 1 linux server you can try doing a loopback connection 
using RDMA transport and see if it works for you.

-Max.

On 5/1/2020 4:47 PM, Grant Albitz wrote:
> Hello, wondering if anyone can lend some advise. I am trying to discover a nvmet target from esxi. My config is below, from esxi i can discover the controller, it sees the namespace and shows the correct size of the drive. The paths are dead and the HPP path driver comes back and states the path is unsupported. I suspect there is some check that is failing but I am not sure what. I havent been able to get anymore logging out of esxi then what is below.
>
> A side note is no matter what i do on ubuntu the mellanox version of nvmet and nvmet-rdma give symbol errors. I have tried it with the inbox ubuntu 19.10 and 20.04 drivers and they both have the behaivor above.
>
> Config:
>
> I used the pure nqn just because i was concerned esxi my reject a simple namespace name. The iqn below came out of another demo from pure that worked, i have tried simple iqns such as testiqn with the same result.
>
> modprobe nvmet
> modprobe nvmet-rdma
> sudo /bin/mount -t configfs none /sys/kernel/config/
> sudo mkdir /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
> cd /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
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
> sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb/ /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
> sudo mkdir /sys/kernel/config/nvmet/ports/2
> cd /sys/kernel/config/nvmet/ports/2
> echo 10.10.12.1 | sudo tee -a addr_traddr > /dev/null
> echo rdma | sudo tee -a addr_trtype > /dev/null
> echo 4420 | sudo tee -a addr_trsvcid > /dev/null
> echo ipv4 | sudo tee -a addr_adrfam > /dev/null
> sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb/ /sys/kernel/config/nvmet/ports/2/subsystems/nqn.2010-06.com.purestorage.flasharray.1f3d6733c48eadcb
>
>
> dmesg error if using ofed modules (i realize not really your problem just putting it here)
> [ 2498.908659] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
> [ 2585.306697] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
> [ 2678.580571] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
> [ 2764.312226] nvmet: Unknown symbol nvme_find_pdev_from_bdev (err -2)
>
> esxi error when using inbox modules. I have a ticket open with vmware but its as if they never heard of nvmeof. Best guess is they support a handfull of vendor appliances and not linux.
>
>
> 2020-04-30T15:29:09.255Z cpu3:2097454)HPP: HppCreateDevice:2957: Created logical device 'uuid.8301e535a182473c96414d4bfe1652cc'.
> 2020-04-30T15:29:09.255Z cpu3:2097454)WARNING: HPP: HppClaimPath:3719: Failed to claim path 'vmhba65:C0:T0:L0': Not supported
> 2020-04-30T15:29:09.255Z cpu3:2097454)HPP: HppUnclaimPath:3765: Unclaiming path vmhba65:C0:T0:L0
> 2020-04-30T15:29:09.255Z cpu3:2097454)ScsiPath: 8397: Plugin 'HPP' rejected path 'vmhba65:C0:T0:L0'
> 2020-04-30T15:29:09.255Z cpu3:2097454)ScsiClaimrule: 1568: Plugin HPP specified by claimrule 65534 was not able to claim path vmhba65:C0:T0:L0: Not supported
>
>
> I realize this may be a vmware issue, but any advise would be appreciated, I am sort of stuck at this point. I did confirm that on the nvmet server, with the inbox module i can mount the nvme target on the same host. So its working in that sense. Unfortunately I dont have another linux server to test, just the esxi hosts from a seperate client perspective.
>
>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C440c15ee412f4ce8397308d7edd62e8d%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C1%7C637239376473706085&amp;sdata=1Z%2FL7bQJyAsG8HT3HYDrIBzLPVZlq36ppn%2F2RwB%2FEnM%3D&amp;reserved=0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
