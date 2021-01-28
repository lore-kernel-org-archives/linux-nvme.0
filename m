Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B3DC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:43:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8CE64DE9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8CE64DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7UzxYvxHGmVIyf6DDWX/Teg/m7f73HXVeS2uJMMVJwc=; b=qUIS0YjDx0MKJJyUKPoW6NvTSy
	TijmOcCrdxG2OgwCjojN/pfgF6jVpRqp9Dao1aycjEsdH60MoCthZp28oG6xt2jkyXfzOA+srmFFd
	x3bV+MgDhb5M4l1wYyppbsqRa6XapjeOH3jVnQKFiLQdrFsYKam/+RU2polmaitYfVVSnmwsiqfkb
	HybhZI3ZNcrmtwur2GrMXze81nAUJ0G8VPiA3aRbfMQOUSdwuG9HtKBkvejftLQuHgqJ4g5UWPY1u
	CM/3xt7W/uH3i6+EvTcx+R7L8pqxxFLT1cB1lt1wD2PU7NtT8sqZxcUr2+/zmKt6jsFR4Vo4vacTg
	XDkqdZYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Gwd-0001M5-Cf; Thu, 28 Jan 2021 23:43:23 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Gwa-0001La-2f
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 23:43:21 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SNhHGQ022371; Thu, 28 Jan 2021 18:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lsPzw3dXbXBzg8tdFik/m1NGXO+LwouI/i2jDtHtLiQ=;
 b=DvXc48uWTXeaml77Kn0YaFPcw6quCJhtS9egQjWe8po2RIJxJjc5a7SAUJ05B+3Vvlsi
 CObtoPUKoPLiIx0znsgRe+0s8SznDa9eI88U8dp+sd/22MbO+YqOXiMNY6xiYiqNuxqt
 wp52xj/VXrF3Fr0CHcCYS8bjJkbjYuZMSzT4jC6GFhzSSFaPKET/m/aODQvoUQ6n6nJa
 KYq52VCQ8IUDPRkQZu0LSOgUXZPUXWCAsuVEVFAq8eL4g3hQ+4DewBr4EDcur0No4tzw
 clu+/m5ClsK+R+TLcw7PzUeV06qiLhxhSeDLqC4A+KDH16vB6+/pwxkkGxKNIL7WIr+Q 9A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 368fuh2ue9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Jan 2021 18:43:17 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SNfKl1193252; Thu, 28 Jan 2021 18:43:17 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
 by mx0a-00154901.pphosted.com with ESMTP id 3691p9uvyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 18:43:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee/io9a5Px9TLHPAev++t6V0XuuEuEodYcABVH8iZHD0exqBGa/tDx0xCcc5jycC5EsMBeJIWnfDy9UWy0e86YsURIUCFiDeZ8uxO1lQPUV+5Qg3wXEaEXOTbtaAY6vlrBsKGVQeDdaZeuH90V2cltdNqaInmE0QOLeKeex6KPgBaH6dRVbcrLI9O639AF+gThhMr/8XgSke+7xxcnpgObEGd+dQQrvjUCl99v+XuZq3oyw1w4WuZaG2/tTtdKt4XKAnzri5ymBg/WheVcaV3us6ESRp7S1nEFSKcIwtYR32HOchmO4u/FVpMxFyCx7tkmPOEPQtymDirSIcmc8j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsPzw3dXbXBzg8tdFik/m1NGXO+LwouI/i2jDtHtLiQ=;
 b=KnS2wgXp/jeo+oy9RkXZx6ReiMcb0zPF8MwePHLIUJTbsbMI8CCgKpUXZY6r+bVWBMm4IjGb6UvSdvYmOWobm1uMAD3ROU321+4vtI/i34tze0vy7wyqmGcDwq0HfrQI0oKEex3cK/NQXHCHRX5sh6GXNEKYoI8jv8NwpJgfIGHLAubz1NsdoWxkW7i6jW5WYNy5XbZ8MLVuSeUbxHZzxhEo1lwbpd9Aq0zr/SbVQYQOY6WorReRUeYyK6gM6+BEN7JSR/LG3K8/V63ZhvSX3TPfYHlu0YHA0SSWi8+lzW5nVo4oZdrw0Ba+N4Jn1EAxIzO3McBEerk3QOcHcjuzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB2524.namprd19.prod.outlook.com (2603:10b6:5:183::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 23:43:14 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 23:43:14 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Topic: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Index: AQHW9Yot5sDcdvF1ckSEbnpOtZTZe6o9l6yAgAAQh7CAAAjDAIAAAIhA
Date: Thu, 28 Jan 2021 23:43:14 +0000
Message-ID: <DM6PR19MB401116F68376949D24B6803AEFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
 <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
In-Reply-To: <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-28T23:41:51.3240012Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=26a2235f-e226-4552-b528-29a8d6c6be94;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae40959-b04a-4ed2-34b5-08d8c3e67ac0
x-ms-traffictypediagnostic: DM6PR19MB2524:
x-microsoft-antispam-prvs: <DM6PR19MB25242DCC0F9C904CA1E65D3DEFBA9@DM6PR19MB2524.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TO4xgWPc2/3rgNEaKXOyQ13euIL4jr0ZRiNfAb6q1xsfnoY/XGtrYcESALughlK2Vl17CIgseNQeTQnJ6ergmgL748v1fSZiiOSKpnfdDfOWZFdMIOeBmpSwvkzULo23lENwYLOjslWItZ3wQ2klxLAiEukhOfd0fAWBMFp9ZMkZ68HPgfPw3ra/+HtEFg3i4MxgCSqNv1QfxxG+e1I+R3Rrcjp/OieiZigngs8E6WBR8wUpW4f9lFeqIB4Or+JFKmMuHIb9l4fTE2wlqMxkm5GTvawAgCc/MtzmQ7ZOV8pXvEBosggbEy31tYGdJypoUGxJn+BIthKvDhXU60du9Kd2g42gMg/U+bOjWaqJt7twfaL5/KPQFDOy4x1WotW4snpig3dIqWMPIbLyTIvRjCQhSOsTHMXsoH5SrZovng8Y0VM14sbyKaP/onFJ3fATvStU8gXAPHSoqVwCaygXE4wkDWsT3t0u6mS1t+MNnycspCHiRA6VWUh7KsjS5DbF03TPeC9+/6TNJuqrDxz2ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(52536014)(86362001)(53546011)(26005)(478600001)(316002)(6506007)(186003)(33656002)(9686003)(64756008)(55016002)(76116006)(8676002)(2906002)(110136005)(66946007)(5660300002)(83380400001)(66446008)(8936002)(66476007)(7696005)(786003)(71200400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MFU4WC9jV0ZWallaeUR2Rm1JMitRcFkrUWo2VzVBTFdZMkY1YTZFMHlRb2hC?=
 =?utf-8?B?d1RKM09VOHM2eDNuMS9IVU9QTXpCRVRLcFB3WGtVbE5IcEZBUUV1WXJlc2NU?=
 =?utf-8?B?RDVzcE1IV2dqUWxlTHgzd3U2VmkwRlpyNUJiR2ExWFhvcVlnb1VjR3JPSEpD?=
 =?utf-8?B?OTRBNzAwMFpOWkJJb2d3RUZXTXJwamJJTjVGYnVhOGthVVRUR1IvcDNnajhx?=
 =?utf-8?B?NWk0YlUrdnUraDJiRStmUWd4KzEvUjNtZEVEU2t5Rjh6R2duL2cvei9YNHdQ?=
 =?utf-8?B?dWFPN3l3QldxYzZmeUhGdUNNQklONzRwSkJhYmV0YnlVUjNEeUdVbDhkYU51?=
 =?utf-8?B?SXB6UTZwellwOUZPa3NWemhiWldoNmFxVDV5emh6bHJkcWRlcG1zLzRteHpj?=
 =?utf-8?B?QWlGQmhmaFYxcTJNT2pqemJiSUlWRUtOT2NBd2JOdGZISHEvM28rVFMySFJW?=
 =?utf-8?B?TFdkRkZBSmJCd2JYczd0QW8xa2N3aWsyMXZNR3l6VTJlRHZOZEQrVlgwenFi?=
 =?utf-8?B?QW1tLytlWFVPMGkrNlZxczlRV2NleWVSbmxLMWM4bm5zcWNQOUxrUlB5TlNJ?=
 =?utf-8?B?K3pkdXlwU2Vna0QxUEhrZG1IcjRwWVMwVDRSbWRuL2svMHNYeEhwdGRmUS82?=
 =?utf-8?B?Q1V5Slh3K0N3eTVBMGt5dlU2dzZEUVlzWjhVcktSbk1IdmI3c0tKYXRGNm9G?=
 =?utf-8?B?VG1DUzVJc2hWV2hZTURpK3hFWUtaUUl6dWYvV2JMam0vaHprNGFncndoQ3hk?=
 =?utf-8?B?SFZ6Y1lVMjVKaGd2WkM1N2RrdHRqcDQvWWdrUG9hT0Eya3J6MmFlbkVTbjY0?=
 =?utf-8?B?eC80RERKb290OFBWTUk4VTk5d3JVSzNPK0ZGQlBFU1RmMXVpd0YxaWpuY0c0?=
 =?utf-8?B?NUpZOXVSQWIvSDNMK1owREZtNHYwTURMK3hRSGFzN0llVHF4SXNTQU9kU3lL?=
 =?utf-8?B?RHplY1V5ZDUxUWM5V25odG84OExuS04zdlJEQVFNSVdweC8wclNocTFPblgz?=
 =?utf-8?B?U0lUQTJYZGtUREF0RnVBZWlXTmttTk5ZTm5aMzFBWGMva2dCQkxHWTBlM3RZ?=
 =?utf-8?B?M3prbkw3M2pSZ1E1ZEZwczZ6UXlEQ1MySlFFT24zQkwwUmlYRkYvK2VOZnov?=
 =?utf-8?B?Rkd4T2VSVGpFVVNqRHc2bWdjdnBSZ1hLaHY3ejFmVFhVSXltVmZCRCtHZkNs?=
 =?utf-8?B?OFVLc3Fja1lZNVhiVkFHTWVlN3BaL2xNalVVRFEzTEFqZEJTbVlRVGFhSThv?=
 =?utf-8?B?TSs1cy91MzhSMEl1SjREaGl1R1FGTGFrUmQ3MHFyaGpaUlhkZUJtdjhhS2Z2?=
 =?utf-8?B?UnRTSVhkcXQ0Zi90Vk4xTDdwYi9OMC9EeWJPZmlVRVoyZHFxeklycmt0c1E3?=
 =?utf-8?B?TUZnbjk2bGdRdzY5R3FyRHhoMlhjVjFublMrUVppb1Q3VU52c1dsV1Buekxx?=
 =?utf-8?Q?0Q7l76i7?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae40959-b04a-4ed2-34b5-08d8c3e67ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 23:43:14.0981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gc2sNWpZhiV08u+tdNYb4zZBuv82hRT9g/cMsOUmWMHZO8Cyho517lq54T9SnhAOUp9GRrZ+Riysotk7DUa21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2524
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-28_12:2021-01-28,
 2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280113
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_184320_309721_3CC63EBE 
X-CRM114-Status: GOOD (  22.86  )
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

Release work might get invoked if nvmet_tcp_set_queue_sock is completed successfully and set sk_user_data, but sk_state_change is triggered by network stack before queue_work_on is invoked. That case - there is a race between release_work and accept_work.

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, 29 January 2021 1:34
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows


[EXTERNAL EMAIL] 


> That will work if sk_state_change is called under sk_callback_lock.

It is.

> In addition, need to flush_work(&queue->port->accept_work) in nvmet_tcp_release_queue_work because accept_work is still using queue struct after unlocking sk_callback_lock.


But sk->sk_user_data was not set, so I don't see how the release work can invoke.

> What about this instead?
> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index c41902f7ce39..6388d18ca7c2 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1494,16 +1494,28 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>                   ip_sock_set_tos(sock->sk, inet->rcv_tos);
> 
>           write_lock_bh(&sock->sk->sk_callback_lock);
> -       sock->sk->sk_user_data = queue;
> -       queue->data_ready = sock->sk->sk_data_ready;
> -       sock->sk->sk_data_ready = nvmet_tcp_data_ready;
> -       queue->state_change = sock->sk->sk_state_change;
> -       sock->sk->sk_state_change = nvmet_tcp_state_change;
> -       queue->write_space = sock->sk->sk_write_space;
> -       sock->sk->sk_write_space = nvmet_tcp_write_space;
> +       switch (sk->sk_state) {
> +       case TCP_FIN_WAIT1:
> +       case TCP_CLOSE_WAIT:
> +       case TCP_CLOSE:
> +               /*
> +                * If the socket is already closing, don't even start
> +                * consuming it
> +                */
> +               ret = -ENOTCONN;
> +               break;
> +       default:
> +               sock->sk->sk_user_data = queue;
> +               queue->data_ready = sock->sk->sk_data_ready;
> +               sock->sk->sk_data_ready = nvmet_tcp_data_ready;
> +               queue->state_change = sock->sk->sk_state_change;
> +               sock->sk->sk_state_change = nvmet_tcp_state_change;
> +               queue->write_space = sock->sk->sk_write_space;
> +               sock->sk->sk_write_space = nvmet_tcp_write_space;
> +       }
>           write_unlock_bh(&sock->sk->sk_callback_lock);
> 
> -       return 0;
> +       return ret;
>    }
> --
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
