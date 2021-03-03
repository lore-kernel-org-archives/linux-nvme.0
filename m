Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F66C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:43:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099BB65077
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099BB65077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=T+qK+phAA0c9sS5fsX5jw3XgVBKY6ZL5OzAxrn/2uDw=; b=acEy1WCqFTNBzDuUSf2tDn1Ur
	+kI1kx4co/L+qgXkIhJaW+0nI1xyCqiyEYwFAtIsM5iJcjYLwmUZvKvk5h4jYIuPT+mcVbBmym7lD
	raFAVKNQfBOkyK2Lj9mc3htg9y4qUDPfZSPsCXMJbxZRF6vJNPcUGk23j4paobXGPHmavbhtDz+FO
	aLU2NJ8JW9E2WKwqvOnIH9YWTiNuyoVcfdlHZ9xp5hDeiYvgGCNHkoopjqV0EnWKUjlILc00qirMk
	Sp42aAd0+kdBEbuamJGa/C6eZyce7asp20mRchIg5QzGp6ICORFAk0L80GmTvTLU3IbiPH3k6ddCx
	2qrUn6kuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHd1H-007N0c-GA; Thu, 04 Mar 2021 01:43:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZ2Y-006bAm-Lf
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 21:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:In-Reply-To;
 bh=ILBmqsm/focuGrnhcL62oLb/QKx64V9SrFS+vPct3d0=; b=dmYvC9185aowqRhwlF4NhMgEvF
 lv1AKrPVIXOvXFUlwKKW/5w4TGlQrW8kF0lTNdGFqcPwPhjmDnygg2ESM5zfqqafJUY2XWbs/5XGa
 W6JvVmavC8cm6mV/UF3qAYVEipU17NlBBxrIlDLgCpEA6dWRZm3bcvVHFx4775ECVe67jjpCUy5pO
 H9xNXYsPO4pcHACXgIiQd+XHclFbfW5gyYbfZlDRy0C0CtYkhCJju4woxjTAoflbDVtotyBFjGrch
 JO+nrKU/h4xnf5LLknSQPzyn1Dt4Uw6T3VGpKDMMSofC0w9h++Fu4G5ZF/fuBUskTfMWK5avn273m
 TXtE1K7A==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZ2U-004GF8-Ob
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:28:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614806894; x=1646342894;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ILBmqsm/focuGrnhcL62oLb/QKx64V9SrFS+vPct3d0=;
 b=IUC6S5Q6VNy8olEMrSj4BKqkYDn1hRR+zLrApAmy3I8BsrmgMD7bXZuq
 Dua20q7b/bskYrOjuVl5zd7Fq3O2O4LkfndJVhX7PMq/45OeO+sfxiG6m
 HqPWyvdUxgDPUARQDNVl//nFgx82nXM9HsqdKeG3c7StGZXTs0zT8xjsi
 IV6v3lKQJ4bAtFHwIKy+0fdaBHF4NNl8IipbbjxGP9bE+7pxYSU8kfhS8
 EZKlJraq3PpEEsfTf2UrYroU1o3AHEOS7yEXfoJdgXGueXrfs5UmgopiM
 I8jNMjJq8PUDdlGjwWFePX/ZJBDf7mitjEnhbs8vr9rqslUqcv98X+PfM w==;
IronPort-SDR: SX07ynODvrqpmCkTO1330+3ioPBuXA4s03c8wbX5LSNkmbuJrzY0ntDaCrSiwBYCqkyqaX+CF7
 D8ogbDbg45agpc7s2HctL+DR/owjlXCTkF4Ts//PhTQiCuyunQ77RfMoG4I0z0s//qhiTJqyqw
 NAFMz/q2YCDSllpnTrHnuvU/nCLvS0FWSffiqoDaxUCPo0nVFQ2cbBmJSBHqnXlmyTQNB68+W1
 20jusTtAUPU63EQ4MDocq+7A8yg1g62qeo5PvdvKPYvh4oASgpag3bH5guafpU5B4Gz2qIhPdg
 3vM=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; d="scan'208";a="271912062"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 05:27:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxe1YANw+w026hYtoSxvtGPfDh+bdw0jWhtvRaIYVS0zV8WA2Yldfo2Xc4rrVTAj4KRJmJeIWctejrFECQy60+2AxA/DxYc7XMtqRrvg4CRVqL6aaYri6QzBky2z9w0ZmVjbUjQITMV/1c2ri4pEVDGN866AzDaBeyl+Rj8ssgmPP40yIsJmJ2P3HC9WTNi7FDzRjIeDDbDkydYq0B/8gHbKJ2QHbb8DCIWKEnDuDwwxG5bUdEcp5l2MFD5JgRmurV4haH+W5OD/QUR1VBze6KaiABU0wa3AdYyPfa9e4CP3iM3lk0tZdeiSMzQfcqHgMbBF8zICIHbOzSlw5TUKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILBmqsm/focuGrnhcL62oLb/QKx64V9SrFS+vPct3d0=;
 b=dy7lJqoUcDk5k6ISILgcTVt2wIHGqdknzyYFu2uPZozB4x2qAiPvUrksxCuIMoPNYTTm/XIETK0bdY7TsyP1CKeuyTSw68SFb0A7ty+aH2kVy/aGlrnLCfxtS1EMG0KPCK5l7b6Y/fGIy6s9Q4s4i9j0q89vmvhpBWuVlXTiO4TrXtsZzB6l+ppmoXYPQ6IPNaW6yCjkYe4DpCzijXBuNMwUuppU675vVqNn617SeZXtKpj8SRdHoFE9PYnD6wm+8MzLRhgli8D52e5NSRT5YEC8tmg+Opk76ykZOTg1tjaCYegBRdHBjw6a9iGfEif1GiLvWmGAzNjLLD9MDp+67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILBmqsm/focuGrnhcL62oLb/QKx64V9SrFS+vPct3d0=;
 b=tpHDwHoqudcBW/DhaWCNhH5iW8+U7b8WUNMKvPi/TljiY/8QhiZQJ/hYuh3ALyC/8m/2dEJsPm2LU/ZYWidieHQiS9lI5ptzbwawphm6VjUmyXAbIa/o3C1AVqqpxeg/0q+cZzOVspMGjIrMxFSOwA3e0+RaE9sK2RvK8ojndMY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4663.namprd04.prod.outlook.com (2603:10b6:a03:58::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 21:27:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 21:27:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-fc: simplify and fix nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify and fix nvmet_fc_alloc_hostport
Thread-Index: AQHXEExfl+HdVmKvn0KqiJnOEhnrbA==
Date: Wed, 3 Mar 2021 21:27:57 +0000
Message-ID: <BYAPR04MB4965D13975B8D3AB19A9DF7486989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210302112058.24630-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54a07105-fff6-47ed-9fa8-08d8de8b36bb
x-ms-traffictypediagnostic: BYAPR04MB4663:
x-microsoft-antispam-prvs: <BYAPR04MB466387B11F6874AA72B9F20D86989@BYAPR04MB4663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Dw+zOLG6OIQohTfizeUxo8V+hqn43fMHYSFEUXpAs/ZbkDbXGINlAKzJluSttmtdENOrKBwpHDXBqoI6S42ENrnnxgh0/3FgHukjEuzQOGQ6BwAHV7u/H948YxosxkUMkvEPO0dgPc619GibuB3s5AM8oybRFiFOuZseOuIuTXC6vCHxIalY+o3xTqrHxNwgdBRnVcYSmy+eF9ewLmGeQyKjqdxKeeCQFaY9KQvXBwkUnI9k7uGqakcR9KN47d9cWQ3VnnYJjhER9JgV/XLEGNFwoB7rfDQoB9cV9+EtIzSbQUNbM9CSd15bxj/qxrBy7wQCxI+YHQkSjL6EeckI9r2nAsGOlCtXAAWUfOHRxYk8BI7Ou8HdNgB+EzfLLDrdc5dNqeFpU4/vbkvulwmywBZGaIETJCeS1RqYKOwR4alOEX7XQw7SBrHGVkxeykaPxWz1weI5v8a9YJdbR8PsjF3eEv9P2opxIRPSTCm6JPly8pw6uEXD0ouYiRHOAZmq0nOB8inmDGuD2bYQ1KI3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(5660300002)(478600001)(2906002)(8676002)(52536014)(71200400001)(33656002)(64756008)(110136005)(66556008)(316002)(66946007)(66446008)(66476007)(55016002)(558084003)(26005)(7696005)(91956017)(76116006)(186003)(53546011)(6506007)(86362001)(9686003)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n4McvjPUPy3z5gZ9nkux2fje5ltJsXkcuuEkSF0BHKOa6nfx/FATpN6rIRc2?=
 =?us-ascii?Q?NdHHwnO531HA/td8bPpNXi5vbTcZnYdCIF89t99OwQ3uS2t1fxibYMGEL6MT?=
 =?us-ascii?Q?en+4BayMRVEvpqrMlpeTauKnECo2bXmBV4I8wNXvgLPauDMrMEf572u58jRB?=
 =?us-ascii?Q?3/bxIcnEP6V3StD8APKHP4Bs7EaHJ9X+LSbQMxk2ROq1+huvTw29aknJxdCo?=
 =?us-ascii?Q?TUR4nrps+U+Hpjdi2i18wSyADFsw5ct59yYQAlLOb9EjPJXHbXlIAj16slo1?=
 =?us-ascii?Q?FfkUk9DIw+vQVF0G92+3keXN8C14S0dLqlR8zIVYw+0oPnqADzJpbVbwSWpv?=
 =?us-ascii?Q?t+5Ib5XrIJhroIVRLtQtPg5S5ZS7cixy+auVno0oyY7ym+BOl0o1DlozI4Gv?=
 =?us-ascii?Q?ThlYeRBCydEmREkm637EeaD/nYw5ahBeQV8loVETC553WzOXSLoRm4j5ehDr?=
 =?us-ascii?Q?/d7IvmSGFVv3HUaDVOE4mg2fRnAKodjysfBi1fblAC8G2jOKOFfouzJRF0QU?=
 =?us-ascii?Q?4g7IFlwELqRigHEAQCtjNnNPz2Jh1U2QUmWlkGFFJy46G2GsG1cmxIymObmC?=
 =?us-ascii?Q?UrV8EQ/1CvC9RdkWMPA1Rm3mJym50W+zDn61c/fpiMnKLCl4m01q4i/5D9p1?=
 =?us-ascii?Q?zJO7++TE/EKYZmdZKiJKxLc0z9icSCe7TsIxpeY+fH8i1CJ1NIft9gwLjxbt?=
 =?us-ascii?Q?y/nVlkPX6cYyI+8oaKaa1u7JkNjG7dJUWllDYtph+oSXub5RFrM3TM03yok5?=
 =?us-ascii?Q?56OlbePfiQntYdFiQw1IV+NFEtpuFw56gpZP9Ro05Vzna7W+G7laojxkZMs1?=
 =?us-ascii?Q?6W4DQdWl+BZncV5GjgGHIj8Z3XiWtmRvl30I4cdGMvyUPjnojCMwYkBry2Vt?=
 =?us-ascii?Q?A43EUVsr45XezJnSSCLNQStf2ym8ep3Hq4c+n09RNJlaD5pC50XV7cgV5YZe?=
 =?us-ascii?Q?rFHuiorlpf+n8aC8fGeKVrUxNAuaR+aMgqfHATJDSBnbxK8YBhN+mxQKp7km?=
 =?us-ascii?Q?K/CnXXBZnGXppOpx4njCMDQhqkVo58rSZqDN/isWn4NxVlklNhhVgzahp82a?=
 =?us-ascii?Q?IHxvz70s0oZmMJr+mp+DRiZjxsBI54CIdiVwcEPYPp5RuuTUZv0CzhFcqHve?=
 =?us-ascii?Q?QKZRmmzvCnVJkl+OFqAWJ6Tts6jrVAhuag80YcPCN69DDzdnTZ6PsTjbc8uD?=
 =?us-ascii?Q?9V3eLsgjl8Z2EqGZol/4+/Wo3iq6Iu+BqBs4uEoW2ivjj8LNbty0qnW+RBYa?=
 =?us-ascii?Q?JPYcVdlFrNhpImbds2mF8fDeo/a8qWN9//Fwj8X85UtCD8tAipCpP86BTaCk?=
 =?us-ascii?Q?MmiLT1XOKrB7CaHb1OSISaXh?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a07105-fff6-47ed-9fa8-08d8de8b36bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:27:57.1702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnpMQ/Dygo8HxcThhck4Bmv3/kiBEYOmBP/40mRtkEV1VCKTeY6isWnQ9jXtYuKnDnFSHvuwROd+MfIbEVUly69Ql/BX0SrPhTVtkRtnZrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_212816_357082_4F595890 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
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

On 3/3/21 08:43, amit.engel@dell.com wrote:
> From: Amit Engel <amit.engel@dell.com>
>
> Alloc newhost only if no host has been found in host_list
> Add a missing tgtport release reference
>
> Signed-off-by: Amit Engel <amit.engel@dell.com>
You need to CC James on this patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
