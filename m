Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EA5C38A02
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6dZOCRDUwlXbjgbPGaWs4oyOk9kxKDT/3au1h2Hy82o=; b=kt9gEmKp3ncHLv5G1fole9Sk73
	Y7VBhF7yxxQ1ySHL+6OtDeP46jpfsKoS96QwjB2OfWZzMnnspuuKsT3D5mrtzts1sLASfvSyDegga
	H9K6CxTPBiRDuVftNPXMK7Fku5mhxJA9Sniw4hO2HVdU3JLIu7clCsXzFXee0mGvRdjbdPMJMexsR
	bQZ0jSmIxJ6LpM4XAtMSw5kDPqa3FMocLpvyVWfqhqAeBfJMXdk6lkKecAvTqvEo3vIQoRZc68kIM
	5qcJv1kWBoJcsr6icCF46tdvDAtHx8UVkrMg46HP1OH5oOUIP2OZ+3WFhSbVI1bAx0I61FWXnFRrE
	jJMzrO/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onVv5-007qiu-Ma; Wed, 26 Oct 2022 02:13:27 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onVv2-007qiT-Pn
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 02:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666750404; x=1698286404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m5UkgWKmOJTeOIixF/6j9WEtuOTGQMHDkDuaCC5uEKA=;
  b=guRJ22Ka5aN0ZNExlR7B5bcn8jH63liP5zEX77lSCh9tNB0x9TMNEUck
   nrLEk788r96xBOFb91mIIZywbJDI0E0vN0EHq19TeBticVhA/N+OvxATC
   8VYuBvgTWN637cq+ocBrJAvrRWPJr+Zo7CW7cRJ3epZivw6UFiTZx1f2r
   G3YMHARdG/loSYGRST5wEqvgC5xQScsMXDUyEg2kLPUuPG6PHL6DzO/XC
   Djv81gVlfzVZWw5p3oitQpibxe7J0Bnv5Ml+czOn4Bj06T8w9+m/vE0wm
   EONeZ4vVfB9oAlcgs1j6tploX4413+4VJkFq1b+LviCLKdqVGFjVVDTef
   A==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661788800"; 
   d="scan'208";a="213045406"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 10:13:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmNh/v7R5PL5EVHhgZ3iIkCoB3HRNe8ihHaVc8HWM/yTYDmvX5+lCO+LRKs7JB+ceOi2ayWXhzWsp3eBXjn2PBSDGf7dMBCRwHPnKAKH9zH7d6I+zFZJpS7bUp9336VzefVSqhZIZauVdCnKnfo7CwkHGddKvddFUMs9RCfBWMO9dvxb4cIuK7m0xosB4MRulR3aCHZEHtnuxi63Imb/HbS2+ETkLF94Ul56vsKLPKIkM2jn/pm7qN4rneuGFJDVyoqx2ZAly7s8Z0t2D6yRcbo44tdK7HuQTBMAHpeq5ZXfxlkz6owLZv3WEHrqJbkjjZu5HFWECwGwTeI1jyCo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dZOCRDUwlXbjgbPGaWs4oyOk9kxKDT/3au1h2Hy82o=;
 b=MJe2yO797g3gRtcHbIwPm9xYhsAj7VdJg62DDAhqCPBsWxCcXU1afX2V8VMBjYbzIbA+/FgndoK0ZCLstQrVGrH7fTac7HrgKincwsjlbM4CsHi8VOkkpIUwmz7PWe7iN7KUk1Oeb8nEbzUn7dLtl9tIgD2WR15R1baae2TpJRWO6u9BB0qj4SjYLlUixU+5LiRjZJkUxUAI3ufH0vHbsE8TmJlN309v6U8kKruvp1YAxBVTdVrjXASL/HNlUITQI5x3AFyqEYWdfFQq8qFnOXwhRUwh2ZEPI3iuvijPJRzGs4iI2yb2G+7DE1AbxVPwKMDKzjyGNk2aLdBpVu83aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dZOCRDUwlXbjgbPGaWs4oyOk9kxKDT/3au1h2Hy82o=;
 b=Tl9lbRmX64fywhJsePDlg4Hhx9llYCfXbJy8+GhWp2dJsdNuPx2jAdk0OweA500fUSDJfpbf7jpm9OK+9gYyZ2s9bveENKGZCWucKttRfRSxCbYYdRIU5pgMfnDCVKZ4zeN6zH9M7sZbLQX1CqaLhF8r+ZotWe4o5sX2AcO5vUc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6526.namprd04.prod.outlook.com (2603:10b6:5:1bd::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Wed, 26 Oct 2022 02:13:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 02:13:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: bad unlock balance WARNING at nvme/045
Thread-Topic: bad unlock balance WARNING at nvme/045
Thread-Index: AQHY4sgozFGFnCMG3EKP0AQmcjycsa4T+1KAgAwAHwA=
Date: Wed, 26 Oct 2022 02:13:15 +0000
Message-ID: <20221026021314.rosayvle2dqgbw6d@shindev>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
 <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
In-Reply-To: <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6526:EE_
x-ms-office365-filtering-correlation-id: 2757ef16-e269-4171-0236-08dab6f7a428
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  tld6eSL5M1LPpPmgTIecEclwtx9LN9xNJTustxNXyZz2Yzxo1LrJnO9Q7cq2R1n8ojwfQc6Sw8f3ObPRGnrqjxmWDa9zudmKfgcu8B/uXqXZm80pTJvODdTdzeYcAbQj3I8dt/AwZ5Ybb6MN2W63VpRSLylNrNiMUDrGULMkcQh+mk7bowEQMD9X80kQSKABP+M7JSaNGgzyqufrxeDpDw7nZ0RtwmG3EZI5qC+2VhXLAHdXEYgYRIZGEJvGlRGAeiBzcVnN2MMBnPdNxiY2Gvn/5ptAe0GZ9f9MHuo4QISLFj/IzNxACjbUDc0/WJKL/44ojE+ezeBffZXxVNwRw+Xn3jO94PB9cM9OvfcLYGNTHD0PfIyhbc+JgKlz+J8CZZ+NopMAer/nPLHYptSL+8dCUlpOI0s3C2TA28m7RXc9qEqDA4M2Kc81uUbV7DYU05CpcfjkX+qMnnvMTAp2qxwXoewpY4nszH7/lKNhmD3Jk1un2MOAyu+ss4XcsRzLK+ll0DpA5uGbJ6B5kJ1KT0em0PbB8VkSnB/HFS89HsYLDbJNhqRczao7chFMcxPlJTg5UN0BNoMsf5B01wFry70iFJaaXgb7xH2XuWNkZuRCmla7hOJ7hLU6L5ReA29w66g2Wj20wHR/2xxR2UGsqPRqssLA4rQqHiG5+HzuZtKER90uTDiABXUFl+rgVoBjMDf1zBf8jzm7VR1tqMHqwf+lIFlC4LCUixa2b5IThD/4kanzt60AWW0MjZdI2N5cPCH0xDRnlKgQxtUkh/9qJw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(6506007)(66446008)(478600001)(6486002)(66946007)(64756008)(316002)(6916009)(8676002)(66476007)(54906003)(66556008)(4326008)(91956017)(76116006)(71200400001)(41300700001)(122000001)(44832011)(186003)(1076003)(6512007)(5660300002)(8936002)(26005)(9686003)(33716001)(2906002)(83380400001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?RP52FyT8tKtIzx9OB0pEEwoJr57/2Rfzf9+kKGIVmT22F6jaJ3TKk8SlQquT?=
 =?us-ascii?Q?7KKzJ8LDtYDHMFrSNuLjJy0cdP8+eTc1WObMurvn6k5pm9BwQfaKxerUORbh?=
 =?us-ascii?Q?fMrS2xvpJY+4orjYyxTSEH9JWfJEHFi7trjIudjP3BOykRutUxAzFnzbRKTc?=
 =?us-ascii?Q?eRHpK+6tj5oG72u4ayoYGWYfcOi/zBYCcGTKbUW3C1yAkhUUBGwpP4nivFpb?=
 =?us-ascii?Q?dNheT/Go8ftbTCvkvK9k2/9zwIpZBymTr91Mzl27oF9EQo9BcvYP2GjL3J1b?=
 =?us-ascii?Q?sqwiql5ZKlSNlULAwsyaBvyrzuMjxyTQThlge5w8vRx9pTC02IdROfCSqYsf?=
 =?us-ascii?Q?bXjVPxAsMTewBaOiq5fFJxDiM/angf/andXeNuA5jziq35QmWC9uhtcdMIsg?=
 =?us-ascii?Q?jJ6us1RNzGNqzptxLZUzLEvsNuUCM05JnlvCL5SiJXciHsX52qmlPisD4wjl?=
 =?us-ascii?Q?16HIEZGPUKbOrnCwwKYIZVySQY3NVS3LjxS/jBEJyC6STCJM8BNdF8MI17Wr?=
 =?us-ascii?Q?XNFXTF4RRL+rnLK0FqbFUiWKHMruT0Rq7lB6B1EIqK4WHFI/cLHHvv3dVnGa?=
 =?us-ascii?Q?vdYk31WirT0aQ9YxJP+JqQ0I+mqLVCu/tx5oGvw1Ziqvk2U0kmJUjy6Z490P?=
 =?us-ascii?Q?aHMIAH0RUzUMSnpBMH3/sopbSGscscTrPYHbRBrDitgHFe/9tb447gaMbSM0?=
 =?us-ascii?Q?td7ML/300HMaNGcIFtjA+yD13C1BOl3wu6sieg2LMxMVCk66ko1fEt3HIRUC?=
 =?us-ascii?Q?kOEFe7RaZDMx/LeGotgjCDQ4NEUaESlaUg/D8+tyTasei02ohv+P+pqcDHzv?=
 =?us-ascii?Q?5tTO4aAUsrA++WYCiRXyd5AI1LFqdFt8W0ZKiCCVhsy0hchdaaMdFOkrczAe?=
 =?us-ascii?Q?zNT79xf2XF/yBaNhSES+Bmwe7EK++/GCf2Tq5glTX8eDpCa+xyXdd9IW7ZAR?=
 =?us-ascii?Q?PLozJ6wNDDm0lu1MtAelAIRA4YBeWebXmMB6q99EQK6LCwY2EB9TG1aMKGYz?=
 =?us-ascii?Q?eWjbtbmCsCroOzItnh05fBJHUTR/Xa6UQvfaCc8yLQC3pbcp1ZO6zi8kokBn?=
 =?us-ascii?Q?Vs8LqL4lGKAbUzepIYzRYLMEyy0G13bx4uDlpNQohO8VO9n7nhL/pO8MxMVg?=
 =?us-ascii?Q?kwWBw/dfnc+tT1DaXdbARzu//5mD9xmM5CI5oaMh7Og4zd+CxvLEPdhZACv4?=
 =?us-ascii?Q?OPbkjXbqGn80MGv5yBXLzeue4NDhgtEesGDU+EfU9DCaglLNDxAx5ogmbMpG?=
 =?us-ascii?Q?n/tKORL+2FfFgr3qBflP2nXMjytP6pqeTXsAIqoP2alWoLo7JcNg8H18ddhb?=
 =?us-ascii?Q?AMZXHCxCDCC0SkRZCx29QlRwYq5fg44tKr4SFGm2UDii1HOashdtkgtYL/ML?=
 =?us-ascii?Q?Vj7xSfgyfTuLtSbJgZ6EIvD7IshFI01UYbOVCCjdJWTWZjFmxhSaei8h43UG?=
 =?us-ascii?Q?+MCf8K+XaxiLU1WKbdvVjo2A7RIjRMAMrMVxg8xQ76acEhaP/zNOeFMo/q99?=
 =?us-ascii?Q?bCRxH1r34W1uXzduzJl4huxg0pxQNoTsiC+Z2gemEh8wvpRqhah41rDHwl3I?=
 =?us-ascii?Q?ZqEchnPdpDhQJeh4/ZKIN9N4qPI92WvB1QaT7kqnG89LKQCWFHaNg65xZQn7?=
 =?us-ascii?Q?QRCrA4ps+S8rYADWpCjVroc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AECAED71D1DE9B42A0B523D57D185779@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2757ef16-e269-4171-0236-08dab6f7a428
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 02:13:15.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhTDIeclwlAerKFFtXc8DP7zB0yHnf6IPeKwP7Wca6hfjkQH369oAxcFUqPKm/VWc/oLaZowB/KJP0yRWAoypejDs47gZNkBezIbUUl/LoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_191325_204620_04EDF0A0 
X-CRM114-Status: GOOD (  33.29  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Oct 18, 2022 / 13:57, Sagi Grimberg wrote:
>=20
> > Hello Hannes,
> >=20
> > I observed "WARNING: bad unlock balance detected!" at nvme/045 [1]. As =
the Call
> > Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.
> >=20
> > 	mutex_lock(&ctrl->dhchap_auth_mutex);
> > 	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> > 		mutex_unlock(&ctrl->dhchap_auth_mutex);
> > 		flush_work(&chap->auth_work);
> > 		__nvme_auth_reset(chap);
> > 	}
> > 	mutex_unlock(&ctrl->dhchap_auth_mutex);
> >=20
> > I tried to remove the mutex_unlock in the list iteration with a patch [=
2], but
> > it resulted in another "WARNING: possible recursive locking detected" [=
3]. I'm
> > not sure but cause of this WARN could be __nvme_auth_work and
> > nvme_dhchap_auth_work in same nvme_wq.
> >=20
> > Could you take a look for fix?

Sagi, thank you for the comments.

> I'm looking at the code and I think that the way the concurrent
> negotiations and how dhchap_auth_mutex is handled is very fragile,
> also why should the per-queue auth_work hold the controller-wide
> dhchap_auth_mutex?

It looks for me that dhchap_auth_mutex lock in nvme_auth_negotiate()
simply guards ctrl->dhchap_auth_list access (look up the list and
add an element to the list).

> The only reason I see is because nvme_auth_negotiate
> is checking if the chap context is already queued? Why should we
> allow that?

I'm not sure about this. I would like to ask other experts' comment on it.

>=20
> I'd suggest to splice dhchap_auth_list, to a local list and then just
> flush nvmet_wq in teardown flows. Same for renegotiations/reset flows.

Thanks for the suggestion. I'm not sure how to use list splice of
dhchap_auth_list at renegotitation. But as for reset by nvme_auth_reset(),
your suggestion looks good for me to avoid the unbalanced lock. It can be
applied to tear down by nvme_auth_free() also. I created a patch [1] with
this approach. It just frees the dhchap contexts at reset and do not reuse
them for negotiation. I think this is fine since the contexts are re-alloca=
ted
at renegotiation.

> And we should prevent for the double-queuing of chap negotiations to
> begin with, instead of handling them (I still don't understand why this
> is permitted, but perhaps just return EBUSY in this case?)

Again, I'm not sure about this point.


I confirmed the patch [1] avoids the unbalanced lock. However, still the ot=
her
"WARNING: possible recursive locking detected" was reported. I created anot=
her
patch to add a workqueue dedicated to nvme auth, then it avoided the WARN. =
Are
these fix approches ok? If so, I can post the two patches for the two WARNs=
.

[1]

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..c71f1be7d403 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -920,17 +920,25 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);
=20
-void nvme_auth_reset(struct nvme_ctrl *ctrl)
+static void nvme_auth_free_queue_contexts(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap;
+	struct nvme_dhchap_queue_context *chap =3D NULL, *tmp;
+	LIST_HEAD(splice);
=20
 	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
+	list_splice_init(&ctrl->dhchap_auth_list, &splice);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+
+	list_for_each_entry_safe(chap, tmp, &splice, entry) {
+		list_del_init(&chap->entry);
 		flush_work(&chap->auth_work);
-		__nvme_auth_reset(chap);
+		__nvme_auth_free(chap);
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+}
+
+void nvme_auth_reset(struct nvme_ctrl *ctrl)
+{
+	nvme_auth_free_queue_contexts(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_reset);
=20
@@ -996,15 +1004,8 @@ EXPORT_SYMBOL_GPL(nvme_auth_stop);
=20
 void nvme_auth_free(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap =3D NULL, *tmp;
+	nvme_auth_free_queue_contexts(ctrl);
=20
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
-		list_del_init(&chap->entry);
-		flush_work(&chap->auth_work);
-		__nvme_auth_free(chap);
-	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key =3D NULL;



--=20
Shin'ichiro Kawasaki=

