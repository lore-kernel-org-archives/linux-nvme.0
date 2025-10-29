Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1125FCCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 05:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxGO9KZ7mCpJ6cfolHH41GCF2E7mey9E3fR5ywN6n+s=; b=d8i1dxE6/vdrFj6GEWS2zS+Zkx
	j4XqZwEJnODOXwNzWmFmvRRxHQBPWnFxqWfHRY2ENFOrCL9PmpRFwK1JkZCcL1Uiz7ntTfuLtHm6U
	goFztnygdYqV0zJOi3JIsjNlB2VvC0ELdJsOzKx1aBa0ehunzlwo+4rWyg3NW+kniq8lhQrySxnMV
	J+UJIxp93eslPtRGGMCAt3u6FIRAoFZmW8Eb2BAS5wXK1Kl/VcIuw+T1kRXcvrw5S/0ibtntJdIHZ
	BrYchz0UTigUmmPjG9lDItDy7x5Dcq1GylP+BCfh+DULkDOEOw9mDdjatHbnwHB5/Lp+TdayipFi2
	dC/K/B/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDz2M-0000000HMjA-3EuG;
	Wed, 29 Oct 2025 05:47:58 +0000
Received: from mail-westusazon11012050.outbound.protection.outlook.com ([52.101.43.50] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDz2K-0000000HMhc-1LwG
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 05:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukayy9d4gip7G0pit+WZf92CidEWfdDnvzGFZ9/gjVV/syzYAMlRWMsEvdZhxuKrlHg+qHeTfa6cRvNsVbbFXFUcMWa1/9LTX7cuL8cr9eb5MKjUMpd/qww6x5VD1avvF2AZwEBtWIsA9WSZid6zBW9sIaljwx7r72lLn+SzwqG3ccXSxlu+FYsrkF8TqvGqH3FP73EAplZzH7t9Cw/0M99OUOB+Y+uVRjPwq+WwteeHpJ3GiDkfTWOW6LPx8N4x1OsDUJ9QwK9Zb8sOC/DlS0nr6TySGFktrq70yCeg1oawU7Hkwf9C+/fLO5S12dTDtYOcOGlBzvYqeKAd30qfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxGO9KZ7mCpJ6cfolHH41GCF2E7mey9E3fR5ywN6n+s=;
 b=uB+46Rfxpmb3Z8ab56XQt+tjHJ3/vsv/Q/7hcGSIEqmwQBFvUEhCZvj+lc8N0OPxNUH4ugr4xFig5LxGugdPUoEICts20ybtGqXvP67LKnmUA1NE21/7AQ1kgKf7qFUG7UOpza/BvnEZPYfpEFL3G3r9WUCTKsRdPwF24aIwp2dtTe8vVkx/FOE+2VORJBqXYlyS7flT+8xLAoN8+7emZZFCGY1D4ePfcRjEHLXYtl3p0+r3aITdGoKVAXMlZZXqV+cmbIAaTVVHMqAV3NkyjDm2f+MqIKbh6p7fBudH9kyOdeX4TrewTIckdWejwGglTmpzyvRt9Wyx2JP8NislbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxGO9KZ7mCpJ6cfolHH41GCF2E7mey9E3fR5ywN6n+s=;
 b=KU/R+eU0E0NLBuRCfUeyIwLRL4vtvcdgeCuzoaVYVIhfmVzoq5zrgmmBAVm2vT4u29n6qWz5TDXKEV/mjXTdOW97d6Hsu8DvHT7fWH1L67CTTkJkt/60LtE/tvALkSUS+MuONcYB8BBiMQwLzWFF+i74Is9foRMTxjpcPbyFGqDaNDJuZdGUoULQRS2VtsXHL3+8ScSqGd3Qf2KfUyqvWZv8OLK9LVQmkQDXwBqm/R3Zsg+o7BUc7/mX6RntAdfkf8qphrc0ySwc+TRBWGo+q7kfLq3b+UAY7sNAvyshfxF9x9RenVf8HePgA/SzpiMdIDb4sGXtAjXggaNcGkrrFw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 05:47:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 05:47:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>, Bart Van Assche
	<bvanassche@acm.org>, Maurizio Lombardi <mlombard@redhat.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>
CC: "bgurney@redhat.com" <bgurney@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
Thread-Topic: [PATCH] nvme-pci: expose active quirks in sysfs
Thread-Index: AQHcSBeS/Wfpc7fZOkySrLZKHYolZrTXwNeAgAAHrQCAANZrAA==
Date: Wed, 29 Oct 2025 05:47:50 +0000
Message-ID: <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
 <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
In-Reply-To: <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB9192:EE_
x-ms-office365-filtering-correlation-id: bbfc406f-25ef-49d0-0cc7-08de16aeb270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eWkvSGFvWkQ3UDNBWkxnc1ZwRTAySW16U3NnMk1GMlduRldsR2hHZHRhWkxa?=
 =?utf-8?B?UC9XM2JSSHREWTRicWZDcXJ4dGRLVHgxSnFGY1VKUzNLSndjL2pzSUZxcWh0?=
 =?utf-8?B?U2prQ1JRZ3o5eGE1aWVLU3ZtbC94RjE4L2g4TU13aUhycmlqajVacUZDOFoz?=
 =?utf-8?B?bnU2aTQvMjhvSnVRWXhEWUhoS1VQNG5tb3ZFUFlKelR4dVJ5ZTM2VXE2cFo5?=
 =?utf-8?B?aDJIWVI5UVJkMnBBU3FIemNLSWxTUnNUcDlvUW9OUFErRlFaa0U4MWhMV3dM?=
 =?utf-8?B?RFUwN09rMTR3VVEvcWxZUS91S2VRU1FSR3FrODJDR2g3VW1xbUdUd1YzaVBP?=
 =?utf-8?B?dVBDaTVucC9POXVvanduTFd1UnVMNmpUR2Jsems0UjhiR3U2MEFNQ2MyOXBy?=
 =?utf-8?B?TWFjcFVNejdOTEZsSkliVnJlUWgyRmFtTlZyWDlOK1RCWHJYbUlYYnBtaWU3?=
 =?utf-8?B?Wk16Nlg4Qkg3MHRiWlRYQ3Vkc1VuWnhhaFdUcXNsQlF3RnhHQXBuNGdSK2Zz?=
 =?utf-8?B?bktiRm5BQ1o5bmFIaFdiRlZaOHhSeTQ0TEJtMldUSG8vdVMzZHVCUmpHMC82?=
 =?utf-8?B?S1FmdStEZUJIVUFVNzE4c0Y0enp6eTJuTXpJcW9Ec2N6RkpXOWZ0REIrZXNS?=
 =?utf-8?B?VzdsdkI5QytpSDcvQzVPdFNpZzJ2aWtSVTFwR2RsUHBGdzJSbjFPRUpBMWRq?=
 =?utf-8?B?WkFxckNhc0ZnVVNoazJDUnlwTXh0bmNzeGxGUnFFdlhjSWhhZ3pER1YvalIz?=
 =?utf-8?B?cDRyWTA4K2YvMDRXeWtVc0JXY0VsWUFGd3N5SUoyUGtWSUFlV2pvVUt3c3E1?=
 =?utf-8?B?N0hTcjFLbGdrbWZ3ckUwL3VUT2J4WElDd1RaRmFkeFhWcUk0VWczY1k1TjNW?=
 =?utf-8?B?d1pZQkRnbUhXYnh2Z3hrV1Q4QkNkN1RrM2tpMW4rdDlUT1FyMzQvL1hkVUtl?=
 =?utf-8?B?ZlEyd09EL0V0WVFoZk1reE0rVVNoK09SQUozN25ZVXQwbVBMSWhsMjhnMzlw?=
 =?utf-8?B?ZGhJYWc4QlJMZWEyME9QT3dZeDJzejBicjg1Y1BKMCtoY3d1UHJCNXljWi8r?=
 =?utf-8?B?VzJLYmxHUHdyQWNiNy9Wd2QvcUlCNEkyTDBqNEd1ME9LL2wvQVdQcThxN2pm?=
 =?utf-8?B?THVaek5mdGZzQTEzRUNaOENWZWxmdzgwWisxZ0NpSHdvakk4d0lGYmhPYXJV?=
 =?utf-8?B?L1R6Y2JZOWoxMHpaanNvY0lsWjBhUi9nOUFRZGo4RjQ3RHQxVXhyMlkxNFhV?=
 =?utf-8?B?WlA2ckJUT0dpUkk4dnUyR3dNUGU2bWtscEdia0kyalk1Y1pYZkw0Z1NaNm5S?=
 =?utf-8?B?N3hhcTdPNW05YkNJMlpJbjBqY3F3bkJtaFlEeVo2MFJFbGIwT2cxVENNYXpS?=
 =?utf-8?B?K1hZMElmU1dOeG51dUt6MnZwajJDVUoxc0NtR1FyV2xWeThsWXBrYWVrWDJY?=
 =?utf-8?B?RWF6UjYwSU5NN0RXQmpvTWsvU3dSVktsNU5rY1l0WVFmN3ZFdVk4V25vcUIw?=
 =?utf-8?B?d3B3UTVlbzBKUHpWc0FrczZDTFI1QmZBS1E5REM4OHF4em1kYXhBRm1hOU1T?=
 =?utf-8?B?ZUpWdVFweVo2QUtjSkRWemJVSTlyTGJCUzU0MnROdXlTcGNITEU1L2RMdU03?=
 =?utf-8?B?dHBmTFNORGRZUkZGb04zMEN2K1Y0OUU3bjJyUnpzelFKenp4NDBwM2Y2NFJ6?=
 =?utf-8?B?T2hON2dBajE2cVFVcXdTVnJYUlVaNW9IdkwxZjdjeW96TjVZQU1qTFhUOTM3?=
 =?utf-8?B?c3pBNTUxbjJ1SGVIYnhQMEUwdFlwckxSaUEyUnlDSUZnajBNcFV1WXQ1RjBp?=
 =?utf-8?B?ZEdpN0ZqdDRLKzA3eVJ2Y21nZHNOcWh0aytITUVEU1dFVHBBVk5oR1FLSm9N?=
 =?utf-8?B?aGd0bXVEdkJhZWNlbTJtSGc2MmZ6OWxsTCsxdDZBbUVoUi9hZU9wbG1YWHUr?=
 =?utf-8?B?b3hGeWtPZE9nR1E2WVYrbnJ6YTRtOEVYRlIyTkRDWVNDOEVsYW1GVVZOaXlC?=
 =?utf-8?B?aGsvU3FzTXA0b1pyR29xU2U3czd3a2Fpd3dONzhRV1FGTFNEVE0vWXZRUUhY?=
 =?utf-8?Q?so0Z53?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkN1VkxmczhmNUdxL3MxV1RqZWQ1dUNVcmN3Q3FBdkJGcG5SdnFhTk9Ma1cr?=
 =?utf-8?B?bXNpYlQ5VHp4d2V5aUtscFlqQzl2TjEyUkNTMTlhUTMvT1lsaWNNekFuYnFa?=
 =?utf-8?B?NkJ4S0hxNkV2NlVONit2L1pDOXdDWHYxS0U5MG9sTk84eDg3OWgvVUhkYi90?=
 =?utf-8?B?RnFWSWJRYTFxM0NyWEVhcmsrWG41MlZRdjNibTJmUG9BRUxqVGMvejN4QmZ4?=
 =?utf-8?B?WVBUY3RzUmZzQmt0MGU0eEc5WFV3SDVvZFM3SmNGNVllUnJ1VHVKR2VUczc0?=
 =?utf-8?B?NzhlbVZEZTA0blZycXU1aDZ0NzFPS1lpS0VIWDJVQXdpbGM4MFBIN3FleFZJ?=
 =?utf-8?B?RVFTMTI2VXJGSXZoczFlWStYZ0hRM2Jxbkg4MkVIbG9HbVdEZGNTYW1vU0Za?=
 =?utf-8?B?a1k5VndGcG9oek5qTlRjeTQrSzYyUGtkbWpQZjNFTHpiVkZHMkVrLytWSE5k?=
 =?utf-8?B?bjJpNExndldITXNYazBJa1JZdXkydldsRDB5UzN1RHcvOHZOeHpjU3dFTXBq?=
 =?utf-8?B?eUlCaEtmeXJVUms2eHc1NUhhVGw5U3VlTFJBS0NnUDJiNEVxZVJrYTVsNHd2?=
 =?utf-8?B?MlE1elBtb0FTOXA1eHI0V3dJMmlyNzd3V2o3Zk1PcnA4N0Z0QTZ3T0J2elpi?=
 =?utf-8?B?dENjN0Y4aVJ2VkR1WFYzemdwNEdjeFlXUFdtNlFHR2RFYURsZXFYSFV6L254?=
 =?utf-8?B?MG1SV0R0NXNSbDRVbEQ2bkdPOWNicUIrV3dCQXl4YjZXZHcyVzlmcWlpdFlI?=
 =?utf-8?B?bFU4aGJmMm8rTnBDTVNCczQ5UXhPR0RyUzB3Q0EwZExPRGwrdlFCaVZNZEt0?=
 =?utf-8?B?WW82T0h3RVEwcXNOeFR2RXFHejBpUDhWSWE0L2R0YTdWSWhZblJUUUNnc1h3?=
 =?utf-8?B?Ukh5cCtqMnFuTkFMaWhhdDRHT1BNWkV2bFZ1clRCNnBEemxLZlF3dzlVS2ZF?=
 =?utf-8?B?cmtjSkQ1NmNNOGdqbzhiQ08rOHNua2MwN0Fud2JhdFFoMGJKMUljZHNOMlVH?=
 =?utf-8?B?VEZmdlN5SlBQd3NqYWsrNElrS1ozY2JhN1dTZEVYYkRTenpRYlFENVo4RHFE?=
 =?utf-8?B?TllWRENNN3hPMTErVTZoMVJ5UldJRTBKZG05OFZKTmVpT1ArUHlLeXd6TDRM?=
 =?utf-8?B?WWNTbzMxSjFUdVEvT3JxSllwQ0d3VktiL2JRM0lLWHh6dzJFWkVVQWNxcVVO?=
 =?utf-8?B?cE82VnI3V3ZYVUtxOUxqOWkvejNRa2dNYmpibDUxd2pvREp1L0p5QmUwWnJR?=
 =?utf-8?B?VzdweTlVZWZYZkRSdFhzZGhabEZNQ2I4dGlpRGFJaHVSeWhMMTVPcFdvZklk?=
 =?utf-8?B?NTlGVlN1emZnbWhzZksxUWxtQlhualk3K0ZrbGJxcmZqZU9FSXVHck8rdFFX?=
 =?utf-8?B?M1RTUXlKNmFyRFM0S2haelRZTDdtRU1FcGRIZHJRQ1JETGJKK3NQTzFRRSsz?=
 =?utf-8?B?V0U3S3hpdERaVXhDaENJZ2NNNVRoL2hRdEtSUjJuMk5KMnlNdkhjanNpR25z?=
 =?utf-8?B?MzBCZjdzRUxpb3ZyN0YvbmVzYlhBOVZBQ25zUXhPR1o0bkJRMjFVbnUwR3Y0?=
 =?utf-8?B?UmdCcUxxdFhxejFaNFoxdCtLS3pySUhpYktlTnlEV3VPUEQxaHJQS1NHaWky?=
 =?utf-8?B?ckNnTHNBb0hoR1hzWlNtZXEzUVdybmtnaEduY0ViMXZSbG5wTk9ld1g5K2ZP?=
 =?utf-8?B?dmVIaWVUdGhWMzRoaFZvcHRDV2pWaCtkNGxpWFN3NFY1ZGZ2MkRWSEEvVEpl?=
 =?utf-8?B?RTMxNEk2Ujd3SkptbEF0bnUvaXp6ZTJseTFDOGN3dTRESUJtdDV6cHpOTzNF?=
 =?utf-8?B?UlFKSlp2Q01McXQ1RjU1WFZOMVBUeEdqbnRsd0ExS1ROMmU0V0FtcE5veGUw?=
 =?utf-8?B?Ym05K1QydVVDaHM5dTVnZ0Q5Znd1YTZvWnZlQkhGVU1wbGhBbWRSQ29ZYXJO?=
 =?utf-8?B?OXJIU0tJbGJ1cGJlTlhSSElYNG9BajN5WWFyclo4cCtDejBZcUVLdFpPQU9P?=
 =?utf-8?B?T05pdU5aMVhPWE1tdzZyRGQ0RERJZ1VhaEdnMXdOTVFYOHBHYjUwd2pFSmsw?=
 =?utf-8?B?QjZpYm8wWkdaRXJsRXpaTVBoTUlha1dJaDlHUkF2eEwrSjlZWFpZbXorODNJ?=
 =?utf-8?B?QXQweDdrTTVVTnplSmxlUjgzaitRTm55S1JiTVNtWHZzaGYzTk9zNVMxbVZ6?=
 =?utf-8?Q?7f3IiK1Dq79W9cR5zDGpCWNPWKxrHYyCAb1NfKHzuAln?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E2AAB8248025847A45EE34FC5634FF1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfc406f-25ef-49d0-0cc7-08de16aeb270
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 05:47:50.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYtdCxfQ1XwGmrWzSq4IgWHOSuAma7VwN2UOGGdSwgcGwLCbX+JhVIyfymCLUlACK7D919dACbD5yz7Ek+Lcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_224756_377515_B6D7EFBB 
X-CRM114-Status: GOOD (  14.64  )
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

T24gMTAvMjgvMjUgMTA6MDAsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBPbiBUdWUgT2N0
IDI4LCAyMDI1IGF0IDU6MzIgUE0gQ0VULCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+PiBPbiAx
MC8yOC8yNSA3OjI5IEFNLCBNYXVyaXppbyBMb21iYXJkaSB3cm90ZToNCj4+PiBDdXJyZW50bHks
IHRoZXJlIGlzIG5vIHN0cmFpZ2h0Zm9yd2FyZCB3YXkgZm9yIGEgdXNlciB0byBpbnNwZWN0DQo+
Pj4gdGhlIHF1aXJrcyB2YWx1ZSBmcm9tIHVzZXJzcGFjZS4NCj4+PiBBZGQgYSBuZXcgcmVhZC1v
bmx5IHN5c2ZzIGF0dHJpYnV0ZSAicXVpcmtzIjsNCj4+PiByZWFkaW5nIHRoaXMgZmlsZSB3aWxs
IGRpc3BsYXkgdGhlIGhleGFkZWNpbWFsDQo+Pj4gdmFsdWUgb2YgdGhlIGN0cmwtPnF1aXJrcyBi
aXRtYXNrIGZvciB0aGUgZ2l2ZW4gTlZNZSBkZXZpY2UuDQo+PiBUaGlzIHBhdGNoIGNoYW5nZXMg
dGhlIGNvbnN0YW50cyBpbiBlbnVtIG52bWVfcXVpcmtzIGZyb20NCj4+IGtlcm5lbC1pbnRlcm5h
bCBjb25zdGFudHMgaW50byBhbiBBQkkuIEknbSBub3Qgc3VyZSB0aGF0J3Mgd2hhdCB3ZQ0KPj4g
d2FudC4NCj4gSSB1bmRlcnN0YW5kIHlvdXIgY29uY2Vybi4NCj4gSSBjb3VsZCByZXNwaW4gaXQg
dG8gZXhwb3J0IHRoZSBuYW1lcyBvZiB0aGUgYWN0aXZlIHF1aXJrcw0KPiByYXRoZXIgdGhhbiB0
aGUgcmF3IGJpdG1hc2ssIGlmIHRoZXJlIGlzIGFuIGludGVyZXN0IGluIGhhdmluZw0KPiB0aGlz
IGZlYXR1cmUuDQo+DQo+IE1hdXJpemlvDQo+DQpxdWVzdGlvbiBoZXJlOiBkbyB3ZSBuZWVkIHRv
IGNhcmUgYWJvdXQgc29tZSBraW5kIG9mIHNlY3VyaXR5IGJlZm9yZSB3ZSANCmV4cG9zZSBjb250
cm9sbGVyIGluZm9ybWF0aW9uIHRoYXQgaXMgaW50ZXJuYWwgdG8gdGhlIGRyaXZlciA/IA0KQ0FQ
X1NZU19BRE1JTiA/IC1jaw0KDQo=

