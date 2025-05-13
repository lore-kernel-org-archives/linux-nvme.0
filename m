Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0D3C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GSi87r2UQGAVjw/VP120Oo9Yf/dflB1UmELPhwUey/E=; b=1ECID5suYj8/YCJWewe5nXuyfQ
	7T3tO6OXUWnbChJdpbjMQld1TcG8qXuaSAailTxgDijkxzGtHKWTKRW3BWXwhfH/nLj1zLBwS/U3G
	5WIoir7rDaN/j/NnIICLRpWxQgQ5525o0xQ0NKNQV1nKVjry7xAlOmnlrA41sGPhty3Qv0xMTPeNW
	9cIZMdUK2bdXTakNi3x7OB1fbgLz4sJZ4gzAUYAHligEuYb+uMXyOGRwRTFMbe3R+86VcIaHknZak
	og9YaJDkm3Os03INa1hFeItq9QE0KB4ZZNIA6jc94yoAz8y7Ej0RsKy7YG/DoOr9jQXMfRW0dp+Qc
	FrbDBZFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEvU2-0000000DOSK-46Dd;
	Tue, 13 May 2025 19:40:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEvFP-0000000DMcQ-3olU
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 19:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747164304; x=1778700304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GSi87r2UQGAVjw/VP120Oo9Yf/dflB1UmELPhwUey/E=;
  b=dCSYZetFQfUPekYqpGb71n+oWSxWwct/553VGirnnEsSepIMJHPINMyT
   5dRTALVV3ECiw25cDkuwSriIsP5BusDB3o3Ncb/oeHwfflodlLIwrFZMn
   OwFC7G0mMw81B0RKIIKSmd0UfSwEvKeR4t0s7jybP7ZQk3c5NfWaaedr/
   UtcKnAK3/GC3ATbg744h1jDtZchHhJKIjQ1/Ukn/QzPucKciHvCNMULLo
   3dTY13lJnS1w/ZqZk+vTtAt+kIkN8MCIo1OIwdrmTZ1WLdzeQ26IxgVoM
   dAiGOoo9EadsIEtHdADs0VbjcxplWXWK9pqoHWKg/AlvAxyl3L2GEKhcY
   g==;
X-CSE-ConnectionGUID: 9TT+bNcbQdW89Z86xgjMLQ==
X-CSE-MsgGUID: w34Q1e5JTnq1z/7FCHwBcw==
X-IronPort-AV: E=Sophos;i="6.15,286,1739808000"; 
   d="scan'208";a="81510593"
Received: from mail-northcentralusazlp17012053.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.53])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2025 03:25:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNSaKrsaYFu1D3UMOzDOZT7ra8dN310+ep+Zv4boMf9gZwN5yqYPpuqnKrW9qmAeyYABGj5+zjNtiJbapV5dYzdRzOsHC+/McnjVVJOw172PX8g8Y490RxqNAIM30dBhZ3bd5hLukiT8tZc1+3KfwOtdvnD2Rd1SE7ELiReIJHs9dvK3UAreba1oGA2Yg8HiyvX4y0scYSsMZgjPera9CI8NGQs7xr183yB8Nbt4Kpm+AavDUoaxlhIS4UCENa4QaoGMH9UGVI/sctYCZ++jTeUXOVR/xgTStLapcLxrRg0Dbu04W0J44KaESLsuKbtnPgMYoxxy1D1cmruO0n4Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSi87r2UQGAVjw/VP120Oo9Yf/dflB1UmELPhwUey/E=;
 b=qEBz9fE16gYAo1T7uELOdfLXfscrQzgFjPTQ7easUW1qLFPBR7xcMe/IYKQBjFA3eAUkEnaWVoM/uUBBTaCR16dWR8gyONjbT1QXjuAnqb26OMfECELRtjTIOKhKQJO8RRpgOZtXGcgek641S7BZv1NaPiD1Sl7thHnPxlg9rhGdQoa4ug3QIRq9rNdselMf21znxE0QNuAHUv9y/CG9vlL/eyc3TybvDD5rdo4SF13WUstwwYoy4tE75D0AWYleYRcSFGjErpREHWUiM2Pdk+NQbhqfbtBdLF3o+ZHgU1Tm9WhdrNWozn88AL5Wmkd68hInshdB8nyrbcjKg42oRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSi87r2UQGAVjw/VP120Oo9Yf/dflB1UmELPhwUey/E=;
 b=X6bDDvJ1LCcvv2cZwnEXMuhH6StDWebWia0CbmhMW3OuujEKjlOrBeIMoA/5c17DFLaocCD0aW5OYqElmOJBAcS04ktkcflXINTdd+MRqdKjxoUW1fkGBN1l2e4SuEM4uxs1A9nQirKLvzn3sIxP+/rjFppklMfoUYTQnYrtOlQ=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by MW4PR04MB7201.namprd04.prod.outlook.com (2603:10b6:303:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 19:24:57 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 19:24:56 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAvfEACAAkIngIAAA8GAgAAZ552AAkkWAIAOmdwmgAAIp4CAAc92qoABUZQugAQlcwCAAikEow==
Date: Tue, 13 May 2025 19:24:56 +0000
Message-ID: <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
In-Reply-To: <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|MW4PR04MB7201:EE_
x-ms-office365-filtering-correlation-id: 87e0d6ff-b006-4b6b-d925-08dd9253d87c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?7bkbLSvcT7vywMRiWvGZmFgD1N5v0VXCdsxyrjH2JfVpuHg1/IQta129?=
 =?Windows-1252?Q?WY5UM+fe9darva8FgGblcy96LaE5grlXWiBhMGr/fc4y2B89zemsLBZA?=
 =?Windows-1252?Q?H8WjZgBo6ZQ21oXIm7fIfcUXnBNYoGqz2li3OmaZBVySaBlyYW1As9we?=
 =?Windows-1252?Q?S23EIKMshh3Rq73GMsqGz/gN/9sB9705rhod9V6YF+VkPNRwQwd2wwL5?=
 =?Windows-1252?Q?ls+we4yXZRTxzrv0z9kb8Ag7ZRPSrBLnxI/qrnmgEcN2Qr9hJBP8/qkk?=
 =?Windows-1252?Q?Z8Vx90nKIeaE0UP59Pg00cWN5dPBSQUR19HM+gjsf4KB3aylZrY1bq6U?=
 =?Windows-1252?Q?4SlH7H/6T26fkt8tU4gaTd0hTZadabrRBp6MsYzztXvaU8yfhHz0FJDZ?=
 =?Windows-1252?Q?CM1I8/MMnKJ4lL5rt+HAhHga2pfOt4KebiOnoJUtLGp/CnQyXv1c1AdQ?=
 =?Windows-1252?Q?aV2vuXgOLD/UtqRWePq5LqmJKEb2yt1/q4cSnX7eolCIGlfVLhHMtlfQ?=
 =?Windows-1252?Q?phRC4xMK56KTta/u8RNMnlhlv+DQVOUHukQqLkSjmt9Gh6G2YhgG+zEV?=
 =?Windows-1252?Q?Z0lu+IdLZ97WsEO/OPgahMV8PVscmQxchQAUjTSVlLtu1bTbipIKJ8Cy?=
 =?Windows-1252?Q?GMTScUWTM7DXWw0dAdUebHODiQdDfbETUDpOUqt0rARlSJrLHI79akJD?=
 =?Windows-1252?Q?WJyLoo4Uq78C6ZM2QmPuXa/O5t2h+G3xFwQlS+rrGMHzvJGiFa4zYUBM?=
 =?Windows-1252?Q?k/NbDpKHF5YEBjFUMzA5OZJV/pX06SCfBhmpo6Yis1aqUP7+nVQMI5su?=
 =?Windows-1252?Q?5/dfJ3e3ODYLMLv8mKaWgUFl2GL0in5VRGXKmfoPegO3ffHQIENu2sS7?=
 =?Windows-1252?Q?A51GKrEtsLrhb/6P6t6LI1uqAnbV1BoXXvdM++gnFstWk4aUwnHxynZW?=
 =?Windows-1252?Q?6qv2wAPOV8ac4Z7OZ5sZWUrxwg1nFCvJaylwRaFaiAEigsZQBHjZjFjQ?=
 =?Windows-1252?Q?Iy5RL4RFb5tXiCCrhjMRN7RD1u9GH9IPEjV8geNjnTEp41wK29X41o0M?=
 =?Windows-1252?Q?f26sLKoH/PSWgQB8gfRWJgnqcJcfoVUk/8HMsWEu48bGM84JXyJ8f/je?=
 =?Windows-1252?Q?A7Vf+RxlFxm8O0Go7jiv98rzSTOHoqxUvN8KzZ3fuvydHF+N1bjsE264?=
 =?Windows-1252?Q?gZnB5pn+gqkeq2Ng7LdzKUDl4+/QWT5BlmMlJ7y7dL4WeGSncPHuFp26?=
 =?Windows-1252?Q?GdzxadlRIQZPBzzpRw8Wb6WMgwzfn1pyJk+rofjpstsvjrxv7wArlyxe?=
 =?Windows-1252?Q?yAo8eWHmk92TZ17zmvSkMt2Qxbe3T9cfdKBX9J1lM+fAMQ5yQVHWBeEF?=
 =?Windows-1252?Q?APeMXTJfA5zY9XG0bHp/3OA9j7GJ+Jj53tfvZ11Uu9s2jt99LgiCrpaf?=
 =?Windows-1252?Q?vnZtwMwft++uPihfjXhXtwUQ1P7Dqa12yB7QSfkb4ak1uMzBF4hhhNkm?=
 =?Windows-1252?Q?zdFZRtnFbiNCjNOwnHicq1zYb9P1srhyuF5NL+Z1xBnPpSZ2ueJF/G0r?=
 =?Windows-1252?Q?bI7YAljFLvrC5DueR1nbb5KVbwDEF+bVQKTXIS0PbuwrYAfpeJSF2Ho7?=
 =?Windows-1252?Q?QIg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?JOL1tFQCIDseTeiA1wn8F9HXsXMb0w7kf11gttZX+DKihLnm0lXhrJ8n?=
 =?Windows-1252?Q?gIWWQ10ItzaKO9rHYxgfLA0hIx9wAXDCCo4SorGzHzfEXHDJcqLG2FYU?=
 =?Windows-1252?Q?IOWCU9y86qkFM6gw/KyUB8HBiOt2BM3sDvNWtq37rDaQj4GsAWbu/C2c?=
 =?Windows-1252?Q?TAUB6VQKWrzpdMoJ8oz92ThAWaLhgHHPRUU7ZyW2cNQiEVkVx4/SpJxr?=
 =?Windows-1252?Q?Hp6Mh4rD9VvBmxvZkQs8n2l9yNewrXTb3n3JJdRixO8C8ZeKF6Qzt4EA?=
 =?Windows-1252?Q?F/3rV3xYGs1hGxP5bcnrjD5Xy2pDV68xODZ8BYPDjdBtUItfKwFbFejI?=
 =?Windows-1252?Q?Gq0/yH7re5KvWfpd1cYiJp9ejC8My7eM7+uNdFOFQIl+tNJUT+WeLQlH?=
 =?Windows-1252?Q?z/k90TP4U44BiJxTdWe2M6i1TsvRz0o6hhEoGuUm3uwn5JLorTWF6G4h?=
 =?Windows-1252?Q?+5j7vR7I0vdOw/DLG7wu2XjYv22+zg+HYnIFlYiwuKdx591oEyl7hfds?=
 =?Windows-1252?Q?Ru7C5vsW0I0H9s7dgL9Q/CUeBWBT4KECFGSDFv5FjZR02wp39QNSZJtk?=
 =?Windows-1252?Q?884qDAVvXDNErciiMkKU1BzSXzKHOtoyDjOnNGXXCx0axAoF9TVeT0+6?=
 =?Windows-1252?Q?cJwyALoU2uVVqg7K+ifPiQdW52gssroecA/mKyxImDx8pA6A1Kq+k0JT?=
 =?Windows-1252?Q?3v0DvWL6qBl1wrC0cQ5FdgWl90qwB7Xsmn6QwBaoU+QhNJMWayaAmJlj?=
 =?Windows-1252?Q?SoJj+TWP/TPup34o4TBMNPG6F7xOvLzkTmMrL/e1HqOBLUXnOIlCexiC?=
 =?Windows-1252?Q?WIW7kO4JZ4mo8ElSq2zVA70Vku02qvuuCchJsI3rS49fCL43KFw2QwFI?=
 =?Windows-1252?Q?W49DAHqr+pDPRbS9QP6yqHhf7O45/HpXwuQuNonfuhLdzh92fzQgH7uy?=
 =?Windows-1252?Q?aGQzwuW9EkAOVIE7OtXJ008o9TftIPBUP69n/DDrweH4ox2Pp46PyfOC?=
 =?Windows-1252?Q?OpXUBxsBRanU1b+QA4UdB4SO7bZnn2PmIr8K/DeWdd8tuKX20Li1IvCy?=
 =?Windows-1252?Q?IerQV17CvMJ8NOWARy9JrikDp0S3qvEQjDOJbedb/HbWbug+XWOL/zoy?=
 =?Windows-1252?Q?yARwM/8JvD4dobTORF7bL/epIiW2TOG8uCcpm2Km6Ztjk+H0wR6uzkGr?=
 =?Windows-1252?Q?j5h/wPDQx/1/KjIDGkGIPW8dP7p1+10sBhq/TZDHdZV+GeyHPV4qUigD?=
 =?Windows-1252?Q?a8yPgFeD+pUSK7toa8bvtwP9Lowvd5TUJIiXNMz6wfR4r4/2Td3DaE/7?=
 =?Windows-1252?Q?zu11wG26EEUiZKgbrlGvIzcouXRFSPy3TZLikSkvPVSZ+DlNbu5U78XE?=
 =?Windows-1252?Q?JF/GuaShi9l58Ifg+ud+CZPwIFsS6fsAnC9GZX0BF8Ql6SuLsw+ypHIC?=
 =?Windows-1252?Q?BfaFJnH4ljgCIgHugvHEX6kdlWSataT2fbCASfDCcgmLVTi3Fvq0b+aH?=
 =?Windows-1252?Q?Rb/xqWav5z144B6sQmX20lPOQ5YEEuNB20nzveFkTtw318yWnMICgeMv?=
 =?Windows-1252?Q?EW3WLD6vmm+ajBSN0rvLtC/bVzUVLGZeW+Ef5FRqoX/pMTVu9jDIWsLQ?=
 =?Windows-1252?Q?pt8ciyaiZJpbeaLSFP9M3dgSvc2z2+apP6WKqwBGhelrBSzCGvllq4nP?=
 =?Windows-1252?Q?hxCDu8gZXNfTPOfVdZzlYjyJ2IJqLfxx?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /PHDRiY6QqaHNS9tUuEAEc8CrJPQaABmI+uQEcjQHuxaZFDDv+T0jtfGY4fLA51VhpzUHadljWeGc5vTKMjiIrdNoZ/ytjeFbcOn6EogdifM++7CVtRNc3QTV89bQ0fQDamfPBCpBQTZUGqAM0EiS/BLIFEIVBYkL04iIPd3oJm8wiHpKy2GN73L6mIrziLSDU528dI05N8rTo24nYRFNbeeLAlIH9qmqiWe5caWY1p0edYE59XOcMJ+ze/shd4MTNULFa1Yl1OpSxf8qFmvQw78cnikoDsIPC0/kbD6mu8Pp6dnoTS6blVq4Mpcq+EmHVokBwsKbtRcMIecFHst+J08zGp1QVgEc5elXWxD1bvaaWokzcL/xGJhOwkLdlOUZKyUZ+mLqi5ykhmbEVnrJ3q4+dSarisvVIShefgI+So/KesJSA0+g9Ia5v5xoMcZDy2kQjq1i301xA8F4y4rts7Au8hP2tjnphb2USFyEAn+OMFy29NVMM6yQoAgh0sJ+RZipD5BaWz2W8OG54z6kuen9CFf2a0X/u958ePudKDWsWcLDPKV/xpVTs/MQi3KR96tLiVLJA18iMzDBbkm+zoLGmyPe/2wrAJIYewxyrPro8sQFKrjTCdS9XpipYXt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e0d6ff-b006-4b6b-d925-08dd9253d87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 19:24:56.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM2tZ9OG9ZJ3USxSfkvXg9R7dhe2dE4qJXkxc0X6QfcWLvQpyHF+b8N/K3YwHoskGpty/HhE1twpGzj91jf7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_122503_992150_7D7FE00C 
X-CRM114-Status: GOOD (  12.58  )
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

Hi Sagi, Hannes,=0A=
=0A=
On 09/11/2025 02:11, Sagi Grimberg wrote:=0A=
>> IO timeouts are still occurring with Writes. The only Read that timed=0A=
>> out was most likely due to the path error. It takes ~4.5 hours to fail.=
=0A=
>>=0A=
>> However, this test does not fail if either ECN is off or if digests=0A=
>> are not enabled. These passing combinations were run for 16+ hours=0A=
>> without any issues. Both ECN and Header+Data Digests need to be turned=
=0A=
>> on for it to fail.=0A=
>>=0A=
>> Do you have a failing test as well? If so, is it quicker to cause the=0A=
>> failure? Would you mind sharing any details?=0A=
>>=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery=
=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 =
opcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n3: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 o=
pcode 0x2 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 =
opcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 =
opcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n4: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n4: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n4: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n2: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n4: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n2: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n2: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 o=
pcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 =
opcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 =
opcode 0x1 (I/O Cmd) QID 4 timeout=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n1: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] block nvme1n1: no usable path - reque=
uing I/O=0A=
>>=A0=A0=A0 [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 second=
s...=0A=
>>=0A=
>> In the current build I had these patches on top of the "nvme-6.16" branc=
h:=0A=
>>=A0=A0=A0 41b2c90a51bd nvme-tcp: sanitize request list handling=0A=
>>=A0=A0=A0 9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets=0A=
>=0A=
>Kamaljit, with the prior version of the patchset (the proposal with the=0A=
>wake_sender flag) did this not reproduce regardless of ECN?=0A=
=A0=0A=
With the last patchset, when ECN=3Doff, we did not see any IO timeouts=0A=
even with a weekend long test. This was true for both cases, i.e.=A0with=0A=
Inband=A0Auth and with SecureConcat.=0A=
=0A=
With ECN=3Don & HD+DD=3Don IO timeout still persists for both Inband Auth &=
=0A=
SC. I=92m currently debugging a possible target side issue with ECN. I=92ll=
=0A=
let you know once I have some resolution.=0A=
=0A=
I don't have any clear indications of the original kernel issue to be able =
to =0A=
differentiate against the current target-side issue. So, if you want to go =
=0A=
ahead and merge those two patchsets that may be fine for now.=0A=
=0A=
Thanks,=0A=
Kamaljit=

