Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0C606A33A
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WZPNwE12;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=mI7vNoM8;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=v7POxJ5L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=m/JN4qmL3MfXFBrAeO685N0PIUnkb4kw8BjNSIZqHHU=; b=WZPNwE120IX6F4
	gDkmmere69FTWqIjoPlVtRuDRZTsUi3cjrZU8h8aMBob6hp0hCRd6SYAAMvlrpzcugRHkCA/yRZj4
	vTy/fq7glsH/agyQ1Hxtt0aHLH7nOP22mr/VXkpcDv/QjaCyvxIXvDmceel55gXKWg0qMrq6a9C9J
	gWpQ2jTvcLSTYZ7ADHWjROHK+IIsjGd2nTuic8ThM2i0t3BHC2AtkhDdTD4TeUMxYe+WPp/UcD/qR
	B3v0v2ZpMhJ3PztoR/K2ZK2GTP9s5UvZGWxTrpxKopR24U7blUPM/MeO71ME5KOmFnc/85SjPUJV/
	bXlkuNbIQz4/E+fCBCGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSYXZ-0000000HScJ-2jyK;
	Sun, 15 Nov 2026 11:36:57 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSYXX-0000000HSbO-0oW5
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 11:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794742622; x=1826278622;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NzJK9F8UnkmYXVzmFKMWxi9QugdpFcHLCIDVlqnR4rU=;
  b=mI7vNoM8VPFMOy3e0PBK4wdkicdtOtsEs2yBAzahCWSaUiE1k2Mi5g2z
   q5niFFo1BZTn8eqRxig5D+Q0xWC3r0rgoKl5umpraJEIMzSRcZPPYvO88
   FnZjf6eZ431w8pgdm0CYhUQfIH5+gx//rek+kqqQTTcdAT3YX4ydMHF20
   iudv5HHkHkzfCErh6eGBBEs4j+0Y9N3RG8onYolERl/Rn6FsIN+4afmNZ
   QFi9k5j6zntX/60y8tnj3lVYtzR7iV+fqbPStgpXYzX7DjxVRP/d+HrBC
   NawACZ93+sv5ndFoSYAPbTfNsQlvHCOA72Oi9gTd1e4t6CfXDqg+gxI/E
   w==;
X-CSE-ConnectionGUID: diOBIqLjTOqshpK/2USe+g==
X-CSE-MsgGUID: mSqefdX1QzuDqJ5iZ6A+zw==
X-IronPort-AV: E=Sophos;i="6.27,214,1786982400"; 
   d="scan'208";a="156682776"
Received: from mail-southcentralusazon11011032.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2026 19:37:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcdaZmWb/re4o6k2lIcoZTCCCNOaRyQXwG5Xowmxr7Y+j8V29LnxrLbzIeRAfjdomtPg9ysO1bpmXq32C0R9LESO3NbYwc8N+D7C7qnAT0kG6N2zpO/hTa9zXq9a4PVKup/Bppg04O659ouV19Wd/Bs2OzCcQwI4vWFir/FW/rvY46vi60AnDpR16sn2LJPhf4gw2nPS9X75MQm0umZKIwyL7Q7cO2urLQX5gIf4fNZjBsI6tLZ9x86z7j+qka9s2e1Uvvol+InVhcE1WR5hsA9dgYpfNicn11L5OQgZngCMtXnBKPJ6LmEX1r17TP2uicKQk0MOhI6CdA7x29n5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/JN4qmL3MfXFBrAeO685N0PIUnkb4kw8BjNSIZqHHU=;
 b=G6vty8lrnT8Wf6+lzQ+yL+u0kQF3VKJgT76fGwjJ7HEod2BZ9N4cOglU8A4fn7DXb+vMV66VIkypHBMKfEiGWhcxRu8W1gPxZKU1ud1LUyVhzRPdal0jTpsMBHTSVOHHxZTY7RgIi/Ey7QgjDRy+JacPToWcFy99rEpunwt3AyeF52on7MVU7Nicp7qCnmnEKhsrJWkgfCxsJP0TP+Jhu6C+qpARqiqfBtarAjVIB4+ICRKZDxrNJI01hwXBFcTYsDUis4DCcBol5KplA/r8/2nby7uCQXiqDXn3oI4Zojm24fB0P7gdrbIINFgoO7Ld1PBfSZDd/QmBB93tdx8LSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/JN4qmL3MfXFBrAeO685N0PIUnkb4kw8BjNSIZqHHU=;
 b=v7POxJ5L24syjZBFHZdyQt0QVGMAvRnfBMX+dIlHw7bvd/+oPiWtCz8b8SOBWPYlkBe/do5NzYnvU5ZbPmNjd/L6gvFKg/zoWbMFHCh58Gz2upcF+KKAj7ngA77x8Ro857rA12a1plkYGnWX9tBIfBmxcm+/Ye+u6bKotMSea2E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7594.namprd04.prod.outlook.com
 (2603:10b6:806:136::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 11:36:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 11:36:50 +0000
Date: Sun, 15 Nov 2026 20:36:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, randyj@purestorage.com, 
	adailey@purestorage.com, Hannes Reinecke <hare@kernel.org>, dwagner@suse.de
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
Message-ID: <avmUgnb87CHqIDOL@shinmob>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com>
 <atSzF3URmcpP2_i2@shinmob>
 <CAMof9cVxoNxM70uJa=N+a88YBMmh+EKfXrrckXz=N45U0EKQcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMof9cVxoNxM70uJa=N+a88YBMmh+EKfXrrckXz=N45U0EKQcg@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9659b7-e9dc-453c-883c-08df430cbd00
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022115727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: kUpMG6hAt/ku+b9aJm73HAts3332SVvhFm6QP8WtJBa0N8vBW3qXZb9NTAmCs/aiHO3+wITdnA0zFH4wNVrJKNWyszEqOr22bHhjs4pfU+JEs8r6144Ebsd1XxnW/bhptCsqJUuDe17mrL+wRWCJc/w9DpPbHSQevjIibz56P2e+2VZC6hbp7P6GPSEDQO1urYpphapCaddYyE0nIVJYyef/476VhJCZ2DJOhDMVoSbPoDZTYXYtBzfLARs17nQ0fdFXOpoOl83yBWQf2QPABkoc2weZjOw/0grPozwAoolczwSpUHSNrJ2B5L6cSqgbVdVTPh8B9Y4QrgZmt8pEvooyPpMs2ZelhqZGCvW37/JM92yg+WNkGGcPy76cgQaC4X4+wrmLDnPz8Zf7UIiMO6rJhE9U1IWqEzVjAhkrbV7DrvloymPTOWaDMjWGUcb597Qon+i0dLQci66fbVaFvmbP//9iWIlRQtoFwwL0mQCTUu1HCE9+FXvcnAGK60dGiONJUjKYADxgrCjGiQZYlQjx7t2f8arVj0HsvZIvpN18kliBpQg+TfRWs4RddLYlwQaE9P65cNuKV2qpjOPu8o7GlMMY3Hsh2oNAjEdKGZTWIx9ZQ2J9xguoqNumTB7o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022115727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJwWkVrYkZjSnNJa0U5MHQ5SWVkT0tweVNRWHFhZkhRL25Qa3EyVUJvMlpF?=
 =?utf-8?B?QnNCYWdYMzhlS1YyblhXUU1LdmNBN1NIdms0MG5ESUQ2MkFxWDUxQ3lsOEI0?=
 =?utf-8?B?UFMrczF4c2s4Nmw5MHUzdnlsdWZuVUtkZkQwNE1BTHIvZHE4VExYbkl5ZWxE?=
 =?utf-8?B?QTJQVlBzQmNFaC9WMTFmOTg2dTR6NjFYMjNJU2NLa3FBc0kxZ2tZSmVwb2tF?=
 =?utf-8?B?MXBjRncwaXZQSXkwOUEvSDQ4TVZpSjNYYmlhM1pqNDJhdGU2bTd6YXdrTjdw?=
 =?utf-8?B?dURNbUpRN3ZHYmJBdGlhVy9hQXZNa08xY001c2IrM0dpbnR6OHh3YVhpRXBl?=
 =?utf-8?B?c3RMSW1oZzZIRFBZVXc1WlhGK1FUeTFTY0RFdjkwMG9CZHZkWjFqMDlJajdk?=
 =?utf-8?B?anZDQnp3QlMwa2R4dnJSNWIvbGxHRGg0U0JmM1oxampRdnh3K002TmlkY3Az?=
 =?utf-8?B?UTRnUGFta05oekliejEvQk1OeWoydHhGbmxQQVBWbFJwRkNTVzBtNVNpRUJa?=
 =?utf-8?B?S293UlBxN25NZ0MvbTVHWnJTVVlqcXVqVS9zNjFMRTJkL0FjUm1MOURrS3ZM?=
 =?utf-8?B?YjM4ejhGSTdKYzRTWG41d0RnQnN0WjlZVkdzNU5JeHNXWTNjK1QxZjV1VHlp?=
 =?utf-8?B?Rnl2MDRra0xuUEZvU2tpUkc2Y2J1dzZCaCsyaGpyQnZyS1h2UWdFZmphMmk4?=
 =?utf-8?B?SXhPZ0hkSDlpZmpiQjVtUFU4U3FVa2NBdGpyeWtFd3Nla3N3bzRpN2o4bmdC?=
 =?utf-8?B?a0FTa1hwS1VaUzlKekNUcmx5NmFGTmdDTWNGNXJ6K0hoRWcrNVZWRWRWVFQ3?=
 =?utf-8?B?eWtkNjBxYjhVTkRGVE9sQk50MEExZytHZnZlMVUxVWlndGRzaWo4RlBGRVQ2?=
 =?utf-8?B?a2JHS0RhYUx1Qmw5QWZpRmR6dCtkVUJ3RjFDbkFlZDJpL0cxcDlHa3doRWZt?=
 =?utf-8?B?SHlBR1FzcTR2TGc5cDkxcExTcmQwNVltNjEwNWI5S0pEMkdabHo3L3FzdVdC?=
 =?utf-8?B?R1FSYWxqYjNoZXczS0Nrc3dZWGw0R0FYR0J5Nk5aMlQ5MnYrUm5qZW9PVE9L?=
 =?utf-8?B?OUpjV2tXWFl6NTFvSlBqL09NZC9oYmVkOHZpb3BHNml0cDNNeWxleDFyTUlJ?=
 =?utf-8?B?WE1QcGpSaUc2Q0I5MndVdDd2QVdsdEQvUnl0OENJNkZ1SHNVNkhpYlpMdWlP?=
 =?utf-8?B?VmdoVzljSVMyKzFyeUY2cnp6eWJMeU92bCtKSjdTT0tKQnBZYlYzMWtGNUNx?=
 =?utf-8?B?OGZUTUNJOG5VNWwrbUxEcWV2Z1NtcTQzeHhoakpEYm5UM0ZMOG9sVCs5c3RD?=
 =?utf-8?B?RlNNNHQ4QVZQQmRIYkZvQ1d4S1A0SDNTVXkvK1RXSmJURXpudElVWm5vdDdR?=
 =?utf-8?B?NE0yMmRhUkpNWUdPdmFnV1FWd2Zac2J2dUU3YUZoLzJubytMamF3Y3p6T0xW?=
 =?utf-8?B?bUNRVC92djdPU0xQdXlGdENCS2FHbkhYOFZaWmZLa0N3NXZ3angzc2NSYWh1?=
 =?utf-8?B?OFdMSkl5MGFiam8yNFVBY1pqQ21CUVhOZ0g0OURlcm50TnVmclJ4eElmaUxz?=
 =?utf-8?B?UkxHU3QrcU40TVpzWG8yMlBjeDJwNlNFbDVqK3dpUmhyU3o5NXJVQ1RHcDh1?=
 =?utf-8?B?RnpPUWljZW5iRUo0cVNlQWJOaWxOeDRNTzV6N1lGNGVONDVrbG5ma0RRenBE?=
 =?utf-8?B?Z0dXdUNacHY0WVNueGs2b210N2grU3MvM0tvZXlZZFJmSTV1RXI1UmJrdGtk?=
 =?utf-8?B?OWhHTlUvZGZDam9vSUtnMFl3THJRL2srS1NiZXB0WnJLRmFmU0xvTTlIZnN3?=
 =?utf-8?B?ZWhMVWo0TE5oendueFJXYU1nSEFqNlZqWitGMkxqaHVYeUxyRjV6SFVqYzhl?=
 =?utf-8?B?c21WWVh3bHdQWDdPVSs2WDlrbi9mbU9tTStHUlFGcEVGblhkcytxYU9wOTZZ?=
 =?utf-8?B?R2tDTTVwL2dpQ3NuOXdGMk5xTGJtOTJoSjh6TzZQSXpYTDhSa2g3MVpHdjBH?=
 =?utf-8?B?RFdUOEYrU204YXhJZ0JpV25GVmVYcnVUdFFDZVZqK1N2dHVIRWpMOXNoT1Bh?=
 =?utf-8?B?VWNzcG9MeXg2dU9LODEzNmlZd1lSd2VVL083dkZqeVhGVmY4WjZoQkhYV1dY?=
 =?utf-8?B?WmNSYVNJK0liMDNwckpISDdoLzI2Z3F2Qlg5R3BKd1UxMmlWTmFLOWZNTW12?=
 =?utf-8?B?aE1sTjFYeXdHNi9OSXhCTEZBekFyT3RTRzNzUDRVSEpWb2xCekR4MHNPdkk1?=
 =?utf-8?B?R21LTVVQeGtqV1Y0ZlF4TGVoSzJ6V1hDMjFjKzZINzhCWXN1WWg4SUFvVEFi?=
 =?utf-8?B?cm44cFdIYmE0c3djcVpQSHJzTS9BeVVIZzd5RklLaDZEQXhBTDBmMzd3REhH?=
 =?utf-8?Q?jf2n9rI8iBKl8ocs=3D?=
X-Exchange-RoutingPolicyChecked: M8rTlVLBT5WjECkOA59lpIh5TD344NgagCz1G2q3jkgBVkry6wwUytJ0YaV5qqPqBKjFdV45511CTRqjdzfNiV0qjkCSsrjajW2mlhhYY469vbjci2YS/HXuUBBWRgO1AcSsyaAcTrjA9q50gCh+VLbEekubyfRkgKeXdvSt6sS2SR1YPxdfVTh69S7eG3wKkL3slKEHJWd8Yrv16JxFgWEDrgwnR+2F9LJGi5YtRIrIStiPF2t73coKIoEvZYFbZmALBgUEAVEXBH0U7ksMuC6bX+gSKn1IPY0Is68q5D8F9PmbVzylasitn9mraP/Tv1j1HaWt3CbTvxMbKDJDdg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cqSrMwvhwnuD5AF/wavbFBxzNV59Aaez3jK5G+CqV7XJ19NuzezonAl1MU3pen/RE7RHynRZ6CGJDsYO2E4ZgLKjKsR+Y+FOJ3TrLp0QOyZB8aByvlhWOzmwG8hsmNonl2VQ49aaeoS+g694Nl3QNERTxtNCc+cmBaqe5auJmLCUjnI/11S3mnIlSG22EkzzePvbr7gP0bAsmdkToV2DHt+nRPg9fwPThiO1/daPEYURTxmNYB0NzoLzDNScp4GzTaRVlhd/uXmFrFUnUwQdQT6p2AJBU+0rF8AdJcLCBSp2QvwtKwQTBb0j7duf+ROSyqz6Hlwtf9DXrU8BU3sUN7uRDDtZFq7zGSThOFRpOGs8m0zQ9tCUkULzRsf6ZeLfZC/tUKduI/6Up+K6vOdveuDB3ykbhNUNtO8CuXOpnlfdC1AGVkO6XBZUd4WlEb/mWgfTRvts3sOrTBhhCa8lcwwKsL2TSGorPQsgLcSOU0EDzcjcebQ/QA5Tgf35TQp+oSVRO9fKApJRV3N9sEH1wLBwTWQauQhioMynMSdH1xDjonkp4pwrIo0/aJvUMQCw0PaT/jipvzGsgPE2mnjJfmrucrTvKSw1Yocwrzk8cvN5Rsvg/UM97hKBzsqWw0cm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9659b7-e9dc-453c-883c-08df430cbd00
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 11:36:50.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KNSPuMKip6dyVLthusy51yBu6uqTIv1phgfie170sUCTNnOYvadIsFeyzkzU57dYzYyJkOwkQVcVJVTZd+8RZD8Hx1UI2pzfbRUonKldgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_033655_374555_0017D755 
X-CRM114-Status: GOOD (  31.67  )
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

On Oct 20, 2026 / 13:48, Surabhi Gogte (she/her) wrote:
> On Sun, Oct 18, 2026 at 5:26 AM Shin'ichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Sep 22, 2026 / 14:07, Surabhi Gogte wrote:
> >
> > Recently, blktests-CI runs for the kernel at block/for-next branch started
> > reporting failures of the test case nvme/004 (with tcp transport) and md/001.
> > The kernel reported a WARN related to lock->magic, and it caused the failures.
> > FYI, here I share the failure run log at md/001 [1] and dmesg at the failure.
> >
> >   The md/001 confirms a bug fix in md driver. The bug was triggered when a
> >   nvme device with tcp transport is used as its backend. Then the test case
> >   exercises the nvme-tcp driver, which this patch touches.
> >
> > I bisected and found that this commit is the trigger of the failures. When I
> > revert this commit from the block/for-next branch tip with git hash
> > 34fbfb9d8d1f, the failure goes away.
> >
> > Surabhi, could you take a look in the failure?
> >
> 
> Yes, there is a bug in commit 61b0ed3be81b ("nvme-tcp: parallelize I/O
> queue allocation and startup").  To know the queue range before the
> queues are set up, it moved the I/O tag set allocation ahead of I/O
> queue allocation.  blk_mq_alloc_tag_set() calls
> nvme_tcp_init_request() for every request, which takes pf_cache_lock
> of the request's queue, but nvme_tcp_alloc_queue() only initializes
> that mutex later:
>   nvme_tcp_configure_io_queues()
>     nvme_alloc_io_tag_set()
>       blk_mq_alloc_tag_set()
>         blk_mq_alloc_rqs()
>           nvme_tcp_init_request()  mutex_lock(pf_cache_lock) <- WARN
>     nvme_tcp_setup_io_queues()
>       nvme_tcp_alloc_queue()   mutex_init(pf_cache_lock)
> 
> So with CONFIG_DEBUG_MUTEXES the first connect trips
> DEBUG_LOCKS_WARN_ON(lock->magic != lock) in __mutex_lock().
> That matches the call trace in your dmesg.
> 
> Daniel Wagner posted a fix for this as patch 1 of [PATCH 0/5]
> nvme-fabrics: fix connects with isolated CPUs and queue mapping bugs:
> lore : https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org
> 
> It initializes pf_cache_lock for all queues in nvme_tcp_alloc_ctrl(),
> right after the queues array is allocated, and drops the
> mutex_destroy() calls so the lock stays valid for the lifetime of the
> controller.
> 
> I ran blktests with his fix on top of block/for-next (34fbfb9d8d1f, the
> same tip you bisected on) and md/001 passes with no WARN related to
> lock->magic.  Without the fix, the same tree and config fails md/001
> with the WARN at kernel/locking/mutex.c:625.
> 
> With the fix : nvme-tcp: initialize pf_cache_lock when allocating the controller
> lore : https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org/
> 
> ~/blktests$ sudo ./check md/001
> md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap
> size) [passed]
>     runtime  1.779s  ...  1.814s

Surabhi, thanks for the confirmation. It's great taht The md/001 failure is
gone. Said that, now I face failrues of other test cases: nvme/062 and 063.

While I was running blktests on v7.4-rc1 and v7.4-rc2 kernel, I observed the two
test cases nvme/062 and 063 fail for tcp transport [*]. I bisected and found
that this patch as the commit 61b0ed3be81b is the trigger. I observed the
failure with nvme-cli versions 3.0, 3.1 and 3.2. ktls-utils version is 1.4.0.

  When I reported blktests failures for v7.4-rc1 kernel [#], the failure was
  not observed by some reason. But now the failure is observed in stable manner.

  [#] https://lore.kernel.org/linux-block/avBz7uOGYo2y426_@shinmob/

It looks like nvme connect can fail for tls connection with multiple I/O
queues. I created a blktests patch to limit number of I/O quees to 1 [**],
and observed the failure goes away. But I'm not sure if this is just hiding
the failure.

Are the failures observed in your environment?


[*] nvme/062 and nvme/063 failure

nvme/062 (tr=tcp) (Create TLS-encrypted connections)         [failed]
    runtime  4.678s  ...  13.619s
    --- tests/nvme/062.out	2026-11-09 20:12:01.056000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/062.out.bad	2026-11-15 20:21:09.213000000 +0900
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
    runtime  3.123s  ...
WARNING: Test did not clean up port: 0
nvme/063 (tr=tcp) (Create authenticated TCP connections with secure concatenation) [failed]
    runtime  3.123s  ...  7.313sost: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
    --- tests/nvme/063.out	2026-11-09 20:12:01.060000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/063.out.bad	2026-11-15 20:21:30.207000000 +0900
    @@ -1,5 +1,4 @@
     Running nvme/063
     Test secure concatenation with SHA256
    -Reset controller
    -Test secure concatenation with SHA384
    -Test complete
    +FAIL: nvme connect return error code
    +WARNING: connection failed


[**] trial blktests patch

diff --git a/tests/nvme/062 b/tests/nvme/062
index eabe2d9..69a05b6 100755
--- a/tests/nvme/062
+++ b/tests/nvme/062
@@ -55,7 +55,7 @@ test() {
 
 	# Test encrypted connection
 	echo "Test encrypted connection w/ tls not required"
-	_nvme_connect_subsys --tls
+	_nvme_connect_subsys --tls --nr-io-queues 1
 
 	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
 	if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
@@ -77,7 +77,7 @@ test() {
 
 	# Test encrypted connection
 	echo "Test encrypted connection w/ tls required"
-	_nvme_connect_subsys --tls
+	_nvme_connect_subsys --tls --nr-io-queues 1
 
 	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
 	if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null; then
diff --git a/tests/nvme/063 b/tests/nvme/063
index feb07bf..900bb9f 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -46,7 +46,7 @@ test() {
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
 	echo "Test secure concatenation with SHA256"
-	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat --nr-io-queues 1
 
 	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
 	if [[ -z "$ctrl" ]]; then
@@ -88,7 +88,7 @@ test() {
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe3072"
 
 	echo "Test secure concatenation with SHA384"
-	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat --nr-io-queues 1
 
 	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
 	if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then

