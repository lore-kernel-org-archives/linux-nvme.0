Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CFDCCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 02:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXb0SUr5b2TdWrcbiXNfJhkQOL7EJngQcjwKklI3Z7w=; b=QrYl31hsSBPKDSLivbxlFiDlTG
	N5X0upRxMkv26vzdk6TlZy9kPZg0OUJYbjydmwOzBth0q4I5q1PE1bdmM6xX8YaVvLReTkpWw4K2y
	QS15/i6j43EWyaNIKWZ0VvJIwBi8kuSp+pspuPjUj66j/4NnFOvwVmX1szhef0jfH+eb/o5Eey4SS
	1durnsYR0t51NEyYoU7sdLJe82sy5PgxNZ0UFRcxvb8c34TNiraJT3UD8IJ1bBH12qYjkqytGm+pa
	zhJFEoHa7yNMQ2dDbcAzOYjKTfmyp688sJRnbHBlB9s8BEEGjH9/2yitaUhtfuo7f3FaAHU0/kvxQ
	bkKn/u7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqDC-0000000EnIA-01SI;
	Thu, 06 Nov 2025 02:58:58 +0000
Received: from mail-southcentralusazon11011059.outbound.protection.outlook.com ([40.93.194.59] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqD9-0000000EnHl-1wYn
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 02:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMPc6Yk2f8PRqLwIX/LPkx0UXwFur6lagTRq337X/jtSjKr6gmf4aee4d5n4SvFcjIrqDzsoyo5rIEyMgfTsUlQM1zSSjmMJbKSMPSouJxnK9xi1AmJFzZCEF7PgVB1sR150JauilqB2CTBDRPdXs7+zJIBxhvoVxRuVveHmZ8Fooz0vOuJFFWzEazQDzTGnCnWhYiTDvTrFXVSqhOlewadQayIYSKq7r3XIxOxuu4wviUA8VzuXiRWogulcSSe9dlySJZMCgxwCFRYLaSgSZYX7tdqZJ0U+rtDuY9CJJSqrBdLejzzCgu31b+199kJty4F++i4slj8K4QcEmgelaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXb0SUr5b2TdWrcbiXNfJhkQOL7EJngQcjwKklI3Z7w=;
 b=ScjtN1v5z24vFROkk/E7RJIgsphiBObMOpR4G5YJRUviK17yHbvvhORKmlKbT+7rHmrbrW0QLKMDc11uaurlKgSbg9pgRea+RYt24r8A0uIRo+rlscsUZmXQI07j2cRZGEWRDEjKo5eNHvG49PFiNOGCovWUovzd+XN2MdSOWUQnT0q67FP8bf/gHhq2iiwxA/PllzjRHeQjh2ugLaeB5whwvqjb5y8vSn9vOQyTfdpx0y7DYDYLW+w+pSnyVgBNBwoMqiLUBb+dDILEGdru/mIbRfBan/xL2JxZosPqszDusII9jTG/SPxk1SgRqsn6mfFlWnmsqDYM8xsMMNPlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXb0SUr5b2TdWrcbiXNfJhkQOL7EJngQcjwKklI3Z7w=;
 b=GyeuLdQ0WOg1nx9Qtl2q+XyBy/Spu/gennEbz5Ot5CctsiuZ/crWh0EyrXuEXVFQB3R6GVmwpwGudNC1UxU5vFqZvBCsIDjkDSVPIVsP3wRyNCk+oo0LL8X+c/LKwvZw+GUywMVR0Oe1BqWlhYFJypZEiL1a9BIE5ZzzwoY5O/oeoHe7XeEl/K9qXjIKIhcevE1OpSYYX8bwbEiVQcDym6cB555JOO1LVuZ2G5Xt9kfmlpTln7w350BDcn35E/HnpgakXYAQB4CFQCiEj3yvRnwOmSLC+N5tp/SoteTZUehz8JX3cnKPgmOtgZ1QYHaFH3MbpNNbq63wtVA+IK2n7w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 02:58:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 02:58:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Topic: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Index: AQHcTWHrDheTX3CfYEy0GSlVBKKEm7TiUwYAgAKjioCAAAE3AA==
Date: Thu, 6 Nov 2025 02:58:48 +0000
Message-ID: <552ca2e6-bfd3-4541-a39f-9c454db8370f@nvidia.com>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
 <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de> <aQwN428CyJXeOjRB@kbusch-mbp>
In-Reply-To: <aQwN428CyJXeOjRB@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6204:EE_
x-ms-office365-filtering-correlation-id: e816ffc1-8c6a-4173-52c3-08de1ce068d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHovcEh1cldKRHg1LzVNeUVwR25YQ1V1SCtnMCsyUHJldFZnZVRMM3BJNnNK?=
 =?utf-8?B?LytqZENtbzhRVWMvb3NlL3VnS0tRQlhOdjRBc1lha0Y2UmZ1MlFsNVVUVlEr?=
 =?utf-8?B?dVBvQ09vMTZWdG55ZWJ6U0lHK3VRdUpJT0hTcGJwMlR3ME5JTkxCQS94a1hI?=
 =?utf-8?B?ajlOdWxNWkJ3UnJaMGl3ZHZPRXVvbkFOQnBtUHAvZWU4UmRCblBwVlJmaXNl?=
 =?utf-8?B?RHAwWFF2STRIM0FVMXdjVGg2RnBGSktDb2ZnTzVONUduV29iWm0xby9SZ3Bn?=
 =?utf-8?B?ZGhpZmxtQU93c3o2YXdNNk1XelBNRGNFZ1l5LzV5SENab1hQcHRXSGRHbWgv?=
 =?utf-8?B?ZW5GN1RPWHUrQmZLb3owa0R1MkpEZFNFd0JzdkpxVllOK0R4QXZiL09vMzVx?=
 =?utf-8?B?dDl0czYzK1pwTDhsaFNwVEp4Vk9qZ2dZTlRHRVJjMld4Sk15cWoyUWkzeEo1?=
 =?utf-8?B?QW4za0VWVk1sM1BhYnRBRHFqQ3Y2NE9aeWZBYTZLRUZkbVZtMThkcCtwQmhV?=
 =?utf-8?B?QUlOQitvUTh4Yy9CcUJLMUs1MzFFL29pTFBtZ2pVNjhwUXI2Vm1KUnVNZDdQ?=
 =?utf-8?B?MDRabnE0aVRCclk2QlRSVThMZG93ZHg1d1V2S0NOVGpHSS9xU21uYktHVDYx?=
 =?utf-8?B?U1F5ckd6cEJDbTNCOE9ISG1jQ0R2YkRhZkZFODNHMlhndWFXcXF2VStSbVZ4?=
 =?utf-8?B?QVV1R2tZR296aThnb1BIZktqMnlSa2RKcE02MW40enhmcVZZVnJVTjc1VWgy?=
 =?utf-8?B?Sm1zcTFHSUg5WjRhUDNycE8zUVhSM0I4bFNmZWpiSGROK2VPZjRNUnNLelpE?=
 =?utf-8?B?d3JSM0I5dVhhTkFxZXBxS1NmZDVPZTJFanpHMEF4MTFDeFFoNDA1NEp5NlZN?=
 =?utf-8?B?RXRIcDdDNkRZTHNDQ3lLcmlvQVZLcDV4amRzRzZXb1k0R1pWa3l4SVBEVk12?=
 =?utf-8?B?Tm5xR3ExSEk0VjF6V1dMa0ZTQm1XRCtCSk1tQVovNWxrYVI3TnFxMys4RmVl?=
 =?utf-8?B?TTBZdjQycDdOWmJHSCtjRlN3eVY4VDdIK21HYUl1S1Iyckx1N3NUVDBjb05O?=
 =?utf-8?B?aGUxR3hoN3Y5VXhjOWlhMkJnTEZFSUljOHdjRjNCSG9ISWNHMVQ1MWFuUWNh?=
 =?utf-8?B?TWVoMGJZY1pIeU9HTmliVEFDUC95cGl0NzdjaVd4cnkzbG16R2R3bVdWbGpp?=
 =?utf-8?B?QTZWLzdaOXBsbXlUYldVb1RIWjg1Y2RhajlrMHFVRmFtcWNCQ215OTJrQ3ho?=
 =?utf-8?B?VW00RG5TR1U3WFFSdC9ncjBzbHpIR1gyNFhTaTR0M3k4NmVFVUFEeFUxSlQ2?=
 =?utf-8?B?YXMzT09CekpKRDRyMldBUmlCQzRFaUcwOWxWUHJqOXh2ZWFEK2xtaFlFTTI0?=
 =?utf-8?B?S25HelA4dDQ0aDduUmIvaDZhNFdwUC9SOU9ZcVU3bUV5eUtld01CWW5EdXk4?=
 =?utf-8?B?ZmJmOWovL3RYZkpwQytvMTRlTSs3TU9QUmh0dnhQMXNYL3lCbEw2Z1dKcWJh?=
 =?utf-8?B?czNVSnJxaEVzakN1Qk1LRXIzYTd5VmFJOUJQUW1JV214cUJRdTJZeVRoaVl5?=
 =?utf-8?B?N0hKUFRqaC9ScUYwWjI5QkFqcWZnenR6b2I5Zkg4d3hIUGZRTE9BcHN1aXZw?=
 =?utf-8?B?cGwzWiszVTBnSkJoSll1RW9IUEpGTG1yU3dET0JuVit4NWhzQWw3cURBZnNh?=
 =?utf-8?B?azBlS1FSYzFaeEwzUFZmUldVYlNGUHdMMnJzTkNlWFZDbHBMdWRoL1AzSWI4?=
 =?utf-8?B?d04vaitYMnlHdTlSY1I2K0hCaTkrVTlXUm1EWEhPSXN1TDUrZzU1b2FqMXIy?=
 =?utf-8?B?N0VTbTI4d2F2NzRJWURRNmhxekNNWk9IbVU0dVRVdTNpaUNvbHFpSXVhQjhD?=
 =?utf-8?B?UDhYaDQxNWxTRDIyYVRYOFQrNTRvb3FIbm45MXNUM1F0dXd6SnJya0M3S2pa?=
 =?utf-8?B?V1RiSVplZkRrMUEwUTJmWFlraFRsNStiY0FzSFI1UFZkQ0V0bXVDdjhXSVlQ?=
 =?utf-8?B?MHRzQ3dOZGdDM2pwMGZOZ2VDTlYrbzVHYVFTS0wxd1VQZDdXdUQ1V3lacU1a?=
 =?utf-8?Q?h6RS+6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUpPSEo0eldacUxTSzhrRHc2R0c2b3dDenFsaTh1Z2kzY1lnQWpsYlRTSUN5?=
 =?utf-8?B?dUkwaHFKeHJqWHpBK3AxUWg0cndyRmZiV2JHOFRnV0dueHVITU5yQUpRTnlV?=
 =?utf-8?B?RkRmWVJTNXV5NG9pOWZNSWZCY0JURU5YRlAvS1FyWWkvVDRkcDc3aVcxUUxJ?=
 =?utf-8?B?SEg5bHdKNGF3T2FiYkJNNkpoVDd2TUhyTlUzSmZvL0hwYXZ2bFZ5d2dkeEg2?=
 =?utf-8?B?TUFLQ2JnSk96RDFYNjAyNXRUbytxdFhMaVhOb0twckFkbFlhaTdxRXRmK2Ux?=
 =?utf-8?B?eFFWdytTbURYQ0VVR2t4TlVkcVRkKyt5UEw1Vng1am80WFdnajNDVnhVbUwx?=
 =?utf-8?B?cnk2VHRCU0VhY2NnK2x1VjRCUFphNWdOQ05KaU9ncVlqRUZubEd4dU9UVnhC?=
 =?utf-8?B?bWJjb0w1MTc0bm5zbHBsdHk1QTB1M0dIcTVhQ0I5RFpkeE9kR29Nazh5UUo5?=
 =?utf-8?B?K3VOMXlLblBYVEhRWGltUW9CQ1BPcmxVckl3UzBmQ0cybEIrQjJtL3FlYlBH?=
 =?utf-8?B?VndydXpidFh6Q0hKMEtlMkJIZ1hvcFplUngrZEdoZzJvT3RmVTBvYkcrZnUw?=
 =?utf-8?B?L2ZQV1c1ci9GK2p4MnovZ01CcnV1UzR6VmpMMDJac2tjamlqeGxNQVVQWm54?=
 =?utf-8?B?UXhibnVpd0k4RUVmaGJUY1VsbnRmdGsxRWplaUNTSVFUa3d3eVQ2ZXhCb3Fs?=
 =?utf-8?B?OU4yRDBMcHZ4Ti9SNzBpWUZpRmZEOEltUnhkZkZxeEphNXdvUmh1RW1FQ3lu?=
 =?utf-8?B?R0ttcGRhYWZBbVJCS1A2cnowYVR3d2tHUnBLbHhhODVhQ3RxUFh3VE9tZCto?=
 =?utf-8?B?R3hnK1ArZDg4RGpXb29QdlVKaXc4dVZaZk5VeEhodFNJeStDK0FZeDZpSzND?=
 =?utf-8?B?MU91NHlpOTRaZk1vcFVzMFdvQU5TaWV6cFlWWHZMNHdueFpjUkNDQVZ3K3FX?=
 =?utf-8?B?aWR3dGlVSE1LbVRDNmNVc21RNzBBRlB0S1k2SkhFeHRhWGM1MnY3ZVpqT3Fy?=
 =?utf-8?B?RGs0WXIyQUJXY2V0QWErOXgxOUZneU8yRXkrcmpnaG1nbC8wQml6S2hha0N1?=
 =?utf-8?B?ZG5XY0RWRnZnM3BsTFQ2dk05SVRUVjN4SGhEYmt0R0RmUWhBaDFicWl4ZnRR?=
 =?utf-8?B?QUVzN0dhVzRCL01LT2JzQ0JhS3V2Wmp2bEY0RVlzTEY4eG4rR0VIVnZQb2Ur?=
 =?utf-8?B?Z1JhbjRTN2xRRTltN09XeS9EQjNiQzRxQkJUMVZ5YVpNRnlnQ0JXWEd1OWlT?=
 =?utf-8?B?K29RQ3hxdGg2WXp6cnp5cHY5RjkwN2RkZlJMNDdoTUtzWnVCclYya0E5NkRw?=
 =?utf-8?B?R3gwMVF3MW9KSjZBSUVLZk11T2l5T2ZNakNqdkkyTlIyclJ0SXdicXYwcHV2?=
 =?utf-8?B?VXhOTVVHb0hEM25ya2M5aERXbmtxUy9TMWpGelg5TEFRNFh1NVNNVUF6NHN2?=
 =?utf-8?B?ZHJYUVBlWmRUazBGZjVKV3lDMk90OHlLWlI3ZVlYUTFnN3J0OTVOSTArd2sw?=
 =?utf-8?B?UGgzZHRaWDI0a2tvL3F3TWpLTUlWZFRkTlcxbjBRbUgycWRacHNBRG81UUpZ?=
 =?utf-8?B?M3oxRktCL2FZck9XbXJFb0t2VWJ2R0dwVE8zTURpeUFlREduVUh1djNSZUdu?=
 =?utf-8?B?SlhNQk9FOGNyY1pxRUNFL2M4Tm82WDR0dWlmVTdjbDgzZnRDNm5hdm9OS3E5?=
 =?utf-8?B?VUhaN25TU2JyR2hyaDJFN3l2WWJmOVhuOGZrZ3h3T0g1YTRHZnZ1SVIrZElF?=
 =?utf-8?B?dmh2VUlLaVFySVRyODNuTy9sZ3BFTGxpcmIxQmpTcHlSQnl5RHZ2Zmo4ZWND?=
 =?utf-8?B?RjNoTENkWFNuRGN3S0RHTVhOOGZkaklxbXg1Um5mZWFWVmFjVHZOVjRQVmRE?=
 =?utf-8?B?clhOT2pxTmZ6ODNKQ2dNZlNldWgyOFVMTjRBc3VYWUtudGxNQWd6NFBGWTls?=
 =?utf-8?B?Ry9WbHY4bjBTeWF4dW0vUEt1Ky92M2svQnVEUXlNeWNEVzVlaVExYU5Bc1g5?=
 =?utf-8?B?SjY4bnZYTUprZDArRTVNY0t0aGpqRXlVVlJXMy9idnVaL282MG1Mck10N2Jt?=
 =?utf-8?B?Sy85RmtvZjdleXhxRkk0NkhGaGVidEFBRG44TnFHZ0lFdmlSUFh5N2tYeEJ4?=
 =?utf-8?B?WUlqaUR0bGJrZ2N6WHdGZ3Z5bFRSQUNUMm5RZHViL1U1bHBadDJsWTAvYk5U?=
 =?utf-8?Q?Zpmyhi7NfeceF/pGUfTKdFuv6tb4ItKSFwxHtQ9afpI3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53F2DAA261375B4A8C3ED4DF35DCCD54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e816ffc1-8c6a-4173-52c3-08de1ce068d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 02:58:48.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gVX++hP1jYd+HcQK2iiPdWDRTawJ8cD1YGo5LuhM06PC3KvnhBoY4fn34NE4NTdNybFY1ceZDHtHFMlyjt3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_185855_501521_899E883B 
X-CRM114-Status: GOOD (  10.77  )
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

T24gMTEvNS8yNSAxODo1NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDA0LCAy
MDI1IGF0IDExOjM2OjM2QU0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4+IFdlIGFs
cmVhZHkgaGF2ZSBhdCBsZWFzdCB0d28gb3RoZXIgbWVtb3J5LWJhY2tlZCBkZXZpY2VzIChicmQs
IG51bGxfYmxrKQ0KPj4gd2hpY2ggc2hvdWxkIGRvIHRoZSBqb2IganVzdCBuaWNlbHkuDQo+IG52
bWV0IGFsc28gc3VwcG9ydHMgZmlsZSBiYWNrZW5kcywgc28gd2UgaGF2ZSB0bXBmcyBhcyBhbm90
aGVyDQo+IG1lbW9yeS1iYWNrZWQgb3B0aW9uLg0KDQp3aGljaCByZXF1aXJlcyBjcmVhdGluZyBh
IGZpbGUgYW5kIGdvaW5nIHRocm91Z2ggZmlsZSBpbnRlcmZhY2UNCndoeSB3b3VsZCBtZW1vcnkg
YWNjZXNzIG5lZWQgc3VjaCBpbnRlcm1lZGlhcnkgbGV2ZWxzIHdoaWNoIGNhbg0KYmUgZG9uZSBk
aXJlY3RseSBmcm9tIE5WTWVPRiB0YXJnZXQgPw0KDQpBbHNvLCBpbi1mdXR1cmUgaWYgd2Ugd2Fu
dCB0byBleHRlbmQgb3IgaW1wbGVtZW50IGFueSBOVk1lIHNwZWNpZmljDQpmZWF0dXJlIHRoZW4g
YW55IHN1Y2ggaW50ZXJtZWRpYXJ5IGxheWVycyB3aWxsIG1ha2UgdGhpbmdzIGhhcmQuDQpXaXRo
IG52bWV0LW1lbS1iYWNrZW5kIHlvdSBjYW4gZWFzaWx5IGltcGxlbWVudCB0aGF0IGluIHRoZSB0
YXJnZXQuDQoNCi1jaw0KDQoNCg==

