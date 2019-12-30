Return-Path: <SRS0=eBch=2U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA87C2D0C2
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Dec 2019 10:52:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA365206E4
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Dec 2019 10:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjkXGKxd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chelsious.onmicrosoft.com header.i=@chelsious.onmicrosoft.com header.b="vrpVgAt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA365206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exCGaBQqG479znZnnb0MEjh4DRiWE0uv04ltbF8SVy0=; b=SjkXGKxd/LkM7p
	V4kbIi/hAkrrkJP1FBkBpvfEGREo3skw8v/iFtLiNj3k+p+mVsgzVoH51kwDAEh4v6tEPC+FYFJpy
	ofYF3jQbhEf5dN/zrPS2wReXmbUZpEZJOW8XvObnx1u4XxJiNlMAKaXisPCPC3J/EzxxziUbF7IlY
	CSSntr/UodoCcrBvkcqhPFy1kKv5J9grEpaNeXzrNrif0CfaGPEbZftr/aKLxNXJdAyteUsyiOD7T
	KfxmtDJthstvT50dFxLrXOZz5eaRlCCyMcYMJEABzS1VtsihYcGYRe5ZJY8dBHbtc8frj2iJoNaZ3
	eoXlXaYyyULDPg8leKsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ilsfJ-00086D-E0; Mon, 30 Dec 2019 10:52:49 +0000
Received: from mail-bn8nam12on2103.outbound.protection.outlook.com
 ([40.107.237.103] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ilsfE-00085h-TP
 for linux-nvme@lists.infradead.org; Mon, 30 Dec 2019 10:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fovDtZ++11zRvoWJPjq2fnO3Tt2xa0HxDu690US2Egh7rxupaOIpGTlc7CZS/NEYsJvBTqAvKf8rlW9xL90qOIhoMo8qDPVMvj63RZXpXvOpM1dU5BE7O7AgAkJddcRjvEY1sRaBdrZ2hpq7xZe3f/gMu8zrz8gnXsLgQnRzhnZy09YN4c+4poLzwSLW/Gd9/k61PDQ5gsve6/OISI6losG8lOhmOPglFHo9KalXns2J8qTz/TmAfeiZar6Rh7SF/MZk+Nn9cAVOyJPBI7qbxe2pPVyQHNF1MGu7Ir07H7y8jN1FP0VEab9tSZpCDbwGo9T3QRV0Yyx2YR6Ndunm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crJZBH8xFoD8IwZ0uLmw3PYKIKEsJf9nHKKwEtWrbw0=;
 b=Ai/9Hzh/ve7N86UH0MXwAylOv0G+xWIIV2ozbF/HPVTwwLyhZALbob2mUfrIsOouzL2rG0LLRWwpBbfaM4t50XXefN+t0FmG4HKMzFnFCLUaBwM0bbtBP4ozIW78qCIH/0MNMe6vpeokkEuPTwFssKqmkuHGIEC1IVI6NLsolRzIfOt8KXY6Dw+QkeV5FoAv5wfoB2MWSOSw2VSxUXJf/sqTdzDsDeq9sYFGGAnaFwBr9NknD6Wu1zRSQgws7HhMIzS3Cu1UY8sQQa+6vJRODGs+0+Q4//36v8ntJi2t2BgmzQ9vmAOEiQpLG0zsyUOWfMYsSb0ChWFley1Wiv1z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crJZBH8xFoD8IwZ0uLmw3PYKIKEsJf9nHKKwEtWrbw0=;
 b=vrpVgAt3dgYYROZLHU/4zJH0uUCpekd0tbKayO2TSNI1CEmJTnXddNB3xvAAd+kWc3S8lOdeg6spPsVeLk1DVpcpkFmM07UBBTWjoZ/iyemfnqz6Y7W1IQS1fJc9/6f2W17vP+Qr5UTnOZeWrk5c7ZyaCAHY71oFimS/JTrxpk4=
Received: from CH2PR12MB4005.namprd12.prod.outlook.com (10.255.155.224) by
 CH2PR12MB4024.namprd12.prod.outlook.com (52.132.245.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 10:52:39 +0000
Received: from CH2PR12MB4005.namprd12.prod.outlook.com
 ([fe80::1cfa:52cc:4992:1f51]) by CH2PR12MB4005.namprd12.prod.outlook.com
 ([fe80::1cfa:52cc:4992:1f51%3]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 10:52:39 +0000
From: Dakshaja Uppalapati <dakshaja@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, Eduard Hasenleithner
 <eduard@hasenleithner.at>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: RE: nvme blk_update_request IO error observed on formatting device
 with kernels 5.5-rc1 and above.
Thread-Topic: nvme blk_update_request IO error observed on formatting device
 with kernels 5.5-rc1 and above.
Thread-Index: AdW8valXLRnTQ+ULQCyoSItdiN7B9wAn7Nf8AGfyQPA=
Date: Mon, 30 Dec 2019 10:52:39 +0000
Message-ID: <CH2PR12MB40050ACF2C0DC7439355ED3FDD270@CH2PR12MB4005.namprd12.prod.outlook.com>
References: <CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0@CH2PR12MB4005.namprd12.prod.outlook.com>
 <0b33acdb-2b8c-2a06-3c6d-b978f9a760ad@hasenleithner.at>
 <00d16b98-fcd1-2439-b50f-ccc992bbf871@grimberg.me>
In-Reply-To: <00d16b98-fcd1-2439-b50f-ccc992bbf871@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dakshaja@chelsio.com; 
x-originating-ip: [111.93.130.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 467d82d8-b5a5-44f7-3bfe-08d78d16638b
x-ms-traffictypediagnostic: CH2PR12MB4024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4024B69EE61EA9C5DA7F2C2FDD270@CH2PR12MB4024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(346002)(39850400004)(366004)(189003)(199004)(13464003)(51914003)(8936002)(6506007)(8676002)(508600001)(107886003)(4326008)(81156014)(81166006)(7696005)(5660300002)(53546011)(52536014)(186003)(26005)(64756008)(66556008)(66476007)(66446008)(66946007)(33656002)(54906003)(55016002)(316002)(86362001)(71200400001)(76116006)(110136005)(9686003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR12MB4024;
 H:CH2PR12MB4005.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iG+vmShLb4zMJApXRkryomsM2bszJHBIzKGBJ3y4RI+ihoKHViYd4YkGGRN8Y+C62XCJQ//9Kabsz45Oztlmt6YYCS99Y3IUTQrQz7F++Jo6Eu/jlqCFu4T0Wg2Srk5NJPH9hTASEfdg3RzMVnUtIIvSZQ+1VkFCcsmFehnIvOgYenOnf/uruGmljsuP8VOUVGkIH8A5jz77mscfB56Xqh3g+cO/iCccuD+rISW/91uK4tBE6ZajvicLfo/mbpJsV0ZA6H0uYEFq9dgKV5qaslhuObqBExdb/XH9tAKBwCWYxE8QiuyPZNq8wS5CPYUdJVRpAJbuc5KgQg8PuFegs3BGSqM+AzjEUS2/O6H3kW20xqSZY72+ySPJdXp7P5XwCIweORwHPmWZ2CohlqgpqvFT3IEon/MvQp+Q4jCyJ9d3vQduiwLDqAXFY4xpinB35hqoNDkG+KM+2zFSt2dgTdARieUAkdmPshqK4D48niAaPGWBH9JxhBkY+JOtfYHBc7riPR6pIbwEJiwQm6JBlg==
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467d82d8-b5a5-44f7-3bfe-08d78d16638b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 10:52:39.4051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkhHJoE53hY+pp6BvirxvI3BmokTH9km8ug4rgr78BPaanJEcH71C02BRmBx07BUFMIBub9uGOzi+IQnbEsFjBRAhOYbjLM7KDJ71f5NRyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191230_025245_007632_788F093B 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



>> How big is the ramdisk?
It's 200MB and also tried with 1GB issue is seen.
>> Are there further error messages in the kernel log?
No.

> Its probably the target not expecting that dsm ranges payload doesn't match the command sgl desc...

> Does this untested patch help?
Yes, with the given patch error is not seen.

Thanks for the help.

Regards,
Dakshaja.

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, December 28, 2019 2:31 PM
To: Eduard Hasenleithner <eduard@hasenleithner.at>; Dakshaja Uppalapati <dakshaja@chelsio.com>; linux-nvme@lists.infradead.org; kbusch@kernel.org
Cc: Potnuri Bharat Teja <bharat@chelsio.com>; Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: nvme blk_update_request IO error observed on formatting device with kernels 5.5-rc1 and above.


>> I am trying to setup and run NVMF with tot linux kernel 
>> installed(5.5.0-rc3) on both target and host. Attached is the target configuration using ramdisk device.
> 
>> The following error is seen in dmesg:
>> [  219.507989] blk_update_request: I/O error, dev nvme0c0n1, sector 0 
>> op 0x3:(DISCARD) flags 0x4000800 phys_seg 1 prio class 0
> 
>> Please let me know if any info is needed further.
> 
> How big is the ramdisk?
> Are there further error messages in the kernel log?
> My current speculation is that it might fail in 
> blk_cloned_rq_check_limits, but then there should be an additional error message,
>   e.g. "blk_cloned_rq_check_limits: over max size limit".

Its probably the target not expecting that dsm ranges payload doesn't match the command sgl desc...

Does this untested patch help?
--
iff --git a/drivers/nvme/target/io-cmd-bdev.c
b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..945dffc82503 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -280,8 +280,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)

  static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
  {
-       if (!nvmet_check_data_len(req, nvmet_dsm_len(req)))
+       if (unlikely(nvmet_dsm_len(req) > req->transfer_len)) {
+               req->error_loc = offsetof(struct nvme_common_command, dptr);
+               nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA |
NVME_SC_DNR);
                 return;
+       }
--
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
