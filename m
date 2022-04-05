Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67FAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmbLZh8KVgzcvmyq8itPmJ4tCYbVM9Rj082j5AFlmG0=; b=l5Z2kg4GO/fS1t8gwKoWyBsl8J
	siasHPJrvjmdGGLlFpK8pGDsUCLD7t+maepwfD8A/BE87+IRTLR3SxdN5mFCoSXAuCOygz+1Zq3Rd
	e93zkEsi+Le4jl1XffnRc+GqAZsFutV8Sq3WWhNvCuYTsUmU6t35KWoIqV2iab1D/Lo7BQ45tN02a
	KB5CxpIaCQqtQ8iLZSOpdplhl5GFOAk9nqsqBsqX9fnkyK5TNrGezqiLREsoj1Pzylz6tKXCRCgDN
	hfmCSDVPWVZNPnzojguwTtgFNVhvErRaZ8kJOkD2aAkLbc9f8cYgfyz2ZI6DyWDOBp12rreCtSxVN
	tOoo30CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nboZL-002Iec-8i; Tue, 05 Apr 2022 19:10:23 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nboZG-002IeD-Le
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 19:10:21 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235GwcpH012575; 
 Tue, 5 Apr 2022 19:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PmbLZh8KVgzcvmyq8itPmJ4tCYbVM9Rj082j5AFlmG0=;
 b=nEyZkCCvPx6ft9CimFtTBiteubEKGMSEyfZWOyYGroqVJDtIwMOyfmkMlZHkBW4x7j7j
 vQpOnWnlbyUad8dU3d6fiXeXXFXA+ySn0NhylSCtnSCy6sJ16KLuINDXcfeSELcCRn9H
 H6z1sKLZuaBfvHZE+LOU45LDqQzWecDwWT2PJsUlhCS94NBdjVEeq49JukYvTrCSBo+w
 O2XMi0SYvKzQWeIXhQyWF6kT9ViYd5aVuJjSRblxFj7fgwjFJyWmOOJLkHKvi6q2e4fV
 KGjoqURx5ceLfy/y6imW1fUu3NRw2TRluuzVPLntYPySNfOBiu5PBI/Sl5AIjeO2DNp2 Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcetcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Apr 2022 19:10:03 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 235J0oUj016804; Tue, 5 Apr 2022 19:10:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3f6cx3v885-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Apr 2022 19:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWHSt9TnuXz/byZvt5HjhxEG6RuuxBuJGkZGuzcmRgtEsSF3xVWfhnNL01wAfjuWr325utiTGpPLGf9h3elvFMB1gq6lpiF/WPxDuJDpOlbB/qx4KBFxYGXYo5E2n4AW0VkLDaj+THgHeKnqO1OgMMPK4kMXCEtbgpqhHWf1C2P3WZF1n8i38Rkgsw81jUBTC66a885esCEvUYHZx4WEMk/Bz004CSMX+lfhr3r8gSlx3iBy1/dCgnXhhSqnrPeSdMlf4XChJRLBXogkRw0WuaAcujiv++GGALKldBtCn98joDJnOWXWDLjfY2CUsBBJCqB5xv3DAt2ARWk+7lghhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmbLZh8KVgzcvmyq8itPmJ4tCYbVM9Rj082j5AFlmG0=;
 b=jJ2cCPQUX3xCx4LSGPzCgPVC2hL13zyYL1kWzYXbKfdM8PetWUXs5Wr7lQ1hvPU6jH+bYaZJZdRFg3lnDNukVfTMhP1Sj9sNmnSpC2KS1oGQ48cjt0MHsN8k2cVIfwAeDUr75+uoPzph7NCQ5VCAE9rUNaT6qpkcGcFghh7t0CcVDlXW31asqZ9DA7CaCLmyh+vB+BvNqiZp1RuOsEuEjAateanOg1xo3sY4c20Rx59wx0FE32El49ackvjDL0PqsA908Pfj0lgBBBWCOA8ful04my/5YqSZLnhtIUbCeSHBLV3HCSwy82ttzwerV8NgRtsN7toEEmdxyRoxoN/nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmbLZh8KVgzcvmyq8itPmJ4tCYbVM9Rj082j5AFlmG0=;
 b=WNY4uUXmXXKgR4WQB3fCTxaE9JKipyuhr82E52hyTFW/+4co52zfP/CZlFX3x0b2RErqHDZmxqsS2WSRIQLvEksZugsWJo3QVBdPRBmUX9Hwul3jhgrPuFg83PsnqTDRce7EcApDYJKOF2T73sR2sxQXHE+JewbYQfD1j2PkmKo=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BN8PR10MB3556.namprd10.prod.outlook.com (2603:10b6:408:b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 19:09:59 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 19:09:59 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Topic: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Index: AQHYR2cuTGHViq1YXkqwVFy/Mk48Dqzf9jCAgAAGqYCAACpjAIAAD4cAgACjS4CAANiegA==
Date: Tue, 5 Apr 2022 19:09:59 +0000
Message-ID: <F29C08BF-98FB-42D2-9D38-69697A50250B@oracle.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
 <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
 <YkveT9/oBMoykEsy@infradead.org>
In-Reply-To: <YkveT9/oBMoykEsy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb458cc-cf6a-47d3-0e1f-08da1737e121
x-ms-traffictypediagnostic: BN8PR10MB3556:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3556141215038472817B2244F4E49@BN8PR10MB3556.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clTm48UwO9BmLhbhZkGibqfPS+Hhp/NIYbXgG2/s7K/HNp+zrvCCU3MozB6sfq/501ldBxVp/J/BQBwzHAm6F/UVZm9AciLdgYXo9n5agL0G12vAOL8GRttxe/hSPo0WWwSFB0akPAb0PiM4/g0XUoY7SbJlsUjX801CMPrvnLvIxK0BmBPsoDXtTTxNw5y3bImkkZqcf5ymf9oZ44x56FCxypir7Ui51TXNlmzbTMtMgVuPJ6I6thkbJgJdHV3ZlVHeobfYZghrbOgisgcws/XsFUj6lLAUQ3M5CEh6hGaV32NLNGyc1mRF2TrW4SIOD3ER6yjNHmmcsN7TEG952rnH/pdUzXwKpq2L0CHpeb0QiJQEyAogsvDa8TiPljCEdjj60OJhy3X1t2oAGe7f7WhPj7IoqHqwETlHk29Arpr3hcX8ilvR6MTi7Vcc1+oCKYLptlOhS+u5Ec01wBA1tJ3ZjtYsT1SV+imFTtqWtiEiutyMc94y0G5EHVnKlKq5OVDlebtyfcD+gwdxLsykMCTEojUWw1DPTOrW1t8tzZHpnJ4IXyG458cjNgKsmsR0OZklEfcmOHu8bmYkFq5eJoTxGOckGPaKNWHDW5ABdQbsAhO3pPVJpMELuas7tjEDW5Me8JgdIu8sj8E0d18DlBd1/RGuoxmq3wwsZfW6pk5eMxkW/7HE+mVPtQBIg2FNmlIaIVj7ii5fZgd9aw1rzANiLTnCG+bSMI9DBL/sgj11LEQR2ajgTotGHszwuJZ9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(86362001)(83380400001)(38070700005)(38100700002)(6916009)(33656002)(64756008)(8676002)(4326008)(66476007)(66556008)(66946007)(76116006)(66446008)(91956017)(122000001)(54906003)(316002)(36756003)(44832011)(5660300002)(2906002)(6506007)(53546011)(186003)(8936002)(6512007)(2616005)(71200400001)(508600001)(6486002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2TgcL93O0hglESBPt4/g5t/zjP/kZ7l4NmMR+1Y0hbf8NFllN1ZPSeAsoPXH?=
 =?us-ascii?Q?1B2kiwtJ3GKYBPppP1FX8VOQSCxM139ChZmxjGJBW8ydGABVsP1eJthP6Q1C?=
 =?us-ascii?Q?7R5K20oUYQgfI7yR3lQ0+N+6XUOJhBg9aPnSZm38FYAVHHoavH6IpGAkv5pr?=
 =?us-ascii?Q?zL+TCYEpVH19HY9aMC/vxphie45oa6tDTf540dyA4OPz6TZtqI2LS3NzHtQN?=
 =?us-ascii?Q?1juSUeU+jfDdtvRY5P462jHlgZYH2j4oFNEziQ8BT1GRXhVKHm5sbx5nF3FT?=
 =?us-ascii?Q?IqyEa7lRwfJ3oec1xFNkQO8ojILA0VZr+qJKdYeqIVnGrtEn8kxb5BaQraYm?=
 =?us-ascii?Q?zeD4+xqj3qXC8GFzfoUvo5+BSWqfw4DChEyL8AahCYkkl2fdkjlSX58BcOln?=
 =?us-ascii?Q?io+MNytaloTNTTd+cqeOXD9Y2dYHoRcjFaMmGNDIsx48k8ORqrZOcI/hWXZP?=
 =?us-ascii?Q?XTHZAR8FHarKZ2Zyfb5ftOYCBJSoatZDLst12kpXfCJuk7UhhnqGD1PEP4Il?=
 =?us-ascii?Q?qbIILSwYPxw+5idKD5et/iY93FmxPOD1YvtoL0p6JAmYDOoE1n1ou734oha6?=
 =?us-ascii?Q?OWjIGfIcnF1sQqrRpHWIC1Zjur7EspxM+UJa+DdAsfy+ELmFj6nl1pBwVUTc?=
 =?us-ascii?Q?QKfp2lH4EjlcfmEHVo1vWLKVdY/fq/zSAqvx+IZ/uoDXMxw3/zv8KtQ0mVjc?=
 =?us-ascii?Q?g56zLgpVGyDM0LW0AhXIKdyEQDTGgoHXz97l1qHs4waK20707oKXaiUJJZd2?=
 =?us-ascii?Q?3brQMBa5uxwDNfzZgDVkRjNdgA8aTHNOxlqvz2OwgdHsa1PbiSUpYsO8xXcU?=
 =?us-ascii?Q?4JU/UMzWN8uu/H/rfWhSy9s2p8rK8ZyHLgaXK2h3LkwCXj7JmGEbYbcaKq2q?=
 =?us-ascii?Q?uwdguPszHbA/6EdrH0otoKRlxzhDb77b+XYh3bby20fMNpy9nCl5UpRRrfbf?=
 =?us-ascii?Q?qQx18yVoQKcHeXGpCEz+weYNY+ps4+goMkIZR4yIUvcR/yJmyzC6RZJwFy6L?=
 =?us-ascii?Q?dsUoawkLr2zNhEoyJFRqzGjqBtQ4yMrTRUGurwxukKZIZrUkndOaOsHgBKud?=
 =?us-ascii?Q?cPzSFWlmnmabSW5puJ7MWcF1ndJXqSmu7TJyNDfL8XueT6Y/npcpPPdziddh?=
 =?us-ascii?Q?Cwt0J3ENQLZlZUbtw7OMqwWP8KzEkysVMB/nl//cvGVbD+yWv+1Ef5U4FUF1?=
 =?us-ascii?Q?07qUNpEHootp28bnUG4NLv2/WlbfAfUX4kO3bHJTCm21Rss3kIQXgT0eqWDl?=
 =?us-ascii?Q?WHYsdIDh4nBcZjKHa+dVaNxCZ1VirJWbZ9IlFVJ/kXWz+7W3tSNg9IpziHMM?=
 =?us-ascii?Q?GAg9QM6L2lEWoPaNBrbTT0bJnwGnBa7hOZ2C1rQPL4H4kCKLEDxra0lZi7r1?=
 =?us-ascii?Q?42XYfhEE261cGGQ1sOwc4nu+VPfywG+9Ixp4LyRrUQh0OffN56o33I2cBcC3?=
 =?us-ascii?Q?fkfZhjvTV0Km+x06oQ1stpiMYskQuGJc6fW1TMdD4sDOoJ7HgzpZA3i/hqNk?=
 =?us-ascii?Q?wsocCzN8C2Zgdsh096gipg1ED5U1eR2C3G8WUbhqTyPtuqlZGRP7PN1FH1cl?=
 =?us-ascii?Q?IU2Klm12naE20rgCgYs+9OmBjjljGogtMq66dcJil6SNSLpN4VIl2pY8e72x?=
 =?us-ascii?Q?sSq9A4t3UDpaPIpgqhO6pz3BiRYk1PBowqagw8YnIwEoNlEukxI+LL2hFkqa?=
 =?us-ascii?Q?dZaqWRilP9TP3xR7qQuFKb/HI39EBZWTlens1gFiAFZkxdO4bamPl+QWzI+j?=
 =?us-ascii?Q?bkyeuuGkz3b/6jCdZSVBPlL55lNxmWsGVPyS1POcrnKJNw+VTkCkoopXBWiz?=
x-ms-exchange-antispam-messagedata-1: OdqyB8A5qP3/Vg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C34F9907D15B2D4DBC446AB7099FBEF8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb458cc-cf6a-47d3-0e1f-08da1737e121
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 19:09:59.2620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHaot1ks5JqisFJt2ksWE2kmnEK7ai9UZDbOgApdXoyvG7U/Ki+7sUnhgCwRHqpAtiFuxRDafpPxsje257v+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3556
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-05_06:2022-04-04,
 2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050107
X-Proofpoint-ORIG-GUID: I4UdjVVwbHQbIOobU4qb41ZK5egbQM-n
X-Proofpoint-GUID: I4UdjVVwbHQbIOobU4qb41ZK5egbQM-n
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_121020_159295_2D8E7ACA 
X-CRM114-Status: GOOD (  27.16  )
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



> On Apr 4, 2022, at 11:14 PM, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Mon, Apr 04, 2022 at 02:30:12PM -0600, Keith Busch wrote:
>>> Eg, nvme0: blah blah command set not supported
>>=20
>> The new print in the completion handler is pretty generic. I don't think=
 it can
>> readily tell the difference from a harmless error. Maybe pr_err is too h=
igh?
>>=20
>> Or maybe since enough people have been concerned about *this* specific
>> identify, maybe it should be restricted to 2.0 devices where it's mandat=
ory. I
>> was reluctant to do that at first since the initial device I tested was =
1.4,
>> but it was a prototype and we should be fine without the non-mdts limits
>> anyway.
>=20
> What SCSI does is to add RQF_QUIET to all internal passthrough commands,
> and then skips printing the SCSI specific error messages in addition
> if that flag is set.
>=20
> This would be the nvme version of that:
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7e07dd69262a7..9346cd4cf5820 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -366,7 +366,8 @@ static inline void nvme_end_req(struct request *req)
> {
> 	blk_status_t status =3D nvme_error_status(nvme_req(req)->status);
>=20
> -	if (unlikely(nvme_req(req)->status !=3D NVME_SC_SUCCESS))
> +	if (unlikely(nvme_req(req)->status !=3D NVME_SC_SUCCESS &&
> +		     !(req->rq_flags & RQF_QUIET)))
> 		nvme_log_error(req);
> 	nvme_end_req_zoned(req);
> 	nvme_trace_bio_complete(req);
> @@ -648,6 +649,7 @@ void nvme_init_request(struct request *req, struct nv=
me_command *cmd)
> 	cmd->common.flags &=3D ~NVME_CMD_SGL_ALL;
>=20
> 	req->cmd_flags |=3D REQ_FAILFAST_DRIVER;
> +	req->rq_flags |=3D RQF_QUIET;
> 	if (req->mq_hctx->type =3D=3D HCTX_TYPE_POLL)
> 		req->cmd_flags |=3D REQ_POLLED;
> 	nvme_clear_nvme_request(req);
>=20

I tested the change with an instrumented qemu emulated device.

Without the change:

# dmesg | grep -i nvme
[    3.610944] nvme nvme0: pci function 0000:00:04.0
[    3.685467] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc=
 0x2) DNR
[    3.687850] nvme nvme0: 1/0/0 default/read/poll queues


With the change:

# dmesg | grep -i nvme
[    3.437014] nvme nvme0: pci function 0000:00:04.0
[    3.506572] nvme nvme0: 1/0/0 default/read/poll queues


Would you like me to submit the patch?

Alan





