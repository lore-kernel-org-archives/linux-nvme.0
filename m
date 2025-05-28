Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28988C3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DYni9bfiGcS6BGWrEIGLWZ8yAQCCqMPooB9oQdKPeDg=; b=1IzK+d9czTrHIXqp2OaxTvUNeG
	S/sDgTwgG6dzrF5McVmFVdOWGfXc3d29cuVvLF6OrYz0Nrbuzpo6wrM2+O8/L+0z0JHuOKcJ2OB5r
	SWQcxKKnap19J4xm4gJTRa1fbYi0yZICVi1c+I/jKbwzAmOvb3E0ByuVPrCXL4SqOqdFfzHj9WEML
	2PMSsLPZXVtejnZrLq6v9eAepxZ2XCpnPHOi+o/ctaVFmhSUIAdCb5BPgnBbycpnj6rLc8W6VUZaE
	nEqo++0E6Z9Zfy1YK6lllhvEBuLG3nwknUCejsCRhggeG/CUavJ8KovJ5riN3dTmxmx7on9JxO0yR
	ITsMc2zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKPYO-0000000EIK1-2gGN;
	Wed, 28 May 2025 22:47:20 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKPWv-0000000EIH6-2fb2
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 22:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748472349; x=1780008349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=znVAxvXYtDM5CVZ8P5VA6Ef6ZyxTBGvVoSSPZguEtqo=;
  b=ecWV6qjj/Qf6VImYTdwaYwr/CtEogE28Kz89ETjNbTC1TeDNsVddSsAh
   mK+Eu0tjJrH/7Km+5sxGqGjjtl5x+YUBORa/We3tzeBP8+JcAVsyWojUv
   Kvivy4mLAOhiM0JvWM96rYBfj4Oyb87i4OIqXD4fG0Xe7KIucvmAm64Ki
   wFpb9I26Ty0Aqz+ntdJwLtpnOmmouIQ2fjEgcjkCdxmzZaDDdbBKvHXeZ
   R8isUkw4dvupNDLiiPghKVZzpumVBU7T23s2NP2/cssKkbfsEJz76+nFo
   /Nn/VEwVnFHbCkqoaeYVltRVC7ikpQxSE6JTNkG8ZztMiCM9rFWd3+VRE
   g==;
X-CSE-ConnectionGUID: w0RGizj+StmsgdgeGZ//hQ==
X-CSE-MsgGUID: FQWi6Yl9SnKGnsPnn6Irkw==
X-IronPort-AV: E=Sophos;i="6.15,322,1739808000"; 
   d="scan'208";a="89555696"
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.64])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2025 06:45:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK8KSlqA38Hy/EFCizX6SLT7GrgjK39/zF13ty9PQzTlDbCD3GBF3Kq0wdhXwRfyGg9rzOHNHsK69WBgUW+2BAXvs1gIMczNXMUMQn9zCwVAPTcwImQfQqXMl1U1dQHkrLJONn1TBI0VTtP4Avn54Z80Q0B5hRcDrTqKQ+YrkAq56D6Ntn7aRgPT1qxFSQtTO9ZxmM4AvZZwjT2vlJXQaQymvRvanqKomMRNQHiR7aELpf7otl9aglaPQFPWmyzmWSPv9m6u22VilPphC9XraFZqdwINsjLZFnjPicJ8vOdsKN5OKYQrakgcJFzh2GZiNEBojnd4cinYCNAS7U9fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYni9bfiGcS6BGWrEIGLWZ8yAQCCqMPooB9oQdKPeDg=;
 b=Lp1kCTP9k8stmONSKQaLYq76bq7F84GgHVx4FEs0Fde9IUg9n07ml3CTZi3myZt5mrR2HwzIoX8Yil9MjZVldOPc/8ivSHx2I1irPFoTb7TPpCaDgBDAiB1Bf9+mbiWL7tOIVtLFbbuNrWwrJTmczhFEcTwCk3jFWqGb0JCkOQzf6MWyG9nQ3ANS9K3Yl2QcfyPv0wbz5EKjyZceB4zB/H+cI0P6WERc0VxRf2MJB1qrd+OmENw1urpAOD4rnrj1imbc3IXiNKGjo3DsZEg1Fz5DBSd5Wy9+bIGmFjRx7Tlil4YeFLNK1AG7pdE8+0FC5y1i7c9gwYIXV5aHHu9xIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYni9bfiGcS6BGWrEIGLWZ8yAQCCqMPooB9oQdKPeDg=;
 b=NJXj1EkwxOapChDZHmTr6gGc/W7P5ZiVV5swBEFpYY8keXjWm83bX/DWHx1VWfcLWwZcCZS/BC0BUMZabox5R210Ig8bM7IiIEqC5jjfAkf+pybsfiNxxC+QSNWrpuJs4FSvSC6ChvTXAGnv8CuGY/Te88z4Vj7yXpHaeug8PYs=
Received: from MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 by CO6PR04MB8379.namprd04.prod.outlook.com (2603:10b6:303:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 22:45:44 +0000
Received: from MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8]) by MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 22:45:43 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAvfEACAAkIngIAAA8GAgAAZ552AAkkWAIAOmdwmgAAIp4CAAc92qoABUZQugAQlcwCAAikEo4ACYnMAgATwiwCAAAL/AIAQeg+AgAA+eMyAAFPbAIAA1rxu
Date: Wed, 28 May 2025 22:45:43 +0000
Message-ID: <MN2PR04MB6862D7D04849EC5870D014F3BC67A@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
 <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
 <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
 <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
 <ede69310-a640-489c-8922-24dd62cf6ea1@grimberg.me>
 <7f7e08be-4930-47e5-80df-91329c827915@grimberg.me>
 <BY5PR04MB6849D665ACF1F64022583047BC67A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <87aa511e-f65d-4521-98f2-edae0fa31be2@suse.de>
In-Reply-To: <87aa511e-f65d-4521-98f2-edae0fa31be2@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6862:EE_|CO6PR04MB8379:EE_
x-ms-office365-filtering-correlation-id: 92fbcc61-90c2-4126-41e9-08dd9e39611e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NlbzR+aDOLlMiX8yQlnHnpLc0L0yWZl85nyYdPc3uqRdRUx8zsUggR0b27?=
 =?iso-8859-1?Q?V46IXxdAoLu0cSO/XyTnCq4L3i0XMSAdtWBBRz5AO2z5Xh3x+/PoWFTn/v?=
 =?iso-8859-1?Q?J0MpDYzUgpJuGqvyXYl4qSpxm+ggtyLMQo9MbltXTEWrli+LANbKTsBA6G?=
 =?iso-8859-1?Q?7bf6oUnD3q4ehytJaihEhCi1zYJHvUTQkFGxALXt5hD7jfD8815MKc1e1U?=
 =?iso-8859-1?Q?+CAock6rWdPfSbALOErrZ7I2rDNLzx8acWWjKBVDeNyTES0L5CCq0BfyJu?=
 =?iso-8859-1?Q?kKq9hPxSZPcmKNTx44gGUlzR9RGoGpB2IGEViq4qbcY9Ygy9ooIGqPTiH6?=
 =?iso-8859-1?Q?Iz5SYiU7BDa7+lYHM/arq7zfPtnb2UkEvLzUOI1dnYybk9SFq9FaY50Ow8?=
 =?iso-8859-1?Q?8QdhXyyDbWw0wlg3bBpENDW4VZP59lRUpqmfvdLYJczfePL48jSaDgJHFR?=
 =?iso-8859-1?Q?cOqp0TL+2/3IE0NnglFc6xc5q0axeEM39OAZAd350ARujlWiITUUA+NSND?=
 =?iso-8859-1?Q?/5Zhe2zZTQwVV8VwqaxjlljLvxdDMJ+6U0q00w8XlEFqPciKrqgiss9JkK?=
 =?iso-8859-1?Q?UwPDB5kgTUt0nb7bCbOw3k1VX61E+s3996vx2+F06HQNHUYPJ4xwQziH/q?=
 =?iso-8859-1?Q?ldNnLOOGfTPQ8ZEzZ36KeJoG1Uao0yWzuUrmQtcprO4lxcAqxOFR/bgik/?=
 =?iso-8859-1?Q?G36ellUuZNO0hkydd0oHG8WAFEjQcPP7/qWK6n1KAlC5oxdPjLAuUKpUtn?=
 =?iso-8859-1?Q?8dr7Xr50Ro8Bp9/zgtReb5qOIRm+WYPmkkQYCyWSaiqivg1PFigfjGua8M?=
 =?iso-8859-1?Q?nvcdmdVclzjjl8iSwPZY9HTEkJrFwf4raEDMbHpiuGJgi779xzU86flc3x?=
 =?iso-8859-1?Q?T82IuIHC/pC9gGbJWMMCVoIyR5p/Smu39R7eFyePYEWHRzU7ZIq449DpEd?=
 =?iso-8859-1?Q?Rs5QuebkHQCBYj3iiydhRxdGD//bZaqFBq3N3a4LcYUF/ulRbrOtbspK+e?=
 =?iso-8859-1?Q?VDHXjPJe24UOB8QYFvbsG0AKr9KZqxmx2rZd12n+lamnjtBjmIdKHXF3zj?=
 =?iso-8859-1?Q?sIrzPyWg6jzg+OoYjLzKRsdHIBv/yHdy6LmdlIm1aCV2XZ/vplpRiKpKdh?=
 =?iso-8859-1?Q?+tJIrUlhEzwSfSLrzFc6ohsOHY5peOoEYw41M3wWuUHHBYk/2wrDpZxT6W?=
 =?iso-8859-1?Q?cFiQ3WvS8AtlfxiEH44fv3ab09k9kIcuHdox1l8lahhuKM5l/JaOE1xzFX?=
 =?iso-8859-1?Q?xBtTKA7l/Tnf5bDcfQ/H4RM3Gg7YjbpGCWrw79E8HAvr8mP0PO0noUsEbq?=
 =?iso-8859-1?Q?420m0MeK79tm48v6X0zNmpLqNYzTc6P+YXxBJqLn09Ee9AgWCUNb1YxpDe?=
 =?iso-8859-1?Q?Th8nbgiRro5KYfUlWoDQrrkWs5z19vp0FMVERXwsNU+g78HWNDBHUeUKUp?=
 =?iso-8859-1?Q?qag1ryxddORKliXASGzUT1QV2NhVoNLcZdNhJnhN4yeVuLzNLoqUVvt7Uk?=
 =?iso-8859-1?Q?Sc0DBgTK7aym95F6ljKIZ+5Rl56V2CYo1oKLnlz/fMXD/DkE/qwC5VQXD6?=
 =?iso-8859-1?Q?eOS12Qw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6862.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6gfUd3i15IivIcXMVZKhHjokQIXRhc6z22cMTfuisbjLVC7+d9ImzwIX/z?=
 =?iso-8859-1?Q?ENqu3c2mMUFU5AgAjVtIhmA3kGeGeJdIDDSBFK0qxB/ut+HZ84/iO9raG+?=
 =?iso-8859-1?Q?f62O8Fl+zyAqEE6o3xHrU1Z6GovsnUQNPlbW00ZWqZZQl+XRrGLQLixNmF?=
 =?iso-8859-1?Q?PecTtpQvGnStvh8B3zFgjZDL7AO1GR+7GlPWhcSuTws24y2Z/rtaK63OER?=
 =?iso-8859-1?Q?2SNN855zcyBm9+KpWyd3KH7RKk4XQ9aW89dk0c9tBaUImuZlA83pnW9dip?=
 =?iso-8859-1?Q?dTQYEn9rQaGNXyn0YHqZBNlIlq9BbRtxShbBAJqPFeDV9euQU4rQ871rqh?=
 =?iso-8859-1?Q?KR32mTQ10OuVRB6SQPA/N1YR8Kqu81EftfNzD4S7vLciOG5jKaWX0FnuW+?=
 =?iso-8859-1?Q?UIVdkTxzgCvuNm9bm7IWIcTrYxHvtJa1yA4G+0tKqna4chtz7P79akMrXd?=
 =?iso-8859-1?Q?FU29f4GvPNk0oBriI6P5X73L7y0G+stuzreaEGFokSZJuUXvBNyUYOM7Q9?=
 =?iso-8859-1?Q?hVW5yi2ZqmPF22KHhlZ0vgZJsZEo3s1Iq0Kc1CpnD+EQFfLQz+5dAODIle?=
 =?iso-8859-1?Q?NTtKxHhM7mruA5YBba8ozYaSeIha9UYgmUPbCiNqSWhiyDhn3RSCaiNH7Z?=
 =?iso-8859-1?Q?P6VTGhvHfBtcM9gbjs8Y+Cej5HuhGlL4vzVOQ5/iPIr7RZlQ10YB5tnw6g?=
 =?iso-8859-1?Q?r+ikyHWh4gFJaEv2OhXcCgex+ebTuHNjaF2RPEi+/ErPmuyZ9Yv7IT5AZc?=
 =?iso-8859-1?Q?b78CychBAKirOJs0alQLFuGV3LN+qhvOa2S2fzxLb3HRRynwNzoEBbdCcA?=
 =?iso-8859-1?Q?F34RrXiJtcrtbGjWs6wYogJRs8LuzSPGjfnHoq1ztkBMISyYr4RlMDSbKy?=
 =?iso-8859-1?Q?c4QLBnrY4CujdBnqkySdfqQeQqtbuEv1Bgk1gNIfKZw1OAvx81hq7c+uyJ?=
 =?iso-8859-1?Q?Y55MLFFe5pV8YSUfhuaSiLXL92x/eQNgLYd48TgWWordNTqLBxlW+lzEEs?=
 =?iso-8859-1?Q?605+6E+6sPFXeoAsA0LHd1pEaURlABwbEAtDK66SwwHeMf24hKZ2V5rAQC?=
 =?iso-8859-1?Q?DCOdY7c0nIpFZauvy3ZamkKSV9dok62eeR14OCZslKxZpb1VgEG1cplBi6?=
 =?iso-8859-1?Q?IiSouHbJwtPl+q+RBwKsc8kawA0pRx6rmYmovD37qTJBT6jPEHFeGRAAaO?=
 =?iso-8859-1?Q?2dzEc9I04KrhfDlUZjoMzy9IOZQZlFnb2qGJUST+0IGm3H/0NxMXaudmpd?=
 =?iso-8859-1?Q?+wab6Rz2mCceEx3wPSMvLBFMOVrOUhjXcgVi35NZwiaqo1vX6VwFGgcyop?=
 =?iso-8859-1?Q?fD6fEkRCyfM8zeaixDEMXdk6xXFoT0FQ3dBmmXNmm1s8OdEthViZ9P52+C?=
 =?iso-8859-1?Q?XztQyq7g/UpTceJHsS33Qmp3uBwBbU1aLFCPuWx4RV1wZsJfc7kebunvsa?=
 =?iso-8859-1?Q?bgDh3S5vKdwOAjDKoDCaE8IvxyrVqbSbYRbt3pT9lZxnYc0z6C8d+52jdu?=
 =?iso-8859-1?Q?XQ0BGkd54Cn3HpfAKE1Q3/qaMTonO6+aJrS4hZSShWLhUHwSzRjJyt+3Zb?=
 =?iso-8859-1?Q?p+9F85VvuPE4eUbiqMZHNrPUo5lZ2zSHPoodezVDfRTv0grY9V3QCTy+1U?=
 =?iso-8859-1?Q?ah7ZJj8zigf2mWbn2kS5v3WodXXKtGoGrz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HsJ0OOAHt6FHK5nrYeXS4pS2B+ITuhDDSljhWJpI18hNGT+I7mKEh53wGKEdyNry1zARq2G/oeFMWVUMoZgxUJHQWIh8/hcwfELe+x59yRpddl2Kzt1U4cYPMfUOvzNk+TEaRXQUywTBHoKC79rvtUNHKOqR7BvJIwiI+WbmJSGb5hwgKTfpbsc0egjjTca+Ex833y1m5y897rLEnixGRjwExNwNj6dh9eHhERg9DgJWK+QeEE4VAvuf5e9Jg+C1zXWDtGpIdmQuugJ4+Efde7lPXWfnveBiuXTD02F2Yv51TqIm18xCxtvoxDK80HtGHCOxl3rFJxb2mCaRYBpXjLJd/uEyH5+D2SO6oWaVDTyKo6uunKjIDXMLyiC5IO/ButM5T3BReBS8m1LS5pXzpXGPO/yBe8H3ZZS9qfN7Awoi2ffDLRvV1FsZ/cukSDK5DybJVymDotjahkMW1K8GklQXfVIuLAVq3+NBiI36ntZy92LgKLrunu+9HJvrGusHiSi9viQYBSvSTGiC6nB2383kxDUK2K7oS3Sug6mTOCIo5qhxNEFCvP3Mj/EaaNgX7aFtlrCHr4OYwxQX9E9LOtthKpJBHRjFmRfVcFahJ7xrwekWVh/6/A5+aXQk8zGi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6862.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fbcc61-90c2-4126-41e9-08dd9e39611e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 22:45:43.5856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOr4CJWrn8NB6Nugc38Zo7BuLer4+uenaw8ieilRc3yQy11s8vxGd4fcyBZRuAcflWxnvhM64RI91rFHf1iHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_154549_798323_69972BAB 
X-CRM114-Status: GOOD (  15.20  )
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

Hi Hannes & Sagi,=0A=
=0A=
On 5/27/25 23:33, Hannes Reinecke wrote:=0A=
>>> On 27/05/2025 2:49, Sagi Grimberg wrote:=0A=
>>>>>=0A=
>>>>> We still need to hunt these down. I'm still puzzled why adding the=0A=
>>>>> WAKE_SENDER=0A=
>>>>> flag was able to make this issue disappear? I'll have another look at=
=0A=
>>>>> this patch.=0A=
>>>>>=0A=
>>>>> For now, I think we can go with this patchset, and then incrementally=
=0A=
>>>>> fix the remains.=0A=
>>>>=0A=
>>>> Kamaljit, can you check the following patch on top of the patchset=0A=
>>>> from Hannes that=0A=
>>>> gets a reproduction?=0A=
>>>>=0A=
>>>> --=0A=
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>>>> index 835e29014841..2f5f2fcfb078 100644=0A=
>>>> --- a/drivers/nvme/host/tcp.c=0A=
>>>> +++ b/drivers/nvme/host/tcp.c=0A=
>>>> @@ -1075,7 +1075,7 @@ static void nvme_tcp_write_space(struct sock *sk=
)=0A=
>>>>=0A=
>>>>          read_lock_bh(&sk->sk_callback_lock);=0A=
>>>>          queue =3D sk->sk_user_data;=0A=
>>>> -       if (likely(queue && sk_stream_is_writeable(sk))) {=0A=
>>>> +      if (likely(queue)) {=0A=
>>>>                  clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);=0A=
>>>>                  queue_work_on(queue->io_cpu, nvme_tcp_wq,=0A=
>>>> &queue->io_work);=0A=
>>>>          }=0A=
>>>> --=0A=
>>>>=0A=
>>>> This think this may be preventing the scheduling of io_work. But now=
=0A=
>>>> that io_work is=0A=
>>>> also ceasing based on sk_stream_is_writeable, we should probably still=
=0A=
>>>> schedule it.=0A=
>>>=0A=
>>> Kamaljit? Any info on this?=0A=
>>=0A=
>> Sorry for the delayed reply. We've been hitting one issue after another,=
=0A=
>> hence the delays. Hoping that by tomorrow I should have clean results wi=
th=0A=
>> a clear a-b comparison of only the changes you suggested.=0A=
Sagi,=0A=
After several more runs, I still don't have any definitive results for the=
=0A=
driver change you suggested. The tests did fail with IO timeouts but=0A=
the rootcauses were clearly unrelated to the Kernel/driver.=0A=
=0A=
=0A=
>Just to make you aware, I've found another issue wrt=0A=
>sk_stream_is_writeable(); we are checking it from the data_ready=0A=
>callback, and do not schedule io_work if no write space is available.=0A=
>Problem here is that the data_ready callback indicates that there=0A=
>_should_ be space available, so by checking sk_stream_is_writeable()=0A=
>we already assume that the actual write space might change, and=0A=
>the callback might not be a reliable indicator.=0A=
>But from that follows that also the opposite might be true, namely=0A=
>that write space _might_ be available by the time io_work is scheduled.=0A=
>I'll repost the series.=0A=
=0A=
Hannes, Thank you for the V4 patchset. Looks like V4 includes the last chan=
ge=0A=
that Sagi suggested, i.e. remove sk_stream_is_writeable(sk) from=0A=
nvme_tcp_write_space. We will continue testing w/ your V4 patchset and=0A=
provided any feedback.=0A=
=0A=
Thanks,=0A=
Kamaljit=0A=

