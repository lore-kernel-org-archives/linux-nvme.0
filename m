Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE4C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:44:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8787461420
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8787461420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VlQtQZkHWjXsPwt19nBP0TO96bTXUWwMEuueYgRYaeY=; b=PP9QcOSP4UoYs02EVPJZhIoyp
	tyTbPKMiCdYdXB7QCLt32/3htyK1g/JWU+glWNcc95+yWEZtUCDNFlYznOS5X6jqczuWhXd00r29d
	4vZCyT2hPEgJMazbdT7Jlvnq1eSLEjJuDGpei/GIQX8Gw953OdC+ZMEumxufPfnzIaRSZD9MuY+sn
	Tj7PaJxyFyPQ5ZhylE+X9uqAaPuMS9o84UhS9bnf9SHgGdhCR1X9+5CuWc/NxphNJWpZ1E4c5HR9S
	sPuE8DLNHRvLX8RqGMDEsmPBmYHRW/NQe6u/3HeS+IPjDhIYdLRSuPjAqLdk4itLxJE7zFBjn4l0m
	NGzjADVDw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbpA4-00463t-AM; Wed, 28 Apr 2021 18:43:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbpA1-00463R-QM
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=awqBZwNdkCaK4W7YEEmsAi/Ti1xeK977FlKq3EWEQCs=; b=gqwokgi6ITVyMNv0Z7NJQVl9Kl
 kTota7jBqTtqQR8QoVw6PGZ4trb3v7QWwHektf59xI6fkvgpdR5PxovICndz8KVeSVfcArVomkZhQ
 rAcLPQLJgOTKBmFs2QsU3C1UvCQQdOAew7Cm/CT0yyBJE5FfMUaxbic7ZLc75bT/Da1ZnPN+KLP/Q
 LTDZC1qb5oQke4skWqigAUFx+2eIqN4dYfsNt1+WxL1tsQAU4Xff+tsmU8nCFNktO96NAeLC17Bu1
 uxi5vdotefNq6LULrcMlF0knZ671P5AlDSMxzuZllbt74QH0wg98A8QmMFCRDnSGyPe4cijXH4jAr
 UqoCGxmA==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp9z-0007Sz-4C
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619635425; x=1651171425;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=puTqNlWg6wvioAyDKv3qSJzVJOei9BSOTSUQ6eWgK54=;
 b=L1HrjPgqxq77VzPkjUAITprTyRexZNkOHBHnZ/amnHNxnsQ+iJ8x4w9D
 VZ+32qqbXvomnPeicTn/5KEAIDaEN65uX1A+2wy2bfLh/RPv944YstPu2
 6DVTYFgpqWW2RyWhggEfTzX4a1Q2MqheQ+g6WLB53EIoUVJdTbseP8bHT
 rlXtbO2UJHQ+D+aWAKSC3oQLZiTiypcGk/2TMn/oDtuqED0eISE5fAotq
 Ec3Ng2gvEeu1EKPbbHFSSo1ILiLJh+LnPBYm/Z4DMlBnG+SxICwbxx7NE
 jy7/pp2b8GeyWbvOKsbjLopCHM64QxNuRhSVgPanoumjLCOZusyEnwIk9 Q==;
IronPort-SDR: bfw8+f+0qlmK0uA5jFQXcSKLfiMPHuu5zqANTCupOVcI3fOSvzagLEK+0UdAIr2mHTG5uuoCGD
 nV3RucdjhfADYkmouKCZtez480o7YWxDWrTSQukuKtRQq0epPBiCAkB/nU16rgw6CrXXbzYbzm
 vic2Hlk6lvLqDqdq5Q8ffBwT7sZ9jr38jR26fmEjsZmehkcvkAHlUb2GzLiJNBtU06SBlePfld
 0E9Us7sAnArH5VhZva+GmWTj1X2Ekp50DCL5NO4edixSPubO0aZQGfTI0//alBpKEfjfw7j/DL
 tf0=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="270491283"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:43:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqLfOfdxw2BtVQ8kTCgcLNNUqeQttyrMRSSKp5To1A7WMV2UX2gH/CN0aOsEd0iFONEnde1O9volIBG1Hfmstw0A2HCd5PaRCztRzpmkv5L2k6ZXXToYOEfMscRybUktnKNPlnLEOKeiTSw1pyniisH1IO8MdwIEmQqZt+1DnOQMlBICQBBfJ4drZu2ICCjlpKEYe8nrnIXNs8lME+3WjgfugP1bLJPayQkPxII5dfumQszJm05gn7Z0POPNGPiDlwQZbSwzcQI0ZCMpuMlbxRmY0b7zLki518dUudsALOnIPXYEtqVTxjHv7ddZqvWGrUiXS+EFw8YOPQzFpqItOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awqBZwNdkCaK4W7YEEmsAi/Ti1xeK977FlKq3EWEQCs=;
 b=mv5sseKsh9n00/IyN8sTNeuDeLSi0eHquN361Rcx0ca0mlYyQN1GBoH5h84pejQTuMtK4KqGRqy+inH9y/iiatkiy2e/VxvWnevxglgrfBfzfMAMHu6wW4U5WuX/hdalK7f0Oq8dAI9f2yg2KlYQXTK1Hd9A8CoLnjlyg4Hbgjk4aydyiINUmY978Pn+V9QruIYJAytVBJpj74voZ+At7iB9s2VLfZXtR194WNlzjbThed7i118Egzd9TlvrpW7Zan1D9q4Iz6SybFyboyCNz4n0itZO/2ReTzrMObVZy8c3m1/diEZw1xcYE6j/tbVsSqvnobSsGRvmHEGzzfSafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awqBZwNdkCaK4W7YEEmsAi/Ti1xeK977FlKq3EWEQCs=;
 b=BrY/yZbjuVY0XdzDNCVcOn9ID62Mj8vvBxPAdSXgpKxmCuKAWxfH24cjUrNJBSqwGoDFdYrnreWvd782ZSoQ3z6SD4mRGFQLUt0QpBGdZ6/MymGqbBOe/SDG9nzT3uS49Swb7FyKO1d2H1E98Q5k9xviOmxmilCWGVriFj+736c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 18:43:35 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:43:35 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "wenxiong@linux.vnet.ibm.com" <wenxiong@linux.vnet.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>, "wenxiong@us.ibm.com"
 <wenxiong@us.ibm.com>, Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>
Subject: Re: [PATCH 1/3] nvme: Add event type as filter in persistent event log
Thread-Topic: [PATCH 1/3] nvme: Add event type as filter in persistent event
 log
Thread-Index: AQHXOtHtgOPuFl1x3kG63JqSoJyuOg==
Date: Wed, 28 Apr 2021 18:43:35 +0000
Message-ID: <BYAPR04MB49653B853957E92CCD31298486409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <1619459538-3998-2-git-send-email-wenxiong@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none; linux.vnet.ibm.com; dmarc=none action=none header.from=wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6fb5981-eb09-4bb8-3255-08d90a7587ef
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB6549B8C4E9B8003ED45A7A7086409@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAx++jTAllYFeEhqNGzaItbZUMjEW7xxTppMYfnz1nc/ArJs3KBzwJnQP2wf7djIhcsf86tzqNYY4pxxniqIr0uu/e/djIkBg1FEbppkT6LjLNPxWEM/Dxo7HVZ1EqSo1DJNnDn39Kk3j8libF0Z57NR7F12SE/7++lhmYn1KzGoa77hcGnLx7tXuuYZueNPOmvN00bAy2hfizcuhvCZNd7p/uCS4gR2JfjJ9m8vot3h4MyPx7oNYhicypoChz+LIzFOmy/eu9qMVx6q6OrIBYe8vqxHS7nY7sHx8SKe361ckFdteCtAULHTNdd5BxsG7MVptXJ4TzJZOFmHxpXpgQNJfBjcmRFCFYgvWE+2ewCDNbB4oXsKtRdIdKqMv3+Ysm2hQIF6S6zihqZPYSzUDaKl4c9fqx6Ex3YQ/RY5rV7brJd3NfOlnDDEqXfysV90kZY1BuiuCWjm2/7nuMcdUJKjs6UMeYI2qWRm6uEDjZZKRXRcaIKWdoMmZfEVHO6BJnTV+FKL1BM7fi4DUPk0m1j+ZG2CYAbmx5lyP7WKWUt0UhhN0WmDQX/PoqumYdsMrhLQEm+sAdEWF+TE2mp1C2eQj9/c42VGpCl+131YneU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(2906002)(54906003)(6916009)(9686003)(558084003)(8676002)(316002)(66476007)(76116006)(4326008)(64756008)(66446008)(66556008)(53546011)(66946007)(86362001)(8936002)(33656002)(478600001)(6506007)(52536014)(122000001)(38100700002)(5660300002)(55016002)(26005)(71200400001)(186003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RMM89ydbKSAE9Fp1+t1otEXrDs5FKtrNByGew5NRP7Oesxn0HkNm8LeUbHtt?=
 =?us-ascii?Q?e74oDBmGomi93nSuO3R6v8icrGwh/pGfeeh8cy2cvXHR56SUF1xtsY80B6bM?=
 =?us-ascii?Q?QM0fftepQ8ewcOIpBm4sLwlU4LKbNvOw5PT1vWCgfcUZjMldYd8QwcIsYLL2?=
 =?us-ascii?Q?WgQtmN0gu5mIo1iuB8zbT4mieIAA9/lM7FMLNoUtX29m/e1OyY70ff4SHCtZ?=
 =?us-ascii?Q?7hH4NzRq3z0SehVQ9yUolm2/o1qc5WACcwqbEQgxOgseoKig5lZRz1kSICcw?=
 =?us-ascii?Q?pJOf8I+LssZyd6DrbZHA7cKpoO8A55DVo7RETfgAJ/0gvdWsGNOGJ1qh2p4F?=
 =?us-ascii?Q?DpiJHPKrcbK+TfRPJ2DsdU6hJbf5kubRIPADaCh1/xx8wdXqzxggNCE//iXN?=
 =?us-ascii?Q?8LY/vI6RlV9qB2G0q6ELP9wrWipM2l+MAa2EfH3DqEdfNJsS1OLewQsbpOOA?=
 =?us-ascii?Q?Srxe/+zX5g2a15a/k6teH4qYtVbSFKRMhEHU3e/EG/VqxyrZunYljtdiRK8x?=
 =?us-ascii?Q?fxJvonj9zwdKRycijJf0AJNCTkDPUBJNKbV6yPI2mLagre4wxphlo8YxR6Cq?=
 =?us-ascii?Q?7uAhNF/IJou3quG8U7Dh9Gn9jqD132QYA08Nm0PvD090IUPuFTwt9e7CqLzt?=
 =?us-ascii?Q?tmhaf1useqp4CMzeZy7lYINJRn+ODk2W03mU3fJnVRn95F2MuohfKYHeXJpc?=
 =?us-ascii?Q?KEkeAidjMVG04urMU9V5ViBxxOrRJLNznJbSvGsgn3UCkfspA3YHkhFt0rEC?=
 =?us-ascii?Q?OisEqhexQ3OQ4Y6wp7/LoJx/ekx0Gm7eX4KbTcs5RJYnnF324sDGMF1Sn51d?=
 =?us-ascii?Q?wINdb0TR687XTwGDf1O2uLCBPnd72riJby0hPcKORQjexhF3j7GVe1teZqv1?=
 =?us-ascii?Q?kQIV5Ztqfs6vQnot4pX/FsXqMWBnXuFLR3UOhnPTtCqb++MsWQel/ph2jA0g?=
 =?us-ascii?Q?zw8BgBlMfAY500zKFmDh3+rnhPJfkCisIHt/yrB/bqnvDqNJ0mQN/w6RuWwt?=
 =?us-ascii?Q?fH/RURL7vkExKpDQMjhbUZqMFQ29GraI9p+igdPRJNo5KoFugaBl5tfJZg7z?=
 =?us-ascii?Q?/4lGABmL8oDdKchM3B3fHkpjP8zwWhsMRMroFu0q6qjeF6tn0fzdb0SP9wLS?=
 =?us-ascii?Q?SsxGUTEf2sghbQYfpvmm7RKa+YcsjPf/JMavy+IDu12Ilwtq2Vtmq5ZGpwFT?=
 =?us-ascii?Q?lxbkrkGeFaNblGqR6WL/5IS5Fewjj/ntE2g+7hSC66DT7pcp4aBFQR7nzaIu?=
 =?us-ascii?Q?LPYTW9I7TqKN5uiL/gqQU0DVllbZ6xRm77kgloys4u3xjsPwIzTP9Jx8qDdF?=
 =?us-ascii?Q?iTl6rnble1F27Nyh+euwa1ts?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fb5981-eb09-4bb8-3255-08d90a7587ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:43:35.6727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WP6pkCXjo9Lzg82uTxPrQRpti+j0AjOt2z7qkrqS5DOYzjfFwOsL30MdHIHLDMsNO63YluW9le3ZBviizJ4lcqsXvhyJl8nfc2hEyvSR4Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_114343_259123_3599BD90 
X-CRM114-Status: GOOD (  10.35  )
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

On 4/26/21 12:25, wenxiong@linux.vnet.ibm.com wrote:
> @@ -1106,6 +1106,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
>  			"log page after context established\n");
>  		return;
>  	}
> +

Please don't add white lines in the commit.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
