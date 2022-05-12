Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE4CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3UzkYGwxgqAdx86jsdwX3zbmKY/xxXYddJtYRnNLBCo=; b=E06sOViHi8slNxGYdUGwcsEW8A
	fTOpjlxYs58YPOOjO4n0Ny6/sFMXb6tNVCZu0moxkTrxzyzh+iZDwBnaaUOmGv+bjAYoJZsOUc4i+
	zvnMeVMFP5OjQU1adP9l7aXfMc+gMI/mrQkEDUXNGlyyL7qSDzDgtGn3bMvScIp9t2ECl4pZ4wolD
	7/X/+moVeEZeIlTf6T+UY2FKtuLJtsg2aEX//9jMEHqq/LlG1qFxXkd6laD15zVYCNPVBga4jnOsS
	84vEhJWdlvjLKp2i8IpWk9svzCH9CahvbAjVHr0IDAv7PX4AvqKyGwCcJUOlf5mkGZ6uhZt5U9JuI
	h2InnBDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npE0o-00DAjH-Ej; Thu, 12 May 2022 18:58:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npE0l-00DAgU-0l
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 18:58:08 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIa0nD013766;
 Thu, 12 May 2022 18:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3UzkYGwxgqAdx86jsdwX3zbmKY/xxXYddJtYRnNLBCo=;
 b=LHZC+pq+rkCcphtjU2O0tJgcngeJZbUww82txynvd8ho1Q/Ck25waaIZkeZWCKBANZV3
 zdS3AeP9XxRGtDEdesns1LstuHhqzEllqO7tDTGiDYKJZ8pATndq6Ya6+l7h7s9sqe3O
 sVy4kL/f7FrMP0//wV0nl046nwXHHim/5mqfW8fToPSxgwQxB+5ZxQh+fX1WdW+KJlpt
 +NZtbQMHR3fZrpqZyLABZhpy70ehwwSZGaevcpc900HhSKQtxOsOiuzlBzjp9r5lYgsj
 ukLusUBDwTdpdt7gGeoS8coAyWami8BT5CbSesCG8x5vV01nQ15uUEpweUCX0GxLAo/o lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9w5kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 May 2022 18:57:57 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24CItH6w002769; Thu, 12 May 2022 18:57:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fyg6gaqy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 May 2022 18:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8y3rgcxGaraoWAksygk9DkbzkWR35m0BeZ+3IEoskLida4lW1uipaoexz3PchdGX4B8L3q2GLvFddwBjxK/DlTb2xsA6F1BauIGtqBpeZlmeDNYNO0Lp9qVtL4y3Z/awVXqbc8JL0REQ/5GwL5965mGzK/g07Xfz4KMGwN2Vin3RagNnGnk7k2wmGm4pxLtXr6/AkvbkYC3pS2GTODCznPyc6mEC9BzjqWmR8BozF9BCHM1eMM5pCnFjfeDwp32kSZWxP7qUrK8DyZASqmqjjFjBE9+bxtqZHZXHftxIIWpwFrL9SHWFJGVRvi1mWWcB4/PiPkh/H/pA0hRHoBxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UzkYGwxgqAdx86jsdwX3zbmKY/xxXYddJtYRnNLBCo=;
 b=cnrM5uRyouIHT740vqslgfFvjfO9lHEln7J+gH58aRwPOwGVXc4IOeWVFpT0l/idc4jGa6nqlqXP6bVsuA06rGqW+d9c5RmNhZOxTKV8cgOCa/yasNLJ/x7RR7ZK0e+wh+/Ev14atVVHY9veszxPanKEV4vQPBDW9CBkVeAIYfBdxzJ36+C1XTDYnWjUlvFNwRBk0MXA+dtKoWw9oNFgUCKRIHsECXjusSWvSiiyTMq5bNhX/glP0DL/HTIr83yudmBgkxCTRJFOanGYREJiachSIMR8MxQKLxZodmlWDhgBS6jLLZhWm/6CWk9NF67YwVWzl8l3F2Y60wLB4hDS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UzkYGwxgqAdx86jsdwX3zbmKY/xxXYddJtYRnNLBCo=;
 b=sICOXIWv2+a8GeFdXbFcqSatdKZ24MWzjej49HK+u2dru/vJxsk02BiPi1v31Y++HZfgSvu0f00wf+BsfXF2LYrCo6z+WmQO8mh535R7Kcoe/G2X/ZbzMFAANLHmXrlv3cqCFqQpHlohPnzxCPnSFnVyABeifZqYeYLpt2u5fKo=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SN6PR10MB2544.namprd10.prod.outlook.com (2603:10b6:805:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 18:57:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 18:57:53 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYXBXeVEXZAuvDIk+YOFpdGvsQFq0WbaWAgAU+FwCAAAB1AA==
Date: Thu, 12 May 2022 18:57:53 +0000
Message-ID: <8C5E4A85-9A5D-4F2E-AAE2-4BA16CE69DDF@oracle.com>
References: <20220429220946.22099-1-alan.adamson@oracle.com>
 <20220509105242.hv52nmc7yqd4chnz@shindev>
 <4a655f3e-a5dc-6aac-c1f2-a9620d05ae4e@nvidia.com>
In-Reply-To: <4a655f3e-a5dc-6aac-c1f2-a9620d05ae4e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fabe4cc5-7aca-4ec2-c9d8-08da344951ef
x-ms-traffictypediagnostic: SN6PR10MB2544:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2544CE1C87CF51368BE6D0BBF4CB9@SN6PR10MB2544.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sluHzUT5oBT5J00kHdJQsksGKObiJIy1bptrg5Bfh04QKqwaSQ0+69nUV65O7nHipL/QSXO0bo2rupokdRXZGXUDbuvTjFvIij5H896+QEHM9WWNcFbQ7scURaaZ5SVFYPDqtWgeA3gR9vkTd6YkQH7GC1GSQAjbZhVcrCpw0WI+93l1TFOXBZjGhe7AQjQ5srgFQ/9UWqbsJoNTIt/E+QPb9xTF+nOYn8LU3OXtzV/fSy+o1E1SRTjxndy4rVA7TxYwLVwiTU5/Eh0y2Qn9nDkRMjobu4GIOI1Mh+KS0fpI5xIXMJvyJxNO2tYFxRFCa+rO51cqimsBD0+zpOjyPRyEbzhbfl4YyVZFhWm5gPCauHE6H3F/KN6rptAlh2vq0lLUSRAy56TaI9/4qMe6JdpTxOkOiBCLLbLkNzvpwHUD7aBuKWpLxm0ZixsdI6Pxdpet7GMk8s0WebF9fVreR1XZiiU47ze3wQc5khbo7nlI6dU3+z1yPn9NjCFKp72wF9hiE4AVlzShMWZrwS1crF3xAC+MOuadEtaSRhAEBXgG3u1pr9il3O+AutOSKCtlH0TREwMJ7xNHWY0Y0fe6fETX5J7uucg8QJq0owjTam3DRWLbnvVs5aDum+r7ixVw9XTWQOvlBbamveyjqOegZjKPMYoG2ozBZm1DJxLXC8oiIFHv4gT9/AOfeflchqb2jjQ9nNHl8LXX7PMsRc9zXmEOfxT1ANWmDE2rchwDuMy5fbwZIRVlGFnSf7JUdiUW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38100700002)(38070700005)(2906002)(54906003)(6916009)(44832011)(316002)(8936002)(4744005)(83380400001)(5660300002)(76116006)(91956017)(4326008)(122000001)(8676002)(66476007)(66946007)(66556008)(66446008)(64756008)(53546011)(6506007)(508600001)(71200400001)(26005)(6486002)(6512007)(186003)(2616005)(33656002)(36756003)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JptEIEdl8s8LuZKo0UPv8QqEYtPQuwzt6uCnAkNlJhTWSFJHG8LpU22SZPUP?=
 =?us-ascii?Q?lfZ7rH8SS7nO++JoKj2hddbMWFNs35MRXAot0VTx90xL3MWE9kIE8clLSMCe?=
 =?us-ascii?Q?HlLNSydR0zUQjRM47lvFNyBCx5WqgyxT9vntdOlsJmnv+KgGG5X841lXTvGE?=
 =?us-ascii?Q?r6qdjVSjV+9XxRNf9HEwFlCiX98O5JF0iWt2FA6w4pjsukwUn3pxEyoNAZ+U?=
 =?us-ascii?Q?5J+6MPQc7F8C7u4gMku0cMV6xpZK6wKFXU7Fj5IoIbxMUwt4gWxHD1tu70uC?=
 =?us-ascii?Q?5mftc3mhfo80tSQNjgKSC6QKYdzqibFHcW5/XJWKZuUH47gWlbO6bIgpuN2p?=
 =?us-ascii?Q?Mk042otn9VpKy7CCn2SeMujyoZm62mhi0ZH2b7JqLbaklP8o/FnrrQwPhSJc?=
 =?us-ascii?Q?u2sbcgfNMgm50vpF6vD1KFENKPIwwR1pHq3Eg5oV0tcGRcJqsCq1oXD1MBi6?=
 =?us-ascii?Q?rV0s5Y2+RTI7BF4VU+ZtZ26sTIHuPg1ByXIrNhyDSVS5l2h1CpRhbEf1xMpb?=
 =?us-ascii?Q?IM4NrxsBtLn+hOLtktx7pHgBs3hSBoTvpRzeuAZv5G8S1dk9u3+NOgmxJdqe?=
 =?us-ascii?Q?TwqA5sovU2COejfvKVc6kF8HZpEBBO0Jj9ejQxoH16qd0SxEDpKJeYeo6rnf?=
 =?us-ascii?Q?KnlwKhsYR+r748b6W1Yn2xZHGY9pM+owfJb58LX+mkNgcvsdG7oRDvjmR3Qh?=
 =?us-ascii?Q?cK2n8zF9T1+N9D5Nd9itX3bxg3BYfpFlAgpdtysI+nRdApUF8N44ilumDk51?=
 =?us-ascii?Q?B6Y7Q98d55jCEoVH2NcjICJjFHzYUPEt6nk8k2WARpN00vL2qx811zToec/q?=
 =?us-ascii?Q?XcK+0uX64tsM1Q+qk3mYS1abN1ZURdYEsEI0dFpyjrhZs3AcQb2vofJMEYo6?=
 =?us-ascii?Q?zNuL393OfLd1XPQaC3kSOZs4mzD6/q0Kjh92/uls85JyNFIQ4LfyWyCAtucd?=
 =?us-ascii?Q?huRpvMzcukFJ83uApo62qSzHAcM/GV2RAGJQ2rKu7jzebSfGZi/1Z5GKg061?=
 =?us-ascii?Q?Ahgjl6G5olEDPbSnjUH+PSbKncb82bTIKS9u/A/PWgqZjRwil+QFtLlJGc6H?=
 =?us-ascii?Q?IcE5K56oyzV8CUrGKAgFnxLhZxJ96TLeZV97j0Vp/+Va83OiAVTPKDB4bkWK?=
 =?us-ascii?Q?xsb0ZYIwVu5XkRpv/j+ywFh0SKKJld2upMXX3hSJMPF8+LqEFmoA864dFe6r?=
 =?us-ascii?Q?zusuXr203S1pSw5FqbozSkEig6eSokl4BfIBpUdplWE9yxk9/a6T7xmEnJKI?=
 =?us-ascii?Q?EsYwNDOC1Y3Q+fjauRZsVtnzAnjGZw/8qEaAuYxiEet+hyD3v2yXc3Kih2nZ?=
 =?us-ascii?Q?huF+8MlqzO7G5jpzHLGiWdsJUGb7ZAHDX8VEwGro5EPISzYoAE3AQzWpKm4h?=
 =?us-ascii?Q?rkRUrl7hTrlm8oVatxDct3OrRDwKbkU6x9tms14Rnu+fUUZvoh53HcBP/68r?=
 =?us-ascii?Q?GBEST71r15fKEw8Jx4Z/Dz8d5yA5rN3DhdgG1xC+3FT0h8rZfg/RdXtSpFFj?=
 =?us-ascii?Q?b9mTn9cQBKu2Sku2U4+9zSnQpOXe6vWphXtm66zYkXS1bnIi13ggdK+8n00p?=
 =?us-ascii?Q?A32TevHZvzM6SX/Uaa07tTmIAmd54iSPqE7Q+9Z8L3eURv6eya2eNnW4roL3?=
 =?us-ascii?Q?0jGcu5tmaJQD1HJB60j4susMY3iH4lALdnG/CpYwr2Jh4B2ROto+R3qtY5nk?=
 =?us-ascii?Q?z20rmimqFbO+rJABNIQYd9Dol3omFEljali+J2qG0SjhnnvWF22y6fpwDxab?=
 =?us-ascii?Q?3w/BAjub9ANXEM4+kUpCvRyQmcQXaMI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99AB4BEEC3EFC14C89DE9A0A828280AD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabe4cc5-7aca-4ec2-c9d8-08da344951ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 18:57:53.7647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cS9DpTN6UUrmOfIzb9XZ5hhgkI2oyLtPqIHfZoqCtf997C4LXufhcU0rt51UZklPmkW7cYANhQodYK5676DrCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2544
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-12_12:2022-05-12,
 2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Proofpoint-GUID: 0M7kq4IiysLIc4javKS0TovBbGgi2hVn
X-Proofpoint-ORIG-GUID: 0M7kq4IiysLIc4javKS0TovBbGgi2hVn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_115807_296057_663F58F9 
X-CRM114-Status: GOOD (  19.08  )
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



> On May 12, 2022, at 11:56 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> =
wrote:
>=20
> Alan,
>=20
> On 5/9/22 03:52, Shinichiro Kawasaki wrote:
>> Hello Alan,
>>=20
>> I ran the test case this patch adds and confirmed it works as expected. =
Good.
>> I found some points to improve in the patch. Please find my comments in =
line.
>>=20
>> On Apr 29, 2022 / 15:09, Alan Adamson wrote:
>>> Test nvme error logging by injecting errors. Kernel must have FAULT_INJ=
ECTION
>>> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests ca=
n be
>>> run with or without NVME_VERBOSE_ERRORS configured.
>>>=20
>>> These test verify the functionality delivered by the follow commit:
>>>         nvme: add verbose error logging
>>=20
>> The commit was already up-streamed. It will be helpful to add git hash o=
f the
>> commit.
>>=20
>>>=20
>=20
>=20
> can you please send out V2 with Shinichiro's comments ?
I did on Wednesday.  Getting ready to send out a v3.

Alan

>=20
> -ck
>=20


