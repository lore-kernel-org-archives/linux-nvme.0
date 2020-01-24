Return-Path: <SRS0=TgIa=3N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0794AC2D0CE
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 08:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1372075D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 08:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QoJnUmsF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chelsious.onmicrosoft.com header.i=@chelsious.onmicrosoft.com header.b="VIiJKqw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1372075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B0Z5UmgiMVkMeIhZFkOYkPjdBmG/8M9+XYhcekZytQg=; b=QoJnUmsFdDgMgj
	k87VB+vqaBPmdScqBU+HnWuhGCtTjHNc72A3m4k5h+O1mpU7xCN8PAhVhdHyw0QGQ0xkpCQ7K8qph
	cDCqJadM4qDl3QC5Xa61k+ROiDSCYzMEgFN8nWbCrsW6MWXr8NX1ubYWGQ4Y+IyqZ9Vn+sSOFAZwO
	u6ysPMVMg95mBASep8oEsyg2d7TaXmCY7c4c6REVSAAYJYfh3F2TMGqyQQiEHeVV20fN71OuLHJu5
	0Y0axpOi426RTPEc16+zG2IT1TcpC+uevs/wHAU2/PTgSQ7WN5a+c6W7WV/a/RZMnPgpb29yJEGvP
	yLG8bJcNk9V8DqQ3FpWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iuugl-0001fu-1U; Fri, 24 Jan 2020 08:51:39 +0000
Received: from mail-eopbgr680136.outbound.protection.outlook.com
 ([40.107.68.136] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuugg-0001ee-Iq
 for linux-nvme@lists.infradead.org; Fri, 24 Jan 2020 08:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4Xh8fPUZsJqGg9R9XfzqS8jNUn0Ur4j2/ZP4UMAlXUPzQHG1U49Vn/KCZHe8rDGpMEVYQT65aBqMMxnrbqIMlsylNRxzwfK45X5YBH4FOtJAKMTy8SIk8D/0exdx9WgNhsF5jwAc878L2DVfNgwBuO5u7fQP9LFAgrqL5Bsw9FlooJoc47fNCMuqTuEky+hCJCgf/JhbA3KuGVTn9g2zWmuxqctDjOhWEd59Kzcm4MI4qW+ork40JkDHRBO8Vsx30u3kL+MOi0yAPROvHIzCx4EK1pRmeC/RZVoFzEkh/jl8W4wz8eA7wZvlcg8Io6hBoT2PxXzMaKH6hRYMRQ/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGu4SMfPuBlYNHrLNVUicT6sVfRfM0Qdp9yZwkPIbzk=;
 b=Z4X14OF+6SQ36eKIF7LJHiMMqjCLEEA6gEnUM97NWwpBf/Y7qt4QfL9HVrL+Pj4XnvyDKHNm6Qv3HYP+15QVCvJ1QQrr5h3EV/YelFYzCKfaRS8A8CZzq2lmrqP5/l25yam55RMF4RDyjvJIP9vSAlVDwX2fgME06A+ZHBI186SwakQ2WBHuVcJGOwkzYThTFHwEYwZ0hQ71ctoF1rou/QSWYBrBw7Kd3mFWK+pBNvPHE6hPZt+xmI5wAZmYDQl0T8JQWNuGfRAGMLOPUaWN79cwjTtBdzXJSKXmypuxHR+lo+ouDTj3D6N7+a7Kws17TaNjFmFRhV6fWafzGE1ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGu4SMfPuBlYNHrLNVUicT6sVfRfM0Qdp9yZwkPIbzk=;
 b=VIiJKqw7GPcgl1kPWhzf4f1MPG46G1Ze0yJG48bPj0HujCakJR/dvk+h7GoDWSoeXBK/ILd7NSiSvE8jl27yOZkGdx/qQgi3xwcqoZZnjxDEQY/ZSyDH+SaKpTq54BaZ6QKxfz38knDI9mGyMamLp2WHnbCGaElJZUYfNur/DWc=
Received: from CH2PR12MB4005.namprd12.prod.outlook.com (10.255.155.224) by
 CH2PR12MB3848.namprd12.prod.outlook.com (52.132.247.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 08:51:29 +0000
Received: from CH2PR12MB4005.namprd12.prod.outlook.com
 ([fe80::4589:2f25:cba0:a480]) by CH2PR12MB4005.namprd12.prod.outlook.com
 ([fe80::4589:2f25:cba0:a480%3]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 08:51:29 +0000
From: Dakshaja Uppalapati <dakshaja@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, Eduard Hasenleithner
 <eduard@hasenleithner.at>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: RE: nvme blk_update_request IO error observed on formatting device
 with kernels 5.5-rc1 and above.
Thread-Topic: nvme blk_update_request IO error observed on formatting device
 with kernels 5.5-rc1 and above.
Thread-Index: AdW8valXLRnTQ+ULQCyoSItdiN7B9wAn7Nf8AGfyQPAE4n6FUA==
Date: Fri, 24 Jan 2020 08:51:28 +0000
Message-ID: <CH2PR12MB40059BF12ADD50A121B755E7DD0E0@CH2PR12MB4005.namprd12.prod.outlook.com>
References: <CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0@CH2PR12MB4005.namprd12.prod.outlook.com>
 <0b33acdb-2b8c-2a06-3c6d-b978f9a760ad@hasenleithner.at>
 <00d16b98-fcd1-2439-b50f-ccc992bbf871@grimberg.me>
 <CH2PR12MB40050ACF2C0DC7439355ED3FDD270@CH2PR12MB4005.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB40050ACF2C0DC7439355ED3FDD270@CH2PR12MB4005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dakshaja@chelsio.com; 
x-originating-ip: [182.74.59.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2d77dcd-65ab-4f5a-c13a-08d7a0aa9a52
x-ms-traffictypediagnostic: CH2PR12MB3848:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3848486ADC0FDD6C0D87B103DD0E0@CH2PR12MB3848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(366004)(346002)(376002)(189003)(199004)(54906003)(110136005)(107886003)(66556008)(64756008)(5660300002)(9686003)(316002)(66446008)(52536014)(2906002)(6506007)(53546011)(508600001)(7696005)(86362001)(55016002)(8936002)(186003)(26005)(8676002)(81156014)(81166006)(76116006)(71200400001)(4326008)(66476007)(66946007)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR12MB3848;
 H:CH2PR12MB4005.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9y6lGWtCPaPxHYk4ChNRMCCJHA6qlv3o/8xNX9orDyfvy5EegoNjB0HoOy104P+94RtjXJZZbN/5x6D0M54Tgdt0DFGbfi6kpyvA/bV5KENSAkijQiaHB126WCLYlwORe6xqVd5wEOc+gx2NMPZuKTg68llrd/BDfOW6zTmmDb8b1Ynjis2bCU0Z33eXj6Y4e0keXo/Y49M3kuzKKLKEAwYj9tORfuvfFq/ipYcbM1xzlz+LLUBRTJRPgVzOp6dFmVaauEI7aLP/npE0T3cZZgPVIKMul4gRRMFIhxCD7hbu5R2eS//eKIpTwfv1pT8OnVhZIdjUL6EMjd79wRa/2Uk/hvatCDXcej1ZzChYetBsM5v2XxyySyD0qChHiXV2nHopADJi/XLKhiA14FKXyCqff1HDExCyjDhTLHX1TCPvsCNeHpWZZLynpqBv4Xm1
x-ms-exchange-antispam-messagedata: DnB3ciS8LPaIGp/KkyoZc0+36ZR5mdBfoG+Jup+XFSoPfQD17Pz6rIxidP73NX19iSte+CcACVlQ6p20nuB+fNBdlbpCs7FYEoBMUcnF8NvL9y4O0jxd2sWIVXZZ2P2Fwf9Sg+l3+7yNNjfDFYFajw==
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d77dcd-65ab-4f5a-c13a-08d7a0aa9a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 08:51:28.8954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5Bgd5bkUXpzLpvX2JlohyTV0AXUgGpO/X0rO9RAGYUi5Eohh+FbqVCNHGUA0vNxQpq3XyCsbXf9r4zA8s3xij/sXv/wDY8JDTPVmQd8wH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200124_005134_773567_513951E0 
X-CRM114-Status: GOOD (  15.82  )
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

Hi Sagi,

Can you please push the patch.

Thanks & Regards,
Dakshaja
-----Original Message-----
From: Dakshaja Uppalapati 
Sent: Monday, December 30, 2019 4:23 PM
To: Sagi Grimberg <sagi@grimberg.me>; Eduard Hasenleithner <eduard@hasenleithner.at>; linux-nvme@lists.infradead.org; kbusch@kernel.org
Cc: Potnuri Bharat Teja <bharat@chelsio.com>; Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: RE: nvme blk_update_request IO error observed on formatting device with kernels 5.5-rc1 and above.



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
