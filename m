Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B9EC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 21:33:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF67D613AD
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 21:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF67D613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=0xTzWRzJF41cjq/DZt8Ye2Qv8TEjN+FNVxcKoXaEthg=; b=CE3bTEeme8wmepODg+mUignVGP
	gSqv0N7JSQaI+/qAT6EWzAX+Wu7uXiB1aA0Uockqgp4DtNwSqByoVWa7DBml9KQuubf8buM8QUVcQ
	Hhkha5NVPiF1Ic4ywEMS1B1AZwogJnjaWyuyAr0eBlXnBp0l0+83n9YmFLQeRD64otzO2IdlZeTRx
	gGEXSMnTTjLkgkg79lxPv22+4bf98JhdcoSBlwKdaRSOPDShk6G4kbLEZ092hA8M/+IuFxm/fGFAP
	LhiWlBQ+TE6lCiha0/1yxEdZ6o00Z7yl17DZ9rjkEKmZw9VsvbVkywPt5rC8VIidyJbuBxHmQ2hH0
	YDynefiQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkClR-0019hi-Hn; Fri, 21 May 2021 21:33:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkClN-0019hQ-Ni
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 21:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=EkzDFVylFZBjRLyHZ0gdT80lH5PHqAh67o+Kv5PgVbU=; b=mejEill6II2PlJdqvk4BjGOeUb
 fDpDg+BZciOIBXpZi+nQcbphNJ/X5ZW+u0z69cnroRr0I+a2+7X+MJblLzDbtH9Wi9AIUy38h4kuO
 kfuqNZRdZ1f2O+vh9TAYeNWvog5DELQbTap8Xf0eYsxT8wgC3DWhuhtl3Wqsp+LZsdgFsutlCUSjj
 p8gAh6ScmE0OPq5mmbbHYSelaeE8X+qP7Wv/VTxeMg4i13aHxUSwkt0EbeVWoo/8jTpkMPluzYdb2
 nQ32ZZrVvMXqXiwZ9tj0bj1EG+3N6QKkAjHrJ7oVkuW+SbgWT5aidJ5rJl49T+6YNjQRR8qQF2Rr+
 KVv5qwyw==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkClJ-00HRAx-Li
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 21:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621632773; x=1653168773;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EkzDFVylFZBjRLyHZ0gdT80lH5PHqAh67o+Kv5PgVbU=;
 b=IV84Boi1Dsa0XVs1wiHoijl2/N+pAT/070GnkQ9rOo7+HwuovqJUIA/5
 78vc7PilsZuerWU3EkEPwZ7hcbBi32bzQlZoLeNUZH//bwVhmufjPODRA
 9puQVUnaXVNl2xZV6bzeJeoyopY95QdPRZCTsB9ssfcdUK/X0zfC8KWR3
 zc+Zp7o/yahB+t5vGHpP2I+sivokO0Q9Daer6YdwIWvdvobr5KNRkZ0F3
 YH0qWLMMdz2Sl3iAL+y6vW7yBgzEcb+akhE84x4XF/idPMPyzikbvV6s3
 fczYOXlclTAzVau8PZtjNmgaqne46ZSZPYSfZ1IxxaUXkrXnmgHd3xViV A==;
IronPort-SDR: 8BUtLFMWFNX4d6/kcTS3rCSDIEfYtD3GXtQM8MopcxWt7yW2G1ZIjPDap4UEMhjWEN9lwI8LgH
 X1Hbdm5dy7UuS3s/oGcGwk1gb754Az4oR3hriY8+DsX3AbH3PxYfK9n8c+1sLBUUPh394se3bg
 tzPYt3hwFN5ZzvBDnzv9Dv1rkdDItWeNPnYOgdD1WGNKn/NBLZGytha/FvdioKa4jAgAPF7tK4
 H4LlztAbXOqpvVXitrijGXW5YvE06acAEkZMLeRzvkOuHPQF/lu17Ji5hTxwFl8rEF5jaZ1irh
 WhA=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="173704691"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 05:32:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyWL21m6NfvQWZh7jHB6za4Z+DWiB4wR/TvvJ32Z7DASbub1/r3rNFdUoR3mNmdR7htqQIA4ZhKQIHVDdgemoCx44BhcHu2Wm+bYADlLVXy8IbRs4E5PTh56J2+mh7WrcorDNdeEIrAfIAOrvKTQx4WqAgJWyA8NMrCUm2QzbXsWrPYqeOQPjFp1JCXLKBqYLKIhniCtIQuJrKfqD5rwib7Oz+WSiQd7it17XGcl9TmCSJMZGm+NvU6zJouYYtY5/C6+2GaPiwfKF5XvMyjOB3tHtzG8atBtaExYTLYxmBBfg9m31kxnbjM5bWPysiJE6X/WpjVe0NZyVQmyIyF0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkzDFVylFZBjRLyHZ0gdT80lH5PHqAh67o+Kv5PgVbU=;
 b=m0u8bNTixQKvOu80vkItyCLHZ6+Pv6MTYjJG3Va+CL7rXvVFu4PJv5VfDJCsbGptTWDqse19uZ2pOIFh1injTC6GqIp8RrqKMyqQ4V0vaBjPWYMw7mcQtXg0ER7xU8vVfaz/XUfqNme+11YIJlxXTqrF+TEmk5r3yzq4qM3UNbs8hUGZ35FHoXAkURMtyODJz8bhNT7BxmWIJB/01W6G3kaZwsSIi49PYE0hJ7D447hAj3WrK644Vrrn3fAWWQGkRlpFRa1fQgpUOAVVfGm0+cpcMaFTad9LaNVMimEA2kk0N222kyUNLnCOhOKeNYIzANCy7evqbn+RIoWz5eioNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkzDFVylFZBjRLyHZ0gdT80lH5PHqAh67o+Kv5PgVbU=;
 b=MAE6DqhlsCBJcTqwUMaYFUK5F0DV/4udoAS1JLyvnDcnTjiPoSirBnbHgSV+lxsmUE1mdGX+KsY6ADg5rW/Z5CjatEVdFEa+KO5bEny4OsQU12sLLYCgLDt2YF3WQ17fTfsuVyC1dRmCrzYP45kD99NY+BL03kict+VE8R1Fjpg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5832.namprd04.prod.outlook.com (2603:10b6:a03:10f::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 21:32:50 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 21:32:50 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fabrics: decode host pathing error for connect
Thread-Topic: [PATCH] nvme-fabrics: decode host pathing error for connect
Thread-Index: AQHXThub1ZjomksqKkm2v5FJAWVMVA==
Date: Fri, 21 May 2021 21:32:50 +0000
Message-ID: <BYAPR04MB496534B795A93E8A66B33D8586299@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210521082346.146966-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d5edebf-76d8-4dc5-4d9c-08d91c9ffc42
x-ms-traffictypediagnostic: BYAPR04MB5832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB583245F3A642B369C80BBB4D86299@BYAPR04MB5832.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XuiOIo7bmY/5InV+9BVmtr7XD/mOdW5MRAbrN6RCPRSnWgmi//A8ahUxMd2tJ8G90mgQJQF2YSlk//+79Ur/GQj0O6rNtHz55wyR5uXejEpWGdtpoJhuS5JLe1rEhPnY67kCbHi5sNjdivltJStCRyuUkWjrzpGaJAJwNVxmciUK/QRSP7P9QX/CmpUcgulHVGwo7i6cBHnNg1gZ2XaZi7GtV16yU80LzsnBc+SUU64DOeMvsLAL5/J8R6KXQIGMGU3wYgoCOmZQHUCd8N24Yvn08P9sf4dpNRaF+XSKZDTIZSDIGeatvoRz1gxMm6Xp6LJBTqCx1iSj3IqFp80+aM1bQp+V/UbyrwZPvLsyeNn1OOP9gxIZPcf61dJCUkEmf0nlU5txismlyjGp1Ftk3BOhjeCROmWtydiQLKDlEa3w7DEWCUSn3h3beCoeoFKg1oMmqmBaN2kyxiRkbLP85hPgORCWuljX7wwFtBn/tbKadLuiepUzVrRxIJAlA6wqmAVodBTkIP0hIy2Ng0cdhXO1AzWJsfLqotoYHYTo4l1ylCGysUj4N8UGCgsgPNq33n68V4ceoCA3M/aeFg7SB+r6r++x9DTsB1eGwnbwfsU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(2906002)(8936002)(8676002)(55016002)(64756008)(9686003)(122000001)(186003)(54906003)(26005)(66946007)(66446008)(66476007)(66556008)(53546011)(6506007)(76116006)(33656002)(316002)(7696005)(110136005)(38100700002)(86362001)(71200400001)(478600001)(558084003)(4326008)(5660300002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?legOtLrgsxxJdsAXC0p5MminT35OwpmAqjP/5n1w3FyIAz7CuEyx6OAj2mpA?=
 =?us-ascii?Q?+hXIen45kF69O7JaGWrUsocQaehGC7D6Tjbj6RAUF+/vL0YKD87M+cRrw4FG?=
 =?us-ascii?Q?lSU6uWz8sTUa1Whw2a0gWK6q3Lr19ZTA4RG/FnI+fWDDxmMzAvE266Che+qV?=
 =?us-ascii?Q?PpQuevJzZVLxY7pGJoXiSygba0pSxYjZ+X2W4uijDcNufYwt+Td/b6AS+W11?=
 =?us-ascii?Q?Ti5heGJ02lX8dj6NNynsF6wLsPGDWCAYk7QduoLgkeWr+30GhgsFaACY3Hgp?=
 =?us-ascii?Q?Eo0QVbEYGMsIaUTVYDWHSefbTQlXfXJFivFUJJRPqKz38PDqk9JAxigvfCHJ?=
 =?us-ascii?Q?r23sApwmoWFksReecITddHQdumhKuMtY/HSM5fb7ff4QAnbc+15pYJbx3NNl?=
 =?us-ascii?Q?7A6JbRXxog2b6MzIPkoTOanvOQ4s9akL/2OUQuUTmq9/Zln25uy95kTK3i+3?=
 =?us-ascii?Q?SshswlS6YnNqMKsfuNNyhyOHfGScvxmXegmkkTemiIADhoNrBdCwuM3XRr7a?=
 =?us-ascii?Q?DqzueFXV7z1xpJgqVCLrAn53uUadifLp/c9dFPh0tsvH26ARq+17uT+A7NQ+?=
 =?us-ascii?Q?m/lAbpqlxRaIn/Wsb4E5vsjiwGpsYzF76N5vOWBxWzNAXtHNkkKTsiBH3Y3b?=
 =?us-ascii?Q?oS5Y/TsFYKL/9ujG5ggWk5nocANXnIpXYzMOHb9gcLG2fopZ6in7TxR+J7J5?=
 =?us-ascii?Q?NQr1yoK6OUPC4rAAP0/5Bynf67UbflT+CU0tZgG9fQWcRqXOtNoh32TM8OOS?=
 =?us-ascii?Q?2DnDXYcGafyvRIoVDG4e7nor+JgNBepSEfvxnANtDxIJ8OcdZRm2owODwr5X?=
 =?us-ascii?Q?6/B43aI7jHwGhpKcflgCQ7+YWOYezUnRLnIKhPpQJveTWBJK84V8i20lVwGK?=
 =?us-ascii?Q?bKPs6EeoM3YzuHFs0f5RIHODQ2Xu9xKLtl6VPhB63VYkLW3acAWR7+cq7uZT?=
 =?us-ascii?Q?p+xttF1+GtWRG+GhBjCtcz/CQmiIiVoPJ/mtJpSFSRHyrhP8RD1xhGJYxwvh?=
 =?us-ascii?Q?V0MQ/VggkiFP9SCi8CrdWEsAqxDyPyo3PftjX9hnX8exNUxPDJGXzKMwHRUG?=
 =?us-ascii?Q?vsCS42cIvsF98lO4ajjUw4AXC4F0ecgv/L4cym0WNicPkcXmZfDlCaNo2FRP?=
 =?us-ascii?Q?5alixn5DcZtQP7Zl/pJvxy2C8fSGUlk1PzPPN782Pjt67TrxR6wsRyu5Lnw+?=
 =?us-ascii?Q?IM/phpEK9KeR1tYZ41BmZPMFu85xOflucwHgNZTkgzbvP4MRV4xNMfpMhi+b?=
 =?us-ascii?Q?TGe8S+hQG8dca3QvdxNhuagM3tOR8DsRw2O9cWPf1b313PGy7Tpj2Qu4vvai?=
 =?us-ascii?Q?IoGRhif0Ty6BX9PInrHlFkA3?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5edebf-76d8-4dc5-4d9c-08d91c9ffc42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 21:32:50.5788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bkL56/xl4gbZP4HIaKnkUo2TIW0bksSffYKq0SmoR9qp7QqgmZs1fHhzsrNlTJO5mUKiAqwR6ry9N3JW5xoqKVzr4+2ccpHp+wErbLxrRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5832
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_143253_738894_2CA02FB1 
X-CRM114-Status: GOOD (  10.26  )
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

On 5/21/21 01:30, Hannes Reinecke wrote:
> Add an additional decoding for 'host pathing error' during connect.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
