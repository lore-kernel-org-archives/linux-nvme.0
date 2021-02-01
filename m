Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B167C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 19:05:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3018264E8F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 19:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3018264E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zcUfz37Vj9C+uQ0NAkXV1UsvfuOAJhGsBPMIpBmyuEI=; b=XOw3LUw67ZavGroWOAM88NYqoJ
	1FQW01LDGG0gM7ZVg5u6iG6mUyfqa+hym8K6JqjTjA+CslkHSKtk9ZgrO8J6Vk3FCjlM1oDKtgQU1
	EkLh1oPIMCtzwT6a1RTaZsP0nWKgt7lqjwa0eyIhzhD2didshq3+jVdtqckd7NSfqDnhEA9wJYnWc
	ggLkKfnuugC8ayp8ToXJofXjQ06LJySCzeklt+8ceDNBfhfTiNymre+2EKS36iICdSXKWqAbNfJJ5
	GSpk17EHhvR9jAKfxd1DmKepcgZ5tjenIREJ211Vve5d6xEPkAGcOysobtPHCqreLgQwgF4IOx17X
	WrAeyrtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6eVc-0005IR-4G; Mon, 01 Feb 2021 19:05:12 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6eVZ-0005Hw-D7
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 19:05:10 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 111J1YDw015839
 for <linux-nvme@lists.infradead.org>; Mon, 1 Feb 2021 14:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=TyVsPQsnGNV4GP2BQG+uzddIMxvExkqJXO3Bwnfos0k=;
 b=L1NXSmoq5BZ7ozUQZTP2L639CaFdFyRVemhgGZ3+QGt5A88oXIVtqoJPcVC2ky3x/rb1
 NT/9fy/+xR2AQXJMg0htSMS4zdvvGtCWdcKyMxjsihok2FuEfAUeM1rvDQT/kneGemto
 MYuNGcVd2b3abjImFiZkiCM5kMoJqAkOpT+YZybi3ZinrfwyX91ZoX+kVPmUCQB1w58i
 V1QKehZOp0IwcRMQf8IfmEJEP8RL0t1gaa1JJUKPGU9YGZ4AnD65W/6s59/gHu4Ewd9I
 /3pvJoAfogQ5QjogToGfrIoQKV4h20s2VT+eliT3C7uONN4pm8ngjr89kMqa2cFUyrtL Wg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 36d3g1nr8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 14:05:07 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 111J568G048118
 for <linux-nvme@lists.infradead.org>; Mon, 1 Feb 2021 14:05:07 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
 by mx0b-00154901.pphosted.com with ESMTP id 36dnmf3tmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 14:05:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD/veAF3yTomrkxbC+/8Ni9LwNfInZer66W8It5T5Pn7IHk2pJJKgNArUYHuxENaukKc8E0ZKlwghTDZxctTG4CgG8tMiRgdDkkbB0Fo51mGkPs8IRqjyapJ/F4bQ3Z02TH+8S0ORnX/FYZOI7m/82Du6Lmkxk5YA8a3SF0T8Lft6OSSOCZ5uLEFFcLsxHsB8uiWHoD1YxLJTf3GGP5WGzpYjOhkqMy74NGNDRmOl7cpcdW5CLEQkAQAZn1ZFjjJj5LF8aIm8Rr3nJpAjyfWt4U/a8q7TstebCKF8LLE3r+T7fC9Br7vZsBquNyIYQoeChaBM6Fq1M/d0kbqpX0UKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyVsPQsnGNV4GP2BQG+uzddIMxvExkqJXO3Bwnfos0k=;
 b=U7RBR/r5k11b4oTK2f5b59pIAY7FeM/o+pIz+O2sObebgiV4HjFzvwrooByYRmUgQ9s51n6MamVx2hKzqq22XEuQ50DLxk7ZxiB4pEh4ad49+bWuKRIk0BjzmS+/Yrju01sTRy0Q/MLbMegq9dJlOBAcn99oCI4uXb3Ui9a3zjt2rxA79RyXisGQiNAJUNBOzRlt0PLlxgBbzFPLqdsCZihvAQUKJqQvD8R13LBtIPLu2FdX3wdLonI/VYTGrknUCD8QRCzB0c+Y6wexi0y6ARBfqsHCeHgpb8jWHM7TRJ2++rmsc346o6Zks3M8yz96UMjPRtigN7Wy9/pskiLP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 19:04:39 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9%3]) with mapi id 15.20.3805.028; Mon, 1 Feb 2021
 19:04:39 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-tcp bricks my computer
Thread-Topic: nvme-tcp bricks my computer
Thread-Index: AQHW+MruLzETObAxCkyOGm3Q8Nl/FQ==
Date: Mon, 1 Feb 2021 19:04:39 +0000
Message-ID: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b64ec75-07e1-47fc-425b-08d8c6e43980
x-ms-traffictypediagnostic: SJ0PR19MB4544:
x-microsoft-antispam-prvs: <SJ0PR19MB4544AC60A5355D1CE429636BF2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNp6Sh2Wpetbcuv/PWZ6mmQX4ykaSHFlv/ZFuquQNJ2V1JZGcO8OhZ3TrVF0lV5ZCK5nCXIHyDQxv/G+Q9s7uO6gg8yDNCNvKmbdqK/W7uNxBkvyfF1RErbOaSL+H/nur/QSZjK/1qqIY31YW6BPg7ts7x98XQI01oZU8OhhHtsApmGIB1lo6nh1TwHbz3G1UeZkdkk4+uFbHMFqac8+G2W/uKQtcm6EQE/fjvTyZZRxAiHFm431FDmzkulG5i0cySgjFJeznscXCXldHjIGUFnBlbFHVhmwRJYP/63OkfaMGfiELVk1/tTxcvEbQWgUNAe87b12U191FJLxSwTnQSKTV+zOHa+z0aV2auBhnLBv4X7EKfFomnSKZdqf1pUGBdeJB3SvVK9WnDfls0tlxBN5i8WQ46s4S909ZitrwbTohzE+7yOKbnvJvqxgsO5APJsGwOXq4lGfiTVQ/gbIeaw820FQcugtJ7vxJnEVsxV7HCQQj7DVkm89t10eqb1JARsurBkIBjkriT4KoBIJfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(8676002)(2906002)(8936002)(66446008)(316002)(66476007)(55016002)(186003)(64756008)(66556008)(86362001)(786003)(83380400001)(52536014)(33656002)(478600001)(9686003)(26005)(3480700007)(7696005)(6506007)(91956017)(66946007)(76116006)(5660300002)(6916009)(71200400001)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9nXc4efj52E/kOqGe51svr6Va5Q5Y8jMJW3M1H7Rhj+lnwf14N/0oCPa/R?=
 =?iso-8859-1?Q?yMDO97dpb7sODR0ci7+5PGBAKqq3fRQ/uqGjkGISbkjgRU0+K6CIDSToI1?=
 =?iso-8859-1?Q?n3T8P4B6lTAiTdFYQ/MwoIQXeCDatXqgxinqq3maUsYJ1wEzvaI72E5JLL?=
 =?iso-8859-1?Q?b6/0shzPeBL7N7a0E4nWQbBpc4MTLhXgDelL3c5qd3izSg97Ve7n5fqhi1?=
 =?iso-8859-1?Q?ydeHi4Rq0mdCtkg//U8K3rMpBKK2aP+hRyL47KsB7JRWvsOGfQiovt30gL?=
 =?iso-8859-1?Q?OcmjNQKOEOIumDYVfEmd8t08XGp06FwvgHB2HUBZ3eIn5pvnCof2KsF3lY?=
 =?iso-8859-1?Q?DSC7PI/wTjaMilhYw+3sO2R9yUnyUIHJJ8LFNuVhSzQCobxvzLKN42PK7Y?=
 =?iso-8859-1?Q?Z1h2R/n6Ihcg3TcXfeFv8JKLyv1iE8w/IpIcFa5SDr31OzS+6kWkz7tWIX?=
 =?iso-8859-1?Q?YeHZiDv1b/B3rq6iwl2gVQG1SsR1eIqtpHa1w0fMraw1Yf54/79sOBzacY?=
 =?iso-8859-1?Q?+ttSX8xZXlKJS5LNHExQUIaaJjJSkE0PWArIOAgVwbtf10XE0bP1j+gtvF?=
 =?iso-8859-1?Q?TMtXFvopc90Zq0akXR1LlDLoLoSQ+LT5652Ped+RauYdjJN3VRXftOeWFW?=
 =?iso-8859-1?Q?8UYx4vpEoCg3C2SKYhiFUITC5s5KsWk58ldO77ZamI7V50fbw9kfp5F0xH?=
 =?iso-8859-1?Q?iSyoRg5IC2lofH7Y2LEDatPXdwCxjiF4VR586HioMpVdtWloCjGGnC3HBi?=
 =?iso-8859-1?Q?lgDbn5Ng8tu/8HV/DBLsvt77H01HgCpek3m+ax41JM9FZvkdIMG7nZCQ1r?=
 =?iso-8859-1?Q?fL76dp9Fw05ZnqnodyU5K11JCo+t7YZsC7VQK2RC+ZHiAJwmwxuqg6jKgv?=
 =?iso-8859-1?Q?9a0PvaPg8HVGumrq/zH9iz8fiuSyRotk3E3f2bOGXUZZzAoH0JLPRCzOZY?=
 =?iso-8859-1?Q?7FK+1JUA3X5L+9Q4fYk+5ldWNtzDby6ICQ271nZWZZNhcyeARWAz+fPoNT?=
 =?iso-8859-1?Q?bvzHTRZxiK7DLnw0bBREpw4qgIBSbqDom4rmutkpZGqGfsnBfw6PMxXyVI?=
 =?iso-8859-1?Q?Pw/ttdtV+TG4vk6jmELAdI1LTWt3cTpT7FEmfxLx7du4?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b64ec75-07e1-47fc-425b-08d8c6e43980
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 19:04:39.0732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCOuA/YChwwkGLp0ehwL1ehO7NTJ+RfaQOZSVI1bRxToiTBIP+2p1mI4eluAldkYRUQNgihXrPjfs2ivzi6oUiQ+bdGxIhLWdzmbbbsMreE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4544
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-01_06:2021-01-29,
 2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=525
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010099
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 mlxlogscore=651 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_140509_688894_7958E4E0 
X-CRM114-Status: GOOD (  14.17  )
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

I'm running "nvme discover" over a TCP connection. The nvme-tcp module freezes completely and bricks my computer.

Steps:
$ sudo modprobe nvme-tcp
$ sudo nvme discover -t tcp -a [IP address] -s 8009
<System Bricked!>
Only a reboot (Alt-SysRq-B) can recover the system. 

Conditions to reproduce the problem:
The Discovery Controller must support sending Discovery Log Change Notifications. That is, bit 31 of the Identity's OAES field returned by the discovery controller must be set to 1. If OAES[31]=0, then everything is OK.

Systems tested:
1) Ubuntu 20.04, Linux 5.8, nvme 1.13.21
2) Fedora 33, Linux 5.10, nvme 1.11.1

Regards,
Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
