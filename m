Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3BCC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 05:41:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B71A64E4B
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 05:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B71A64E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Content-ID:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJyY8qwhCfsRF+EQq50ar6BoMtem+Pa2pjb+gI0PhXw=; b=lWc3MKXds2dVBlDpwwNU0xWzT5
	rfYwrQyBss0Y0eNO98W8XoTHsaMsT5SgELdCdUtJC1I5nOCIm1XrCKa/8ug1DrLT7evO+Rrxd3T0Y
	4hohWb9ImadM+htfP48Ov68ATWMjvLgz7Z0GzAd9JGqkEPAiCrNhn4ASjQUJJcV1T167wllZ/Ma7w
	Iw5rL35Mu4zBDRaRObhn2UcAPR1gKSNl/xAU1eKSjlxMz+6xZUDz4ojYSvoSsCOdd1br2AykDe9BO
	UTTIcYe1xJHLLZc/S3e5qQ6TSey5w87iQZ8QpPpetqIcsVcAU54ciCi1d3Hk4ho4vgUXt2tv+NV+A
	zuRPXO1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEQRX-0004Fw-1z; Tue, 23 Feb 2021 05:41:07 +0000
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com
 ([40.107.236.47] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEQRU-0004FU-I4
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 05:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZKu9iowlRW5qHfypIu+eC45OT9mIXXE30lINszO5wUW2fitMe5hbQB5vlByHW8ZLPrrtdhJhM20oWOs3aORETmteRDbJDIqqTAj55tz25FlwyDbJ8xWgB0K5YBLoC2/scCgp9nI1mUCY9fOEbaBUaaDYJ2dYTeXb48FEeHw/ekZVagoDjNz07GwNt3/dNVbzkOQNdz2GPwiSXQB4yYedPQeHR/CTfufXO/zG00WStfqIySY151SZU63lcAVGi6AWVDY5dVPLaMAJZJ8Kj78VcsE10d/UtDWlGQZtxHwA1XMGTPHrrIu/Ry93JcmWxM0HNJNDyeokghFEmfA2fJxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgx7RjI3i46tU+vgOD/K5HC6VFgT1SPJD6BvqiG+4TM=;
 b=ZYYFCyEIw/u61jRcMlPEIQNPtE6OJ7Quvod3rx2x1LU2H5luK+A+sb7JY8uhtlwC1EzDTwJxGcaRONUwUNvO7nrCdW+Bkd0+olZNLwayrbS3PGo06Hdo7yMKJEgNd3MC1KXt3PBq8PClA6mTpxNU2BG5qvPbVYowVzFzEmew2DYzgibMtANcy0p0cMNDHBLxq9cuSp/GXWH2Jufs+beyPL4wPnUt9Kp6mTudCR1Y4egdicv5PTGOPUyrJZuRHxgi6iGpBzKABdbhyACYucLT3bL9g+vQyUf27wkeJ8XukBacyl8cKRp0/nIXQh1ue5gRDTkKG9/AOvXgWQWQokCy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgx7RjI3i46tU+vgOD/K5HC6VFgT1SPJD6BvqiG+4TM=;
 b=yrBtq6xxdh6Ntfa9giQLOfj29+YeTN8n8bVuha7AsCad/VAJDpfUXhwINy4ZWwp2H5+sujw7NUr6TQsiWwYojfx+73OPM7194jkCLTml0j/iDDog5pPLr/lGch54C7Spe2H7P+Vdzo1f+QYhlMzVPK8knnBbv1ONM/CW1jQCnI8fqN3Q8JhHtruiS8KZzirr4cOzZZGFuw4KuIdfHdKJ1oUrSX61eRL5jNXwd1GVEggcIMAlMiIbGOUhgZBC2hE9FVvtGWm5rzkfLBrrRfWPcPbj1KIIV/v++Hu5z1xCP8IX+LhVqV6rvHp861EtaTnzMJIeYoVuR+OTAEukz4ywow==
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB6442.namprd06.prod.outlook.com (2603:10b6:5:110::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Tue, 23 Feb 2021 05:41:00 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 05:41:00 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Thread-Topic: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Thread-Index: AQHXBdwVCJJe3ZOHYEapjHnhbLUW0aplQTWA
Date: Tue, 23 Feb 2021 05:41:00 +0000
Message-ID: <cb89029d362a3cd61504012351f56731cec9c6fe.camel@netapp.com>
References: <20210218095422.5696-1-marting@netapp.com>
In-Reply-To: <20210218095422.5696-1-marting@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=netapp.com;
x-originating-ip: [202.3.121.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c1dedd-7c0b-4768-27ca-08d8d7bd9a34
x-ms-traffictypediagnostic: DM6PR06MB6442:
x-microsoft-antispam-prvs: <DM6PR06MB6442E1F68ED38FB8900600D295809@DM6PR06MB6442.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgCmAiVa30MXty8UzgYUgia4cSj3AymglMs1Rb3lNoDDH5ILOSdR57mf+j4tCurYfQdj9YxfDIStQ4IFbIS3xemNXPeuVpMQoVeMtdcBqdJPUNuRELKNT2LbYvRVblxMqrzK/87dOZRRvC3oRDSwza4jrpSQOI+cagQGUXY/1zusxco3g/HDrZwEoVaXxElG2pYVBlXiwzPPI6jjvCXLNWLlgEp3rXMsjiDehYDEhgrOuIQvGpuDvCGO2UgSWDuTiTyds6+dyFz5CMuNnr3Z2qMGUlAF2AH+ZJYoS49dmefWuuZ5v8eVmae1VuBodzp45Xwg1i5sLFb06wIq+CiBwCd9BqZQtWJM3e+1XSn3ZUadf9SKJ0ScS5jgQ3YLoin52+FEY6KWSjIdWf2GGBFsuujrPdVkjGogg0aKpCSpInfTjDQMJ8geYDi/D3uNluZ+WQMScls5xN7FwHygfqapOb2TOgACCI5B0jIOhIetthMPRZ1akxQtrjjx7N+9ZRjuZeu/V3oYJjuBsl47V5ACbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(91956017)(5660300002)(6506007)(36756003)(186003)(26005)(6486002)(71200400001)(6916009)(478600001)(2906002)(316002)(6512007)(64756008)(8936002)(66476007)(66556008)(66946007)(66446008)(8676002)(2616005)(76116006)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?U0RWK2Z1Yzg5WFd3bEowYXZXeEZEUWE4a3FzYnhlbFc5cHpEQnFEOFk2TkpX?=
 =?utf-8?B?VitkYkt6ZTN4ampPRzhXU3FLRGwvbnQ1d1RpNUt0VFBKZ0thWFF6WnpWZTBx?=
 =?utf-8?B?ai9hYzZqaFJrMGFCU1lNcE5ONm1KMnhISnNkallUNGlOdEtPVlhBODJzKzNn?=
 =?utf-8?B?T09jV05sM1dEZDlVWHp2TEZLVzRtK2JoNW9zL1VWNXdCOWlQUHlReks1cmhP?=
 =?utf-8?B?aDh5VHlSWU5pZWlaT3VQdlZsTm0veTh4dy84U1pyODQyM1c2NjZIU1l4TUpZ?=
 =?utf-8?B?dWFXeTd2cVlKZkFMaTArOUlLZUVja1Y0WktCQXZ3MjdESGhTRzYzWXI3dEo5?=
 =?utf-8?B?MVpjZ0Z1UmtTU3YrWWFWUEhVR05Id29xd05LVVBuNU5VaGUvTksyTjlKbzdm?=
 =?utf-8?B?YUROcWtqNU01djl5dlNiMWVKZXBNNjdpc3NYOGszYnFxL2p6dVVMZEd3cWxL?=
 =?utf-8?B?STBROGtJZnlUTnpSaHNqVDJ0Yjl1Q1RkWHhJS2xodjJZeGh2dHNNK0lxMTI0?=
 =?utf-8?B?cHlrMSt1SDZqN3p4RzNhTUlpUU1wa0VjQnlDZUQ0R0VZeTF4ZW9ZUkxkSVhB?=
 =?utf-8?B?bHlRQnk1dHNTazFyM2JnU3RZUWpQTUtwenJKOHI1TnJvSXl1cU1NcEpzOVFJ?=
 =?utf-8?B?TTlxdEhXckwwaVNmQlJpaVFuelQ5anI2a2VQY2RscUtrNUFrUnRqbCs0M2Nx?=
 =?utf-8?B?N2ladDJGRHhZTFVQYnhCWS9RRVJvMUJSOWxaRVJrY25hODhkLzVmakViK3d4?=
 =?utf-8?B?N05sbElQWDhIcEd0bUZBTklobGgrbk5FNWtqc2lMWW55SFQ0Mk9VZHhZN1BQ?=
 =?utf-8?B?VmRHdjZ0WDRIUEYyVGVrUEFoUXd1WWdQZkxYRzNVbkJQL25IK2FqSXpvRzRt?=
 =?utf-8?B?QXlURWJPTW5nT0FZdnRRT0Y3Yy9ieWp5Y2RjRFhsVE96cU82TlhqUzZ6RFJS?=
 =?utf-8?B?NDNrYWJqWmwyaFRtS1hkR3FQdUhBay9pU1JIU0cvdjg4cUpFaW92VDdSUVNH?=
 =?utf-8?B?KzBUQkpzR2FFNmlZY2NBbnFKK1FMNWMwcXY0bXY1Ynp4ZmJ0TkdVUW44VEEv?=
 =?utf-8?B?dHhCVWhVVThOcXV0T1cvYU41eXhoWWxyRzN4cElxSkc1Tk9vQW5STERMV2xW?=
 =?utf-8?B?d2YxVytIT1lPSEtjK3hjNEdlZWI3Sm5lWExSaEhMSWJKQmdaN3NCaVMxN3l1?=
 =?utf-8?B?Z05LVXRCOG9HcGw2Zi9lVDhOSE1EekxPOUZINi93Kzk2akRLT0ZVQS93WWhY?=
 =?utf-8?B?TURkY3JHRmpKcUhKb2JIZ0hJekVNZTRWa2syUnMvaWJCclY4UGhrK3BmdmRp?=
 =?utf-8?B?TjFKRzk2L1g1Vkd6NTJvRGg1bFVlSzlHQWtCemJYTmVESDJRRDZ4MWN4Q1lv?=
 =?utf-8?B?UTMrSS9oUC9WM1IvYkhlSE9YWmE5NjZCSFFjRzJPTzc0SXJ0T0NMSGdhSDlE?=
 =?utf-8?B?TVFvU3F5OGx0UUt2UE04UXJ5RDh3dm9uTXA0MVZVckpaQXVBeUFnVmo1M2RT?=
 =?utf-8?B?b0g1NzBpa1VnUHJCczNReC9ITVprSzRjT2pqdW90VmRxcnFpYmRrVFltM2g0?=
 =?utf-8?B?TGNiVnhMZE9tWXNVSkJyNkliaTdYa2Y2UTRXaWM2TkZrUS9MYjVGT3FJVUdE?=
 =?utf-8?B?THdOY2hURDlwRUlTUmphR2FVTTNHdUp2Y3lRV05tWXJmMm9QWTNaTzlGV244?=
 =?utf-8?B?NEZPUGtlekZIaWhEckEyUHkwS2wyd1NUV25QR3NNSTd2TFdkdzhQZ2FQSUFW?=
 =?utf-8?Q?gjkStWNTrH+KYGlVbeUOcQ3ZTK8yqapevuPV6ud?=
x-ms-exchange-transport-forked: True
Content-ID: <A2CCE14207680B4086E6692BFDCC98D3@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c1dedd-7c0b-4768-27ca-08d8d7bd9a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 05:41:00.8225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yv3emqI8qPfowtF/Ma6oVg8cpq3sRFXU8tTDlp8COiap4rzIbZx2TDp6nMT16bJCc8W9CMVVpGQ0T7J50wtgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6442
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_004105_226287_4DA26F0B 
X-CRM114-Status: GOOD (  15.25  )
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

Ping?

On Thu, 2021-02-18 at 15:24 +0530, Martin George wrote:
> Along with ensuring a non-zero kato is passed to a
> persistent discovery controller, also ensure a zero
> kato is passed to a non-persistent discovery controller.
> 
> Signed-off-by: Martin George <marting@netapp.com>
> ---
>  fabrics.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 1880a5d..ed15e08 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -1399,6 +1399,8 @@ static int discover_from_conf_file(const char
> *desc, char *argstr,
> 
>                 if (cfg.persistent && !cfg.keep_alive_tmo)
>                         cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +               else if (!cfg.persistent && (cfg.keep_alive_tmo > 0))
> +                       cfg.keep_alive_tmo = 0;
> 
>                 if (traddr_is_hostname(&cfg)) {
>                         ret = hostname2traddr(&cfg);
> @@ -1474,6 +1476,8 @@ int fabrics_discover(const char *desc, int
> argc, char **argv, bool connect)
>         } else {
>                 if (cfg.persistent && !cfg.keep_alive_tmo)
>                         cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +               else if (!cfg.persistent && (cfg.keep_alive_tmo > 0))
> +                       cfg.keep_alive_tmo = 0;
> 
>                 if (traddr_is_hostname(&cfg)) {
>                         ret = hostname2traddr(&cfg);
> --
> 2.30.0
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
