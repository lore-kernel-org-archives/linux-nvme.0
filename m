Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB567C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iYBobSFjJxNpLzjy/1mV1OFP4fN5C2ukBaxp1EO18o=; b=2PrnMbdPTrZWo+n852/HT4yJ+R
	zeyHnZsV0h/DbL1dgKAz+mTeJsyuurM/CMktCwQ3Sw/sM0gwUs6zHNDcS3PTsS5bvlHEEed2WQhR2
	dBG1ci3KChRt1ZuJhq9jq1+nsP1rBa7SINm5gvlepmJLjr1ATAQp8c71wO34krs4TETpEM47U1IAb
	stmQ1VNHoKBoGX0Bt5pnb0bv8fBVSVyEk+DLLIA0e3a9HHkGibMyHadEbXZycRtDCAWMmVAMQV3Nq
	/qf6FPsKdbOGtdtVBh/+8/3hRluVlQZKpJcEbZ21+px0XhT9VWJEOreEYSC1Vv4k/vLkBXHunkMdy
	jDrQgt1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaL0-0000000EnAY-0p8g;
	Wed, 07 May 2025 08:41:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZV9-0000000Easr-0S6V
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746604054; x=1778140054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3iYBobSFjJxNpLzjy/1mV1OFP4fN5C2ukBaxp1EO18o=;
  b=NHY+BS5K4QjpQC9KVyCRSxWL8KNu8em3SHqzUbBYeXV0E3whQUowZu+a
   8Jrrvi90s5J2apZurY2Y4yAfUzotGvfYEuopA83E4fpS2pJwJjsVrZc0k
   zloHrG62xPudD2QL4zeJbogxyf1vZqVnIRSyZeKaqQirpqu2ZQMVrpGyF
   O+0D/C/wsIhRXcmwDZSgOUS5TcHp7ujPFByqFwLaHbivJSnIE6uXVE9OY
   HFyz3pvsX+w49otXPJPVSx/L+ICZlocXKY5MPRVAYUpAKoeFGYz2meWge
   Ie7n4yBn7VvLCCAsMfMYvoYTEMQyraIMG+6563Fa+y4a/TbV78gUxrh/R
   A==;
X-CSE-ConnectionGUID: lAbU857FRruxnJzzj4HOLw==
X-CSE-MsgGUID: VQJOqo8ISd2/O7SxMx1fMQ==
X-IronPort-AV: E=Sophos;i="6.15,268,1739808000"; 
   d="scan'208";a="79038927"
Received: from mail-southcentralusazlp17012013.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.13])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 15:47:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyhS7n1JFucitCPbhvTGcDfa0L42TNCKDFnskiuViIkC4VoPpVe5ssQwgUq8cUKiKrq+7Ti5sHGxMa7xiOWBxgUwlS7WS+pKrQMQ5Y6A0t8Ewb2xc61M4HN+paAIAyrXX+UCkCil6HuPyX/Eb2QTotuRu0Kgp4nUoe+twHFIMkpIzTFGT1yRMJhBwsDhNJU/WERbOjgU8t6IbrueehS5JusXE355MpbzVlQmdYvHcAF8KZgnmek4lHOavj0+iKH6nPSgl/D0L7AH9FpnAtAkw0tiYSyIu5SyPcz595wu6WB3PILWRDoNlbfK+Ds18WiQcOgFOyy7y18lG11tybEMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iYBobSFjJxNpLzjy/1mV1OFP4fN5C2ukBaxp1EO18o=;
 b=ej+fnOSS2kf9baTYq/3VwID2fkvWmb52ykql9yRdNKAGDlEYu+HSkd7AYK2G54qpvADeKEeKI/i/cy2TumX6UATug8lOeen3tDe0+S+Tm7UU18C15F1P4iXanuHik+OfKvYp2hJiJRk4LwrshudjakUhRAltLgSZ35Ah05Kw/H/yVfjuAoeVuuWEDvtZbd5mrpaGGLWiOp29Jmf57j9rWYpXUiXdVBdBqeXsokmoCsJiRdPCtcT31d3Vhi1DEf6486B01+n+5BOAaHk1/Y6dRUDtvQ66OZiQRvd72Tds4yTwyduPerUJMAYbvFSzoaIpISTYtPjwFsbpp957V4TKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iYBobSFjJxNpLzjy/1mV1OFP4fN5C2ukBaxp1EO18o=;
 b=I4OMlX1cthP+lzUNPsFRA5+XJsakmm9n1l+gUXB/zW0/5oWNUt+mSq20vvRNPhPpfPWDG9Fxr97izXBrSlXqzZiCwSCeWrM7UZ/7Kn+U1RI45kvscDNaMg3kmNvpYTa+RwtClwLDynrl1EqABUM0eWJ6+2vvLJiKWWckLb0QfGs=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY1PR04MB8703.namprd04.prod.outlook.com (2603:10b6:a03:52a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 07:47:27 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8699.031; Wed, 7 May 2025
 07:47:27 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kch@nvidia.com" <kch@nvidia.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>, "cassel@kernel.org"
	<cassel@kernel.org>
Subject: Re: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
Thread-Topic: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
Thread-Index: AQHbtNfGmXI4l2i6g0uazv7nOrWHsLPG2MYAgAACdwCAAAEcAIAAAoQA
Date: Wed, 7 May 2025 07:47:27 +0000
Message-ID: <8a8f115747dfbb96acafb0cd022194c5eff9b156.camel@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
	 <20250424051352.7980-4-wilfred.opensource@gmail.com>
	 <0db89443-9db7-4f39-8db1-eb374a9a3bcd@kernel.org>
	 <00f483cee8a1ac6b076f62c4551b015867136050.camel@wdc.com>
	 <fe2c74cf-a53c-4c91-b078-8eeac0943229@kernel.org>
In-Reply-To: <fe2c74cf-a53c-4c91-b078-8eeac0943229@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY1PR04MB8703:EE_
x-ms-office365-filtering-correlation-id: 9de92ef1-ca70-4857-e257-08dd8d3b69cc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWtnWWluTHM5Y3dwem5LQTBNRHMzeHNERXpRQUhKYTRQU3JRbW5HaTNONHUx?=
 =?utf-8?B?amhYa1Q1K0ozVWxDMXpFemYyVytBMEhSNncvU2p2WjRHZVFCSHh3UTJNZzE0?=
 =?utf-8?B?SDgzbkNoS25YSHB4dDNIUnpiQ2lncFFwdUI0S1BEUmVkRTFMVnBIdWlranAv?=
 =?utf-8?B?SnA4cE16Q1hjV0wzb2gvZVliakFtdUNHaEM4TDlIdmNjYTdvRjJTbEJJTUxI?=
 =?utf-8?B?bDE2NHk5S2ltMjNYUGlxU1pkZVd2OUlkT3dUd0hib01kRUsvODVvVEYxZ21x?=
 =?utf-8?B?cTVRZ0p6bXgreHBXV0VtTjlqZVV6dVZVVDRNeGprNHM4ZTQza2pOdWllNVk2?=
 =?utf-8?B?TDBzOXBTdXpaa3dSTFpaRlZZcTNIMkdrSTB5dXhySXl5clJXSWxwSEZ4REli?=
 =?utf-8?B?aElkRTNDU25oLzZmZHRTK0UvUDNYbzVIWUlzUzFpME1TYXVXSjMzenFVTk1E?=
 =?utf-8?B?dS9OWVJ4TU8rSERsZ0JjVnZMbGNmQy9sdnVUNmpUQlNmSWY5eGkwd2UzOHNV?=
 =?utf-8?B?MGh6TDJwUVhLQi91MHRJSEJzZ0x5T2MxeXdVK1pLQ3QrUkpPZWVVWVJ3Smpo?=
 =?utf-8?B?Um5TNWpPdWh4bnRINTU0RzFzbG55bXAwZ0t0UUV3TXJFWmtOeGpUelp2LzA3?=
 =?utf-8?B?d1hRazRWNWVLTHkvLzJwL1NYbkZIYkpqZVBnejVyaUxTTlhkVWNmNHk4aldJ?=
 =?utf-8?B?allJd1c0NFYvZlBKY3lIS1ZuTEVSdVlYR2xISkZXRVhhNllzRTZXbGZRdGlj?=
 =?utf-8?B?TFBCU3FWV2JHSGQyNEVoY2dCSTF6dGNCRjB4LzhJRFY1RkpFb05ValVQdDFV?=
 =?utf-8?B?c1BOdU9vaE0zYXpxVkROVnFWVW1qZGYzVVRoQ2FkK3dQM0JXWkExcE1BaU53?=
 =?utf-8?B?bmo4NGMyNFBnOGgzMkM3VGQ4c01YcnVVWS8vN015Z3JKOXUxRC9DVjJXOTFO?=
 =?utf-8?B?MkFORWN2dzRYRFlSd2JmcmVTVjFWaWgwM1IwYjhnb3FxeVNGdVBlVDlhN0tz?=
 =?utf-8?B?VXd6bzl0YUJTY080MFM3NFJUWExKMUY1NmZDNktNSnB0aDdNQ05DNit1cy8z?=
 =?utf-8?B?NC9xditpaFg5YkwrMUtLUVM2enZnaG9FY2FpRGVadHl5eHJydzBXYmNLOFIw?=
 =?utf-8?B?dkxXSjJ2QVBOT0I0UXBmNCtMZHh0ZmJFUUR5N211MmRVN0F3YlRiT1UxaFpQ?=
 =?utf-8?B?dzlkSTJIajhjbkU5SWs1N3pWOXpsdlkwMHJUMExqUzNrYnFhYlY4OVJKVkpJ?=
 =?utf-8?B?alc0S3dLUmJsT3J5b3o0MmczVlJqSEFaNXUvQkdlYUVmSHp0VWcxMlFoa3lX?=
 =?utf-8?B?ZWFPT25td0kwZ210S3ZnVlBrL20velF6T2l4bldZd09QRnN5blkwa1dmTHJB?=
 =?utf-8?B?SHc1YWF4ZmtNbDB0b3R5bFVoVXhnVEJIanFJbGM1dUpFcm8vOG43TzhIRG9z?=
 =?utf-8?B?aW82d1NOYzMrbG9sSlI0ZnA3K1lYczJudTlvM3N3TnFXTlFQOWtJUFZGdzgw?=
 =?utf-8?B?RW9BUTFiMjROQXJ3SUtHcC9pZ1UwWFhrRk42aU9YNmxtZVpSdWVKVFhKYm1W?=
 =?utf-8?B?eTNBRVpIa2xvdEZxMStieDJqcEZsdktaT2FVcTN2c0ZSdHlOdU1BRlc4VnN2?=
 =?utf-8?B?SmJvZmFDUWZ5TDFpcWpWR1luZStjZ1dLOHpVYllmUDFxaks2T0lKdkdRemxm?=
 =?utf-8?B?L2RQa3dScXcyZlNsTjVEQzVuS0lpUUVoYVc2TjBzaE41S2FYWkw0K0JlSW9B?=
 =?utf-8?B?MTMzUDRCWU1MVjlTMWtHN0NKcmZMV1FRa1BZSzYxblZQS00wNVNaTjZSQXJk?=
 =?utf-8?B?eTBERXlvWTlidHdWSXFKcDN1RlN0K1FzRFFuWVNtTzVnWVFVeVRiNE1Oa1VF?=
 =?utf-8?B?UURFM3ZsM053Y01sNG5wUWdEd2NHNVBlSkROUDdnNG1MaUpRMGU4Nm1yMmFD?=
 =?utf-8?B?WWErYWpacTdoOGlaZmJVSWZwNHJYUmE5NW14b2FQVmg4QSttOU40RktsU1FZ?=
 =?utf-8?B?VTY4RjhNSlBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUxYZXMxMG1vS2dBRHoyT3RSZTdnN0xTWDZzZGNVRVY0K2hQUUk0QjJJVVp2?=
 =?utf-8?B?dS9zWFdZWWlHbHptaWp2VXhqRitQU2QzNmRYZE05U0ZmTmRJTzhZcm1hdHRT?=
 =?utf-8?B?NlJ2Yk0rYnBsUGpMR2dPcUhsSVJjdGxkWW5DNkM5azYwZSsyM2RmWmt5Q1Bi?=
 =?utf-8?B?WGtLSXlUcjAzVmJkUWw1TU9RWHp6MDJWM0x5WFF4SStBVkFzQ2pFQmdDMFpn?=
 =?utf-8?B?RWQwU1NTem82QmFQVEtGQUE4TkZXdHZBWUpGOTBDWjU4QVUyb2dveVp1TW9W?=
 =?utf-8?B?bG9tZ2JOU0Q3eFo1TFdnL2pMQnFFSGJEOWpsZS9VRWN4NkxmMjJLTFFKdDYr?=
 =?utf-8?B?OW5zUWMvcXBaUHRMb01VdkFMUkpzbENjTzFodmZxWVA0Vzc3Z2ptcWo0Z2Jw?=
 =?utf-8?B?ZG1Ja2NuWDFlZnhCUFNhZzlmb3lXR1hzL1RMcFBuc1FER3JSemd3UC9KN1FR?=
 =?utf-8?B?M2VlZituQXBSNVlTU1EvcjFHdnZ4Mk5vMmwzOVA1VWZRMC9uYXJvek5zTEVi?=
 =?utf-8?B?am1wdUxiTVZIWm1teU94VFh0N2xubloyWFlHMkRxTFhrdFdpQk9ZYUIyRktZ?=
 =?utf-8?B?SXRaS3VLOTlKeGllcXoxQlAvR3UvdUg3bFNnbFUyWjVCZ2R1QW45aEpveWEw?=
 =?utf-8?B?V1NiQjBMbDFWWUYyTm1qSEEwak5BVDVZUmRlL3RRdGJOZFBBYkQyWTVSN2pT?=
 =?utf-8?B?Q1ZPckx6dWRaTVlHRVd0bHA1ZlduOUthWkpKNEk0SUd5SnRuRWdwQmdGaXV5?=
 =?utf-8?B?TzNocldqa0g5dEdXdkZmTzdURFMzMUxoS1psNmYwTkxkVmtSY3RKYnFrY05x?=
 =?utf-8?B?ZGRUUkUyWDI0MjM0Z0F3aStJNVVxaThDR3FOV2N2VFNKQTJzdVUwSllJTW45?=
 =?utf-8?B?ZHV3cVh5VTNhSUNOVW90bE12Rjh6cXRYY0IvMEtvTWVrZTZFRjBRNU0xb0NT?=
 =?utf-8?B?c25UaXJnYnRsQ0RMVlMvc25sRm5HY1I5QytvUEthaU50eldlcVA2VVhzYnY4?=
 =?utf-8?B?QWxCK3lHemNLVElLekE5NXl0L2I2ZFlqb0t3YmhFVzhzK1lmTWFkY1NvSXQ2?=
 =?utf-8?B?MTZjWm9VZmpxcGNxT080OHBPdHJieFc0MzB1ZVRTelhCREtDQ3l2ckJ5T2Vv?=
 =?utf-8?B?dk5pZEVvcGwxS3MzTEtrOTBHZ1BXaUprNEJ5WjdGNnUzbTlHUTdHOWRPR0lQ?=
 =?utf-8?B?SU5jeHk4N1g5Wk5kblViYnRzM3FqcXpWd0VucFJTZ21BL0xERUtxemhkWTFC?=
 =?utf-8?B?eDJqa2sxd21oTE1HK3dnbzYreEdWSGhnUGRXTGhaOUdRMU5OZU1DdW84bUNH?=
 =?utf-8?B?dzZJUGZZajJCQWFaRUVwaWg2eGkxWTZJMXFYZTdsRElISWhSYUdWNGtDTldv?=
 =?utf-8?B?VUFjdndRWU9OSmdEUnQ1TFhEZzBMZUdwdFJidlB0UE4yZm9wRHNVbzNlZE80?=
 =?utf-8?B?Y1BDZGZhOGdJSHIxTHIyajRXRGZyT25rb3FkNTkvbDdJb3doOU1NNkVOeDJR?=
 =?utf-8?B?YmFNZVRZUDVFTGhaUHdjME9NYW9MNUZ0TXRXS1NiZU9RUUJSa3UrbTRJcE1x?=
 =?utf-8?B?dTlkZGduTVhoT0JXc2dCcVFCdlpCc0lva1RGU0hGR0lxVThGWTBqcXliUDdZ?=
 =?utf-8?B?TXVRdGUrZUg1Mk1BYkxlWGdmemtzMDlrdTFrSGNCL2NvVWtsRmJZUGpPSklM?=
 =?utf-8?B?Z21odHN0OUloN3pwY1BnbHdoVUNXeDI4MjRTV3RQRnBGLzBKZ1dEbHZSUU5T?=
 =?utf-8?B?dkNxYzREZkFwQ3VVRUxLd3NRZFBCblc4NmNXVG9iN2NZa05WN0VybXV5Q3RD?=
 =?utf-8?B?cGIzTHVOUkZjZWdqSHBPV2F2QXRwTENMbm1NaUhjbnRQWWJpNEN5M1FNNGJq?=
 =?utf-8?B?ZzloalpSZVlQREt6Witad2lzYTlWM0p1MEhZemNVeE9MZW5UUHMxdlZwbzJ4?=
 =?utf-8?B?dmMzSnNKUkVRK0dPK1VtbnMxK09HYSt1NDRHMGh3YzZCTHhYY28rMTI3R3RP?=
 =?utf-8?B?QUJZbjRMQjQ5NEVVTW0vVGgxR3hBNVNISStqdHFYbTlmek1tTktISDJtQ0hl?=
 =?utf-8?B?dk1kNUY1YnJndmwwa3BuUDNSZmxXQXNJT1JWNzNpWVR3NjdheG5iQ0RVKzJ2?=
 =?utf-8?B?dXVOTDRjSU1iaUMyM25zWlZaRk1ieWZLSUV5VHMwSkRjTVZYdkFYZWFTb2Uz?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A19572C40A7A9840A1FC98A66206F828@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BdJVvd4OLeOhCoPrCeBiMq94p8sRuxaJkJNQ4efmcoXbv5udCrDczTs3JDlhTrZxmdpq0xCVuQe7q+QTGfUfmF+llcD95gzZxywwmuqPhTpV7kR9dTYgFWhZDZTvSZGwU5UQvK1rCWI8XmABKJatxTKiNiRCqJp9zQ9hmBhEjU0D9cCRb6XXQTH+bUN5PtQGUT7scwbkI+MGblGY18cD2QwQAHGrTj+d/+nFOao7nKNhqd4faTboZ+3uEYbNs5udUowREuAFI7DUpFvmF8EqLT7Y+7DYFLpmZ4PBE0/Z4xEL/6HVoeszEhB+X2gaLYoN8nC6kruB+6avGOsyPTLzDTj2TJPqF5n6J7vSx3dYnYDkzt/BGgLR4BsNVvD+RUnropNst07XWmKq3mfdScvrtMAddFKDEa/J9DI/iLsiu4kXjAGN1O3xab+g7KNmRb7fFtTYNTEpWUwVssbbIc64IV7J/JoFHat68+/GiWV7DytLv3fZEiRSc2RJ8oGedfBAMHOMFetw9ZK7KR98jUTTWp9uMl1RNoVrd22wNwjd2LGbg61SfJxznmgpDkBxjIdiM4kbe1R3DVSI4fpI0J2Y+p9G9yH9LMvsO0EtLAeA0zhqpm3P1KllngsOe+dF+2Hq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de92ef1-ca70-4857-e257-08dd8d3b69cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:47:27.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJCvNsNcyQM22PcfrfN0VWdmyAZr7kOK0gRwC8Dnlhc+veJ/opgVI0ZQMRzFK9y063iCybU9PVwTOYsZHcCVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8703
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_004735_153930_A88B9673 
X-CRM114-Status: GOOD (  22.00  )
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

T24gV2VkLCAyMDI1LTA1LTA3IGF0IDE2OjM4ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gT24gNS83LzI1IDQ6MzQgUE0sIFdpbGZyZWQgTWFsbGF3YSB3cm90ZToNCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcGNpLWVwZi5jDQo+ID4gPiA+IGIvZHJpdmVy
cy9udm1lL3RhcmdldC9wY2ktZXBmLmMNCj4gPiA+ID4gaW5kZXggN2ZhYjdmM2Q3OWI3Li43ZGRh
NDE1NmQ4NmMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcGNpLWVw
Zi5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGNpLWVwZi5jDQo+ID4gPiA+
IEBAIC0xMzQ2LDYgKzEzNDYsNyBAQCBzdGF0aWMgdTE2IG52bWV0X3BjaV9lcGZfZGVsZXRlX2Nx
KHN0cnVjdA0KPiA+ID4gPiBudm1ldF9jdHJsICp0Y3RybCwgdTE2IGNxaWQpDQo+ID4gPiA+IMKg
CW52bWV0X3BjaV9lcGZfZHJhaW5fcXVldWUoY3EpOw0KPiA+ID4gPiDCoAludm1ldF9wY2lfZXBm
X3JlbW92ZV9pcnFfdmVjdG9yKGN0cmwsIGNxLT52ZWN0b3IpOw0KPiA+ID4gPiDCoAludm1ldF9w
Y2lfZXBmX21lbV91bm1hcChjdHJsLT5udm1lX2VwZiwgJmNxLT5wY2lfbWFwKTsNCj4gPiA+ID4g
Kwl0Y3RybC0+Y3FzW2NxaWRdID0gTlVMTDsNCj4gPiA+IA0KPiA+ID4gSSBkbyBub3QgdGhpbmsg
d2UgbmVlZCBmb3IgdGhpcyBodW5rIGluIHRoaXMgcGF0Y2ggYXMgd2UgYXJlIG5vdA0KPiA+ID4g
eWV0DQo+ID4gPiB1c2luZyB0aGUNCj4gPiA+IGNxcyBhcnJheSwgYW5kIHBhdGNoIDQgcmVtb3Zl
cyB0aGlzIGxpbmUgdG8gY2hhbmdlIGl0IHdpdGggYSBjYWxsDQo+ID4gPiB0bw0KPiA+ID4gbnZt
ZXRfY3FfcHV0KCkuDQo+ID4gPiANCj4gPiBIZXkgRGFtaWVuLA0KPiA+IA0KPiA+IFRoaXMgaXMg
YWRkZWQgdG8gdW5kbyB0aGUgZWZmZWN0cyBvZiBgbnZtZXRfY3Ffc2V0dXAoKWAuIElmIHdlDQo+
ID4gZG9uJ3QsDQo+ID4gd2hlbiBhIENRIGlzIGRlbGV0ZWQgYW5kIGNyZWF0ZWQgKHNhbWUgaWQp
IGl0IHdvdWxkIGluY29ycmVjdGx5DQo+ID4gZmFpbA0KPiA+IHRoZSBgY3JlYXRlICYmIGN0cmwt
PmNxc1tjcWlkXWAgY2hlY2sgaW4gbnZtZXRfY2hlY2tfY3FpZCgpLg0KPiANCj4gT29wcy4gWWVz
LCBhYnNvbHV0ZWx5LiBGb3Jnb3QgdGhhdCB3ZSBhbHJlYWR5IGFyZSBjYWxsaW5nDQo+IG52bWV0
X2NxX3NldHVwKCkuDQo+IE5lZWQgbW9yZSBjb2ZmZWUgOikNCmhhISB5ZXAgbWUgdG9vIDpQDQo+
IA0KPiBTb3JyeSBmb3IgdGhlIG5vaXNlLg0KPiANCg0K

