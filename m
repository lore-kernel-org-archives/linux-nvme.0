Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA2C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 13:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DB26112E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 13:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34DB26112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l7Me3Wvmm1RMbOGchQvbe9RO/bTWCLUT3P8yDHEyu7s=; b=MuslUCD6YHqVZt
	Gc2oagrjDr70HFFs8hCIa4pCGEQhZ8RQ9E5sXg/6LVoxI3SKDJKM8UxcxkvPnCWFF4CrPIYACpq9s
	GXojtK339zfZiHFxRH3AI5bzwkCvQg7okSOe3nXxJ/WxZN143a42KwgpXrQj6MeMDkRqxQkk6QQxv
	IDGQzuw4wAjRIQBW4Ww0L/G9QdOFWgzaVLC5XeNLnP1lbwbazx5JYlp18rskVrFJqtYmxFZWcgrJJ
	W3wxq0n7FzjhpE6vopcH9qVb7ZIVMXRRjJOqwmH0KXvlAsLV4GmmhG/k7Q3h+XB/8YJKHhd2BRat3
	4BtT6mn2IY5hE9X7IzXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ8up-005v1W-Fp; Tue, 14 Sep 2021 13:56:03 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ8uW-005uuP-LD
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 13:55:47 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ECncLq024441; 
 Tue, 14 Sep 2021 13:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=avW8nYTOoAFrLowm/LTwAErtsi6lJ/ZtLxlWps7tg7k=;
 b=EkJ9F4Z4wP+nN8jA6wDB/2MPwR/jcbTgl0IIVfvXqH2V3vigUMK5QH8hgnSlvmbASl59
 0Xo4OdFje/CY2V5YN/YLJQk2uINCZ/kGXSC7bubuYqYTCa+f4NUMl6VFEbvEMS3MtG9d
 6FQ3HonxqjJAyYBljQyg+pjYb/m3ePwiWU+bT2RPq6B0oNFkVyU7ybSVk7k1SGJSa63n
 oxHP8oV5+9BWDrRDr66v4HSljcQCAntd3UD/u9ClvMqKFVA5jKFvBTBJ0bxjW+4DF2hx
 G2Sj1m1VVvDRn+lNgkQ7NcQAfC2Q+ct3/t6ajh3Nsx+VBrWG7fbPcKz8uuEmhajDnF9z hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=avW8nYTOoAFrLowm/LTwAErtsi6lJ/ZtLxlWps7tg7k=;
 b=Xti44XwBJha9vTcBZX50H0Z0FCoDVF5ncuwH4Twrwwcx6SakRb2v5z/ii7Bj66e6/3H1
 suSlGCny2XBf14YHqpqZhESk97T45kGOWO2PIc0vaHEiN/npDKvAtYOMKIAzo/UGlEPK
 G5ycmh0jbM7mz+h6J9r0shRK6uz72XnFk2FOzrC9Y2LhyDk3pC9RkGObo5jzYlLSRP75
 axjCXe93m9y235bqKa6KqjDP9k079cesrkFee48HQqBrr0vaotccq/OGJ0EAzHzLfjVb
 hLnqJVcUXfRfKLoxy0mmojYV90FRTiqS/hQevtLXF6Dkwi1YQlReFElwG2a+h27kc9k4 ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyg9bpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 13:55:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EDtVgV057380;
 Tue, 14 Sep 2021 13:55:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by userp3020.oracle.com with ESMTP id 3b167s4s71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 13:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inGQbYfaBVp2uNy2HjlQMfpt0AryzLn4mvFHIqeuV0EZppFX6T+j8Sk2j0g80MBjE99KjlhGQPl0TXVVNHNe860ZTsWjlob/QErkOO/FhDO7iMvaNbEGhR1G3b31/KnDbGXmROPJXUJ4Cdl0iWk5RLMCAo74yCTRkNaksmtwrQV7/yUjjB5tPAj52iSXj+lWNoX7ZFALenbz8AIRf8pCdDgY3y0rBvTOsXMKRbw0Y+Jklw1OD2ndX51bASmJCfIqLoaWPGMQTSR6zWSKzUXbp3xtfkq/++09Hl8LT1sc2LRDYlHcKqPREdhaHGdVWD0nXBbr8m9JojktYkqXaJCWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=avW8nYTOoAFrLowm/LTwAErtsi6lJ/ZtLxlWps7tg7k=;
 b=AEEP83zoQugxutOPwPY0kXVWXJnThBXZLSlrv2lpXIWBhnD5zauFeLToGus4EHZoWSKZ48KfMswXf4zwin/l9tKGO2VbSKpkyGPnri5BHfDumDlsbFnSQzZuIGKchHeEsGS5TJdq/rBEjlIc6BVsq9wIQcBpEfTB2xeRutxEi8BsBKOwLoJTNBk7na16/eoHQ1DhGwbUnrGoNzLZHrMiIttxK2pEina1yJhuMsWKOXvLhb2aPbETUDHeHiSPNRzvBuLoMrpUtJH8kp6ztD/iIAFzYvZ3Jk2jbBwpj7Zz5VmQLNuVVAcD5a/dEfY4ETpsIimplI7Ofsy5TuFAYQupeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avW8nYTOoAFrLowm/LTwAErtsi6lJ/ZtLxlWps7tg7k=;
 b=CbcxlJUlFvsXxA7fCdd1mQrj6o+JAYPDkHglElA7z1DEFGrVZFrtes3ZWYp1aH2J7AO0ZcG90T7Zl1BWoGe47jAK1kSCcJ0asOJlHmiyfYSDU3qHRi7ZPh/BwKQkt8igKmAkjDELNlo5Wpe3VPda0aKbsWRYOWecgQkuZn/i6+8=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by SJ0PR10MB5518.namprd10.prod.outlook.com (2603:10b6:a03:3f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 13:55:23 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::d477:c047:7008:7696]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::d477:c047:7008:7696%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:55:23 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hannes
 Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
 <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>, Wen Xiong
 <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Thread-Topic: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Thread-Index: AQHXqUm6rrULTUaw/k+KK4RXW1oSXqujjb4A
Date: Tue, 14 Sep 2021 13:55:23 +0000
Message-ID: <4B62612F-EAA9-4E2B-9CCC-6C5C60C73EEC@oracle.com>
References: <20210914092008.40370-1-dwagner@suse.de>
 <20210914092008.40370-4-dwagner@suse.de>
In-Reply-To: <20210914092008.40370-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eff3b43-fd99-484f-d588-08d977874c64
x-ms-traffictypediagnostic: SJ0PR10MB5518:
x-microsoft-antispam-prvs: <SJ0PR10MB5518F5A80D9FDF8189EC412AE6DA9@SJ0PR10MB5518.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBo8eYYT8h5wsng2aInFrzeM8GAyklXtdl10soIQTK8o4fL+1jY6k2qBpgHcWLVYgFjTbDfjpWHofu3Ogs5JQuAt9jNgoyjU+anFxGPBCc7He/+wra4iFrG3aLXgfixHPYotV0IrngDpb4NYXmc1HoGPSQcsVkcojIZ5yRjS86dRLhP5Q4XsWkA51X5X7q9RM84s+Fzc3qragIVw/OuifgP9ZblLquR+/3mELrpskUW3c+qi4MDbpZNhUfioEnP4lfbcGhTeSWithFm+WkmDdtBIniudMhDkWQtl3fjiI9Uz67Eeseg/SWuvp/WDXmmEXt3U+K10OWAdkYXebnm9Z6zhxv1Io12I5G1Jg8slEYkJwvbUpyh5ZUCQkC2Q0fVO8iXXSGGfixP3ffvUWcaeZNo6sJrWyJRySxB+iF9zzHC51oN4QeBte9e4en6hn6FKFHhflx2LMnviKlqH+vDS963rIZgZmGGM5ckGMdHprQkI9livQ/Fj7rh1QXx4Sjkr6aB41QKo+4YLU8XipeRi9knWFkuHpKCAjc1KmCOJlvX+mACC55vHSJSLXKPM0H1/A0dzl/faZ8T6QRjHuR0p5VxKfCQFimOHRdTnOWwCdZcl4vnIToS6970WQWefX4AIRdYB/4ECZdP3yIMnFO2GSWfvV9cCmRNSBNunJjEek8VOQKUvgXiNN3AfIzPkl4N6wXtjFhRrnaNPdHVCe7m+5/GXn8pmf0Wd1FeXPrbUFeb4e3pXfRRyiDBVovZ9EbKL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(4326008)(44832011)(36756003)(508600001)(2906002)(2616005)(71200400001)(83380400001)(6486002)(15650500001)(186003)(66946007)(122000001)(38100700002)(91956017)(54906003)(76116006)(6916009)(64756008)(66446008)(66556008)(66476007)(86362001)(26005)(38070700005)(6512007)(33656002)(5660300002)(8676002)(8936002)(316002)(6506007)(53546011)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tLRZN7Q3sOyA2dJFEHHHEgKlfL5zaoiOTjDx6Rz+FAHF/OeIgGJQolPRQ2Rg?=
 =?us-ascii?Q?pHDLrdo9sT5hNkzQ+/ziVPMJ5WgKacXJeJVmwCyEZpeu/D7wygdxJN4eXa1d?=
 =?us-ascii?Q?ayYFrNBiKk/9fclssTuTDfIEs2oFaMTUlVSBQJJXwaj26a7je+p7tPRSs2xc?=
 =?us-ascii?Q?xUFUx6Fo/hJk7wQbhyh1Chm0+hHz8FhlUJxBNgtR74e9nmSLE05lglYnR7Uq?=
 =?us-ascii?Q?PtE1JRxUS83d3TkS7mlCNraUGLvnV9QoxarJqwR1FpXZYUdiWrLWoCVl+r0c?=
 =?us-ascii?Q?N9rGWDX1OtWcjRivlMkPUn8kR1MS1AIm7CCO0yXzBTK9+jB03jRv4RlegLGx?=
 =?us-ascii?Q?ACrba8wqnv8PLLgZpG+dy/lsRZ1Hubj/Rtyc9331taMe6Dj3cOQdWlX2qPvP?=
 =?us-ascii?Q?Z85A/lqThZy7XftlEE0+7DVclKyiU0iMxMchthg/i1ebsKETCWNSyxrN7Ao4?=
 =?us-ascii?Q?QIBXHVO/mh0OAWpzDtrkU4QSozRjcaX1GufQ2n9ZXL2S2XdCN45qIbb8xiVn?=
 =?us-ascii?Q?xrFbgyt5cdAeyabcLw+ISVwMhdZ50LBQDhfqfDUjarvEEL42j6BhtftqFsW5?=
 =?us-ascii?Q?CNwsV2OUoX9vCG8/VP1p6Ky8HmXCGaEv2xR4pclZslf2tL8SGx9oXNROikgg?=
 =?us-ascii?Q?DeSuC/B1JOU/Q+YJM3M8vEfr6WpE/sP/TpMFNEx8ruzYd1/nL76miwbxzTef?=
 =?us-ascii?Q?fX1HLOXM1eVGU21xKlel1zPcZ3/2lPONd3xFv0AGhIyTX34cMCzFrYNOV4uG?=
 =?us-ascii?Q?dA/2SSiLOVnqpOCM0DY00ZDvDaVAyeiYbTAKSunsD0seJ4+wRgyXWy7HUvzv?=
 =?us-ascii?Q?85wpweGoZVTf1osMV8T6WJazbplmWKp5u0S+QkPCj5scBsxKmCXHznt6FTcf?=
 =?us-ascii?Q?K5ti97f+kWC6guGS7Wu+amZTs576z5Fvk3oD6PXaMApeg1bn1QLGiFIc1Auv?=
 =?us-ascii?Q?kBB1bRCTCSenPGR5mC3P7itH1f++BEVM6kSn/UvajxBfVkSxfhBeEQirITaY?=
 =?us-ascii?Q?/DvBfecUgYMqprjfUKXohjNEKX/JUtCGjzjJyxPEZjmaC2IgyJwY/4jPLfaD?=
 =?us-ascii?Q?lVpaHb6QINjT3e63Ug4KG+1jTQ/llMJwtausYyjsVs7/apPvu285UoMpgy+e?=
 =?us-ascii?Q?SiSXsJWwD7dzQZ0lMj2T/lt5eApsvvRSBq3dju+cVNwWmXM3sTSOTuwFSS2E?=
 =?us-ascii?Q?Fd3Qw+u7MAMoxgcxQlP8NMJC6tB9NhcZSFxybFwFJj+Thsqpjn8gViWxoTm4?=
 =?us-ascii?Q?eh52Tg16aTUPqHSvnc/4iDJS5oMMqGs2jJnp2M+S9IeSaI6oMENJwByKvLNM?=
 =?us-ascii?Q?RGXjTvKLlMNF5n2hpbl++O0uGQNU7EjJMUiVmOTYD6aOrA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <20DB8EF8DD235A41A97C602B88CD249C@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eff3b43-fd99-484f-d588-08d977874c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 13:55:23.4973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4stMUxYNcgqDDMIwOztYmEoAcybJxmTNKYgdTnLHzlU6c4STkgNa+bMXhdjhYaQI6+dGlDQGPteKcMahD4hlaUxgwTNm59XHCbizUCko0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5518
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140087
X-Proofpoint-GUID: S3bPV2QS2jWecu45PBy9O1N316AAxOEJ
X-Proofpoint-ORIG-GUID: S3bPV2QS2jWecu45PBy9O1N316AAxOEJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_065544_756069_1F256F7E 
X-CRM114-Status: GOOD (  25.49  )
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



> On Sep 14, 2021, at 4:20 AM, Daniel Wagner <dwagner@suse.de> wrote:
> 
> From: James Smart <jsmart2021@gmail.com>
> 
> Remove the freeze/unfreeze around changes to the number of hardware
> queues. Study and retest has indicated there are no ios that can be
> active at this point so there is nothing to freeze.
> 
> nvme-fc is draining the queues in the shutdown and error recovery path
> in __nvme_fc_abort_outstanding_ios.
> 
> This patch primarily reverts 88e837ed0f1f "nvme-fc: wait for queues to
> freeze before calling update_hr_hw_queues". It's not an exact revert as
> it leaves the adjusting of hw queues only if the count changes.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> [dwagner: added explanation why no IO is pending]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> drivers/nvme/host/fc.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6ebe68396712..aa14ad963d91 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2957,9 +2957,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
> 		dev_info(ctrl->ctrl.device,
> 			"reconnect: revising io queue count from %d to %d\n",
> 			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> -		nvme_unfreeze(&ctrl->ctrl);
> 	}
> 
> 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -- 
> 2.29.2
> 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
