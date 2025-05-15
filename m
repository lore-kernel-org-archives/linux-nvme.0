Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8094C3ABDA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 02:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ekRrMB/mdfeG35RiPRLldb6a/bPydGv1neLJMNyoTQ=; b=Doo3TuGMIwGJGKSJH/Of7QdRUX
	fJjeSBHHDQV5hnmyKdw5DHBLh7yTiehapdQdnWZyvj0kQQv6t2BgScSSYuyLXAIdADKFrAoOfuuVt
	kpSEnbrkMqCP6nYgJnW8Y8igpMZC88W3Z9b18GyE9vsYzYNJdgdArMPhJtldqlFaNlGwnYFYOtucQ
	n30Alh9xhbP9d39n9i+iNi77799RVK4A8aI2HYeR49UdJBsn1H78/fFSumVg+N1LKhtDY8f5oRVIs
	DqFWKSvGJ316jnlrPa8RDLGMhxd4d+lMXEr22AjfvcoeUOx9Mxk/Ywi8izmaQpGef1Ap9l67QbAvx
	N6izkUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFOhh-0000000GrOW-0FGP;
	Thu, 15 May 2025 02:52:13 +0000
Received: from mail-mw2nam04on20612.outbound.protection.outlook.com ([2a01:111:f403:240a::612] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFOhc-0000000GrO0-1vBR
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 02:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+Ez2fNfBG4KtPzXlO+eErzygcSkIKiTgcpkShIs5u9Jn4ZJ4MV0BvVqHtszKS1+ejVCmbep3If6z9j+RkKYvayYT0faq1n5RotU+T6suC1+fD0S0bqea6OsD3vojdTQZc65CAfNFj1LaLo1SHbqyh0CpZIi753mWCi4mVRxou/Rz50PhHRwokM3jQCfDH+habgxQ1zRFBmz1EM/07edShh7lpNIm0ge+N/UsG2aQkS5zJTvxF4ajWAs0E8enNgzpC05ZZEtoMtA/zS8DBh7rS8zgTkYBuaZ7b0lz02LFQ+KWg5Z+piOOFIaVkY+iyENmchMtAndhhTgKpSj9aG8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ekRrMB/mdfeG35RiPRLldb6a/bPydGv1neLJMNyoTQ=;
 b=AH8q+7ti2LvbgA/HHGwQyl0H+peDZI0DevwnBKwyQeNciQMutYnfcpkHDQKNwGeNIIHXq7e0POmLepTAZTJDw2lwTA4NfFdXN9caMuBz537TRZoMsELwMUzBbM5b46EleO14d4BI/CklIdjAMa7nttqo89wEwS/AAeXr+vKZh29Xs27JoIr4bigrRAk0cuD2ZE9kVwOz8I1GGxaaiY2RCnTNogHK9Vh/wAnw1i/zDGwLFlseghzqa3buP6jkMXnW0xvnphR4Fih6LI82C+o2ENKRGWUXgt3e5BeEhLwNpLoy09DoWL1v3+LS1n424gSA9ZzPmm/9HpgsKFBm+ZjvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ekRrMB/mdfeG35RiPRLldb6a/bPydGv1neLJMNyoTQ=;
 b=kiClTtwBmk1l+TMjoFBatRbyOLv34H0+PXEbKmmImTWLX/WVTmTX8oUy2ePOy8fI6vCdKNYXJjKUJ5fmloTinbzCrGKdeKz/lj/o2oC3YRDRJzPNWeLWz6VGhpx7vDlFCLaBAYnVJ2BXDKnZzpkmKcdCLTxjAI3lfdIucQ9RgHYA+c9aPrZij/L/k84NQHCW237J0iyEooRpNkxh43LBA7XidHu5HD3UO3omKfwE8CBC33I5W5qtwy8+gV/eNB9s8la/BJwa6AqSnDiNBHPHRCLV4hCh1UfsCAEO8uvke29+ct7QTVlkeSDMj4ZurxTr+XfaqE9hPnndRAbWV0hR/Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 02:51:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Thu, 15 May 2025
 02:51:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH v3 1/2] nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for
 multipathing
Thread-Topic: [PATCH v3 1/2] nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES
 for multipathing
Thread-Index: AQHbwGiFBzFTnmk2tUi17VlEonA+EbPTB8yA
Date: Thu, 15 May 2025 02:51:51 +0000
Message-ID: <6ef17f4c-9215-43ac-a392-1c75fce0d1aa@nvidia.com>
References: <20250508223802.277311-1-alan.adamson@oracle.com>
 <20250508223802.277311-2-alan.adamson@oracle.com>
In-Reply-To: <20250508223802.277311-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7138:EE_
x-ms-office365-filtering-correlation-id: e31e16ae-bb54-4ac9-e404-08dd935b71b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cFkybGhNV05FeWwwREZ2amRnZ0dxckJvSlBQRGswemR0RUswcDdVSVYvZ0xo?=
 =?utf-8?B?bVFvOVQ5MGt0TVpCaHBtZkI4cFdneTlIVG1GRzRXNmhObzN5STBjaUV6Yzlt?=
 =?utf-8?B?YmFTL2k1L1psVTIrbU9teFpuRjdwOC9qbUpSZ0ZsYytKUnJwQitwSmw5MGl6?=
 =?utf-8?B?MFMzMkw4TVdiK2VEUFZPd1VtUHF4UU1iV1p2QXFHU0sya0V2bDgyL3V1VTJG?=
 =?utf-8?B?NFNOWDV3ZStGRkg4L2lSR280RFNkRlFQQnA2R1BnckVUYi9wRzJrTVUxRWJk?=
 =?utf-8?B?SzFCbTU0UmNXYkx5NEw4cEN2eUNsbXlVZFJmNmdwRE5nOGJRcUFzZTRNLzYr?=
 =?utf-8?B?dEdpSitXYWx5b0g2YWhmTmthUjRYY2hFcXJoaUFBdkFrWEpiTlduYkJ1SDZa?=
 =?utf-8?B?YW9Pc0ZnVFAwR1VhVi91d3lObmVMNTA1NEcrQ3VXRUlETzRyUWhrbElCVE9K?=
 =?utf-8?B?b3dNaUlKWm1GNk1YNnFNRzNBblNJcXZacHk1Zk4vZDlLL3hSNVBaNTR4Yk1G?=
 =?utf-8?B?RDJraU5ibXpqNU9CTk1waVhZTENMSjI0UjR2b21wRU5sQk1uODhOZlF1RnNy?=
 =?utf-8?B?T1hJS1Z5UkJINHgxazJES3A0OExBSFZVQ2g0MndpZFpmR3ZTNkdNSzlSQkYx?=
 =?utf-8?B?R2hzS0dPN2poRHV2OUpjSEMvdkdxNUlkU0tyQThIRjlEK01FK1NXQXFVUW9K?=
 =?utf-8?B?aGZvUUdhZkRTTW91b1hLdHpoZ3dnUUkxeWpSTHFYeXY3YUxkNlRRdENZeXFa?=
 =?utf-8?B?ZVRlazhsTW5jV2ZrUmIzRVQ2UDF6ZDliK3dpaGJORXV4dXlnVlJDSnhUaFZz?=
 =?utf-8?B?Z0h6bFhibkFWQlYramxJQStUUUlzWkFkZDJnNVowWngrL1Z0Yit5YnFuN1FW?=
 =?utf-8?B?cm1oTEpVbnA4UFZwYi9VL3lvVnRsM0N4Y0xjRFVNWC9QbDhoUVFLQlBaY0FH?=
 =?utf-8?B?V2d2VTBqYmJDd3dIV041eHRoTE1xTWlSakZqQ3J6QmFOM0krampLMStldVZu?=
 =?utf-8?B?cERMNGYyNUZEdWZJcklSdS9qdVlTWUtUbDZDekg4VTJQMDFUQ1AraE4vNER1?=
 =?utf-8?B?QWZQVnpxVGduREVhZWRwaDg5aU44RWdFREJoS01NZXNodk91Q1N6WXlMREw1?=
 =?utf-8?B?VTFxR0dRaERlRWk5M0laSkdVVzEyTDFFNThYQThSTS9MTFBsRGJIUHRaTFln?=
 =?utf-8?B?NjkzeUtRSE1sbzhtRis1V2hCNVpUd2s4aVFRbk82OHB0RC9JTVVnam1jYzVv?=
 =?utf-8?B?SjA4Q3FTRzNFdXloNkNlUVpzSGdCNHIvTktGMDFRWExVNjR4WEVKSnVCL2xK?=
 =?utf-8?B?dm1HbDdjcHc4ZitmRFQxRE5TczBPUnpWNXpheXA5dVJUVitibFVLbWd4aVBV?=
 =?utf-8?B?cTRBNGg2RlVUS1dZN3BwQWovWTllcXMrUHAycnpUbkVHYWhxajhNQTg1dk1m?=
 =?utf-8?B?VnNHSnI1V2N5NkxsaGRlUlZwQTQvQnlYalJuOVRCL2FXd2w1U1VaYnpTU3Np?=
 =?utf-8?B?M0VuaVhBMXlDTE8yWForWUVKSERqelREM25abk45dW1nYWRheVpFY2FwN3VW?=
 =?utf-8?B?ZlArTS9zWGNlaU51Z0kwaldpVU56M2haelVYUmpFRkw4aERtdmJ3TjhTUEd3?=
 =?utf-8?B?UWtEOEFiTm94UE5kY0FPV0duT01nL2tOSWlMb242ZlRuQk00aWR0UXV3YUpu?=
 =?utf-8?B?ZTIybGFBWmpKTXVZWXJzMCtCRVB5dC9ucVk5MXRYSEk0QXZEZlBvQTdoakh5?=
 =?utf-8?B?SmNnaFhOTHRhNGhKOU9aWDRNRmZXNWZWWjc0aEVDRU5SbXNBbnNpcTRlK1pI?=
 =?utf-8?B?S2tma1Q0MUkrSWxWbUYzamMwVWFHVXJTd3Rqb0ZyT1hrcmVHMnZXRWlFWlVK?=
 =?utf-8?B?MVRwSll4cW9iV0w2MDgrZCtFSG9IYWpKcktqZXpUZ21TYXd6UFUrRm9RSTJS?=
 =?utf-8?B?TUdmZTdUOE1qRUVKMjRUbkJxVzRNdC94Q3JHYUR6dTl5eiszWXluak9VQjFu?=
 =?utf-8?B?NUdFcnowYTFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNmVGg4aEFBejMvczJOYW1QUmdKNTFIZEV0eVo1d0VuMDRaSWVGTnlQSlBs?=
 =?utf-8?B?aTlTR0c4YTd5Ylh1U1dlb25jQlhnWVVuRzhKeWxrT0pQeW0xTlFvQ1VKbFhW?=
 =?utf-8?B?eWt5ckxGMFY1MllXcXBmTUlnV05pWEdLaWZNQlhWbThCd0NncDlSekZuYkJJ?=
 =?utf-8?B?bmJXSWlBcFdjTGxxRzU4ZkV3ZlpDemNxNVJsampoY3MvbU1JaDBaSmsrSjN0?=
 =?utf-8?B?SmZmdmFBeEEwZmlmY1doZzhscThMekcvKzJIZnc0U1duNW9PYmtxcS9FdWRI?=
 =?utf-8?B?c0J0MHpqb0Q0SlFPWC9CcUpxaHNibm5hbXFjZmU1bkxSVGRyQ21lZmx1clZ4?=
 =?utf-8?B?TVJHdkk1TnVPVXlZeDBQOHU5TGxmSE5ld3Z4b3MvMk81Z0VBZmh1MW5EQUE2?=
 =?utf-8?B?dUtuWVZIN1M5R013QlpaTUtoSG1YaCtGT2dWSDhSMEIrODBvWXV0Vm10dXc3?=
 =?utf-8?B?NU1wUnpBcnBoNGUyVlJSY0M2MktXdnJ6MjJXYmtyZFVSQmZ2WTZRb0RvVk5O?=
 =?utf-8?B?OFg5b3AzVERRSkxRcFpSMXNFQWVXMjE3bUhrR2k2R1lUSlJRQjczRjMyd0NU?=
 =?utf-8?B?S3YrWE9pTytLY1R3TVhwVjJGUHlZR1puZUlEMzM4dFNhdWRDM2dZYko3T0Nh?=
 =?utf-8?B?Sk5EQ2VKREppZ1MxR2lpUmNxeU56QS9hV0JlWWZZTnRSSTZvVm9QdzVDeW5T?=
 =?utf-8?B?RTFvK1BjQzExYjZlbTFJaFBoTWI2UkZNU2NpMlNOc05yUVNNSVNjRi95SS85?=
 =?utf-8?B?bWRnTVVlWGJ3c0MrUWhBVThsYVRsckVhcldUR0ZHTEo2dUI5bU01cFV4b09F?=
 =?utf-8?B?R1p2OUx4VnQ4M3pTTGtGZExsUVZ5M3NUS0tyeCt3WWFEci9aME5Qd21WSGJj?=
 =?utf-8?B?RHZzaUdZQzhCSEFORUR3c3BHR0RVWkNGc28rMjduOUlsZk1FQUdRT25NVFhy?=
 =?utf-8?B?TFF5UTBpUmxVTVR4VDZaY25ZbW4rTVJzbHVZNS92VlZzbEtJaFJDMGdLTmNu?=
 =?utf-8?B?VTc5YzNWRWc5RHpZTS9vcWpLalg5YlExTXRTT2dBUHBVSU1DcEp1eWsrdXFa?=
 =?utf-8?B?TFhjNXdSSW5iN1Vrb0hwa3UxYmdHaEgxc3Z1Z2FrTS80MnowVXU3TWtHUnY4?=
 =?utf-8?B?WWV1RlowVXlaNVo0OWhzaFZERnJCVzlNQVdyNUlMN3lKbUMxZjVNSjYzSUIy?=
 =?utf-8?B?cHkvQUg5KzdsN0t4VjYrVS95UEJNd1BNaGZZUG9MK0tQUW82Q3p6ZXNGNkE5?=
 =?utf-8?B?ZitlZm5lMithVXN3VEo5YlQwcnZISDE1elQ5SURpUUtkckgyTGNIdkF1eXg3?=
 =?utf-8?B?OGR4azg4MHBqOVBTV2NZWjdET0l2TWJYM05qTzhkUnRod2JtcCtZeEdqbURP?=
 =?utf-8?B?ZGJqb1FJUWtRK1Y3RUFna0RrYjhPSG13MGFjWFg5ZVhVdWlVdmRybEpTN1VL?=
 =?utf-8?B?dllpWThUMDZqamcyeHpNZTY1Z1RhUEUwOXYrWDhrQWwyRGRkbXluMnE0bDN4?=
 =?utf-8?B?OTJGTVNHcjAyZVJka1NiWEhmY09PVWNSeGwwYW5kTEZDUXRZaStOMUpldzdh?=
 =?utf-8?B?YW9DNnVMVUwrb3VBei9nWGxsVFJqUkZ0L3lUTlJEVXVNRzBPMnpLWHE0bUdD?=
 =?utf-8?B?RitCek5Dd1lRYlFuNUVMNWoycHltQXNLN3BmV1A3bFRsei9YSjdJbVdZVUpt?=
 =?utf-8?B?R20ybUwrR3FBRmcyUzZHdWMrUkZXTGozZGdLYnp6d2grTlFqbjdxRzB3OVJL?=
 =?utf-8?B?THBBakpmSzhvZFBNdXBqUDZFeTU3c0xDekJDUk55TG5jekxIVFVDaENPMURo?=
 =?utf-8?B?VnZDaFBhUXQwQW4wUlQ0ZXdPT2pLaTdLeDk2OHdLSTBJeXByZEdGYUUwN084?=
 =?utf-8?B?Yjh5ZGRTWVptb3Awb1dKWVZkby92OVhXbXZFRkg1Q25ha2RMRmZvMlN4Nk5Y?=
 =?utf-8?B?RnRHQUM0ekt1MDkrTG9Pa1lla3VoQ1lDYklubmh0NHRSMHJSeHRlQXNEcHQ2?=
 =?utf-8?B?cmw2T3RjN1ZMdW9KbHp5RVhGQTZaOTQrUSttNEJMa1dIdUhxbUV2ZEpERU11?=
 =?utf-8?B?cHlTb3RwSGVPYjZKZDF0SXlkR3hZWFN2L0sxVmtCMzJWdk96UVMwNjVacUFx?=
 =?utf-8?B?Z0JPeFRaUjFPWDJKQUVXOGVSb084SjZwWVIzbDhJMGc1bUhhU05KZGcvZWwz?=
 =?utf-8?Q?V3O7bDnT+dXuwHm3r/EnM6FLURgJgFw99YlEhlfagiSD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F61E80CE19F084F911048B74F91377B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31e16ae-bb54-4ac9-e404-08dd935b71b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 02:51:51.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5r++P8hWFxQYUBDcgtXvkY7+qsZNF3nMpHgZ/vJnuo+ps6ZqNcuCAi7FOz8yc8FCt2ZVCneGvUu1Tw2jHYyrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_195208_514303_E2E0534A 
X-CRM114-Status: GOOD (  14.10  )
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

T24gNS84LzI1IDE1OjM4LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IEEgY2hhbmdlIHRvIFFFTVUg
cmVzdWx0ZWQgaW4gYWxsIG52bWUgY29udHJvbGxlcnMgKHNpbmdsZSBhbmQNCj4gbXVsdGktY29u
dHJvbGxlciBzdWJzeXN0ZW1zKSB0byBoYXZlIGl0cyBDTUlDLk1DVFJTIGJpdCBzZXQgd2hpY2gg
aW5kaWNhdGVzDQo+IHRoZSBzdWJzeXN0ZW0gc3VwcG9ydHMgbXVsdGlwbGUgY29udHJvbGxlcnMg
YW5kIGl0IGlzIHBvc3NpYmxlIGEgbmFtZXNwYWNlDQo+IGNhbiBiZSBzaGFyZWQgYmV0d2VlbiB0
aG9zZSBtdWx0aXBsZSBjb250cm9sbGVycyBpbiBhIG11bHRpcGF0aGVkDQo+IGNvbmZpZ3VyYXRp
b24uDQo+DQo+IFdoZW4gYSBuYW1lc3BhY2Ugb2YgYSBDTUlDLk1DVFJTIGVuYWJsZWQgc3Vic3lz
dGVtIGlzIGFsbG9jYXRlZCwgYQ0KPiBtdWx0aXBhdGggbm9kZSBpcyBjcmVhdGVkLiAgVGhlIHF1
ZXVlIGxpbWl0cyBmb3IgdGhpcyBub2RlIGFyZSBpbmhlcml0ZWQNCj4gZnJvbSB0aGUgbmFtZXNw
YWNlIGJlaW5nIGFsbG9jYXRlZC4gV2hlbiBpbmhlcml0aW5nIHF1ZXVlIGxpbWl0cywgdGhlDQo+
IGZlYXR1cmVzIGJlaW5nIGluaGVyaXRlZCBuZWVkIHRvIGJlIHNwZWNpZmllZC4gVGhlIGF0b21p
YyB3cml0ZSBmZWF0dXJlDQo+IChCTEtfRkVBVF9BVE9NSUNfV1JJVEVTKSB3YXMgbm90IHNwZWNp
ZmllZCBzbyB0aGUgYXRvbWljIHF1ZXVlIGxpbWl0cw0KPiB3ZXJlIG5vdCBpbmhlcml0ZWQgYnkg
dGhlIG11bHRpcGF0aCBkaXNrIG5vZGUgd2hpY2ggcmVzdWx0ZWQgaW4gdGhlIHN5c2ZzDQo+IGF0
b21pYyB3cml0ZSBhdHRyaWJ1dGVzIGJlaW5nIHplcm9lZC4gVGhlIGZpeCBpcyB0byBpbmNsdWRl
DQo+IEJMS19GRUFUX0FUT01JQ19XUklURVMgaW4gdGhlIGxpc3Qgb2YgZmVhdHVyZXMgdG8gYmUg
aW5oZXJpdGVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFuIEFkYW1zb248YWxhbi5hZGFtc29u
QG9yYWNsZS5jb20+DQo+IFJldmlld2VkLWJ5OiBKb2huIEdhcnJ5PGpvaG4uZy5nYXJyeUBvcmFj
bGUuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

