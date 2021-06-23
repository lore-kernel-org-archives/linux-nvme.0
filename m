Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF2CC48BC2
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 17:20:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC29D60FEA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 17:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC29D60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0XAaLerDWbp/z3P26Ij7wQcV95p+yIXJsf3UnvUNhC4=; b=FQPYiO0qwKj04Y
	BtidGxlQ180FVjmYpVyrSLbA101ko1ym7cw/7qpkwXv0AxXcStKBTymmIxrswZqYhOBkTN/XGp7Pa
	jail5g9B0DX8jNZ+r7o7LUdPGQATvTugXQTbt8V1O983/r4KR2koinUIgfYo+0P6i5+Aonn9iD9Uc
	Ych8//RHYlkEB5nj9wh14S1SAsFaQRmWPwdq0csh0W3dFIwSCSwtKvwaH6fY35fxEwYqkQXky4AjD
	yelwPiFvY51HbnQF61inn7q27IATjPI59Icugzq3cDiSU99gJI/BXfPO2q7oCbc2zRXZtrErPCEfz
	Wih4zkrq8Wm83t0/EEnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw6XM-00BNDu-T4; Wed, 23 Jun 2021 17:19:40 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw6XK-00BNCz-7z
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 17:19:39 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15NH7drV017062; Wed, 23 Jun 2021 13:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=USvvx6GKmeWxXqZyQO7un22atowFuvehVZm4VXtwwdE=;
 b=TqY84rNRKeD6KCMfMf//LIdvQ1JoOkibcNyFq3Ce2UQKn2lJeeX+D5IcDN9Kcso0mTLG
 4rWzzGAGBR73eK8XQ4NW8QOS2viQrbBUkw6JF8p7PXbfBd0LB6Jvc+hmldvI1qpXPH5v
 8MLtdNeVSi/5hOpnMl4J6RNAhwdm6uqhRB2xta0G8M2CmTZl6NsbvPzzbvNOdLlm1kUp
 zEzGunXfF+olIeBiwrXqvgm4pkTHbHtE8AuzA9N4owIrNCYmHt5JN5K2Eb7AST+cIuwm
 xRdUzrbA/iuAMQecesqe2SqXheP3FmBEqz7l6fECG8pVoTGpsUsI6ZY3b1R61Q+jy1K0 jQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 39c5nnh751-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jun 2021 13:19:25 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15NHAVeb007833; Wed, 23 Jun 2021 13:19:25 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
 by mx0b-00154901.pphosted.com with ESMTP id 39btm65hec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jun 2021 13:19:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOCx2qHH3VJlkpBrQJ75TmA6JBUirmKjSiLDuz/OJz164ex9rQjhwAk4tOrB5iuypbmBbP1d8riGFUk+YknaZ1/rmQQ9CeFLeKMloLNgAaU2ecXuJDu4261A7qIok6dgbsq7fJ06ZC+Ypb9/6Umsm4ADg0+CeXG6KKqVwIhtyoywSxKlWb2AcUBI4oROSxWGB1nRm8lmBByiEDodMEldCymKaQAynVznqfTcxfoDGbqC9YLK3U7i23/bN3xSzu79EpEL4d4l1XCRn4B5EvHCi0ndzGUWexIFwdQ/4L3aU0iIekfdx1SWxWB4/+vJM0hThoNKUo2lVgHdOFMgoGBrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USvvx6GKmeWxXqZyQO7un22atowFuvehVZm4VXtwwdE=;
 b=F3EMLb0tcCXHP02uK2qB0G8uggsnuEj5XB6fGL1BejsMrz/srnHrptjjEtXHmJdOxlnbyXfL0VIBALor5onAXmF97WLZEqT8Hr068lGCxn4Kxw8JCArPoHJguG/xKTtda/Qz0t4ZF3VO/+NSQaOLkhofhgFsArBelba2wLULkEDSjvo3CJiTr9ud2XxMAb0nl6NoRaBLuBj5pXw+4cQQYHqC9sxtvGpEKbixUscKDkZWJtCX/Uhw99Z85HLe28dCpkKKvkW59fUERJvFYqBBePttwQUoKLn05oXosBfNtM+/SuPPa+F5cQLNXrYqn7zx0Jtm9/iwEtThQd+mfOraCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB4020.namprd19.prod.outlook.com (2603:10b6:a03:219::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 17:19:22 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::5c7b:35bb:9dd9:b3c9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::5c7b:35bb:9dd9:b3c9%9]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 17:19:22 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "aelior@marvell.com" <aelior@marvell.com>,
 Omkar Kulkarni <okulkarni@marvell.com>, Shai Malin <smalin@marvell.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>
Subject: RE: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name
 for OPT_HOST_IFACE
Thread-Topic: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name
 for OPT_HOST_IFACE
Thread-Index: AQHXZEd8sLyGx+nXtUObs2sadQ5n66sZxxIAgABcj4CAA5GVgIAEKM1g
Date: Wed, 23 Jun 2021 17:19:22 +0000
Message-ID: <SJ0PR19MB45442B71E8DAE398970BC1C6F2089@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20210618133956.10637-1-pkushwaha@marvell.com>
 <20210618134244.GA16005@lst.de>
 <78d5833d-2038-811c-f6a4-2f14a3996fc5@grimberg.me>
 <CAJ2QiJLWh3_gWf8Bx8c201hGzVGcqfEhT-J_OLD=2740w1+Qsw@mail.gmail.com>
In-Reply-To: <CAJ2QiJLWh3_gWf8Bx8c201hGzVGcqfEhT-J_OLD=2740w1+Qsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-23T17:19:19.7378274Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=961b98c8-e4b1-496d-b5ec-25e277b66982;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6de69035-5414-4f29-8c42-08d9366b0b3f
x-ms-traffictypediagnostic: BY5PR19MB4020:
x-microsoft-antispam-prvs: <BY5PR19MB402024E5724FDF6E7BF04F6DF2089@BY5PR19MB4020.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BABTZ76ty6GSYqBxnvg3ibUJT3rjdFJrGbMUNzZ2erJCrPPAGLQsh85hcSXUh3afev252XENzdiARTtR5BfPgFj3+yrIXfMbV+dtksT4BSciyvwcIsVs0y202OpoW2yuYZM9nxQ9Ua/wVRfh0y6D0n5TH/+7S6khzNvOoCr7Z4mwXGjXRAh3RCkPHjmIT/APmE72fc/qY1sGOsrdbeMsbfUKPOyNJF6E6lp37Wdx02MVn4Bk4Mms87YcMiUeecLz4e6pR3zpvKPbKRUAdXftmpseDwQDcaIXqeORVV7bVmmCEixWl2SlKy06k6EKm6FdXawnZ2Kcd6sB2XLmW3NHYv+51wAy0pczLHboo785E2ejpG3cG++TO88LIwy5u/ZNRTs72yTJZfmXuqOE6G5uwTd7caLoQWyRYqzmF9+gHe8RJXtkWII/aAGtBtZ7O3MASAFRJ/ufRmQODp3U09ft96zIeO3hYf023PZiuQ26TkHj6tOXJrrpcEX4Y7STjwC4L7hmmsDsUtLYE9YStNLf6gjHfmwS1vWtR0G71SLi2DOG/Zu3uE8gR3wbcBFF2uLObCSE6OeQVmoXXVGezmR6sHKdbqSRvwkot7T4RSaA660=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(71200400001)(7416002)(9686003)(478600001)(6506007)(54906003)(83380400001)(66446008)(64756008)(53546011)(110136005)(316002)(66556008)(55016002)(8676002)(786003)(33656002)(76116006)(66946007)(26005)(8936002)(2906002)(186003)(5660300002)(38100700002)(122000001)(86362001)(7696005)(52536014)(4326008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2RQQnAxMi9HTDdJUkRPK3VqQkhnRlo2dGcveS9scWZMU3gzME5MYXhPd1la?=
 =?utf-8?B?dFY1VkFadmpLTFdZQ0duL0czanlKc3piblIwRlBrVC9EOFZoaURnSnF3T0Jn?=
 =?utf-8?B?N0l2TDlxUWpJOG9TSVRDWWg3QXJwM09CRnh3QzhMVGNSNFZqU3ZJQ1dkL2lk?=
 =?utf-8?B?VEhPYlJtWi9uUE9TT3RlbWhpZEcyV1cvUEVNMktiSmcwYWdWQXNkNCt0b29S?=
 =?utf-8?B?SGJOa2VWM29VMFdQaEhVUTRFY1p4QWFxbjZ3YnRIcW5Ia1JnQWhrNzgrVjdL?=
 =?utf-8?B?YVBpKzlpTXdscGZlU3RxQ0ZBSi9CNzFnMmJickQzOHJEMERWVEdqa2xsZitr?=
 =?utf-8?B?MXRqbW9QdEgyRnYwQmJWSjRQV00vd3VFU3dwMkpQVU1KVmpubGg5d0ZDWHp2?=
 =?utf-8?B?bDYwaWxuVGcxUkZmRm5WWnRSdlR6UXNvcThWTVJVT0lQTjJCMHpZSWEvakxI?=
 =?utf-8?B?bDFQMjA5Y3YyelltaWJRZDJTelFhK0ZmSkJIdU0yTHdvWjVZS3A5VGZtT3U2?=
 =?utf-8?B?NkpENHpTM1VJQ1Y3SVVSUi9CWjV6S2ZzNjhTNi9vbGp4WWlRNTNHMFpGM05u?=
 =?utf-8?B?a2NFa0pIcGdpaml5VWx3T1lsVURFaFFMajR1WkEwK1lGU2s0b3JKdStqdk01?=
 =?utf-8?B?ZVFZV2VOUkN5dFN5YmM2aHd1UmNDWEU1UW5wWU9nMHc3ZWRidU5Cd3Q1WnE5?=
 =?utf-8?B?UCtLdGhIYXpUVmVmR0w2VTlrVU5zYXdOeVFsbTkrdUJndzNOcTRGTDBzRDNG?=
 =?utf-8?B?OGhsdHJOeXNJTzgzakhEc2VSVGkvTXJlcnNaaGk2Um5qbVg5N2NqT1lIZmhy?=
 =?utf-8?B?dmpBQjVyTUZ3MFhuMzZubkdvV3c0WUE3djNwR1lnakNVZWhmQU1qQXM5UGYz?=
 =?utf-8?B?QWVaeE96YUxLY2ljQ1VsS3RvN2t2WGhmRzl3OWlWWFBmOVozeGlTNHd5OWVw?=
 =?utf-8?B?dVhoKzJUWjJvTWpuZnM5WGR6Q1FxaW1SQXZzYVJjZjFKaG1MaDNBTEswSWpv?=
 =?utf-8?B?aS9JQVFRM1VHNkE3UWJkYmdFZlVJUkdqUE96d1h6dWIzZzlCWEZJeGJDVlI5?=
 =?utf-8?B?WERLTDlHQzlBeWNoWlBmcnpLS2pORTdYdHFES1ZSOHF4VFpOMWQ5Zm5Ba1ZK?=
 =?utf-8?B?SzZLbTd3dDQ5SVFZYUpvOUNBK0VNNkZ1TzMxZ2xsTU40U1I1QjY5MElSdWxj?=
 =?utf-8?B?aFNNOTBqVHg0TENROUxtZUdIamUyTzQ1K29QQnhRMkdHS0FmRHJmYW1nbEcr?=
 =?utf-8?B?MW45QU1kNWxrVllkSE0vbXRBdTAzbmFQcDBxUlk3eG1Haitwc0FEb0oweExE?=
 =?utf-8?B?VUJ2QitIRWg5VGlOMWUrQ0JWd0x2UllmQ09MMUNlNkk4ME1rY2FjbmZvT21w?=
 =?utf-8?B?b0JMcUpZRzVGN0RNRk82OFNKam9Qb2xDRERDSjNuMjYzQWVZZk4rbWRvNXRV?=
 =?utf-8?B?eUJBbjVwWCtJQzc1TGcrcTMrMXhjMUhneGpZTzhZZW4xczFubkU3SndXUG84?=
 =?utf-8?B?bzM3ZHY3T1V1ZmIxczJRMGdQZk00TFFuV2tISmZqUG0vNEZXdUljQms3a2JD?=
 =?utf-8?B?QUZZYTdNZlUvNkhPMWRnYzhtWkpyUlEySXJNQzdDbVB4MmY1c3RRWkRaZGxr?=
 =?utf-8?B?cFBpK0lsMVRmOWZBaU42OW12ejExaTYvRGI3QlBOcGEyT09icGp6ckg5aGdC?=
 =?utf-8?B?MmFLSzdLMWxnNGgyZXFvR1dJMHYwZU9ySUYxajNtejY5amRrNnBST1MrNW8v?=
 =?utf-8?Q?kAJv9QN+GtJYafuwx8=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de69035-5414-4f29-8c42-08d9366b0b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 17:19:22.6525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fs00/uSRvX88qFE5yU4hzxtspfED87sNF6GwoQoh0Ogs/OHes3TUFDwvS3/az+WeqY/gWG8G38xA+E9CMtjvipf7ZDy0odeijVhbtz8ZXl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4020
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-23_12:2021-06-23,
 2021-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 mlxlogscore=988 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106230100
X-Proofpoint-ORIG-GUID: u6LWxer_u011lWOqIdaeI-enxXPkAys8
X-Proofpoint-GUID: u6LWxer_u011lWOqIdaeI-enxXPkAys8
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106230100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_101938_396984_FF80DBC6 
X-CRM114-Status: GOOD (  35.89  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiBPbiBTYXQsIEp1biAxOSwgMjAyMSBhdCAxMjo0NCBBTSBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPj4gZGV2X2dldF9ieV9uYW1lKCkgZmlu
ZHMgbmV0d29yayBkZXZpY2UgYnkgbmFtZSBidXQgaXQgYWxzbw0KPiA+ID4+IGluY3JlYXNlcyBy
ZWZlcmVuY2UgY291bnQuDQo+ID4gPj4gSW5jcmVhc2luZyB0aGUgcmVmIGNvdW50LA0KPiA+ID4+
IElmIG52bWUtdGNwIHF1ZXVlIGlzIHByZXNlbnQgYW5kIHRoZSBuZXR3b3JrIGRldmljZSBkcml2
ZXIgaXMNCj4gPiA+PiByZW1vdmVkIGJlZm9yZSBudm1lX3RjcCwgd2Ugd2lsbCBmYWNlIHRoZSBm
b2xsb3dpbmcgY29udGludW91cyBsb2c6DQo+ID4gPj4gICAgImtlcm5lbDp1bnJlZ2lzdGVyX25l
dGRldmljZTogd2FpdGluZyBmb3IgPGV0aD4gdG8gYmVjb21lDQo+ID4gPj4gICAgZnJlZS4gVXNh
Z2UgY291bnQgPSAyIg0KPiA+ID4+IEFuZCBybW1vZCBmdXJ0aGVyIGhhbHRzLiBTaW1pbGFyIGNh
c2UgYXJpc2VzIGR1cmluZyByZWJvb3Qvc2h1dGRvd24NCj4gPiA+PiB3aXRoIG52bWUtdGNwIHF1
ZXVlIHByZXNlbnQgYW5kIGJvdGggbmV2ZXIgY29tcGxldGVzLg0KPiA+ID4+DQo+ID4gPj4gQXMg
YSBmaXggd2Ugd2lsbCB1c2UgX19kZXZfZ2V0X2J5X25hbWUoKSB3aGljaCBmaW5kIG5ldHdvcmsg
ZGV2aWNlDQo+ID4gPj4gYnkgbmFtZSB3aXRob3V0IGluY3JlYXNpbmcgYW55IHJlZmVyZW5jZSBj
b3VudGVyLg0KPiA+ID4NCj4gPiA+IEFuZCB3aGVuIHlvdSByZW1vdmUgaXQgd2l0aG91dCB0aGUg
cmVmY291bnQgd2UnbGwgbm93IGhhdmUgYSBzdGFsZQ0KPiA+ID4ga2VybmVsIHBvaW50ZXI/DQo+
ID4NCj4gPiBUaGUgbmV0ZGV2IGlzIG5vdCBhY3R1YWxseSBuZWVkZWQsIGl0cyB0byBtYWtlIHN1
cmUgdGhhdCBpdCBleGlzdCBhcw0KPiA+IHJlZmVyZW5jZSBpbiB0aGUgaG9zdF9pZmFjZSBhZmFp
Y3QgKHRoZSBuZXRkZXYgaXMgbmV2ZXIgcmVmZXJlbmNlZA0KPiA+IGFmdGVyd2FyZHMpLCBhbmQg
SSdtIHByZXR0eSBzdXJlIHRoZXJlIHdhcyBhIG1hdGNoaW5nIHB1dCBzb21ld2hlcmUgaW4NCj4g
PiB0aGUgZm9ybWVyIHZlcnNpb25zIG9mIHRoaXMgcGF0Y2guDQo+IA0KPiBQYXRjaCAzZWRlOGY3
MmE5YTIgKOKAnG52bWUtdGNwOiBhbGxvdyBzZWxlY3RpbmcgdGhlIG5ldHdvcmsgaW50ZXJmYWNl
IGZvcg0KPiBjb25uZWN0aW9ucyIpIGV4cG9zZWQgdG8gdGhpcyBwcm9ibGVtIGluIHRoZSBmb2xs
b3dpbmcgY2FzZXM6DQo+IEEpICBjcmVhdGUgbnZtZS10Y3AgcXVldWUsIGRpc2Nvbm5lY3QgcXVl
dWUgYW5kIHJlbW92ZSBuZXR3b3JrIGRyaXZlcg0KPiBCKSAgY3JlYXRlIG52bWUtdGNwIHF1ZXVl
IGFuZCByZW1vdmUgbmV0d29yayBkcml2ZXINCj4gDQo+IOKAnEHigJ0gY2FuIGJlIHNvbHZlZCBi
eSBwdXR0aW5nIGRldl9wdXQoKSBiZWZvcmUga2ZyZWUoY3RybCk6DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGluZGV4DQo+
IGM3YmQzNzEwM2NmNC4uOTM2MzliNWI3OTVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiBAQCAtMjE1NSw2
ICsyMTU1LDggQEAgc3RhdGljIHZvaWQgbnZtZV90Y3BfZnJlZV9jdHJsKHN0cnVjdCBudm1lX2N0
cmwNCj4gKm5jdHJsKQ0KPiAgICAgICAgIG52bWZfZnJlZV9vcHRpb25zKG5jdHJsLT5vcHRzKTsN
Cj4gZnJlZV9jdHJsOg0KPiAgICAgICAgIGtmcmVlKGN0cmwtPnF1ZXVlcyk7DQo+ICsgICAgICAg
aWYgKGN0cmwtPm5kZXYpDQo+ICsgICAgICAgICAgICAgICBkZXZfcHV0KGN0cmwtPm5kZXYpOw0K
PiAgICAgICAgIGtmcmVlKGN0cmwpOw0KPiB9DQo+IA0KPiBAQCAtMjU4Niw2ICsyNTg4LDggQEAg
c3RhdGljIHN0cnVjdCBudm1lX2N0cmwgKm52bWVfdGNwX2NyZWF0ZV9jdHJsKHN0cnVjdA0KPiBk
ZXZpY2UgKmRldiwNCj4gb3V0X2tmcmVlX3F1ZXVlczoNCj4gICAgICAgICBrZnJlZShjdHJsLT5x
dWV1ZXMpOw0KPiBvdXRfZnJlZV9jdHJsOg0KPiArICAgICAgIGlmIChjdHJsLT5uZGV2KQ0KPiAr
ICAgICAgICAgICAgICAgZGV2X3B1dChjdHJsLT5uZGV2KTsNCj4gICAgICAgICBrZnJlZShjdHJs
KTsNCj4gICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KPiB9DQo+IA0KPiBCdXQgZXZlbiB1
c2luZyBkZXZfcHV0KCkgd2lsbCBub3Qgc29sdmUg4oCcQuKAnSBpbiBjYXNlIG9mIHRoZSByZW1v
dmFsIG9mIHRoZQ0KPiBuZXR3b3JrIGRyaXZlciBiZWZvcmUgbnZtZS10Y3AuDQo+IA0KPiBUaGlz
IHdhcyBvdXIgaW5pdGlhbCBtb3RpdmF0aW9uIGZvciB1c2luZyAgX19kZXZfZ2V0X2J5X25hbWUo
KS4NCj4gSXQgd2lsbCBzb2x2ZSBib3RoIOKAnEHigJ0gYW5kIOKAnELigJ0gYW5kIGl0IHdpbGwg
YmVoYXZlIHRoZSBzYW1lIHdpdGggb3Igd2l0aG91dCB0aGUNCj4gdXNhZ2Ugb2YgdGhlIE9QVF9I
T1NUX0lGQUNFIG9wdGlvbi4NCj4gaS5lLiBJZiB3ZSByZW1vdmUgdGhlIG5ldHdvcmsgZHJpdmVy
IHdoaWxlIGNvbnRyb2xsZXJzIGFyZSBjb25uZWN0ZWQgaXQgd2lsbCBlbmQNCj4gd2l0aCBudm1l
IHRpbWVvdXRzLg0KPiANCj4gLS1waw0KDQpTYWdpIGlzIHJpZ2h0LiBUaGUgZnVuY3Rpb24gZGV2
X2dldF9ieV9uYW1lKCkgd2FzIHVzZWQgdG8gdmVyaWZ5IHRoYXQgdGhlIGludGVyZmFjZSBuYW1l
IGV4aXN0cy4gV2UgZG9uJ3QgbmVlZCB0byBpbmNyZWFzZSB0aGUgcmVmIGNvdW50IGhlcmUgYW5k
IHVzaW5nIF9fZGV2X2dldF9ieV9uYW1lKCkgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLg0KTWFy
dGluDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
