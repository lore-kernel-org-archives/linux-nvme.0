Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F3DC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:35:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A3A61003
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A3A61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/mdw5MbQ7h/ZNDTuhtGnxU+gY4WxsRvlteacn2+O1Zo=; b=AeT3E4kKpcRhaxIuFT63sHmq2
	RM1bRaxMVx+ZK1k9QfXa99AKtdAdTXfMLilvMqSRAxaEb7iKMrYV4NuaEY8TnDmeK4nvXqA6c1Ui8
	7i5F5vneZy5AZYlMTVfxNAG82ndpAbupbAozx5cRBSKWnq2JKkEao0IBf0WwRB3RS/jT1KK6WQoKt
	SqVaLMXG29YjX1SDBY2Cs1ejVa20Wsaj1bLOtRRJyytT19OMCvXQJNzoiXvXiPlsGZs+8HgiHhpkL
	tMItBjC/qpLbHElwkya+ztnIdlvvWT7PLZ8FHlwgGRHfuwDjLFpSX8V4aHWza3xwCFJFPfuORB/Ro
	cYHdweOxA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUgzh-009jSP-Ce; Fri, 09 Apr 2021 02:35:38 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUgzY-009jRK-5n
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617935728; x=1649471728;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=P/5QEg2XCJLsBZOBupq5681EFwAlFMafxvzM5zX38gE=;
 b=R+HP1sbLe6Ho4N0YHwPYQEzL7mcQG7ObYXWUhHlv8cpzR98FNxRvdciQ
 W9/6c9UC2ejzvDM0lR/EIOIcqb64wu5gv/6jMn/Fz2iYiHkU0yOD0rvYJ
 eCemZDtRAKHAMeeSJ5KqB64KSd6J0oJIKD0823nQcojUFwhwEtwS08Y9e
 8Vc9ZJSJdPsvTPtmLnWZ1MqN7ubVh1hQFxzY/XZvbmp00niyQ8WsLRDjS
 huxaC/RGKK6R8/AGoVx9uoRY5Lo1obkcXgZGRI/hww5xBndzMbgskJQuA
 eb4qV4KYYIqPpUNU8ZMCbjwILoQcyn6yIctN7cV3PqO0ORZEGkb7fDvis A==;
IronPort-SDR: aK6QN0Ut9NqjECdD44oo3rGqB0gP2tws5KV8LqbFjXsKX36rS6HHw/Hl6IKXidG2RNYFWm+dzP
 0PZALP3nkv5dt3QrJsmepe+iaoyVnPKGQ45Gr07WCxGlLr2PYsZFkgpYyuyaOyK2Crs2dL2eon
 qKDIunqFnkb6R4AJt96e3yZU7+XbBFi/90v7DMvlb68LMg0eN4QvGSIrOA4UzCLaOtlR3RaWFK
 JRA6oiQ+8+b05D5861A2ZoUGcKgmoolxSmGQecvF+zfNaeDUAueXCVGYTX75Pq0LhUAP7vK2Py
 sdo=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="163962905"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:33:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELZi68yHi9ebvaW3PG5cwjzQm4RjzdTglz73oYOC2wSj8H9Hz1iyOeknPfHmv4SW9WrinTieeHUKxaZQnckgnwbq/kTyh/trWjqkMDKoWyBNmXETsNtAp76sXrA0vdxQeOiFKTbd7LhkzNlaq2M2YaB24ljcOAuHlYtaBjyF/khSlpLW+hwXo1bu1h4ejPQkSi9Y9tynzIhfMSyB2OdrUpywacU/x8W9grp/oO4IWTto79SCdu7wcPwm/mcvzXrx8YP7Dx+5FOnune7UTwhojtf7SgLad8hy2RGav+m6VEYVtBvM4aS5rG1IZGZil8lc1ao0HrOqwW+TR7wSbZlFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/5QEg2XCJLsBZOBupq5681EFwAlFMafxvzM5zX38gE=;
 b=EwYiqSBESRjqgtnU3kwFLn9dm/yblnPUqw7SURztupab+ZcVd4rw79GemeAVIQfSZ3/0l6ilM9czl7UE6MGizNkUCCJ0dEsPpCmSe079X8h0NbM/RP2JJ6FA1EgVT7YNOurLVuvR9b1LubRRBVxMuHkRoHzfQQB9QxWZmtmqWY+niUczvhxUBCsLKXCbKG4Y+hupeYj6Dnq00hisundC8cyQmN2mwBPrhLMvuv5f7lCYESf2XgiQC706/DCrkHAu3wloe0tGB/KXa9DGbsLD6Wk0/odONb5/v+1UvmJ0L30tF+H/RbO5pVdD9g5BiQh5lW5NYrU5UaRX8s3qhPyI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/5QEg2XCJLsBZOBupq5681EFwAlFMafxvzM5zX38gE=;
 b=yHjSpoZpjVeKOZbEcrAZulzrBvb8kKBdcp0+hZb97hYbFYFHVvYBRxWlQwo0A9+zTfyuVpr7Nt7XMsJG68NkY+HsRqviEjabNApX944sONiM6E2vdES8/13AVg4+7df31UjFPK0cKDJaz0YQ0CfKG2YbhOx3jmdVKG/EvN6F64I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4040.namprd04.prod.outlook.com (2603:10b6:a02:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Fri, 9 Apr
 2021 02:33:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:33:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/13] nvme: add a nvme_ns_head_multipath helper
Thread-Topic: [PATCH 01/13] nvme: add a nvme_ns_head_multipath helper
Thread-Index: AQHXLHHa3pjewT/QNkysnbUAe7Ay1w==
Date: Fri, 9 Apr 2021 02:33:43 +0000
Message-ID: <BYAPR04MB49651C1AC80832E9FBF2B37686739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7286d405-500f-4b41-0f30-08d8faffe535
x-ms-traffictypediagnostic: BYAPR04MB4040:
x-microsoft-antispam-prvs: <BYAPR04MB4040330352A111BFC5E8492086739@BYAPR04MB4040.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IV8uU/ftpvy12nTK3nL5dq7Vn9WmHNkTtOjTIPG/1dCNiD6HUMm/RFmJeNT9ZNbvNBO/8sbQRo0cEM+oXemHtoCobz2RjVQBDzUkHF58vYCLwdKDUc60N9b+xkni1N1fk31fnNbO2LRvxa6mCgQLVSyrmN3d/m9u9caJsF64OAPQQGeVeOkIBg/CNsCAp5Z+wSrkGmKoidmmr/CLtNaxf8MQC60o7OMC2uXmwE2y0miaeM1riHlJLs5uN1sAALyxEQ0T0NTapUc5LyhyilJJ26Nq+GLYWuhaqjHj0ZFMZCJbDc5Qx5I0F2BrjLNIa7hP0tNnczmPOzidGG6YziohERfa87t/y9uy9nvBJOcxQvB1nItAy7VkI3H8wXJqmW32QZ2Idjl89mQHhW7KAmm//igjt+zfmZgjSF1vCpD0nol6Acew+6+zXg4MMdawrzAHi7VpFbG3SKd4KrxxF6Fl7jrbWhm0L8X3/IweMmZCUPLQN5bd3HGKRZyBZn9DoZFw8w3d4UzbmZ1AT+nOB8nDGFeszzHLznD65vPL/fxmpHCREaxu+4Q/DiBRstVqmjGfOwCzABCGPd16xW26wrODmhIJXgifEiOj9mrl69qvfcCc8yCzf0SEPkMP0TGvHdNTN+PutMDKE5UrVnVUHxHGxFq66egX9EozL/Te1/e2Cxo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(9686003)(33656002)(55016002)(2906002)(71200400001)(478600001)(4326008)(5660300002)(7696005)(316002)(8676002)(86362001)(52536014)(8936002)(54906003)(110136005)(6506007)(53546011)(66946007)(66476007)(64756008)(66556008)(26005)(38100700001)(186003)(76116006)(66446008)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LANQ3RkKbvwlnOyV8LSfQgIF8pDsc+z10QXLWM99emYWxXkbPO5WV713dsod?=
 =?us-ascii?Q?ki67yA11p6AugZqLxa0NCafbmSrg22hgOnqvksHIQMxjkBBmH+t7SjDtT9Xi?=
 =?us-ascii?Q?ePvGPsFHF39Tf84e5jED7BtlEiFDmuaHYVSdK/nGQjpWl3e3VMIckzkyWFwG?=
 =?us-ascii?Q?161WsHKXghRAmefz9qt0EddpScseDvDWQAIYQN0B7KH/wMRk3QT/uptd2wjf?=
 =?us-ascii?Q?gBT31/gATyZH/x8IjhXjpNfT29Ep3UkRwHHhMNfj/jG+x2NLrhPuOvnKlIdx?=
 =?us-ascii?Q?Rwcb4KT590AHCXlSSHffmHOnNA/bKZag8ofueQutMAnSeFHEXlGYmNa/oExL?=
 =?us-ascii?Q?JSADLAXXP7f085yf9EacOVzwDBm/VHsiq08urWCpzHBS+rAGX9q7iqjcBx1P?=
 =?us-ascii?Q?Rv7hTXfx4hoKEVCEBSQ9N3I4GF1bjHvcMmQkuPUyOfHRxnyG7HTFwPZD5VoP?=
 =?us-ascii?Q?gYh669iDKlt1KfOefH8w3sMslAC8pmtmEC8l/A052dkacxuMd/HhKJ1c6YqD?=
 =?us-ascii?Q?oVc0Sefgj0FyzOJEdxphWrcpIS8v1XcoAsia8VkUzi1Iat4DJxZTWIibjJy2?=
 =?us-ascii?Q?ZKz6h/wyy4n+uZVtDmpJxkGHJHonxwize6smuUOzM1JSAgm9EIyYWVNhTgA+?=
 =?us-ascii?Q?5lIk8v5WH4rv34rf4YJWYkxUNeZxHPdMnzk51QOGVcA9hTmsayDTHaoTImCa?=
 =?us-ascii?Q?LTGCuc30ngm0aXRH8t59g3m1jmyfhOq8HYtYpGyIveCkzOAyqstT8LDuPabn?=
 =?us-ascii?Q?ESL02DM9Q5avVr/CYBoFjS2ow8ThGGpGSf+VutXiSPuUGKwmRss9S5yS02fG?=
 =?us-ascii?Q?ksnfgmrwr345kaBNaB+Uj4IhKjzM/Cwd+0yo2m3h4gVRkGdMOBckuWwpq7/S?=
 =?us-ascii?Q?sJTNMZJVvCW9GhZ0jk0QUIb/ezhOH8Wy3fYP6MWRIdbr3CFLbSCzV3wwmCRp?=
 =?us-ascii?Q?UD1dHJRB88pkBwBWjYwi7y4UgFFoW8jpb0aU+FLxbWs/4WhokBDX7hxUWNcG?=
 =?us-ascii?Q?87EtE4MKYRr12q1mKJiMpzwU5+Y2SEW1PH7yD2S5+w1rEKtEBfa/E5lNxAe1?=
 =?us-ascii?Q?Pt9DAzP76n9PluIu4bQE9CE2APTCmtCufoMjiRiHK7fBYIFkLuAdtnIcXCDQ?=
 =?us-ascii?Q?z7j58VOoTVU+A6T49aJoUedYSSrd9mMax+9kLkO9AbyN5xz9pnVjIkX1qHjk?=
 =?us-ascii?Q?VLHDZboYcmG8w/ZeSHn0mxTNC0dNF35NuHWE/lCkY/6vvRGeof9XEaM0Dbbg?=
 =?us-ascii?Q?GZYQfe5t8PiWJpTWdg+nQOMlDlBMb4jYQV+L5RdiISSOMZ4COjvA0susqdPS?=
 =?us-ascii?Q?smc946lTkzu6XNLD3xpMSNno?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7286d405-500f-4b41-0f30-08d8faffe535
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:33:43.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuDdT1N+zgg7nNblswZ8lCS8c+eDMyRZwMdCF8/FqJqNfJVS0gVC1audM+rH1btw8dIxI7kkAGijok9YY0q8vz1aKD2sBQE90CzY2lU2J6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_033530_169146_708FCA8A 
X-CRM114-Status: GOOD (  11.62  )
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

On 4/8/21 05:22, Christoph Hellwig wrote:
> From: Minwoo Im <minwoo.im.dev@gmail.com>
>
> Move the multipath gendisk out of #ifdef CONFIG_NVME_MULTIPATH and add
> a new nvme_ns_head_multipath that uses it to check if a ns_head has
> a multipath device associated with it.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> [hch: added the IS_ENABLED, converted a few existing users]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
