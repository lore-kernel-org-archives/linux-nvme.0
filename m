Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF1C83F1B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jIVzOLJHlasklVnElomixDoAogOM6pSknxrToD5jtYM=; b=iIOv3S7we2zwkfKUcVdsiMG5Hx
	I6uMtTpEtAnnTO3t46hc73kjkk2SsA/XkT0TcBRb42XVePWizbybg4bkfjEKKgs+4aVklKWF1Kz2Y
	DiRx2d+oATUioioIzN19fShILi8A0jNqCDE6r64+u/2Kr6TmbmpI9geMyTpnr9T+Okmt5Un6UHBSz
	o8ciQEXZtdt0zsCM+/S/2WT4ULNZQjkINVhL+2BA+O3eEKfKWEVK3bF0PGHEY6jBweO+d8KB83y5n
	ZKBtTdi6yNma5fgNhfWI3Y5xjPP5MXA3OUUc0CMCQ3mvShGCPGfOGxOgi0mp6XuMbLdmsoIgHBEnm
	tz1SqaWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc9f7-00000008hS0-22lJ;
	Wed, 16 Jul 2025 21:27:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc9f4-00000008hRP-2Mhv
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 21:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752701254; x=1784237254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jIVzOLJHlasklVnElomixDoAogOM6pSknxrToD5jtYM=;
  b=K9qziu77Vu9JSbM8yRXv6e5AaTme7PSskEidCqLfK7L39igtHk6NkqaJ
   E1jc7cUStiW5Es2esjPvgFZHPb6Yl83XCo8qK8fxwlc9lMg/aU9mCGquJ
   hPx1FicKLKkWcZkjLgl2Ns754B8m0YbQiLuQ2qHTa+tg0g9ixUUkEZXqV
   eUJHtzTgLh0Y7dEejjw7fRNKX8oIndNMUvnOD78+SGXttqOmRsKYnD3NK
   SPZ2c5dWjDtRMW9bqhwbhJ4iouX+UfhfU0Ap36253F9dfiWF+xezj9N4/
   NIGU+f/eFE6LQYjk+Kh43Ky28vshMdxmUCrkCM9XOTWgZ1IewNkBXI9YH
   w==;
X-CSE-ConnectionGUID: YUrcJSDOTHWFwA8tZ03zaA==
X-CSE-MsgGUID: 5sH92aZOQhWFw6BnTI8cyA==
X-IronPort-AV: E=Sophos;i="6.16,316,1744041600"; 
   d="scan'208";a="94958752"
Received: from mail-sn1nam02on2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.46])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2025 05:27:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYw6QSi/F4RCQa/aL/vLT/7PUq1Q+lO6iabhG9+25UU+JhGRdUBiZYQ5XQ99pfjYv81yAg08WqA/MuToMUjhrvBCxRb+D0fyk2v5ILWFbTmHQ8KFYOyHqG6zdFTMjhFJVx2TPalAujFa1t8EPb4n7TzG12Q+Gyh0T4oH9GYen/H2F4JR6D/vPgavXD8Xw2OA5hGdUglGA5sPCU7cQCbMQZyYGEd+PELZE6d+xO/8vYt7AVI4cR+YrVfvIEJIQSPeMC7nsuEE3MiLPlfVoj9NYsHnF0YauvmiX6E+VQFketCqEBnOjpr0OC14+spI0rM0iOsJeaYmhpXpSDPKtTvo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIVzOLJHlasklVnElomixDoAogOM6pSknxrToD5jtYM=;
 b=mOoNqrX1ytpU67iiMmeNpMIQHCJxBtdPY/PjJOcXIb3G9nfPirui17XN3wy6K2bpix1hDA8PUHNHuHeFwYKE1HSS/GMPlnO/kRvdjp++gq5IdR58Akxt+AiuIA415oMkszb7sHGyGvbhbnkJdBiJJypC80xDfk0qH8Zez1dRAzgy2SQ90VSlr35tH3Zk2wL7BQXMHfxP+SdlUR5FrG3hp5lpqSB3k6u8nq+MMFq5Vya/qBm6csQfxRVgtC6DrKukp7YEdueUUwJs3LDxtyxPqK1sfMYY6lOyI5xKfPYbm66+8zrqIIWNfM6mbJW8sA73HQKvv8rTRm1meAOcHZ0bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIVzOLJHlasklVnElomixDoAogOM6pSknxrToD5jtYM=;
 b=NHYDKZAtJkL1DrjWHyjFHJ2lDgDgMJvMDytCxAHRVH1e4xP23cC4F9jGkjoJp1S349ocEY2JhEYKYtCj/1BKlnjtT3jC5Qq9bJHz7pdWgEedUlM8fmaR5ak37Xkxqn0P48N7PbiHJc+iP/ah8f/+9sD4HzO1Y1jWyAtALw8KOUY=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CH0PR04MB8052.namprd04.prod.outlook.com (2603:10b6:610:f0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 16 Jul
 2025 21:27:28 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5%4]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 21:27:28 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "cassel@kernel.org" <cassel@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v2 1/3] nvme: add capability to connect to an admin
 controller
Thread-Topic: [PATCH v2 1/3] nvme: add capability to connect to an admin
 controller
Thread-Index: AQHb6uxwHiN8wQJfJEWAQJueJuEnz7QgGncAgBU8a9I=
Date: Wed, 16 Jul 2025 21:27:28 +0000
Message-ID: <BY5PR04MB6849B60D0ACFD724C1B8171DBC56A@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-2-kamaljit.singh1@wdc.com>
 <d19a0776-5c3c-46f8-82ad-a1a83d5af884@suse.de>
In-Reply-To: <d19a0776-5c3c-46f8-82ad-a1a83d5af884@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CH0PR04MB8052:EE_
x-ms-office365-filtering-correlation-id: f69c32c8-df30-4f2f-8de4-08ddc4af90b5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+iRF+gvuf0ftCh105+6qCVV1AJPUvTDgp/D6m5C3gxUREHdjo3uiHjC4Q7?=
 =?iso-8859-1?Q?QUty9xsYH3s1z6NymVMA+JVerkuje7p8JeU9W9vVtgPn7yr3i0tl4WjzfV?=
 =?iso-8859-1?Q?ROJT0pM52UA9VVNlmgr7SZs1b5dbaD7VDJwLoIqOLUFhn08y7I7WS1hTvv?=
 =?iso-8859-1?Q?Ci6XrCfEzFC9I8XEzNdKz5cyeXqgU7YaKxLkrRfJk9hl4LDld6vQIW9YtS?=
 =?iso-8859-1?Q?+UdOVwWrLMX0MNBKxwj/HKRzJrvL8yycGWbf+WqCq/qhSXASx+WgsRhOie?=
 =?iso-8859-1?Q?mddGzORVXnxp0sYyaCHos1UkWcH3EF9ZOKLdQE0+nLWyflizv+cLpXgw9l?=
 =?iso-8859-1?Q?WMqD8LpZytjqwLjeKsS4XpgLA5OdIfORERpqaGq8jXaN5G0x2MkcpVJRLk?=
 =?iso-8859-1?Q?QFIoVGYwCpKeb1gUuV86NhJBQ5tcMdES++buW0Kxkzx9RKhsrGii94wF3u?=
 =?iso-8859-1?Q?C+1th29RsJi6RPWuDFkmvS2vtUjJnaKytzkMr3Oajzs4RR4DHj5xwvwGz8?=
 =?iso-8859-1?Q?lpq6Nw6O3PuQHLsoUW8/XZEOYGhBlx7NgPTWvkhPqqU0XU/a+Lv43fGgdE?=
 =?iso-8859-1?Q?99qoyXo29hCjJ70DTXUkh/pRitbTv++EO/MEVA6t7zVmZKN70TAmGcUR3k?=
 =?iso-8859-1?Q?XTYjh4QnW+DhEiSYeGwH9vT3C2ZlZ8zDE90LKK2VmIUf0oTL5vBzKvbxo6?=
 =?iso-8859-1?Q?DsPV2L3jExbtEz+YFYz5wtVPecPRVeyb9SAv1e3Ihbp7+KvOtjLfzE0SBU?=
 =?iso-8859-1?Q?O8t/7V1zG26JZPFZcxxOQJyRkAHlZpanCHCh7F3d5+6TNL9pvz2PXqqudF?=
 =?iso-8859-1?Q?dsm1c7ojLx113OfbCDQt3kOpyH7MnaHgMl9s22/w61BZ6b+PGSlSarX+XH?=
 =?iso-8859-1?Q?n+Dw0SwcCKH6V9bsBrYTc+6AWVLznL9SqGSpxuTx6ZkvRHDTaBeG1hG1CU?=
 =?iso-8859-1?Q?rqyBD1LvybZBrPtCGfBU8+qQ9mV+LiMkwEdrP9fRGS8OPdLgx2mPLtNTjn?=
 =?iso-8859-1?Q?htPl7yFwa7n819J/oLnutUnhznO68y8LlMe26t6XiWVymGdqDxfuuG2RyD?=
 =?iso-8859-1?Q?kfNuR/N4iGxXd0Kzn1Vdv9nyx2YNO70qz+QBOhSjHEosmsdkQb310TDaSx?=
 =?iso-8859-1?Q?VGWXOpXvwgI2+4ecDQ3Ih90RvmaykTVsCDn/0RQQG6R3X1QAiyXyJuFbW/?=
 =?iso-8859-1?Q?i9A4wnlryOJydcBuNOZBFpqHw6gV3QsgVzaIwqkYatdkvMJejq3h3XMjrE?=
 =?iso-8859-1?Q?68+Yt3Ay6ZZ2s6sHKJv46+Ifl59FuFm5fg8yfceBSkoxZqTKxpfMrN3VJQ?=
 =?iso-8859-1?Q?pulP7EOYrk6LHn4d2rfGE9hUgYQk7CXdlZmAY2C2nO2F0u31FiioWnVdNj?=
 =?iso-8859-1?Q?zfHo97418COh81P7r2QNNJTyvsJXp+zPpnPERA84DcXcsiL/ax+sSFc6Da?=
 =?iso-8859-1?Q?+NvsDWhz5Pu5mqsxqjotqb52zGwTl0bJBbD8G3m1HqMoBbuF7D6ktZEg9z?=
 =?iso-8859-1?Q?JFL+VLFvdLnCYhb+gEVvE6NznlSwt8LtjL1XHXNPMh6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YuAHcXkIk9T1DUSqRd4UzhGuCAc45l5hNgvNLtBUe8jhT8yytOrRP5X/J3?=
 =?iso-8859-1?Q?DdUB0Gq63vhEvK3GDkaAoW1KrINqCXP8TzxLIRlof5rSLoKhinC9aqGwUl?=
 =?iso-8859-1?Q?rMh117V3RD7oJiyINayxNUoZPl3OXq3Qgvb5hAynznHbtq6AsOMh1KqjPR?=
 =?iso-8859-1?Q?dV2mGT5JI/L4wv9F0boU9UHDOzZDccKDcQI0KNb2F3tdBQHfwKJZBFDudY?=
 =?iso-8859-1?Q?L9j+BGl8N1sU7j10jzBZmCrUcdsDfvKw5W/6n3Q+bVzA7cjR5fSJ+nWFnu?=
 =?iso-8859-1?Q?Q5fHnm071Wt6vww4EKOkKIMfs3OBS2UPwwKli+tAUlXJ9lmCe7IoezFsLt?=
 =?iso-8859-1?Q?kgkGn3PtM3Th0kbIbVjcP4i7jm+N8Xu5fJ6KGQGducbRNYO3bNLo3NofEz?=
 =?iso-8859-1?Q?rcwjnyUiwbZDoaqBWWVcwB0VBKujzeL27PK7qkXW8wMhZWWC8/Q0gh4Xfh?=
 =?iso-8859-1?Q?GqYDPDPvPAPEXdaWok0JSRrNi8kXx3UojMBR7oAoJppYfOCcc2o4T2Sajy?=
 =?iso-8859-1?Q?ua6ruKNDX/cE2vRH/oqCpvHExSAWbTwZs1Gaxd5gWjuxVl8jujBALbAK0v?=
 =?iso-8859-1?Q?kbihkFdJB/4aJCm6fEMHXUEhvsc3SctCX02kqMhyW7RayttXU1LbEoGrny?=
 =?iso-8859-1?Q?MNMULPebx1v3gRfrL2+8TpPPktYIABnMVk5ue/3jh9fDkVFJm6N3y36KNA?=
 =?iso-8859-1?Q?evhMsi7FNyID8rgHX68+j7Tfdts7VwBRk7RzPW243P6Cnb8PBWw5qTfVvH?=
 =?iso-8859-1?Q?ZgkpJh2MptzGZ1XzqJRW+ay1vP4UFKQuE3jiOzpNkkxh9WhkXYvB8VRKOX?=
 =?iso-8859-1?Q?/qbOc2qxg2KxU2M3GBJ1kTWgOo3q7HmYGuwFHDyFrkMsJ2/y9/rKc8qd96?=
 =?iso-8859-1?Q?JINybr4Zwe5pSthWT8k5tBtfzL27A/0OYv5ngRx7MptFOMUjS5upzslncb?=
 =?iso-8859-1?Q?TZbPaJisyDgK1HVzWNRI0latnK7ILkXbv7qf5aewG/USHe8U57AB0v4ynL?=
 =?iso-8859-1?Q?A1XJZStU5rfbFloGd4kTxOSLq/wALVzzumeI1AWi1LJzCG2Tvy5nHlgoCy?=
 =?iso-8859-1?Q?EOqyGRYCPoSdFYWYmoffBW9VqB6LvmDi664FVhI10tqfuYM1oVJNCnaN+q?=
 =?iso-8859-1?Q?hicQY3BLy8CQpSuEkLT/B5HCM5uELQ1mkjmmH3sdvVk/25vIgkv4B+6Snw?=
 =?iso-8859-1?Q?d0xuiDTpNOQ5jfJ1SDLjn3dIvPZXZ13bl2WuRpx0ze644QeBEtEB8Uephr?=
 =?iso-8859-1?Q?/muGz5OWXpipvndmZywzZBNYWc33BpKgLZRwAHmRWi0rglA2vfQ8uAS2cL?=
 =?iso-8859-1?Q?9GSTuFnl3IrkiAlMemjAHzVJUe36ug1DXyKAnzz8RL5bwgIVoJHy0nLxPf?=
 =?iso-8859-1?Q?FrCEfdFO9h8/2odL7RRJeY9mw85MyG43Cec2iqG6qtQnJU64SczuVrm0HE?=
 =?iso-8859-1?Q?ZonnPEwR4Ve9j2HAmQYpRTzEAUImOTkIQaFbExFmKwBOQZoKb8X1gCDn4z?=
 =?iso-8859-1?Q?ZJC+AlZXRWiqo5ApzRV6uE9CAtxhlKtKhePyoBemKbh0ElCsIx2jxvXTBC?=
 =?iso-8859-1?Q?iR7ooo/8Zm16GULkhYwVr6dAKa/MZCPB+MWq//LUELdixwIL1yAubtjNDk?=
 =?iso-8859-1?Q?tcxqVna60t4PgPsfRkPzLYEGn39BXdd9PX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oyoF2uLJ7Rr1W6MCEJCas7Gk98/r2rg+1vFRED1I75i9Gu22YvPNs5jOfbyiuvNFjfRjd0J4Y7AX3EFA5Cgitqn9DVj+Y9OpVlS5hgkQ5GBIw0Owx4jipBoKB7q0JKcUdRjrvQrX18jc65Xwos3FLz0mET1fIxYgfoVMKqvF/qSrIWNzvi5b176kMtOb2qCYkSfHa38vRi3U5IE1KtAjOtkWO+LsIrSg+9Fu6DKqmuoVcohkv9UNwZonwqV2/hErNw7ZqFNlf/3Iaqu0rcjvDDvym8nQ7sZm5nmE9GNvgN75DxaBHWdgfs0e/UMw3Iu3qY6Vt5tDps4ftabI3hoNO3ayj9NTxv8HHito8PrsIj6nSogft2Wn1hvr+X4T0eGpj/DPgGRZfjzXDXAA7WNtwIaJgd/U2Xwpeq60BJHZ2C3Fa+1+awdNQUI9Rk1IU+kM8TL5oU7sp/oeLgjQj13+d2SXKhX0KxV/jhipXY1wV4M92y//X+Y2E6x3cca4/cuNAoKdjX4BdeRQyZ//vEtmbpLQ6UHhqwKfrys02T8z1Jn/UVbmAlpcQ/YCUJLGuU3fSdWyMo8mxnLESjxS3qq99WKnOWXiv6LEtcvBpaAz6LjFjH6F+NpHVtg+eBKBeSUQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69c32c8-df30-4f2f-8de4-08ddc4af90b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 21:27:28.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVpWLET9RZh7b6KHduNoOyhjflrGuLghmZ+7k7VOVY8MEY+1/tTSJcDpZfonVZVaLCmsFGl5S/kBYelpsNgI4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_142734_680436_51F2F90B 
X-CRM114-Status: GOOD (  13.01  )
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

Hi Hannes,=0A=
Sorry for delayed reply due to PTO. Responses are inline below. Working on =
v3.=0A=
=0A=
On 7/3/25 01:55, Hannes Reinecke wrote:=0A=
>>=A0@@ -3215,6 +3231,11 @@ static int nvme_init_subsystem(struct nvme_ctrl=
 *ctrl, struct nvme_id_ctrl *id)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(subsys);=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
>>=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0+=A0=A0=A0=A0 if (nvme_admin_ctrl(ctrl))=0A=
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_info(ctrl->device,=0A=
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Subsyst=
em %s is an administrative controller",=0A=
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 subsys->=
subnqn);=0A=
>> +=0A=
>=0A=
>Bzzt. A subsystem is a subsystem, a controller is a controller.=0A=
>Better issue a message when connecting the controller.=0A=
Yeah, changing it to dev_dbg() as Christoph suggested.=0A=
=0A=
=0A=
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>> index d924008c3949..bfb52a487c45 100644=0A=
>> --- a/drivers/nvme/host/tcp.c=0A=
>> +++ b/drivers/nvme/host/tcp.c=0A=
>> @@ -2381,6 +2381,8 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *c=
trl, bool new)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto destroy_admin;=0A=
>>=A0=A0=A0=A0=A0=A0 }=0A=
>>=0A=
>> +=A0=A0=A0=A0 nvme_override_prohibited_io_queues(ctrl);=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0 if (opts->queue_size > ctrl->sqsize + 1)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(ctrl->device,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "queue=
_size %zu > ctrl sqsize %u, clamping down\n",=0A=
=0A=
>And that is a bit convoluted.=0A=
>=0A=
>Why not add a check in 'nvme_set_queue_count' and reduce the number of=0A=
>queues to '1' there?=0A=
>=0A=
>(Then you also have a place to put your message about the admin=0A=
>controller ...)=0A=
nvme_set_queue_count() won't be called in this case as its only called to=
=0A=
configure IO queues. Besides, this function is only called to do set-featur=
es=0A=
(FID=3D7) on the target.=0A=
=0A=
I've moved nvme_override_prohibited_io_queues() to nvme_init_subsystem() as=
=0A=
Damien suggested. I've checked it and that should work fine in the generic =
code.=0A=
=0A=
Thanks,=0A=
Kamaljit=

