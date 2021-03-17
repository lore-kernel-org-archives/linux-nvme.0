Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA01C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:58:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF13F64F26
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF13F64F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cnCCgId+f0TohgKIviDq1NPW36sCWFILwMBZB3bSnMo=; b=jNZZnuZf1vBbpU/fLBf5tso5r
	TvEuIZ7I6h9J8shGiVAZgowIbfnPmojbEsGoRbdiciva9+31sBX4tuqG667xyVkBxp90Su7JcVwrF
	B5G3S7uHNWIxgD8U3814kEJBNL2XiiQlhpHP96I0DwAQVXYUwCKZglqFXilttgMhb41z9cEEKUVKv
	A/QAZt/48gydR1ApcRcUPM1jgEyCI25gS/bLkdQGy8kv3NvKj71cDn6DWMNPT8Mxq0V6cKXeORPm9
	MeM2vV7CsQ79OBuLZ2D8eENkTyYTbsz1V8rvCtVAyhJngvGFvn5ET+vBb1ykvBczykA7MWjITVlAS
	FT3Uya2nA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMS0o-002o7L-IN; Wed, 17 Mar 2021 08:58:44 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMS0i-002o3p-ET
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 08:58:38 +0000
IronPort-SDR: fY7AfhXux54iyRiahO+elvGQJSXqGKY48eaeCrOXI3h7h/mm8Jt72nmux7pwCMqkqp+t0HqPWA
 afBxFSqAsr6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="188785657"
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; d="scan'208";a="188785657"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 01:58:26 -0700
IronPort-SDR: KA4om1qr9UVF2MSnlMT0TOf22h7Pha3yhpgaxhh3S37AEE116hcbj3BY2daMaMLNno67NuJ/B7
 rj0ShQODSIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; d="scan'208";a="605621393"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2021 01:58:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 01:58:26 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 01:58:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 17 Mar 2021 01:58:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 17 Mar 2021 01:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWYIqTkGZqtbYgmAL+U9rtCWTJLLDSyjR32o97WxtAi6BGzVxpQ/vD4wjh8HofkZKE1szXCeiV46Bpev55c4fD2CHyMiqxyEzS3BPM1rBBTym+EtLOXdPNOmVv1N2vnFtNp1H1UQOJAXY0t+3jHu3G/ghAUB0GYLi8kgltwW189VVS6H5SisAfvsXsXIvYTOQLG7rUZm/C2YUHMr9PRqAN/VpFPsXcgKns3Zp8O7hdTGYAh7xDA9+cv/PbnrVLZHP2Q6wqsQZ8VvNqCk4q/tXH7IobShPumQF0qrSO8/1iPKf6VTWfDwNmjqxOqqT9dXw21M1JMXDIt+E7wORIcpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV7W+Q1/B0fDkI+Bd/v3upgwQCit1fsHJ+Jl3dx708s=;
 b=TABS9S6fmL/igZo+tsM8tOwOYDFnZG1OvWSp2n3DSm9RS1GsFpzdGCLM2TT+a1AHYKb6+SNx003tFO4QsNEk9Qq/u+RSbSa6+WlK6HSvrjr8HCTo8EPcDwwUsuuXBViEV0TPJxGi0PPfximSW4OxPjL10xOq+uocXKCZ/wpd0anKP3SQrCFpKnEpSNPel56kTeNKoscYPAQplg7gK+fWiM8LLtVhKFxW8oHMIJcbhk0GNNuKBn/jTE/Xc7g4rK+W49u5Jrjua/TqrqeW7IHAqsE+DCVwGClTaIvfppLQ2s1nsFSgvmH3gsxIwesoynOoNNDkOPeEOsv3EnhOYphKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV7W+Q1/B0fDkI+Bd/v3upgwQCit1fsHJ+Jl3dx708s=;
 b=nfnFA+RdWPmp1uzWIbmmt8eg0Bp/SWWSrvpPQh6k5mruQMZHrqaESrXqYmW+TBR6n4G6QdscNi7Kjl0gCTy38UhOW6GzOynQiLzPz6sZ4ouyjkDE+GcqE1A8y6U1bV4cCnX5+CHt4sBjTx9zd0tY0dznweWDVGKbjLH63VLFLo0=
Received: from MN2PR11MB4221.namprd11.prod.outlook.com (2603:10b6:208:18d::14)
 by BL0PR11MB3489.namprd11.prod.outlook.com (2603:10b6:208:75::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 08:58:23 +0000
Received: from MN2PR11MB4221.namprd11.prod.outlook.com
 ([fe80::f11a:de1:64b2:22dc]) by MN2PR11MB4221.namprd11.prod.outlook.com
 ([fe80::f11a:de1:64b2:22dc%6]) with mapi id 15.20.3933.033; Wed, 17 Mar 2021
 08:58:23 +0000
From: "Ye, Jinhe" <jinhe.ye@intel.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>
CC: "Zheng, Wu" <wu.zheng@intel.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-pci: add another device ID with stripe quirk
Thread-Topic: [PATCH] nvme-pci: add another device ID with stripe quirk
Thread-Index: AQHXGhfwjw9tsMrjukeBUyR0wKD9Z6qGOFoAgADkmACAAMMsgA==
Date: Wed, 17 Mar 2021 08:58:23 +0000
Message-ID: <MN2PR11MB4221937A2D8E84C1BAF4D4239D6A9@MN2PR11MB4221.namprd11.prod.outlook.com>
References: <1615864938-6757-1-git-send-email-wu.zheng@intel.com>
 <20210316073042.GA376417@infradead.org>
 <20210316210852.GB23332@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210316210852.GB23332@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db0cc30d-65a1-4b28-d69b-08d8e922d225
x-ms-traffictypediagnostic: BL0PR11MB3489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB348983C2D6A5CCAEAAE961BD9D6A9@BL0PR11MB3489.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qkjIVMdTIRw6gzDBvCa41TaiEZIzCJmlWrkh9u+ymxOlJpj93IbAdCgLyfpFkBkHMtU1VKrIWZnAraRVhJ7CJ4u6Rzqc2KBPbcymQdtGXfau/3Bh9CtRpXJ4Vo8yx2+dIqUG2G6kbpN4y48uLojZ2c2bDXL8xfMC3LAD0P9NtEqV8gybA7+fIz1QNdH9X7IXP1PTZJVMUzxh3WY1+pUggTPwjsTPZjFwc1kt08Zna7qR0Ce4BpEBkcdAJccXzl3EsA++KCc8lUgwP3Myejkr60GGPaCSZJPn+TrNyUHlscEca2uFXbQiJPH5I826ngelr+JX3M9k1eWB5m4H5WRtcDBwdwTdwDKvSbY3FHhb5WXRxUlNWqPO2pTrcil1zuejVfVeXj6DrmckkPM61coiy49+TfAQEDZBTVNdaNty5dGzTj/m+lE73G+jQnp73QxDq79ZoOP+QjCWfUQUwoNuSKHpITGtBdnFn52/fw6sBxPGfirjR9f3WFdGllBWFyCVjkJMF//y4VlaAD1OlQgiFTIFe/jxnSsgqHbGV77zy+1flk2c55JVO6TxgYJUqXi3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4221.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(86362001)(66476007)(33656002)(4326008)(52536014)(55016002)(64756008)(66556008)(2906002)(478600001)(71200400001)(110136005)(5660300002)(186003)(8676002)(8936002)(83380400001)(7696005)(66446008)(66946007)(53546011)(76116006)(316002)(6506007)(26005)(54906003)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j3oOnNLzLXa+6Xwn59/zirKTqr7txHizTTGetQcFkuY0LfFB0STE4OS2d5Sp?=
 =?us-ascii?Q?XkiKjm+/Ao2OQM9AqRXlgTLPNfU3pb+KCQmppLPfc2nrleqaaSZP3y8/PhFZ?=
 =?us-ascii?Q?e+MGpqzvUC4lFPsvH3JJHy05b2p/L88hUt1D0MYFFbeLWTRk5K/3L4qbBqbl?=
 =?us-ascii?Q?4S7cAsT2yCZidOGU/3XpuJa8qEGb9264KcEPqnL8TaP1eDouAobPZ1jTi3bP?=
 =?us-ascii?Q?Uab+fBoQ5ryLvROdjmtiSdEtIVzzAV2KRfxJzk87Ak0xINduTL0maWrHDC9z?=
 =?us-ascii?Q?GEevH7+mNX9PRM6wvRtiHbqeLTzvkkkG+OhEASrzkD/w/7uwF182rRFTvtxd?=
 =?us-ascii?Q?ABvoa4Fq8pb+9GUqxSGZnbH7q/GnhuCc2J2Jn3b4MRCRhPdwyUL6CYA/NVPC?=
 =?us-ascii?Q?AtOp3Vk9O7pfYm9hzNLnVSqa082P5aoDAkn3w6CrwbnKDRdOosprFODrA4c+?=
 =?us-ascii?Q?5mp0zJBZUThjz96OVhJNoKukSy1SwAigeM34R3dVVI9vGicBVHLYXahtmM/Z?=
 =?us-ascii?Q?8wi1KpuP/IOt6Q0+TK2WsTpb7NeGK1AzTvRs4N+bu3NTz1TcUfEAaMCToAo5?=
 =?us-ascii?Q?kNMXJ/fkhHHuHGL2iTN5Ubm6gtXlhinsVteJ8s0C+IJ47HQNt1B67ZqFrMNC?=
 =?us-ascii?Q?FP3L1unAkDPlzVOVaG3k+wU3eP4YV+CZJ+mhzrw+mUYpEEUWmZWJmtiTVZ9S?=
 =?us-ascii?Q?tQvbHyAihKJGhGClGA74qQEsmNCDuEczNG3clx3GpHV+1NFOTXOKir7t6YDB?=
 =?us-ascii?Q?pyjmLSL5uMozumxzEowxThHKk4PfrBe2N6r+c3JBSp1aBSSxyKIAna8kmz5E?=
 =?us-ascii?Q?/qF1WQmm11SC610apu7vkMQ+ysxEWwu2blW0uvZoTVJDaoVsp6CdnqB3/wzX?=
 =?us-ascii?Q?/v/rDzeJMIgTPdti9H3qAihkFOY2V4t8t8dwMlT8J+7yZdItEiXXdydtLWjD?=
 =?us-ascii?Q?bAVC3F0dGhj9qLJWrN3N5QwJ5TCqD8N+Se7o8i2nkjI7IIcj+H8gvv5AhBQr?=
 =?us-ascii?Q?Vz2zC/1uG9wT/fxlRWCEsd0aPMuHPNaJ3FQxUxEZ27xWp2WzReiXy4v1NvX2?=
 =?us-ascii?Q?cLgDsYq9gr9GqUseEQpV04ASon1zxUe2bJwGu+G8MjP610HU6UlpR4k6lgm1?=
 =?us-ascii?Q?1N+VjUfRUFvE33zltA8cHzJlupxNUPK8bxI/Ugpm0G3Xvn/7agF6a9lPkXBa?=
 =?us-ascii?Q?C9UB/b9W/3cFQY7YkrGL6c5DLxIJLT/bedWIrR3s0CI1u8v3hj32EISHwNfP?=
 =?us-ascii?Q?60qgxdyscOzUgAw6hxpLdyQ2z45bzvf1iDbSXP8R355uFZUL/hg+HB8AgxLO?=
 =?us-ascii?Q?YzvKx+SEeg1ZbxOi2ZQ9Q0G4?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4221.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0cc30d-65a1-4b28-d69b-08d8e922d225
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 08:58:23.5540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGrpKNdibFOvWOgL4n06nB04pj5HU5l6DKKBRYN9DzPYvaluPeB5L2iaYQNIgmUmuucvr8iJuXidEXIiKoJizw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3489
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_085837_009852_1F233692 
X-CRM114-Status: GOOD (  16.67  )
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

Checked P5510 and it supports noiob field. 
nvme id-ns /dev/nvme0n1 |grep noiob
noiob   : 256

The purpose of the patch is for customers who are using old kernels. May I know from which kernel will support "stripe" quirk by noiob field checking? Thank you!

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Wednesday, March 17, 2021 5:09 AM
To: Christoph Hellwig <hch@infradead.org>
Cc: Zheng, Wu <wu.zheng@intel.com>; linux-nvme@lists.infradead.org; Ye, Jinhe <jinhe.ye@intel.com>
Subject: Re: [PATCH] nvme-pci: add another device ID with stripe quirk

On Tue, Mar 16, 2021 at 07:30:42AM +0000, Christoph Hellwig wrote:
> On Mon, Mar 15, 2021 at 11:22:18PM -0400, Zheng Wu wrote:
> > From: Wu Zheng <wu.zheng@intel.com>
> > 
> > Adds the Intel controller of P5510 which has the "stripe" quirk.
> > 
> > Signed-off-by: Zheng Wu <wu.zheng@intel.com>
> > Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>
> 
> I'm pretty sure we said we're not going add more of these years after 
> there has been a standard way to communicate this performance 
> preference using the noiob field.

P5510 was a Q4'20 release and NOIOB is 4 years older than that!

Jinhe, is it possible to reiterate to the development side how painful this non-standard behavior is to the nvme ecosystem? The spec compliant method is a simple and harmless f/w change that will make all your Linux customers better off.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
