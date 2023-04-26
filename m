Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D71C7618E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLBt0UKXdpHxM9unV/kJHExx83Bcj9UkUs32laW2qDg=; b=tsnyWvoBq4EuUmKBHdJjDY1NZC
	l2YzCCObWOoey6mAuTIz/csFW9fi58KudmxeNKlADCCATafVarfmiAv91MkE4tbqN9+UVYxsKPce5
	uVwnrYaQbpcPixQQRB0dCAbvgjBbbUaPaV4PYIqqyj1H/PlVfXacEpMlhRvYQr7A4YggWduAoFVhv
	eaeFxxQxMfXIq3SGbPlvR9GbhNLfzt0WQrjz3JDhz50kIwGTb7gCX4vLq6m83rKm/cn5jh5U55xr1
	nr/GxYv1w2p+DomY6kQUly+wOmpL/+B4wpIrD7QihxiTtUoB33T4s5Ro1qbYdWdtCmTLjCBkcDFlb
	u2XD9smQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pri9T-004PoS-15;
	Wed, 26 Apr 2023 16:37:55 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pri9N-004Pnl-0q
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 16:37:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682527069; x=1714063069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9sEPnvq5tGikMtNHueEFcSq9fd15QHI7Asw5WuNdChU=;
  b=cMtBsPvIVG7AZXIRSZdAFCWdBT3X2CG7YCHd6ulQXVEFmog29noi1hzH
   vrSBDXlF30HTOaeYivVtqJPlrHdMAgjWbb+Wa4KHMbgfY9UiNyFguqt3g
   HFePQ+ZhXh4RTF0GvWw84pxfuLhNga+jlaaFT031FT0E6mmbJZbMPn8vm
   FY9KDDKc9StP/+wWmzocwIXA62lozE+Ldeq5SOTM6YxzqktFv3c/rRrph
   /x6s4WgByOj+iz86kQ+Z3gG694Gp/hQPKJeACvj26p1R3uRRX62FDwbuj
   nq0BE+pE/S8o4FqP2MJ3Mya4TRTn2e9sn7ACagnS4PRj3qnbLCCppsUfP
   w==;
X-IronPort-AV: E=Sophos;i="5.99,228,1677513600"; 
   d="scan'208";a="229239130"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2023 00:37:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMIw5ZmzLF9MEa6yC49ltcNhYW3lxFzX9XyJjCk8bjODFFMT6Kr/mCSDSxWv//dUjOVI3scZzu/zl2hE0zZoqcP10E07pcjlyozYed+aaWrvyxq5ThR3/xbOMPgLQ9YRI821WXsb9HJvnyRiqSI/9x5oPVR5TRPZR662wl4Dcsb/ERajWZNYgB6OCmX7iuwUl1MxU4t/Xg3PEXsQMkZDbFxmJEaKktnkxgIzE+gaD2xCMec2Q4/buLUbIRqdtq0NXfrINLDrXyTBRnQendrWh8ax6nDVUdnFjokiJg7LNu+kaZ6KMf3sGfVH+T+c9zfMFqxb9c5F7+hWgfRuXH+eOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLBt0UKXdpHxM9unV/kJHExx83Bcj9UkUs32laW2qDg=;
 b=H3DmVHxmhk1rMgWsbHWbPd4Xw++gXUL6LFQ+dkX3SCh+aBCqg427UdzGqzg57NHvxOW2XiXbmr0WroZlzEbfFAegiyq7x+4qpzCpvS5YIYudFffvEWjqKg5FalVNzuWPklH2IVIXfAou8sExhoTqm+SPx6koRvyPg3dC5IXoJxSiR8oDEReclKRrJ7SDYiQgb1IuChEaKbiSFvaUy9A07T4967PEu2tdM1hrzyYiBqcZ6PeEkcgoq6I+Usghq3Xwco9mDPeI5VTubnIcDJO5zytqr5fjD5zCtQySop7APWEsRRJQ8Fbptp9kN/pA2ZXznk5Qv+oFzjF3Y9cg5o7baQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLBt0UKXdpHxM9unV/kJHExx83Bcj9UkUs32laW2qDg=;
 b=iBturT6u+p3qjdPTPVtNQGpNVcIPI4QgFhviIPz+I4kHXib23KRANGCuwh1PI0m6pEd6ahndyRh/9qIjnBb569I2lzkZuhf9KiHRbtCK1WUAuylYMqEBdreXrJ7aq7aeXSl8kXIjCFV5/027xHW6oGnJ1eef3kzIiQ6dqDKEjws=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB7830.namprd04.prod.outlook.com (2603:10b6:8:33::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Wed, 26 Apr 2023 16:37:44 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6298.030; Wed, 26 Apr 2023
 16:37:44 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme-pci: add and use print io-queues helper
Thread-Topic: [PATCH 1/3] nvme-pci: add and use print io-queues helper
Thread-Index: AQHZeF1s0QhaJcSDnk6sk39LDdG8VQ==
Date: Wed, 26 Apr 2023 16:37:43 +0000
Message-ID: <ZElTVr7V2TS8Wpij@x1-carbon>
References: <20230426123119.8738-1-kch@nvidia.com>
In-Reply-To: <20230426123119.8738-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB7830:EE_
x-ms-office365-filtering-correlation-id: d1d0d510-dad9-4f83-2872-08db46748f6c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1vJnTriSn4eepeN9Wvk79lsnUqXohD01kX4uzACIqlfTnW7Rh9gGICpMySaG9+trDibpLr2TCgZk/4EKPgJZbnLsbAfMRXmtS2hrQL6wz7sv7TOrsdgWFvpWyHbNlC0k+JWuv8Pny1MwWd92bbpjp93C33FcQCOe3RTOEad0dWF3gqWejhe5QfbFZyBlSwF8T33D6KO6dfqWCu2KSPzqJEwv546V1dYr1wKAsgNKucmtwbIH7BI/mHNms8CzcGB9PB7DNPvBTAImTpz9vEClfFwXd/OBAhYPHuTiU94O5siyAQ5xpM0m2dpKlMkntw1YQ/GemxLxgXm4C3I4RqhUySzho64h22DlUovrhYX2ObuBEjDvpLK3yB/yzEpCSc3vAQtPp64mWmCDkrHXYsMO9LkKhn9AOCeYJX+Xi08kPj3mOEDdqKxASablOpI6SuUdTIuqAUtsfNPcrfa7cp1RYgwq5pAJsQdzArdjothcRXLEd4zNriOYFa6yjtei+eXEup/XNofQ3HMyvaa3nOTvNCqU8cd6S3h/blpTGMa1C4o6gt736C6i6zxAzxON+5OoMYgK6sWd74LkrXmnpQOlSKwR95l71NtqYtM1H0slP4BnRJMiZjC2DbHNj4x1me4G
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(66946007)(66556008)(64756008)(66476007)(76116006)(66446008)(316002)(6916009)(4326008)(54906003)(91956017)(5660300002)(82960400001)(41300700001)(38070700005)(8936002)(8676002)(2906002)(122000001)(186003)(38100700002)(9686003)(6506007)(6512007)(26005)(83380400001)(33716001)(86362001)(478600001)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?Ilf8a34nVIYAHnv+S7tTle8CO1vUjqj9p0g6pv5NfRb2MqNIrYX4HoU/U545?=
 =?us-ascii?Q?C9tVjxmfA2+oA7QKPbifZSuceQ0ygaEt1TFBdVaJTpG+b/ETCGhiyWYdMv33?=
 =?us-ascii?Q?GgwBcO/HRWWVS6ExXde1u4WoY1Uv07Va6Yqok/Wrk3SKQxCxmgWbt+32uokc?=
 =?us-ascii?Q?dfrXsi4K/wk+iVx3qBzz40O3Tp2tDi1RtTb2jcF0nKV0e26QZT/yA6baITv1?=
 =?us-ascii?Q?gqg+w1bscy7D3jY7icrRE2RF62dBIjlDKORvbsG3r5B1OEbgygnsQDcZJHpz?=
 =?us-ascii?Q?M+9hc5xopIX2IfJbtP1S6+yF9Iuq8m3pRO0/zxJwotahc10Kt8GTaxgJvswg?=
 =?us-ascii?Q?LCgLe2+Z2FxAgXuGRgp6rQVAZd5xsA0W48coq4c1Jz0G+GwshLaS41/sbbvQ?=
 =?us-ascii?Q?4pKL1zbBisC3HBeEMwAVxwYf3TFo93hpjTzMUicMUvys3c7bV46jXQ0ZLqTg?=
 =?us-ascii?Q?V18m4+klygMu80J5GYoUiIc6p3RyceUSDg0SHxVFwLftoD864IKzhjd0SmSP?=
 =?us-ascii?Q?PrpzGGZ3DaoBe4mkreZXYhCpKne0FzhbDyBhPFcZxbRtFdECop+dBupVRu1d?=
 =?us-ascii?Q?upOqa1fMxo/i+F2MzJNRJCxlBpxQRQwhySZuYiFjeYgFDZ19w60HU5cLq0om?=
 =?us-ascii?Q?2eB1plDSTkeNTfbjApO+FeCoc6YkNz8Z4e8aJVWsSnTnX8UBGZDEplNkQADt?=
 =?us-ascii?Q?EmQKonubq/FzvNwta8/sU7xG3lwOdl5N2H3ueIQnt6egtdWRu6auQCNtWw7y?=
 =?us-ascii?Q?ag/BW5FjunVh9qGiYuVF5Ch73+yXP/QYfR0zmz+Bo9Y6fl9CVvaVXDS9PvYI?=
 =?us-ascii?Q?bHqtd0oILMrM1qtIjiCCmE/DYo1MydJHzUW2yzPGvuoZ0+pXhZ3cqpWvIySO?=
 =?us-ascii?Q?xrrhaVG/seV85GvmnWaPDys9ragchjBVQ8iNrkDo2ESeG4NFsEWc2D85JG12?=
 =?us-ascii?Q?X/nURqHpmYhvDL5b97KSZD3wj3e9HRqf0H7MpsrBbCT85euIC82h9J1ANl8A?=
 =?us-ascii?Q?Ti6VXOQJ3lnOVvvXIpjZerAL38EQP8U6UpUGaKv3rJPAxiQMtXURCGPRTPCS?=
 =?us-ascii?Q?eun+2xYRCqOs6JPbrPu0voXRbIVq3PDmHBmoTK+lAdeH0APZxg+DtmanUSI5?=
 =?us-ascii?Q?WXPEGkx//Y4Zl9E9Us53YJh6wX3BCHIm7f7DQ28FRiDKKTN0Ad9E/SG+XJ7B?=
 =?us-ascii?Q?p/o0zxOFeG95/L8txuZfZvIKlOJ2tnEA+yD10+FJlZth6rhxlKIbqvqATSWp?=
 =?us-ascii?Q?Dlg6tkm3OXFE0J57ChzAtMUw9jSyQ7UC2oTiT88aKGFp/uz8RKEwRzA/oLZK?=
 =?us-ascii?Q?2Wz4CsewI4dCZMP0gZqqT+jTLXz91OVeiJOg2l8F9LgvPOOUJPMTDaQjzzVO?=
 =?us-ascii?Q?SO56Gb4DKEI2N73kJgDv5py6sRjluHdKMRKhCn1pB4iFCLu+R/+sp4qMHxpx?=
 =?us-ascii?Q?NMuBJ1fCGJ6LfC/IN4Yh2gqo+H9T6ewlugHg1ULThMWSFGKx+Jso10AjLNTl?=
 =?us-ascii?Q?IWrRjLEZH8eNsnhcA98eMzARIZgpvIYabi9MukIK/m0lVu4vQ27Hbbuh90SW?=
 =?us-ascii?Q?spNyPONRIbXLJMfXyyUnOJIum6rMSztKo5tBmrjpASx7wuDPS0LXdphB+YsY?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5519801075EEF640AB62FA8D5CA2777A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	GEaFD5Hwvj98akHUbd0sR0lqPbLGdmiYcLhtVdUtgpBq8rEV0i/4vmIrtgMKBni4qlkoM6nTj66bdUOniOWxbgQ3ZqcS7J4C3/WhuXpqdie/1Aa2dGF2Ktmd9KUuKAKg96ePgZqvu1v1lL9fmrOmBYZCMcUa7KjyHrvjD3csa3LJYj/nW7O1HCJED+yqZ2plL2yhz6D5acZ4MkkVp7V/TnjDXNHYrME8VpDVVq5xziJ+qAncjA6NURYXlc2xWdIivPcxgLu4ElV5TmS/Hz4aWSSAIR531VAQnJCNwInrS4kUvgG1LhMVLEpZVTJ+VqRdvJiwFIVDmsn2ekpMJOYqOsg3xRziEq2HNUpIKsj+4I9LWYfvnU2jcx3LQahb3+lPMHfQaWjLC5JfSHgS8Gt/7PVPcSiRJjUAGgcZG2mmhfS+lhgPedIrbBor3VIypUOeDdWQn0bK+SSqnDWlYCsLLOd3EHuhX/iuiGt/1dUUHp4NhzCQBiMeBpCTDN/PBJ6MbXQgHU5rsELhdGePdDv1jWxi8VSlWyJeBMMOC4Wl2lqOomxTSm5CSckF93O0MzIwaTvueRzJ6qNSRGW3JEb7Z2I9kfGoBo4TBZOWm4+6b9ZqCy0+hHQC4si7KnAorU3lBjDGVAupheR97Z/Nj6ddmp5suGFYQqRSXfmD56/937WVt5Y+ps6VQgQPZ25jommg+KYkgXtpAWiWaOibcE+WpEaixcYw7rVx/zKz0rVW63aoskTpWVI81iWrp8dhmJq0yPqbDPr55zNwPFWyJJpR2mbPzUR6P1piH5F8ALRgkw6F5qhnC+aZP/Gi1NUiaksWbfE0YyBhR4gowubyNsGYj9Qi0f/1u9oUD7/BDXQrAqlE42M29GEJyC7lKuKmZXP/MTFOLdQbNa8PgmJs4m6cYhxXA+FXzfOW3/SALVQgXYs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d0d510-dad9-4f83-2872-08db46748f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 16:37:43.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FR9lOXkuiDwc7TM2SR5+0JT8vuTuw+/i7cfZTns95l1z41vo+vL2dvZ/r5TysikNV62cmx+sv7yX3NXZSMTDUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_093749_395040_9C8BEB80 
X-CRM114-Status: GOOD (  24.12  )
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

Hello Chaitanya,

On Wed, Apr 26, 2023 at 05:31:17AM -0700, Chaitanya Kulkarni wrote:
> Instaed of duplicating same code in every transport, add helper in the

s/Instaed/Instead/
in all three patches

> core to print the ctrl->io_queues, since all the transports are using
> same format to print the information we can safely replace repetative

s/repetative/repetitive/
in all three patches

> code by a centralize helper.
>=20
> Use that helper for nvme-pci transport.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 10 ++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  5 +----
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 518c759346f0..ec430947aaf7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -249,6 +249,16 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *=
ctrl)
>  	nvme_put_ctrl(ctrl);
>  }
> =20
> +void nvme_ctrl_print_io_queues(struct nvme_ctrl *ctrl, int io_queues[])
> +{
> +	dev_info(ctrl->device,
> +		"mapped %d/%d/%d default/read/poll queues.\n",

Here you have a full stop before the newline.
In the PCI print below, there is no full stop.

Looking at TCP and RDMA prints, they do have a full stop.

Which version do we want?

I think I prefer the version without full stop, probably because
I'm used to seeing that print, but looking at core.c it seems to
be 50/50 if a full stop is used or not at the end of a print.


Kind regards,
Niklas

> +		io_queues[HCTX_TYPE_DEFAULT],
> +		io_queues[HCTX_TYPE_READ],
> +		io_queues[HCTX_TYPE_POLL]);
> +}
> +EXPORT_SYMBOL_GPL(nvme_ctrl_print_io_queues);
> +
>  static blk_status_t nvme_error_status(u16 status)
>  {
>  	switch (status & 0x7ff) {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..4000526cbca0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -767,6 +767,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
>  void nvme_wait_freeze(struct nvme_ctrl *ctrl);
>  int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
>  void nvme_start_freeze(struct nvme_ctrl *ctrl);
> +void nvme_ctrl_print_io_queues(struct nvme_ctrl *ctrl, int io_queues[]);
> =20
>  static inline enum req_op nvme_req_op(struct nvme_command *cmd)
>  {
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 593f86323e25..771d2bf5f402 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2356,10 +2356,7 @@ static int nvme_setup_io_queues(struct nvme_dev *d=
ev)
>  		nvme_suspend_io_queues(dev);
>  		goto retry;
>  	}
> -	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
> -					dev->io_queues[HCTX_TYPE_DEFAULT],
> -					dev->io_queues[HCTX_TYPE_READ],
> -					dev->io_queues[HCTX_TYPE_POLL]);
> +	nvme_ctrl_print_io_queues(&dev->ctrl, dev->io_queues);
>  	return 0;
>  out_unlock:
>  	mutex_unlock(&dev->shutdown_lock);
> --=20
> 2.40.0
>=20
> =

