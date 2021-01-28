Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B1C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:07:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCE664DE8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCE664DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dpCEy1G9mRAAcxDgiROW+xwK8H97sSCcr+2etilPVzI=; b=UHgrbg1T21E10tX7nj+J4o5cqC
	m6Gi0aDLxSdYha6hR5NLyXeIDfylAakjp3qk+Xyduj1yd/1ULu3Qeo6BbdA6FniJezOWdEXZ2krVt
	gLqGt41sbipWn7R5s6ILfTlXqGZywpyWyDozdATIlLMk7l3Ks334Zj8NWSHG+OWVlGvBD0yKzPXpL
	DJe2UEL9FmycaJYOBVVO88kWAMmxqs+sM6WKwshbBXgtnqsIMOrLfrl2foU+dAuzeQMLfi5div3B9
	64l7JWMaYF+zoIOBdTWCxXUkT3+HWdaHZzlSJ0XvXXvR9To8hCAlim67P2ThQG/5rYcC9rKMQUX6B
	YRaBk1Kg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5GNr-0007Ex-Ma; Thu, 28 Jan 2021 23:07:27 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5GNo-0007E7-TD
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 23:07:26 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SMvRnJ029253; Thu, 28 Jan 2021 18:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=tTcGCp4i1JqRqhLAtgGpO6bIGWJIhDEIi2PHODVzOyg=;
 b=SkhBCUGxSPsRRo+85GhLguAo7x1SjzefWf8tetMVzRYEmf9XSMBJFtDW0CW/nW6YGfrx
 2HUKETp7txNUvdP6blZLhNrcoe77r1SXevDkWtPW7hy3UgDScZSguAh2HiSznmsdbq3n
 7MMpXp9kvDIHlZ3PWtfR3wTqSLCW4dGO3rwi+zZqDzeSfX3BLoTnWQz31I97l250ku6h
 Y6k/z+UAW8foqRNvUFsWjAe8Zn/na6JZQBHk2uRNpKPrZNdUQXPaV6EIunqyzI9TamXH
 YMZdK4zXH+2bSrOazJ7L8jSumX/xlcZB1J6bVsWdvIRJtGNuCxM34kuz3U3EDktoZEyw AQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 368gpramyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Jan 2021 18:07:16 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SN5pdJ124751; Thu, 28 Jan 2021 18:07:15 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0b-00154901.pphosted.com with ESMTP id 369259k1jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 18:07:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGztcn8oEG/Dfw2dHreuRbTfHFxkVmNJqycceUcyHP3YOhl6U1XiSXlHvc1Zg6hlP4lNRBANzGiLYM3V7qoJC/5kUYQ8wFVHbGyXCdwRp7gYNYKYeWamRRQ2TjXBU8MOfe6DbScx4o85uIE/4iMgKrN05ifDS0VRb1VSiqHZQGxtCYJe+fRPO2vYffmReRd0snJGDSToS4r++UJCBfSfDgQRQ1pPG4pfFRPGbtHnDA9zK0Q3pZmSl0eQSaB7vdWY13wHvOQI3W+LexG8Yb1dmaAI6sAL/TRxmVNua44XZpajkkHBt/p5iLRA5V+3bLFMt7Dw+LXtH55aaFNRpdj+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTcGCp4i1JqRqhLAtgGpO6bIGWJIhDEIi2PHODVzOyg=;
 b=KYpGqNrwN79DrY5lgU2Cwf7lWrmh1+WcGjIqs9kA0frETR9OGF4nRq9xv1/wB/2yoREgUWhAPqvUgw4kFdopmbGymccOTlkHWxe+tHrxXziL4fBClBn2LDtKIvtOecbsTz5hgx0rpr0rY0FQwUKNw79DeUI1UHmjs3dCI08Hx5GvImYi9uePITW6s9exK9AvDrGnAIs9NJqghEDzNlo5GDWZcAs01VItDYrAr4j0nIC2pEmwOLFKiJKbVDQAwb7wRzrl+OwerYBDbwYDuBNtadeHhnqBbMQBvpnh1vVuzcpJ0L0KeYSuL13Oq26Me1heZBcPNr4kXlVABNQ77I1kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR1901MB2103.namprd19.prod.outlook.com (2603:10b6:4:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 28 Jan
 2021 23:07:12 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 23:07:12 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Topic: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Index: AQHW9Yot5sDcdvF1ckSEbnpOtZTZe6o9l6yAgAAQh7A=
Date: Thu, 28 Jan 2021 23:07:12 +0000
Message-ID: <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
In-Reply-To: <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-28T23:07:08.8355720Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6e8e4ace-c833-4a75-8798-56f9a5a41feb;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bb5b398-9fe8-40e3-57da-08d8c3e17282
x-ms-traffictypediagnostic: DM5PR1901MB2103:
x-microsoft-antispam-prvs: <DM5PR1901MB2103C8044A4CD3053D9EA3F9EFBA9@DM5PR1901MB2103.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g783w1wPNR8wl593NkbmYhTR8wycyyYYJ5mvhASE7jvxOeU2fZ+d54AIhP5DSYNxehDUA3Y7LGMja3dvDh1YJBu4lJ+K+t9YP7gjx0+DLd4rK6RpqUpVZ+cWJfjPcNjExdS0lEVEyL7uNUBJfNm1CLNIz3HBKBDWcm7ilCs0h6UsUAJASFk2vlqZrimiQMQe10mzOrcOw3GkSLB38ZcdUfSt4SPfxkVcb1VGybGpzuqvfITOF3yC9NpyDL6RNBPuS/ixHI9zGMFGybLMBVIfLUnU+4Bd53dvqZq1a0auXnMvyMmFMp1LBcMjO0iW51T0ADAiovb8Wf/6ulvVd9IKY2E0oZJRcrjGkYNJsKYInuACOpz6YfAGE+WuwZjUdpDGLBartOzilpyiYmtKWSTw+WHKEFryXDj3UGcRLKQbP6zDM8Sgg3OZb01koYA3bZ061a+ejUZiQei2VsP21dwFSvSuq4gDFK8O2fccug3CljrBB2+22u6GTs7iRpwbkfWeS/WIxdypOXJnhfrH4fEBuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(64756008)(110136005)(55016002)(5660300002)(478600001)(66556008)(786003)(9686003)(26005)(52536014)(66476007)(83380400001)(76116006)(66946007)(7696005)(66446008)(2906002)(71200400001)(33656002)(53546011)(8936002)(316002)(8676002)(86362001)(186003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TEEzYU9QM09na2RuRUJTV2ZYMEMxOFA2WE9GbXQxaTQ2TzlZVkxZWmF5ZDNQ?=
 =?utf-8?B?bXVSdU5jWUdiNFU4VERJYVE3cHVORFpINGlWSW01Z1VUWmRoR2RRczBGdzM4?=
 =?utf-8?B?U1RhWHNOeVFGdEZZL3RHbkdjZ2tvSnh6VHN4SXB2WnRzZ2J1WkRTWEFGY1NB?=
 =?utf-8?B?aURkdm9WbHoya01BZ2ZKRkNsMUFvd1FITVB2TG41S1FnMWZpakFESWprbFZr?=
 =?utf-8?B?Wmk2b01qeXcvY3AxUitERUVzeWR5VkQ3bmMwV3NlaUJJZWRFelFEMVFnWFYv?=
 =?utf-8?B?cEsvSGd5a0JWSDRPWGlxb2FBNHB4TzBXWUdtSFJBSENYYjJxY0wvQ0N4T0Z2?=
 =?utf-8?B?ZjNWZkhsVWx4Qk1QTDd6c1NqRVJ2Uld1Uk0wV1JYQ2JtL3Fud2RvRkk3azRG?=
 =?utf-8?B?b1FiL2pKVFNLSmt5dkNDMDhnTHVOT1lxbEdoUG4wakRpZmpwRWl1OUpldWdx?=
 =?utf-8?B?TzFEclR6QnVyNUp4R0FKSTl5cFRZSjBuYUFuWTdyK29jcFk1a1VrcXo5NHda?=
 =?utf-8?B?ZmZ4WVNaelJMcHZkWFJ6VnlUUkhpdmtuSzdKOFB1a2xwNkNiaTgwcGlETkY1?=
 =?utf-8?B?VEJRK2hRaHVrVU94VE92a1FleEh6bkhJMEJzQzV3c0FlVWh6dFJyRE8vOVZh?=
 =?utf-8?B?LzhjSTV6cXZUWVgyNURDN1FKSjAyZVBCRmE0VW1nb3Y0a1c5cUprMVROd1NU?=
 =?utf-8?B?Ykd5Z0VkUzNXeDVXRUhWWDVOMGpSWnRlT0tLMWlrQlRuamRsTEtBTmh6cVBO?=
 =?utf-8?B?MWZPZ1RoQ2x0c1pOeWVOcHlzblBvVUFSN0ZZc1ZPVi9jR2xNR1libkpSOHB1?=
 =?utf-8?B?Y25MbXJqQXpJczBsTkxlVS9RU3UvS2VVOHdCaGtMSnJQR3g2b3JRcitOQ1Ew?=
 =?utf-8?B?Q1BBbkJUWWtRSW85ZFJOS1pyUTM3bUJFQUZaeHFqR2tKTEpqT2lIVjgyN2NY?=
 =?utf-8?B?Tlk0L2hicmlNZUxmbXpldU12dS9nQ3kwa3lzVEZUR0l0UEZjcUJwdEt2bXAv?=
 =?utf-8?B?NGJkOXVtOE5lN0tPWkpITStjUG9RZWNVZUk1WDlKaDF5MncyckxrWWtjck5X?=
 =?utf-8?B?VzI2d09yUjN2OTVjMXlIWnRUM2ZVWXZhTE5IREV2MElXaHNEV2NsajlWUkNu?=
 =?utf-8?B?NG96OG4yMEtxeFY0V1ZqUDIrV2srZFlyRFh2OGFDUVphckgzdXZZbHNTVURE?=
 =?utf-8?B?MlB1Q2d0VUtJQWtQNFUxaGUxTlpaYjBWbFZXb3V0MjdoWE9XQk9QdjJQdjBJ?=
 =?utf-8?B?eEhmOFZmWkRsUEVLMmlYNzg0cVBjNzQrQ29FRWdzYWw3OU91dktHbHgxME90?=
 =?utf-8?B?aUVuUnBQcitac2ZWODJDczVyc0pVWVBPS3gxTTQwNVNJNEErUzFzN2tiSHBx?=
 =?utf-8?B?SWt6ZjVLZE5jVnZGUUkvN1ltc0QrTnFZTEJDNXc4WXRlOUJsRkJCaGM2cWVp?=
 =?utf-8?Q?IEt0F83h?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb5b398-9fe8-40e3-57da-08d8c3e17282
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 23:07:12.7953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deEnRX38P6UPyrEmuDq5/90HWZBNONwhgSKwGTFJRxIqChFbRpRZLr3GWSfQmLWxf4Md0o4GW2AAJI3tI0f1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-28_12:2021-01-28,
 2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101280111
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_180725_218611_FB37C906 
X-CRM114-Status: GOOD (  26.67  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

That will work if sk_state_change is called under sk_callback_lock.

In addition, need to flush_work(&queue->port->accept_work) in nvmet_tcp_release_queue_work because accept_work is still using queue struct after unlocking sk_callback_lock.


-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, 29 January 2021 0:03
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows


[EXTERNAL EMAIL] 


> ---
>   drivers/nvme/target/tcp.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index d535080b781f..dac737bac874 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -647,7 +647,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   	struct nvmet_tcp_cmd *cmd = queue->snd_cmd;
>   	int ret = 0;
>   
> -	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +	if (!cmd) {
>   		cmd = nvmet_tcp_fetch_cmd(queue);
>   		if (unlikely(!cmd))
>   			return 0;
> @@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	sock->sk->sk_state_change = nvmet_tcp_state_change;
>   	queue->write_space = sock->sk->sk_write_space;
>   	sock->sk->sk_write_space = nvmet_tcp_write_space;
> +
> +	switch (sk->sk_state) {
> +	case TCP_FIN_WAIT1:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_CLOSE:
> +		/* FALLTHRU */
> +		sock->sk->sk_data_ready =  queue->data_ready;
> +		sock->sk->sk_state_change = queue->state_change;
> +		sock->sk->sk_write_space = queue->write_space;
> +		sk->sk_user_data = NULL;
> +		queue->state = NVMET_TCP_Q_DISCONNECTING;
> +		ret = -ENOTCONN;
> +		break;
> +	default:
> +		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +		ret = 0;
> +	}
> +
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port, @@ 
> -1506,8 +1524,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	if (ret)
>   		goto out_destroy_sq;
>   
> -	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> -
>   	return 0;
>   out_destroy_sq:
>   	mutex_lock(&nvmet_tcp_queue_mutex);
> 


What about this instead?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index c41902f7ce39..6388d18ca7c2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1494,16 +1494,28 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
                 ip_sock_set_tos(sock->sk, inet->rcv_tos);

         write_lock_bh(&sock->sk->sk_callback_lock);
-       sock->sk->sk_user_data = queue;
-       queue->data_ready = sock->sk->sk_data_ready;
-       sock->sk->sk_data_ready = nvmet_tcp_data_ready;
-       queue->state_change = sock->sk->sk_state_change;
-       sock->sk->sk_state_change = nvmet_tcp_state_change;
-       queue->write_space = sock->sk->sk_write_space;
-       sock->sk->sk_write_space = nvmet_tcp_write_space;
+       switch (sk->sk_state) {
+       case TCP_FIN_WAIT1:
+       case TCP_CLOSE_WAIT:
+       case TCP_CLOSE:
+               /*
+                * If the socket is already closing, don't even start
+                * consuming it
+                */
+               ret = -ENOTCONN;
+               break;
+       default:
+               sock->sk->sk_user_data = queue;
+               queue->data_ready = sock->sk->sk_data_ready;
+               sock->sk->sk_data_ready = nvmet_tcp_data_ready;
+               queue->state_change = sock->sk->sk_state_change;
+               sock->sk->sk_state_change = nvmet_tcp_state_change;
+               queue->write_space = sock->sk->sk_write_space;
+               sock->sk->sk_write_space = nvmet_tcp_write_space;
+       }
         write_unlock_bh(&sock->sk->sk_callback_lock);

-       return 0;
+       return ret;
  }
--
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
