Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD54CAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 03:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DaqLFrCxtgP++xb4QL3bhGedAWKhffhPQEdTAyWYwPI=; b=XqQUy7fAtXrrGM2SDxj+tDXw6g
	HLH5QVCeUzOi8uy8F/0rBGFvxHLjWZ7PcCiWlvKTOsea7OOvTT0XLo7Zoli3ddOqDXsF/v7Vxo47n
	zTof3UMamPgYc4G6tHwZlMsNDG8fRozVu3Mg8Q/4yYmRRoJqTIgu4Nd5W2BBpxrbykRfT7d69infF
	AYQ+9ihF5YUuvU9/HRq79RaP6JalpirO8lsaXzf9SiYPSPuL82MSzTuNJnEYaS6V4fR86n1q2CXcb
	MmYnmxH2foGR1NfmHtRbC36g3fUnVJT8TpeAEVwJv+vx+dImDh+WUfyKlSLmp/Mu2qI+nR8cbTCH1
	E2GA5s2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3REm-000000042Y6-2vYi;
	Tue, 30 Sep 2025 03:41:12 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3REk-000000042Xj-2SbF
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 03:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759203670; x=1790739670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9rZaejUxRAWpI1SclXsLsizdgFHaTvOz6e7yPaJASj0=;
  b=XH67aOA4knmSj/Fgs5GdDqweMVQZIXs4BAJ6G9i9MmbR5zrk7+KTn4uu
   kvC92M89anLDChmuQvCcGrhr8n5bXK9plNd0x6BZaY6t0vn7ECJmnBjQn
   GlXS/NfGZkvV4U6h550NErh+/X6Z4qrTid0hnk39Xu1ezCDGmzZjXwWDM
   5cT2+nm/KsoSUvvcV2JeBcQmiYT8npr8IT+Y9hrxGTNFfiaZCawAS4AF7
   9tsFrgiyNYzZZuK4RTGYZGqJN4IL4ZfW6dD+ILc5/c3JO+MRNE1HARCIf
   +LWxTl5Vpau+SfKAibzjLprDfgs0oD63AJxg7iIgMHP7q18tyBIohzd5E
   g==;
X-CSE-ConnectionGUID: WPIoowpqSEqxyqfVgwCdUw==
X-CSE-MsgGUID: 6mv6IQ2XQ0u+iP6VhqC3uw==
X-IronPort-AV: E=Sophos;i="6.18,303,1751212800"; 
   d="scan'208";a="129050060"
Received: from mail-centralusazon11011025.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.25])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2025 11:41:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvCDhAF59e2FZOlzPXqfhJ72I3YIFHToi/Sm3C8jC651k2ydvvXkpxciqzk6kryJFbL3TOu5v+s0fss3X2A3UGinLZuxWCfbGFPgERmpa3hHfBs4Zxd5VF/veuryj4kKx3qsxM3xmj6kJxV++ajsEo7cwIdU6BeUURebXbrcxAruCBBYIXnd8eKIv+d3fituRrb8axJVqLmSqnXQG+/ZDFPNdRRAqrebFKOMtSbuQd+1aUeb8ItSmurI0hQUlthiNLjSqWXwud1lZ1akYkZWhDYHzp/9TJ8p/d5Bna+VQH7v+C9Poo9Aj0NHCxfkv3GtAaT8F7vDNzQOvIGM1dfb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaqLFrCxtgP++xb4QL3bhGedAWKhffhPQEdTAyWYwPI=;
 b=WbcaOC32fY+xxl1WnKCDB4XFL4hdQWCXG0QNVY7HWgA3XBsHlFTIKbBTQoSVDEDBXyzaqR2Po3MPuPtTWccRdD4+beZevrtjRFwqdzoMead4guZGKAt9IGqyOor4c/X0Mm5xbzhO4KGgvmneYEle3GN05hDjxBw3TMrIM51LypmZ92WgEeMtndI6xyPlfwiMPO3PsI//xpwq0j2P5m0ZhNb78MND8TAUbQvZdBV9dUUso68JuhH0Yh2oBtVcdrNuuOEh1O65ZleuB7MnzhuVPmvR8KtWNOK669hbaN+oEAqqb/buiJB43U/H6+NJk0+z1pwUTZUQo+0COtuk147TbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaqLFrCxtgP++xb4QL3bhGedAWKhffhPQEdTAyWYwPI=;
 b=Uz8waqYis/wqNosHbQDmNO+Es/hGypalCex92A4o9CBoujqkbxClKjiXAOi1e8cibALsfBCq0bjk4n7KhUeN4KdItoetNe9BndRpGkNVfZMkrBCHgG0ONE8+wgokHrYHt6iNsI+q807geAh+Z+pcB7U9WThFgPXjyJ5+EpMXpEQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA3PR04MB8748.namprd04.prod.outlook.com (2603:10b6:806:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 03:41:07 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 03:41:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"israelr@nvidia.com" <israelr@nvidia.com>, hch <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvmet: add --qid-max support for subsystem creation
 and setup
Thread-Topic: [PATCH 4/4] nvmet: add --qid-max support for subsystem creation
 and setup
Thread-Index: AQHcMG5NGm1dsyqrxkW4vMafx79n7bSrFz0A
Date: Tue, 30 Sep 2025 03:41:07 +0000
Message-ID: <l6sabp2ek44xahje2s2bwiulqqbahwzdifwuxzpgtudplcy5e2@gkd6xyefktxi>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
 <20250928115125.38383-5-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-5-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA3PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: 1d94e540-5691-4b00-3262-08ddffd3309f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZEz8eWZCo5YLG2Jvv/L6jzaGXvNVST9qSb6X4WtjCTnp/84RjChYUy8uZzbL?=
 =?us-ascii?Q?yWiy4Xhb11kApZa31JFLFKEEUG5HBRTGsSR3h6iXiSpjfJa3+VsFNC/Zc67a?=
 =?us-ascii?Q?G85SmeyCRjpcMRZkWWKKr0H8g55OdrAlhACQZwLrU6wy53kLH7tJkzeMWare?=
 =?us-ascii?Q?JqMHaitUxZKVX/2sTd3+B6tQktu8TSLWOLwHZE1Z/R8UUdYRuVqdpY6ZZotg?=
 =?us-ascii?Q?S4Z4U7Co+UEmPMfOHAzfwwZcN6HwWyYHNIrke4geK46yofS8C8QovFcwsb3A?=
 =?us-ascii?Q?uSO8hacYu0PYvs/FKc9aZ/hHpo/DGCA8n6RRbPR2qQS0AsG076PaVMYSYVgR?=
 =?us-ascii?Q?9IiY/tZilYDsZLL3jTw7Gv0ECaw0+UGg11OsFbnsC2I/PaelHQnJWvInFYFh?=
 =?us-ascii?Q?FNlKG0wsIRNddPwnWX/H5BVIGDo2+M81Qt19RowKrv1ffUZUiRwEj10bH5w6?=
 =?us-ascii?Q?qr1w+GZSUbTmxmYUtePvhhnHqTzuO4ZKCj/AgizDlJatHiPRrss3NVwVH4u1?=
 =?us-ascii?Q?eYoASpf1o0kZM17V+q2X8lni4et9esYptOrmy9QYMpP2j4a4SpzinZHFzHFV?=
 =?us-ascii?Q?PhHGUsAf9tD+0nPBPWqdJzK7EMPwG0tTloP1H+jpdwh4FbpQi0s8V1taW6KU?=
 =?us-ascii?Q?AkDHBPov6KGUv4kbl/6xpe8erJLAcVXhOjhdWZgBGSvDlvu348OWqA2KqUmU?=
 =?us-ascii?Q?auw10UshcXxTdMgM9vhwqi05GgN898z+YJRd4bUEpLznizKTaiB2QAfPTgsV?=
 =?us-ascii?Q?i7D0YlQVIe3vNKQFrLJtY+CmLohfedIoZZS35yNUnN21ZVe8LmM72WkNRwBU?=
 =?us-ascii?Q?XLFMQsK2fi+0KtqIgh0HXkVT4yITFyhzIigqXLZ9+KyebZ0sUUlaahE80Buo?=
 =?us-ascii?Q?b2wpbkXkae0bJHl9WSn+2sraAudaukEWd4Kktp81BAEEF6jkxeAgWg1h0j7Y?=
 =?us-ascii?Q?etNE4hi7P6tN/SUX/GMoNmC9HFw3PNBGWhCiMDQQRJS+y9Sm6LtfWj6/PkUx?=
 =?us-ascii?Q?geUtnwl6/sMsXnF0TbXDO+Ek9RjMuH2oyz31iAIDxPTpR/9RHxnOzPaFzTy+?=
 =?us-ascii?Q?CTMgo0T/9kkkuTnONYlazXMb3wAp4DM++8bfJ75DjRPxowENLScAUdq1W9dQ?=
 =?us-ascii?Q?v4mYQMFXYaI7xEa8YXNv8Q78oKjDk8/iCc/2AyePPuIZ4VLXSe57ZXBFYist?=
 =?us-ascii?Q?wH6n15cE3juP/q0TyHcXUB9H0GMSARhtZMN+FUxIb/gK8y4Ewx+Q1NUEFvkj?=
 =?us-ascii?Q?3jOlo0fhRUaD1MfKtnPuVEnzC2uwCHyI1gnFEraZIoLt5qn1jJNO2rv7b9UX?=
 =?us-ascii?Q?OBQ1XZvwR58ShZ6kP/nVsxzVCIpo6F0JMad1zUvZWttKDmCkhqa6Kf13IqeY?=
 =?us-ascii?Q?KzOysk0ZwyfxEqHQSMPVKgtLTv9RIcoDS3+KnUoBbqMtxDNQYJlAHABziCqw?=
 =?us-ascii?Q?AzkFbFB1AIhMy+nydilZfCQCuvGiCMgF7Yqjq66EEdR+5j7PnS0vBLGYfcz9?=
 =?us-ascii?Q?LAluDDC0XjuMy3Gp+Nuuyf9Kuzpw2AaNTA9E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?78cDOH+asfbGv/pWxilRad/a5OzVHgcTPr9vNFhLsE7ErOh2MjEgwULAr5r3?=
 =?us-ascii?Q?5TCFlhRIL6UqUx2TbIsMKP+abnSDh8ihmO0FiL/YlpOqpmUhfgpfzqw40RYF?=
 =?us-ascii?Q?4ey6QM9pSTxKHyxPxr/yAdQrTzeMctYMLK4yJFQ5ASpeHVK5OS5HSi8kS/bQ?=
 =?us-ascii?Q?I0zU+o67FSo1VUuJkNmjohhzlOv/JYO2X9/2AB6DFA1zgmxrIPLG69l6ZYbd?=
 =?us-ascii?Q?DkGnBNf6DY5zPsXXkwwmhinFgGt4saBlL0GBLuzo+HMjH8f23wyPIcEMpjuU?=
 =?us-ascii?Q?8yM/HaY4hlMZIn78UrSGGzifrrmQhiOxFsVGgbY3z1iaxSbjhIV4+R0tOU5U?=
 =?us-ascii?Q?TsiUCZZVUCt6IpjBZBgii9qxAEl/w5JkBqMJRdi6EKwxXVbKbG4y1JFtDxCw?=
 =?us-ascii?Q?j3U2YwanXCWBCc+orofsxYBMW6Jkg0NPhBMzOqBspeOIiov9neWbkPu1Q4jO?=
 =?us-ascii?Q?Q2pW6rYIjDCp9k7s2rtGnd/MI3jBnMoFx3pK/VTkT4BuzgbNjXnNGIQ4P1gq?=
 =?us-ascii?Q?Qs0bB1U3J1aRPL6BsrWqxPqjfgc7LX9Kct/QFsWGLx9PFjTDIRtLKyrnNafA?=
 =?us-ascii?Q?rx79swIVV5bFcQSbiAOqeaF6GkDrK9Wscv2nFBwRxTMRKVyM6o4r1eDn8qbU?=
 =?us-ascii?Q?2StPaWdA58ICmp0VGPrRmHJBV9EkXxwUdrdsu56040KdQ/NMiLHwo5K4hXRP?=
 =?us-ascii?Q?58zNYdAfVKBY1m3bFm7TYuTDivw5IKl8Ptcjf3cO9L0e3jqKjF28lsMo/ODf?=
 =?us-ascii?Q?MooU9FC5gis1fgPIA8TdsCWg9jho2HttBSp0sc5LQtckArsfjgUo8+1c/07k?=
 =?us-ascii?Q?J8kQdmgddoktMzh1lu9qYzbRSTClkZ6a5WhvG1FRw0NHeMqpHLJAo42f89MH?=
 =?us-ascii?Q?hQV9LttpqAPXbQ2LRWDW26D2KgavZhLWYfxfR3AiX1uP8BF9rHJ/eCu4LaGV?=
 =?us-ascii?Q?xUpEI+IxKTUgCMEIIFLjaB6UcHXCRD9ZD5HrPFTIK5LIgV18LXNuqpzQTXbu?=
 =?us-ascii?Q?VFxmy+l3lqd/ZMa7b11U4AYGDqsZd08yzTDqJeqf78AtEd6pfcIt2QCiG7Uo?=
 =?us-ascii?Q?xoY/bL4CGuS/kwYU896FOdJnmX5PCPV428DkjMQ5fS8oHI79+yxfbjsdZXIs?=
 =?us-ascii?Q?Ia5HxPUwqL8fX7u2l7IW9fWCBjojz3wbKU0PdRQbPOx/R9DWWjGhN1y6vCth?=
 =?us-ascii?Q?helIu+jjWn/lMgEbF9WVxyfqhxEKr5MeEx7nzxvH8VrlLmBhKfDOFvplsUof?=
 =?us-ascii?Q?dJZAsUacIvo+KyVMVMRXuIJme/dZzEgm4zVIiit9z5AGk32xGmOP2aG8Vsv4?=
 =?us-ascii?Q?t2G1MpnZu3p8RKAWqQ7EO+2kY6wPjgSa2lAumDuNudn/RprCs55aPHlvIdus?=
 =?us-ascii?Q?/EsOPY9DuNeSzCJ6jZaPbnFjKIxoGm32fUx+gy/yeJiKmk7z/5ds7bWrcp5q?=
 =?us-ascii?Q?j0M0mcPjXvFq/zFaXhQizpKl4K7uITQIfAAaoRf//x73Kjvl/9KFDkEuoJHQ?=
 =?us-ascii?Q?cOy0BOMYb+ukdvwyCUw0tX+77DUhs72lol/2W/ZN0oABbt1aGXu/NViNYmfX?=
 =?us-ascii?Q?GPOfJvm4ul+cfczdQlO/34EcrUxNZT7nVr/NSkmwv6BKm6rs0VLpn6M/k5jL?=
 =?us-ascii?Q?RcO4NYGpKoyi097cHWvAE3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67212B2CB960D84CAC1B7101B781742E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZBR4tw30l/lcQuvod6XSOMT0gHm1ZYFOgxo74LJDrh5wy5LDOkG9tAtlfJ2Y+YdqH7RYLS3MHtQXyuxoCxbVEz3/mTcOROHp2BvqrkabhlafqdD+mwZo/wC4eiFix0EpQVtGVTvg23xO6cXm/090x0PR9aWzWvV1lMDVOmKWR9SJeb8qoipFYc5jNCf9gy64OwM5Y0M5MkWTJZspFkdLMjaRd5u7Tvnza6LbfbWjEP007LeBX+znc2Q2YsxCFXJbzieOa0/xum11flnunJJ+MR8hmyUNNs5qehJjAfYQH4gs3xxIgzGovs8TZLWTa1FnQkpXKMZIz6WDiZ+rui4KCfjuzrkmW1xqKbKB9LqEa3uBf3mV2RIY4Cwe2u5X1ErScfd7ADxFw6pxmbp2nn2Ls0mvPQ3jCh69G+cGo83VX3LrFvxaDsGD9xRMwIhY0nxOqTft7Cq3evUqDgZ+XjNkZytG5Hz0j+/jzVa7/DbBHIziDZAFxAqx6zmNIqPR/qorGo8SgFbJvVqliWGPFSmAzrrleybcH/EbISq2B86Lw0lhg3+dDEBjcDczfFjJuFs9US/oVt9fMEVeCpAgQHnvzWKJmwtIK61rmcJIj2jf0Hs1EPuyi6nBhPd1MB4VA8Xi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d94e540-5691-4b00-3262-08ddffd3309f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 03:41:07.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9WXqMtwMs28+bfwFcVK9PsA4EVIxvfMY9gDsri+fCU1kjdHceMAuqKOVtS9IieU7wJzRyTgpMUKMYB53iYnHH9+Op3dJ1tn89KEoCHBsvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8748
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_204110_694622_E2D481BD 
X-CRM114-Status: GOOD (  19.26  )
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

On Sep 28, 2025 / 14:51, Max Gurtovoy wrote:
> Introduce support for the --qid-max argument to both
> _create_nvmet_subsystem and _nvmet_target_setup functions, allowing
> configuration of the maximum queue ID through the "attr_qid_max" sysfs
> attribute when available. This enables more flexible queue management
> for NVMe subsystems.
>=20
> Additionally, update test 048 to set qid_max via the new --qid-max
> workflow. This will follow the new logic added to the NVMe target
> driver, which forbid changing the attr_qid_max for a discovered
> subsystem.
>=20
> Also increase the sleep durations to adjust real RDMA HW devices.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
[...]
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index afd9272..c6f4d9f 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -37,7 +37,7 @@ nvmf_check_queue_count() {
>  			return 1
>  		fi
> =20
> -		sleep 1
> +		sleep 2
> =20
>  		retries=3D$((retries - 1))
>  		queue_count_file=3D$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queu=
e_count)
> @@ -58,9 +58,10 @@ set_qid_max() {
>  	local subsys_name=3D"$1"
>  	local qid_max=3D"$2"
> =20
> -	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"

The call to set_nvmet_attr_qid_max() is removed here, but the function is s=
till
left in nvme/048. I suggest to remove it.

> +	_nvmet_target_cleanup
> +	_nvmet_target_setup --blkdev file --qid-max "${qid_max}"
>  	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
> -	_nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +	_nvmf_wait_for_state "${subsys_name}" "live" 10 || return 1

