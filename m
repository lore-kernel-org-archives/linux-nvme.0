Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DF7CEBF61
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 23:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tqcd8yMRu5jGBXtIAuNjQ8rWU3KpLOefdFP5XmwiYhU=; b=dxRGFam/HpKuLG+SGzqPhMZCth
	ZgWILYI4+Q2xByBLr8d38KM3qcKML6Im4QEo5Vl54vmjF5mzPUyQuhAjNx9OiRIjFs4zX8LMOGmCl
	fcnYMrse4HUJevFo/CuQXJ6+MTVvNT/COJdDcBtK3G5ex5eA/c2TgYdJrb+/FBMff27E7lUhTqaCI
	GK1fJ+Shm+KPAhBdXerIkQc4QZHmNDC9RKTSQDnDtElaWHn/IQ+oFAGHtGmscJMA6VC1MN31mHU6y
	RwSae5cC+WwOS4yLhLo1mhw6MG8/bHdoN/Ev/lIlgcR4SCkmRb0vMInAWlVynE7Lxd6afNzwTlulL
	vkY+RGkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKmZP-0000000FCei-1VZ6;
	Sun, 16 Nov 2025 23:54:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKmZK-0000000FCeD-367r
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 23:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763337246; x=1794873246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tqcd8yMRu5jGBXtIAuNjQ8rWU3KpLOefdFP5XmwiYhU=;
  b=RnbmCxUioAIgFwfsZ6nt1WKANa6wJRuPZpoz9aO9NC/FnGr5vWb8JDui
   wnz1BLLDVSmXZRMO3yI9YnU4fKj/wukhv3hzXkxZruADlXg9r5I5eWRdw
   yvmpjA3Iu1gAiXnTcYk2XueAUSKizrea0vIZgm1DK1IAcg/+tAJvlThhm
   0jbQtw+fru06jX9S+mckqDwUBlQ+A4K+ZVi1cPf4H8tghIfLkh2dFI4AX
   Yph9Kbu/EcJO9T4+gtHQtt0mNhKbhRVjy5tOJTD59nbIl6qps60usMEvQ
   U5P2zbVUlN9I7aU/fQLwfqoDssjR5SXuTsbld6oSDT2nghkB55t+l11ZG
   A==;
X-CSE-ConnectionGUID: 1unJfD4zTyyY0ilC6ns/qw==
X-CSE-MsgGUID: Mwtk+YP6SdiE3VZhtyWk1g==
X-IronPort-AV: E=Sophos;i="6.19,310,1754928000"; 
   d="scan'208";a="134842167"
Received: from mail-westusazon11012004.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.4])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 07:54:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpfM5vUKrupHzIRApliui2brOj/B2oTGsFIi0lU1g+qLFWarQqbChCUkhEiIvJZgtlFrcXTTa/iR261BWyf3elLhfVmFNE+r3QLFpEyKoG+WZpd/oBQxoUgjR2FNtD6VArwXce97VK6PDAZcF3C2PlmrHV/egYXUgop9W3YOkjqwm099T5ZSo34/1zWilb4inQrvZtQSMKM/MD2sfxTQew+pfJft/wBaLDIw4BuclYV3A+LujCfKL4MXwGsGy/mhlA359lWrDf5J5GhKO52Ssxho9ibEza1z7yPtgWue5cARhm3XeAJJQ9ijFb88m0QaX1B9KV099bwcnWjj1UYuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqcd8yMRu5jGBXtIAuNjQ8rWU3KpLOefdFP5XmwiYhU=;
 b=WuM81DORZwu7ZtKyjRInaZhhdkIGlvEjyYk6BTwGOiNQ4AXROJUru2Er3fhVROnEoeXvODgftCmdB0YGB+T0PkNBu5LfNTjR1Tg2sFrHQre9S4N+Z2LngRMIKosA2hWrxZJlcFU12CrjHUatTkcK1+5/3M6givbZtBhbKF9RbmXdGNdeYr55jxGxN/b2qibfvuCaDqIcFSSQQg33cGltgoo+zOMEQVlAh4GqusRMbBZczH2KnILTo0LhY2CnWGi4PA3xSbpN2M02ZdEFscDOUq2RFOcrQvFIftcrtkF3tbEkWXWUkq3LGRSYTsQ9QsGsD1cayI6graTTcmg/tr9Cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqcd8yMRu5jGBXtIAuNjQ8rWU3KpLOefdFP5XmwiYhU=;
 b=bII/e3cyL1XHAGnbDxEtW2FTVzUzEUhYXJ9lmxP0LkX/QgS+2cbbeLzTEVVZCNeD/PiJL1UHK9YnDLyCpCIfmHgFhkTvSPhtjFNsJ7a76c/OEkk0xnKb7FDOOJf5KjOm145ZyePO6Q9Hmt4whgr+3/BnEDq6LeK94tMRu1LkA5s=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB9146.namprd04.prod.outlook.com (2603:10b6:408:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 23:54:00 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 23:54:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>
CC: "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair
 Francis <Alistair.Francis@wdc.com>
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
Thread-Topic: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
Thread-Index: AQHcV1RHluEpeF0sqE62qvAnUjyueQ==
Date: Sun, 16 Nov 2025 23:53:59 +0000
Message-ID: <i3hfkgxavqcpodqshi6iekpyyqsdndiwpgp7pp2el5v4liznsl@xntdmhnujfur>
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB9146:EE_
x-ms-office365-filtering-correlation-id: 5e453d68-aa50-4471-6ac5-08de256b69e4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021|7053199007|27256017;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zach9ER2sgIs02g+46APep4/xc6+khIBxMj+8ejfHdJjpaoTfoJYssXdPKje?=
 =?us-ascii?Q?Pj6hDgD0OPscpKjywnzw7/S6H/9qkwwxxyZH4bOzwl+JF8/7cGvHZspl+Os1?=
 =?us-ascii?Q?692f2LZ4BWe9SZE9GV3pENGDxOWMjy/g17eXdKWqXQpv4m694L8PWCjCbgxW?=
 =?us-ascii?Q?Ry9W6v4wEli1DvoS8OHuaRGQLzBLGRGl9NbuUIWjmD075BArx29wDr1cKOWk?=
 =?us-ascii?Q?ngxmTZYHe3jLdca8eSjDLHviLKGzY2JrwiqUjIAip96pKR67bn+t6loBeChE?=
 =?us-ascii?Q?fRhogzbd7QqnFqYeWeb5ct3/gQrAV800zjFQzVZmnyRI9aq8a0QFV9QEBbnI?=
 =?us-ascii?Q?e/sQKCV0+ckZH0GcxpR/qxOgP9ywKGHOdNOCqMxjY7jhW9ZJ/6vW0hJdwu7v?=
 =?us-ascii?Q?8noZPqui34T65mRbq43cOs2Qwi4mOqrdU/ZwtSD7vd7+zBDvUp4t9W0uFDU0?=
 =?us-ascii?Q?li0s7HyWg3tQrnLfM68TnB1MKSZKtHOFd8Dat5BURflSGRL/gljdVcHBrlm5?=
 =?us-ascii?Q?huuLOXzatUoNBqF/GDCUcaHKzstQCNGobZ1fbKQHzK85kY5eFf5xGEMNYhRC?=
 =?us-ascii?Q?XStKra/8+YB5qhDj/DeW4VIg6eGJXk2H4GFZcheBA0Ptvu7eN+txbvZ+Atg3?=
 =?us-ascii?Q?JyCKRx3qk0HbgoI6KRc/e/VvaTiyIVHHSNN5s7R/9QKGfvt6619cUR+dwhd+?=
 =?us-ascii?Q?6iEOuYiyJ6r/8DaXblBXsceBG8X8NbBQvBLmUrxj1kXxkiukx0dFlplCITSH?=
 =?us-ascii?Q?DGlWCijj1tIZxi70l2qmdUwCnBYXdic2yv1JoQA58g6bjfjLiZykeiI9DdN8?=
 =?us-ascii?Q?Ko7cD3shW4yRMbUQ+n6l1tZoNiwSbr0SHmq6u6C7zzSpHHgLbNZdNxAA+WoD?=
 =?us-ascii?Q?HDJrXT0TyWILySiqraKdUc95EM7Dh6ZmE/jAlggd2iFbT14+/8kA8v6OGZ+O?=
 =?us-ascii?Q?YvqdH1y0mqHXmh9H/x2dIEsh4m9V2MjObhVpDyI5IiMTEwDzpWsBjeRo7rVR?=
 =?us-ascii?Q?UTUnfrMT1GjA83StksNcQk+67LXdXtNja/QMFfYDpSIBYnmlVY1ayQMwMtFr?=
 =?us-ascii?Q?4O1VVFQQO9G1flYF8VIjENBMg+Tx+TRz9cUDoLLKC+7BrDwfzqdYrMUGiy08?=
 =?us-ascii?Q?wsIHtbUiLGJHhitrpa2CIGEM0NdHeZNTf2iNrqqOt3b2UC10Qb6SMWHPC5ks?=
 =?us-ascii?Q?a3zp7Fz6sDLTHeRvMYy5QHJnY8alWQuI19EZIAkNjvlhY3vtu1PLK0yZTTTj?=
 =?us-ascii?Q?IbM1FJ7jRbOILupsHEHD5Ln6yluR+fEn/G2mV8IWf8j/bqov6hZpcaWAd6m7?=
 =?us-ascii?Q?yEHo1kpPcGGnOnUcMj/aEGIJkxoQNT5fvlHEpthm0KiZFM9O/koythSY2ALL?=
 =?us-ascii?Q?GkXWYa1x3MDIT/mq7BY60b/ZKimaCC2kJ+KTua7maLsVxs81dUxWR3gx63CV?=
 =?us-ascii?Q?iJ129C3gejK/QniBHBbQTOEV3yMkBVC6kqJ7TAWYUNpTCMaYYObU7R5YeGGk?=
 =?us-ascii?Q?JbfYw38SW+QJqUH1eMO94PyL6vQgE9A/Vtjn5orz3acHrhQ8O70WMt+2iX2P?=
 =?us-ascii?Q?KW9xXUZy9oK1ckM3yNw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021)(7053199007)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cghrjGUW2l8C6QaP9OydIHWBP6xAOINUI4cRQ2E+5RYMfQ7M4anebTZq4pHG?=
 =?us-ascii?Q?qFvnElOpUfZUZBgCDwH4Pj2qYbRba0mL5nh0MjEFh8fxLPMGrF9rVvxxjkPC?=
 =?us-ascii?Q?CiBPTJVtztCX+0ntXq69NLt0kyiX28ogbBxo04ARroTj+TCKX1fOOkywR90h?=
 =?us-ascii?Q?K6JpBs8XcdA5PwDRkIhdawqOCuFldgsP0oquce5UxsKTqfaxoCvc6eeIphOK?=
 =?us-ascii?Q?rFWSUoukkYVvQxQ+g9lBj5duFeHFzkg4cpkzYvyuwTH4GpS4yp1UOLtKBWL3?=
 =?us-ascii?Q?/EFFPQOu0QwFgjwCD4Awckig3vsu7d6elEzvAKa9vMWc93699H97CXVMS5Ki?=
 =?us-ascii?Q?2jkYG1uSiJpPLOJs67MJ+1OV9qIwpdrYCqsCw2poq3AXiQ8EFZGCcxdYkKm6?=
 =?us-ascii?Q?1Hv6QtG1V29Vommoh6l6Bod0l0F1yamXalLaXOXV2/q5ORdOLz3tQPY01Kjo?=
 =?us-ascii?Q?uPdDHjqfZYlsVr7TJBY86J90RqGECETm2//3w4j3ly7xnhQl9kzaaqdr+/L8?=
 =?us-ascii?Q?FVM+U+Aujd7XSrz01FHZxk8XtRSasCSg3/e+AH3o95DvK7w4GoLeDrStDQ1Q?=
 =?us-ascii?Q?x9omAwToNjWt07Lm+QOk1J5CqA9LjJfjiuGVn92ayRhNOaQnxgxZHYBzEoIX?=
 =?us-ascii?Q?zQXm+N2+9nWr0GnniR7yUYVqkZgm7z50nYNZXPdy9RBgYB2mdlhwcA0Xr1IY?=
 =?us-ascii?Q?1ibkf2emAUmkEVRmTpHFC5MFmEOWpfdYf9DXr3TWiIYIowQ3Lo4wpQw+fPaK?=
 =?us-ascii?Q?MwPcm328Pl7K3GWvptTFSyj5+RTq+Xcx+ygv9Y+8Lj6qEXRy3NMi58PN+b0N?=
 =?us-ascii?Q?JSWxPGVo3d5cnzak3vg0QG22vFTWTtETrSSvIuyxPtkNqcmhtqXbuLERk+JP?=
 =?us-ascii?Q?eYSd+V5LD06sz0GIej7e0L/vx1xOMxjeYLq0AJLOOQMuXHlCAliKF8GOm6zN?=
 =?us-ascii?Q?fxZmzUK5pUGilBSU5ZeU6HGBnQ3FYP+tWeVyvWwLXonPuk74hfJdUpiqLbRl?=
 =?us-ascii?Q?Fi7mEtEq1CEEzCi2mLS1wDTKgMwJI11BUSvolFsnh7zZYDg7gxMwMOzP4+Gw?=
 =?us-ascii?Q?rb2zrGfJ0cou75sKVKhrNzmmdRIFBiTjkm8SwZuHlhbtHdXH/8XL1Q+O5SQ+?=
 =?us-ascii?Q?f3KJYBkK3zyhGN5g66Pd0gUES0UNkmwmSTTHi0S8T+gPkqEb37x+BiK1VEkC?=
 =?us-ascii?Q?f9exkU9EFPNx2eCQfpcnIItlLZanELb8Q8pO9DGbQJlO9PJiU92B8qEqAAI2?=
 =?us-ascii?Q?w/tJNtB+fChFyclTwNPF2lO1gLy6UZ88uqsZ/mq3C49Kv4kszqKUcxxAGgfS?=
 =?us-ascii?Q?XB2EB/kYeiH/etP5BH2IWlq6uPyiAtkhnYnGWlkkNt2oSp9JYF9+o8QAzGwJ?=
 =?us-ascii?Q?AvvbwmsB+OOQL08BF5wstfpUnpmtlozUh3F8O838BYxkGdLrMGfxDBlHhWSK?=
 =?us-ascii?Q?zSDujnNfQeq+6su9L6MsZ07Hmcb+xB8QfSVv2pFnDdsNj8DjWOVgi2xgrjAO?=
 =?us-ascii?Q?oME8Llcaunk0C9VR6kqn5HIKsy6+pJJriIAWgbWMkSklq6uok2ldJEPnxPGj?=
 =?us-ascii?Q?5pYZZYOjvaoOkPfIGNNdh6p9UcHRK77LpDlymhPM8QN2rZfgtVZAqdWx/trT?=
 =?us-ascii?Q?xWRxC4OTCvOX8oX/jK8q4N0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF027392B6A68142AC26CC3833E4DAE2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vz80GpsQSUe0h1ywIgmVfCkTv9rGPgVFkR7KRtjw8FAfc9EQt8BZAegDMrxkzLwpBZpWWqb3jZtjXTF7Ih0V1mKJOJXppfNjLhtVxNx0DOYvAOwwj4kyg+m/3dlX4cqLjQM6X1k4xgvADR5BvnR0URf3H9RQQCAmTeX6nVtrHjNrT6cgbynli2xSPNf8OiAGPRTclOLXmS9der/QUKY3HSs+uQQrdQOraMH9E2Vpz1Xzt+7Zk9fJrdZjPURGnG3nmMHpbnON08h535Tu/hnhB+IG8dEH6pZGfMZBxE5V982IZo1fOaGQQuFIwqDJ50cTtyHz2neOx/KPePSrT2wcz8U0m7AqShrpw3JE/NR3F+zJpO6GltiMagNbMMOECoA0AbCXU4OL7c5iR2L7rtNPNZsEdmPV+ZBAE8OcsHNoPMCHizoBVaSYQAyDrPPwby7X7al9uJO+DBdjXU66/M1g8qfe08l2CAkNg09KIuE+lsjW7J//4lrYoyC9BTguIaP/UHVqgPOWBYqJenvvYEP0mtIySAAHl2cYLH181WrYAEjJADscAvzCrkwwiZphA87JW5rFvi/lPbRN+OT1E7D+SW04KYs45pGV9d9EREEPHKJNDQmBEBc2usBGuoT1u9zV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e453d68-aa50-4471-6ac5-08de256b69e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 23:54:00.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF1A5MszielXelMlOhowoOkdG6JEeKP38YYDNQPAVd6yiSGOPM6WZVCxwbxw1U9+InWVHA/LSTHbL8ocOZUMTQMcegf2MSDEadYbr3Nobcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_155406_966896_D8D81C47 
X-CRM114-Status: GOOD (  14.56  )
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

On Nov 07, 2025 / 09:17, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host response.
>=20
> This breaks secure concat connections with a Linux target as the target
> code wasn't updated at the same time. This patch fixes this by adding a
> new sc_c variable to the host hash calculations.
>=20
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I confirmed that this patch avoids the blktests nvme/063 failure symptom
that I reported [*]. Thanks for the fix.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://lore.kernel.org/linux-nvme/6xoxbezgcnv4bfaevi3pdpesfelia3epxidd=
k47azho7y5mnhr@ykmlqgnrbl3w/

