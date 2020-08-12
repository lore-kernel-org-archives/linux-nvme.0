Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE205C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 07:05:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2C92053B
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 07:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYpyrN0l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="iw1JnpAW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="E0Ag4qy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2C92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=76Lv3kO5CAR0FulNhpIeEpruEnEyro0S8Z6wgAs8so8=; b=RYpyrN0lph5u4jbjbXC6opbo/
	qyDjF929A9vBdi74Y0yq9XHwYkjngKbwveo52zYH2acprKfYvbcsIcU87On0oarjq87r+No1YhDrj
	HMRrfC0d4Lc+HvjkM5c+SC+0CDoilritzmW7Ixp9d64U0FFEQ9TB2DygLWSu5TZ5FOS9GT5PUlQaY
	1acLU4Oht7nK5fWH8givX/jBopWUScVSvnD7phydahGbHRcAqyWfzeG++9Vp5dK5jyEp7XLRRH2AG
	o0Rr9RpW6YPKZY+1+tuVQtxhE+yvW/R+i/QTGHpuwDEEc41cytKhkJR5bJ/pKU/A8JQCgKkKcSm9m
	+0OpASrNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5kpU-0007vP-CU; Wed, 12 Aug 2020 07:05:44 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5kpE-0007sg-FW
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 07:05:29 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07C6ujbN015046; Wed, 12 Aug 2020 03:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=K1pVMK6vgT7mXNqfHDdH0UbfPuUrZiywS9SnhBt286E=;
 b=iw1JnpAWwguLjJ6PjFu/6kEus2PXD9czyehjkX4s0fiH+3pcLdSOs3R9ujd7RLgt25AY
 BPifaMHu2DqyItTSLfZIgVctYc3CufJuR3kYfR4/YdpJY6t5j9Zu1Faw4uw1fBtJFcO1
 wnQfmjN+L2l+QeUnfAtHtEGG4vljXuNZGOKezkj0DtbS+CCSBlaZIgEsHHnp+UC8PoAf
 QlmM4ge+iK/6iP82jRsAuc0UBgedKtc6Oj+N92d4N33OHscrnr75S2sigf1ad1SD/jbb
 zXbUDyrVOMhYlvSmn7ALV9lC4YIj7n/1JgRZXnhIXF4XDONooKO2dCmkGiJiJvBc8eei ig== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 32srqnc8h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 03:05:14 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07C742ao003093; Wed, 12 Aug 2020 03:05:13 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by mx0a-00154901.pphosted.com with ESMTP id 32vaa91qmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2020 03:05:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0R6kkuU0anXPSTjA9bMv3xoCz7798Zmuj+tHwbg2xfR8IzHcW6SWxWhFUKiGoGfvZqz+AwEkXmaCPLmVcRhWZiyTFqHVtJHY+604siiaM+k1oxTsPwmSk4e2xSmhEBwYnpUsDFOZz9QPyjU0xJMI20ijYV3sF5Qrga4DXtueUIVH6Go7j6Cxhuhvjp76wYT1s6XOrMWqupeEAAkmIvoEcF/2w+sg2jWDUqQKgTqGu7WQeuXUoQMzeKBErQ6XyjfRYrvuzChBqizYCaXLB6grK/1YSg5TIJ0JuPFQWKUA98GdLtjFz2Fsh4ouEMMyQeBvlz1EgakcRqsuiic/WUO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1pVMK6vgT7mXNqfHDdH0UbfPuUrZiywS9SnhBt286E=;
 b=Xv2BzZ/eXfATIGY+gdU5XOcFlZFTSLHvFRFuXzQIhcr+EOSEsoEzrJ6a7/UHRSyt74UObBbOS0HNc/Dyad3o9IFzFgkgLOmXCp0ISdvb2zhuQlFloFQ4d71mUXh+XS8/i6ZKvGZgiqJxJw+8mwqt/mfUWQH/QnGmXW3LAE6GdgbVLPqP8lFS0Oqc/FHPBwRwoO4mTkbYwGCRvIobjPVYzvxUe5wCMN3a05ThoBc+UAkmE5NjuMhHFZ8+0bRzl2Lnnv7wbfGyjFr300tEq067vzgDrWWCM/6r2jNX/UEpffdisf5QKcW8WZ7HdtgTfwVZT6hDExxA7F/jd3KAfJhfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1pVMK6vgT7mXNqfHDdH0UbfPuUrZiywS9SnhBt286E=;
 b=E0Ag4qy3l2IGEpblQ79mp/jLid395esd7Cc3fN+NCf579k3bOHX2Yw9PuvVkyNUGKkJEn856+FpC1ZnuECaxPwugCZkIsWeRJj5nDcAAgnEj8Rxy9G49U1MYBLzRFYWlxH8PmHjIVc8cm7aQ/CIrs2zB8DnsXKJCO9PLDK2SKrw=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB2445.namprd19.prod.outlook.com (2603:10b6:208:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 07:00:07 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 07:00:07 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: RE: nvme reservation commands during controller reset
Thread-Topic: nvme reservation commands during controller reset
Thread-Index: AdZq9/uNS/3GoWeGS1CKT5X8UElmUQDb5YwAACr4CgAABP8VYAABk0IAADzA8AAAFST0YA==
Date: Wed, 12 Aug 2020 07:00:07 +0000
Message-ID: <MN2PR19MB30051E06C5E2B5F16E8A5879EE420@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6> <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
In-Reply-To: <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-12T07:00:05.7196100Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=ae1a8306-da90-453a-81c0-7c205fb64496;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0101eafe-7a0d-421e-74d7-08d83e8d58dd
x-ms-traffictypediagnostic: MN2PR19MB2445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB2445E9E966744679431F5BB4EE420@MN2PR19MB2445.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgYJMuR+dTfldq/cmCHi/3d2VAEAmGfcmKgQZzLd66vjanCzRaJrX/gWouuwlu+BMp7+xldJy3NUj11j/0jJ4ShUisUTXFMvyEqyvvx6OMS9RGctCetdf2KBFF7vQPY3hE9Kg9tNVBlhsbZOcyL0HH3VT8gNaTgGE3I9d7k5VowMUTWAVkrBeDrDxAZu7fMZBEEtYP8w/d01q+iTlfuKySQW4ThviX01rf1S0BEz7Rflb1kLBzX15Sgl/QN1UztJQ5jrkDmMZd7ksMAuyYpJyN9JheXBuvXMZ1zYJ0SQZg57TPOpQmMmUc+0x+AppxCI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(316002)(786003)(55016002)(54906003)(110136005)(2906002)(7696005)(53546011)(26005)(186003)(9686003)(6506007)(478600001)(8676002)(52536014)(4326008)(64756008)(33656002)(66556008)(66476007)(76116006)(66946007)(66446008)(86362001)(71200400001)(5660300002)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4+podgqBMasSQhu6TFQxqAwGHRAvNx5C4ryC0SKefT4IEcNm7LxPPuDx96HrCbSzHrq+yfgvAEe+QmK/WyC3S3KwsaPXZmdDdf/LlfML2Au5grHSaLJnCvYpfIK9ZWTR+DDO1EvmOY9CSvnZWBxopP05Vp+vLK0MSuOU6nqOSY7ktC6/jurga9nk8MgLUaYnVuPd8Hfaub1J3raXqBW7cCo93zUaCya8I4UIINWd14XD4RVOdtNxTXQGzTP+OfrzsUH5M+auOM8NRRqlxTKP43OyRbcV1rA3glNcin7mpH9aOFppsQUoN1Cnh12Mb7+a7A85+ekuVaH5f0ip1P2YmWXYw2mPIUDXQj0C6lDf4jS/Nd67soi7XCnJjU8pUGoUBiy2amkb6I4Ru9OnHkkXcC1tegPuT5V8y0f7ABU+fiKuoAKDi+d0szFavMt3PHBbktnIkjoKG5QgNDpdE8bSQ8fKUXSzdAxdYWOM7be2iBNJp4vKNvnZWvdlfqyihUDX6wxpTK9ZxsMN4RBGNI2D9uEyI1mVZk9ZFQD8oGt2HlQVfO+0W/oJ1xBX/e/reUBZXRzvW5WMbVCZMYPWPUr/5AM1zOATndFF8147uoLlgdtj7bluy0Ls9UzEsnL66SCzOgTKbmD4P+LFt/HjslDVOw==
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0101eafe-7a0d-421e-74d7-08d83e8d58dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 07:00:07.4154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6c91qCp+y+lv5b+ndHO1Ld60+wFdYW9+L/wQNiESnEsczimw3AOcGrMQdZfChWl+Cl+OLs6pbH0Pzla+xL6j7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-11_19:2020-08-11,
 2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxlogscore=883 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120051
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=995 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008120050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_030528_576471_088CE7D7 
X-CRM114-Status: GOOD (  19.63  )
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
Cc: Christoph Hellwig <hch@infradead.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme,
cmd_flags is set with REQ_FAILFAST_DRIVER as part of nvme_alloc_request
while in scsi,
sd_pr_command is called with flags = 0

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Tuesday, August 11, 2020 11:48 PM
To: Keith Busch; Engel, Amit
Cc: Christoph Hellwig; Anner, Ran; linux-nvme@lists.infradead.org
Subject: Re: nvme reservation commands during controller reset


[EXTERNAL EMAIL] 


>> We saw that in case of path error, nvme reservation cmds does not get error handling.
>> This is true via the blk layer as well as nvme-cli.
>>
>> We are working on implementing nvmeof stack and this current behavior 
>> is blocking our host from running nvme reservation cmds during path error.
> 
> What's blocking you from retrying this command in your host software?
> 
> If we truly want to provide a way to hide intermittent errors on 
> passthrough commands via automatic retry, it may be a little longer 
> before such an interface hits a released kernel.

I think we need to keep the passthru commands as they are, but reservations coming from the pr_ops maybe we can failover these in nvme_pr_command?

What is the semantics in scsi btw? Didn't see any failover functionality for pr_ops...
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
