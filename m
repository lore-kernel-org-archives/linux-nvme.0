Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93663C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTYsKdFJyMTZvl82yVdjvF92CxFnXZMUoBt2iLDH37Y=; b=bNZY2qABpxg3FCaIxKBy8c3uhN
	DfJnsjJcTWpm6BfKUfLaLy6FMk7BWIfgGX6S1+mR5Rga5o/sd3VRNfRGWA44moDe5AjTq6NpCxWdp
	D6DEzikT+QRiUc2huNVu0WIM27jrrrZ0AoiqoqQ+Dgaiw4NrkbNMdhkSOpkEr+nBT6kYwGX0IQmQ0
	R5Gi9hng/fpuhF3a+jwwlWH7saCR9wmwmr3VVSdXXiWvIgr0Bpbk//4RyRLsF7Pc9W37AeqUiWLgU
	36/DyN+mrnIFecFOebve+3GlxW9U1mF84w5AfINC8VNfUybs8Hc0aj67o6mpdGFQ6+KcAMzc5gGDO
	P+pb6TMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30L6-00B2n1-Cq; Wed, 07 Dec 2022 19:44:20 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30L3-00B2l5-41
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 19:44:18 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7D1SAJ032173;
	Wed, 7 Dec 2022 11:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uTYsKdFJyMTZvl82yVdjvF92CxFnXZMUoBt2iLDH37Y=;
 b=D8LAVmQSyriRCByvepwISazPSLL3/MJ22wrmxI8OS0ZG6TxsiWaFJWDGkGaJ8swlP23Q
 pIXC1pzD4hI6nIjKtsaVHcuoTEpjs1McNEuF7teLoehJmLXnAKm1/+he3+8gn30z74NP
 eXWHxrPoRU8547Y3gl2pcXQNct9pQ+2BXu3CCnxh8z/dmRqXFEwrB/4tScaEaELvExgL
 1jXmmO0pn4Wf4jNAbY2cqDrteU3cxeyeGGXCuMBlvR0a9Is+Ib/4R/vOglq2mTl+qDvU
 jc+E7IK9GPD6Y9EltZag+Kb7QNO07rESPeMlD+cKlxUMajxTMPMLWxGX614qAL3Vsr+I zg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3m840uud6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Dec 2022 11:55:13 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GijKY014522;
	Wed, 7 Dec 2022 11:55:12 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3maxma064u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Dec 2022 11:55:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWKWmX9+FTNHkw/pLhHj05x8RLQ4e81RnMhUDDOhB/ev6rM0ppSFUso6ZwONFL1HteVC1nswi3ILLPdVjYBg3IbvNBwywvYt6t70LJGGHAAnagrNg/x9129yPUHW6uY/R7v6zcS1N8H12ZQrhUjvnNoN2UvnwaJb2UZBfX4LfQhsaihEKTQdeOo74sH9QOio+uNbsweTqXeqN/+G0JAWjmsjwXX650r7LJBRSusUJu4vdWizZ63sxyIBDgHQeoGA5J7QYrQbByqFOTZKM1jYsb7zrhV5rmCF5b0M1MjGcaRvVDCjMcW5Z1U55QYQus90Dw6S//o60sW+0i2gWHt+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTYsKdFJyMTZvl82yVdjvF92CxFnXZMUoBt2iLDH37Y=;
 b=MuhVRF1DVuen8mJ79kQsGainqZr7poHRq9s8CtHK9y6ro+g1GhJfLwh8HtIeETJFUTw6jwn6XPP2Ljemv42x0pyXH4Nq38D5lwNoAICnab/stCbmILF3tUCePS52SvczG/zfT62e7gGOr1bZBM7AqqF81KttyB5dGjb7Cjxdj5Ykh+YlCgGEvmdZv2HQZNKbm8U3kxuB4S9p60FaJfOStsV9sZpfTDBrlb/FsagTixrrKLKB+dSAahMPCA4aGxhYCT7YKxxHVKvxLuW3hOckZGjHJ2/KZ6lKtWkARLvXhLo9bwPYSsH+gN0pabPcag5JSYVShyCrtpQIJrfXxRZfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by CO6PR19MB5436.namprd19.prod.outlook.com (2603:10b6:303:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 16:55:09 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:55:09 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHZCircZassPCXK70uAR/3KOBzuUq5iR1uAgAAmnICAABt3AIAAG2Dg
Date: Wed, 7 Dec 2022 16:55:09 +0000
Message-ID:  <CO1PR19MB48856AF1A3631095EA029329EE1A9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1669889667-1034818-1-git-send-email-amit.engel@dell.com>
 <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
 <40ec518c-db1b-8fa2-af66-3b2f3dcc235d@grimberg.me>
 <CO1PR19MB4885380AC6E687A3FC8A858EEE1A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <769ace6a-4eac-bef5-12f2-8f1f45875c6d@grimberg.me>
In-Reply-To: <769ace6a-4eac-bef5-12f2-8f1f45875c6d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-07T16:54:59Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=d8c19856-3d98-46bf-a29c-99d8848c250a;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|CO6PR19MB5436:EE_
x-ms-office365-filtering-correlation-id: 6b5ccf2d-fa05-4181-2acd-08dad873ccef
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  TySzAaZVMJEyQpyEMBhKEssP0vCSY7peIOlRVGZhu5+lCyY0bXzvnvZ1p/8+tE5J1OKtdLz6qC5W/tbJRhczmlaIltyN9juQGglm4cwp6Z/+IinXWk4iIpwz42RXVdXUy2ZnAq46hC4cqj+oA9vzW3f3vlH2VMzwrqRY5g0Rbej7CWa/JdUPuxfCTdHzXZLKLZGkEL+fpeBs0N7LmqB0M6Dfoj6V1dQ3knYasjBA9V72Wbqv0fAoc9qR/HSHVCi8C+3vuf40U1vDEWWdCNOaKVr61xsG7kCWrfKkrao3iA9wbFrxh6AMD3R0Q8amfLv7xIrKrRmdXglOY7B4Adu8+jJiQn0eJu9kX0B8vWjbl1WJS4MMhVN/YDUMtJfLoprhxXwTiu0Yw35TomjQPHnzyhD2kY6/XDlpjxKT6oMnxBieJL/F2wIDV6Og8f+gCBgO+XIiK506rglcsy2RbY4bJjIjsTrPaIR82irl8DiFnewzHPcpn9m/lkbjroXS5mCdxUH/dKV2gtWEuSNiRkLiNvHM5rAkFlV7wLk6ab4GUikOM0WCy0hqm4xfjfSLrMuPEFSCuBNrZ0vZm1YXdEiRvhBcqo65ug0SFnnWXCzQMkE7WR7a9DVkhL4Nu1BJrpf3J5daWRy9tfvqx3uazadIHR3gVvk7B6nDu7B4IcAZMXZrmV+BA2nHSFQ3cPFV9/C54Vviv5ZykNpggwT4+EH5wQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(86362001)(41300700001)(8936002)(64756008)(66476007)(478600001)(107886003)(66556008)(66946007)(5660300002)(66446008)(8676002)(38100700002)(186003)(4326008)(76116006)(53546011)(6506007)(110136005)(9686003)(83380400001)(2906002)(26005)(52536014)(786003)(33656002)(316002)(82960400001)(71200400001)(38070700005)(7696005)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UytRMGtjQi9JZ2tVdXpKQWFEU1AzV3FsbXpPZFZUd3lxSmNXdEVuRmJ3aUE0?=
 =?utf-8?B?NjBXNHlHQ0lOaUEzTnlJYVI3T3R2blBkVUlrN3hjemJuYWVnZG1vY04xbFp5?=
 =?utf-8?B?bXQyWitlaEtYNXJkZWhSaHJNRjlWWWU4eWVLYis1TUhaUjdzbTNhcWV1dktF?=
 =?utf-8?B?RWdVbDM0ajIvNUJ0ZERnWlI0QzMrMndPR1FJVDRBRXhjSHY2Z2gwU1hRbWk0?=
 =?utf-8?B?L2FvNnVMWHRhQjRwLy8xOEtqcjl3bzgzYjB3MFFrMzYrZ0JuZjRRM0ZSQjdw?=
 =?utf-8?B?enhIckFUSGRtMU8rRnlCblVyVGoxZEJhcE81UTFzU0lOWm4ra3dYTWdQdExa?=
 =?utf-8?B?MUlId1dIT09jVldvTzhIWFpFbk1wZ1hqQzVXRGtpbkRLVmxBWktRZnF2K1cy?=
 =?utf-8?B?dFdjQnlMaHVnd01sODByZko3T1RZdVQ3WEhuNXFmMjRnVVEyZEFJM0FObmZE?=
 =?utf-8?B?UGRycmptZUFUbjNScDZWdENuWXVQa3ZLcnFOTExtOGZEQ3Q5MnZxeEpIOWRR?=
 =?utf-8?B?bTNLS1JPMTZLMHBhTHgwd3ZSeHBCdW9WYldYVnN5WnJ6V3EwTzF2SkZoQ3Bv?=
 =?utf-8?B?ZUFpUzVsY2h1bkU3aytLZ21ab3QzYWh6VGdublBVNkQyMldmRnF5Yit6TXkw?=
 =?utf-8?B?SHBXQUZ4RGZIcG93MzJhdFRYdjdnWGQ4NmptM0xxRGZEMGE2aFNKQ2xGemxL?=
 =?utf-8?B?R05aVS9wZWxibWgwdEFJRGVhT2IzVy8ySHBkTjgvd282UTZpNTQxQjZMRXJY?=
 =?utf-8?B?SDBTSS8xNUJlb2NuMUo5cEs5SWhGYlBGTVY2VDk5WVZRRnBjZmZBM1hBSUJW?=
 =?utf-8?B?Ri9QOGhYdk5HWFZ5OWs3ck5NYTlESVNtaUJuaGNhemcrL3pqVUxVYmF2SDZj?=
 =?utf-8?B?VjNrOFpCeVRsTkdSeDQ5cFkvVUdMRTNBUDFscjJGOVpiWTlURmVwNFUySStM?=
 =?utf-8?B?TmI0aUxJeWtDOEZRUmJrUWw0UzdBV0gxV3JsZTErUHVBdDVrbG9aUVQvUDhv?=
 =?utf-8?B?SjBBaUhmVlgrNnFvZlNWUXFqSDFHZFVJeURBbUFISDBiWDVvd2h4RENpRWpy?=
 =?utf-8?B?bVhNcFR3R0V1N2xRWUU0Y0taUlFzYVJucGUwSEhxWWE3cG9zai9hTXI3S2t1?=
 =?utf-8?B?a0JtbFdPQ2xtamRxRk1RUDFmQ244Z0RSb2ZIMHJseExjRyttWlgwS3E3Uy9h?=
 =?utf-8?B?WjlEaVF5RVN6aEVoSFVyYUVIR2hsUWVCNnhUY2JsWmxBWUd1alVLRlI4LzFP?=
 =?utf-8?B?RWc1a1JtR3lzV0FRTTliVFRBT2FDSS9YeVhjaXhoN2tqVUZ1WjMrNTVCMXQr?=
 =?utf-8?B?cHBmNVlqSzZOSkpENExhRXhMMXkzMEZScEhSMlhIMHRCWHgzaXJyUU9jWmVD?=
 =?utf-8?B?VEluZndsejhESy9MNkJlQTFCRUxPeitpbmhpRjBrZUkrVFZQYjE0TURUcUE4?=
 =?utf-8?B?S2NQbzhsbGMzeG1hMERFSk4rcFZsRWI4K2VIOWdXYUZqL096ZlNDMko0bGNr?=
 =?utf-8?B?aWdHUG12SWkyYm4zTXhFVnVyNmNmLzh1NVk5azFBM1JUM3k0N0V0ZHlVWndv?=
 =?utf-8?B?MDdsaTFaZ25FTzdCZVVpSHd1Q013MGIzbnNjc2FkZFJxeFk3SVFIak9MUDJy?=
 =?utf-8?B?aGxhZlR6TWdJS3ZsT1BRelhSNkpQKzFzdzBObDhUVDhJcnFrTU9GUFRNV2h2?=
 =?utf-8?B?RmRlS2R5ZzVxRTVaNGVvVm8vSTY0NlJaaGJQNm42a0RXb3RRekxGSkZEOVAz?=
 =?utf-8?B?UnMwRHRFdGxMK3U2bk8wYU9CRXVIbjNLMHpzbktSR3pSZS8xZVJsSVJVaDNL?=
 =?utf-8?B?b2I4Z1RkY0YwUUdHV3ZxQTVKUWdPdkQ0czJJY3JncHdkYnIrcmkzaDc3NmVN?=
 =?utf-8?B?UzJmRnR0MUl3TjJiaFh5T1ZkaDd0b3pGYXd0SGFTWTcwdUsxRkgvMFhkeEp1?=
 =?utf-8?B?WEtuZTN1YTE2dDB5NVJ6aEJaaGYxc3pnRkdnTEpvVDJhY0g3dlVQc0FXa1p4?=
 =?utf-8?B?dForbHR6YW1OTWpnNC9tNTBTZTdZRUNvZW1CaVo4dWo2WWFEbTBUekNRa3B4?=
 =?utf-8?B?cjg0QjBVZHVCUy9UKzZxUWJlUDN0K3k4MWNMb1pyKzc2YUtUdlJuQk5kMHJY?=
 =?utf-8?Q?8kygVl9TO2HoxzNP1brI++VIw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5ccf2d-fa05-4181-2acd-08dad873ccef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 16:55:09.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4EjN8YDjkMJ5YPE5eLf20m7ZTSynNbgyiBpynKdR4wP681B03lnwx484ywIhtL+Kvnqg+bd6ymRbqTow2DCSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070147
X-Proofpoint-ORIG-GUID: 7S2hPn6Rxi-fuY-eIteIyqg0RSQFenTk
X-Proofpoint-GUID: 7S2hPn6Rxi-fuY-eIteIyqg0RSQFenTk
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_114417_470571_374E893C 
X-CRM114-Status: GOOD (  23.15  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U3VyZSwgSSB3aWxsIGFkZCBpdCBhbmQgYXBwbHkgdGhlIHBhdGNoIGZvciB5b3VyIHJldmlldw0K
DQpUaGFua3MNCkFtaXQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNhZ2kg
R3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IA0KU2VudDogV2VkbmVzZGF5LCA3IERlY2VtYmVy
IDIwMjIgMTc6MTcNClRvOiBFbmdlbCwgQW1pdCA8QW1pdC5FbmdlbEBEZWxsLmNvbT47IGxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZS10Y3A6
IGFkZCBhZGRpdGlvbmFsIGluZm8gZm9yIG52bWVfdGNwX3RpbWVvdXQgbG9nDQoNCg0KW0VYVEVS
TkFMIEVNQUlMXSANCg0KDQo+IEhpIFNhZ2ksDQo+IA0KPiBEbyB5b3UgbWVhbiBzaG93X29wY29k
ZV9uYW1lKCkgbWFjcm8gd2hpY2ggaXMgZGVmaW5lZCBhcyBwYXJ0IG9mIFRSQUNFX0VWRU5UPw0K
PiANCj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwgSSBjYW4ndCB1c2Ugc2hvd19vcGNvZGVfbmFt
ZSgpIGRpcmVjdGx5IA0KPiBvdXRzaWRlIG9mIFRSQUNFX0VWRU5UDQo+IA0KPiBDYW4geW91IHBs
ZWFzZSBzaGFyZSBhbiBleGFtcGxlPw0KDQpTb3JyeSwgSSBtZWFudCBzb21ldGhpbmcgbGlrZSBu
dm1lX2dldF9vcGNvZGVfc3RyKCkuLi4NCg0KU29tZXRoaW5nIGxpa2UgKHVudGVzdGVkIGFuZCBu
ZWVkcyBhIHNwbGl0KToNCi0tDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29uc3Rh
bnRzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb25zdGFudHMuYyBpbmRleCBlOTU4ZDUwMTU1ODUu
LmVhY2YyODJmMDRkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvbnN0YW50cy5j
DQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb25zdGFudHMuYw0KQEAgLTU0LDYgKzU0LDE0IEBA
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbnZtZV9hZG1pbl9vcHNbXSA9IHsNCiAgICAgICAg
IFtudm1lX2FkbWluX2dldF9sYmFfc3RhdHVzXSA9ICJHZXQgTEJBIFN0YXR1cyIsDQogIH07DQoN
CitzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG52bWVfZmFicmljc19vcHNbXSA9IHsNCisgICAg
ICAgW252bWVfZmFicmljc190eXBlX3Byb3BlcnR5X3NldF0gPSAiUHJvcGVydHkgU2V0IiwNCisg
ICAgICAgW252bWVfZmFicmljc190eXBlX2Nvbm5lY3RdID0gIkNvbm5lY3QiLA0KKyAgICAgICBb
bnZtZV9mYWJyaWNzX3R5cGVfcHJvcGVydHlfZ2V0XSA9ICJQcm9wZXJ0eSBHZXQiLA0KKyAgICAg
ICBbbnZtZV9mYWJyaWNzX3R5cGVfYXV0aF9zZW5kXSA9ICJBdXRoZW50aWNhdGlvbiBTZW5kIiwN
CisgICAgICAgW252bWVfZmFicmljc190eXBlX2F1dGhfcmVjZWl2ZV0gPSAiQXV0aGVudGljYXRp
b24gUmVjZWl2ZSIsIH07DQorDQogIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbnZtZV9zdGF0
dXNlc1tdID0gew0KICAgICAgICAgW05WTUVfU0NfU1VDQ0VTU10gPSAiU3VjY2VzcyIsDQogICAg
ICAgICBbTlZNRV9TQ19JTlZBTElEX09QQ09ERV0gPSAiSW52YWxpZCBDb21tYW5kIE9wY29kZSIs
IEBAIC0xODUsMyArMTkzLDEyIEBAIGNvbnN0IHVuc2lnbmVkIGNoYXIgKm52bWVfZ2V0X2FkbWlu
X29wY29kZV9zdHIodTgNCm9wY29kZSkNCiAgICAgICAgICAgICAgICAgcmV0dXJuIG52bWVfYWRt
aW5fb3BzW29wY29kZV07DQogICAgICAgICByZXR1cm4gIlVua25vd24iOw0KICB9DQorRVhQT1JU
X1NZTUJPTF9HUEwobnZtZV9nZXRfYWRtaW5fb3Bjb2RlX3N0cik7DQorDQorY29uc3QgdW5zaWdu
ZWQgY2hhciAqbnZtZV9nZXRfZmFicmljc19vcGNvZGVfc3RyKHU4IG9wY29kZSkgew0KKyAgICAg
ICBpZiAob3Bjb2RlIDwgQVJSQVlfU0laRShudm1lX2FkbWluX29wcykgJiYgbnZtZV9mYWJyaWNz
X29wc1tvcGNvZGVdKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBudm1lX2ZhYnJpY3Nfb3BzW29w
Y29kZV07DQorICAgICAgIHJldHVybiAiVW5rbm93biI7DQorfQ0KK0VYUE9SVF9TWU1CT0xfR1BM
KG52bWVfZ2V0X2ZhYnJpY3Nfb3Bjb2RlX3N0cik7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGluZGV4IGUwMWZhOWY2OTZm
YS4uNTZmMmNlYzZlNWIxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQor
KysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCkBAIC0xMDg2LDE5ICsxMDg2LDMwIEBAIHN0
YXRpYyBpbmxpbmUgYm9vbCBudm1lX211bHRpX2NzcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0K
ICBjb25zdCB1bnNpZ25lZCBjaGFyICpudm1lX2dldF9lcnJvcl9zdGF0dXNfc3RyKHUxNiBzdGF0
dXMpOw0KICBjb25zdCB1bnNpZ25lZCBjaGFyICpudm1lX2dldF9vcGNvZGVfc3RyKHU4IG9wY29k
ZSk7DQogIGNvbnN0IHVuc2lnbmVkIGNoYXIgKm52bWVfZ2V0X2FkbWluX29wY29kZV9zdHIodTgg
b3Bjb2RlKTsNCitjb25zdCB1bnNpZ25lZCBjaGFyICpudm1lX2dldF9mYWJyaWNzX29wY29kZV9z
dHIodTggb3Bjb2RlKTsNCiAgI2Vsc2UgLyogQ09ORklHX05WTUVfVkVSQk9TRV9FUlJPUlMgKi8N
CiAgc3RhdGljIGlubGluZSBjb25zdCB1bnNpZ25lZCBjaGFyICpudm1lX2dldF9lcnJvcl9zdGF0
dXNfc3RyKHUxNiBzdGF0dXMpDQogIHsNCi0gICAgICAgcmV0dXJuICJJL08gRXJyb3IiOw0KKyAg
ICAgICByZXR1cm4gX19zdHJpbmdpZnkoc3RhdHVzKTsNCiAgfQ0KICBzdGF0aWMgaW5saW5lIGNv
bnN0IHVuc2lnbmVkIGNoYXIgKm52bWVfZ2V0X29wY29kZV9zdHIodTggb3Bjb2RlKQ0KICB7DQot
ICAgICAgIHJldHVybiAiSS9PIENtZCI7DQorICAgICAgIHJldHVybiBfX3N0cmluZ2lmeShvcGNv
ZGUpOw0KICB9DQogIHN0YXRpYyBpbmxpbmUgY29uc3QgdW5zaWduZWQgY2hhciAqbnZtZV9nZXRf
YWRtaW5fb3Bjb2RlX3N0cih1OCBvcGNvZGUpDQogIHsNCi0gICAgICAgcmV0dXJuICJBZG1pbiBD
bWQiOw0KKyAgICAgICByZXR1cm4gX19zdHJpbmdpZnkob3Bjb2RlKTsNCit9DQorc3RhdGljIGlu
bGluZSBjb25zdCB1bnNpZ25lZCBjaGFyICpudm1lX2dldF9mYWJyaWNzX29wY29kZV9zdHIodTgg
DQorb3Bjb2RlKSB7DQorICAgICAgIHJldHVybiBfX3N0cmluZ2lmeShvcGNvZGUpOw0KICB9DQog
ICNlbmRpZiAvKiBDT05GSUdfTlZNRV9WRVJCT1NFX0VSUk9SUyAqLw0KLQ0KK3N0YXRpYyBpbmxp
bmUgY29uc3QgdW5zaWduZWQgY2hhciAqbnZtZV9vcGNvZGVfc3RyKGludCBxaWQsIHU4IG9wY29k
ZSwNCnU4IGZjdHlwZSkNCit7DQorICAgICAgIGlmIChvcGNvZGUgPT0gbnZtZV9mYWJyaWNzX2Nv
bW1hbmQpDQorICAgICAgICAgICAgICAgcmV0dXJuIG52bWVfZ2V0X2ZhYnJpY3Nfb3Bjb2RlX3N0
cihmY3R5cGUpOw0KKyAgICAgICByZXR1cm4gcWlkID8gbnZtZV9nZXRfb3Bjb2RlX3N0cihvcGNv
ZGUpIDoNCisgICAgICAgICAgICAgICBudm1lX2dldF9hZG1pbl9vcGNvZGVfc3RyKG9wY29kZSk7
DQorfQ0KICAjZW5kaWYgLyogX05WTUVfSCAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgaW5kZXggNzk3ODlkYWRkZWFjLi43
NzQ1MGY1MmMxNDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCkBAIC0yMjc1LDEwICsyMjc1LDEzIEBAIHN0YXRpYyBl
bnVtIGJsa19laF90aW1lcl9yZXR1cm4gbnZtZV90Y3BfdGltZW91dChzdHJ1Y3QgcmVxdWVzdCAq
cnEpDQogICAgICAgICBzdHJ1Y3QgbnZtZV90Y3BfcmVxdWVzdCAqcmVxID0gYmxrX21xX3JxX3Rv
X3BkdShycSk7DQogICAgICAgICBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gJnJlcS0+cXVldWUt
PmN0cmwtPmN0cmw7DQogICAgICAgICBzdHJ1Y3QgbnZtZV90Y3BfY21kX3BkdSAqcGR1ID0gcmVx
LT5wZHU7DQorICAgICAgIHU4IG9wY29kZSA9IHBkdS0+Y21kLmNvbW1vbi5vcGNvZGUsIGZjdHlw
ZSA9DQpwZHUtPmNtZC5mYWJyaWNzLmZjdHlwZTsNCisgICAgICAgaW50IHFpZCA9IG52bWVfdGNw
X3F1ZXVlX2lkKHJlcS0+cXVldWUpOw0KDQogICAgICAgICBkZXZfd2FybihjdHJsLT5kZXZpY2Us
DQotICAgICAgICAgICAgICAgInF1ZXVlICVkOiB0aW1lb3V0IHJlcXVlc3QgJSN4IHR5cGUgJWRc
biIsDQotICAgICAgICAgICAgICAgbnZtZV90Y3BfcXVldWVfaWQocmVxLT5xdWV1ZSksIHJxLT50
YWcsIHBkdS0+aGRyLnR5cGUpOw0KKyAgICAgICAgICAgICAgICJxdWV1ZSAlZDogdGltZW91dCBj
aWQgJSN4IHR5cGUgJWQgb3AgJXNcbiIsDQorICAgICAgICAgICAgICAgcWlkLCBudm1lX2NpZChy
cSksIHBkdS0+aGRyLnR5cGUsDQorICAgICAgICAgICAgICAgbnZtZV9vcGNvZGVfc3RyKHFpZCwg
b3Bjb2RlLCBmY3R5cGUpKTsNCg0KICAgICAgICAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RS
TF9MSVZFKSB7DQogICAgICAgICAgICAgICAgIC8qDQotLQ0K

