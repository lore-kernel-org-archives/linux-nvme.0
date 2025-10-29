Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5557BCCF9EE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PY0AD5UHBOlrUfIvRaxXUNih3i2d6ddxRyFW1EEv0w4=; b=fxUVf0T6sJnGZ3kbxsR0INiim0
	d2IYOY2/QX8YGYk6dyA7EuVwVumxLxn9BG1LRdEC27y2GGcgz1AQjan78ZqqZ3n8pssroaGs11F7S
	5KrCebz0aY2FNRO8kD9gvpBCdl1EWk/eW5ff0Qo8sz/0Nv73QjmdMUtp215YCnt0DUo2jTUmDEyTp
	QxHrFHGVZIWDg29daAOZNtxABoIQ3A26WczDG1tRJru3Fs8MY54cNksv3tzTTCBRXURjLx18Jm5t5
	ACqysIe1oiOdtpvo88JwoA8NFVhqDBpVvVNCVd+kVOZrmPyaLxtU0uRNUOG2BQeKPZmZkNRvGOLL+
	F8LbQicQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEFYF-00000003FI8-1MfX;
	Wed, 29 Oct 2025 23:25:59 +0000
Received: from mail-westusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEFYC-00000003FHk-3JaG
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 23:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWHqdcOGTSied43tBFmE80akgG7fPFkv+KGGlldoVLyfXluLulcFs2hOgLoAJEH2stVEEWjZhn7iBcwaeFOuEdGAo1/IGinhDGOe3kBlxX8kS6CuB42CbxCd+Tue85fVXOgIMjZGsbyqDIIFHyR2tPv2pfPUls13G2qg096lL87j8d9x4nhekvzqasRGJMTG0digTjpNW8zNLJj2WWYxkJeIoLIdPjoLNGkafDqixJxsRqwZcdP3/MtNk+CZ4VKQW2uQ8n7nHZOZluZ+R31Lq/Y3ZrPTHGUq3Gyc47JC23ZeP5ePZa0nkawLrdFtBEI1trVoopft/rqqqI7UaJIAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY0AD5UHBOlrUfIvRaxXUNih3i2d6ddxRyFW1EEv0w4=;
 b=fhEA7Kg1e+QQScdWdZRQSdmtJ0CiRIMVm/YLOZqQ0wa+DIs0jwW/PPj+mGFiCYWyUKqFRre4H1TB9UIBEpNpsVcuxDM94BdINssZKVuPVG7EO2zVcLob1hGVX5qds+OUwTtQv3gHMAQKB/Y9KvmcC1Xl2QOzhaB5luYTMqf0RWCcw6sxMcgFw+oh1DFnfxJD2WbkqskN3O60iDXMhFaA9kSYHbosxeotX51uHl07YKtpdQwdguHsFCbgeRRToPaM9C+H/fA3GlB+IKZ/7vH+Y3ITOPhlXu+o2ZyqG161DI+vNM1yeWhCSEHQposuHjP6Alo78sX6PuFQR1a2s1CVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY0AD5UHBOlrUfIvRaxXUNih3i2d6ddxRyFW1EEv0w4=;
 b=lJMKlAodKQ3RVo5vFmUUWPYH/L9xDzhwnduJOrw0J5e/PUU6BAx4A5RMeWPtiSDhtX2JWTggDbchIs93Y7xduIeCqvYNlAdRDMErk/JkpVQkTLoFnAEMDslDEFLxtn7OEVUnF15VKWZHPN//UuFoDdv43+BX4o29RjlxYwTi50iq09bODIPsC/mrbePS8aG+PE7udzzbSZWjWHrC5fO6IaupfIEFDN8l4TVZ6oDSYnsLOX0SLwjPfIkvlu6wsU+RONkOwmttrMKLI4hjY+yY6SI59vhNWpahB1EBsOp/gGvjwhyfhofihJXfePGR1bqDINoOexLIE97tMpmusvTdRg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 23:25:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 23:25:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>, Bart Van Assche
	<bvanassche@acm.org>, Maurizio Lombardi <mlombard@redhat.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>
CC: "bgurney@redhat.com" <bgurney@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
Thread-Topic: [PATCH] nvme-pci: expose active quirks in sysfs
Thread-Index: AQHcSBeS/Wfpc7fZOkySrLZKHYolZrTXwNeAgAAHrQCAANZrAIAAJYsAgAECEAA=
Date: Wed, 29 Oct 2025 23:25:50 +0000
Message-ID: <5f38e8ae-41c3-46ef-ac3d-b6e1c106379f@nvidia.com>
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
 <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
 <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
 <DDUND9A6HFVR.14U2BRGS72CEP@bsdbackstore.eu>
In-Reply-To: <DDUND9A6HFVR.14U2BRGS72CEP@bsdbackstore.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7264:EE_
x-ms-office365-filtering-correlation-id: a8acfffe-5c67-4f64-6418-08de17427f55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aFRhdGQrYmlibXRZbmNGejJvNWFreUxDN2c1WjhqR1d6UGFlajR6MW5vOGJu?=
 =?utf-8?B?YlQ1ZTU1ZE1rNWwwQkpHdTVyOUJHZlQyUGNQWXZxa0ZRY0d5OWdreXFsMjJt?=
 =?utf-8?B?QXhhU3hTQkR6NW1mT0R2YVZuNkxRVkx6aUtqUWF0MDFJNkZqeTk5MjN1cnlN?=
 =?utf-8?B?dnlnZVFNbURDb2d3dC9XWFVlMWhpd3NhMDNZa2JhSzk2Rkd4K2tpdHo0WEk1?=
 =?utf-8?B?cExzdm9pa3ZlWWlVNFNrWWxhNjlicDMrdlBoTGVqM3R1R0tSbVNpVkJxeThV?=
 =?utf-8?B?UmQwSGdBaGhvRkl6cnh1WjNIcXVtc24vVTdxcDh1d2l0by9memlCbEpQd3V1?=
 =?utf-8?B?UzI0ZFkzT042MmZCZUNLeDhiQVdUMGZKRWtseC9teS9wVitlVUsxZnlYWWNs?=
 =?utf-8?B?alk3Q0V4UVR2Y0hGbzlraGlMeG12ZUVwOXRRcUxMdjBzQ2VaNlRIQ0dtVmFy?=
 =?utf-8?B?WGluWEE3ZEZyN1Zqam4zTnhwRzJyM3hGNGJCOUdWbkNHZnkyOTNhUk11Mld6?=
 =?utf-8?B?Vkk5ZVBucDhGejY2OXN4SXM2Tll2cHlUOUdCTWZCWDJ0c09oaWtXdEpPQ3J2?=
 =?utf-8?B?R0Rrc2FmYSt4QWl3RXFmMVBqV1BZbFFVKzBNQ0p2azQ0VUpBQ1ZzcDVnR2dR?=
 =?utf-8?B?d0FJR0k0ZnhKTVl6STE4bHlSaUUzdFc2cEFUNmdnb0pBb0Y4cVVrc2RveGJM?=
 =?utf-8?B?UEF5ZmhUaTlvR3pESUFMcXpVRXgvQnUzcXhPeEU2ZlBKN1Y2TGpYeTVzWWdq?=
 =?utf-8?B?SmZ6TGlYWURrYmIvdFh5L3JnRFFaZXJiMlFBaHk0UXB6RHY3R1lvem1aMnAx?=
 =?utf-8?B?MXFMYzFkeCtYNDJqbWM5ZU1WOUlPaHpKb0w5RVB1VHI0QUxZV3daKzA1cktl?=
 =?utf-8?B?dmg3RkVkWHoxdHczdXV3UEl5dkUxUXdTc3VyOXRwU2JPSFpjS29xNjFsS2NC?=
 =?utf-8?B?bXJKSy9sUm5ETUNleitlU2JLdnVvQmxYLy94VmxuUS9pRW45cE9pcnhxd05y?=
 =?utf-8?B?T3FmZC9nTGFBdVJhS2trczBUcEZtU0ZQOEQxZ0dTWmk2MlZienErWTlNZ2ZN?=
 =?utf-8?B?aUtmUG00cUVHQXlIUVQ3UFJZTDBqUWc1SlBmanRwV2hVcXowYXF3eElkSTV4?=
 =?utf-8?B?OXJmNjNCa1lxcnpqa01ZYVg1SFdQQlJWazdZZWlJT2dsdzBqbFlSQUNLWkNI?=
 =?utf-8?B?Nkc3OEtxeFpGSXE1ejE5S1QvMVJON1BLV2YvdFMvVWpqQ1hucy8zeENlUTY2?=
 =?utf-8?B?RlVEbmMxNm9pcllKbGFINzd5ai9mVEJNbjRna0pvR0xCYmRYSmJvRTJhQ096?=
 =?utf-8?B?NXI3aFpMYXZyNXRnVW1NeEQ4NHdTRGZmZnVocmJmYXJiMkpJQ3JIQzJ1VFRU?=
 =?utf-8?B?OTQ4R0VtT0tmLzUraGRvc21VL1hFbzhFSmZEME5SVTVJbnNPMEE3ZUxVY2Vk?=
 =?utf-8?B?NmFwTnRxTVZneklNRVl6blBRRHNzNnBtTFlrYjI2eUptcmUrZVBKNzk4ZmMz?=
 =?utf-8?B?Tk5XK0NjM3ZLaVJFaXQ3TXQrVUFrUTlDN1RBTjZrR05sTjlCc0ZHK0g5YWlQ?=
 =?utf-8?B?QjMzNzRBaXlpSHZPTkc1NXhaK1Y2eTJuaElSMkQ4emgxbGpBYjRwSEVQS3h3?=
 =?utf-8?B?Zzh6Y0tsSXZSTEV5QmN5S0dUcExSNXY2aWVSSTNvaVBQQTNrK0taSjZpSjdG?=
 =?utf-8?B?cDJNcktMUG8wRlFlR0tVQVFSdkRJYVdDazR5bnRLV0FFL2lWUjFpVXp0Y1pp?=
 =?utf-8?B?TElmeXNFWS8zenp2aFMrZ2lhdW9ISmlCZ1RFUFFVVE5reEQ1ZWwyazhld2ZB?=
 =?utf-8?B?bVhlYnIzczNoMDA1Y0M2ZmhBK0llSVh3aERGajc4am15c2RTMTduWTV4Qzhp?=
 =?utf-8?B?Z24wZ0lJamw2YXUvUmRmK2NveHlxYXYxOG80L1R5RHZnMWhSaytsQVZ3bDhD?=
 =?utf-8?B?eFFyb0paR281bVN4SktpOGFCQWxHaHU1djZxMkRVaGIrYzYrSVRmbEpSSnNR?=
 =?utf-8?B?YVRFcG9LTHFqblhUMUtpWDhjaW9wenhuSXF5RG5KL25BVzNidS9WdmphbTZK?=
 =?utf-8?Q?R+Ekht?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0tjWko4dFMxVnBBaVNya2N4dGxvL29TWW5EUGxvMmlSWHBPUlJUMUZML1dY?=
 =?utf-8?B?VVR5S21QbjRSeDByd3kyRjZnSndJR3Nxd0tjNFRqQTBVbm05QWMzWVdicmpj?=
 =?utf-8?B?WkhEQUxxQzhNUzV5dVh2aWlsc25lVDlSb1FGbm1zYWV2d3VrTk8xRDRTSHpJ?=
 =?utf-8?B?WjJRc2pJSGVseS90bEdGdEhKcDBvb05NRVh0b2ttTlE5K0Y3ek5jRXpnN1VY?=
 =?utf-8?B?UDdEWm5JT2FCY1BQNGdXSFJTc21LMnFLckJXM3MvdGR1QzdQekNNNElhWWJX?=
 =?utf-8?B?bDFmRFV5NUdwakNoa3NHVWZ3SmdKZy80V2VuWlZxczlFSHB4NVY1Ym84MWk0?=
 =?utf-8?B?cURaWVVJdjlKeGl4VDUrK2plWThhZ0dvN3hCQmtiSUY5cVRMa1JEd0dNbTRm?=
 =?utf-8?B?MzROOFhteW1DeGdpZFBDaGRCTzllMHNTeUhQUWdCcFVlM1VHSnV5WWFUS1VT?=
 =?utf-8?B?T3MrakpUVUFEK1ZleDJjV3o1bUZEb2YrT1ByWDhKOVVsZk9ERG5ON0s4eVRq?=
 =?utf-8?B?MTJuMENmQndZWDNQbXNWM0pTR1JUNTBibitEOXI2OS9DV24vK1RwWVpPREhs?=
 =?utf-8?B?dExNWG5XcmNVdk4vd0kzZHVvWE9iOE1mbjdmOGRsWFM2NXY5RWhHVUtnN0d4?=
 =?utf-8?B?NGlGZVV4NmZ0RDJPWGRMYlQzTU53R2FPZkozaC9EVG9EQ2hKbGMwRVVzM1JO?=
 =?utf-8?B?WWJSTnJ1cENzeFpkSmxmTFMrM1l4eHgwMTRkY2pCd2IxdnczWlRjdEE5UnNj?=
 =?utf-8?B?WitKR3hCSzNTV2wzcTBRaUd2R2NCeVBLQVlOeVg0cndqVzFZQ3dLNk9XRFFZ?=
 =?utf-8?B?Z0xsK3o1UWt6SjN5NnFaakwyejQ3bVhrRjRhbmlBTHhrUUhPUnFBTDBJaW1K?=
 =?utf-8?B?eEhHcVFxdFNDbVczNnhWa1ZnMENrYjZkTGVKK1F0Sm5KTkVJdzJRZ3l2cUxp?=
 =?utf-8?B?a1RQa0wvcTNPL2E5WlI3aUZDaE1ZQnZ6Z05lSnJ2c3ppR0dyeitRRVdHbEpQ?=
 =?utf-8?B?RFhkSE9JeDlHMG5CcU1Rc1UvUVk1bmZUWFNQTGxkK1JaRWlldEg5RFdLbGMx?=
 =?utf-8?B?Mks0Ryt1UVRQcTJ5ejRoRlRxbEVvdnV6SVAzOXNHWXVNeWZlcWc0aTNkb1U5?=
 =?utf-8?B?blR3dHBYTUFwSDVLUDM4YksrMDViWEh4V0lZa1RwRmNEdC9HU2tBQW80dC9I?=
 =?utf-8?B?NlJ1UG1SVGJGOHdDZ3F3Uk4zbC9PdFJKUzJBNmJNWDRaQUtWUHlNZzlrbFhm?=
 =?utf-8?B?VzhydFdPODFJT0ZBY2lkMXI1MEY5NWVLbDBYNE5lQ0xFazJmbkQwQ0JEOVR6?=
 =?utf-8?B?QWExU2FIZXpCVG9MbmNFLzBzVEI3SkhtMkRKSlY3dlZmaWx3enJZdHorVXBh?=
 =?utf-8?B?cHpIdVNEaTBEdDU5bFRKYzdWVTRuSTlSRWRiTEJhcGZGN3BVTDRLbGN0SmdP?=
 =?utf-8?B?N09KRlNKU0ZkM083bG1IanZjVVFpcUFjQWVZeTg3cEdac1VpRk5iUTZJM0du?=
 =?utf-8?B?Y25xY2lxQUhuNjlrUzROR1BibjYybGt6N3MrRjBKLzVEeE94c2pkN2ZtQ2Nw?=
 =?utf-8?B?a1lVcHlSUXBoQzdmYjRsR013eHpzQnNKQ0w3Qmh5Y1ZqWDFEbjM1TC9kdlNv?=
 =?utf-8?B?ZFVIWUlXak1aUER0eTFZeU5QdDViY2daUTRDbi9sa25XZHJlUHA3TS9IODc0?=
 =?utf-8?B?Q0taUzhVRkpLRWFtaWRqNkF2aDJBNlltVS81ZFoyczZkSHFsRVMvWWpvQ3oy?=
 =?utf-8?B?c0VNUmIxZ0lLTGxleVRTazVKOWNQR2diVTBGR2luSWFpMlRBVWRTYTVJcS9F?=
 =?utf-8?B?dVBQMERMQldicnVmV25GckhwYTFLWWs2dDVmLzFrbEtnTE5Yd3hES0FzLzJj?=
 =?utf-8?B?M21xMldmRzlLSmcyQ2JKTlluUjRrUGpBdTRnR3VIdE5yYXJlQVp5MnpIWEhv?=
 =?utf-8?B?cEp0cXEyYXd5QThDUVprbE9BZUVFOGc1bGFVMWROTUtnWjd4bDltWmFFeHdM?=
 =?utf-8?B?Yk1XbFZ3T0lna2g3Rnh5a2VCQXZHaFlDWjNMSnBzeXozS1IzWmN2bDljYlpj?=
 =?utf-8?B?cU9IcUdldVVuY1Vab0JKejRSWmRrWEdySC84aExZdlJFSHJ4SlhhbkpUT1NQ?=
 =?utf-8?B?TzVhVXBVbWFnTEhuVGNaNVhJOVIrRXF6cnV0YlA5UkpyV2YyV2xVWDBVVUla?=
 =?utf-8?Q?llAYhaf0kQeZVyKyN9C7VIOhPnN+KkSc8Iv1CoedDkJO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24F58825BBCC5444B4605CC2F8D3FA1A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8acfffe-5c67-4f64-6418-08de17427f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 23:25:50.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4JM/0bm+U6ZXWGAQhxTKtzSaGvD+2HkEwCIM/9+2p/xSqfl+6oFDmj6wDavnnlUAelXFO8wQk2JL7lbsgxx5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_162556_860936_61FDB21B 
X-CRM114-Status: GOOD (  19.92  )
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

T24gMTAvMjkvMjUgMDE6MDIsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBPbiBXZWQgT2N0
IDI5LCAyMDI1IGF0IDY6NDcgQU0gQ0VULCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBP
biAxMC8yOC8yNSAxMDowMCwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+Pj4gT24gVHVlIE9j
dCAyOCwgMjAyNSBhdCA1OjMyIFBNIENFVCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPj4+PiBP
biAxMC8yOC8yNSA3OjI5IEFNLCBNYXVyaXppbyBMb21iYXJkaSB3cm90ZToNCj4+Pj4+IEN1cnJl
bnRseSwgdGhlcmUgaXMgbm8gc3RyYWlnaHRmb3J3YXJkIHdheSBmb3IgYSB1c2VyIHRvIGluc3Bl
Y3QNCj4+Pj4+IHRoZSBxdWlya3MgdmFsdWUgZnJvbSB1c2Vyc3BhY2UuDQo+Pj4+PiBBZGQgYSBu
ZXcgcmVhZC1vbmx5IHN5c2ZzIGF0dHJpYnV0ZSAicXVpcmtzIjsNCj4+Pj4+IHJlYWRpbmcgdGhp
cyBmaWxlIHdpbGwgZGlzcGxheSB0aGUgaGV4YWRlY2ltYWwNCj4+Pj4+IHZhbHVlIG9mIHRoZSBj
dHJsLT5xdWlya3MgYml0bWFzayBmb3IgdGhlIGdpdmVuIE5WTWUgZGV2aWNlLg0KPj4+PiBUaGlz
IHBhdGNoIGNoYW5nZXMgdGhlIGNvbnN0YW50cyBpbiBlbnVtIG52bWVfcXVpcmtzIGZyb20NCj4+
Pj4ga2VybmVsLWludGVybmFsIGNvbnN0YW50cyBpbnRvIGFuIEFCSS4gSSdtIG5vdCBzdXJlIHRo
YXQncyB3aGF0IHdlDQo+Pj4+IHdhbnQuDQo+Pj4gSSB1bmRlcnN0YW5kIHlvdXIgY29uY2Vybi4N
Cj4+PiBJIGNvdWxkIHJlc3BpbiBpdCB0byBleHBvcnQgdGhlIG5hbWVzIG9mIHRoZSBhY3RpdmUg
cXVpcmtzDQo+Pj4gcmF0aGVyIHRoYW4gdGhlIHJhdyBiaXRtYXNrLCBpZiB0aGVyZSBpcyBhbiBp
bnRlcmVzdCBpbiBoYXZpbmcNCj4+PiB0aGlzIGZlYXR1cmUuDQo+Pj4NCj4+PiBNYXVyaXppbw0K
Pj4+DQo+PiBxdWVzdGlvbiBoZXJlOiBkbyB3ZSBuZWVkIHRvIGNhcmUgYWJvdXQgc29tZSBraW5k
IG9mIHNlY3VyaXR5IGJlZm9yZSB3ZQ0KPj4gZXhwb3NlIGNvbnRyb2xsZXIgaW5mb3JtYXRpb24g
dGhhdCBpcyBpbnRlcm5hbCB0byB0aGUgZHJpdmVyID8NCj4+IENBUF9TWVNfQURNSU4gPyAtY2sN
Cj4gSU1PIEkgZG9uJ3QgdGhpbmsgaXQncyBhbiBpbmZvcm1hdGlvbiB0aGF0IG5lZWRzIHRvIGJl
IGhpZGRlbi4NCj4gQWZ0ZXIgYWxsLCBhbnkgdXNlciBjb3VsZCBydW4gImxzY3BpIC1ubiIsIGdl
dCB0aGUgdmVuZG9yIGFuZCBkZXZpY2UNCj4gaWQgYW5kIGNyb3NzLXJlZmVyZW5jZSB0aGVtIHdp
dGggdGhlIHBjaSB0YWJsZSBpbiB0aGUgc291cmNlIGNvZGUNCj4gdG8gZ2V0IHRoZSBlbmFibGVk
IHF1aXJrcywgdGhpcyBzeXNmcyBlbnRyeSB3b3VsZCBqdXN0IG1ha2UgaXQgZmFzdGVyLg0KPg0K
PiBNYXVyaXppbw0KDQpZZXMgaXQgaXMgZGVmaW5pdGVseSB1c2VmdWwgYWZ0ZXIgb25seSBkZWNv
ZGluZyA6LQ0KDQpsaW51eC1ibG9jayAoZm9yLW5leHQpICMgY2F0IC9zeXMvY2xhc3MvbnZtZS9u
dm1lMC9xdWlya3MNCjB4MDAwMDAwMDAwMDA0MDAwMA0KDQpBY3RpdmUgcXVpcmtzOg0KICAgQk9H
VVNfTklEDQpsaW51eC1ibG9jayAoZm9yLW5leHQpICMNCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KaW5kZXggYzkxNjE3
NmJkOWYwLi4xYjlhZDgxOGIxMmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2ku
Yw0KKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCkBAIC0yNDk3LDYgKzI0OTcsODAgQEAg
c3RhdGljIHNzaXplX3QgY21ic3pfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLA0KICB9DQogIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhjbWJzeik7
DQogIA0KK3N0YXRpYyBpbnQgbnZtZV9nZXRfcXVpcmtzX3N0cmluZyh1bnNpZ25lZCBsb25nIHF1
aXJrcywgY2hhciAqYnVmLCBzaXplX3QgYnVmX2xlbikNCit7DQorCXNpemVfdCBsZW4gPSAwOw0K
Kw0KKwlpZiAoIXF1aXJrcykgew0KKwkJbGVuID0gc2NucHJpbnRmKGJ1ZiwgYnVmX2xlbiwgIk5v
IHF1aXJrcyBlbmFibGVkXG4iKTsNCisJCXJldHVybiBsZW47DQorCX0NCisNCisJbGVuICs9IHNj
bnByaW50ZihidWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICJBY3RpdmUgcXVpcmtzOlxuIik7DQor
DQorCWlmIChxdWlya3MgJiBOVk1FX1FVSVJLX1NUUklQRV9TSVpFKQ0KKwkJbGVuICs9IHNjbnBy
aW50ZihidWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIFNUUklQRV9TSVpFXG4iKTsNCisJaWYg
KHF1aXJrcyAmIE5WTUVfUVVJUktfSURFTlRJRllfQ05TKQ0KKwkJbGVuICs9IHNjbnByaW50Zihi
dWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIElERU5USUZZX0NOU1xuIik7DQorCWlmIChxdWly
a3MgJiBOVk1FX1FVSVJLX0RFQUxMT0NBVEVfWkVST0VTKQ0KKwkJbGVuICs9IHNjbnByaW50Zihi
dWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIERFQUxMT0NBVEVfWkVST0VTXG4iKTsNCisJaWYg
KHF1aXJrcyAmIE5WTUVfUVVJUktfREVMQVlfQkVGT1JFX0NIS19SRFkpDQorCQlsZW4gKz0gc2Nu
cHJpbnRmKGJ1ZiArIGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgREVMQVlfQkVGT1JFX0NIS19SRFlc
biIpOw0KKwlpZiAocXVpcmtzICYgTlZNRV9RVUlSS19OT19BUFNUKQ0KKwkJbGVuICs9IHNjbnBy
aW50ZihidWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIE5PX0FQU1RcbiIpOw0KKwlpZiAocXVp
cmtzICYgTlZNRV9RVUlSS19OT19ERUVQRVNUX1BTKQ0KKwkJbGVuICs9IHNjbnByaW50ZihidWYg
KyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIE5PX0RFRVBFU1RfUFNcbiIpOw0KKwlpZiAocXVpcmtz
ICYgTlZNRV9RVUlSS19RREVQVEhfT05FKQ0KKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4s
IGJ1Zl9sZW4gLSBsZW4sICIgIFFERVBUSF9PTkVcbiIpOw0KKwlpZiAocXVpcmtzICYgTlZNRV9R
VUlSS19NRURJVU1fUFJJT19TUSkNCisJCWxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBidWZf
bGVuIC0gbGVuLCAiICBNRURJVU1fUFJJT19TUVxuIik7DQorCWlmIChxdWlya3MgJiBOVk1FX1FV
SVJLX0lHTk9SRV9ERVZfU1VCTlFOKQ0KKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIGJ1
Zl9sZW4gLSBsZW4sICIgIElHTk9SRV9ERVZfU1VCTlFOXG4iKTsNCisJaWYgKHF1aXJrcyAmIE5W
TUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMpDQorCQlsZW4gKz0gc2NucHJpbnRmKGJ1ZiAr
IGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgRElTQUJMRV9XUklURV9aRVJPRVNcbiIpOw0KKwlpZiAo
cXVpcmtzICYgTlZNRV9RVUlSS19TSU1QTEVfU1VTUEVORCkNCisJCWxlbiArPSBzY25wcmludGYo
YnVmICsgbGVuLCBidWZfbGVuIC0gbGVuLCAiICBTSU1QTEVfU1VTUEVORFxuIik7DQorCWlmIChx
dWlya3MgJiBOVk1FX1FVSVJLX1NJTkdMRV9WRUNUT1IpDQorCQlsZW4gKz0gc2NucHJpbnRmKGJ1
ZiArIGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgU0lOR0xFX1ZFQ1RPUlxuIik7DQorCWlmIChxdWly
a3MgJiBOVk1FX1FVSVJLXzEyOF9CWVRFU19TUUVTKQ0KKwkJbGVuICs9IHNjbnByaW50ZihidWYg
KyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIDEyOF9CWVRFU19TUUVTXG4iKTsNCisJaWYgKHF1aXJr
cyAmIE5WTUVfUVVJUktfU0hBUkVEX1RBR1MpDQorCQlsZW4gKz0gc2NucHJpbnRmKGJ1ZiArIGxl
biwgYnVmX2xlbiAtIGxlbiwgIiAgU0hBUkVEX1RBR1NcbiIpOw0KKwlpZiAocXVpcmtzICYgTlZN
RV9RVUlSS19OT19URU1QX1RIUkVTSF9DSEFOR0UpDQorCQlsZW4gKz0gc2NucHJpbnRmKGJ1ZiAr
IGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgTk9fVEVNUF9USFJFU0hfQ0hBTkdFXG4iKTsNCisJaWYg
KHF1aXJrcyAmIE5WTUVfUVVJUktfTk9fTlNfREVTQ19MSVNUKQ0KKwkJbGVuICs9IHNjbnByaW50
ZihidWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIE5PX05TX0RFU0NfTElTVFxuIik7DQorCWlm
IChxdWlya3MgJiBOVk1FX1FVSVJLX0RNQV9BRERSRVNTX0JJVFNfNDgpDQorCQlsZW4gKz0gc2Nu
cHJpbnRmKGJ1ZiArIGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgRE1BX0FERFJFU1NfQklUU180OFxu
Iik7DQorCWlmIChxdWlya3MgJiBOVk1FX1FVSVJLX1NLSVBfQ0lEX0dFTikNCisJCWxlbiArPSBz
Y25wcmludGYoYnVmICsgbGVuLCBidWZfbGVuIC0gbGVuLCAiICBTS0lQX0NJRF9HRU5cbiIpOw0K
KwlpZiAocXVpcmtzICYgTlZNRV9RVUlSS19CT0dVU19OSUQpDQorCQlsZW4gKz0gc2NucHJpbnRm
KGJ1ZiArIGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgQk9HVVNfTklEXG4iKTsNCisJaWYgKHF1aXJr
cyAmIE5WTUVfUVVJUktfTk9fU0VDT05EQVJZX1RFTVBfVEhSRVNIKQ0KKwkJbGVuICs9IHNjbnBy
aW50ZihidWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIE5PX1NFQ09OREFSWV9URU1QX1RIUkVT
SFxuIik7DQorCWlmIChxdWlya3MgJiBOVk1FX1FVSVJLX0ZPUkNFX05PX1NJTVBMRV9TVVNQRU5E
KQ0KKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgIEZPUkNF
X05PX1NJTVBMRV9TVVNQRU5EXG4iKTsNCisJaWYgKHF1aXJrcyAmIE5WTUVfUVVJUktfQlJPS0VO
X01TSSkNCisJCWxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBidWZfbGVuIC0gbGVuLCAiICBC
Uk9LRU5fTVNJXG4iKTsNCisJaWYgKHF1aXJrcyAmIE5WTUVfUVVJUktfRE1BUE9PTF9BTElHTl81
MTIpDQorCQlsZW4gKz0gc2NucHJpbnRmKGJ1ZiArIGxlbiwgYnVmX2xlbiAtIGxlbiwgIiAgRE1B
UE9PTF9BTElHTl81MTJcbiIpOw0KKw0KKwlyZXR1cm4gbGVuOw0KK30NCisNCitzdGF0aWMgc3Np
emVfdCBxdWlya3Nfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KKwkJCSAgIGNoYXIgKmJ1ZikNCit7DQorCXN0cnVjdCBudm1lX2RldiAqbmRl
diA9IHRvX252bWVfZGV2KGRldl9nZXRfZHJ2ZGF0YShkZXYpKTsNCisJaW50IGxlbjsNCisNCisJ
bGVuID0gc3lzZnNfZW1pdChidWYsICIweCUwMTZseFxuXG4iLCBuZGV2LT5jdHJsLnF1aXJrcyk7
DQorCWxlbiArPSBudm1lX2dldF9xdWlya3Nfc3RyaW5nKG5kZXYtPmN0cmwucXVpcmtzLCBidWYg
KyBsZW4sIFBBR0VfU0laRSAtIGxlbik7DQorDQorCXJldHVybiBsZW47DQorfQ0KK3N0YXRpYyBE
RVZJQ0VfQVRUUl9STyhxdWlya3MpOw0KKw0KICBzdGF0aWMgc3NpemVfdCBobWJfc2hvdyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KICAJCQljaGFy
ICpidWYpDQogIHsNCkBAIC0yNTU3LDYgKzI2MzEsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0
ZSAqbnZtZV9wY2lfYXR0cnNbXSA9IHsNCiAgCSZkZXZfYXR0cl9jbWJsb2MuYXR0ciwNCiAgCSZk
ZXZfYXR0cl9jbWJzei5hdHRyLA0KICAJJmRldl9hdHRyX2htYi5hdHRyLA0KKwkmZGV2X2F0dHJf
cXVpcmtzLmF0dHIsDQogIAlOVUxMLA0KICB9Ow0KICANCi0tIA0KMi40MC4wDQoNCg0K

