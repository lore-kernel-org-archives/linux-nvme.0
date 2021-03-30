Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE340C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:41:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F97B619CF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F97B619CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=SL5GNX1qCcjZVKYb+1XfkpVtnG5VYLOpsw1ZAav48Hk=; b=Gsnkn5OAJmS9+FR1cT1lhPm/+
	gf5E3BjTuRSWsCx0237DMWJGSM2EZIWrw5M9/Is9qR7UFZlR/9l3noEqZMEf2J3OjQsARuHBrSo0s
	mky5TXEYN7tKhZPkij4U5idhH2DUiNtc5mbv7WxuYH9e4KVuu3aQzhy1uBbPnwdRTX4odez8odFpC
	4dPDCdnwiT0fsU9s8A/rKSi9BxQtFlvyVbKTpyh0Yz+gDItd7jvmuda6ckqdTdfn3FX+CpRUfdsWt
	otCVHxygJ2J5eHjU3PZDGWMB7vlNEDUANDFQ54A7RWUtlw9U/gscdPS9YqlxgXLa/yWGQEvNyp9Lw
	PUoVFzjmg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNyl-0058bd-NF; Tue, 30 Mar 2021 23:40:59 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNyf-0058ah-Du
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617147653; x=1648683653;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=yfLtmkX+Riq3PInbG5BoInaaDOQD4yEOjDlu5bgAyZY=;
 b=NS2S4YTLtZbDOgRTFtZ583BexiMiIL/q98rNVsG7IszD33TOjj/J803F
 7dnGBa+Z4qumoeGwuzhYFEVcPxAmpirKG/NRWCElBQTPqnLQCfERzR8Nx
 TKbaQC4tfwnNA9R7LokBB0xhVz42nmP7EIenxyLmf998iSvemOZSRD/I1
 9gEpxdlb1UcelI8weDRRfSwwShD6cNSXMqDPVlnT1GtmFqmMn00Hs54Ek
 PliJQrBx5e1Vv0AAigdCHzjb0P0NyN0YvCbLpuXhwVj7792al7LQyutly
 Z6CssjmBraBJ4jhiTU+QJd3sGhRIP1LFoeHkWcb37Nqb52MyNkEgeiEj1 Q==;
IronPort-SDR: s2Ej5nNZJUl5KfScHLb8pN+O1rC2fjoDZeA0xjsXk3sAf7pI95ebzJuM1zzxZ2o7KDpBLfhGrD
 ldUNwLDQrjXtnXAs75sIa1cLfBrS+R3rB5Re3d76andySdD4L11wIAf/vsI4CxGqE/lf4CKsBC
 Y6kNkK9lro3u4P5pb6hsY5CViwfOxVT6xwoBY/mFbAJ3YPfaSHU/nphr9irXCKkinFlAt68w0q
 EB3rhCH50tX5ZRq4aLFX5H7FSsen37mf8ZfJ1+IdLaM681UlhSO8qWX6H/xV6tVqL0Tenrg+/O
 Ufg=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="164445567"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:39:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN5CAS8fu94DZcK7QzZTVyZMRQJjhad2/DUl+/BQ20jIFxFdZnvJp7S/8oo5/oVrQPyBXVmhLwUrtPVrdz/cQ0iajDI8j+F5MkPxUqIA7MoQHLgibV5+UIE0U4z5boby1lAmel9eb0B6fwlVBvNXGuWyd+iHY12j3Y37lzfI5WJCS8eGS+IyOch61rs4FvxaEqCd8CScflHXb3iaPG5RQy5k8P/GRuXawoaHX/0R+jatAh/JBAGZ6mRZTTJ2I7zZ3RNKApPhYXWnLDV2pP8l5boJA+A7n3lDJFuMnY9Ec4qP5975kcbnSQ+SpuqjQy6A1aqSbjSJkkwOW9HpO0guUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfLtmkX+Riq3PInbG5BoInaaDOQD4yEOjDlu5bgAyZY=;
 b=X5urqIcFHrMuaS/ggMwHHA7HHgWZvSB97nyR3t6s/AfsW4xmqJPMfmRzq5G8vBjimjKJRM2DRFVulO/UlxcLiUu6vXL0Vy/TmmqrlajrqQvRtCM8y+svWRRnfSBl4BUTXgHXprkOq8VNz1GVumI5bY0PgUk4NGx7xdrvpXQ04wMO0LPBQejDBNpA7fzIj4N/PZTTtl+TzgbDpMkjwk4Cw2UpxZ9LR6u8VVUXVYTKGbhV79hZHiLEplnL/AM6vLkO9k6xF1L0BtUdC1oZ5mlyzqD3bLROIEElp1d7Qe+Oaww6bWPLo48Pwyadg7rse/z59X+KS5BlS41Lqy3m3gc4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfLtmkX+Riq3PInbG5BoInaaDOQD4yEOjDlu5bgAyZY=;
 b=fxKA4+VZnHrIrpTxRQHodN7ZCbICZe2vyfJhGDvMEjx+2pVA2Vl5VO3nhdcEU9T3xDvGipiuY1Fhyzkq7eHomz+H2Xte1SDbzcGUnKVq89BrUkY4IA9J0QaJ/dtu8Cdh5fqnXdaVi3yQMKetiR8msTLmZAKk7AxvGLVaY6m+xow=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5686.namprd04.prod.outlook.com (2603:10b6:a03:103::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 23:39:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:39:43 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 1/2] nvme-tcp: check sgl supported by target
Thread-Topic: [PATCH 1/2] nvme-tcp: check sgl supported by target
Thread-Index: AQHXJbiftjsKfN1bOUaAz5beVkORRw==
Date: Tue, 30 Mar 2021 23:39:43 +0000
Message-ID: <BYAPR04MB49653C9EB5D027EAEE52C61C867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40aa0466-162c-4f90-a40b-08d8f3d51885
x-ms-traffictypediagnostic: BYAPR04MB5686:
x-microsoft-antispam-prvs: <BYAPR04MB5686F6B476FD16A3175D686D867D9@BYAPR04MB5686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLOESgaPgTQ+A28hpbqeOm4pQKsAn4LGzSiD3z3oSfphGIYY57X8bSDJzqDuOj1waKbFsFSbprFKqAjztwTdFVd5GroassHLYO4JkWl0fsXDP2ZthvINnvS+xLptqLbwFethyITlpbYEzw/+dqycGDH/MJYi8YXpTpMrGUFllTAVyoOD47W19IDmxQxFsqPzj9q8DBZkFjv4MW8eapgYRa6n+SIru+ZqsUBtKdLPYAg52MtyIcJbnErlkcaeHS+JPTbugQaQV3wn0BzmWrs51rWep8IvmCaiqxjWVAjH+DQi3rAGrdMGarQ9Acw+EMfy6zVmeyWR3ttUwkLfOrXfz7leMiyCRr3VwFeTmtLBYDbSrcDaG0VwcwbvMy4VQ33JyvpBOW9k/fyx1U/EGneZ0O7CPH6foGx4yw+0Qo8lOsoMMzzPhUkaZ++7b9Dr6PdycfQCDdvIqmpxotC/UWV/JapDD4NsvHGh1dyOWKfmAIgl61SzXH5Tl5lLKvZMUrezW65HD8//u8a56EqbwWQLhbnATnIj0OWDm4mQ70UEWEOtCU3Fs5QWmf6k01eAq9XwdVgL7DZsCa+Cw7MYUeF0GSyhOZuHDk6hXmwvY1c0GBu50fJ/kAvwHay6UTxO8hGeEZipziEvnlmeUJDv0iCFB+M70wV9oxTNXMFOkIti5q0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(66946007)(52536014)(6506007)(66556008)(33656002)(55016002)(8676002)(9686003)(64756008)(26005)(66476007)(316002)(478600001)(5660300002)(110136005)(71200400001)(7696005)(53546011)(2906002)(558084003)(8936002)(38100700001)(86362001)(186003)(76116006)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vwG1MInpzHs4ClvDQ3+LuVwRWJBvVuPS0guwFb42sBgFkdF0W1EwqAt32qis?=
 =?us-ascii?Q?SO0JKQEv+7tBGPoaJrVH0RhH1bQPt6f2Sve86NKhQ1YIH5M5v8Jf3zjVvTdl?=
 =?us-ascii?Q?or4Vz3Ix5K6Ehl1Z889gslnjgTAodcWKS7d9Eev3g3xzekAVsH7UeAP1jqC8?=
 =?us-ascii?Q?aErWPEKYi1mRPW4PWyQnO4c5YO4qM8d09Xq9jdQnJbwyf2vPM+iv1moKbdIs?=
 =?us-ascii?Q?MFPkDVUMwGn/xD7kV/8VaeOevlv1BEI+tzzxGtnulIUHzZSl+m4riLP7eSKp?=
 =?us-ascii?Q?3ir4zyhIxpM5DdhNQrYW53r4lUWxekhLV+jGGeq90Cpd82eWNkSSdLTW+OdF?=
 =?us-ascii?Q?A5XYVW6gZA61fQRa1ksSc45xuol8eTGd4EApbpTrQxUdswK1oXSXeN8ikseO?=
 =?us-ascii?Q?GHtqbLZfvDapFKZD4Mjp9yulijhyVoz1OAjeudYUUmD3aueoHHgYrvpF1z9M?=
 =?us-ascii?Q?DubDAyNlI3wQ0eP9ew1IavA+Th5+AFnhvsp3vuEn96CNQlcDOSw2rfFXCGev?=
 =?us-ascii?Q?GAT+1XA5Y5I6C5Dd5FzRwYiLWRTx5DDkilfRxO+1DLI32SPKHDXwoEMMNp4H?=
 =?us-ascii?Q?hPgQb25SFuYQmjRXn07hzq/nuM4YGigyRE/96jsoPSNY0NiIzftU/4Re7b7H?=
 =?us-ascii?Q?OXulcHjz5m4ugwhvPEH+k9tOZem8V5iuVGWWJ0StHyxJqEdpw2EcW5A4DZo7?=
 =?us-ascii?Q?fUK3Kfl7wemVwzotwBvzYvUalWE/mkws8kq55YSCmO4YlLEL3obY3NQvN6yX?=
 =?us-ascii?Q?FDbKvUfZCrb9cXPPfZk/DuJXPugh3PilL1Z153Z6HxzkOGFWcsee/eJfWUD6?=
 =?us-ascii?Q?8WZ4CErQnb+06e/DZZeJeX/YODgv+mY/WcFMLTYUcGvVBcAROYWPCXrXYl5z?=
 =?us-ascii?Q?gfzyjv06SlFYJA94oVBZKBtoMSwUiguuOotmkAgPquCGmW9o7kBhVhbn/Xe+?=
 =?us-ascii?Q?wEETwxQRk2HiGg55PGJQt20ZKoOCBzOcPf1HV7Fl8/CfAHL0OE3u5evlCiHF?=
 =?us-ascii?Q?y4Qp5Im4q7+VNAuHvClT8fEVkjbSp9cEQKvzBMwannI3GafAoqFcFEtqVqDN?=
 =?us-ascii?Q?RdjqzvbWX2tgCUPzJzLpQv1jMc+LbVAwZS2dgAaLL8W2XaPZQ5TQ74dw76b2?=
 =?us-ascii?Q?x41ujN9d/5spvFsfoMeFamWuq0EEzyzOlYh/jTb1kvRSxSyGQ9E0OQN4m7F2?=
 =?us-ascii?Q?resI6g7e2kJUBVfMEi4VnIrKgsuUk3HXiLwpTnhSir3nIzlpTzujx3Q/Cl5K?=
 =?us-ascii?Q?3mfRHg36aq2b+OyMagjuislvym5EgBXgbUMIbPQ6mv2Bvj7GgKrnpT3UPhD4?=
 =?us-ascii?Q?89n66flMBYw1ihqrHav6k2r1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aa0466-162c-4f90-a40b-08d8f3d51885
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:39:43.6930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qY0ZM0f4eZ0MYKjjrk7pN66+twrh8lyME+Z13JBelEy6ZUMhtebS6IZVeT0erpTTAs3/y7p15o5g7T+VMfyQOdc279qzuGeX/MhVJSB+cBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5686
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_004054_029068_A752ECB5 
X-CRM114-Status: GOOD (  10.65  )
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

On 3/30/21 16:01, Max Gurtovoy wrote:
> SGLs support is mandatory for NVMe/tcp, make sure that the target is
> aligned to the specification.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
