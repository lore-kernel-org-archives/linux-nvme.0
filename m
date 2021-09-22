Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F79C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:38:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F61610A1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7F61610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z2x35jEj+cXveGI2eSNHfXRWricxSxmx4YNsXoEcloI=; b=2kUFZYVMNenNMd
	TYX/ei66MljE1hp9U3TMZbB4vq6mQypDCKYo+lX669zbS6ygwi9QVCcf7otnT6ahiLTHQ4FZJj/pA
	+AbbBfLVWHpDa533TM3P9JXRE5RW4cEequrin6o/6O8R+Q7FF2fPVWOjEVXs/SO4Dpoebbox5Sxn/
	RsYaWGMoRMUmLz9eaBgC0h4nYyP8V76LuTgYRLTkjfaWcCm6QY5V94wFlhzGrtZyQjttIzh/Zr903
	2SL8TojT/hpNZ6rSdsPI+vVxGRIXEoFHxfqhJ3B0qtlou73CzfuSA4iIv79xkRaI1uBujrWu2P0fc
	7Icm7xqcvPAvbccWhdCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2Rj-008eNP-Od; Wed, 22 Sep 2021 13:38:00 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2R9-008eHC-Sa
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:37:25 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MDA53U013119; 
 Wed, 22 Sep 2021 13:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PgyJsilsdHSHDOepAgChRz0ypilnr7D5sZEGiqeZUEE=;
 b=fd1m+WXlVrb0qiBQXgTbdLF0bwAbgU4ta4uolnBVZaF0BNIV5qLqGQ3VNhcpzBPACNz8
 SM6kFAoAk6MGXss2Ej6IYyQ+Y9/VZws11Cs0yMWVkXKNJrlwOGg88k6tfANZoEl8nJ99
 g1awny1B5Cv4+2Sfpz4rQsJiqZy+BerMO3dDiH/fTNVFrW91SBQiTD0MFwcsT2cf+C4k
 uNCaCLKxk16YBdqh+knzxAjoMBkR66wGxaY+LPr0WmNXduAKnGzR6oRUZzUsYwPaDL4u
 iYBmE3vhnycj+pRy2iYpCDHE0FbQNpJdVNck93lIA6NmOR6pZTmBrsimBJ4fjbeLa+I3 dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4qkw52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:37:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDa3UC061087;
 Wed, 22 Sep 2021 13:37:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by userp3020.oracle.com with ESMTP id 3b7q5w7q9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrufKENHkLHAiQDV1vgaXgi/bWDwvG/NMXquYJZGQS+3Ge1mcqrto7WLLcgxiExZja9HtIiKQwV82PmU9/+mod34LV8abrC9ciD0FxXKof2roLYIfdRJwq1toDVCJY1es5tZOMDIElbpI2vlflvwAVe3KcbW2kWiHSzGeHEW9Pxd/9JGv6L/KeyJgWJ3TYGDphI/L19Ze4ZGl+fgncUAic6VbR5+DjYIecwGLKaKrTaqd0Sr6OmSTl9VScNwu1bZDadAJXGjLAezuCyX/oWCnpNxHZLWdlvsvtf/dUeVFKjgMQpUgYwAQsKobmCPXooepOt20OT00H/k8jwXzc4ggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=PgyJsilsdHSHDOepAgChRz0ypilnr7D5sZEGiqeZUEE=;
 b=RVTx1firpk3ZvOzhlJ5dsuHSq+8KZV/ApJvxtbZ43yoCj7vOuY4wbGK/rvXrc2CG7zznykBklfdpagGiHZuJElPbNNBfQW09jwrl8xjpIab5R1ElT4Zs72J5OX3BEn07zdf8ILfAh+jkMltfjDErp8R49NlpPl/+a1I4BTv5edY3bq1pKMuC3HDu9a1xndiP9VNb+aUP9dqzrfRbHkZ9IBtdUu6IxxHLLDSP35emj7JK8NUursEsaH/lJInJ+tSBXPevVIZ7YUTyRH9xszhhQ58RRT6n9PEK72y+wFgwHPuXAKEIOHdNa+deEw/XL5bjXWWp7ZjdQ2VuuveRyYdA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgyJsilsdHSHDOepAgChRz0ypilnr7D5sZEGiqeZUEE=;
 b=EhiVVd+fWKx8mIaQ5HmfDsEWAXd9aFMtnr2ugfRgsGL8SKHfQDof0ZY+SGrIUcg9gnRuuQsOrmHYLz8/y63uuDV7to4cob1AhGHWZns4nq5YA+3R+sQSQvJIZGsqavLsHAqCIdgy7pT/DMl1LkAAYZ2VpvlHcs2ZgWhPdrIT6cs=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 13:37:14 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:37:14 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/7] nvme: add CNTRLTYPE definitions for 'identify
 controller'
Thread-Topic: [PATCH 2/7] nvme: add CNTRLTYPE definitions for 'identify
 controller'
Thread-Index: AQHXr36ltL8Z9ghxtk+y8Fxs26tF0auwDumA
Date: Wed, 22 Sep 2021 13:37:14 +0000
Message-ID: <66FC4F03-ED5C-4727-BA94-C23DAF7D6D76@oracle.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-3-hare@suse.de>
In-Reply-To: <20210922063525.143045-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e147a667-7508-4f30-f445-08d97dce1681
x-ms-traffictypediagnostic: SA2PR10MB4556:
x-microsoft-antispam-prvs: <SA2PR10MB45565E1A9BD32E181042363EE6A29@SA2PR10MB4556.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnq1ni0DbpaVQ3GoPWRtI7GB7jwK5mM02qrMgdlcOrx8enaADRaZ3Q6Ger2ak39OT9Yaik4YI6Gr9QEgp6Ax9Y4qUgMqQ62ALVmfixKMpggRMTtuednhEguXv5Lx0IOrRCIBWAIeo7DjBFQStFs80DpXt3zkfxf1Pf4UqxWHVV8nBHSp1cczfuFLU0J/4AZv2J63M8MegtYgRUDuyIGCy8RQAi/uDDqg23RoXjTm+ZL1b1hCMG5MIWPXUdzd90FGivn9qDrnwR9tX6zfMPrisYGUrK8ptkg++KhyVt2Gl0XDR9Dy+FZK9XSUQn1t+TpfoVeShmR/zaJfwvdraeXpm+d29QxI3IKmNHMobv5RwhyvWEN7NvxzPZLaMqeEotGgOWqQVbRIBcgMFe4rnTfUfFw6ZVjcg8jyflN/ybd9mToEg3dyMjovrtZZTLJwWKaBae9Y7EEc8ibwgynpCqKyw0RHWhrQvxM6RexjeSAxCTfF5JlQZDFzT29jSh0MSVfAdz+hTIIs26stSFAffApAUbrFm9UMDORk2QnVg2KPFUQvARXaWeGJ/Fho910vJGHfP+MmIC+Ixmm/Q05Z2E1NbGfxrL0LWTqUN4gr8Eru3i5Kowf32r52Tn2ldkv3FKnOFmJEhhIMsnywhrwOjay5TcCRTylpcb7kH260F3wA5AQtQ0ODt5fWBicEWY/MGR4EmKkS/7Ty6k0OqtfNzpP5zTPv6BZDJOPoP4Pmz4mCrF+iZqS9hISO2uPdGyC5rlBJMc3oIfGHYAFmFHFrRR+JutoNDIVOs000hT6/4Lw2dSxr18849Hxgc4vckHEymvUp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(122000001)(53546011)(76116006)(2906002)(36756003)(6506007)(316002)(66476007)(64756008)(66556008)(66946007)(66446008)(86362001)(6486002)(6916009)(71200400001)(26005)(2616005)(44832011)(508600001)(38100700002)(8936002)(186003)(33656002)(4326008)(966005)(83380400001)(8676002)(38070700005)(54906003)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kRigPC5AqAabj/0NN2RMZG4WwN9LfEz96nE0vyeLXia4e7Y75pi2QV6ScBvY?=
 =?us-ascii?Q?EHhxYXiM0WTVDaRsw+/ShAv11wQ+8I0Cfuo2A+VtElsvGouWueL3YEsh1Y2l?=
 =?us-ascii?Q?oRfJFqRcgP0fY8ns3Jn3dTVvPp/JBgJby4uMhfruOoyR2O6ZgNfCrPrqQD0u?=
 =?us-ascii?Q?p8+vcH+mXUhU7qhrFe40ODlCINYZU8EFQrzx7ZcXbl5B5+VR4tm9g9bk4UPJ?=
 =?us-ascii?Q?KI09jUviSHR8OwqI/czB2htFxq4DJDYRP1C8yBzcBAOAed0BrlgYV2PPNEVc?=
 =?us-ascii?Q?TrSOK6d9eUO9l8yIQaL0aJDhfocoVkVFGdyHyGSIGfFfKsqF4+/H7KCSLm2r?=
 =?us-ascii?Q?45oBdTf0NeHPXsfuQuJdlvBXj5HegZiu7QKy64Ik/hcAHfSgzAgZgkLvVrK2?=
 =?us-ascii?Q?iUaXP5iFsU3lkrJmGhYaKWyh1e+9ajx7V1VNHgSUwEjzFn0K2XnuHJLiADyD?=
 =?us-ascii?Q?uYhwX5OctlBjWgL8vff+q8Ri1c+/qOMUcBXLIL0hltJjtI2KA2d7EHmLmSHe?=
 =?us-ascii?Q?9RFanayPx4m7SYii+hQg5HltbBfIoFoS0CHOZ/iuaRgUy4tw3kGrEJRjjarZ?=
 =?us-ascii?Q?q8KeJYtF0xylQIjBckghIC033Va9ImXhBOSpxCHgeuvL6SKqaEId0BP7Xwyt?=
 =?us-ascii?Q?jWsk4xi3Xdv8sfHuYwvymXzaLAHP9baMjzcdjhyup6/LoMEUDy/njdmYqLKb?=
 =?us-ascii?Q?Ni5+dN+HcZKUHKekOvLis7aI7yBqwOfu0HvbRO8ENYZp4lRLq0MIzGeIDlYn?=
 =?us-ascii?Q?skCHTMtGatkc+Tx6hiICgJlwH4VIsDbChAvd/D8KgKOV+uhY61S1OKoVcEQT?=
 =?us-ascii?Q?pAckPP7lyW5UB260yXLV9ev4rjqHaP6QjhPjIgDJrGmWSLkyT0SHtWkxKDm0?=
 =?us-ascii?Q?a5cBdBbxf7eXnHOiQ2TpSCYoMDKBtbvZlJfYGyw4VIn8S0G6CoL7hz53AaXS?=
 =?us-ascii?Q?uRYd7Z3boTctSpD2kQlhXWw7nRsqclOcf0lbKXyKYe0OX34Esb0LLVOBqrqX?=
 =?us-ascii?Q?0isX1o+I+FNypnWAbM3ExtW6chjWwdz2S7kRAc/sQ7LRSQhk1KxQar8+CL+g?=
 =?us-ascii?Q?IUAgqp1fyksj+Dr3ho7YlcDw/gzHLyzntwOeiUlTbNQmwUEFQPcRnj5Z5coQ?=
 =?us-ascii?Q?01ko8oDKcMC3TxJTLP3uGOjf37E8ruEE7rt3ALLbpEQsPAoEE2hQ1+WasKaQ?=
 =?us-ascii?Q?yR6ZyQNO3oWCdpoh16YBWI5LMjyBMj4KWXyfDwAqR6ufbCSOLsNmLIKCLpca?=
 =?us-ascii?Q?F5m/pNhCliRZVwvSod4SwySjBTuJ9M3QoURprYZZdwaGGYMkSfswFzn5KcQs?=
 =?us-ascii?Q?WVgUYOuTHHqjBuMOfis+G7/D9D0j8yT5JgXDEEZ8OWZAug=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <2144C3F026438648828ADB9A04F6DE35@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e147a667-7508-4f30-f445-08d97dce1681
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:37:14.2307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KATpYVkzrCug+VuT+fO+d5vZpRLlc5OsfFeiRYRbWfOy5EJnWlXnRAfk23ySMIruOKrdXpxMwmWE+lxGPJsf/2XEuu1tkC6B0mIaS3nqXFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220097
X-Proofpoint-ORIG-GUID: TLt0XJNgvQqctdTxV1pIIR7gesYNgWTw
X-Proofpoint-GUID: TLt0XJNgvQqctdTxV1pIIR7gesYNgWTw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063724_137361_C09CCF0E 
X-CRM114-Status: GOOD (  26.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Sep 22, 2021, at 1:35 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> Update the 'identify controller' structure to define the missing
> CNTRLTYPE field.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> include/linux/nvme.h | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b7c4c4130b65..ed2428918bca 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -31,6 +31,12 @@ enum nvme_subsys_type {
> 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
> };
> 
> +enum nvme_ctrl_type {
> +	NVME_CTRL_IO	= 1,		/* I/O controller */
> +	NVME_CTRL_DISC	= 2,		/* Discovery controller */
> +	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
> +};
> +
> /* Address Family codes for Discovery Log Page entry ADRFAM field */
> enum {
> 	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
> @@ -244,7 +250,9 @@ struct nvme_id_ctrl {
> 	__le32			rtd3e;
> 	__le32			oaes;
> 	__le32			ctratt;
> -	__u8			rsvd100[28];
> +	__u8			rsvd100[11];
> +	__u8			cntrltype;
> +	__u8			fguid[16];
> 	__le16			crdt1;
> 	__le16			crdt2;
> 	__le16			crdt3;
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
