Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1434C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 04:17:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1C82312E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 04:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1C82312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=vevp11qrR0MseqcHr7cAwYmVVOsPZDUCIodaavdp4Mg=; b=Yd7F7ZHzcTf9AeG9qjPCo6r8u
	AwsZ+HsHWTFDn8uS9uvud5dCSsqU4Ghvr7AQmFdiiBWMCi12OH7lCcuftuPMdVeo7Th1G87gdaukZ
	VUfAvL/mxRs6qmY5zVg7d4+9N9qc43zyhNz8fJqez5L+htGSyDeXbnPNDRqa1bEnv8dhPXZGJnQC3
	Dps7wKqO+hatE4apCce/m8g8kaX92CtOPN6VInj2LbSuszJ95b8SUhwF/Dyao8xqhczlITspu4G6O
	jP796/JncI3Z1jxdOtQ35OklFhrVxzqsyHnkC9ykR561rLqIb09XyNWiL0MyjtFCSPPZBBstOyKJJ
	ZsWhXG/YQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzXaa-00083c-QL; Wed, 13 Jan 2021 04:16:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzXaY-00082b-0O
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 04:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610511413; x=1642047413;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+k09t0bD/PijyhvnYyDuMixGOBz6d3hs6k71sNw5NGE=;
 b=m7GXVRjXoNofZeTutYfLhZuYljxedkq4cVz7h/8HELX3F9fhRxJa9X8G
 ZgDUE6KTxyHLfMkkMZupZ/4CQA5AQIFdHeI1g5ccTQpVw1DoA1cLlP06D
 LA1CKN00J0e52taNopV9JWSSB1ysRSSkikP5RYjYr2+JKo1YDe2bYgrJY
 XNKItD2lT0ECz/R+Uebd45qfQAFG0N7b3j0vQw+o41Bau10iyiajcETny
 fbICG58BCBnoHjcmDhR3fzwP82txaKnljfYWpkeWQwhGiXrw7IPPdyysV
 fVmdj2Q2sefaCgrE2xqYKmbFKOAeCMdUnx4GVawKr3LHH5IJXRxiM/wzf A==;
IronPort-SDR: iPNILWbO2NN5lgDE2DS+ZLSUiOVmJsRbI3YOwUOpCIoRLMPlLyTxHbPeE2/DYcqx6htJruCJcu
 Wn4vt1px5GsY4dnlF3xqbyVzSilePX26HtmZQOUAwI2RVY24K4uxCXIvnM++Z+IMFGDcg8FhGu
 BLqpDnSA/gsFxdfFN/0c1QrCSX7BN5fZnRm+bGDpfIzD0FfFdIMo+veXTC4CwNfvy8e6+V/s5M
 hNkDV1oja0wFQndieCO3825etnOJmR+AGgamWUVFpCyA4mqSGNzYEfHgzLGCPqRnYULbd6SVLL
 ME4=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; d="scan'208";a="267606044"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 12:16:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYyfbtD8u3QBp2OfnyQ8pdWres7GyMWEh/WeKWzE7CL3AeMbKWMfCEmYa+kMUlC9X5SSoC+m+7LbhyTAew0OR77lN5JAOgEFWyMKLHNcZs2g1YvSQtMj/ZGLEjLa0g34KyOfblxvwsWZPXzat8G+4v1m+5idEFhrSmO06O+rf+lL0RUoI8a28Lmx3fRLKYZ0Ks9f12DfIVDOSG2XSY9f1j1hxwvWy1hnUE2ZJMMR5EbR2SpBP8QAz/GnQsF7RJgecCqkrHw2clqmzPU/TPvndrdhx/1UwN+TRjlaiURX82v+06nWT74GVy269SgSkd+iK//kkmAt9Tl1n6WYDenfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aav66NQi/DWK12whZJruaJv3xluGbxjHZREyRBlG4c=;
 b=J1wdXWeK16GtyhmB9qS2WXi9kk1s/rz7xjljfqJs6II65MCEZasiPD1HBcIHFKKs1K9bLQygDYArEIk3fkrkBLIQVxif0j5FNGiC1gDOGoqKrTHHDsvOpm5F1L5yArTSdhkB7+xhjM3hyNJ7wK2UY7QMtbYP4h7sgRFiMG0NzxSVS2mvZwPcSSdqjTKuLqLKUAnyQT3Q+L8GJkPVUWwajJMbyGKIVVZ/dCCSGyqqPng7dyQ9dr2oUPbvfuD+bLdjrXrXXOH0x4RJVgsWKHD9EKvbBjs122IIWrzBsIDu7/LHojI5x7EkiXMCpmMXL6u8lXj/JHJdd7iH9rq63/QDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aav66NQi/DWK12whZJruaJv3xluGbxjHZREyRBlG4c=;
 b=HbF6fxdpZczC9qfybSsKgrOlhol1O8U6TA8sXQSvAlqtuIni6+y073CPYgAgVkJ2GyrDfUBQu8sK3BEharEt5b89HYcekRCbFlCeLUKAH4SRollpkYJl53v+BbydkQY+gl1C1CX4h8k/ZobTWB5v6AS6ur7furO+ZvDsQzDkSMs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 04:16:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 04:16:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Thread-Topic: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Thread-Index: AQHW6JssIxRWomQxKUmbANEjg1SeZw==
Date: Wed, 13 Jan 2021 04:16:51 +0000
Message-ID: <BYAPR04MB4965017878A807316A0A1BBA86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
 <20210112072715.GB24155@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ee048f2-71af-4c5b-8ac7-08d8b77a0d91
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6884FB5033F4711C3FF6284D86A90@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JygwEaPzFRsqfhpMqCo40i5MwYMOGOa1qFlHv0pwZ4q9zrFEg0CA79zS2lnmD4QGUur9PzVgcxtkhFFdOBs/dPeAsnn7q+fGfhrBRj8OlPiX4A9kBO6jiRCLxvpWaCFoUyGvNJeUno7/A7n9WyFEEWEvRs7kX9JdHqMgMTpMZvBH1GqZ1F9vNuoVPd7nAyid/p9ae4ryVl9Yj6nfScbbw452fEt+DRIDYKCSpXum9uViwdALfjGShRym/g/wqAeytEaqFBMkLwZhnuSuUkXXGhHWgTg6R3GsWvlKKMkejlrt/f8eRjwzIA/z+WT3H+aYX2HXLFek+bAj+gTcxJpwQN/jIfqf3CoRzAKvrmouwgEZk3QR+L067rRWCCW8x3D8ymA7r1OX0gOPueJWV2x8cA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(5660300002)(66946007)(66556008)(33656002)(66446008)(186003)(76116006)(4326008)(6916009)(6506007)(53546011)(2906002)(64756008)(83380400001)(66476007)(9686003)(71200400001)(316002)(7696005)(478600001)(55016002)(54906003)(26005)(8936002)(8676002)(86362001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OXotQB/jqAyg6XSPUpmvHYXPxDl/dPS6WtGGmnhry/LD7xAiWDrRWMi+/1Aa?=
 =?us-ascii?Q?yOr/36hRslnAhDfY0LVhtCaGb+Gop9hvQY4xvCIusgtRn/fHd5CE/Lv24o3i?=
 =?us-ascii?Q?eqnBeUlMGr10e56GjwQRVVSsUslXoS4waAlXWmUh5PExJj7bqXiKUlV6Eot8?=
 =?us-ascii?Q?Cc0mI0bNIyQVvQUzgJywC/1dE83GydYENRHdPbGwZibZsfrqez8Uz91Fv5Hn?=
 =?us-ascii?Q?JOyX6ySOwG6UDZggubJ8fMH+zvCokUtITwf+rnhQSC6LQYbFMkavYVxIVqEp?=
 =?us-ascii?Q?pnPv9xQvqzjA0ilYIXze88JOd2YHCkVzE5xM8R7gLiP5Y9SQhoDzDqz4br0l?=
 =?us-ascii?Q?7V5FLPMwGhbFMsXEdRcRcrVuBqL/qiyYu3djjTXKLG+xW8jmXPDat7MZal0i?=
 =?us-ascii?Q?SceoMcDKPt3vzPaU9DVVdJ/N0s6MM8jXilj96yUmjWSx16Qr82YbcCy6JHD7?=
 =?us-ascii?Q?Niowg23NuPwh2IvdoIKl7G0P0gExJaaXmkdldgGLrAd3FwOC2Lo9rRtdznMa?=
 =?us-ascii?Q?MXYYazupKIzmyjoXswF2+MqjTuKuA2e9XNGIYZsyFQ6K35gYAECzHd8Ci761?=
 =?us-ascii?Q?QuOnF2/EjkzBe/o9EmL5nHJB/f/85cYE+UmggvWfBO9e9O2ItGHhZxFXO8yU?=
 =?us-ascii?Q?nfHVfHfMfW3q3GL/kJkXsXi0K8r8DZaHVgg99lHOuqzWOaD1/f/adFJOozC0?=
 =?us-ascii?Q?QzOzulLigFu4wcMrAEvPODQ6P2UKD0eoo4tGQNiZO4UMhPtBShPxjMpoA9W3?=
 =?us-ascii?Q?hXJnPyRJHp1GQRZ+WywoqXphDNwnGof9J/ypJtIQ56FhlYpWlp8DTtD8JnLA?=
 =?us-ascii?Q?frAiglVQTr8WfSEhHiGOZdOoLuOUvsmxwR3eHsDEq7ZFtEBg0WlBIfCg7cK1?=
 =?us-ascii?Q?GY4mdThkvr0w7KbC9bQkfB8Lz2c/f1bYgyccfkoO8hokw2hiqNBvXr5Q7YUs?=
 =?us-ascii?Q?Mdid+7uUWfXUV4FFT7vafTa9aCz6RCbjIgL+lvMGYi71iIk075nHPodw0g4q?=
 =?us-ascii?Q?DKY5?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee048f2-71af-4c5b-8ac7-08d8b77a0d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 04:16:51.3287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07gPyh3WWI2GlNisDwdc8gL/4xI012/p0y1QJUNQNjq3EHLVX9SiJaGua3isF0v8bUjPOTQx0IJaYtbknTRa5VSs8MZnNU9O9N9aI4ENoVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_231654_386579_46ADBDE4 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/11/21 23:27, Christoph Hellwig wrote:
> The Command Set Identifier has no "NVM" in its name.
>
>
>> +static inline bool nvmet_cc_css_check(u8 cc_css)
>> +{
>> +	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
>> +	case NVME_CC_CSS_NVM:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
> This hunk looks misplaced, it isn't very useful on its own, but
> should go together with the multiple command set support.
>
We advertise the support for command sets supported in
nvmet_init_cap() -> ctrl->cap = (1ULL << 37). This results in
nvme_enable_ctrl() setting the ctrl->ctrl_config -> NVME_CC_CSS_NVM.
In current code in nvmet_start_ctrl() ->  nvmet_cc_css(ctrl->cc) != 0
checks if value is not = 0 but doesn't use the macro used by the host.
Above function does that also makes it helper that we use in the next
patch where cc_css value is != 0 but NVME_CC_CSS_CSI with
ctrl->cap set to 1ULL << 43.

With code flow in [1] above function is needed to make sure css value
matches the value set by the host using the same macro in
nvme_enable_ctrl() NVME_CC_CSS_NVM. Otherwise patch looks incomplete
and adding check for the CSS NVM with CSS_CSI looks mixing up things
to me.

Are you okay with that ?

[1]
nvme_enable_ctrl()
 ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config)
  nvmf_reg_write32()
   nvmet_parse_fabrics_cmd()
    nvmet_execute_prop_set()
     nvmet_update_ctrl()
      new cc != old cc == true -> nvmet_start_ctrl()
       nvmet_cc_css_check(ctrl->css)
        Check if host has set the for controller config NVME_CC_CSS_NVM
        as we are supporting default CSS_NVM which ctrl needs to set
        irrespective of other CC_CSS values.
      
 



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
