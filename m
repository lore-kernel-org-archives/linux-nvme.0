Return-Path: <SRS0=oNOl=GM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BDC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 20:34:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E33A23AC9
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 20:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E33A23AC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BlUm3P79EygxAgL7KdFoGSWTDoVKKQyoJLps5O3caLM=; b=b5hp/yeImdPtnvllB+ls7qsfn
	ICQ7by5zJ0Pro91vN1I+IvXSJ/EP3sUcHpBNCy0QMwx+2NhKaRWouZcmgJalLF1IO2UMRrV2SuFzL
	d5P4I6BmMLGHL52lGcvIJU6ZoVVspE01+LfbQ9/X8zzHJ2TaiMqvbqzwqQl0++cHHRYcaJ+z1tWd3
	iJy3l4f3lQ0MysQjgica6nZM2q1OLz29GwZ2MBkGCrWIexjBcMkOUcyac2f0OvkkSEFrGNzT4Okn+
	9surwUQhhqhsPS/ZXkKkCnxpKgi26fYyzB+M+/9URNKNq4pkN61KthxSYVrObCeW5aKZnSGNoy5z3
	m9+YBxrxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyKwF-0008HS-M1; Sat, 09 Jan 2021 20:34:19 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyKwB-0008Gl-Sf
 for linux-nvme@lists.infradead.org; Sat, 09 Jan 2021 20:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610224455; x=1641760455;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2rv1WWaj92qqnDDeGZDzsXhq9z1uQjM8j/90ue7L4gc=;
 b=Z81nVQkF/7V4i2YQGB8lqGS0kq9RpasDNMudNbV+fddaMXaTF5WOrWYc
 RfEyPmtg/oFexfFJ1eYCH6DOb7LQgwDBvhNw3l1IwJqT+peedKLy37Ej0
 wxNwZorCHKnZ5onCAlqFOqE32Hpawty9cZFiqGB0hqdryc5weN3kxC+sT
 +CusGOvBAGIJPP26w7Dir0N09ahiTKXACQsF8fuE64MFP86+bL6YkmJv5
 LrdQBHZmPGjHlKakru/y3tHqPGGh4D4X5KlZNRPd2yEX1eoVkSCsothhR
 zWl6wU15xPCPezMFLjOU+buG9Z9umkwqT/9KsxoNFrxQqalMtnaZAp9IL g==;
IronPort-SDR: rM8SguNOfUhp2Vyikv1wo9WdtKdIQcl9JWQokoEpyLiXcAbw2T7oVSF9TmbreChS0s1JT0J/NS
 5P+YEN7Y556lWVCbZbT/NB8Di22l/rVIgsfcAmPFqHnqffBQ5luGx2gZjV9CRc233/w2fqrSYw
 3OUsc/lDAhCTb4Bb8NYxyFgu2p3bzKbr0BhQ8xbC2KZhl+fUS78YwoNKE083aE5evFFlIqG8no
 El92suTLW5jInhICIG4FCalUBK1+Yscjml9D5whGNXRCMfxwj4ZUeLwY0Xd4KqLUksjpQkvuj1
 i08=
X-IronPort-AV: E=Sophos;i="5.79,334,1602518400"; d="scan'208";a="267328029"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2021 04:34:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIxELFvHp01nPNpkybX0GhacQDz0n+0R753CyhYZs/nRgb+Kp1d0D5XzhbBxwQ3/SjALa7zG3wMbTp986AtqqZX72n0lr/VpgNXTIzzCXte+1agyq3SDC3r+jnwAYZCv8qCh3+BJOH9eqPnrnIYwvCYUC9dLdwjijKUmLs9oaKLm+NZrVrgFAv82phucczMdlwfgeeK/tD97PHM8mA6Qhgxx6NWp0YHjX2u0C/Ttz87hS7IfPVhkZ02HxDUgRh0p8NbLRz4iuaQ2f5X5Dc0RNBJdUauuFE4E1Ex6R4t4xo2t5nf1DpwEy1ArM3u7LU9i/aqTpU730az0jFsJvX7M4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7ufq+dHuv/KVqczU/mHwHLm+cRjZP8WBcP5cVXg7cQ=;
 b=LfzT8HQmn1lmj+bhHbKr3OLm84dJrg5KKhjAMsVvSZt37ADHUrrE9oEQ8WoT5QnKWA9AiFYazb5hTDNOFnpJDcUBV6bz122knecKtgI2LBJsxNpJEBF/JjDG6AxkVQ7eCa9fEfa6NTAtjYppUsX8Ux6XbMkqrEM0bcg5kPBLlc94RgZ8jBy0IYgO2UdLUte5A+urNyZSB+zHhxntTTmhloi5dzCtJOXijcc0XeeQhWQajtSnl28qlrUwsLkMT0VFjahPj3erkqPNsvAWfhARhtKZtQlfkjrGuEbvnRluE1QaLYHxPITk8aGZXfyABJI4UrMonOGWHfEkQ7UEZGv7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7ufq+dHuv/KVqczU/mHwHLm+cRjZP8WBcP5cVXg7cQ=;
 b=d8pUtfCuvvXCxIajfrLkgIBS/P2LeD+WvlXl+NfMY3C0RhjjIdoSRxROfSr5P6BG/wX0ZPevQ8AOmdCxVNtZFoItum1saLFMsr0tAnkfI5M7sp5KEGlIj6ioCEQGQpxh3bV6NyrYo/A/ycoMuZdj70JOmbAH1coi/cVpY8XDEU0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5430.namprd04.prod.outlook.com (2603:10b6:a03:c7::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sat, 9 Jan
 2021 20:34:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.009; Sat, 9 Jan 2021
 20:34:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: support command retry delay for admin command
Thread-Topic: [PATCH 1/3] nvme: support command retry delay for admin command
Thread-Index: AQHW5c4xILq8S1EXoEygdZYJAenKEg==
Date: Sat, 9 Jan 2021 20:34:11 +0000
Message-ID: <BYAPR04MB4965078A7B0C75B03D342EFD86AD0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-2-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e19abe48-4aab-4eb8-943a-08d8b4ddec3a
x-ms-traffictypediagnostic: BYAPR04MB5430:
x-microsoft-antispam-prvs: <BYAPR04MB543041A9CFDD6F00B4D4ADA986AD0@BYAPR04MB5430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4woufv8y6yNrHFzzVUJ0Wv9FZUsP8I2ML7zusnFva03PlRdKsUPrzUXG+CS0/OeJN9TY+nvts2bTWMkcJezEwWcdXdI6X+UePkBk9Qtu0Eq3N/zfKTG4T83JCNlGonFgNNgRGyGDrUD7W2upg62ISADFWPYgceyzBOHr7n+DnfWmLBGtO24yixGxURo6pT7itkDjyMMGDo/eydu1HFbT4w1NyjDTz+QCv8H1D8cXVbmxH9qyx9TipvZPJvJJdyxAp+sOeEhDuxuEvkpPRZwNgUoZfm8UL9cJanemkQ5NyEeMdGG5GVQhbph1PskI7rM7QCvWTrirs7fFO2yqOa35WlgU9/q9B7wbnFYySdINL/gx2iEvP3dXJHNDVJP6j8Zygn5yv6bwAbbt1J6GeR8vxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(76116006)(4744005)(2906002)(66556008)(66476007)(5660300002)(52536014)(26005)(4326008)(53546011)(316002)(186003)(6506007)(110136005)(66946007)(33656002)(66446008)(71200400001)(7696005)(54906003)(64756008)(478600001)(8936002)(55016002)(83380400001)(8676002)(9686003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?riUn/n2jON1PPPMexKRkXjYSuj31xecGLKJurhL9xc1rLY8rZv2hTmbmvhYL?=
 =?us-ascii?Q?At71fOGgL0jQNiK1Ox+ps0XItLHT5seBNLI1mHeH91vzRpPa5ytqO8tEO5W7?=
 =?us-ascii?Q?Hcgb7ssFG2tqnA2KU+N9ml8MLjwz1F09JXXHY4QIwAPV40ihDesftxJO2QGG?=
 =?us-ascii?Q?ELSRi6kVmGsXiFnwvfVZFW3+HQ31ULkurjnThAb96jtbb+1Z5uklAKtGll13?=
 =?us-ascii?Q?+MFWuKqP4vRgOfjnDozqG3/oISHpiJfEgPk6vLahRNFDQb7qMk8vTyGc+PgL?=
 =?us-ascii?Q?WvLuz1/WFt8LU1o3VNa1BfpgQCgr9Nw1m+sp73GGmVjJBx9t9W8T8Cva13jt?=
 =?us-ascii?Q?Yg/oP8Vq08nFkVGOBNFzzzxfjNViXmmjIIgsb/JunYiqyXq5NeiMxh+e+uTf?=
 =?us-ascii?Q?Fo8i2tsZHedoOurjDxEJPdFQASnajDwec4CgCVIIFroxkNIMaAqgldPLDuUl?=
 =?us-ascii?Q?OhAPXSP58CJeTCM4MeeGh8yLXKG1aqpfY8qmcSgXdeIEPZ18tRLLtCdtia90?=
 =?us-ascii?Q?8pLhQmWkZxhSqasWSJn+EInN5ZdpNC0nR2qNXXyDdRWcmWc9NMa4kjnreUox?=
 =?us-ascii?Q?+KgApfSEL/vTHVUiNHJB9YfmgrdoYFMnBwbkq8eq2TVRfOX0ChWTDzm6M9qn?=
 =?us-ascii?Q?Bqb2t1LgFOAlvPuWhppCqBfzQJONDlN7QrOnOdxRp4jMtELyhBf2ZUoBO7ht?=
 =?us-ascii?Q?bFCxdZXX59djj3xW6zhoRn7ZCC3kqe36onfK/pTOUU0fe1kjmzzhvI9cVg2y?=
 =?us-ascii?Q?h6ufK8kS0RnHdPL8oum0aDl4D9bdcPF/MGuY+Z73u1piWZKjWNZYi9pXdKwV?=
 =?us-ascii?Q?HrYUGrgbt7vOg65Kg4eoyXyOCUulBBUG4ZkA2glFaIIpYKNWBwzHIes7oH6x?=
 =?us-ascii?Q?MeYh6CXxijKImtgQDO06jJhAPgnTTO/FkLSDZ2JuEJF160NOk2a73Jx9ZlUy?=
 =?us-ascii?Q?qAhC5CJHcwLLu2/JhURyALluNGlob1Oo1ZTenkZO1kFo7JhqhJD8o6v8WEQe?=
 =?us-ascii?Q?pgxg?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19abe48-4aab-4eb8-943a-08d8b4ddec3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 20:34:11.5896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtCUd0ItJ7J8k8PanJn12FnA0EuPiwvF64tJvzRAyyApF3dviKdRjuDR5lKq9EqR+r6lFzClkjTEAdsKNgC8/DJMcWzDxXFG2ZXkgwUwCW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210109_153416_112097_9626CF93 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/8/21 06:54, Minwoo Im wrote:
> This feature can be applied not only I/O queue commands, but also admin
> queue commands.  Admin command during the initialization may fail due to
> some un-ready state of a controller, so it would be better to have this
> feature for admin commands also.
What is some un-ready state ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
