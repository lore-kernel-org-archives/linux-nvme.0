Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0928C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 09:28:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE38613C0
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 09:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE38613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d/jT1+ZPM0vn5KPfep4nmL2dgJbfLMHoWLWNl/gVQMU=; b=jVg23x7K4JfxdRm7szw98MgDOR
	l2IoSCQx06RUu6RCDtzgyQ456Nq2vW1kax5OmPX9g2fTtsau7lyaa4fqFpDyQeorNWKA5bxig4uTU
	kcGRLdOYwjknEfKNS42mSKeHycj4OMl9RwIoST5PGhtUyYzzj5EFT8xFypcrCJZbURHc1HBbeUymd
	FlVfKO6w+dw2Yez27X2VQHQoagOwmF+i5dlXVt5M7VgFIglKAIbQ99sIpqFJiuLYyyOWGjq9SaVMK
	gpTboK3S1oF1PIiESu9Y1Nk3yjPBMq9nXgbhjE6orYrIeghrg5ruduHOeX6oy/L8et9+UxO8yTpFT
	Fjr+OVig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbgU3-003CM9-UT; Wed, 28 Apr 2021 09:27:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbgU1-003CLu-59
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 09:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=qFsymPUnB7LAuHFWmOeWK7H3souNbTY83rt4g6dsIbQ=; b=l+mfuvQd9vjVy3CaoJIlXMY5hj
 TGvovnF1nCfU6QkqZgy1066NmRU6rTddooHFBaYFdHXxwCyM0LSgQSLZBXj1kYjrjaZCyAlkd5V+z
 abNGWYY5b/QlHh8bt/n8+7RaM6zcQbmAAmSm4MdsFRkE3yDbR39uTvg2XdDVmBGCCUHOgZXLfaWA+
 8rb/gNxNrkTUm5/7tBZGdjdY3K1uXLhgTUcKXhXOlJeT/jkkLZp7MMcwSytNujiG8FpkwxihLLjbr
 DqNggl8+87rHScyU1+accsbrC5hCSxiYgIRynwjJcsZ1ic2xJWXv1ai23hd12NEuhWj2ZoWv/L5z6
 HabWo9Gg==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbgTw-00HJeB-NI
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 09:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619602065; x=1651138065;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=s/iKMci4/QTBFrQKYSmn5Wo6uLhWysvxtQ74v0pcW7Y=;
 b=EAB6Ml7A7Iv1an5gdYWudW4uza8c64tvRqYQb/Wu1415e5gmL3g98EyD
 fgiw+fQfMLYlJWvD+NfTpQ1Yn0aHozCsITC62K2AeebOBCWafqiLIjAWN
 n5/LRu6+V3Gm4LEVIw06GqVMGZ6vIwJjzkmA0las2l9TkHvAa7H2dlAU1
 9UxQy8oFsQCv0D2X/A1TieklGdPr0bX1pShj/Op8SgzKCYo0ygylLzYNE
 wavEg40L1ZhPYj+3TwHd6pCFWi6+BcKcTXu+RTQDrYQWlwdplPxY+KCyy
 J4LPVKyWBwA+EUUEkwI64VSLqV2cc823AlcGTKg5sIGQs5YjvQAHBv49e w==;
IronPort-SDR: nJszunMis1B1+vu/4qFzk5zBt8yH5iYaw6wg6OqJeEIIeMZVDHrMLwtiI6tXVC3TZg5VQyLOyl
 g5ytT+g80U1+EaKWJ5GbkR1bBHV1hjkPdvicOE/JEnkmIkAQuXJkuNg9HO5ht73JAFkyJGKACH
 SUvdX8p3xObIgnTF8HZMvl6Nsf5nxZ2o+uY7LHim22wl2UZS3CQIRzs1DlzieJ2YJtty0TlvdK
 rRvt/Qn318MY6vll8zLjNF41Br0pBiXb4X51Y6GRh5FudfFGv/nO3ErQQdiUV7+cXgTIJfUBcI
 juY=
X-IronPort-AV: E=Sophos;i="5.82,257,1613404800"; d="scan'208";a="270431658"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 17:28:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJLWpQrSfTZ4jtzVZkrcLsJuNJ7e2sLMTU8QH64tRV1vGpVx/jLxrUHASEqyrCriWpt8YsKXjo48uQNiF3ikTknQFqo7q9LKfr3uYG4Ph4G+3A9ms4vXgEvMIuqDEycFJDpwTuY8+uDMIg0RRQpmA5cUYJ+uHwLzTQOgoO2rp02htG561yQxFoErSbnlPlEaeRoTGEqwB7Dinml4VmqRRgbbs3DQmQEAhlHjPfaRN/XmzjQ9LW4/mMaNLLAlC+Rzl7odFk+U9lrgb01p/YO6IxnhIKRsYJpCRWooqfbys5gxOIqwmzihrU7FgZfpnayEyXtU/bZIGOskVi2SSoxOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFsymPUnB7LAuHFWmOeWK7H3souNbTY83rt4g6dsIbQ=;
 b=bvXJNfHUOR5I4Pl+L6gS07DpP68qYrTv6bQFV1U7iU+85KEwlstoobI/mvsPyJqIMq6PoX8DhmdSQSMnmC2n877BgEs6M8ejix4WWyWehkhrs76biN/nXFL7L4l6lyxnLTGssVPaMmFd35cVyPfvxr3KTmp8mLHUT9NpXzHAKdLTxCnVgi24QwcBDW/tcS8aAn+vVvHYPSFQfphOljbBTGfagOwsHuTZLwDYLoVRVH1s8m240sWvtcBcIlHNwPeTMEUbnnK+cqtdrlmEuQpV0KotPuo0QkflKGMsI049SKkr1eR1V8qK/mcaAiSHqVtVulMQdc4u/jnEDPCdU5WnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFsymPUnB7LAuHFWmOeWK7H3souNbTY83rt4g6dsIbQ=;
 b=Spg4PpKfmTXfghbjb2nYu+arVRV+3UK0ELvkDXZrEnM5usyEZYJ2IIYqb95zUBLdxnKMP0XlUuMGnufVxKrKTVQahtFz3ZDrAzcwoKobg2CPD4arvYSu9C1yUC1RzqdJhJ4aOIZRfhANs9oDM3WyQGh1u6rbc6UeLJD1rzwnON0=
Received: from BY5PR04MB7041.namprd04.prod.outlook.com (2603:10b6:a03:222::19)
 by BY5PR04MB7076.namprd04.prod.outlook.com (2603:10b6:a03:222::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 09:27:37 +0000
Received: from BY5PR04MB7041.namprd04.prod.outlook.com
 ([fe80::5d1:dd35:f322:49b3]) by BY5PR04MB7041.namprd04.prod.outlook.com
 ([fe80::5d1:dd35:f322:49b3%8]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 09:27:37 +0000
From: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: [PATCH 1/1] nvme: extend and modify the APST configuration algorithm
Thread-Topic: [PATCH 1/1] nvme: extend and modify the APST configuration
 algorithm
Thread-Index: Adc8C9ro5+f6h5TRSN2r8FB+X7i/AQ==
Date: Wed, 28 Apr 2021 09:27:36 +0000
Message-ID: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [87.68.183.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc0e885-55ee-485d-96c7-08d90a27dc8f
x-ms-traffictypediagnostic: BY5PR04MB7076:
x-microsoft-antispam-prvs: <BY5PR04MB7076F72C1C52AA8BA3BFD5B78B409@BY5PR04MB7076.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elFf3Kc4Oasj23hHDihZHzgF4Hfac11BSCPIojM4872oETVYy79l12NSe/2p4Ko0DNkKoXnaZZgOXwEkhIXtY8ewd9xuytyYXqLjae94jo7qh39z9Zx0mS5dKvecZMjaR+WKf2ExnICr9o5zsrQ/6uwAszXjXkIX9IJrDcRDbi3AmgbnYyhQrrdcxxsRM3iaK6afqSoTWYatGgWTdmX2r2CJm9KD3LrIVuonT1Ode5JNpO1L+lIo6CGwVHGbj+M1LmTFOQ4auPxw+Oy+NybP3O5w745hdQs7tbKpiKowrSrYTAZqihbdTGb8pPLbQDa8efCj0sGg4N6Lz8UGH19C+a3Lqbyus2i+7em4OPCeU8R1/sd7ZJ9hepqv+nRyHIUWmzRziBQbNYgYr5uVaIUnxxx79FjX3bz5JtVSj7iKIJPaHK2qHLrW1gacfMeZuTD1Gmfq2eIQGN7H9NxPNUMOR0CjCBgOh4DLP3kcp+gZIPM9EgSFRtS7Z5Y4tAs0YTetlRj4U+UGQAF07znJ61EtRXvpOYufdlpH8la14dDNLUyick5Nt8KNxkMLei1OaRhgqfVdG6Vj/5EqYNAoqIrdigyHAsGsZhKVqwsi2QJ96qc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR04MB7041.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(33656002)(55016002)(66556008)(66446008)(66476007)(9686003)(64756008)(2906002)(66946007)(76116006)(5660300002)(71200400001)(8936002)(26005)(8676002)(186003)(86362001)(6506007)(7696005)(38100700002)(6916009)(122000001)(54906003)(52536014)(30864003)(4326008)(478600001)(316002)(83380400001)(45080400002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G5jzic911/ii64h/xma8SBqcCwsgRpgB1R2YyVg3kmSJbQbubrSwBtt991ph?=
 =?us-ascii?Q?0ffd9HzXmm6mXGA9wP4kZUy9uorjN6UvVsjJ3/nEkDtiKPfv+c/4gFl9PkZX?=
 =?us-ascii?Q?vKvYJGgJwkblmBBuNHd7gg7D9ioHvy1M+lyQpz0Vqy0aKMCuUio+p6fg3jNz?=
 =?us-ascii?Q?HCMTexhw3vDKykNEwbOCtAgq/6H1kssJoOe7/jt0ob236vAx8msUpOMI4wyb?=
 =?us-ascii?Q?DvvgL/Gpl05NB8HBMYA9/uFvlaZv27x7lWZPKmDwLYc9NZovazYt4P0fPkSl?=
 =?us-ascii?Q?+pknA0K4XyHfy2TBz2s14fR9sCLOyKrdCfs3CtmOSvRsucTNwjawwNDOICfH?=
 =?us-ascii?Q?8qTwJEvc5PBarOo4ymOV9Ga98Qfs2jTBz9v8iaPjnxheA77VCh1BRm264prg?=
 =?us-ascii?Q?gSZTWozhI2WGKeZgdMRXvUdraLn6+CiHmh1rNqzUapSZ6RwCBNkARPZCcVbm?=
 =?us-ascii?Q?9f18oc4Tq0fH6uhOdhOpikQF0+TaVnbno2bZKs3upJvDIYySyNLSf13iexay?=
 =?us-ascii?Q?q2u0biNlu3Bt6pHoVAtFSdre+/Oxm9i9H6evWudhQ3HtZRwAS6LLgMaPuBo2?=
 =?us-ascii?Q?Rjf+/wDlP58RISxoWW5WWoatZR/luTNsqPzu9vwdwZTk3v5TfoTX5ZBW5zLd?=
 =?us-ascii?Q?V8JWWdXd7HG2jegoPxXyCyeeElW7xOTFz2TTvLvYrx5vLOaRcaS7esoC3bUM?=
 =?us-ascii?Q?q/bdI7e+zq48a9F5KTRN1+6xn47qBd7kNNAFiLp12pl3wSE5vkE6i8l3xXMW?=
 =?us-ascii?Q?YK54mV3xqA3paLpWle/0+NAXZCMgAItZEp4jxtXfANOBed4pMhp7NyAW3aOu?=
 =?us-ascii?Q?6MVi4M8aHQAjARTyH34JmJF1x0F+/ynhw0VRFaYANlTfpOTiyuYXhJp6mVFj?=
 =?us-ascii?Q?/DapzzsIFfekWYILRcGoWN41Eg2UsFn442SkHYI7fk3OkSa75DPr91ZR0eS1?=
 =?us-ascii?Q?EMXlDd4/2YkQTq/a3Mj/iiqKjIZnugWQx0g8wsrm4NVcTInaXB0joIFSozXd?=
 =?us-ascii?Q?qYlayT5KW8TdlQbR8ndz250hXTjjIx+LphpB/khMTO50eGG51KuxUPlUuaHS?=
 =?us-ascii?Q?sYm42q48R+RfRy7YE1y61g5fGlR0uVcVEtc73GmgLngCkLniorD6uQcRUGMQ?=
 =?us-ascii?Q?wd9EDdWxP5xPIH4kdGBg0rX9zUDHUAtz2iF9VmkGRoYaDbLLbPM9h5PZf1kT?=
 =?us-ascii?Q?dtYVphwNrQ1MsGaxViks7cCAOMQqe8oyaeyNeDHjn5SAsj98n0rsXi86bTpE?=
 =?us-ascii?Q?UaMCsEBYN7pUi/4ps3O10vSVNVeQntyebc+Tko/D+HB2GZKVvLeuwgaWvFll?=
 =?us-ascii?Q?ChMO7K+oIVnuP3Gf6zek8SMo?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB7041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc0e885-55ee-485d-96c7-08d90a27dc8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 09:27:36.7616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRuZX70NtzE5jfSEKJTKehqfFAe5U2O5m8HqD7r8iquNI5+nrqtc0PVv03n1+Wsj4sKPw4EmLsGu2+yB0f/LA+XNSeV2u66XEC+Sa2Jv2dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_022744_969540_0D195E21 
X-CRM114-Status: GOOD (  27.81  )
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

From: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>

The algorithm that was used until now for building the APST configuration
table has been found to produce entries with excessively long ITPT
(idle time prior to transition) for devices declaring relatively long
entry and exit latencies for non-operational power states. This leads
to unnecessary waste of power and, as a result, failure to pass
mandatory power consumption tests on Chromebook platforms.

The new algorithm is based on two predefined ITPT values and two
predefined latency tolerances. Based on these values, as well as on
exit and entry latencies reported by the device, the algorithm looks
for up to 2 suitable non-operational power states to use as primary
and secondary APST transition targets. The predefined values are
supplied to the nvme driver as module parameters:

 - apst_primary_timeout_ms (default: 100)
 - apst_secondary_timeout_ms (default: 2000)
 - apst_primary_latency_tol_us (default: 15000)
 - apst_secondary_latency_tol_us (default: 100000)

The algorithm echoes the approach used by Intel's and Microsoft's drivers
on Windows. The specific default parameter values are also based on those
drivers. Yet, this patch doesn't introduce the ability to dynamically
regenerate the APST table in the event of switching the power source from
AC to battery and back. Adding this functionality may be considered in the
future. In the meantime, the timeouts and tolerances reflect a compromise
between values used by Microsoft for AC and battery scenarios.

In most NVMe devices the new algorithm causes them to implement a more
aggressive power saving policy. While beneficial in most cases, this
sometimes comes at the price of a higher IO processing latency in certain
scenarios as well as at the price of a potential impact on the drive's
endurance (due to more frequent context saving when entering deep non-
operational states). So in order to provide a fallback for systems where
these regressions cannot be tolerated, the patch allows to revert to
the legacy behavior by setting either apst_primary_timeout_ms or
apst_primary_latency_tol_us parameter to 0. Eventually (and possibly after
fine tuning the default values of the module parameters) the legacy behavior
can be removed.

TESTING.

The new algorithm has been extensively tested. Initially, simulations were
used to compare APST tables generated by old and new algorithms for a wide
range of devices. After that, power consumption, performance and latencies
were measured under different workloads on devices from multiple vendors
(WD, Intel, Samsung, Hynix, Kioxia). Below is the description of the tests
and the findings.

General observations.
The effect the patch has on the APST table varies depending on the entry and
exit latencies advertised by the devices. For some devices, the effect is
negligible (e.g. Kioxia KBG40ZNS), for some significant, making the
transitions to PS3 and PS4 much quicker (e.g. WD SN530, Intel 760P), or making
the sleep deeper, PS4 rather than PS3 after a similar amount of time (e.g.
SK Hynix BC511). For some devices (e.g. Samsung PM991) the effect is mixed:
the initial transition happens after a longer idle time, but takes the device
to a lower power state.

Workflows.
In order to evaluate the patch's effect on the power consumption and latency,
7 workflows were used for each device. The workflows were designed to test
the scenarios where significant differences between the old and new behaviors
are most likely. Each workflow was tested twice: with the new and with the
old APST table generation implementation. Power consumption, performance and
latency were measured in the process. The following workflows were used:
1) Consecutive write at the maximum rate with IO depth of 2, with no pauses
2) Repeated pattern of 1000 consecutive writes of 4K packets followed by 50ms
   idle time
3) Repeated pattern of 1000 consecutive writes of 4K packets followed by 150ms
   idle time
4) Repeated pattern of 1000 consecutive writes of 4K packets followed by 500ms
   idle time
5) Repeated pattern of 1000 consecutive writes of 4K packets followed by 1.5s
   idle time
6) Repeated pattern of 1000 consecutive writes of 4K packets followed by 5s
   idle time
7) Repeated pattern of a single random read of a 4K packet followed by 150ms
   idle time

Power consumption
Actual power consumption measurements produced predictable results in
accordance with the APST mechanism's theory of operation.
Devices with long entry and exit latencies such as WD SN530 showed huge
improvement on scenarios 4,5 and 6 of up to 62%. Devices such as Kioxia
KBG40ZNS where the resulting APST table looks virtually identical with
both legacy and new algorithms, showed little or no change in the average power
consumption on all workflows. Devices with extra short latencies such as
Samsung PM991 showed moderate increase in power consumption of up to 18% in
worst case scenarios.
In addition, on Intel and Samsung devices a more complex impact was observed
on scenarios 3, 4 and 7. Our understanding is that due to longer stay in deep
non-operational states between the writes the devices start performing background
operations leading to an increase of power consumption. With the old APST tables
part of these operations are delayed until the scenario is over and a longer idle
period begins, but eventually this extra power is consumed anyway.

Performance.
In terms of performance measured on sustained write or read scenarios, the
effect of the patch is minimal as in this case the device doesn't enter low power
states.

Latency
As expected, in devices where the patch causes a more aggressive power saving
policy (e.g. WD SN530, Intel 760P), an increase in latency was observed in
certain scenarios. Workflow number 7, specifically designed to simulate the
worst case scenario as far as latency is concerned, indeed shows a sharp
increase in average latency (~2ms -> ~53ms on Intel 760P and 0.6 -> 10ms on
WD SN530). The latency increase on other workloads and other devices is much
milder or non-existent.

Signed-off-by: Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>
---
 drivers/nvme/host/core.c | 89 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f45e8fcdd7c..9768d2e84562 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -57,6 +57,26 @@ static bool force_apst;
 module_param(force_apst, bool, 0644);
 MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
 
+static unsigned long apst_primary_timeout_ms = 100;
+module_param(apst_primary_timeout_ms, ulong, 0644);
+MODULE_PARM_DESC(apst_primary_timeout_ms,
+	"primary APST timeout in ms");
+
+static unsigned long apst_secondary_timeout_ms = 2000;
+module_param(apst_secondary_timeout_ms, ulong, 0644);
+MODULE_PARM_DESC(apst_secondary_timeout_ms,
+	"secondary APST timeout in ms");
+
+static unsigned long apst_primary_latency_tol_us = 15000;
+module_param(apst_primary_latency_tol_us, ulong, 0644);
+MODULE_PARM_DESC(apst_primary_latency_tol_us,
+	"primary APST latency tolerance in us");
+
+static unsigned long apst_secondary_latency_tol_us = 100000;
+module_param(apst_secondary_latency_tol_us, ulong, 0644);
+MODULE_PARM_DESC(apst_secondary_latency_tol_us,
+	"secondary APST latency tolerance in us");
+
 static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
@@ -2185,14 +2205,54 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+/*
+ * The function checks whether the given total (exlat + enlat) latency of
+ * a power state allows the latter to be used as an APST transition target.
+ * It does so by comparing the latency to the primary and secondary latency
+ * tolerances defined by module params. If there's a match, the corresponding
+ * timeout value is returned and the matching tolerance index (1 or 2) is
+ * reported.
+ */
+static bool nvme_apst_get_transition_time(u64 total_latency,
+		u64 *transition_time, unsigned *last_index)
+{
+	if (total_latency <= apst_primary_latency_tol_us) {
+		if (*last_index == 1)
+			return false;
+		*last_index = 1;
+		*transition_time = apst_primary_timeout_ms;
+		return true;
+	}
+	if (apst_secondary_timeout_ms &&
+		total_latency <= apst_secondary_latency_tol_us) {
+		if (*last_index <= 2)
+			return false;
+		*last_index = 2;
+		*transition_time = apst_secondary_timeout_ms;
+		return true;
+	}
+	return false;
+}
+
 /*
  * APST (Autonomous Power State Transition) lets us program a table of power
  * state transitions that the controller will perform automatically.
- * We configure it with a simple heuristic: we are willing to spend at most 2%
- * of the time transitioning between power states.  Therefore, when running in
- * any given state, we will enter the next lower-power non-operational state
- * after waiting 50 * (enlat + exlat) microseconds, as long as that state's exit
- * latency is under the requested maximum latency.
+ *
+ * Depending on module params, one of the two supported techniques will be used:
+ *
+ * - If the parameters provide explicit timeouts and tolerances, they will be
+ *   used to build a table with up to 2 non-operational states to transition to.
+ *   The default parameter values were selected based on the values used by
+ *   Microsoft's and Intel's NVMe drivers. Yet, since we don't implement dynamic
+ *   regeneration of the APST table in the event of switching between external
+ *   and battery power, the timeouts and tolerances reflect a compromise
+ *   between values used by Microsoft for AC and battery scenarios.
+ * - If not, we'll configure the table with a simple heuristic: we are willing
+ *   to spend at most 2% of the time transitioning between power states.
+ *   Therefore, when running in any given state, we will enter the next
+ *   lower-power non-operational state after waiting 50 * (enlat + exlat)
+ *   microseconds, as long as that state's exit latency is under the requested
+ *   maximum latency.
  *
  * We will not autonomously enter any non-operational state for which the total
  * latency exceeds ps_max_latency_us.
@@ -2208,6 +2268,7 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	int max_ps = -1;
 	int state;
 	int ret;
+	unsigned last_lt_index = UINT_MAX;
 
 	/*
 	 * If APST isn't supported or if we haven't been initialized yet,
@@ -2266,13 +2327,19 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 			le32_to_cpu(ctrl->psd[state].entry_lat);
 
 		/*
-		 * This state is good.  Use it as the APST idle target for
-		 * higher power states.
+		 * This state is good. It can be used as the APST idle target
+		 * for higher power states.
 		 */
-		transition_ms = total_latency_us + 19;
-		do_div(transition_ms, 20);
-		if (transition_ms > (1 << 24) - 1)
-			transition_ms = (1 << 24) - 1;
+		if (apst_primary_timeout_ms && apst_primary_latency_tol_us) {
+			if (!nvme_apst_get_transition_time(total_latency_us,
+					&transition_ms, &last_lt_index))
+				continue;
+		} else {
+			transition_ms = total_latency_us + 19;
+			do_div(transition_ms, 20);
+			if (transition_ms > (1 << 24) - 1)
+				transition_ms = (1 << 24) - 1;
+		}
 
 		target = cpu_to_le64((state << 3) | (transition_ms << 8));
 		if (max_ps == -1)
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
