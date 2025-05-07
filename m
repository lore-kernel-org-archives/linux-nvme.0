Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2753C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/82Oft1mktPjqLcB/Gu5rAes7Bqe6M9hwUnuf7XI9ZE=; b=IPEtbeq5vxMZQBpIvTZRuSZncz
	oaT0omU4hxHC/geERcDcoGwfmwspazEMLGygbX5WWoclfn8CdMI4wXQfYVOClLAnYd7PJk//upsFm
	XQWqvmYpAEj1TO0Dt+U2HA1F8x8q0Nlm2LJluDZseqBDlMtOgllhr9FIokToIzixuOq57lh4hqlGm
	RUWfnPap4x7kLeycnEi2/JsckTT+fvMKWYbb0IkEeDlkBIAqf4tEmjuX7BUFEfWA7RshzHMf+RzEz
	7c/UW34ih1n3+WFjXHDdtGMDT3/0xs/+T363sYhzSTzH5XIRKc4lcGLlLOuxE4c2fllXcAucpYsnY
	zDwk5RQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEa-0000000EkwO-1urQ;
	Wed, 07 May 2025 08:34:32 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZIh-0000000EYLv-2WKf
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:34:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746603283; x=1778139283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/82Oft1mktPjqLcB/Gu5rAes7Bqe6M9hwUnuf7XI9ZE=;
  b=TOtnDZLE8ePVOzGli6US7QBsslrmGDovBshgkzZvuF5qw9jqO2hN2P39
   +pUltbEVB/HJRkdT1rpYjvr4gDxAiri/dBEQFMrVfmV7XtmGKkGy9kSDb
   6CT3UGtAva4xk1p7L/ilN5hZiP00GIbAPa857FhPSKPZ0/FgFJGu9uYk7
   IPNOnd0r2QaV2ee4grdYC7jQRjB7rfvrv2lKlx9ohQ4NOWK4AjTnq5lsr
   45s55zWJygq0JTwdYFuCnL7QAiYNq1tbrgcJLpHlL+o5tJNxtZ0ZPmi1v
   BnpB0bKkydJ0SQwNWZVRioMl9LSo368gxGMwuQHwqo1IwQCmzjvjyshOQ
   Q==;
X-CSE-ConnectionGUID: No7mm8LaQiaA7hP0lD3xsw==
X-CSE-MsgGUID: tbVOPIKFTXeVtVHxgsxZTw==
X-IronPort-AV: E=Sophos;i="6.15,268,1739808000"; 
   d="scan'208";a="81410396"
Received: from mail-centralusazlp17010002.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.2])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 15:34:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7COIJLMMhTyF/wuW3AGOK3LLEA9YVaNdeVvHJrIhVLsa3z2vCzj3i+WykANIPjz1q3Rc5ihil4kaz0M7SEkLqR6MZz4f0bzGRiRNFDZPyqe3zztRcJZ+HyQfQAphWcNxYQtPbKhOH/cfZMlBWRs+wBFZo17/LFbVjQJ0B9vpHPsQPhZEC+PFf3vw6TF0Fg/dn3JuREYwAgE06UkReHAfn3LT6cwTfKKaKZ6RsTWXw7faXRVBcvamXDUIvSGjWUGS3zW05qdQZ5gh+jmV0IaQgdyMEnAp6YECd3MlqAALbbplax6ErHls0xCcaqL2JoYWiXmW0wnPwVKSZYDE8DAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/82Oft1mktPjqLcB/Gu5rAes7Bqe6M9hwUnuf7XI9ZE=;
 b=r1Ge7o61ByBsMaLw2gLDN2+8zumosWBp7S2/2+xKUi7NxTQQzUeyjaOyOIPfoAyfNvZMkyAJ6ymOMkoF/ILKrpeXsRj7+W1QgTXHPVup1RXVhsXTsq1iXy1/QAsP/Zqb1IYLkbdWpsWjtYVIINmSTLWKbqpYBEHeP4SqTFKjxPLo6MtAKH1yqrwuxKG8hCCs9/w0p66K3NISKV8qJBsqGopS04+/EOGZzCxACUlseF5XFVJlBwfGH5wnVCXtGNdS4L+uPsXZnMo2yKPP5hizE3cNlP1HK2Imy8ci48NqIMs0CyeSOoq9Vj6Y0bBglNuVO/GMbKGuDQ3P6GNYJYP4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/82Oft1mktPjqLcB/Gu5rAes7Bqe6M9hwUnuf7XI9ZE=;
 b=rPbkX1kqoLXlwtb33cdH8rGYDeNfdHven8490EoKqPSm6KaKMK7SNrWHxgP+56U8koSQRW9alPjwCjfimqFp2pvuCu/UmZ4Y6EoDUrBPW7DoGQqc6CAu1nDsMlUqHroEFoU8sSqb5Gy+W3iDCNY9FvqiEufKJxmSAfskgu98+sc=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA0PR04MB7420.namprd04.prod.outlook.com (2603:10b6:806:e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 7 May
 2025 07:34:31 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8699.031; Wed, 7 May 2025
 07:34:29 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kch@nvidia.com" <kch@nvidia.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>, "cassel@kernel.org"
	<cassel@kernel.org>
Subject: Re: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
Thread-Topic: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
Thread-Index: AQHbtNfGmXI4l2i6g0uazv7nOrWHsLPG2MYAgAACdwA=
Date: Wed, 7 May 2025 07:34:29 +0000
Message-ID: <00f483cee8a1ac6b076f62c4551b015867136050.camel@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
	 <20250424051352.7980-4-wilfred.opensource@gmail.com>
	 <0db89443-9db7-4f39-8db1-eb374a9a3bcd@kernel.org>
In-Reply-To: <0db89443-9db7-4f39-8db1-eb374a9a3bcd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA0PR04MB7420:EE_
x-ms-office365-filtering-correlation-id: 881bb09f-e204-4304-57b6-08dd8d399a2e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHRtTlppajB1azRwNm1LdTZiVWg2bFRvdUI0Q2Q2Tm5JUThicE0vcVRLYktw?=
 =?utf-8?B?alp5MHNHYklLZnZKcmNPK3M1U1Jxd1htNFRpMTZKelhBdTdZZWM0aU82K09D?=
 =?utf-8?B?RFFjU3l6c0ZDMjJ2R2xjVjErdWFHcDh2OUtRakdXNGJTMmpUbHJQdnlQc0JU?=
 =?utf-8?B?M3pGVWJWUG1sMm1YQ25IaDg1YmFrck1EYVhKWW9NVVo3V0JwbEpsbXpGQmRJ?=
 =?utf-8?B?MHA4OVVEem1QRDZTSWJJMmw1V3hteHl3Nnp2Z1BHVys0OHByZ2ExbGdrMFJH?=
 =?utf-8?B?K2RkaDg3WkxQVTZCTlNpWmp1aGJZa2twZXVoSkdvZmxCVkF3dG43Y1J2WGZo?=
 =?utf-8?B?K2FLZG9rMDhkYjNoeHB0YkVRWk9PT2tTQjV2aUR5K0RZem1pdWY0Wi96bERr?=
 =?utf-8?B?M3ZFdm5RY1hvRzcrUm1ST3BvVmd2TEE4ek5nczYwRDY0T1hUdlZ2NWl4K0Rm?=
 =?utf-8?B?WHdIeFdtWTdiUU50WDFrYUxzSTFmbGYwOEFLRnlZQnd1R3pFK25BZHNCK0ph?=
 =?utf-8?B?Wi9UdkJiaFEvMitLRGJOU081YUNJbmxEYXJ3ekl3aUNncVpTcHczUEpKMm9z?=
 =?utf-8?B?VkZjVXNDeDBuNTc0NkNCU0VnWnRMOWhKanNQc0dmeHdqVStsSlNYSUFtWXVV?=
 =?utf-8?B?NlhBb3Z3QzlDZzJHbzBuTUUxM1NWdEIzbWt4VzFaMGlFbTFSdnRkQ0JhdCt1?=
 =?utf-8?B?WTk5amlTZm90aVJoalZMS1lmbWRQa045cWsxOG5EUHF6WmRXbUF3WmFUdFV1?=
 =?utf-8?B?WGZXV0lQRXF5cDRvaVl5L24zaVVOd0laK1lqeXZFY2NQOTVQOW9NaXpDcUFs?=
 =?utf-8?B?VWtxbDNzY1BzZWJGY0NZdlhYNEdVcTQ5eG1mRWFwemdUVXRKOFRiaExhYisw?=
 =?utf-8?B?K2N4d01RRG1DN0VYaEF2ZTdHOEIrWWExWVhFdCs0VUpCZ3RvU05HS0lWalFK?=
 =?utf-8?B?R0huelV5MGJYd09PbHdOT0RKMVNOMWFzZlFFVDBWcUpGSGVPb0pSWlkwOVZl?=
 =?utf-8?B?WlJoQWhpaDFkWDkySWlDeC96Nzl5OVZPUjdLMVA1cnN1aG5leGxrUC9HcVVI?=
 =?utf-8?B?eWRzQUxOdlh6SWxDaWM0NUNGU0hERE1kQUdHeWtnR3QvWjRuZG1LM0V1UWxH?=
 =?utf-8?B?ZnBjRFBGWUZQd0FucnJRcGxVb2JIYVQ1bCtreVk2eFpyWDhESWZNVXMzY0Vs?=
 =?utf-8?B?dnRMcHpiNUlBa0k5NzRuK2RYa0p5bVIrMkZkL0tLV3dBclFHcFpna09tanBD?=
 =?utf-8?B?RzZpNFhhRXcydWJkSUZ0bVBxNVgrWEhkdm9iVFUvZkFiZGNjRnQ4SHpIZGhQ?=
 =?utf-8?B?eXFHNWJpNFAyT0cyNEJEMUxiNkpHNGd3Mkg5cHpVamFNWFJjUUg4LzV2cU5S?=
 =?utf-8?B?MlNUK0Z5UWJ4TlZMV3gzOUd4d3pZMmQyaTNBN2NNbkFQOThXSTdiY0VBZ3Vt?=
 =?utf-8?B?ZWZtdndjV2hLanhEdERncVJtQnp0Q2NhWWVqQUtBVWhEMmhFdVNHbUFySmUz?=
 =?utf-8?B?NytPTHloUXNrbTZ1TEJ0WGVsYjRRMlpzMjd5K1dMSkpES3NwSUMxWG85RFBR?=
 =?utf-8?B?QkJha3RLelRPUU1yK3dILzZDV2EydVM1RjN2UWpGb1RFbFZvTGJkdkRJRUdm?=
 =?utf-8?B?VDJWbXFLQ21JS0dLVEZRcWVHTUFxRlQxaWlqYmRtZGxHV3N1L0krdnlQU1hs?=
 =?utf-8?B?RThvSWpOQmtBWWZUeldWcW9VMGhHeHBYRkxCanpieFRGc3ZJdm1UR0JMT1Av?=
 =?utf-8?B?ZzVWanZDTXpXZEhwQmh0clpGUWJ3WWRGdEpxMTFvNkhTRFgzL3ZEdmNrWUo0?=
 =?utf-8?B?cFVyQkZaZEpuQzFuQjQzdmVJQjJUOUhBYThTMkVKUW9BZmFmRTQybFQxTUVi?=
 =?utf-8?B?MFJ4c1lvTnpnTTZuYnlZVkRVcEU2bERCSDB0Y0FhQTFGb1k0MVBXUGRRUE1k?=
 =?utf-8?B?czA0S3RXM1hiM3A2WiswdXlabkFWS0lYcHRUN2tieE1uMHZsY0ZjQmNWalBi?=
 =?utf-8?Q?emZdBjMzBLFUM/wpHWk+4Ix3Er66kQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?My9JdDVOR3NNQ29pRk01dGN1bng3cnVmNHF0bTRxbDZ1N3RzOFdwckF3alNu?=
 =?utf-8?B?SUNRNGY3NDVBQ1U3WUhlM2htRVBDL1k3VjV2Qk5LZ1d1ZkI5R2duMkdMQlNK?=
 =?utf-8?B?cHdCYy94d29iUUJKVW1UQmRJTEdDTjQ3TCtha1J5cU9PR0NydmJIZXdna1c3?=
 =?utf-8?B?RUE4ajQ5UUVuOUFlb1NVdlF4YUU1MStWc2RPYTBPaTNxVlM3UkluR3RpSEhI?=
 =?utf-8?B?dXJGWkN1NnkwWktrVE5LbVR3QnJwc25qRVlUN3N1NGh6T1RDT3NSejI4bGlO?=
 =?utf-8?B?UG0zMll3cGpMeFVtNU1MaFB5dHc3VkNoalU5WFpMd3RQRlRad3U4VFNaSlM1?=
 =?utf-8?B?SU1oL1ozZEdpb1BWNStSaWwrTWlLLy82bmdIM3Y3WjJTbnMrRjBBcUVqQU9M?=
 =?utf-8?B?aGczNm8yb2tmNWdFM1JGVXVvNEtnR3M5N2pwY1lNMDhFa2RVRDd0alFvaG5m?=
 =?utf-8?B?emtyc0hGUEtBZGFOc05oeWk0eHZacWRsYkVyME9LQi9XREsvVW1Ya0xrQXow?=
 =?utf-8?B?eEF1aGNkWTJva2VHcUR4b1hIeithenBTaStKSW5qMGlvVEJGNUM2ellTQ0x5?=
 =?utf-8?B?dklzRDY1emYyYkVha2xLYzVwWXFPYlE4TE93TGxja2xHeE5qMEVuRUpmeC9u?=
 =?utf-8?B?U0VqN1dFWTRVVFdmZTBnUzlQUTRvNkVhbDFUczdWVGdoWGVabUxJUkk0bU1Z?=
 =?utf-8?B?cUIycm9FRnFlWGJ3ajBrYTVTOE5hTzlaL24yUVE1ajZYYkM2Mmdrd3FDWWp1?=
 =?utf-8?B?Zk5TcW1pUFZzYjBCMitvVENIblo3WFc2czhZbWZCa2lERjlzOFZXdnFlYUpN?=
 =?utf-8?B?amE2K00zMTZUSG5pb24zZnpCemkwVEFCWEZFc3dxVWNhQitBTW9LNXZtcXJy?=
 =?utf-8?B?RzIvZEtueUhoTTlrU0phWjlJUmU4QXluVXdiMDAvbFBNZ3hnZVp5enI4OHY2?=
 =?utf-8?B?dFhyS0I1VndPazlrZGFtOFhjUDZkTUlHU2FVcXpFSWw4a2hMZHE5Y2hTdkh3?=
 =?utf-8?B?eUJ1aXNkY055eW91c1NKVG5LWElqVGh6aWhVN05kVkZzZDdSanVqUlhXSFRn?=
 =?utf-8?B?dGRHM2JlaTVmQkRzdVJ5V2gzM3JIdHV5SWRETzZzbk8wZmF2QzVvYmRuUW4y?=
 =?utf-8?B?S3Z2N3BEZE5LY1BrSUNvaHZJQVNpR21oRmpoaE1qRDVSMU50WnNRRmdBS1F6?=
 =?utf-8?B?R3VVU3h5SSt1SG1UemQ1cVNDOExTanR6OU5aOGl4YkZLUUVnQ1p0bHo5YkpN?=
 =?utf-8?B?bWltSHBOVzdKTDQvQ3pFUkU4SVZNS2xua0EvaUx5eFVHbW4rWGxOeWpnTkln?=
 =?utf-8?B?QUVpd1R0NnFOMjFsMHViOVFUS3BBenhXOWVKbDd6c2piZTBBZHZxYjBwY05P?=
 =?utf-8?B?VXZTQkNLTXV4OFJRakdSSXN2d24vNGFrQ05ET0lCeVRJY2tLN2VCL2JleW9Q?=
 =?utf-8?B?TnZzU1pCR21xOXZ4RHpTRGx5TEVoTHc3b2RqRkpuUEFIT0YvUW15VWtnYUdO?=
 =?utf-8?B?YmU5bU9vZXRlWDkycEsyd3lUVzBqbTJCcFZLZGVjMHhPbEg0REd6VmtIYkVl?=
 =?utf-8?B?VE1yZEFTd2hRZFhCdUIvTkFuek5iTkFUYndtTnowb1RjMVl3eVRHWE1mVU9Q?=
 =?utf-8?B?Z0x2eXdxSDBjTnRnTnJwSmlrakY0d1h6RSs4bnNGYmZ2aEFWeXJORlhnck41?=
 =?utf-8?B?RFE4Wk5uRnVnbUFXekxzSTNYMXQ3MVFYbWxyaHZKTUVvQ2tZUXAxdXVkbzR5?=
 =?utf-8?B?cUFhUGxhUElyKzdDSkhGb1kwUkVMT3FjbTNoRVBXOW5WcDU5TUFRdVduSldv?=
 =?utf-8?B?a3BlVnZXMEdPd0dxaGxTcHdGUGVNVEVjWHo5Ung5djE5L1luQlp1dFZjSzNh?=
 =?utf-8?B?UUxJZ0IyMmFWNXR2eTBwanFMS3RDeG5MalczczJtQ2VRMjNHclVIajcrNFBp?=
 =?utf-8?B?VC84M01CcnlJZHFlU1pTbTJmaEZKSkxqUmRqcFZpQWFNZDVqaUtxUk81ZTE3?=
 =?utf-8?B?a1pBeC91THVIeFRUc3cvZEtDOVZCWVgxMG9PU2NqUzhzUitNdmQyTVRqem5E?=
 =?utf-8?B?RWRnNFZqWmJjeS9IOW5YcHlxUkhsSVQ0aWVJWm4vYW00ZE5aWU1tVUFZTTY0?=
 =?utf-8?B?c2t1SS8wUnVxZmRlVjBNLzBwcVBOcTF4dlV6SWlTZ3dYTEhDbnNjQVhFQkgz?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E968395719E5478246FFA130E53B3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wr+KaffUKh2RHBzDP2TLbIjuMJrklM/2xkkPD1VjeZtcIOv3D9jVFhfV2VdAv0JVjKPrxh0oh2k3RGRblNCqSMJ9prniM+0SzWDxRVkDS15PDzX+Z+Wocc/8DPgUcOrwO/PePpXrF2WPFUDegAb4pZ+bC3IIBdPtA66UMVlMO9wVNK3APFKKUfJ9Tw7Qszj8BfJCwvSSnRxTu+yryocmm1fgV9RqUkdrFB1Hp3+tWA+VqYzphUL46HCahwVGLuIFuwwsAY4RmsIyYz+HYaH0K79GPpiIFP4wPSAVwub+YboGjDN8GqA+qcvXNniaTRGPCC7hxunG6ocrX5R6QMxpAWQqf972BOzVdesJHuJITnktGvIDHE50aztPm2+4MKCxv59ENmU/cZTrko+oFnU9jg0sujc8Exy9i4Io0kzVCpQiJKL02177fUXRKSKXgv+F33W8Ad8cWRq1KkxqogxnZxp+AoCn0oo8adJjZ52F6x/iKYbMECo/csetIxxKk1Yu49ctTGLRodqfWT4oAdaqxz05wVBJ7ErHWFWD4HjaTLD4cXFJmX7Ire/Zoauovszdq4H6AY0Jn6UIEZMuevdXoa7sJRSKQQpSs0K5xeiutm2viGQfoqhu+c1gv5f5Ne0j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881bb09f-e204-4304-57b6-08dd8d399a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:34:29.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFR4mgcXYlki7vsm6Jq3lJrlk0c7wVRB39il/6R+gCAbEBJiYHY00ovcmCB3rsBBlUxaSQbMHn+gNsDQUfho2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7420
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003443_762969_19D001B1 
X-CRM114-Status: GOOD (  31.60  )
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

T24gV2VkLCAyMDI1LTA1LTA3IGF0IDE2OjI1ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gT24gNC8yNC8yNSAyOjEzIFBNLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6DQo+ID4gRnJvbTog
V2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gPiANCj4gPiBGb3Ig
dGhlIFBDSSB0cmFuc3BvcnQsIHRoZSBOVk1lIHNwZWNpZmljYXRpb24gYWxsb3dzIHN1Ym1pc3Np
b24NCj4gPiBxdWV1ZXMgdG8NCj4gPiBzaGFyZSBjb21wbGV0aW9uIHF1ZXVlcywgaG93ZXZlciwg
dGhpcyBpcyBub3Qgc3VwcG9ydGVkIGluIHRoZQ0KPiA+IGN1cnJlbnQNCj4gPiBOVk1lIHRhcmdl
dCBpbXBsZW1lbnRhdGlvbi4gVGhpcyBpcyBhIHByZXBhcmF0b3J5IHBhdGNoIHRvIGFsbG93DQo+
ID4gZm9yDQo+ID4gY29tcGxldGlvbiBxdWV1ZSAoQ1EpIHNoYXJpbmcgYmV0d2VlbiBkaWZmZXJl
bnQgc3VibWlzc2lvbiBxdWV1ZXMNCj4gPiAoU1EpLg0KPiA+IA0KPiA+IFRvIHN1cHBvcnQgcXVl
dWUgc2hhcmluZywgcmVmZXJlbmNlIGNvdW50aW5nIGNvbXBsZXRpb24gcXVldWVzIGlzDQo+ID4g
cmVxdWlyZWQuIFRoaXMgcGF0Y2ggYWRkcyB0aGUgcmVmY291bnRfdCBmaWVsZCByZWYgdG8gc3Ry
dWN0DQo+ID4gbnZtZXRfY3ENCj4gPiBjb3VwbGVkIHdpdGggcmVzcGVjdGl2ZSBudm1ldF9jcV9p
bml0KCksIG52bWV0X2NxX2dldCgpLA0KPiA+IG52bWV0X2NxX3B1dCgpLA0KPiA+IG52bWV0X2Nx
X2lzX2RlbGV0YWJsZSgpIGFuZCBudm1ldF9jcV9kZXN0cm95KCkgZnVuY3Rpb25zLg0KPiA+IA0K
PiA+IEEgQ1EgcmVmZXJlbmNlIGNvdW50IGlzIGluaXRpYWxpemVkIHdpdGggbnZtZXRfY3FfaW5p
dCgpIHdoZW4gYSBDUQ0KPiA+IGlzDQo+ID4gY3JlYXRlZC4gVXNpbmcgbnZtZXRfY3FfZ2V0KCks
IGEgcmVmZXJlbmNlIHRvIGEgQ1EgaXMgdGFrZW4gd2hlbiBhbg0KPiA+IFNRIGlzDQo+ID4gY3Jl
YXRlZCB0aGF0IHVzZXMgdGhlIHJlc3BlY3RpdmUgQ1EuIFNpbWlsYXJseS4gd2hlbiBhbiBTUSBp
cw0KPiA+IGRlc3Ryb3llZCwNCj4gPiB0aGUgcmVmZXJlbmNlIGNvdW50IHRvIHRoZSByZXNwZWN0
aXZlIENRIGZyb20gdGhlIFNRIGJlaW5nDQo+ID4gZGVzdHJveWVkIGlzDQo+ID4gZGVjcmVtZW50
ZWQgd2l0aCBudm1ldF9jcV9wdXQoKS4gVGhlIGxhc3QgcmVmZXJlbmNlIHRvIGEgQ1EgaXMNCj4g
PiBkcm9wcGVkDQo+ID4gb24gYSBDUSBkZWxldGlvbiB1c2luZyBudm1ldF9jcV9wdXQoKSwgd2hp
Y2ggaW52b2tlcw0KPiA+IG52bWV0X2NxX2Rlc3Ryb3koKQ0KPiA+IHRvIGZ1bGx5IGNsZWFudXAg
YWZ0ZXIgdGhlIENRLiBUaGUgaGVscGVyIGZ1bmN0aW9uDQo+ID4gbnZtZXRfY3FfaW5fdXNlKCkg
aXMNCj4gPiB1c2VkIHRvIGRldGVybWluZSBpZiBhbnkgU1FzIGFyZSBzdGlsbCB1c2luZyB0aGUg
Q1EgcGVuZGluZw0KPiA+IGRlbGV0aW9uLg0KPiA+IEluIHdoaWNoIGNhc2UsIHRoZSBDUSBtdXN0
IG5vdCBiZSBkZWxldGVkLiBUaGlzIHNob3VsZCBwcm90ZWN0DQo+ID4gc2NlbmFyaW9zDQo+ID4g
d2hlcmUgYSBiYWQgaG9zdCBtYXkgYXR0ZW1wdCB0byBkZWxldGUgYSBDUSB3aXRob3V0IGZpcnN0
IGhhdmluZw0KPiA+IGRlbGV0ZWQNCj4gPiBTUShzKSB1c2luZyB0aGF0IENRLg0KPiA+IA0KPiA+
IEFkZGl0aW9uYWxseSwgdGhpcyBwYXRjaCBhZGRzIGFuIGFycmF5IG9mIHN0cnVjdCBudm1ldF9j
cSB0byB0aGUNCj4gPiBudm1ldF9jdHJsIHN0cnVjdHVyZS4gVGhpcyBhbGxvd3MgZm9yIHRoZSBj
b250cm9sbGVyIHRvIGtlZXAgdHJhY2sNCj4gPiBvZiBDUXMNCj4gPiBhcyB0aGV5IGFyZSBjcmVh
dGVkIGFuZCBkZXN0cm95ZWQsIHNpbWlsYXIgdG8gdGhlIGN1cnJlbnQgdHJhY2tpbmcNCj4gPiBk
b25lDQo+ID4gZm9yIFNRcy4gVGhlIG1lbW9yeSBmb3IgdGhpcyBhcnJheSBpcyBmcmVlZCB3aGVu
IHRoZSBjb250cm9sbGVyIGlzDQo+ID4gZnJlZWQuDQo+ID4gQSBzdHJ1Y3QgbnZtZXRfY3RybCBy
ZWZlcmVuY2UgaXMgYWxzbyBhZGRlZCB0byB0aGUgbnZtZXRfY3ENCj4gPiBzdHJ1Y3R1cmUgdG8N
Cj4gPiBhbGxvdyBmb3IgQ1FzIHRvIGJlIHJlbW92ZWQgZnJvbSB0aGUgY29udHJvbGxlciB3aGls
c3Qga2VlcGluZyB0aGUNCj4gPiBuZXcgQVBJDQo+ID4gc2ltaWxhciB0byB0aGUgZXhpc3Rpbmcg
QVBJIGZvciBTUXMuDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lLCBtb2R1bG8gb25lIG5pdCBiZWxv
dy4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3Jn
Pg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9wY2ktZXBmLmMNCj4g
PiBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGNpLWVwZi5jDQo+ID4gaW5kZXggN2ZhYjdmM2Q3OWI3
Li43ZGRhNDE1NmQ4NmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9wY2kt
ZXBmLmMNCj4gPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3BjaS1lcGYuYw0KPiA+IEBAIC0x
MzQ2LDYgKzEzNDYsNyBAQCBzdGF0aWMgdTE2IG52bWV0X3BjaV9lcGZfZGVsZXRlX2NxKHN0cnVj
dA0KPiA+IG52bWV0X2N0cmwgKnRjdHJsLCB1MTYgY3FpZCkNCj4gPiDCoAludm1ldF9wY2lfZXBm
X2RyYWluX3F1ZXVlKGNxKTsNCj4gPiDCoAludm1ldF9wY2lfZXBmX3JlbW92ZV9pcnFfdmVjdG9y
KGN0cmwsIGNxLT52ZWN0b3IpOw0KPiA+IMKgCW52bWV0X3BjaV9lcGZfbWVtX3VubWFwKGN0cmwt
Pm52bWVfZXBmLCAmY3EtPnBjaV9tYXApOw0KPiA+ICsJdGN0cmwtPmNxc1tjcWlkXSA9IE5VTEw7
DQo+IA0KPiBJIGRvIG5vdCB0aGluayB3ZSBuZWVkIGZvciB0aGlzIGh1bmsgaW4gdGhpcyBwYXRj
aCBhcyB3ZSBhcmUgbm90IHlldA0KPiB1c2luZyB0aGUNCj4gY3FzIGFycmF5LCBhbmQgcGF0Y2gg
NCByZW1vdmVzIHRoaXMgbGluZSB0byBjaGFuZ2UgaXQgd2l0aCBhIGNhbGwgdG8NCj4gbnZtZXRf
Y3FfcHV0KCkuDQo+IA0KSGV5IERhbWllbiwNCg0KVGhpcyBpcyBhZGRlZCB0byB1bmRvIHRoZSBl
ZmZlY3RzIG9mIGBudm1ldF9jcV9zZXR1cCgpYC4gSWYgd2UgZG9uJ3QsDQp3aGVuIGEgQ1EgaXMg
ZGVsZXRlZCBhbmQgY3JlYXRlZCAoc2FtZSBpZCkgaXQgd291bGQgaW5jb3JyZWN0bHkgZmFpbA0K
dGhlIGBjcmVhdGUgJiYgY3RybC0+Y3FzW2NxaWRdYCBjaGVjayBpbiBudm1ldF9jaGVja19jcWlk
KCkuDQoNCldpbGZyZWQNCg0K

