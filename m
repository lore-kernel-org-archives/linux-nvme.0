Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 15:48:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A9364DD2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 15:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A9364DD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Content-ID:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDP5a6htQ10kU5Gs/4s9dcZk4SmcOFrCyIdbdg9dk2Y=; b=G3DCBnvXRRBppWx9XnUV8t8xgs
	fiWcnLttmNhIFldkdYSRGvIFxijhGRwh561MaZNzcw0U4iz/U4tRK8FTImjL+DQgC7HvvxyB55czs
	yJb0NB1g/TpPFQgcwf3VvBdJSWXBxSrb1xE9zBMsaW++lc8eu4a4zcb2FUSLBhfHJs9ZLC/tLuLJM
	yLsf58g9xgpxFzcC/HU5YCSnCUlbhSi83BQqs84NQY2d0/9iZXxe2JRqfC0o1smAGKmX1eufDaS6x
	Qr49tghec0wpuYhXQXtMuFA3nKjB2ARQV3VmR+zcCdjyvSnuf5iH4+/wemIms1KMr0QD5Fj4SB0nE
	Bxe+RUZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGkmP-0005qw-DF; Mon, 01 Mar 2021 15:48:17 +0000
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com
 ([40.107.237.42] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGkmJ-0005qK-Bb
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 15:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh8sNwEkZTpvWs4HfM26m+mT4ZeBwbhYxrXrTwHWnicB/T2jQXyJEbLyHWkGqDQk6frxzFDJdXrgGH0WyP7fS9XmdLliFkCsMbbxNBuh/HbHKzWCZbjiF8oun/9C4zgmSOEDSAPHOzCIK2NhV+AbPNt/CM90cHX5dnlB/s1TEAdsT5isvrNjzG/ZcpS1DyomCmB1DjiywL8StlCVN4ITd8ZIL4BVMSSrfQ4TxyGGm/dXGpMnvX3ugZZwY3q53A6TwZAbqkBdhk1ajbsyt0MKrGsKQzw3tcCH1cVJOmmJpjF2PczMc/xB/M/6Bn4jl5xNhgjA8SXVbiGQ1dgvv9S79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqaFYu7FfxbnxojWNClAOhncknljZxAn2gtdWu+oLhA=;
 b=O/nk5AecGoveyG1wDDVv7WPzCpZkExjS4K+T5861+uRMFWh4Wj9/GzKdPbbEV84LEPO3gBBC199c/eavqYnQVZdaOov2HdJEfAYQ4CFsXJ+pbMwvmu+NKFUNnaW2rzaXfWU8vKhb866WaXQDPCa1n97y1y8fFaFZ6iUjAa4jG5x1OA/u2Jr2TMHaQnmrqpwR+N87az/kg6Rll9a8/0FJDpPQ990cj65OUqfEJe0BrYBfV8MQjk+SVfVG3qW2kLr1SxPn8OZeyxpzepGT5py+Zh9MKqgfbmjXbvtILKx5DA1tOLt+PQqi+0pR77fvR+z8RWymZjkQZUJpt1GqVH5yRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqaFYu7FfxbnxojWNClAOhncknljZxAn2gtdWu+oLhA=;
 b=Wj74jvQN7jrm4JSb0f9ONqtCRSGw30jiYZNo9eDmOW16BiLHeoU6D7sa9mRcli7d8/+SqcpW91vlBS+eHpNYjLzOUvEt1Z8I9oM2ux/WysL0u9MM2UcQy35MF7dSOyJhlN9TLqsIJDmCvukanrkEgrg5mrgP4Gi9l+rd7Q12csUBkdU0pH4/1RN5rvJOpSLtp6dScCvYJ01s5oTxDV6M/s+XDt1FtLlD/yMw1DD4oiPStZYlao1Xipyn/0gDLVQ8wvFELS5QPlP+eyEMjWFeChcRZbCFs6LEgtVyph4gbtPexRvLczLQdjVBejJDlFSUQ5m7PHiQy2OlPUQWO6ldcw==
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB3900.namprd06.prod.outlook.com (2603:10b6:5:86::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 1 Mar 2021 15:48:09 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998%6]) with mapi id 15.20.3868.033; Mon, 1 Mar 2021
 15:48:08 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] fabrics: ensure zero kato for non-persistent
 controllers
Thread-Topic: [PATCH v2] fabrics: ensure zero kato for non-persistent
 controllers
Thread-Index: AQHXCpsvRA/KNS147UCK+68uWrvzl6pvT1QA
Date: Mon, 1 Mar 2021 15:48:08 +0000
Message-ID: <f021a3737cd48447633042ab9c4f078529a917c0.camel@netapp.com>
References: <20210224105123.7050-2-marting@netapp.com>
In-Reply-To: <20210224105123.7050-2-marting@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2b04b52-f6f6-4384-db33-08d8dcc96986
x-ms-traffictypediagnostic: DM6PR06MB3900:
x-microsoft-antispam-prvs: <DM6PR06MB3900DF2A4866FDEABA628031959A9@DM6PR06MB3900.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBHlRd+3T+KFiOV3I2O1JnDOM433/HLbh4dSrz9yqQU3rEynsod/m9ZW9Cbkq4p3Y1zG7+NWPRwYiN2yg1AHN6YTKn6Bdu3Ue7xBkjkIAfPdQ49JYR26QrPDIldQci5wIQj8g/wWrV23V2sBgdQipY+O2dL+5arm4FKvcdfmPWtCQVJXHBSQYG1aEYu2rdbxHTa7Bfwt9Mn6lvtLhL/cQ6DzV7mu28jeWvsRMJ+ln59Ow6u04Qrb52CJ5XmOOHgrWTga+IDJYob+F7J4qiIWLUkxdJRRMgU0NVwcO64gACvnDISs7WDH4NGaeB4ZD0nT2T1g1WpvTznIQ6yn+EEdfa3J5eqTNGbM8yKMnvj87Rr/EPjwqar7D306RNhDWXw4aiJ36XcBVOUWT6SXh8aza9dsSz3kceCmIBXsrwsLbnzD6LiQDkm/xJdxIk+l3KY2otbXOWHI0VKrat61fZ/jFSAWXND6toughAlaRn+gTDQwkbGrePpQDNSTYqjHi3dE0/Nxlqz8/bl7liZyZhXWZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(26005)(71200400001)(66946007)(186003)(66476007)(2616005)(64756008)(66446008)(36756003)(6486002)(66556008)(86362001)(2906002)(91956017)(6512007)(478600001)(110136005)(76116006)(316002)(6506007)(83380400001)(8936002)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZVoyRVIzZEpJSUJSaFIraksvU0dnOVJwZ3RITU1EdWVqNSttZXhYUEVpYmE0?=
 =?utf-8?B?WE16L3RKdlhyKzdHUmpwSVJzTE90R3hFa3FqU0MxT3RTRVJjMlo4VFBPeHdN?=
 =?utf-8?B?emZoOEoreVh1c1R1WU0wZkd4L0tMdmMreTUzZXh2eFZmODh5WkZqTDNDYjRL?=
 =?utf-8?B?L0JlWkNnVHB4SS94K0Y5bXJaRk9pMmh1MmJaa3pONURyUXI3c21WT1dTQy9X?=
 =?utf-8?B?bU1scW1ucGlMUG9vYWRmVXhrc2pMblVuS2RIUGFERXlBamplNlJxRW1GSDlE?=
 =?utf-8?B?MFI5UDdoUk9lTEVpTjF5c0t6SHJOTFRnOERNQ2QraEVBMHovRHBrb2VXWkhS?=
 =?utf-8?B?Zk9vWFF2U3JRZ1paa3hRTmJIajF6cm11bm5kSklaWUlGYTBudWR3QStXZmsv?=
 =?utf-8?B?ajJqV0tPQXRFQmI5TzlEVTRzNTZSU3NTUy82REljYkF1QjE1U0F1TnFNV05u?=
 =?utf-8?B?K2lIbzF0dk9YdXFMdmlMVmhaTU1XQ1VPbEh0ZGRmZGxOQmdJYUJCYmR4ZW9Y?=
 =?utf-8?B?T1p6NFZ4RGNvMGNrNUluR2k4OUErWkxFSUhGYTJwUFZaTnJ6V1E4K05ZVkho?=
 =?utf-8?B?Rk1zeThDK25JM2xKQnROS1EramZsOG00VFh0R3hFRUxLL3dsU1dHbk9ick9T?=
 =?utf-8?B?Q290UE44WU12NlU5NEplUi9oNGpiVStBa2Vod0svVUh1cEdvMW0zZk53dlJo?=
 =?utf-8?B?R3FIUkNuTUE5SE1DMjU5eXFYcDNPT3doWmFiT2ZaaHhNZkhlR0QrMXBlUVlU?=
 =?utf-8?B?NmlkQzU2SjZVRzBMZmgrSVpOR3BXdktKNzM3NVp3OVloSnVoT2cxTjR0YlFV?=
 =?utf-8?B?ZXg4cmYzQ3JvL2UxWGZtTm1Gc3dGVGVtY0RobmFPc1gyUFc5QjZpeDErTHFr?=
 =?utf-8?B?emh1TmxBVEVqSkVnbCtXQ3BkYU5Kdlh6amt2ZFpCMTBObzRHY1RFV3dCMUM5?=
 =?utf-8?B?T0I1a0NQZzZEdFZndCs4MFhNSnNhRnRvQ3E1bERuVVBNT3JEU3BrWXNia1Np?=
 =?utf-8?B?bENWL1FsWDk1clhTUFRpQzI3bUR0RU93RkRxeDNmMVpBamV6b3VJQ3VKRjNE?=
 =?utf-8?B?eTdKR2pocVlBckFoaGUwUnd0Z1kvalQ3MlVSZktYVEMvRDZzQW9Kc0l2S3pq?=
 =?utf-8?B?UERwNXA5YUhxWEE2NnU4RGpYdDlKQmJ2RnNKY3JKTy9HT292RUVYWk1qZEp5?=
 =?utf-8?B?b0JiRW5TR3VTMnF0VEdsSmNiWGhRdm9iRGlPSTVkUnhKNjVrU0p2U24wRjRC?=
 =?utf-8?B?KzZ2dFlwZmpZQ1hROWNhbUlqaVVwN1FsdjlnR3F1WFB6SDNKTU84REI0RkNp?=
 =?utf-8?B?V0NnTm8xdlVZWVlTcVQxR3hJYUlaeDZtWVluMzNCTGkwMDFvQW5lUmJOVytU?=
 =?utf-8?B?K29QL29pR2F4WHVrYnBrbk1GVjNQc3ByNVZrSE9DbFZFR2RvVU10QjlJRGk3?=
 =?utf-8?B?ajRRcGIvMnJPNVlUWkdFVXFRdEFRV2l6UXdMdHBFbXBHMGpQYUVTb2ZRYlpY?=
 =?utf-8?B?NDRzUUZLNUtHUGQ2MStBUWRkTHlwamQ5T3pPYnEyUjZFT2VOQ1NQVS9vSTVN?=
 =?utf-8?B?QU9PdHNoMVFuT1Uvbi9RRzk1VmMwT2p3aGsvWS9McGE4VkZxS2FaaitXVStp?=
 =?utf-8?B?WnVPZmVRTUpTRnV4cmtGZCtWMUp1QnZoLzhNTUsyc1FVWHJNYzdnTzBIUVla?=
 =?utf-8?B?ZEtuQVJ0OU8weGwvaDRTcVhTbFlHYXNGYlVPYzd5MnBsRHlXYjlZNW1UNnox?=
 =?utf-8?Q?j9N7PSds8A9bweCFZhzH0XOuJ3Y55jVhyEgJZOB?=
x-ms-exchange-transport-forked: True
Content-ID: <84A1519066413C49AF9DDC7A5FD126F1@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b04b52-f6f6-4384-db33-08d8dcc96986
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:48:08.2712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2NO27srpjPIdEcd+KO/c1Ya/9//UGz/rro5PyYCfm5SvGlpLMeSv9dpSmPfGnhynL69ki1Po8nRTMgpYfeU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3900
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_104811_472165_970D53AB 
X-CRM114-Status: GOOD (  19.85  )
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

> Add a helper function that sets the default kato value for the
> controllers. Along with ensuring a non-zero kato value (i.e.
> NVMF_DEF_DISC_TMO) is passed to a persistent discovery controller,
> it also ensures a zero kato is passed to a non-persistent discovery
> controller.
> 
> Signed-off-by: Martin George <marting@netapp.com>
> ---
>  fabrics.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index e38657e..c780040 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -918,6 +918,16 @@ static int build_options(char *argstr, int
> max_len, bool discover)
>         return 0;
>  }
> 
> +static void set_kato(struct config *cfg)
> +{
> +       /* Set kato to NVMF_DEF_DISC_TMO for persistent discovery
> controllers */
> +       if (cfg->persistent && !cfg->keep_alive_tmo)
> +               cfg->keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +       /* Set kato to zero for non-persistent discovery controllers
> */
> +       else if (!cfg->persistent && (cfg->keep_alive_tmo > 0))
> +               cfg->keep_alive_tmo = 0;
> +}
> +
>  static void discovery_trsvcid(struct config *cfg)
>  {
>         if (!strcmp(cfg->transport, "tcp")) {
> @@ -1401,8 +1411,7 @@ static int discover_from_conf_file(const char
> *desc, char *argstr,
>                 if (err)
>                         goto free_and_continue;
> 
> -               if (cfg.persistent && !cfg.keep_alive_tmo)
> -                       cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +               set_kato(&cfg);
> 
>                 if (traddr_is_hostname(&cfg)) {
>                         ret = hostname2traddr(&cfg);
> @@ -1476,8 +1485,7 @@ int fabrics_discover(const char *desc, int
> argc, char **argv, bool connect)
>         if (!cfg.transport && !cfg.traddr) {
>                 ret = discover_from_conf_file(desc, argstr, opts,
> connect);
>         } else {
> -               if (cfg.persistent && !cfg.keep_alive_tmo)
> -                       cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +               set_kato(&cfg);
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
