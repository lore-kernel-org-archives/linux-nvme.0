Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40A8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WwYDdM2p7os4EORD6D+OUm4Hvmy5Kgsc6KPAdTd4rq0=; b=zxf2lQCxYgQdIk
	vpwRI9LjgHp76+U4/Z6JSIzcd41okzmrTEFEB1nBx6jC/QHRl9jW9m/LXOwSU+OTAUpU7WfGPlJtd
	0h9w17QAWsgocGQ6zn2ytBDLaU8NyJUiWDWf+6WY5jmZed/6Hamy2vcwVFQ8y488qDhvjrglp2jiU
	GjEwYgtjufR/J4T2S2TqOzYU705aXsTzdOO+FPvB7jllQqGHtsmEV1zfrHlolzS0+7oOqN6LUShdr
	hsN8COCyCmKjaUOuir5pJvts4EnmIh6OHXwiCqbkNHnB4rLhTTMcTaMs1S5a/zcsyxfzz5qayMDcH
	b5/Zokt7E/SGXx02rHoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhbCA-00EZmv-8S; Thu, 21 Apr 2022 18:06:22 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhbC5-00EZlp-ID
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 18:06:19 +0000
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LGWi2D005182
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 18:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=WwYDdM2p7os4EORD6D+OUm4Hvmy5Kgsc6KPAdTd4rq0=;
 b=RPKyO30oNT7c8BUM2BUrgaTEl/RC81Y9D1dzTFvIj++VzzpZ2mgGwBrKVaUY3onXBgq8
 FlxtZzzvW+iGqxM3oBfoqwH6j9lb35UVGHXRWR5eMt4MFSV/PJU2GFFKfVU+lR78JKp/
 ZHKAUY4Rcmpcmwoix/SWODk2p85kZiBc3lnJlvSPo8Sf/zH/PAOSs9K94ihcR+CFsD8P
 RTzxxbXMqMC/m7bPpZFIGpukcxxPz1vRA/ffjAO4DzABred+dxjWfVbgkeQ0qpgRrMLf
 yVt/wMhJeGsskJOVUHIqAJBywDBdV/afha06U8TXcY1UBjVRGlzbHy1lAHfUnZS3gEzA Yw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fk8cqjdhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 18:06:16 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 49ACE80035E
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 18:06:14 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 06:05:58 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 21 Apr 2022 06:05:58 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 06:05:58 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol3IWC/dlNE9MdivX6eTg+2C+yCiZ3BNIFoI74XtRy6tyv6yxrhjWLHu2UI2xfUYYUdrxlyjhEd/Dvb94sDRqdfMyS39wDoXlhO6cHslKw+XQnMO5aIwBOFfSAJFpVT+0yHKDAAgSyuNW1jXh6L2l/Iy49Q4jvOpWySQpUlIEuvMhliOdG3/k5AUX2P7cPHl6iMkr+ZoubgL9ztX/p2bdVBrbjWBPN1nilEIhgg/CaDJy0JhOYtD0nUkiXzD03RZ2r9xPFF2gczKaLAX/Fck7ktEZLfygvjUiAWy5Kr8SjDDE0DYbQnApegom3RlCBrLHpWOW8+WeBx+qL8jcJ5QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzOLJihTEE37jOzgd9OFGf0CzuXWa2pt5doAO83drI8=;
 b=NjDT6RKPfnl/jdgwTRTHZDop3+aCwZZ0gqwyq88aSiVMb4Xwhi2Gm3LwCTfJmOha1O1N9+ZQKRU2Qv+MG+W1aZ5glvQQPj21irxDXacYPWPTRJDbjI/+YB9k5rGj18wk8CUvuPobXJVGNqUIHZGH9rER31At+ikklWlNpgZpPtqTeK45s898VZ1Hkkk/MFFswdw5TMg2n5lly/dhSyaQuxULG9aGwtdwk9Lgl3K4y1tcxtFpAUHYSEo/3N2vIzZfp56bzUoYuQ6g+/ZGqjqTi6jymtXpD+DMwWYVH6iU8LqpEfQP+n+NygjU6AYMazv/6sbPM8YklukV7XqmR05bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::15) by
 DM4PR84MB1496.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 21 Apr 2022 18:05:57 +0000
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d832:ef14:4fc7:fae9]) by DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d832:ef14:4fc7:fae9%2]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 18:05:57 +0000
From: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Topic: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Index: AdhVqlZ3h7upkXT4TAG9KVUkeJ9NKg==
Date: Thu, 21 Apr 2022 18:05:56 +0000
Message-ID: <DM4PR84MB1590F030A9AF89C6E0E62A38A0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6750e1ea-d0b4-4cab-2b0a-08da23c19579
x-ms-traffictypediagnostic: DM4PR84MB1496:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1496F8FCBC3F0C3B984A9759A0F49@DM4PR84MB1496.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L87JsgNh4Uguocv+s9fyVy0DoRRHPlnpdCe/ZvSvSQvmjtmSEFWjvc4JJVhJFy1kOO6nRpIUlscyVh9Hpd+lIiIRPpfJ3HiaJJOvIiqmWUEgg4C5v7V8zcHMQnLkdq7UZktnvbAYPKkrFbFDKvYOsw2Jzqp5wZ1XjuInqY1bNh4mgF8+wxqzueQFby9aaYLfnne6hyp6h0jN5Y8vOD/aExWpCa0zBtF4sHt0vHY4XxHZoUYhcCvePW+OkCswYU6UtjC1z8o1b3uXMo8b1bMMCFZT2IKigl5WLteL0VAd3ZbWmxnMwarxAzJ7S0m3Y80ye8s6SvYyUjVjJEBKxC1kfc8raNvcSFEDxcgD4E3qAT+/EMAc56ku2/qh+Rd4mKAZvAydyM1QwItLXzVo+Tx2vsmgQpCeKFLsFRMj/Sxt0CtpDkMNUSwXpr/TVv8BzT+Yo6kP7WJdcOdHzp3RXZZy32ynb3+0H+0F62XkuW5WI8r+3StY9ODmMTJgksdH186KrHBFypa+8ieHilYn6jGBL1BjhUU5/m3Dr1udGLholPLs/8RLsiUxu7CKd7F98L0V/5SlgR1DbYfbUgbCpak9eAvwT+AP8oD+/8JkF1X18jUsF/fTg8vk6PSoKLLEc6jHkwnAcMamWqM0NXzspicE9KYSltGzcqKGtnT7vWiHTX4YZ0TdvbEv7XjNOlK5O4M2z1NWpE4dxnFPZgnPARjaJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(316002)(55236004)(82960400001)(38070700005)(38100700002)(8936002)(55016003)(122000001)(508600001)(6506007)(33656002)(52536014)(7696005)(9686003)(26005)(186003)(2906002)(66476007)(83380400001)(8676002)(66946007)(66556008)(66446008)(64756008)(71200400001)(6916009)(86362001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rNvfnXyiM1Yi8bLMVUDrL+/sTHXAABCGayvsktiq+AZ9VSgillttCNImZ0?=
 =?iso-8859-1?Q?ud39uOtb5Rh8zJU2lCpfslC3mEOvukO0JHHPYdLr6UCida1iPx09k6B+jc?=
 =?iso-8859-1?Q?LGruRBTFeCN6WmXRPFEHmdHbXGeIN1VjIc0Y+aH48zbwlAzIapfb+rw5W8?=
 =?iso-8859-1?Q?K5jh6oxeXRCB5oOy+rq6zq6g00qGaTXFHTs8EKfxPnni0fv1EQZDmhFhk1?=
 =?iso-8859-1?Q?OzIB64XvWrROeJcpl0dS9/B2B8k88pKDM1p5QhA52jCLoDeIZ5jCFz/BPI?=
 =?iso-8859-1?Q?nQXfAxrux9IiKysASqmXfzpizj0Q6imIiz64kFQO7bvxgVEagIx1yKU41+?=
 =?iso-8859-1?Q?xJ6ELaPWpAoI4lUQ1Znul+z+/z5clI2NZ32lJxJK+Ls4nm6lkksHslaXyq?=
 =?iso-8859-1?Q?YEe/uXvBn0IPF9md2TNWj6Qn1HljWuPSI6LBijAWPRRbLpo5//7wAZqQF0?=
 =?iso-8859-1?Q?dlkMuuqBP7A0bgZtvgXAXLBtbXrduvSYN9ye/+7joXS9jZZNAeF9qTLjRj?=
 =?iso-8859-1?Q?qoAIPNTL1WsU8znvuvYTbrM3aBLmSSg96+7fRxGdtDH1UanSRj/MBd2eS0?=
 =?iso-8859-1?Q?tSJSlBU0fC1nVwMhq+/RqcoOsZvr4vEFIZBiNrFE8Ctubz21tdX3ZqxmoC?=
 =?iso-8859-1?Q?GgRK0VXNijjCo40SyCYngUvAxPAaSoeFjKolu8BiozPZ2sQ/fryU0ixFBi?=
 =?iso-8859-1?Q?IHm/W0GJ2ZFBn360e9In50IUK+/eqoFIXRnqYmHTtbb4RhRSxlM/NKm3pR?=
 =?iso-8859-1?Q?20BndVTMs7ke5nTnRdC4ooiUVdcCLNe0u5b4DRCaWTbK1qpPqnR8Qq7+9p?=
 =?iso-8859-1?Q?Kg1mhEXcRJcmMJS62dmDmOpk3cnTf3nDfXc1n8JqFIoD9rSE7Qls5OSChz?=
 =?iso-8859-1?Q?oPzKNqj0S4BfI7f0NYH1fIw+O9O22Ecxy1Rp4dEI4FZGz8QLQf0miaK7Xk?=
 =?iso-8859-1?Q?cxnwRlLhQVcsKk2foRzkh/vpehX5ViyGsxf8uUCAOTnEhNXfNqBH68LOyc?=
 =?iso-8859-1?Q?bHDlgVq+kLJ4e8fppwCsPBsbA12It43H17RCU2DNBK1vlyCb9gAV+p8aLd?=
 =?iso-8859-1?Q?JKM+0DUZGWFV/jSlHLCqHUdcgERPtr91Wd8ZevKigC/wZBKX2xCwIdEPBs?=
 =?iso-8859-1?Q?j9MrLPAYdT3hFf0XJmBDWV5/jMX1Ebzx22Zf0Bs9dAiDgGLB7b2AJU+eDO?=
 =?iso-8859-1?Q?7aUUSCcUZvAgeSqK0z5c7N2V4FaejTuRI5h7pwHvZ3/D9715l2sMbhpOn5?=
 =?iso-8859-1?Q?Jq/ynGCvFlltkIRgUfSJM9bpsmTAZJ+SWXSGDDdmr6LQxHFlElklFQLZep?=
 =?iso-8859-1?Q?h4ENWL/KbOvqblyTDFKkc63XxylxhKgr/2sMs8wJKcqFfoXPnKMC2D7Bx6?=
 =?iso-8859-1?Q?SL+wEATJUIer3uvZQ1vgKsmDlhDy2M5hqosKYx5kO7mX/sh885wY9mVV7t?=
 =?iso-8859-1?Q?1C3kLhTGfIDXubp73Mo70j0nYuUF4NVTVf80wkalERcNh5nNNhKe+ShF2U?=
 =?iso-8859-1?Q?n5QuEfO9RvhHxkW2mDmKKNVECZV/EblXfBWyWj/XAk2crBdbj7T+QqP5n+?=
 =?iso-8859-1?Q?7EM3rUaj2AHZ7phleUU8TrxVw8yncOvq/udgdhCHgYWnkNhwhDvVP/96h7?=
 =?iso-8859-1?Q?CVqEnKJXPvjj5X55e2ipebT+Q6BF1vSvYSrKXl9h4AfFfogq97iNnPF8pw?=
 =?iso-8859-1?Q?YmuZBvuCjnqcTpexTFnvDXxU/u8LHZwkiXKeSRLhzEElI1C9ivfhEtJeCy?=
 =?iso-8859-1?Q?eZ+RBhBbioMCmBk27mbqUb2DpixyO7gNOj1YecGrUagHTT?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6750e1ea-d0b4-4cab-2b0a-08da23c19579
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 18:05:56.9284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBdXzQ7NRwD+yLZ5oK5y9pksYp+19O5x3jBmZ2lZiZ9irdrQ1gooIRtFcKdoNg7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1496
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: zTJa-h1wsMR-ny8Q_wTDkoGw8MBe5flp
X-Proofpoint-ORIG-GUID: zTJa-h1wsMR-ny8Q_wTDkoGw8MBe5flp
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_03,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=957 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_110617_808118_7142F2FA 
X-CRM114-Status: GOOD (  19.94  )
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

In nvme_alloc_admin_tags, the admin_q can be set to an error (typically -EN=
OMEM) if the blk_mq_init_queue call fails to set up the queue, which is che=
cked for immediately after the call. However, when we return the error up t=
he stack to nvme_reset_work the error takes us to nvme_remove_dead_ctrl -> =
nvme_dev_disable -> nvme_suspend_queue(&dev->queues[0]). Here, we only chec=
k that the admin_q is non-NULL, rather than not an error or NULL, and begin=
 quiescing a queue that never existed, leading to bad / NULL pointer derefe=
rence.

Signed-off-by: Kyle Smith <mailto:kyles@hpe.com>
---
drivers/nvme/host/pci.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..2f7510938b18 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1772,6 +1772,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 dev->ctrl.admin_q =3D blk_mq_init_queue(&dev->admin_tagset);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 if (IS_ERR(dev->ctrl.admin_q)) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_mq_free=
_tag_set(&dev->admin_tagset);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->ctrl.admi=
n_q =3D NULL;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENO=
MEM;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 if (!blk_get_queue(dev->ctrl.admin_q)) {



