Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A872C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:42:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB99423A5B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB99423A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iIUzRlhoLlAsfmRMN+B548tdS2u4AC8ZRFVYcEjXju8=; b=CSVL+oaGYTJZOjIh7iD0mr+Jyy
	FDixlUvQzxWgm5WYSfHBu3VYRsf2GsOn4rBV14HX73cTkgznQ2uc/w+YhNlWfr/ekLMXtxvmwMi7e
	Aflnu0BDCOlHRYx490Ayqwaqg2L7quQjdUEEMBVO2jyeew3xNV4iSS5jeMjZI/olwI/2fCqi9RGjS
	tROCwkn64IUEOazF8jY2pwvvffqwhmSJmJ/oNQPrGEUYU2rgLkK8yCENdJSB1/+Kf1Bcbc2ujxm4q
	N/5Kjtyil4cjXb+HEvVn81KyTiKsxxJ5DkFB/oBs8SHz929FdbOedd/wkluWDzODhRZAHzdR5+GwR
	VUsRXcDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0ANa-0007mM-IF; Thu, 14 Jan 2021 21:42:06 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0ANX-0007lu-4Y
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:42:04 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10ELQtN8011722; Thu, 14 Jan 2021 16:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=u3jVDKIlj0H6ofYEE4KfaGS6Vaich18A77D90ozYu1k=;
 b=FrlmOgYs/esYVAKYIOF5Ou698ygf3OtkQ/LJTu4jxxH5gnZyYKxDK7J5jDGdTidvqP8y
 pTDsnOxI6jz9OomEyYdJHIAf2/gOOpEbTrx6fu7xAVtRScNJvljrpk46B+yCFu4dU0Cy
 GzPK1plG3DSD+Dt/CA+7PbiOSeuCLq/sFx8K5hp5BzORYef8lXyRiTqBlMqQlSNJGNaB
 ST7HhDmv6bmfRFP3zU8tWxYoa5iY8gzc/8ENpDApERdd9x45wtzUYlKZTacGmDeLpbwA
 8OQeE+uQPM3SLyJbVc76iGg55+rQ8ZFwzv5VGvJgO1DCX9GDuso9ISb5kkFAEnn2pURp tw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 361fyas0md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 16:42:00 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10ELdsQW097514; Thu, 14 Jan 2021 16:42:00 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by mx0b-00154901.pphosted.com with ESMTP id 362wq7gc4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jan 2021 16:42:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVNPz+t5l3/U8y7B/FD4FjnWuK40Gn0/TLcwZvi10K9Jq4atMhfTP16udfYXiIZE59411xtn/JG+xRrQylMQaVRMNjzle+yLATsAITD5b05sNNmsoJvCdEcJLoXYe9p9Rzy7iT01BF3Lw4jRQegnmgB+k1NywI+VcY+hTmMDDyH377bh5JoLIYAz2WMA3nG2MbggV1vdryhDWghEh9XeObUX5+ExIH/cTSTRrZDSK2WeF3OZ9QK+CV6yND0Ad9D40xZC3A3p8X7ab9oMaoCmcl83vDpqgRYmzOJLzTbRaPelgObIQd3rugklgnJf67iyix+dN94l7+QoZxCxTTeVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3jVDKIlj0H6ofYEE4KfaGS6Vaich18A77D90ozYu1k=;
 b=g5mmfSTlJ32Okb4UJjObc8QtwxGxzHWpDN3ncpkh43o30OkMg7n8vkhAcv0qLQMBhAU85mbLhOepZHqhWxW1URu+mHTx6vQ/nU/iQ8ZstOBIyKRVOG07dIXfl3LO35+IK6AWq+Lt1Ts4Ch/LA+p62cBkYdBUyQbRISlWnAz+Wckdp/IvqkVnPDyCHTgPnoqYa8hHO/RJWsxh5b3/s4Q+MKcJwpfOwHwxSFmPqKxNG1sqREgXatQ+s3RakzB3kQHqEGUj5br8jxFgljjrITYTmyPW9mdV4cURHF/zYfHHw28IevG71Zt5YKub4/sRXeicg7Zy0HFX8W+ec64N1NouBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3jVDKIlj0H6ofYEE4KfaGS6Vaich18A77D90ozYu1k=;
 b=Xg0/deCwXV0LUIHR4mBG7eCFV78XYdWratOjNljkiRdocaReCtucxiOWEMaWWeXDHPg5lnaz/+vmnMPgCWVgwngGrmO6KLRrHWkfK3HZVIqwZW5n5oX0vG4eLLIi67DYkv6ayV04Q4R6x0+q8MOvkY1cljLWaIVqCoyYfmqBjx4=
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Thu, 14 Jan
 2021 21:41:58 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 21:41:58 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KomKNIAgADakqCAAJ7gAIAABJXg
Date: Thu, 14 Jan 2021 21:41:58 +0000
Message-ID: <DM6PR19MB4011A4116FAB37BEC28BBC91EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
 <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
 <f5b8dbc2-7960-894e-47ea-b18665536e70@grimberg.me>
In-Reply-To: <f5b8dbc2-7960-894e-47ea-b18665536e70@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-14T21:41:55.6360217Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6539ce82-18a4-4e65-86d7-a24972c1bec1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: accecc01-44ab-4d70-dafe-08d8b8d53883
x-ms-traffictypediagnostic: DM5PR1901MB2037:
x-microsoft-antispam-prvs: <DM5PR1901MB2037F9D9D460A2B62F4A7A5CEFA80@DM5PR1901MB2037.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkfvheXqlR7F6TlHxG8pppB3d2bnUK1RId3nrrrqmJhkdr2W29XeZNqcaW+Rv2IE6rW3WrlQWaCaHeGUcnDcyq4yOGMEPO8IcD7s0K3nNwQZwXsf19tujdB83sX3CbKWw2tDHg+zbXYerelTN9kIbYkYAmX2c5ZOCXWKMPVNTgBWqu7osiUrz3UjrE4fb8aXy5miTSheF8nRinL9QfjvTJ79Sr7q9Hh2B89sLwr+BMwmaNwEUittTzil/YUfltuXD7QgtBqT7MEZuh6MbGAaiHmsF0CGlkj+sH8plY48LEZUsH+G+0U228leK4SOJ8FMyko0RvEPxJexupHT67dBSrk0pOk43iZpfo9FN5EuDZ3eQiq6+OFSdvnO56TwtkFyESjciLelZcnC08qK7sOLYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(5660300002)(64756008)(83380400001)(26005)(66446008)(71200400001)(52536014)(7696005)(8676002)(66476007)(76116006)(66556008)(55016002)(6506007)(66946007)(316002)(53546011)(9686003)(8936002)(186003)(110136005)(786003)(86362001)(33656002)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?a2Jpd2tPOHJhME1NUHFuZDZQOEVaa2NLbXg0dEEyanBtaVcrV0lrVHlWdDFa?=
 =?utf-8?B?NEIzcE5VWWRZV2NzQnhKZFpFTFpOSHpRdnRTNDk2UVZEMGt3OGJSWVYxSmo3?=
 =?utf-8?B?bmthM0NkVi9QYy8xVUw1ay82a2U2MFcwOUU4TEwxcXhLdGNBd3ZzNGV0NW04?=
 =?utf-8?B?KzVJOHdkejBLanpoaGVuOCtXMnIya0JoU2tJNHNmZkRscmRXZXBrcGNBRkd0?=
 =?utf-8?B?YzR1WlZyMXFnZVcrMmRCby9SbkNFdFhlQnFud2pUdWxYMHhrdnpVajJQSVRj?=
 =?utf-8?B?WGFiVHNyWDZFR3A4c2xqS3g5VFFsK1lLaUp3bVpuNUsrLzQ5dXJiS0xuZ3h6?=
 =?utf-8?B?ZVBldXNPWm12UFBtRkorOWs1TFcwZ0dJK2thamNzU2dVNkxMNjQ2bUxoeTV1?=
 =?utf-8?B?di94VEdYaFRaZlk3M0FGekcvK1I4ckgvNVY2TGJNZjJuZ3NwNGpHR0J6UEY0?=
 =?utf-8?B?a3dmMm9NbmR1WFRMN2laNVZYRU1vWlRHdEpCU01VRmNScWRjdzJrR2lwWWVw?=
 =?utf-8?B?dG9jb3NTNGlvUjNiaVhHTWhOZklHODk4YWJRSlh1MkdNejRCREl1RXl3M1RR?=
 =?utf-8?B?RWNrUDBPRGUwTXZNNzRzNGdKOURvOVFobUcrcngzSUxjMHVmSUlSQkk3VWo3?=
 =?utf-8?B?azZ6VDlZc29zbVZ3Q0wwb2NPSUpKYUVXa3B5WU01Y0wwRDcxb0JjeWpTdTRQ?=
 =?utf-8?B?WUg0ZnJVdDZpeEo2eFIvUEdDem5LOFRzNzg3N1p4QkNRNm5Oc1AwZVVZVi9Y?=
 =?utf-8?B?U3VjNWhVWFdGTStUQ1p2NXdTemFGSmJ4YkRpc1ZlMlptTVZMUTN4QUVCU0Ru?=
 =?utf-8?B?cElROG5HdG1tajJzd1p2QVFLL3RLS1dFRmJmTkI2cGxIajhkakxTVVNrT3RT?=
 =?utf-8?B?aGhJZVdGSDR6RVkveDJmRDBSTXZxQUhJOUhoWWw3b3gyM3FTVHlPOEZJbVZU?=
 =?utf-8?B?N1RiamxLbjZFem9iZXd3aGlwTSsvRUdPUk5OTEl1dGMxWHQyZ0RqQlB6RUFT?=
 =?utf-8?B?N3p4V2JMdEVFenZRRWtncGtOcVNZVXhPTkVHYWxFYkxIdXRZUXVEbWpFRUtL?=
 =?utf-8?B?b2VmZmRiMDFXblRuQVVZajZPUE1KTDBZc04wdFpHR3c3aFordWdOVG1VTGlX?=
 =?utf-8?B?VTBsSU4vMkZQYlkza2dKK3FjU3l5eGlEc0FUWDNnS2M3TTBYbzJ6SDFteTd3?=
 =?utf-8?B?WWF5VXM2TUJJWEMvcnpPY3VZTFZWSU9KNk40R1pyQTYwQ3ZGUnhBc3BwdkJK?=
 =?utf-8?B?NWVHMVZHYjFuaUQ0ZUp1WWZHTTlQZnN1ZDJ0MGVOaDh3MXJZcjhzTUt2dGR5?=
 =?utf-8?Q?8Ja5RHRRYcZ1I=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accecc01-44ab-4d70-dafe-08d8b8d53883
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 21:41:58.8197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URu7nL3SyoCZb7fy/uZURlz+IiESaK6K5mCAtdh+wDMWVcrsnGu2kznYbjCQ3bDqqXc19pAHegG8BYCxj2rDQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2037
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_08:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140124
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_164203_325049_E2A0ED86 
X-CRM114-Status: GOOD (  20.59  )
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

> This was a silly typo, did you check if it addressed your issue when you applied the needed change?

Yes. We applied the needed change before testing your patch, but still had kernel panic on recv flow when we had unread inline data on the socket.

> There are stuff there that I think we need to use for sorting out other issues where your bug report is the trigger for this.

I agree, changes looks good. 

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Thursday, 14 January 2021 23:18
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 


> Thank you Sagi,
> 
> I will submit a new patch with a comment as requested.

Thanks.

> The patch you sent did not solve that issue, I submitted some comments on the relevant thread.

This was a silly typo, did you check if it addressed your issue when you applied the needed change?

There are stuff there that I think we need to use for sorting out other issues where your bug report is the trigger for this.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
