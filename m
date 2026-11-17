Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7356606A323
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qjdBbDOe;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=AMrMQdI0;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=eFx959TN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pUjlF4KmMwusETBxMOiou9Qeqv8nW68glxu+HTmrpmU=; b=qjdBbDOeO995W0WATNroZpsYNc
	jpSCnfMEXmRbYaWO9r6crOHtXRqE/KafT/rRr3ZZ7NAVp7+FnTu/EHx0nrfLKkuca5EdVeCp6VNb6
	eHfZaUqmkcnJ9nFXadEUwGDVuKEhj4nYHtqNSOiq3e88ywmantIrsbFqXbNvsmi8LqIz1ewMnq63F
	KKrGWK5vNg8UOgLUl4RKrkghmDlUJDLsCLLSSBU4aUL/XR8LRLTEFzUkST6Yre7sQ+cebdpb530RC
	wo1mUhtRsnJK2tW0j/gCW+bHHCNwaHO4uTDxyIiHeX304YHPeRnWkqtskiwpV4GsbD0BnkNsUyHGf
	L2nUSV1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTH6K-00000005PAJ-2peG;
	Tue, 17 Nov 2026 11:11:48 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTH6H-00000005P9r-2gpq
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 11:11:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794913914; x=1826449914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xPZmGTLIy8wHIXPCjcd5U7pbJx8TzNEzg97p0iNrm90=;
  b=AMrMQdI0xOXk85jAb88LVgQymDE4NCg/KzEJLScu9H9skYq2lxaQMTtT
   0ehrLSZCR2G9xa4JohtWGN00i/eFfcrC5xFxVMbgFN8KeOzYflc2KRId9
   dcDrBptTEkEEPfaBgXhlm2AJygSb21sv630mCZZkWk5OMYEy3jEbiJ/h8
   7UkqekQNqLrCVWX3HIXLlGEXfAWBRSiezn3RVtcteMJr5wxhdFHSL9L6d
   Hhk5VXsNLmC6e2Mn35NYNW8RIjfysLTLk3xtnaWecW18/MpUyQwewZto+
   +PQy+wbBgP/Xc2ygPF6upW+n1weGPxHxYc2DcuScU/uIG0G1J1aaK47N7
   A==;
X-CSE-ConnectionGUID: UA+FkY+rQbGYzDN1E54bmw==
X-CSE-MsgGUID: F8IWqo59RQWvuUbPGdCaiQ==
X-IronPort-AV: E=Sophos;i="6.27,218,1786982400"; 
   d="scan'208";a="161092679"
Received: from mail-eastusazon11012062.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2026 19:11:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjz3hpbBh2lRc4lqXMrsnfz2sUqaFlQapyG+4pGRTzJ5kr//OukDkog0kqhGJfwSC7R1QY9be3o6KM2FY3TqBRz4Sullvb0DO1ad4SKN5M3I3+AF6AUOEi6qafZG1gyXGbijoVRrdtMPuG082VGTr4zU9SYKRPVZnd4bCIOgTOSbsP9TwxDByrM11p8umBVBPmCdTfz44jb1UWISV+NwDMikCsK55M6LgyuBh/HkqQg/3Q5AbWhZJgGKTPadz78LYOQcCZeFkc4nPKsABfg4UfQ2YH67SZ1OuSi1laEFalfl4VHmfVUwWeJPZDLx86ElzxMVE12iGo2Vfvjxbf+4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUjlF4KmMwusETBxMOiou9Qeqv8nW68glxu+HTmrpmU=;
 b=az4VPW9o7C74645iLwtVlRrFGdVbROnetI0Kn4W69ju8we45bkj3XDh6uFq+GuiAxm9HLq0poona5U+k/A70Gpg0JsKv46/oUmd/LQAP2TvSpqk2wjVll81GhDFQM5QlJ3wPz+fopY3J/Q9yQqM72+TBdOH4J40THkUnjbjN27Sm9Z9AXmWU0Qle/lr8SCVEggawEiS3FGysFAAEwgISWqVGOMZwuKr4cOfs0z4tequviT76ms+HatnKjw/kv0dNns2v5IeTFSrexDZjfnaqK+C5QVJybjjHcfP8qhqkvEyFS5KY72U5SZQjrWIPBpZkgwLHHKL8aoLV41XyIM9ZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUjlF4KmMwusETBxMOiou9Qeqv8nW68glxu+HTmrpmU=;
 b=eFx959TNPWPLBOln8MaFE7RuT/cAOqzgjh1ctWIcUZMg8zXTibXXhnp+oLkkkLm43JRwxtYyYbpV5dzJFziSUoHU09Ix85RQ9NaO2VsQjE1JW5VO2xDsZUz8M93i71K3ir+XOpaEtj/2EStTLZ/eychHZOwDsRjxOJpmKVT23aM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM8PR04MB7896.namprd04.prod.outlook.com
 (2603:10b6:8:3f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:11:40 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:11:39 +0000
Date: Tue, 17 Nov 2026 20:11:32 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, randyj@purestorage.com, 
	adailey@purestorage.com, Hannes Reinecke <hare@kernel.org>, dwagner@suse.de
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
Message-ID: <avwxyzFIASk10lMI@shinmob>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com>
 <atSzF3URmcpP2_i2@shinmob>
 <CAMof9cVxoNxM70uJa=N+a88YBMmh+EKfXrrckXz=N45U0EKQcg@mail.gmail.com>
 <avmUgnb87CHqIDOL@shinmob>
 <CAMof9cX9TNaXdL1ugdnCwxVG1Us8V-=c=Uk+YVKsMwFEYR7Vvg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMof9cX9TNaXdL1ugdnCwxVG1Us8V-=c=Uk+YVKsMwFEYR7Vvg@mail.gmail.com>
X-ClientProxiedBy: TY4P301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 82312501-773f-4812-20b7-08df449b8daf
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: +wt0vIP+dwy/ByUvHr/UxUyriKE0xM1eHRB4NbvQrI47BjTxWNKjEm+XYLKTF/fJ7vBgntyiMK/1+mYUzOl/SOeYi6fPb6V3YWHDiwN/RyQJ1WOid+jy4Td35ed3ek7zkWkviPogYNuulc9dBxab+aI3oesWoufqEWItKmjUro4NuTTfc4lbWLIpTiFj6afvRAU660uUfSjvvZNil6rPu5lHX7phdYguBF0nm9lZJ7gYnAXD79WOU3I+gZi1U2wUIrdC/mimaiPDxEqCVOak3FXvSQzESWKnyol4A9rFrtsC+W/RyRU44ME7HCxAiuD4HnMnb+2L2dNPV53D7NPDDdnKBsuCJSaxMHySGvUe2LTz5ua/OBZhRdYQIj2cY2UNplBOl9B51291YavJctzdCeSqxTYpbnTMp25xSb7FoMqooYoYlMtHJiO0H5yE4X4NXnBO4nMZAqBrTZZg2q9XJmqlb/MGCCV9EFgr8Pj3pi+rd2ppRxPsopWEcv4WN4s3aKWUvtJ+chKgVWiDxyACxZjPDR0au0oekkwizBVG28PdGHi501Ul7hUfvrmDOgBtW1mlv69WFIZFwKORXV0eoGRYrktkkfqTU4j5MFnQSehv8DiItbcaA5mT9qOkEcdr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ua58pyZqbmvXjyJnmmac4yeX8Duj1+Og7V1BPA6hB8yNVwszbFr/ioqA7sDn?=
 =?us-ascii?Q?UMd5C0nTig9nxYtJM4pJXBpYvyk+NBcNXAOoGzhbSnJVRZiO6nYUGP4ZW/Ff?=
 =?us-ascii?Q?MoW+GLpoiwohet66Cgz79cJVCkf0meJ+908FnYYTkDwGkHFJ1wmoCmV5FqQY?=
 =?us-ascii?Q?VVlytLIRaZwX/2KqoF3hV2nqoFaGJEXrTneS9+J+ySEX87b9JEZFR5glvyLP?=
 =?us-ascii?Q?voZt7BrAQr5tfzlyc/VldAN1qxrtgh08MzvDmb567gy0oGzHYG2224sTeLqw?=
 =?us-ascii?Q?lLOEoEIdLg78Ae29vyQ1PGgc+x2mUSEgnUUpzJJv56gzz9uvitcuC8x7Rxxw?=
 =?us-ascii?Q?d3cqbPzrQJ1MyOOYDBf8MHuHZFCgygiNrZcl8bCFC0GLg7lyRPNKs/n6h8F6?=
 =?us-ascii?Q?vGi7EIoSbrOgdwIFrjQo3avIX6Kv95w64PdiovfpQ3FvkeC3wrsxVfIRETAJ?=
 =?us-ascii?Q?eX8I/5JOF6fX4E00yYI7BAIoE7tzwjx8T4ZYTztLVPJQo8SfcMaNkntFt/AK?=
 =?us-ascii?Q?VZjEn7DVJfcuZPp9/YcENPiAlhge1h1XxJNzQDSM6QA4tcZGXjBbj1k07osP?=
 =?us-ascii?Q?FEcWchEYbFp1/eXoWolJsTLB2S/pG/Cz66jIfhQqxXNEIaqt1YgpzHydyLeV?=
 =?us-ascii?Q?VdT/ddhQvbe0vk+ZLB0IlCThJ8lqefx+HsrjJ4Tul77Mh3BwsXehXQ+YpPUd?=
 =?us-ascii?Q?GMDZ+Qo9o39EzIkHY/x/tmfwYGGfEPgSkd6RgQ8TdiEunfnTEN8SR7ENGMmZ?=
 =?us-ascii?Q?qVnXev4zU3bBnsw+YhgUtkoQQ02zLEiF4jU5aG1T0pD+hFKw+Qae7PBzesY0?=
 =?us-ascii?Q?5UwhnbN8YXFpnBwXTr5hmV+GqnW3hHWxiA3re7PFFbUxckrOoRti8Xd1VFto?=
 =?us-ascii?Q?u5Cgu9Rhfkq6jXSd/0u4x+uuL7BtGtFos7PQtKDfZi65/FVPbqBxgUJSDUFJ?=
 =?us-ascii?Q?jI0pF254FA4zwCy8R+gALHoMdpBSkuptvUyR9FmmJKlqprXE41gW2T/06GjN?=
 =?us-ascii?Q?XKtW5mPJ8yeS1D/Cx7VkfiIFjI0NXy9pAffkK1LcZ/HxXBW6Vb02Yry8xZ0q?=
 =?us-ascii?Q?e2/S/yB81At4CcZ4qy+QwNVxUCTfYjrDYltwjSTFwBbFLukLzUxUFI19Icxq?=
 =?us-ascii?Q?TUcPMVJFRgJ0N+1NCdsHeyKiyZw3zOQxQT1DVNxQPHsKWIMWD6UTxm+TK3Tr?=
 =?us-ascii?Q?CdvdGK7/5BAalEadqS9j8ewMpj8Ru8RdWhymjg7XbIEQKHbm3khA2YJBkARc?=
 =?us-ascii?Q?N6oREKE8VhG36nCpS+jeeEOpgialrd5MT09HvEDAP7Lfx+jkl5cKGoH1MkVt?=
 =?us-ascii?Q?QOLl0m0Txl1qUAOQEh8qFUKesXR3cUCMb91IfhPdANH4pLlgrHHYADw4N+Vo?=
 =?us-ascii?Q?1d0/FWGYlNVMrF02zyvgg6WXTjFt/tR2eo+7jvGFFWBeVCdJH8ugZFEKMeOx?=
 =?us-ascii?Q?ri1EGPukRyLVbm4XuY4WZhu7hGPPW+ZcGkm6iWK+4bmEwlN1/qo5cJkJKjCD?=
 =?us-ascii?Q?cEB18OK3RlWH/emfeT4jIOv0+iDVXKWkvSKHhpfhAZw7HoCbamF22xfFvVLx?=
 =?us-ascii?Q?h6nLE03mTdPNInUrRjdy56SN2XP9lgrPfvbnCgvfNTlN51y0QDl7OAyEtnuZ?=
 =?us-ascii?Q?8rsOAsI4taXW5d1EvHYZL5xPlqNXFT1afVG5DvNB/UTxdFhErCcqW6MdF32V?=
 =?us-ascii?Q?jR0yVxu0b9KBAv8XsWlAhcNVZzIMjqs40BaO5GLVBWow5GJbucntDyxhxl3I?=
 =?us-ascii?Q?P3GM/nb17/qQeEISxUL+9PFk+tirIU4=3D?=
X-Exchange-RoutingPolicyChecked: vqoZVyKPfngCQlj1sbb2E40Hhol8M+T9FDWpNtvATXlzmpQ+qjiDJV5kD+D0vjLIrBFr3ilbKaQssvZDeNTPcQ2UVZGzvborokSOuDZx5GrrFYtXxEOosU24ndEJ5zKJZrHXzLYmusFoG41TjLbfYSPx7U0haQuwtpBXN3/k9rIv8AVKsw0PkHE2FDq5LlJkI78clqmXx/+3Ylm20QT4u+SK4iIL32K6wtM5nx+qmzt8pB5q1fIbr5Yw5G6S3GhaDQyVLMLUA4P2gU9qkVX+F8g9hdhosgNcnbd3RiTfGS4AyEAGDMUSCQ9/j+VGLa8AtxAz53B4ZdseDzE1jd3muA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nLtV/cQfqAvUz/GuTErCo8vMIfKpjWZyLpwdVxrygRJd3L2INBQ0aA3eWQ5PAvGpB7ENvURJSPsoq5t5RaR+h17kKRdIrFjDzxd6r67laV6QPXkLQbNJu2y4dLmlJvSNFbHQnmDbU9bDyGX8JIddF8oHq4is7NUaHmOYfFXAQGqGLcHajSDhRdiQrdYdZK7jvMsEQIhYuZvWKzTLWNQsp0dIxpzOF2gefGR+H1Og4GLcIiFLz7RBW33yV5p3kixUUedDmhSHdglYy/6ymcYlnvwHuD72hvuOQQbMaYsRgSFYjOoQu3LsDUJRhYvaWwcOkjVqHbChjP4IHdWSMR3Vzjv2CnL7mKCU8JrxFzcdLuehhGF9v282r2GkOG/0LPSouDEypp7bhXTGoOisZg+lyII1FGSdmHdVch3qFG7UREkqJWCVXyFmJ/TFqR5n+21luD90AgavvN/ImljQnCK6rk/1o+WbUVo4ZQA+nslQ0aq2vHOgHKk6RUqmEVFoNzixfCWJDjuYjYqhyLQYhsEksSh9odoLMlpyYFPw6Hd2bmayhVS1g/H98Ar1KGybtXuB4kaQ4UoNB6wFyYdtLeV6kRN7PUKj9M0NahpLYH49moktOPktJXKlCq2pNr30/+2E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82312501-773f-4812-20b7-08df449b8daf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:11:39.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYCrOnbA/iEj0UndFUdGnwhRQK4eI2DlthIjE6JgQmWfV140qEiVsyG0KXi82j3b99CKfY2XuCYJD6oS8vWFkJC5lv6yVYz1ZG626LJq79k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7896
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_031145_709546_C356CE82 
X-CRM114-Status: GOOD (  17.99  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 16, 2026 / 08:59, Surabhi Gogte (she/her) wrote:
[...]
> Hi Shin'ichiro, I ran bltkests with ktls 1.5.0. It contains the tlshd
> commit 3a6658e
> ("tlshd: Link the NFS keyrings per handshake instead of at startup")
> which fixes the keyring race during the handshake. Both tests 62 and
> 63 pass with it.
> Can you retest with that version to see if the issue persists? Can you
> also share the kernel logs of the failure.
> 
> Ref: https://lore.kernel.org/linux-nvme/CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com/

Hi Surabhi, thanks for the response. Ah, the nvme/062 and 063 failures were
already reported, so I should have tried ktls-utils 1.5.0.

I uninstalled the Fedora ktls-utils package 1.4.0, and compiled ktls-utils 1.5.0
from source code [a]. With this, I tsill observe the failures [b]. I also share
dmesg for your reference [c].


[a] ktls-utils, nvme and kernel versions

$ /usr/local/sbin/tlshd --version
tlshd, built from ktls-utils 1.5.0 on Nov 17 2026 09:52:23
$ nvme --version
nvme version 3.2 (git v3.2)
libnvme version 3.2 (git v3.2)
$ uname -a
Linux testnode1 7.4.0-rc3 #501 SMP PREEMPT_DYNAMIC Mon Nov 16 14:47:04 JST 2026 x86_64 GNU/Linux


[b] nvme/062, 063 failures

nvme/062 (tr=tcp) (Create TLS-encrypted connections)         [failed]
    runtime  12.978s  ...  14.855s
    --- tests/nvme/062.out	2026-11-09 20:12:01.056000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/062.out.bad	2026-11-17 19:51:06.015000000 +0900
    @@ -1,6 +1,10 @@
     Running nvme/062
     Test unencrypted connection w/ tls not required
     Test encrypted connection w/ tls not required
    +FAIL: nvme connect return error code
    +WARNING: connection is not encrypted
     Test unencrypted connection w/ tls required (should fail)
     Test encrypted connection w/ tls required
    ...
    (Run 'diff -u tests/nvme/062.out /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/062.out.bad' to see the entire diff)
nvme/063 (tr=tcp) (Create authenticated TCP connections with secure concatenation)
    runtime  5.639s  ...
WARNING: Test did not clean up port: 0
nvme/063 (tr=tcp) (Create authenticated TCP connections with secure concatenation) [failed]
    runtime  5.639s  ...  5.820sost: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
    --- tests/nvme/063.out	2026-11-09 20:12:01.060000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/063.out.bad	2026-11-17 19:51:26.054000000 +0900
    @@ -1,5 +1,4 @@
     Running nvme/063
     Test secure concatenation with SHA256
    -Reset controller
    -Test secure concatenation with SHA384
    -Test complete
    +FAIL: nvme connect return error code


[c] dmesg

[  151.189255] [   T2481] loop: module loaded
[  163.048150] [   T2446] run blktests nvme/062 at 2026-11-17 19:50:50.958502092
[  163.352484] [   T2568] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  163.400186] [   T2571] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[  163.418639] [   T2574] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  163.559515] [    T321] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  163.570048] [   T2581] nvme nvme5: creating 4 I/O queues.
[  163.571893] [   T2581] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  163.581555] [   T2581] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  164.430504] [   T2635] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  164.701380] [   T2653] nvme nvme5: queue 0: failed to start TLS: -3
[  164.708096] [     T51] nvmet_tcp: failed to allocate queue, error -107
[  171.587415] [   T2900] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  171.653183] [   T2906] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  171.793463] [     T51] nvmet_tcp: failed to start TLS, err=-3
[  171.804442] [     T51] nvmet_tcp: failed to allocate queue, error 0
[  171.807577] [   T2913] nvme_tcp: queue 0: failed to receive icresp, error -104
[  172.080585] [   T2934] nvme nvme5: queue 0: failed to start TLS: -3
[  172.080739] [     T51] nvmet_tcp: failed to start TLS, err=-3
[  172.085529] [     T51] nvmet_tcp: failed to allocate queue, error 0
[  179.988608] [   T3283] loop: module loaded
[  192.204777] [   T3248] run blktests nvme/063 at 2026-11-17 19:51:20.118835914
[  192.524477] [   T3374] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  192.573747] [   T3377] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[  192.594083] [   T3380] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  192.753377] [     T29] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  192.768611] [     T51] nvme nvme5: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
[  192.769604] [   T3387] nvme nvme5: qid 0: authenticated
[  192.774532] [   T3387] nvme nvme5: queue 0: failed to start TLS: -3
[  192.785871] [     T92] nvmet_tcp: failed to allocate queue, error -107

