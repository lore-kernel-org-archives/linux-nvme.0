Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB55C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 11:49:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312EB23741
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 11:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312EB23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U+5r/W99me7lODSCwm338r3NuWlMkbT2e1YvGqk7c5I=; b=kCN390NVQC/4uuQiKJ6dEW4Tw
	B9fdD3XSnxlf3mmZV14+l0mVGXqD2n2l0DHai9lmMKB5jZiel1xXpt/xRtBPfl2UlDqdro0NCl3hL
	OEvcQqpANMHlsPMrM+kbuVCqTmJuMKXMinbDFt9nrlATioYy+CL4B4X9OfipcFWg33oGvwCYLxRG8
	x1YYOcEDmQDT/I5UAZ/t8IKLjBguBFSSMVLaC2EQ1CkpKN/GCWR3DX/zLti3rcPYuKamOpoU8kiHG
	U1JVC3rqJeJSiVWOE7v2V1jgqWMZoXqxmlSiSCUL1Qay0k6gMZ4X1USaGT+/rno2nMOqi7Jf2Zlje
	yigSPF6Ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l018A-0004IY-NN; Thu, 14 Jan 2021 11:49:34 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0186-0004HF-O4
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 11:49:32 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10EBhWhB004529; Thu, 14 Jan 2021 06:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=w+HwP0e0cVkyYhYdHsMR8QbCg/82JcLuihXK7xsVyz8=;
 b=WX+wQ6J2XRo9Bt/nB1mr+C35WyVfxRY6Dyxa8kH9NkIfgJy35oAKGOL/FulIbyJjQkNC
 SJRP2jnUj19Om0aqkh7yjrvEWdHmNUdQLBN/2/Y9WBdE73HaHDLjJi5Ma/DOyr8geCyP
 Ven9DZm9F1HuPu7SqHJdYaEOXAJCfTnH6F4D/RP1vuVdo7glD7YqNam21b3pX3T8JzpO
 jsU8jY44mrrarr7x3kSnuwdqgECB35q8NyqvFlcBtN/IipttxbEFbE/NuO5jsylB/uuq
 EOotQTAtBlV+wIFle6+H2bhEydH74gtgJL+rHBZ9/2GDFYvwyWPTvZF0OhdeJFZYz16E 0w== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 361fy9q0r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 06:49:26 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10EBjUpx128788; Thu, 14 Jan 2021 06:49:25 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by mx0b-00154901.pphosted.com with ESMTP id 362kd5hpfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jan 2021 06:49:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/HeHADZCSiXGX63ZpGG6ww8vK5aKxZgkc2rEym6WzOm2K66IWQJk/y86YKef0H7+DE4DCP1B6tSZsyylvrEobTBpNRA9QrZ3IqMxbdJWw8v8RiAKgUvRq/IMVNLQRrNI+3CHhBrp10pF+n+yJKCWAyFB/LOyCtjwAjE9QYyKrEqTV0ah435TtvT5gdUkKSNrXcIxKA/C5ZmQru/nSKc/Xnxz1xfYk9BqiQ0Rw8JZihi/B2r4BKPGorluANX9ENHNjvGmoYufgd9uUbIbHJNcUDoJozrelBDzdNlNM7GZzr9NTV2h8/s/PZkjPfcln/TNmrWKxkUeze9DLO9/8NAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+HwP0e0cVkyYhYdHsMR8QbCg/82JcLuihXK7xsVyz8=;
 b=EA479PONGCY0WCObS29Lx1aREEohSVjjfv/v7+S8U0LVB/smSP/v0hZgVH1GoHasMfvAF3O+WTftAeC6SGETIrJiGLb91XAy+Pl+hQSM5wVBlGMXPxffkfIHj+hf0SFMAECaFi4GIp0kszh0w8hX4WPMPh3D+CvHClg4ah+Cuu940A99E44OjjKizIO12PIrIhKuETT3SDtBlFhCf0txTTmS4eL8JG12nftMfqsaB6Z2jvVAwQ6NcHlEDyAfuIWrADkxao0nlcA712yG+iVF3rll+WUyPHRl48l6o91ORAZAVsu2dL1nBuakggZSU17tTKVQZznfoLyfjKMyd93JIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+HwP0e0cVkyYhYdHsMR8QbCg/82JcLuihXK7xsVyz8=;
 b=BTx8mZRKOTp7eOlRmZ+OEVkh0Ip+qE+c1laOMj86IHGM6VthbRAjb5tyleCawnvIh9X0EUVKESPooQArXoRLNeE5+vuEcAC5f/ZueWinQEb6KtXLGkR+MTA663KFLRCqwD0gjRY0C0DQ8d7iIM2ihuafqFiGqxkxLOXn2bnc/M8=
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB3162.namprd19.prod.outlook.com (2603:10b6:5:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 14 Jan
 2021 11:49:23 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 11:49:23 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "Engel, Amit" <Amit.Engel@Dell.com>,
 "Anner, Ran" <Ran.Anner@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Topic: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Index: AdaWdvf+7tpUpYyWRD2wZy6V/04JWAAKtLKAAB62/8ASo86R4AB72xCAAJg5OIABG48NkA==
Date: Thu, 14 Jan 2021 11:49:23 +0000
Message-ID: <DM6PR19MB401188A9DCF3FCC762A3CCE4EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
 <BL0PR1901MB20671CF789D8C246AF911B4D91330@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <DS7PR19MB4439372515F931BA5A1578ABEED30@DS7PR19MB4439.namprd19.prod.outlook.com>
 <dec5fc1d-62d6-1c1e-e2f8-4aa5aeb084af@grimberg.me>
 <2f2b2df4-ba06-a7ae-23cf-31eb17998c6e@grimberg.me>
In-Reply-To: <2f2b2df4-ba06-a7ae-23cf-31eb17998c6e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-14T11:49:19.3206162Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=45a0c025-2c3b-46c0-852e-57eb1747db75;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 513d17f9-cb8b-4e2b-6537-08d8b8827007
x-ms-traffictypediagnostic: DM6PR19MB3162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB316200DBCFFE33CF4EABA3E0EFA80@DM6PR19MB3162.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k15Zqo0Lwa3g8e4lf9ZpGSr0nLC5yq/189D3M4Rd1VP+g+sQwsFJTDAiFXU6nIg4ysv/3uwTQ6ACQsGfiMKjbI6R25+piRG9Ymy/YCpPHH6b+IezABq20DcHASLLmgMMVgJKjhtWit1RXB/6gNSni5j4joMXkJGs8bpDB6EZ72ovEPCUEjZXBn4EoqLxmgxfkx0h+UvwUhCtfzKfM8RhwABgUiOTXbImUYtGZT4q0TC5cA63PbPfU0cKz8pL8DKAPegyPkp3BvvFMLOiculMTXu37dqBQdGGN2bJXY9tKplosMut9G0OZ34HqFX59cBuKHYgSNyeWUkL4XEXsXDaFj6YorbZ7FQfb0J4xclTJM5a6JCLANxW56b3OfGtP95hC+olHcNiR33tfmz/4dqan33gRxu/4ymRXlQFFIgiMiaDVWJKMfWtPxCPaGq8CP1BzvEZfHkUjHf65oL6NjIR0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(66946007)(4326008)(66476007)(66556008)(66446008)(64756008)(52536014)(33656002)(71200400001)(2906002)(7696005)(8936002)(107886003)(76116006)(5660300002)(53546011)(786003)(55016002)(83380400001)(110136005)(86362001)(8676002)(186003)(316002)(26005)(966005)(9686003)(6506007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RitjbmRHcE8xcW01VkVTaG4wb1p5bkhPc01CUFJYK1pKbGpYY3N6WmdOd0F6?=
 =?utf-8?B?ZHkxV3BkM0NENkoyaXo2aW1OOThUQTRJOEN4L1hZT1UweXdEeTFhQ2pYUzFm?=
 =?utf-8?B?NURodVFkcm4rMHc1cCtFdXpQYnVhK3QrRUhiSU5DQmkxQ0xNVkNyQWlKeUcz?=
 =?utf-8?B?Qm9yVmRGREVvZ3NRZFkvcHA5am1iOWNkWXhWYS92NHE0Rm93SlgzTC9YbFFC?=
 =?utf-8?B?UWN5ZjJ2eVFlNHo2MExhUDBxQTMvd1NCbmt2YUlOV216bHFlS1JoR3h3aVEw?=
 =?utf-8?B?d3AxWkNLZjBDSllRRHBBMjZxcy9qaytGMWQ5M2M3N2lzRlV0MTBTNllET1gz?=
 =?utf-8?B?eDJaUlNNL3pUUjgzMFNYcGdqUDRrT2I0U2FOQ2RXUlBkbzNWWlVqTGk5R0hp?=
 =?utf-8?B?akNIYlM5MldEZ0Q0L056QmthN2JrSWtSNytsV2ZWZ0VPYlVhVFlyMlVSYXlQ?=
 =?utf-8?B?NTh1SS9QUHArTHRvVUVEOHM1aEhVZi80WDEwajhJUTF6eWs4Z2tSYjlYbEE4?=
 =?utf-8?B?T2FTemk2ZkpNQ29vL1ZuRUFodVhlaU1UOURUUHI0SHF1Ymc3V3FodjRodlJW?=
 =?utf-8?B?NU5ZekVIZ3ZGdEFvQkVtemJkZFhTcDBDMzdYNHZucjZpZU9uWHVObjZ2YzNn?=
 =?utf-8?B?ekoxYXV5ajVuVm1rTUpoOTBVSWdBS3hiWVNIMi8wU3p3RlIyVmVFN2ViQmw3?=
 =?utf-8?B?TXhSdnJEZCsxZGpSUXcvc1JJMUZtSTJhRGlTUmJrOHlFSHd4RVZ0dTRpK2tz?=
 =?utf-8?B?bk00cUM0TTNsMXBuMHNGZWlzVXk2eU10R1ZQRkdWWW90U2xxNWdUMFl4R25P?=
 =?utf-8?B?cnhpb0VHWURtNTFtZ3BXRkltZkVmL1BWeFhMWFNpTFJRWXV5ajBHQXplNjVE?=
 =?utf-8?B?VG8yTkdURHlHbGJTcHNYYXQ2Zi9mMUp4elVGUUlkcDdwQ1grWEVTczV2Vnkz?=
 =?utf-8?B?ZHp3eGIwYkRHby9KaVlIZVlnTDJjR0R4TTRkQlR4Sk5KbHlRaVdtbHNBWVNH?=
 =?utf-8?B?M3dDZ2syRlROVVdqZ09pVVB2UkdXOFl5Sld1d3lxbFB4cFpBVi9FVzhmRXg3?=
 =?utf-8?B?cldVL0JlUW1Ha3BBV0ZCMVRNU1lYLytscHVadHNaaXQ1aU8weS9WWFUvRW5r?=
 =?utf-8?B?ZnlqUm1CMkZtaVBTRWVZMndydXpYRmorUTFscVhqUjZHUmxkZlNwRzYreXZ6?=
 =?utf-8?B?ZjYreDN1Uy9wWUo5dllBVFZTa2dKcFlLRjNObE1RU3ZuNW53VXF2Vm5NN1dZ?=
 =?utf-8?B?OUhjY0FRUEpKWXhWUUR4cWJ5aW9uMG1ORnNlMmZTWjF1U0NrdE5Od0pGQUF0?=
 =?utf-8?Q?TxaZnQ6Z6npYU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513d17f9-cb8b-4e2b-6537-08d8b8827007
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 11:49:23.6472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfFdpw019X0jNbuACdEAoKWomuzjT77TVpj4GYJeyIxh2xSaHoVJcSRfw/GckldrBCN5iUzOek/3451TMpONuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3162
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_04:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140069
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_064931_275993_287E0ECC 
X-CRM114-Status: GOOD (  24.85  )
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
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi

This patch did not solve the below issue. We still see the same kernel panic.
We reproduce the issue by adding a validation to the resv1 field in connect command.

Few comments about your patch:

In nvmet_tcp_unmap_cmds, need to use queue->connect instead of cmd:
+               /* failed in connect */
+               nvmet_tcp_unmap_pdu_iovec(cmd);
+               nvmet_tcp_unmap_data(cmd);

Also in nvmet_tcp_uninit_data_in_cmds same issue:
                 /* failed in connect */
-               nvmet_tcp_finish_cmd(&queue->connect);
+               nvmet_req_uninit(&cmd->req);

Elad

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Sagi Grimberg
Sent: Friday, 8 January 2021 22:24
To: Engel, Amit; Anner, Ran; linux-nvme@lists.infradead.org
Cc: Zinger, Eldad; Grupi, Elad
Subject: Re: kernel panic in nvmet_tcp when receiving malformed admin command


[EXTERNAL EMAIL] 


>> Hi Sagi, is the patch addressing the below issue is already out there?
> 
> No, thanks for reminding me, I'll have a look into this.

Amit, Ran,

Does this solve your issue?
This needs to split to patches but would be good to understand if this works.
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index dc1f0f647189..c41902f7ce39 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -204,7 +204,6 @@ nvmet_tcp_get_cmd(struct nvmet_tcp_queue *queue)
         cmd->rbytes_done = cmd->wbytes_done = 0;
         cmd->pdu_len = 0;
         cmd->pdu_recv = 0;
-       cmd->iov = NULL;
         cmd->flags = 0;
         return cmd;
  }
@@ -294,6 +293,7 @@ static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)

         for (i = 0; i < cmd->nr_mapped; i++)
                 kunmap(sg_page(&sg[i]));
+       cmd->nr_mapped = 0;
  }

  static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd) @@ -341,6 +341,14 @@ static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
                 nvmet_tcp_fatal_error(queue);
  }

+static void nvmet_tcp_unmap_data(struct nvmet_tcp_cmd *cmd) {
+       kfree(cmd->iov);
+       cmd->iov = NULL;
+       sgl_free(cmd->req.sg);
+       cmd->req.sg = NULL;
+}
+
  static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
  {
         struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl; @@ -375,6 +383,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
         return 0;
  err:
         sgl_free(cmd->req.sg);
+       cmd->req.sg = NULL;
         return NVME_SC_INTERNAL;
  }

@@ -571,17 +580,13 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
         } else {
                 if (queue->nvme_sq.sqhd_disabled) {
                         cmd->queue->snd_cmd = NULL;
+                       nvmet_tcp_unmap_data(cmd);
                         nvmet_tcp_put_cmd(cmd);
                 } else {
                         nvmet_setup_response_pdu(cmd);
                 }
         }

-       if (queue->nvme_sq.sqhd_disabled) {
-               kfree(cmd->iov);
-               sgl_free(cmd->req.sg);
-       }
-
         return 1;

  }
@@ -609,9 +614,8 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
         if (left)
                 return -EAGAIN;

-       kfree(cmd->iov);
-       sgl_free(cmd->req.sg);
         cmd->queue->snd_cmd = NULL;
+       nvmet_tcp_unmap_data(cmd);
         nvmet_tcp_put_cmd(cmd);
         return 1;
  }
@@ -665,6 +669,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)

         if (queue->nvme_sq.sqhd_disabled) {
                 cmd->queue->snd_cmd = NULL;
+               nvmet_tcp_unmap_data(cmd);
                 nvmet_tcp_put_cmd(cmd);
         } else {
                 nvmet_setup_response_pdu(cmd); @@ -1082,15 +1087,16 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)

         nvmet_tcp_unmap_pdu_iovec(cmd);

-       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-           cmd->rbytes_done == cmd->req.transfer_len) {
-               if (queue->data_digest) {
-                       nvmet_tcp_prep_recv_ddgst(cmd);
-                       return 0;
-               }
-               cmd->req.execute(&cmd->req);
+       if (queue->data_digest) {
+               nvmet_tcp_prep_recv_ddgst(cmd);
+               return 0;
         }

+       if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+               nvmet_tcp_finish_cmd(cmd);
+       else if (cmd->rbytes_done == cmd->req.transfer_len)
+               cmd->req.execute(&cmd->req);
+
         nvmet_prepare_receive_pdu(queue);
         return 0;
  }
@@ -1120,14 +1126,16 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
                         queue->idx, cmd->req.cmd->common.command_id,
                         queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
                         le32_to_cpu(cmd->exp_ddgst));
+               nvmet_req_uninit(&cmd->req);
                 nvmet_tcp_finish_cmd(cmd);
                 nvmet_tcp_fatal_error(queue);
                 ret = -EPROTO;
                 goto out;
         }

-       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-           cmd->rbytes_done == cmd->req.transfer_len)
+       if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+               nvmet_tcp_finish_cmd(cmd);
+       else if (cmd->rbytes_done == cmd->req.transfer_len)
                 cmd->req.execute(&cmd->req);
         ret = 0;
  out:
@@ -1139,7 +1147,8 @@ static int nvmet_tcp_try_recv_one(struct nvmet_tcp_queue *queue)
  {
         int result = 0;

-       if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR))
+       if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR ||
+                    queue->state == NVMET_TCP_Q_DISCONNECTING))
                 return 0;

         if (queue->rcv_state == NVMET_TCP_RECV_PDU) { @@ -1333,10 +1342,26 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)

  static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
  {
-       nvmet_req_uninit(&cmd->req);
         nvmet_tcp_unmap_pdu_iovec(cmd);
-       kfree(cmd->iov);
-       sgl_free(cmd->req.sg);
+       nvmet_tcp_unmap_data(cmd);
+       nvmet_tcp_put_cmd(cmd);
+}
+
+static void nvmet_tcp_unmap_cmds(struct nvmet_tcp_queue *queue) {
+       struct nvmet_tcp_cmd *cmd = queue->cmds;
+       int i;
+
+       for (i = 0; i < queue->nr_cmds; i++, cmd++) {
+               nvmet_tcp_unmap_pdu_iovec(cmd);
+               nvmet_tcp_unmap_data(cmd);
+       }
+
+       if (!queue->nr_cmds) {
+               /* failed in connect */
+               nvmet_tcp_unmap_pdu_iovec(cmd);
+               nvmet_tcp_unmap_data(cmd);
+       }
  }

  static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue) @@ -1346,12 +1371,12 @@ static void nvmet_tcp_uninit_data_in_cmds(struct
nvmet_tcp_queue *queue)

         for (i = 0; i < queue->nr_cmds; i++, cmd++) {
                 if (nvmet_tcp_need_data_in(cmd))
-                       nvmet_tcp_finish_cmd(cmd);
+                       nvmet_req_uninit(&cmd->req);
         }

         if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
                 /* failed in connect */
-               nvmet_tcp_finish_cmd(&queue->connect);
+               nvmet_req_uninit(&cmd->req);
         }
  }

@@ -1370,6 +1395,7 @@ static void nvmet_tcp_release_queue_work(struct
work_struct *w)
         nvmet_tcp_uninit_data_in_cmds(queue);
         nvmet_sq_destroy(&queue->nvme_sq);
         cancel_work_sync(&queue->io_work);
+       nvmet_tcp_unmap_cmds(queue);
         sock_release(queue->sock);
         nvmet_tcp_free_cmds(queue);
         if (queue->hdr_digest || queue->data_digest)
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
