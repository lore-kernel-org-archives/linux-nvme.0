Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC1FD45F1
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 23:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SalS3QCu1IqlVHGyJd3rULKnQv619IAuRuOBWicd+44=; b=Avd6uud2dzV6L+T/jKYT+JQS8w
	H3JkqWj6jOWHJY8Z+2Z3FpzuLQRlyLSIW5wV5D4zixqnTWwAplJ56K6jQcJZbmIifTN5e/w8k6BKC
	x/YT6sJI+vBLai9FZRhrvKfisr/gxJa79uVsamYQN1A2UNBofKAfqUXWUPHpwSoOVPTP5VPuFwphx
	B5Xcq0HamanE4UoWPPN35O2fUBpLYFlA6ubBqqsxt4CKt0N6gKFDT/0Y5cphHmYjAlkFyIto6Zag9
	2Ct4udd2L8rBYy2Ar3XmWzScU+8S2XtFb+OAjlTvM/gsLa7ZfVdMLocfZn/HO3vKmS6fMcmtEDtzK
	MAOL1W7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvORM-00000005545-3u2U;
	Wed, 25 Feb 2026 23:37:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvORK-0000000553h-3UJx
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 23:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772062630; x=1803598630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SalS3QCu1IqlVHGyJd3rULKnQv619IAuRuOBWicd+44=;
  b=SrTayamPmqd2dRw9C6Abz3SyNgrK6biCtWeqkEzE3+JLcyOlXcP/8uKk
   IUjvGT6uHepyI3h6AV7rT7mEGNyqUj/mzkyZOsS9/6SYpf2vO0EG90EJA
   cKWHlNiR9pjR7mHCCfmlrgj8gfcqSHLfkh0jFcz0O7HTQePYuTZxMotRa
   SE/5GuBgYboV4o5yAAkrsUaskwAE9G2xPXi5E5Z5QjWmgwByEn21SHSJc
   N+i9T18k7IjvO8Y6YwIFBNu1fijLEJJ9ZyRLC6h8vL7r5PH5JUrJ4uNDz
   HkJO7szaR2nUR7XeAkoCuajhCWezIMQcUcYlwwW+lVc3H6Ir94QxzGRvl
   w==;
X-CSE-ConnectionGUID: /JSUl7b7TueUJ0NUWF3sdg==
X-CSE-MsgGUID: Lz/gELrUSeW564OrAKBRKA==
X-IronPort-AV: E=Sophos;i="6.21,311,1763395200"; 
   d="scan'208";a="140533775"
Received: from mail-northcentralusazon11013027.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2026 07:37:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUi/L0YsNKCZMGS6ke3BzTQUomK/OB8RrP5hLv7Tkequ091PJU4qEKQWCLDTxyMwf2vO2x59qdsuyy1dZ/wOB9TJ1DJe+4Oe78GZsAZRUd5gyipYJpKPeIMnHHLcaVqkd+XG9gN+ME6m3bnehiUa6HBhka+Ia9xmWTzeHeAMVibDbLejkVgf+CrkrkQSSd1u8ggSK0K8mgMcbUpuvFx/cRppcUaD7rC3c1t6jKRI0H7FwbKyNLVAwTf6gWDViEvYAqRFJSRWvwNZHzJLXupfwxcc3YeKHo4j5UhwQ8fimSZfuJYu5Kh+MXPal0xQJBE9XqlJKztSbyyxTVnlWnGr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SalS3QCu1IqlVHGyJd3rULKnQv619IAuRuOBWicd+44=;
 b=lGKQxmkE1xe6zppQtcz3c/itQP0v4SxXhBCB77hBazYgV6y7/8R862AgyswkQDMYNFbyhCDYpjD4au7+pKKK2YsQrFsAW514xP/VfjPidzFdJLqYE4WI/f5cpz6NE4P4EUcbgJCfRj0t16t/obsb2z6gqnJbtJhGc2TzdlR1igtkZCXFw32CXPHs1mKbv08kiURXZuIgWD3/ASlXnjxbic0bMKJPFZ9goLh5AcWwrK3yT2GOV1ND/b2iuppQVZlj95yykwxAbFb9ZaotpcOWT3jVPzW2tloEkO0c9I4ZnsDScKfMwgpQ98LBe3s9h4bEfbXGrC9swhCsfxpuNhsawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SalS3QCu1IqlVHGyJd3rULKnQv619IAuRuOBWicd+44=;
 b=RXcPc1JxxEYSNyMCR6dtfU/DVN/+ZYM2ZbOyv6TJeoHop76IYl/UJpWMukA5JnPWJj7lFsERqH260RybJNNUeVYfSsc5RmR8Abi01M5ViaLcZ6KByV9lHlcINX4sqRbLMvoa3UDO0lyGI4ctVn5UY6MfH4yHUYtg+3os8oIXtCw=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by DM6PR04MB7018.namprd04.prod.outlook.com (2603:10b6:5:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 23:37:04 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 23:37:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: hch <hch@lst.de>, "hare@kernel.org" <hare@kernel.org>, "hare@suse.de"
	<hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
Thread-Topic: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
Thread-Index: AQHcI9yXM3tTa6DDl0+KwEFYCNGDybWUQy4AgAAMagCAABo5gIAAHhMAgACPrIA=
Date: Wed, 25 Feb 2026 23:37:04 +0000
Message-ID: <3739383d428d75ca1eda44ae61716057e20488d0.camel@wdc.com>
References: <20250912115829.58669-1-hare@kernel.org>
	 <99c9b1f7d8bbeca3681bb2f8502fe6af1374df8d.camel@wdc.com>
	 <b778bc2f-5911-431c-9b65-1fbaea68fd4d@suse.de>
	 <8c3fd4f7f9c0074ec35fb15d1573ad2e3155cbe1.camel@wdc.com>
	 <d21a9ad8-24d6-4210-8779-0cc91175f57c@suse.de>
In-Reply-To: <d21a9ad8-24d6-4210-8779-0cc91175f57c@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|DM6PR04MB7018:EE_
x-ms-office365-filtering-correlation-id: b20ed76f-8bfa-4b4e-9ad5-08de74c6c81e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: DrRW9uevMwkm/XjeWbm3aEu9n2K5D49Agtt3tFVB2GBano6Z4O5z1WPM22ZpFr93xWn/qqz7u6dtTFwZ6F3QLlSfc8AQkknO8U4spb7dFs30apALJGyw52JAti0Q+PHi2nMtn0E4vgo0ZuSdE+dZEmM3bMxBZqTynSbhQPuUpaVNFkdxYoGtYR86Fk3fv0la1QzU7aOcyYXOxp4QJmSyIlkJMDrOf6YM8gNWAAszCXAad6i0GgadYa3fxcxLSJtK628ngrWTC3LEfYQdR6Xc7luCI7L9Ar8Q6Vwh64HsM4683uxqVpGhhFab9m9D/rvpLbncKLcV4z3nOmvLo5xR1F/ejPyO0jpu84vpTTw3UB4e7UhTRgCzZMOrappcWcyrCosFgaQuI/u0wj1kLT/kichR41IrBHj1Ub0QlBaJthsCIqJ/qqQyveEN0k6MC4sNvLmQZcoSynJyjH4yhlzY40ZmuoiW6ciA+VNSMPeAvjdNSikwQJxtheBYORJvuyV4K3itprEBLxi79khDN5mipiO09lhjZrx1zy5eX5Vy6TRGoDwTNxDqVWXaBA8ZMYNanUwBBAz/lfdbvozkx8auSBqKzpC+ZgET385f5OhwJNlVzFfqp2C2EcoRFXD019YV9itPa9qyMIVnox0bhyankDbFgGflnTuDN1SRWYh4gNcecan+8RHtqyXu7FQW6kNa1nOw/2uC5DMrswv0waG+qbG/OJRE1jXG3bxy7VTRWnPnIq/HcMsE1Yp/7aBHLj/ikhSEqTIeNBcAxEXkBnkx4BFuX1uuAkKHeoMZwqj4++Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB9849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm1JNjIvRmhuVXNpY3g5SGpnTGdLYnA5RXhHbCtRR0xNMmZXd0xGdUpvRk9E?=
 =?utf-8?B?K0U3MFcwdG9tOFZtMFJwdXpUelVwUy91bU9tODhpekkwT0JYSzJ3U0tiWk5K?=
 =?utf-8?B?UUlHZzZBL01SUURWeWxIb2k4NnhhczFNWmVJcWdFUldSRVpIUVlTMGhWZENr?=
 =?utf-8?B?akRxWkE5RENWdVFmNXhjMjBsUlgxajdka05LdTlKMkJKUEJkVHVFVFh3WmVr?=
 =?utf-8?B?b1dYQ0FjSm9na2RPU3MwOWhVWFE3azZTVnc3Q3Rjdm0xS1BURzllVTZZZGls?=
 =?utf-8?B?VE9FaW1Jei9ZeGZONzN0Nkh6b3NXK3NSQk9zREkvS2xGWlJwZEpTb0NvUkd0?=
 =?utf-8?B?MU5BaU5oWkd3aHFBUytIcGxJTXlXK3VoVWZ1NEk2cXIveTlSZHd4TFVNWHBU?=
 =?utf-8?B?bHBaTFd5MnRlMlZMelNTb0dXTVFyRkxBK2tlNVF4RWtxOUhpd0tDVjBLSzQ0?=
 =?utf-8?B?UWl2dFRoQk1RNzdzZ2RXWnkzYVpSZHhiTUVhMnNhM2R5eTBkQUhaUzhyRnEx?=
 =?utf-8?B?aDVsUllOT3owZUIvYTQ3cUNrdndicXdxSEJkUlhPYWF5cjVxTGl3U2FDa1NJ?=
 =?utf-8?B?c0VFWlFXNU81U0RmcGUyZlJzZDMraXpPZ25wc1ZPMFlMSnF4QVFpcjJHajZD?=
 =?utf-8?B?WHgvV3NNYU5ZYWs1aUJ1aUwzd25MRTNtVzU2cWhncU1LTE9WTXRhRHBLbno0?=
 =?utf-8?B?bmJWaDZWY1d5YmFkVmxsaDYxM2c2Qnl4VjRRVHJ0dU5iUFhWRUVBQkZKbzdV?=
 =?utf-8?B?YXhBc0VtM1pvV0JaUllCRHZBVStwSVF2SDEvSWVtNDFsVlliNE9IbHprUXdz?=
 =?utf-8?B?OEFSZ0htYnJkK1Q0S3NQUmc0TUpzOHZTVm96OG5YUUplK1YzbDVvZExnVmFP?=
 =?utf-8?B?T0ZSeis4SGMyS2RmMHFtb2tTQlV6YVRoVUtWeEVMT3V4NEZzbURremREZldU?=
 =?utf-8?B?NUF3Q2p5b0MwT2JITUxtc0M5N2NJbmZJUGk1dmJmZUhRMTNOTkNlN1pqVVl3?=
 =?utf-8?B?c0NKTDUyT3lMKzBKRDMyVldPTTZabjFSYXoxZTFwTTVJREs2dkt2aVBIa1B2?=
 =?utf-8?B?RkdqQXFuV1lQdnIxNUdpakVpZ3h2Q3FyamRFOGJQendYSXExYXVJeDNscjRQ?=
 =?utf-8?B?ZHUxMUFiYlFBdkRmUE9nVnFvZit0Vk5CYXlwb0g1b3l6Z013NHgxUloxeTl5?=
 =?utf-8?B?ZzB0UGppdXVlZGl0RWRNK3pkSjlGNHUvSE5WZ3dRVE9RTzk2OGdNSERpMitW?=
 =?utf-8?B?WHFCMXJqMllraTkxV3lwMlpsRzJ5b2k3WmVEOVZTdjFtd3dGNXJMZndVb2J6?=
 =?utf-8?B?N0RWbVZlZFAwZzVNNUNsQmtOSEFjLzFGd3RmVDFIdWFMdkVzemM4WmVoMXox?=
 =?utf-8?B?dDJrVVRpbnZzbHZSK1lkMTdOVTFJR2JaSTZHMnhRbzRJblV3OFZDUlBYQWdm?=
 =?utf-8?B?cnUvc1g2T2hYWitPTitKeUFMTTUwZTE1V3lkYkhOZ1kvZHZNOXlFUmhmUlht?=
 =?utf-8?B?blNrTFhvZitudENqRU1jRWRXajJ4MmxrV25FRy9oTmxKbE93YWVNazRuT0tY?=
 =?utf-8?B?RllqZXZIZlpoQnBVT1ZYMzVWd0ZPa0ZjS0dod1A4VzZvakhwNUFHUndaNk5X?=
 =?utf-8?B?ckd4emVhamR4WkU4dy9lYXdieFVJWkNNZEUrUFhqamZ5Y3FhejNGSnBlWTJR?=
 =?utf-8?B?V1d0TW1iUjNyelR1YUVBVGtCemtkRUx2cUJ4aVl5eWc2TG0ySlVFS3lzTGg4?=
 =?utf-8?B?ckhma2tIQmc3bnArU3l3Y3dSNXFKdUJuVUNIanZXeDJ5RisxQjNTY3FSZE9I?=
 =?utf-8?B?YUcvcC9IcVd0Sm5jUTJ5azBvVFZ2ZE1zanNreHVBNklOc2c3MjdrR3dGYk8y?=
 =?utf-8?B?UmlwSDNWMllJVVVUQnpLcHZrYllVOGNkK3ZxTmlSL3F1WHEvejZIbmJjekY2?=
 =?utf-8?B?cEtjaWJQS01LbWd0bTBQTlloZ1pCUjlpendsQllTK0IzNk9MMFovb1RKaDQv?=
 =?utf-8?B?aXdDVFliZTNvT20yNTZRNk9GaGZMMkFvV3RiUjZoMjNUeWpSQ2J3S1k0TkVC?=
 =?utf-8?B?Um1VZldqbzU0dEtaKzVsdU1iUERKZDNVYWllOXBvWWhJU1N1alNXNEJUNUlX?=
 =?utf-8?B?LzhvZTNudlhqa09IYVpMUmtPdjRFY2N3bWp3WHdBQ01HNjZoU01lcWZ1bFgy?=
 =?utf-8?B?UzM2dHVVZkhOWmphMmtraGtFdFkrRnB5ZkJPZHNuVXEwR3JDL1RmWXZiVWln?=
 =?utf-8?B?T3c1THVKcEFIcEZiTklvTlRvUmUwTVMvaCtwUzdFM3J5ekxxWHNzbVk2Q2Fs?=
 =?utf-8?B?ZnJsRW5EUUNMVVhSekpkZzllL2VpaFhBa3JOb01qelFwc29PSTdYZEl0OEtD?=
 =?utf-8?Q?eSLHmcIAoB39nRSDg6K3cQSAvyMZfK21XDUvterte1Ots?=
x-ms-exchange-antispam-messagedata-1: OTPPlvsDRz7Fzg039e7vETovhdFZcB7pf6s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26D0BD5991ED8B40A9A955591FB9EB07@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ibhcCwpY96jD43NSIV5STiahhGsZ+EsRnQkoJ4c59kA/EcLWuOzoUYtXSwhyQWmugUnGldQr305lm3X+A/LneerNemc8Mm/bKWbR/yLOhkuQyPLgYqstv5SGWVmBoVMnaaLh+eFtvp/bmbmSJEUfyIBn5wIgdiQzDorOOz+88R4fYTL4J3ABH956Q+YXmj45NEJnxpzTOgsmFquqK9jKDyEsAcXtonJ0NdaD2kgG32tVXVABL0GuHnRb0yDq4ynYTNo5PnrfXKWnGq2lb7Km4kDZxXNowtia/UT4NdxEs+5UfqlwuoNOwRbkbfNbZdFXOJrlLaTlaLHbZr7jMpC1FA9e6ZE93zvthichQHoCFbWAwMFykNlFb3hJFh+jul62gFaMQ9ZLc+ecq6FrOv59IiDr1v0C8Uvlzbp5uUEMCbjXv6va6X54fyqlsMolSNw3SUgHLlmjoPqgO4CuruS7QuxC2RO6B3eBtxYL7ZcYJGmVxdF8aKgF9V9CmBGDFvbS6mAyb+jvd01HhCmzLzHbc4cL6zXw83a3PKjKwqV9Ygc/bHldN22iE+vsunJ8r2sNZ2XSqzrnsXkXN8tkPDNx94YOiB0WlTxhMEJvffvNyFG9dyBYf2bZyyLw7XFeKZlK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20ed76f-8bfa-4b4e-9ad5-08de74c6c81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 23:37:04.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1k5WJmZZN/O+F6kdNiYABqfdNQ7Kx2nIQkZMippg+OsLJIW0uip4Gafwf+/NjeusV74oZFhfto8fOZGn9QmHKDsFqe/5vQ0BNWcVe+h1FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7018
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_153710_986916_5E660EA9 
X-CRM114-Status: GOOD (  42.57  )
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

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDE2OjAyICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IE9uIDIvMjUvMjYgMTQ6MTUsIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDI2LTAyLTI1IGF0IDEyOjQxICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+ID4g
PiBPbiAyLzI1LzI2IDExOjU2LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBbIC4uIF0NCj4g
PiA+ID4gDQo+ID4gPiA+IFRoaXMgZG9lc24ndCB3b3JrIHVuZm9ydHVuYXRlbHkuDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGUgcHJvYmxlbSBpcyB3aGF0IGhhcHBlbnMgaWYgcXVldWUtPmRhdGFfcmVt
YWluaW5nIGlzIHNtYWxsZXINCj4gPiA+ID4gdGhlbiBpb3ZfaXRlcl9jb3VudCgmcmVxLT5pdGVy
KT8NCj4gPiA+ID4gDQo+ID4gPiA+IHF1ZXVlLT5kYXRhX3JlbWFpbmluZyBpcyBzZXQgYnkgdGhl
IGRhdGEgbGVuZ3RoIGluIHRoZSBjMmgsDQo+ID4gPiA+IHdoaWxlDQo+ID4gPiA+IHRoZSBsZW5n
dGggb2YgdGhlIHJlcXVlc3QgaW92X2l0ZXJfY291bnQoJnJlcS0+aXRlcikgaXMgc2V0DQo+ID4g
PiA+IHdoZW4gdGhlDQo+ID4gPiA+IHJlcXVlc3QgaXMgc3VibWl0dGVkLg0KPiA+ID4gPiANCj4g
PiA+ID4gSWYgcXVldWUtPmRhdGFfcmVtYWluaW5nIGVuZHMgdXAgYmVpbmcgc21hbGxlciB0aGVu
DQo+ID4gPiA+IGlvdl9pdGVyX2NvdW50KCZyZXEtPml0ZXIpIHRoZW4gd2UgbmVlZCB0byByZWFk
IGxlc3MgZGF0YSB0aGVuDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBhY3R1YWwgY291bnQgb2YgcmVx
LT5pdGVyLg0KPiA+ID4gPiANCj4gPiA+ID4gU28gd2UgbmVlZCBhIGlvdl9pdGVyX3RydW5jYXRl
KCksIGJ1dCB0aGVuIHdlIGVuZCB1cA0KPiA+ID4gPiBvdmVyd3JpdGluZw0KPiA+ID4gPiB0aGUg
ZGF0YSBvbiB0aGUgbmV4dCBpdGVyYXRpb24gYXMgd2UgaGF2ZSBubyB3YXkgdG8ga2VlcC4uLg0K
PiA+ID4gPiANCj4gPiA+IFF1ZXN0aW9uIGlzLCB0aG91Z2g6IHdoYXQgX2lzXyBpbiB0aGUgcmVt
YWluaW5nIGlvdj8NCj4gPiANCj4gPiBXaGljaCByZW1haW5pbmcgaW92Pw0KPiA+IA0KPiANCj4g
V2VsbCwgaWYgcXVldWUtPg0KPiA+ID4gVGhlIG1vc3QgcmVhc29uYWJsZSBleHBsYW5hdGlvbiB3
b3VsZCBiZSB0aGF0IGl0J3MgdGhlIHN0YXJ0IG9mDQo+ID4gPiB0aGUNCj4gPiA+IG5leHQgUERV
ICh3aGljaCB3ZSBoYXZlbid0IGFjY291bnRlZCBmb3IsIGFuZCBoZW5jZSBoYXZlbid0IHNldA0K
PiA+ID4gdXAgcG9pbnRlcnMgY29ycmVjdGx5KS4NCj4gPiANCj4gPiBUaGUgbmV4dCBQRFUgc2Vl
bXMgZmluZSwgaXQncyBqdXN0IHRoZSBuZXh0IGRhdGEgdGhhdCBnb2VzIG9uIHRoZQ0KPiA+IGN1
cnJlbnQgKGFuZCBjb3JyZWN0KSBJT1YsIGp1c3Qgb3ZlcndyaXRpbmcgdGhlIHByZXZpb3VzIGRh
dGEgYXMNCj4gPiB0aGVyZQ0KPiA+IGlzIG5vIG9mZnNldC4NCj4gPiANCj4gDQo+IFRoZSBvZmZz
ZXQgaXMgaW4gdGhlIGlvdiAoaWUgeW91IGFkdmFuY2UgdGhlIGlvdiBpdGVyIHRvIGNhcHR1cmUg
dGhlDQo+IG9mZnNldCkNCj4gDQo+ID4gPiBJIGNhbiBzZWUgdGhpcyBoYXBwZW5pbmcgZm9yIFRM
UyB3aGVuIHRoZSBzZW5kZXIgZG9lc24ndCBzcGFjZQ0KPiA+ID4gdGhlIHJlY29yZHMgY29ycmVj
dGx5IChpZSBpZiB0aGUgUERVIGVuZCBpcyBub3QgZmFsbGluZyBvbiBhDQo+ID4gPiBUTFMgcmVj
b3JkIGJvdW5kYXJ5KS4NCj4gPiA+IA0KPiA+ID4gQnV0IHllYWgsIEkgY2FuIHNlZSB0aGUgaXNz
dWUuIFdoaWxlIHdlIGNhbiAoYW5kIGRvKQ0KPiA+ID4gYWR2YW5jZSB0aGUgaXRlcmF0b3IgdG8g
Y29tcGxldGUgdGhlIHJlcXVlc3QsIHdlIHN0aWxsDQo+ID4gPiBoYXZlIHRoZSByZW1haW5pbmcg
ZGF0YSBpbiB0aGUgaXRlcmF0b3IuDQo+ID4gDQo+ID4gPiBXaGF0IHdlIGNhbiBkbywgdGhvdWdo
LCBpcyB0byBjb3B5IHRoZSByZW1haW5pbmcgZGF0YSBvdmVyDQo+ID4gPiB0byAncXVldWUtPnBk
dScgKGFzIHdlIGFzc3VtZSBpdCdzIHRoZSBzdGFydCBvZiB0aGUgbmV4dCBQRFUpLA0KPiA+ID4g
c2V0IHVwIHBvaW50ZXJzLCBhbmQgbGV0IGl0IHJpcC4NCg0KSSB0aGluayBJIHVuZGVyc3RhbmQg
dGhpcyBwYXJ0IGEgYml0IG1vcmUgbm93LiBJJ20gY3VycmVudGx5IHVzaW5nDQppb3ZfaXRlcl90
cnVuY2F0ZSgpIHRvIHJlZHVjZSB0aGUgY291bnQgb2YgcmVxLT5pdGVyIHRvIG1hdGNoIHF1ZXVl
LQ0KPmRhdGFfcmVtYWluaW5nLCBzbyBJIGRvbid0IHNlZSB0aGlzLg0KDQpJZiB0aGVyZSB3YXMg
bm8gdHJ1bmNhdGlvbiB0aGVuIHRoZSByZXEtPml0ZXIgd291bGQgZmlsbCB1cCB3aXRoIHRoZQ0K
Y3VycmVudCBkYXRhIGFuZCB0aGUgbmV4dCBQRFUuIFRoaXMgaXMgd2hlcmUgd2UgY291bGQgY29w
eSB0aGF0IGRhdGENCm92ZXIgYW5kIGxldCBpdCByaXAuDQoNCkJ1dCBpdCBzdGlsbCBoYXMgdGhl
IHNhbWUgaXNzdWUgaW4gdGhhdCB3ZSBjYW4ndCBhZGQgZnV0dXJlIGRhdGEgdG8gYW4NCm9mZnNl
dCBpbiB0aGUgcmVxLT5pdGVyLiBBdCBsZWFzdCBub3QgdGhhdCBJIGNhbiBmaWd1cmUgb3V0Lg0K
DQo+ID4gDQo+ID4gQWgsIEkgdGhpbmsgdGhhdCdzIHRoZSBvdGhlciB3YXkgYXJvdW5kIG9mIHdo
YXQgSSdtIHRhbGtpbmcgYWJvdXQuDQo+ID4gVGhhdA0KPiA+IHNvdW5kcyBtb3JlIGxpa2UgeW91
IG92ZXJmbG93IHRoZSBjdXJyZW50IGl0ZXJhdG9yLiBJJ20gdGFsa2luZw0KPiA+IGFib3V0DQo+
ID4gYW4gdW5kZXJmbG93LCB3aGVyZSB3ZSBkb24ndCB0cmFuc2ZlciBlbm91Z2ggZGF0YSB0byBj
b21wbGV0ZSBhDQo+ID4gcmVxdWVzdC4gU28gd2hlbiB3ZSBjb250aW51ZSB0aGUgdHJhbnNmZXIg
d2Ugb3ZlcndyaXRlIHRoZSBwcmV2aW91cw0KPiA+IGRhdGEuDQo+ID4gDQo+IFRvIG15IHVuZGVy
c3RhbmRpbmcgcXVldWUtPnJlbWFpbmluZyBpcyB0aGUgbnVtYmVyIG9mIGJ5dGVzIGxlZnQNCj4g
Zm9yIF90aGlzXyBQRFUgKGFjdHVhbGx5LCBmb3IgdGhlIFBEVSBkYXRhOyBkaWdlc3RzIGFyZSBj
b3VudGVkDQo+IHNlcGFyYXRlbHkpLg0KDQpZZWFoLCB0aGF0J3MgY29ycmVjdC4NCg0KPiBBbmQg
dGhlIGl0ZXJhdG9yIHBvaW50cyB0byB0aGUgaW92ZWMgc3RvcmluZyB0aGUgZXZlbnR1YWwgZGF0
YS4NCj4gU28gaW4geW91ciBjYXNlIGlvdl9sZW4oKSBpcyBfbGFyZ2VyXyB0aGFuIHF1ZXVlLT5y
ZW1haW5pbmcuDQo+IEhvdyBzbz8gaW92X2xlbigpIGlzIGNhbGN1bGF0ZWQgZnJvbSB0aGUgcmVx
dWVzdCwgYW5kIHRoYXQNCj4gc2hvdWxkIGhhdmUgdGhlIGNvcnJlY3QgbGVuZ3RoIHNldC4NCg0K
V2hhdCBJJ20gc2VlaW5nIGlzIHRoYXQgbnZtZV9zdWJtaXRfc3luY19jbWQoKSBpcyBjYWxsZWQg
d2l0aCBhIGxlbmd0aA0Kb2YgNDA5NiAoY2FsbGVkIGZyb20gbnZtZV9pZGVudGlmeV9jdHJsKCkp
Lg0KDQpUaGF0IHJlc3VsdHMgaW4gYSByZXEtPml0ZXIgd2l0aCBhIGNvdW50IG9mIDQwOTYuDQoN
ClRoZSBkYXRhIGZyb20gdGhlIGRldmljZSBpcyBzZW50IGluIDMgdHJhbnNmZXJzIChkYXRhX3Jl
bWFpbmluZykNCg0KMTQxMiBieXRlcw0KMTQxMiBieXRlcw0KMTI3MiBieXRlcw0KDQpUaGV5IGFs
bCB0YXJnZXQgdGhlIHNhbWUgcmVxLT5pdGVyLg0KDQpJbiB0aGUgcHJldmlvdXMgY29kZSB0aGUg
b2Zmc2V0IGhhbmRsZWQgdGhpcyBmaW5lLCBidXQgd2Ugbm8gbG9uZ2VyDQpoYXZlIHRoYXQuDQoN
Cj4gU28gdGhlIG9ubHkgd2F5IEkgc2VlIGhvdyB3ZSBjb3VsZCBhcnJpdmUgaW4gdGhlIHNpdHVh
dGlvbg0KPiB3aGVyZSBpb3ZfbGVuKCkgaXMgbGFyZ2VyIHRoYXRuIHF1ZXVlLT5yZW1haW5pbmcg
aXMgd2hlbg0KPiB3ZSBoYXZlIGEgc2hvcnQgcmVhZC4NCj4gQnV0IHJlYWxseSwgYm90aCB2YWx1
ZXMgYXJlIHNldHVwIHJpZ2h0IGF0IHRoZSBzdGFydA0KPiBiZWZvcmUgd2UgZXZlbiBzdGFydCBy
ZWNlaXZpbmcgZGF0YS4NCj4gU2hvdWxkbid0IHdlIGNhdGNoIHRoaXMgaXNzdWUgdGhlcmU/DQoN
ClRoaXMgaGFwcGVucyByZWFsbHkgZWFybHkgYXMgcGFydCBvZiBudm1lX2lkZW50aWZ5X2N0cmwo
KQ0KDQpBbGlzdGFpcg0KDQo+IA0KPiBJIGd1ZXNzIEknbSBzdGlsbCBjb25mdXNlZCBob3cgeW91
IGNvdWxkIGVuZCB1cCBpbiBhIHNpdHVhdGlvbg0KPiB3aGVyZSBxdWV1ZS0+cmVtYWluaW5nIGlz
IHNtYWxsZXIgdGhhdCB0aGUgaW92ZWMgbGVuZ3RoLi4uDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBI
YW5uZXMNCg==

