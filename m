Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E15B61153
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E15B61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4IEsm13gmsalqu2fMygDoX/JDGU1O8qurF0pBt3vxQs=; b=j02LEb5j5cbu2a
	8YgAJmfb0r7lM3OWRdZZTq8koQurZWOiIVvh9Lx30OP9DAn/6b7LfbteVscsWWwh3tg5RpqmwNvjU
	+h6zXtBhZmJs47/0SpZYw3XEBONgizLFLPpN4EZT9Q7pa8TZ9OY0YXMWDn/xBjUbwNDl9JQvIdtBX
	5OYKkukLIsRn+gvgsXQ2JjxEPKn2tMBChyXGzuFOkhyssykWYUKzpEh4YeKuPphVtQhDQFQSXwwLN
	D9pBiwE2fQKOf9XQY317UdJt7cnIkiKmFFmmFb137eY0G4dJxebZhTkEl5fsDk1gz7xbiuxu1REvU
	C6YYCAmkHZCBNnO5DldQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2NE-008dWx-Vc; Wed, 22 Sep 2021 13:33:21 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2NB-008dVd-5M
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:33:18 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MD2J6A013127; 
 Wed, 22 Sep 2021 13:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EFqESEs0Cbo4Hoa6u0up5ADvfEC9+mbeTlD7OZuIOkc=;
 b=BeqgX2HZB5hyXDXyqF1rWlFFpNYPpXu3Eifwv+MtKrHTD8K9wMNoYQqH3TlEmxR/MssN
 LbhOal6O1MaTnPfB//DWROSa4jvGLUeit9SYLMxzEH6RiRa8YRdbNV94+xjl/qhqALtW
 EQySWIOn1cS0QsUpyKXR8LGH/YQnQv2dn/xTXw7II18MmXtT81aeB9UH8kZtwZ8SHO/V
 9DMaf9ARymTJiOJ1Bj5mnHGpfsSzKR47L6kiL+L3j1l8zrsvEoIDtL4XhV5lDkdan5FP
 kDo+SjcDB5/CtRgOUCbEXIXc91klp8F+cWpQ0IyA8JE32COuUGu9/9WAZux88GPZvEom Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4qkv8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:33:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDU2DG019970;
 Wed, 22 Sep 2021 13:32:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by userp3020.oracle.com with ESMTP id 3b7q5w7guk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su1+fBmGT3HoQXNWaPRnEkJTGh87Gvs+GYN+McXZ45B4AWlmc/ALnMBKj2+1kXInNIC1T+YdOeEqH6JPU+DtvlXeYr4h4v0vtZnrheGBINiBO3y4q56XEnXDoFn1610pSU9DpJkbG0Og2LyOgunki+Yrnd2KNLkDe8TugI2Bd0AAxiuvr12+V696zxxg18zABtTrvnqyWX+9WeTSUK22d7C6EYXQMMTrqD7yv20e2y42lIj/8+rkuMYXHapMc/b6SEiwc+tfp7e7DlZiI4jTicmvsvJwJxG4BQyQUSQqORTZJLLquGJTWvXglRMp33k+lko3tWLW9ojBq82p3mWiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EFqESEs0Cbo4Hoa6u0up5ADvfEC9+mbeTlD7OZuIOkc=;
 b=QsoRe8XOEkAzn4qFzqvdADrkf8NwWoxPYNahP14jSxqt+Th/4YIDBUz8LymWrFGDerRUiytH0v54Pm/MzX8w/8PsEVOPQI8kFgVegi7/CXJJjBomFjO0ck160q+h7PoveMOjRoD5e8I33/anmH0LRrxGOuzBHXp7Z2MiQmwo0LobJMwDywY/AwlKdcg6i+GM2ViLtA1h62zXtQfAc+9qQtIlTh978HZHcXGs2TXBJgb6E5waNgtzREqXk2oDGepjjHMG0IcMIpelf4qM05K84RZED1lpgbRr+vfC/UV2ttfgBVr1WXOe3XUAvBwHknFVOrmYgQ8zYTFVYZss9XyXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFqESEs0Cbo4Hoa6u0up5ADvfEC9+mbeTlD7OZuIOkc=;
 b=XovwFI/bbRRK77K5iAveOCvaqrG0VYaM4cRaL+qcGOH+ZYm3OJJcFFZ+27sJisBSn+diwHEKViPulbA+eFs/Nxl9+weRAWoMCQmOH9zjfW1OyjNlFyXI6teck/3evGcOpZi6dFK7S60zzaJgSq9B7J4YSD6yp5Au4PNnX70MmfA=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA1PR10MB5510.namprd10.prod.outlook.com (2603:10b6:806:1e5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 13:32:53 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:32:53 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/6] nvmet: make discovery NQN configurable
Thread-Topic: [PATCH 1/6] nvmet: make discovery NQN configurable
Thread-Index: AQHXrv1q09iGR2BtI0Oy9xJfeR/ubquwDrWA
Date: Wed, 22 Sep 2021 13:32:53 +0000
Message-ID: <13F8510F-E2CB-41F7-B620-E5944493C62F@oracle.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-2-hare@suse.de>
In-Reply-To: <20210921151529.29419-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af565d81-ba51-4a04-5505-08d97dcd7af3
x-ms-traffictypediagnostic: SA1PR10MB5510:
x-microsoft-antispam-prvs: <SA1PR10MB55106CBFE6E1FF81888AE87FE6A29@SA1PR10MB5510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnE/qPvfdmPEYwvkuC6wljkvqVp3klZLA0ooHGQW2CibCZehaRVJ7q+oXO5xUA6VHv8+Qm2vZlyUtQ8zSGt0oXsvORd0kdd1gVIekjpy7fGmndqwWb12i6yYTAoEzjDGpYIs6G76SbugTwdGl3mwQHCZ/gaVsbcoUMkCVqNUeOWM6OmTYsAZTzYcGlhNH1rw2YZqHkIbyKkhMIXBDUmaKcWKAU+lBTcvfLPpywtpgCHVQNumC0QpOw3S+1PiumWKAlRkmFfmcagNcE1Ro7hx4soNn4evyiziJTlvGFS/ff5VCz2arhPGKXTZjKYVq7uKiFWwGrdlTh9cmFE0Ava/W28NAlaVzikB/AkedKFzDDPGvSUiIuxBVvuNhliuWlkbbbmQlhm/n77OoWt6wTVcbH8anRU9ynLYu5CQrX6j+lYedcjgeT+N78YM4G+YazmYW57QMsXk+iX0SqGZSCZ+7jRwEe7n3Z7M204vaU37uGCrq9xtXJLdeB/ylC9auPWakjaTpGt1oExiXvJ4EOzQRSj1bsqAB44YI0HOU561OjL+nntG3n1KTUKHCHyQ8Soy7998dN3BggJDtEfyBZQ4uONiAg8fIIlDAuzVm0mJYqiSBLq0oBDM0LPijv6UkUbzYNNSrl2KEW2l++e71IWWtspnwmOH02JJ6281lxPV3eHLh0ycwA7cL8fV8TGAHAcDlYo+GCar3d8dGydYeolKdTqBSr6Vnh86poECmzyrJMtigZcpGXhhXmVuaoxl8IzGZVdv8KNLNkLVYGUWstmNcqdRHKMuQeZbyH/b1wYEMULK6bFX9ZuSzgikUfJhIGtp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6916009)(186003)(38070700005)(26005)(64756008)(966005)(8936002)(6512007)(33656002)(66476007)(83380400001)(86362001)(66556008)(5660300002)(508600001)(66446008)(6486002)(4326008)(2616005)(44832011)(38100700002)(8676002)(122000001)(54906003)(76116006)(6506007)(53546011)(2906002)(316002)(71200400001)(36756003)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rg6EilNlQbVWKwLekPJIGxyMob1m0hGKp2XGdMynDYAULM+dlP8+y+7dX7AZ?=
 =?us-ascii?Q?j+kT3p/V7Pe+SB4DGWn6lqRqqEITCzs1C93wAgCw6oZhOg/lZ2Ju6eXCP/Ju?=
 =?us-ascii?Q?xRVWvHes7rW3XcsPrqXjzDKLuzr1QXAn4dHBW4z5AoDOkovxzkJjOt1eUvjs?=
 =?us-ascii?Q?d7zK0uPkOiyCEevdrnq62bxOMGoN41UGmIhnMz1icHzDABgn+HRaTDxkLjwY?=
 =?us-ascii?Q?TvPAnF2ZFrgAGLl218zmiUMIwNivJWOn/rf7Z6EFJwPtcuhAG+KC+RGcsGht?=
 =?us-ascii?Q?Sm18YBSU1iRXJ/RRnKYiJW8XvANDN3woEsMY2Ej/i5x1eA18OmLrlvI2ZnMg?=
 =?us-ascii?Q?ywOUc6mwnLCYPqet+lUpfzCE8krlfjeoDlQDIDAJQJuyCa2RvCPkuh7h4MYo?=
 =?us-ascii?Q?Ofx91xsnxobXwmPlZfzIRZbZy7iV900SNefryrXfWAUa9vDlxmS2IsUPgOFX?=
 =?us-ascii?Q?j9YrWwg6yuxZvsfGezRgFhGTaCeBCMszhjTpUM52VRro8Oh5aEXqTkQT4pqC?=
 =?us-ascii?Q?6knSUhcHsx3D9HmaTDi121CbTUHqe5tj/9ozE5bWYtoIG/RLvQxJhAd5uz60?=
 =?us-ascii?Q?ouKnMO1pvFjReO4nzyXdKVsvFTRhx+J538kkMlRqVTDb4EibwET2tVgMkm4O?=
 =?us-ascii?Q?QpIuOqwXjCwVkO3nOSQzOUnBHj/eGDNsZUgh4m/Mo4RyL2CFc3uwoN81L14Q?=
 =?us-ascii?Q?E3sLOEkNUe/j3E3LOfo6est9+iuaRIVFBETWSqPNw4GpIOwkfFVu+ZURzzFJ?=
 =?us-ascii?Q?I/zB+PuSEWDMVblO4CCQLEwX1S8D4wZShr4LlT51DnwtXbX3VRl/Rs9U5Mlk?=
 =?us-ascii?Q?zvWgYwYsgE0leGG+6Hm77n//QbKXfiuFqLxubsbuIxgVFsh8SHkzZUCwI4qJ?=
 =?us-ascii?Q?hMr4UEe5Soq4HIEHML0PQlX5/2wQNAGB83KcJsTOku/Ym6ueI5A0JPRJEKzP?=
 =?us-ascii?Q?315foIaCuWhNbSHO55LhKW0GGAUCL31cLiQnlNEgU600GB5RNyKx64uAUOZk?=
 =?us-ascii?Q?pbO6p8Oula/mUEOsYdhPPo4I7UPmowTurEKsdkDkQqF9ndhI30BJuHa8jeed?=
 =?us-ascii?Q?r1W1QQSS0RjuLvHM81FxIxk2WowwGsdIcANnCVFRTbwy3tJhQboNNuXShGQc?=
 =?us-ascii?Q?QCNJf1qluLzKYI0pSlX7p3ubS6Jj25PgRTD6ORunvwsJfQTLLyThNpvX4naL?=
 =?us-ascii?Q?Y9lAjInKLuV/nRE7NfrTW8rtF4FsZF9cijHX+43nwhZVGzdukZN9vm1H8Ham?=
 =?us-ascii?Q?CyFS/7rZrL3QEXC0HOJsVbBJ2B60f2T2uHUpRZywvosf0Z/7jAcsUfyzF+ss?=
 =?us-ascii?Q?wKWrmpTbMrdADh7vy/iphcXKQq9MZo10V7XruJnmCFN/ew=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <104C3E45A3142E46BE2ED93A5B2C90F3@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af565d81-ba51-4a04-5505-08d97dcd7af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:32:53.3211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/QfK+Md2LGZCfvCYwGmQfKTI6YRhsJCHBX+t3pD2+bIfYfxIBOldBTXBE/nbpwSc9pyncTkkGmgjuJ3pE3ACZW+v1U5Re/LybhHENkomvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220096
X-Proofpoint-ORIG-GUID: x1eUSuZxzjQjTXJSR_HnBh59KXq3lSlQ
X-Proofpoint-GUID: x1eUSuZxzjQjTXJSR_HnBh59KXq3lSlQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063317_369783_E9360599 
X-CRM114-Status: GOOD (  30.07  )
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



> On Sep 21, 2021, at 10:15 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> TPAR8013 allows for unique discovery NQNs, so make the discovery
> controller NQN configurable by exposing a subsys attribute
> 'discovery_nqn'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/target/configfs.c | 42 ++++++++++++++++++++++++++++++++++
> drivers/nvme/target/core.c     |  3 ++-
> 2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index be5d82421e3a..d80717b9779d 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1233,6 +1233,47 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
> }
> CONFIGFS_ATTR(nvmet_subsys_, attr_model);
> 
> +static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
> +			char *page)
> +{
> +	struct nvmet_subsys *subsys = nvmet_disc_subsys;
> +
> +	return snprintf(page, PAGE_SIZE, "%s\n",
> +			subsys->subsysnqn);
> +}
> +
> +static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
> +			const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	char *subsysnqn;
> +	int len;
> +
> +	len = strcspn(page, "\n");
> +	if (!len)
> +		return -EINVAL;
> +
> +	subsysnqn = kmemdup_nul(page, len, GFP_KERNEL);
> +	if (!subsysnqn)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The discovery NQN must be different from
> +	 * subsystem NQN.
> +	 */
> +	if (!strcmp(subsysnqn, subsys->subsysnqn)) {
> +		kfree(subsysnqn);
> +		return -EBUSY;
> +	}
> +	down_write(&nvmet_config_sem);
> +	kfree(nvmet_disc_subsys->subsysnqn);
> +	nvmet_disc_subsys->subsysnqn = subsysnqn;
> +	up_write(&nvmet_config_sem);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_discovery_nqn);
> +
> #ifdef CONFIG_BLK_DEV_INTEGRITY
> static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
> 						char *page)
> @@ -1262,6 +1303,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
> 	&nvmet_subsys_attr_attr_cntlid_min,
> 	&nvmet_subsys_attr_attr_cntlid_max,
> 	&nvmet_subsys_attr_attr_model,
> +	&nvmet_subsys_attr_attr_discovery_nqn,
> #ifdef CONFIG_BLK_DEV_INTEGRITY
> 	&nvmet_subsys_attr_attr_pi_enable,
> #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b8425fa34300..88ed746c675f 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1491,7 +1491,8 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
> 	if (!port)
> 		return NULL;
> 
> -	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
> +	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn) ||
> +	    !strcmp(nvmet_disc_subsys->subsysnqn, subsysnqn)) {
> 		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
> 			return NULL;
> 		return nvmet_disc_subsys;
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Agree with Comments from Chaitanya. 

With those changes you can add  

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
