Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C534C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZKIIOUoM+y6kL3ywwX8TrVkYt3OpeVSrrdJEUG86/c=; b=2/fMsyVdvRfgPFXyFvwMYFCPQq
	j5UoAXLZrMzRu4Drf6201+KmHjpg8MumjS1Z08p4/hegfXzN8len5EscVVDe41OxpDyhb3K9k2WVv
	x8ywrnQ/fK3WJb9OhD7TctFXCMR4+9yi5FDUHen6RnBDqhOsrY1bG0KchQJi6PEmN0wFTdihpXjr7
	qqD1YBfWjBMAoyjfPMM7elgYfW3UEVVTlSL3n8QtKnDrneFB0lvHI0n2tVMfV3lYzlWEzu717+KZn
	9YQw4+66s47N45xKd/C4bbOqROYLNceVHyX5g6C0rZ/yXa3J5UJy+0juUUl01LYipKQD28sxJsrTv
	Eg+lsNxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbPjd-00FpX2-DN; Mon, 04 Apr 2022 16:39:21 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbPja-00FpWB-OJ
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 16:39:20 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234G6KiT006418; 
 Mon, 4 Apr 2022 16:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DZKIIOUoM+y6kL3ywwX8TrVkYt3OpeVSrrdJEUG86/c=;
 b=nCbccAPmCotDPB+kCG0Z40ZkGorEuGg29rfUbS0u39QqoVWTeNTv6x+F946uZS6kozhW
 jVntAdlWFWHohqB1ITdmk+Qlp+15LehpLf1KeHLZX4tYIW8Or/m/xc1aJSa8miWZ3Wj6
 TNxCnOOXTD+5gwIRKnAx+V+PEzQ/iT5HfQsnxhHR/Dr7Rik8csKSIxEzkghmIcgo9K0x
 bDWbr4TcjzXm+0suEE4BimMAl1oI214TROi/3coMgUeFklak0PeOF7FRJ7MnU6azfvH8
 0Cb/MyemTOzV/AV0uXLE+bqynlhyR00vBJSSdJVyhEffqZN4o/mtulIfCAbM6lTP3iAL 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bunv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Apr 2022 16:39:09 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 234GavBm027249; Mon, 4 Apr 2022 16:39:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3f6cx2p2rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Apr 2022 16:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX1tBOH6oSa2mlJ/f3HfKTqCsffD7dHawO+2akKA1JsU8HQA+0wdhgr1JQjEUAED9U5gjZjBksOQDhhBB/ERwByl6g8XorfwLXoy70UN4G7DhzqBehNojXkHkVVA0Gcl/lMREyQZCzBrgHOYFddtdJhEw6VNyUKLjYLtDFLJItW3mU45EiTd1I4HZV2w9FUz41VddZzKD63cOnAmL2JaJ2+Y/v7EBeOcRNzisavDsC1LjDyfGtzCc9T/ImToXCSsJWswp+o9yjcb0HlCSRbH5nHiBOSoaU5QID8f+fPxNAP5t13SNufUD/ctSoUZ4VurW5zw9ddfrHYip5aKqAlLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZKIIOUoM+y6kL3ywwX8TrVkYt3OpeVSrrdJEUG86/c=;
 b=Uea48D4JikH2LUujaB9J81chSSF02+dM/0XilhAokmOk2ldgu9B7A+pNZf1UxwUFRcmVbOxY9+TYAEi23bsyp5mnLcoVWTxLSOkRxaG6rtmAvDpC6Hv02DMyhh2CInSkYho+aS3b5MnAV44lxdbRfuDJtyi27kFC8hqLQZ3OGur+hgAmAnmjlhe5qKNgA77B0J+BKzfyqF8Tzm1Fgr4qbOzFSbef0/MhOGL/kPlsSqKT0GXkOvCJVaLXmsc2UHs2zeX3m+PDVBr71PCtIUC071oQmSjp2LJszWG3K2hHabDMmRAdn09+VqzU4g1tjQxPWTOUoRArpfigaJPHNWhZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZKIIOUoM+y6kL3ywwX8TrVkYt3OpeVSrrdJEUG86/c=;
 b=zbomvbnVNV5OCu5aNS570FjoYIq5i0nYtSR5PS0fAaz71fDNeU8GjXPa1G1/9srZP8NLkGByLboGXZPwKgg6LIKiUjKM45w1flfi89oFaDBkEdRZ840otfN13GjbFX+5w6ju++l0B7IntyOjrdjiUB5vDKak6Bsbhv7cirlRzRk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:39:07 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:39:06 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Topic: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Index: AQHYR2cuTGHViq1YXkqwVFy/Mk48Dqzf9jCA
Date: Mon, 4 Apr 2022 16:39:06 +0000
Message-ID: <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
In-Reply-To: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8035b223-742c-4297-b1ce-08da1659a30d
x-ms-traffictypediagnostic: BLAPR10MB4881:EE_
x-microsoft-antispam-prvs: <BLAPR10MB4881E72C062543E31E878A38F4E59@BLAPR10MB4881.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5PhFvPZjfAuuMhRXiBGgFIDYzRwqLz5jBnjkIIy+4rHs27K4Kftmd03BTM1cEnBlEct+PlGTGLwfNb9Vfc4mbm+GQbj+ZeKPWsSApuBIQtITKPB3pQroi0/HG+Op3AEoS9oe3fTwgHe1fa7e6l/IUmVsrSkE8uiig/DbDy76nQBvNSngS4YdcHhyWLvBcMZlypxp/oNSnw1i0LFhtoUAqlZmedYnBQ+ZQeFAxbaWQYEhcikboxu/QtI3bzCoVYKsUjpJBwyQxvzK3cQILrt/N8oss2GxaPvG4hJ4yvAKkrdMXM5+O1+TVWmPi0J4tYkQ7DvUaUPsDh+5kLkMzKR8KoZmGHiGmTRaNMk+wx0gHTrszGBsKbgBJMjXDnogoWqOP5+rUw8tkwxkKY5oHX2hN4P19FBsX9PG7FBTEjcSSeUosp6PuJUqe+DOHgz+0HLmOrqVcl6H8BPPw/gAcpiEKD8vgdFH2exm4vOjVDK1C5aRlO+hAqCX41HHZO3APVS2mJvjrM2c2B/01XszUIqMLP2sl2Up0XTeb2Nf7Z2RGPLVKIY9+v57DGQZNcBMC2xM0u8fqyAi93maXaPioPfxdHsYMm+nGJuuni6VNe8S1ZwlAWmupfdHPNGeuwTmLgsO4Yg0UChBzl9hbzX3Enyw8g6SdRAqWSA2gIe8ztmoqIQLgNXjS+lkELy51RkuG9kqtdAfe5YcoxOA3IUQfOqWXcXoomtuEDEOpSPL+ON8V5ElYUkO/wqlA/KGBG3n002
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(6486002)(44832011)(508600001)(8936002)(6916009)(71200400001)(83380400001)(186003)(36756003)(2616005)(53546011)(91956017)(316002)(54906003)(66946007)(38100700002)(38070700005)(122000001)(6512007)(86362001)(33656002)(6506007)(76116006)(2906002)(66476007)(66446008)(64756008)(66556008)(8676002)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHgzUmZSbWpXSHJiSkhqYnpOU2RwM1VseXJ1SUEzNytkcXpzQzdZeUpYUTgv?=
 =?utf-8?B?OXBENkpUTTBQZHZJakdIREFnV3BHK2MrTU1aRU5Vanl5WEhBNWRPMW80SmU1?=
 =?utf-8?B?WWRNcUFNeEMyak1JcTNRTDNXK0c2cjNDUmVMQWVSKzNiYlRyTGpwWlFDUWto?=
 =?utf-8?B?SjYvaHVwQ1AvVHg1dDlQU3p4UWtuRDJTWXBHU0g4MDJVdDNUL29UdHlweHhH?=
 =?utf-8?B?RlNGOVVHeXhYV2J3MlBYR0FjQjl6L1NhdUU3eVQzMnY1NlVGSTJZZFJ1emth?=
 =?utf-8?B?M2R2UW1jalFLMlZTMDBvaGNoZXEwaDZrWUhlbHhXWGYzK0l6QXpnZW0vblZy?=
 =?utf-8?B?NVZtOE5aR3pwYjhabmRtVHVGS3ZQWTlyQzhGbVZzWnB4a3lRNHVkR0V3L2d1?=
 =?utf-8?B?RUR4Z0F1aXRaOWk2LytSOXhKSzJTeVJqVTJIZzVDZlJMaGQ1ZDZMWDJIaTUy?=
 =?utf-8?B?VFFxcTRJN3VXVDZBaHl6cXhKUWE5ZDZuN1Y5ZWk3ZGdCcUpwRDY5VkE5Qyty?=
 =?utf-8?B?ejdyRk9VVVB4akIwcEhDVWlqd3J2c21KVHdBam5xVTNWdGhWM2xRbTk0MVFr?=
 =?utf-8?B?OUZyNG1DLzJoREZUZ2YyenZ2c3dIamNkQitIZHRKYTY3c2x3dXgzaXYwdGVl?=
 =?utf-8?B?R2NkVGFWQXcwTFB2QmcxazR2WFYrQXRjaUI3NnFBOWVhc1ZkRzJxM1RzTjFN?=
 =?utf-8?B?R3lDR0tiRVdEYmVlR2RKQktPMitMNjA0L2VIRUpIeDNQL2orVUNOb04wMzA0?=
 =?utf-8?B?ZHBnSkg3VXgvNUpnemh4c0tRZ1ZZYVozRFJPcXNISHFNcFFLMUhwMDRvalBE?=
 =?utf-8?B?T0xFUUtRSTEza2pPUVhaOUwvTG8xOHN4MTZVZU9uQUF1dFBPemZlQVJoZVNB?=
 =?utf-8?B?Ymsva2pFUlYvTG5keFJCVVMwc0kyTksvVTBkRGpBR0RTdUhKZnhoVjhNTmpm?=
 =?utf-8?B?ZGZkcEo1QU5LdnJMdVNPcWlmNkw3Mkcza0wxVjk2T3FyelhDcmVIeHdocm1S?=
 =?utf-8?B?N0FDcE8zNXNTUmJPWGVFbEg0a3hNNGhJaGtoR1dNRCtVVkxjMG5SeU4yOTJO?=
 =?utf-8?B?UUtqdDdzZEJnN3k1K0N0MXV3K2s2TlQyYXhRMU51cEh3eG00NWlmdC9Yd0NL?=
 =?utf-8?B?cTFqc1ByM1lsNzVVQ2svKzNIblFpb3J0ZXhKR0hIOUhEbXBaOFRhMTV4cUNX?=
 =?utf-8?B?MUpOSEprMHVSb3A0WWtoK0U2WGMwUHREWDJDSDFEdkVDOWtZQUZkckVOdUtu?=
 =?utf-8?B?eUtWSVlmVTBuVkthZ0c1VnFPWVM3R2lkMDMwNkIyVjR3VVRDZG1JNmZ4eEcr?=
 =?utf-8?B?a1VTZmFxeEg5OUZNN2t0YXpxd1VaeGQzSGtoaURYSC9FNjJvOGJVZnpKRjR4?=
 =?utf-8?B?Q1hWVjJ5cngyQkw1SlRYaWFZQ0llTDJqUjNnQUxESzAya0hBNm9VQWVWdW5P?=
 =?utf-8?B?VWlYQnJNSnJDcG1WUVhxTmpwWGJOT2ExTXJqTXhpV3BPcUxaNkszQkpWR3ds?=
 =?utf-8?B?alh3VlFnV1hxV1BEb2RtQ3BSWjdmQ1NqaDRqZEZiNk85RFlDZ3FGZUxFZENx?=
 =?utf-8?B?dTF3ZnRFUHJXNnBTdklxbmZYVkQ4NVVYdFR4VDZKRlF2SHlDRDFsQm1IcXBO?=
 =?utf-8?B?c1dYUUFGbDI3cVlXcnVBWG1FcWMrZlJUZytmek56SG9RbjJwZFM5VjB5Lzdw?=
 =?utf-8?B?UmtGeWRKdkxYQjhiOWxodTdaZlB6c0VDRlRCc3Rzczl0MW8vcW5ZMjM2a2R6?=
 =?utf-8?B?bTJuV0ZxbHdRc3ZNMU01SmlabDVmNjJKc0k0SjVTOTF4Ky9pdUxvODNZTEJL?=
 =?utf-8?B?Wlg1UUdhcWJ5SmhJbkoxYlB2bEZMYUVBTjFTUW04QmFmbU9RVVVWZ3kxZGI0?=
 =?utf-8?B?eUp3SEI1RUEyckJyVGJDZ1N3UVU3OWIzZ2E1aG5IMG1jRjJWRHJjY2ZmTmtX?=
 =?utf-8?B?VDhuM3FaVWtUOTEwQXR3dXNLNTN6dGZyVmx2MXhSbG1ObmRBL0EwV01mRUM4?=
 =?utf-8?B?bGEwU1VKc1kwcmExWmNDS3AwdGt6OGVtelZiQWNWZE9Qdm5PZlkrRzlUTG95?=
 =?utf-8?B?UHRqdEpmaEJtMi81VGM0dWNxc1FPTFRjMy9VZFFHd1VPb2R2MzFjV3lyYXVL?=
 =?utf-8?B?Z1JqemVBdEdlQ3k5bVNHbVJPV216bVhKWktTaE1zMzhHU0dPT3F1YUc3QTVJ?=
 =?utf-8?B?WXhlREJtQ2EyNk95SFRCQVJ4MWFhY3BwSmJsbUpVRWFCTkpnZDh2UlptRFVn?=
 =?utf-8?B?VEhPWS9DYXZPRTBhTFcyMU9zNG9rWmJ5MVg0OVhLUTRkVnBKM1hPOHJiTUFx?=
 =?utf-8?B?b2VLZmJJUFVPVjh5V1RxOUpnaXZaTWxxc1NJMzhkNkgxM0diN0ZONDJya2ph?=
 =?utf-8?Q?ZdS8IU2JRYc4VlgvxXqcHdTe1gCLO3xG5/x26vost5Fwi?=
x-ms-exchange-antispam-messagedata-1: E1x4nTqzZTMuQQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFC32F79F9095F4595E5A671EE1BDBF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8035b223-742c-4297-b1ce-08da1659a30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:39:06.8424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyINXA1iSMdFP8++8TS//PD2WioXVm/Tj7WVzqeZejvwp7KgaPZWGn3ASjoLWrCUPaMUAMjqhAptQQh3vkzSuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-04_06:2022-03-30,
 2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040094
X-Proofpoint-GUID: Faz1wVwOv-d406kSeqLRFMf-M-6szB93
X-Proofpoint-ORIG-GUID: Faz1wVwOv-d406kSeqLRFMf-M-6szB93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_093918_834855_2768CC52 
X-CRM114-Status: GOOD (  20.78  )
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

DQpbICAgOTcuMDgzMjE1XSBudm1lMDogQWRtaW4gQ21kKDB4NiksIEkvTyBFcnJvciAoc2N0IDB4
MCAvIHNjIDB4MikgTU9SRSBETlINCg0KQW4gZXJyb3IgZnJvbSB0aGUgZGV2aWNlIChzdGF0dXM9
Mi9JbnZhbGlkIEZpZWxkKSB3aGVuIGFuIElkZW50aWZ5ICgweDYpIGNvbW1hbmQgd2FzIGlzc3Vl
ZC4gUHJpb3IgdG8gdGhlIHBhdGNoLA0KdGhlIG52bWUgZHJpdmVyIGRpZG7igJl0IGRpc3BsYXkg
dGhlIGVycm9yLg0KDQpBbGFuDQoNCg0KPiBPbiBBcHIgMywgMjAyMiwgYXQgNzoyOCBBTSwgWWkg
WmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8NCj4gDQo+IEkg
Zm91bmQgdGhpcyBlcnJvciBsb2cgZHVyaW5nIGJsa3Rlc3RzWzFdIHdpdGggdGhlIGxhdGVzdA0K
PiBsaW51eC1ibG9jay9mb3ItbmV4dCwgc2VlbXMgaXQgd2FzIGludHJvZHVjZWQgYWZ0ZXIgY29t
bWl0WzJdLCBpcyB0aGF0DQo+IGV4cGVjdGVkPw0KPiANCj4gWzFdDQo+IFsgICA5Ni45MzE5MTFd
IHJ1biBibGt0ZXN0cyBudm1lLzAwNCBhdCAyMDIyLTA0LTAyIDIwOjUzOjE2DQo+IFsgICA5Ny4w
MjQ2OTNdIGxvb3A6IG1vZHVsZSBsb2FkZWQNCj4gWyAgIDk3LjAyOTMxOV0gbG9vcDA6IGRldGVj
dGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMjA5NzE1Mg0KPiBbICAgOTcuMDM5NjQxXSBu
dm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTENCj4g
WyAgIDk3LjA2ODg0N10gbnZtZXQ6IGNyZWF0aW5nIG52bSBjb250cm9sbGVyIDEgZm9yIHN1YnN5
c3RlbQ0KPiBibGt0ZXN0cy1zdWJzeXN0ZW0tMSBmb3IgTlFODQo+IG5xbi4yMDE0LTA4Lm9yZy5u
dm1leHByZXNzOnV1aWQ6NGM0YzQ1NDQtMDAzNS00YjEwLTgwNDQtYjljMDRmNDYzMzMzLg0KPiBb
ICAgOTcuMDgzMjE1XSBudm1lMDogQWRtaW4gQ21kKDB4NiksIEkvTyBFcnJvciAoc2N0IDB4MCAv
IHNjIDB4MikgTU9SRSBETlINCj4gWyAgIDk3LjA5MDEwOF0gbnZtZSBudm1lMDogY3JlYXRpbmcg
MzIgSS9PIHF1ZXVlcy4NCj4gWyAgIDk3LjA5ODI4M10gbnZtZSBudm1lMDogbmV3IGN0cmw6ICJi
bGt0ZXN0cy1zdWJzeXN0ZW0tMSINCj4gWyAgIDk4LjEzNjkwMF0gbnZtZSBudm1lMDogUmVtb3Zp
bmcgY3RybDogTlFOICJibGt0ZXN0cy1zdWJzeXN0ZW0tMSINCj4gDQo+IFsyXQ0KPiBjb21taXQg
YmQ4M2ZlNmYyY2QyMTMzYmVhYWM3YzQyM2ZkMzZjMzUxNTA0OGZjOA0KPiBBdXRob3I6IEFsYW4g
QWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+DQo+IERhdGU6ICAgVGh1IEZlYiAzIDAw
OjExOjUzIDIwMjIgLTA4MDANCj4gDQo+ICAgIG52bWU6IGFkZCB2ZXJib3NlIGVycm9yIGxvZ2dp
bmcNCj4gDQo+IC0tIA0KPiBCZXN0IFJlZ2FyZHMsDQo+ICBZaSBaaGFuZw0KPiANCg0K

