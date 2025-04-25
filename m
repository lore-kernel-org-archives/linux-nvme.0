Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002CFC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zp+1dR0JLiqA2rKnKpZ8zTP5KWaFQV6K3hu5nLiYUFQ=; b=a+T/mVjSYgyC9I+hJh4yBNPp0g
	qf/PE/2mKFSgE7FpUdJCJX+iPL0R7l4oyN1Np/stIU4FWNrcgr23Iq5m4H9ZF4py1v2GmV1xbIAMj
	kWNFPFb1kjgXg4jKFE2J8pt6KmD0t3MAp0nnNvnkeaXVnwGF4FNBa+p2VMxQUrxQ0MP3AIbYEKZEk
	bWfWprqUJ+f/f0ylNKKH++GmBKutIDHkP39d4nEE34lLSE9wfKtARAqtuix0GYrsDwMJB8yOGfuQa
	2qlNE9JghgM+iImNJppmm3rAeDqwKKjcEU5PStFfhPCTIXevyzwFIIxHLd5nnF8TINCJ3AvzV4MEn
	uYHPmcmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Slw-0000000193v-3AKq;
	Fri, 25 Apr 2025 23:47:56 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Slt-0000000193W-3Js7
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 23:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745624873; x=1777160873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zp+1dR0JLiqA2rKnKpZ8zTP5KWaFQV6K3hu5nLiYUFQ=;
  b=IDEwiET64Y0AaZTCXiY5sHlojpyUHw7tYfip1PC4mbuGjLDQRobt3V7x
   2PyqKiY2hBAJekU9+N+MA6XRcmBSUoUr9LamMVdtfaY5xQQzHKYLLXAgz
   FFMod+F7Gla0n1NAwh7KZTO5ve8JameqZ0NvwptcYIJeuUnP2zbvLJica
   rzqOHRQ+D1oFGPdyaAuOfheYtZaS9eYMC65afoW9yMo5L5q8qKrrMZr54
   l9ywjie1WjdUoZMvvX3XtSWO5BtCdN01eTVD2ChWup1ZCe4so6id1QtvK
   SMzRFqPnjXz5o4FEE44XPz/uQ5RH5c0xNry/AVPo7NhmbMV49v+ztsZ7t
   A==;
X-CSE-ConnectionGUID: FaYaLn/pRv6KgM319Qocqw==
X-CSE-MsgGUID: CKcYkiL4RdS/CQvMTiRzJw==
X-IronPort-AV: E=Sophos;i="6.15,240,1739808000"; 
   d="scan'208";a="82468353"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2025 07:47:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNFo0iC1hXtniZDfqdf0D2MWhd0ZY8D88TCLZFbZERCs9R943Ge2zauLBG0pupXBSUwf4NEMcrOf+YIdUHVdPOezI+ULrlxhEMd1pbrgBDabiWxHeK81C51bKbXgo/KufHqa9FpNxEOEpWjE8Kjs3m7d+MB2vVhrkHb5mWJ/3yGm+faMeBzi9eItvRBR/ciE9Y9uG3D5p0hNemsERuCDny9SxDPOMk6xVrZmH0oMvFPXn3tNabHy7i0d88e3/iEZJvkhuOCC6oFJBVOCpUwmfINmflQyXJBTH2yTFe9+axUcn43FJYmyOFfWhdbAXcdt3QnlQknid3xwE4vbEHPD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zp+1dR0JLiqA2rKnKpZ8zTP5KWaFQV6K3hu5nLiYUFQ=;
 b=NErPVkl6X5wSCGWkwf4unuhaySxkoNN6pOywLHXHsrc2pVENofMaLzZMcTgAL0kAHM3Isc8dJDN4yPo3Tqw0Ni9qyHlPKFkvH5cOTH+gKPr2sfM4eZtBtxXB54qR8Vk7w0Q7DzOaK2njAe9wcpSDm1d86haANdaTpJxTfIOniak6CAmJWikrPuOS2B13R4gOKfgGZAwib/Oxx9+KL/8Z8YJKzsweMZLwkqsXjsyxQ8UA9nAFws4TmLYEXjG2BLJoE65M6dNUWKEPls0/cDHQlIM9qXvMb4GGgPWM5It1pg0JLkU1HYStr/iXUPQB14bsCl5YglN0YkaFZltV26WHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp+1dR0JLiqA2rKnKpZ8zTP5KWaFQV6K3hu5nLiYUFQ=;
 b=OI4Z+6ItENQXN076KDW8w8k8OtIgGh8ZjMN8iiACApuF9V1HxRf6CsB/QOZA34I0HtKrHd8gvQC08KH3wT1N4nNgY9mppNUQEdSxbn3wRVwP3ThpjWIUBRXXppDPyQy7YENlB3Z38d+IRjXxe+a7Bay5E3DViyMuIFV+8mp9s1s=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 23:47:49 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8678.027; Fri, 25 Apr 2025
 23:47:48 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAvfEACAAkIngIAAA8GAgAAZ550=
Date: Fri, 25 Apr 2025 23:47:48 +0000
Message-ID: <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
In-Reply-To: <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|PH7PR04MB8755:EE_
x-ms-office365-filtering-correlation-id: a3500f44-5f54-49b0-6672-08dd845395f4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pHPa8dIQT8YQg0FlWAn+gzJieu9MPqbbsudRAkg9yW7ah1xOra85mla20V?=
 =?iso-8859-1?Q?sfr7FrCTHsozyBuQ9tUPGnf2cBDG57VVuUi8dH7JKUb2KfaQA1GPOWIG60?=
 =?iso-8859-1?Q?LlwWYBtCmfTr5X6NHxMk8B+ieLbVYjOKAfE5XH5ASm/rwoF3uMAFeSGcWh?=
 =?iso-8859-1?Q?wPeNbGV+LjFMpEEuhU4bJ5q9GPFdFgx9+cV9ToEDeczJtvKBKpKD7M0+YU?=
 =?iso-8859-1?Q?V8tT/vjO6tho35lF5BAw5KZli/qwVX4L23sou7x2j+ftAkJFZBvG7Y9xxt?=
 =?iso-8859-1?Q?zwjMKgly2nSgpTu6dMdd+rV/eM1RwRx2maftEdj+D9bo0IMzHudzh/J7ks?=
 =?iso-8859-1?Q?bDU8uSoTS+QaZf5OpKUtX0aipVSlX6O2slLmkLa3wFwOHEHhzZ1I7au+NK?=
 =?iso-8859-1?Q?Zng/QE6i8TgbMQxZdaCoGL2rfS850KJZSDMtPITI92KOe3zHvMoQ4X93+O?=
 =?iso-8859-1?Q?rvIrffWBS/j0RWrxHDPi7MvxDOezvPmr6cNZYekNw+pqhNaVglY07ZDUyD?=
 =?iso-8859-1?Q?qM8RRPE5+gyq35LjUaQoz3NcP4HcpBeBcoAiUdrUosxg+J6K9jAf7W/us0?=
 =?iso-8859-1?Q?rflK7Pe2SSa1BLlv1xjVYTT+xSuVmmHTcntxZrh6bbuUihQejg4xj/tHaP?=
 =?iso-8859-1?Q?YEVu/J37vDLPR2lDMXXyHBpetxI/GQrmpar0WUx/VZHzZL5mFxnHKjiCQO?=
 =?iso-8859-1?Q?Ur5kqNHNRBDpv5iqTRJg0xgCa8HoSrNqw7xoJo2wlKz24fweNQImXrOdwu?=
 =?iso-8859-1?Q?7H5bjHRZFipOt3EopFQ2w1gIsGgtKYrWy3vwLiBBRi2Dy/5plYcbhqVGWD?=
 =?iso-8859-1?Q?eqfIe2kKFil/DEVg02xIX518XcKRDCaDLSRWinDw+95AjkOGQxnC8apsXT?=
 =?iso-8859-1?Q?92khBfh2VgYE18Z6FP5Ues9lBjXnEnotP3LJHKbNXHvpOIk3dr0L2I7l/I?=
 =?iso-8859-1?Q?7TLy3Qq9Pr2C+/mVCMnCio0qwDflxVdaqQzI6u2gySEeBayhZyvbheUQBp?=
 =?iso-8859-1?Q?zcSC2FbfAHKpCCBADmNDUSmEGDHGWM5laRh3I98Wfe+WDrPedLbLEETgRH?=
 =?iso-8859-1?Q?35VwHy/JnT1zARFW6vR5TdsJ20XWL3tsk6qw1vpslTW/7JKh72X1/UjEj6?=
 =?iso-8859-1?Q?MtR1UgYOv2XhxxxcFJTQvRUecmvok9mZVQGxZmxVgpGVnMlltm5c/39Uiu?=
 =?iso-8859-1?Q?IajWXecZIMsAOWT2lOlrm2aZoQDtIkDZHSC6kcS1o8SLEtXlE9U0DNk1yY?=
 =?iso-8859-1?Q?kDdZ3VG39yUjJCbSKpZu5EdCyc4RXwlZUEalicz9jW++XeDQ73KOdIqB9C?=
 =?iso-8859-1?Q?ov665dR7mm05DG2IomK0pRGJuIhxSi92nMzRw1lR4G7rkkZjSKR1ONmTvB?=
 =?iso-8859-1?Q?yZQrh50/p2Ovzz3N2HJ6vGvwK330/Iem5uei2OFEbfv4JhHKmG7kqFGRkC?=
 =?iso-8859-1?Q?PJTeOZpvJX6unaYdSrI8DT+eQUGMJCQmNEhmCvrX7eeEO3nml60mwAnhDO?=
 =?iso-8859-1?Q?34/51vW4i1C1gBDC6y56pd4yek1gGITYytoywFAOUJlA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ImJgPKuG/pcmCdsGCCqZzCUZBvJWKoNhVHhS7sBzqxkl4rTSd0Oc/Gb9hX?=
 =?iso-8859-1?Q?vy6zizJCflRRA+hiAjN5FVCRGD57M+LOcv9o7yJSZii80Ec9wHd5gIW4Av?=
 =?iso-8859-1?Q?dD3lSQRODeDWyHhVlDquTMG0lAuH9G6ZsKXT//mCA9Pk5+qKs/s2/4g8aO?=
 =?iso-8859-1?Q?2eBPsNyOETun+P9m2JZ9tGxcEk3PZk/tnRx8EPf+njweV8n3RjtFYEYg/Y?=
 =?iso-8859-1?Q?JOj91UWVkOySOFgQvoLrQsXKwUTZJoME1qFPbujmF3thpoFQWpGKUE+xI7?=
 =?iso-8859-1?Q?QQqX/IfURITjyN1BC7YBI7OCRTeOEH+kzdQ41GmdEfYP+98oNrJm8+Afhb?=
 =?iso-8859-1?Q?5vi/LZg5faT3dx+YWt3uvZD2HfVPjw4WTPGd2hRjxKLrLrIFXRYxW1LOtH?=
 =?iso-8859-1?Q?KxnlBZa2tJKs4HrR41GIN1vO6O5lmo2V+rGZM5rhBSbbcO5Z0sadlDb1NF?=
 =?iso-8859-1?Q?tp574gJNibD4BJOSMKLIxtCw4XZHU7AauDvwaTe0ilzIb8C8PtE0m2p2IV?=
 =?iso-8859-1?Q?cVFFZe2wR+VmoeBC5ePIRtWUEH1Zz97TVYN74CmRRb5M4XkADuLzQheJcV?=
 =?iso-8859-1?Q?34Xujh7CVtcZ+hUSZhhZzermSsHiFY/qlgOx+vKZfA7eZNmu3UZsT9iRuK?=
 =?iso-8859-1?Q?DLr1ypCkDGFrbx6irb9ONN9brgpdEH8UoG0KeSDKuGYzn8loLwZLz/Aklt?=
 =?iso-8859-1?Q?omj7WGNOR5PsrG4GjBKgh2wAJlD5uepLrdX1PnB3woBYT2DeECCsPzD/q/?=
 =?iso-8859-1?Q?FlBbOaIp73lhqYqlVSIkWCgkgRo7TXCbZoohSs8xGpZmJyA6gaKQ4e3ClK?=
 =?iso-8859-1?Q?jaTyGASnL+bApHdhBsYO4ZTZaym03Mew2pi8b3FqlYS0b81+oVdgGi2QJC?=
 =?iso-8859-1?Q?ZsYHniQMr9eR2lw/AS7s20W7CM1ha046nWf2r9wdnvvolXMc57WK2FMp77?=
 =?iso-8859-1?Q?I6GfQQxOaEzRokHM+8cUfjNCIFGbgY0qOqfZEzevBmKw3ngYGXRVCaC7ks?=
 =?iso-8859-1?Q?taio2OfamZOIXr8OQrpwilPwX7p/x8s6Czjk1KeKQ48KHFWohpl2IenqS/?=
 =?iso-8859-1?Q?cirJuqfTAqO65MWrC4Boqu97mXhUX/mno+FdE9TNpioQlHxZdcb8it/wA+?=
 =?iso-8859-1?Q?4nNZOmHNe3Rs9Qq71YCcKN0dZ7HD8pEOBhuaJrNA3+LY9W/FvHywilWpTe?=
 =?iso-8859-1?Q?maz7FvrN5CKyf6h77+0A4dB5WATsOWfUqoov/NJwDFq09bFsa/Xxchapp7?=
 =?iso-8859-1?Q?J6V8xB39H5/C+oZeXIP/+Bg/WtJM/gDKCrwlhQQag+AulUP5DjeD2SHCCI?=
 =?iso-8859-1?Q?2NWKFKnHZcLyyNgvoVLNU3EsQFfK/dIQUPvSwkKZUQDm8/0XHvVVuBi9lY?=
 =?iso-8859-1?Q?T1SFho1jqRWipriTDYwVR3QV7zoZvuEzprX33MsT+nYuIC4GjehPkXcl4M?=
 =?iso-8859-1?Q?YLyB9qL9d8CoKIV53HuA0DDXeL4dO2BzIkmgYG/qszf4kWwCVUrJkQzyYP?=
 =?iso-8859-1?Q?sby4DqyDO4uZwqxI1E1fmUy52tlTZnJfIHowxyUYu9Msx0h+6gNTcFuznp?=
 =?iso-8859-1?Q?imImkJdqjgK11jEqKrvireZTyaRe6FI1OVB04rCEIfzFWCI3D7TY38wRsM?=
 =?iso-8859-1?Q?NcvR0g/yL2JeSnffZmGzUCFqgnCbioi2IU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Y2fZMkA6Z5B2ZQbt9brFaQOKermFVA5nNVq0qkSKYfhD7chqme9qypBh4JQ4YD53yeKT7AFKZQVeLyt97zY4D5wXF+Wgx1BZXcFdHwfnmLNR7/iBgD9Ndsa94DTcz+XGozZaILrvewIRs8vsFiWUllOi0Om7Sc6bLIwUz4yZZIQDjznE5G8Tt99ZCo1vzJpgIlQTQ+nVQdMiaLyNZU29pW03Xgh0pUl8FKorqpT0sfwAn9OVXeNjopr/dqjg1ZDE4vQlq33Qx//v48bs62NiZf9k05dpDQeCAQyXQfiT4Bmx09ih+sj59gqi6gpP6XdceeVI0sRXvNlZl9NGjQQa4WvDPgko+91cCFkoypaOtMeC/f3Y5rWT5Y4NqjZYwKY69hAhXaqdYNDPg6hVH80sgigo7rSCqG6HJ7b5OCpw939m52deYE+34M/HO01nteQqteWP/M+yEhnI14jZBuXiZl+VymJ/nIMl4NM/qo0aTDv7KC+klPh9y0SK6KBHgNKY3xAGyib9LIxM82h2i8CFEkqeh0b5a36Xu2S85nns1z/Jx78je0Z939uOKAu5t2Day3WV4stvl7M9Rntk5HprrrrgbgZlZYvj+b3Dc6JeH+tZ+AweeB1qh8xPzFZlmc9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3500f44-5f54-49b0-6672-08dd845395f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 23:47:48.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/lxDNlSsNgkMqUuww6+ykJ2MJDOxnNQmGqcOQHmNlZcBUIO6DVHS82u77d90c561mev0SGyfXkarrsCQDOMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8755
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_164753_922678_018478B7 
X-CRM114-Status: GOOD (  13.28  )
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

Sagi,=0A=
=0A=
>>=0A=
>> Right after the check sk_stream_is_writeable(), there could have new=0A=
>> room in the socket=0A=
>> send buffer, state_change() fired, and queued io_work, before we get=0A=
>> to the pending=0A=
>> check. This is the "lost event" problem.=0A=
>=0A=
>Actually, this is incorrect. write_space() -> queue_work(io_work) will=0A=
>be re-queued if io_work=0A=
>is currently running. Hence I'm not sure that this flag is needed.=0A=
>=0A=
>Kamaljit, can you run with the below and report if it fixes your problem?=
=0A=
With the last set of fixes that included list_del_init() you suggested, all=
=0A=
tests have been stable. I'm not seeing any more issues. Are you asking to=
=0A=
test this patch regardless? If so, does this need to be in addition to=0A=
previous patches?=0A=
=0A=
=0A=
>--=0A=
>diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>index 4d20fcc0a230..835e29014841 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -1390,6 +1390,11 @@ static void nvme_tcp_io_work(struct work_struct *w)=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (unlikely(result =
< 0))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn;=0A=
>=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* did we get some space after=
 spending time in recv? */=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (nvme_tcp_queue_has_pending=
(queue) &&=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sk_stream_is_write=
able(queue->sock->sk))=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pendin=
g =3D true;=0A=
>+=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!pending || !queue->r=
d_enabled)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn;=0A=
>--=0A=
=0A=
Thanks,=0A=
Kamaljit=

