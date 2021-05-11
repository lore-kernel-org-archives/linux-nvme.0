Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14844C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 12:24:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A56561919
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 12:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56561919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fQv0VglsL7ZXXDo8VQ9qPLSMXujMku01bZdP4nzF5y4=; b=OMrO5/o8Y89PF7pBXV+vayHvR
	KQ3N7u7kzcqNiESeqbj0EY5aiGI4hKA+zHJIYi92mBV+EgyyhUAkKXU7uZ1VowX6ABOd9RfQIl8DB
	oJX8fmoEutM21VKZcCU0kP4BhLC2sY0G9Qv/MSD5mE/04Pn28XvMFLWWRXZlE73JsaHW412kBzEy5
	EVrJZrQZzYK6QV0fsRE3kFhp09qE2Nf0nWbPrwG4tGa5hHd5jC493UaEugoZTStBe4kWvemOnrxlU
	gZrYdiXxnWhG3CIUPIWjkn/jdMTk+To84N0vPFFlwDfyrYG2g+jWQY/vzNNaGCGyBitic/Iv/IiIF
	OpxF2HJSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgRQp-00HMmS-1e; Tue, 11 May 2021 12:24:11 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgO8l-00GdYn-0L
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 08:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=Cw+eH9MV4eXlSa+x45/xdbQP/t8NgFmT0xvp4wPvuyw=; b=YBGPBAUQLWyQgVcUgGIN8YpM8D
 cNCmDtwOd//vr2WvMT/GoHLRzm7tqmYtv+WZutQsuC8kYzEDjYdCbM4+NywG6nuRUxkM3Gu59or7V
 Fhj0vLx5BC3DEfGKNLw2V9GcYs5nyU0QuXTOS/U4vKy4ChaJsJKulVOSorWzjKGHwO0AqNGuQ+79/
 J89GI2/hbLBXfLHj9VSPAjvr2RWrSNiSIVyMJtLcCMeo1Io81kBOmxKoO3Lub1NigXIqjvluF950V
 grgKLOmvcqD8sXqhivccDjua2SYbGk1haj75EE7yAoUJJyAHRgMFXIy6itnryw1cLFFxHiHRvQ1Xe
 67WreEjQ==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgO8e-009PZM-SW
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 08:53:14 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14B8qnCu016913; Tue, 11 May 2021 04:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Cw+eH9MV4eXlSa+x45/xdbQP/t8NgFmT0xvp4wPvuyw=;
 b=HA2hOM23iMfehuT32XMAlK7F90n32TOYywGwKCq+Uud1kTB0pD3nBRRisD6+G/YUdiPT
 IWZOUMjmnnX0UhFxR3VY97BuVkPlBR0UfZ8ELV6dVN658W+9tkJl9b64fsOQx8QmNE9l
 Y7NAJ0SCmxQAyNAojlpVfgTtvLfzXjqkQtuhGC93ZBL6r4jNwHqV0WZz+KbIoUYyA6IW
 woppGJn892XjKM7G0Dwo6Kp/keTd+gIfOiIATr/BBob37dzwuZIrFfag7wI7Ouc5L4k6
 CEo5pIN5FOi3/3VuFAoYzi2bXc42z3+N1iUGxKSgK/A7KqJ11zPAPYfI3VqRGAUQMtW6 QA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 38f4vqkx6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 May 2021 04:53:05 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14B8oPGr140840; Tue, 11 May 2021 04:53:04 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0b-00154901.pphosted.com with ESMTP id 38fas88umh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 May 2021 04:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDgrfthT2S5RkGJ/KEzB57FP8JxJ3vTpIzc1lhwCgobNhccGN4nv9+pmCHR9nUxzaFwau99wgX5vqs8tf7mjoUeO6tg/b4C0mBwIGc9YgyPrUjVPIXFAcV07/SqqejEGhV1K+GtDOiWADYGH4Ogeq0nOadz718wNF7kTx78U9m6DeaEiTXNqwHtjcx3ANHYp9X881U9nG3R4i3hh0xOyMGckhjUqOQ3whM6ZysXjxn3X//e6lukzctXFmP5GDni861GyszH2mTgjJQzNPN1JX2qCOulx2/9Sr+5+nMkjXrZwiWRsUj6hqhSZ4TWn8odzIcHmIjOUtStCKVq8zS19Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw+eH9MV4eXlSa+x45/xdbQP/t8NgFmT0xvp4wPvuyw=;
 b=QL15ONTI6HMe/Q+oj+TwOxcXAhAP19HZgK4qpbpcHWhw2JX/O8UJt1DR4xcQT6SGXy1czGaWLVAeZrs55ZOPvLoN0JG45XAlXzc9TvR6nJRPfQP7nzzwe9A8A8eJFqDrXZMSvQWwUlantLFCnkG8WN8m/VcupfY9nOYr+Y25kmbS8aW65wwCP04JXMGKH+HNhpnu2fDHbmXqy5VJR13IYE53pkPsEUMSsiA0qVN7uA8JBJxa5JP6zcUy9mcE5kfTluve+jlX9WjA14gD0Of48oqZyqcjiUQtlo5ga2ySMbX34E+iTNae/ABeKttC5CHs/nWlDnDTJnOc1rnBBuY7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB2935.namprd19.prod.outlook.com (2603:10b6:a03:b5::33)
 by SJ0PR19MB4399.namprd19.prod.outlook.com (2603:10b6:a03:28c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Tue, 11 May
 2021 08:53:00 +0000
Received: from BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca]) by BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 08:53:00 +0000
From: "Rao, Vinay" <Vinay.Rao@dell.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Christoph Hellwig
 <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: "Belanger, Martin" <Martin.Belanger@dell.com>, "Hayes, Stuart"
 <Stuart.Hayes@dell.com>, "Tarikere, Madhu" <Madhu.Tarikere@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrS9ddQgAsXOmA=
Date: Tue, 11 May 2021 08:53:00 +0000
Message-ID: <BYAPR19MB293589E3A1359CD15964AACF8F539@BYAPR19MB2935.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
 <BN8PR19MB29290320440FE9740E699BAC8F5B9@BN8PR19MB2929.namprd19.prod.outlook.com>
 <BYAPR04MB4965C4F33AC9A888930DB272865B9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29358DD73BFD034E84C9602A8F5A9@BYAPR19MB2935.namprd19.prod.outlook.com>
In-Reply-To: <BYAPR19MB29358DD73BFD034E84C9602A8F5A9@BYAPR19MB2935.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=vinay.rao@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-04T08:32:45.2030320Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=0a4208c1-f66f-4a11-9d9e-adcb0a4f6b11;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [49.37.16.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e83d161-fdfe-4a6d-df24-08d9145a2e5d
x-ms-traffictypediagnostic: SJ0PR19MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR19MB4399D831834573F447DB90348F539@SJ0PR19MB4399.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfSSqFko6gaJtZrI2mforLJDzOxfBKA+/IWN1jUt09W0mhKKxQQvTgJzU+Ij8KWd2haXOZ+eOjibNA8BbJxEBPD0AebKleLzfVfNJPuWgwnMnAzP6aywJQKIDuIKP0NOFD+dyBZpSlX0rYKSLMLKBW8lnIiTHg+JWmL1Ylcc8X9ZuoOAnbcXPgqQdSMml3VvPZdTA4BmWr6jjsnROAz8qWI90p2Rq4pX7OwjJ7zcNjgZxUiX1RQZFxy46xArDVPsphTY9oUS4nUbXhnssUwBNYIbCq2rHCnAbNIKFq6eFhiiDDt+HU2aF/iVWFUdQIyrcQNHEVhOa48j0shTkfJtrJOrz17tMZITCFHjrmKquBl333+uK8zfIHvLFMExC6gipzRipsIe6xRHfm+XqrAx+abvFa7JncGJThGTRAnyGpBrSgITmptM+ot+h8XaDxpD5rRDP+/wYwxWVaIE0Nsdqvqygl/5V5F6YkLrbwumzkT57mGair//ikhBcbGa4YmcBdlnEzzUqBD3CmnFqXgv/1kSH+caHkp9C1JNqspwcwZK2qP01oeK0Iqn8PBMJ3Xa7U9FdtaPEkso4+TjV9tMRTtUXRzSiQ7aPPQZIj/p8JY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR19MB2935.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(4326008)(9686003)(316002)(122000001)(54906003)(64756008)(66446008)(76116006)(66476007)(66946007)(786003)(55016002)(6506007)(66556008)(8936002)(52536014)(8676002)(110136005)(86362001)(53546011)(71200400001)(478600001)(7696005)(26005)(2906002)(83380400001)(33656002)(186003)(38100700002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N+Fk2bhVVgCEdRKILv30YsKpnIg5I50m/qUUol7iYkwXibGdKdTwHM6qBpBY?=
 =?us-ascii?Q?aefE+3k3ilelFb3UmpjzxQTO9qp/uc6Plh9T5DXg/TLDSUGPJ0ROPtnMavX3?=
 =?us-ascii?Q?+SXn3TKBfKMoqCvz81hcoXK4Cm+Fp+4ewvdqOAfoWugDxDSd9mXT6EOZkVM/?=
 =?us-ascii?Q?uKKwpGbyMqEUhRxbOrAt1I/3Ur8uhMJOGqYLDMKI+o1V2K58TQVTkhoMBfGi?=
 =?us-ascii?Q?ctAa+kbK21OuSJTDm9ag13ajy9Akkz1zYe+v/8/wPlzERsXorBGhnhnIu7nJ?=
 =?us-ascii?Q?5t/R9+QuLNV7r8Wh06Mklu/PwFZn36iWK+0xscudgSuu7OcjNSU6ylknaFzm?=
 =?us-ascii?Q?0Lw0xy60GTFEQGKtOPAMzHna7TAeWLZrKA4qdnM9juLIlLmnxUR3SyCTjNVI?=
 =?us-ascii?Q?qVtgB0vDqupYZbr42olE1YXw1TQhM3u/XGvtOJheO22vT39ZAq/wJ8Aw1bLt?=
 =?us-ascii?Q?xWA/GXbS7OatjgHhhSKZwWmZNjBPGVRTaHu2OmiEDs3s2B+6QwZVod1A7JxK?=
 =?us-ascii?Q?ZrrxecIxa4QztIeJOjJ2k0ToYxyV+PuZGcKDF0yaOl13bvfnystv1kq0NaQO?=
 =?us-ascii?Q?whZiX5xPcHHqvdT2Wyh41hd+gzORt8AfLhs2ZpGITQcYJMXywSfC4dYBRR9A?=
 =?us-ascii?Q?M+GhhKa9qUcFecnieRwTJJDE8qCGfjkFdBArxRrw8xev9aJzK46EiD/fDRVL?=
 =?us-ascii?Q?V4ROPg0O45lPpyYRIYvDRO23r+azQNGINOsUeZhW0kgCew+Du7MfyRI0ZcPv?=
 =?us-ascii?Q?SmneNq3vlc3tAx3dCXCJi/JPCrPr2QkYtu/v4QSIyTn1UUkTxHJD/hFOTaHy?=
 =?us-ascii?Q?Nm5X9bPVIcCogXyBYq6/URON77KOuLluEFNgzfAoM6k/P0p+l++6ZXrwNzWS?=
 =?us-ascii?Q?gAa2tiPIRM5l7PAUMeb9KxPTdq4tbp+doGm+obGBgDMLx8Hw7i1xpLjrV5E7?=
 =?us-ascii?Q?S+C7UenU4/tQgHemA5Spe9axswRgfylergWhAWiUXGtTuxo26icxIePJl6LV?=
 =?us-ascii?Q?8ci+ys5j0AxYL/nNf5SyoYMrnUUzPOg6bP2P+E425HUA5jjXYyofajV/Mh0Y?=
 =?us-ascii?Q?9KKOKQC1vvj8rRwO9aT4Vai8gIpV6595W2zyPmnu6Lvzu2HkRjnA2KyJ/xY7?=
 =?us-ascii?Q?Lg51ndOazB7ETSdhcsD4ig1B3NdaCxcylgCofGYxLz9lZzjSOGC3L1OKphqb?=
 =?us-ascii?Q?vLGlaBFyRt3X7Et7He+hjmZCVezzWewCxdaNGdERRmdWxmXI8sIQYpGZdH5e?=
 =?us-ascii?Q?r2U471DHVkkKj0K1d2aYMgI1b45ZPYo9Cl3fi+PhH2IApjgXii5hV3Lypwex?=
 =?us-ascii?Q?oQyVAAgl6csm8wLf2WmCncQ1?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB2935.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e83d161-fdfe-4a6d-df24-08d9145a2e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 08:53:00.6302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57Gi97f8gGjmKhg0tr0zNSGxeVYSN7NUIt33LsKo8JE5aiGb7X7sbc9JjyQGMS+t4onX+Wzsl9y4+/Ev/H3PbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4399
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-11_02:2021-05-10,
 2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=771 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110068
X-Proofpoint-GUID: vdQY9ye_IKuXBYHh-r_WNCWfajHFueQP
X-Proofpoint-ORIG-GUID: vdQY9ye_IKuXBYHh-r_WNCWfajHFueQP
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=875 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_015312_993862_E7389EDF 
X-CRM114-Status: GOOD (  20.47  )
/bin/ln: failed to access
 'reaver_cache/texts/20210511_015312_993862_E7389EDF': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_015312_993862_E7389EDF 
X-CRM114-Status: GOOD (  16.05  )
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



-----Original Message-----
From: Rao, Vinay 
Sent: Tuesday, May 4, 2021 2:03 PM
To: Chaitanya Kulkarni; Christoph Hellwig; Keith Busch
Cc: Belanger, Martin; Hayes, Stuart; Tarikere, Madhu; Martin Belanger; linux-nvme@lists.infradead.org; axboe@fb.com; sagi@grimberg.me
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs



-----Original Message-----
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> 
Sent: Tuesday, May 4, 2021 4:52 AM
To: Rao, Vinay; Christoph Hellwig; Keith Busch
Cc: Belanger, Martin; Hayes, Stuart; Tarikere, Madhu; Martin Belanger; linux-nvme@lists.infradead.org; axboe@fb.com; sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs


[EXTERNAL EMAIL] 

On 5/3/21 00:21, Rao, Vinay wrote:
> Forcing RAE bit on all the log pages that kernel cares about is one of the option.
>
> Can we also think also think about an another mechanism where the kernel would generate uevent after kernel does a get log page. This would make kernel always to get the get log data first from the controller. 

to read empty log page ?

We are interested in these two events NVME_AER_NOTICE_NS_CHANGED and NVME_AER_NOTICE_ANA. 
-- NVME_AER_NOTICE_NS_CHANGED event would require the host software to do an nvme identify namespace to see the change in the namespace. 
-- NVME_AER_NOTICE_ANA event would require the host software to do a ANA LOG page command to get the ANA log page from the controller. Even if the ANA log page is sent from userland after the kernel sends it first the controller would still return the ANA log page. It will not return an empty log page. 

Any comments on my last email? 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
