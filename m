Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7998CC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFNvgaJG0qP5YKb7+CrwgZIJ3RzgCxtCjFmE5RGgCwc=; b=osQBzpYCNXZc1w3RyJKo9cmCOh
	klgc9BAuCDWR9iLIPdH2MfrKIyqoTgVFUYMwfcPB3bop/lOPTmbrByvQG/3myV3kiXO/REDFl+uI+
	YQNeXGCmquRm0Sws99j86gkQiJeC6xZOYoidK8Xrn3osz1GrXOln5sjCUcVHx6CU853tjsV+2LyJX
	Wt2VMPI5BPEca28v4pWy+X0zOpId+ScgUEkIEVrCWHb35JoBeD/TKIHlcW1a+xYvioq1A93IlD/Mz
	1dxuMORhTDOIooREx2uDGwwm2A4dN48lbgCeqcHDeptRYwn2qvev7/c/dEqBuxQ+7Sv6/pRoy0WNx
	Q2j8zLZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNsk-00000005tNd-04ZN;
	Wed, 26 Jun 2024 08:19:58 +0000
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com ([2a01:111:f403:2418::61b] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNsg-00000005tMu-1Npz
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:19:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGohh5gmGVgiwutdVHBzO4WtSu5jfiLTMo0yabqpo4IRJOolr4i2RQYVPX45uUWMnexRSLMSmEmskWoeDpiSdJxUhwwN+CofoOPN0OR3odknaY9uiqaTYvAoc79Ps3J26GNKkpBISDgeHOCLJLb5EXjaOYUSHPKMgaK7ndKbEUrIuG9uF0SfR1D+n0+xoRgh4GYO1vsC7ajrEaO3SmHkUr4kxdvWiWT/ikPoGYozYEFKpD9UUOCPtpHUcOo06gXtfMYg5+Sz3NZQJjIByOQqQF6J9JtaQiYAcsrwmhZ3zZmJ3ooKEyarMjeB2X4kTRm0ljXDUfuLyAlCLozq1fVzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFNvgaJG0qP5YKb7+CrwgZIJ3RzgCxtCjFmE5RGgCwc=;
 b=XlIBxp2SDXIJ21nXNwjqzjRHCRF380CrIFFoH6OH5nl7dbH+2sRO0Ci0v0I615jkGF+RaKlxvDzzpNun3/a2TenPQnSBmdzA6ODwFBy2ZujS7jL/5dquHu0iTGkBzC5KwwaH3toeDeW7DEgKeSHvYe0J1/Qvurt3iz1wgGqe2C3eQlCBuHf+JqXpJxmd7qm026KAiWA0IHJDBwefijmHagJpgldJU2igy3nR0XD11uRLFL5e17VphC/uZAKQDfqKqObZ1bQMj5YLVMrqITfLna++0PbQekD78B9GPWa6NVFgJJWghcje7Jvg9Si/ZQ/Y6qYbXLlAbKH2fPuesaGVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFNvgaJG0qP5YKb7+CrwgZIJ3RzgCxtCjFmE5RGgCwc=;
 b=bcShbG8ORT+Kpnx4CZKL/eyjIev9e9SyB0nQxkIBSml+fFgQ4RNkrs1M7jcpiphJwFgA9sogS5T/DVilv0BuAAvln//YRxWfXICTYpD3nVYaq7bWiirYILY4qXMe1W/wxxLWTB/oNiharNQk4SXElG/vwxsk7lHEZN4nvTUG2EurCfnnqWPv9g/OsiqxXi7GcGXIahlXoiOjRyZNrr1iKNcqCMmOb541mF0YT/dA4KssUR4NKpXOVm0Ti0BN51aJSP/mFT7+bViaRKUnCgDyiDZhLp2yApIh0G+tW0WgnN8v96V0gZZXiXW8KLTxTgrdg6f4YzK8faW0/WuEOWJZ9w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 08:19:48 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:19:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Meneghini <jmeneghi@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"emilne@redhat.com" <emilne@redhat.com>, "jrani@purestorage.com"
	<jrani@purestorage.com>, "randyj@purestorage.com" <randyj@purestorage.com>,
	"hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
Thread-Topic: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
Thread-Index: AQHaxvrmnigKuYnuw0aSADvVOBA2M7HZtT8A
Date: Wed, 26 Jun 2024 08:19:46 +0000
Message-ID: <fb69b60d-b2ad-4a3f-87c7-a3779184edd9@nvidia.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <20240625122605.857462-3-jmeneghi@redhat.com>
In-Reply-To: <20240625122605.857462-3-jmeneghi@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB8451:EE_
x-ms-office365-filtering-correlation-id: 45605598-1cc4-4541-51e0-08dc95b8bd98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?dFc1TE03OVZCY0dWakZHWElVdlRiQXhzeDRFT1FmbXR2Ly81NFFpSDlWT1Fq?=
 =?utf-8?B?UjBmTFVLZ1JWQVlHdmZQbWc2bW9qeXBES1U4dEhrekt2Z3hFRzV2c2NXVFRU?=
 =?utf-8?B?SG90NHg5VW02Q3RoeDhJL0s3WkNPR0RJQ25ZaEtRbWQrVnpLTUdZcXpUU0Ja?=
 =?utf-8?B?WkFaMVR3dG5zckhOYjJkdUlSNWRETjQxdVJlOFlCd0VDdlBZcGZGWWVBdWgr?=
 =?utf-8?B?aGNhaE5iWGZFMUZ5SFJhUkVWSDBZOHRta3hiZ2JVckJJSmJLNjMybnZkQlhZ?=
 =?utf-8?B?OGJYbFpBWlA3bGJOS24vTS90YVdLUzAvOXJQL1YxUTNrUDI1WExHZXhhNU1F?=
 =?utf-8?B?ZGRGWkdtSkRWdE4rbGVVdFdvUXFONUFXMkdqekpBUlNudi9GNGVIbDkwQm0z?=
 =?utf-8?B?M243R0NNYlJSK2g2eWlOaGszamsydVNITkVIVUN1ZktNODZJWVV0VVd4a1Y1?=
 =?utf-8?B?UVZqSEFHTHU2QVgxcERaeXpsd3RIdkY5aXNKK1FvNWw5WTlla3ZMU2hiU2VL?=
 =?utf-8?B?aTc4MUtjdXIzbGNxNkttT1ZzeFBPUWZXT0dYclNJZEU5Uzh4QXR4OFF1ZDBk?=
 =?utf-8?B?WlZtZWQ3SHBCNlRMUDhBQ2hrS3NSNjhpcHZKeFF3WHhzZFo1dlR1OWNaaVhy?=
 =?utf-8?B?Kzhic1pBd3pCalkyV3JUQVRmMllPS2hCUWxKc1JlKzQxYmd2L2dxV1JtUUo0?=
 =?utf-8?B?dlpHRGppSUpDMVQ2M2FZZ3pLMFRkc2FrMUZLYXd0K05icXpHdHVwdms0YkVI?=
 =?utf-8?B?SVA2QXhvOWpzSmFkVFpBVU9udlE1S2p3YStUa0RJS2tCVTJkWU1zY2pMMEsv?=
 =?utf-8?B?THFJbnZuRnNlaFNSaFY4eFZ3bXpDMUh3Q1pybGhUTk1NWDVRU2FXMTZlUFRu?=
 =?utf-8?B?MmFUWkNjWGdqdmhDWEpycE1IdHBGNHczTkJCWW9jVW5lbDU5aE0vaUNsbVlw?=
 =?utf-8?B?NEpFekZKNTViSjJQMEhnTGo3QXE0dHlxVWsyZTl3OFJ0TkphNFVHSmVjV0E2?=
 =?utf-8?B?eC9hVElnQkY3YXFpMFltTGxyOTNucmVZSFRqajZ0UmNYRmFRcnBMT1dua1lu?=
 =?utf-8?B?S3lpY2F0OStKWXJUd0J3Y0ZmdHhXaStDTUcwRGVpRmNBYk11czBFekc5TTJ6?=
 =?utf-8?B?UEZrMExkUmE4TFRSb1BzWnlaNllZZ2RCcWdGZitpRmNObi9yVkdtYzFqZ2NC?=
 =?utf-8?B?RFNsNGpaNlFrQk5GR21uSFFNQ2YwN1Z6cVdJOG9qdUZ2Vlh2eFJpbm5ZRnE1?=
 =?utf-8?B?dXZKSG5aTCs5M0NZRnBueGVlc2I5R2dXT2oybFgvSG5JbWl0emVnWncxSG1O?=
 =?utf-8?B?L0J4L2NpYm4vOW8zcElOWTJsVGpOendVUlFoMUN1TkdObWkyMmtMcUd4ZXFh?=
 =?utf-8?B?b00remJvcnZtajgzMEJnVFFCdTVmZ2NqUEJWNWRhSURZSHJ4bndQWUJNREJQ?=
 =?utf-8?B?UzBDOGJVUHFzNEFSdW04c0RlUkxFMUdncHRkSmFRQThsNnhiUWhQWXFkeHhH?=
 =?utf-8?B?TjlhUTdPdEpXMUp4dStnR3FnbGZGaDBCQXE0V1hvRkNvczJHS2JvYi94MTBX?=
 =?utf-8?B?cFZueHdsNjA3SDM1T3lNK1lRUXV2MXN0aU93RkdoRHBFcGYwNmVzVVByL3Fi?=
 =?utf-8?B?dEtuQ2ozaEhMcWRWQkt2bDFDN3cxSVRkUUFoQ1dNK3ZFbWFrVlJVMllXOWN3?=
 =?utf-8?B?Y2hDR3lxVVBndnUvVWU4M2c2Y2lDU2FtRWVlL3R0UDhlVkxRdG81VThUdXZt?=
 =?utf-8?B?QzZHMm9KK1J5YS9RMWFNY0ZsNFBkRVpuVlVHUlV2dEdGaWRwdXNkZzYrQXB5?=
 =?utf-8?Q?FSQ7Dgm+xAodTMorMEbD+WWcgL5+fZ1BNNmxk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFQzcHdsdUhnanpUZjVlNWZoOGxyT3dqVlJVYkkrd1h0Vi9TOWJ2SlF0cFFt?=
 =?utf-8?B?am5jMGpodE1hWUFicW1ia1ExcU1OS3RISUwzUGZKNXV1cHB2MTdBZVFWZ1E5?=
 =?utf-8?B?T1NBaCtpZTlmUmMrNTFwRXRkcG5wREszNE0vOGFlcjBQZnRKNlp2ZUtidmFj?=
 =?utf-8?B?TGlRTkZBZnpiRHZJZXNvMU5XbjhISDFwT1RRRkdUZVJ6bm5paDcrUWFKRVIw?=
 =?utf-8?B?dXp3S3ZMeTJYS0ZJVm5tc3lLRnU0Si9LVlU3QzZLUkFGV2FMTDJpUnVjVGZn?=
 =?utf-8?B?dVJQUGJGSFZ2UU4zUnREcWx3WTd5TnI4dURVYkcvdVpMM0wxSmtNcGtCS1Rl?=
 =?utf-8?B?NVdsZ0UyZys1VmcxZjNyMWx6N3F0ZFN2VXlHZVFpc0JnZktYWEluejROSEk1?=
 =?utf-8?B?ZGZNQldwVWZZV0dPdU9CYmlIZkhYNDhydW9SOHNGdi82RDJWMEQrMWlUUXpS?=
 =?utf-8?B?ak5WZXJ0NHUrS09oK3h1Z1dob2t4aXo4b0F3eEx0dG5OdjlRWi9UTTdpdGtx?=
 =?utf-8?B?Y0VMVTBUOEpzTzJ5T0c0SXpOSGFKUGJpVUVpMiswK0pjajhXMUVFdUNXRkh2?=
 =?utf-8?B?dUNMTDFuTFVzKzFaWGZVb3VLbzRNbFlaRjlCVzJJUDBwRlpOSkl0a0FwQzJG?=
 =?utf-8?B?VEUrSDh0SS9XbUJDeEE2bm1yc292cUtob1BHOUhYMUFZWjNVb0pRSDRUNldm?=
 =?utf-8?B?YkROZEhWOG4zMnFXUy9NRDlpbTJXcEppUTNleHg0TXdGa2VCUkhack9nbzQ3?=
 =?utf-8?B?QjNlVmx1bjJ6SVk5ZVFRTy9VTHdCWm4wSm53ak92S2k0REpVSU8vK0hEU3ZP?=
 =?utf-8?B?c01wWnlhVG4rcXBTNlRZMGhDTFErcklOdTU2WWduWlovNUhyT21XMlpqcHZm?=
 =?utf-8?B?Mm9VNXh5S0xvSE9vZ09lbUZFaWFlKzBUTHZMR2p1TFRjbWphRjRlNmU1YnZD?=
 =?utf-8?B?b3RFcWtsSG1YeWxEcUtzT1dNbHFONFdPbjdtbWhMNUdkTytyL2lhRHV4SDV6?=
 =?utf-8?B?WnFRQXdMWmowZzQzYzh3cUh2T0ppdnhBZnNvN3A4dTFYRFppdmp0b3BrWnZD?=
 =?utf-8?B?UEJoTGxjVGVCR0lFTlI0WHRPVUU1cWFNaklJaFhHQXpoZEk0MHNzWnNDdHdT?=
 =?utf-8?B?L00rdlpLeWRZS256NG9QNzRqV3FxRXJBaHZMNXFFUzZTempiczFQRUhTQ3Zq?=
 =?utf-8?B?VFlTYlZHRlFPS0tmVTg4VEFra3RKNUF6TEgrL3VlOVNhSE02ZDFPWGJyMXd0?=
 =?utf-8?B?SVlNUzZxVUFXUHgzK3FkK0Zwd0JzbjVvT1JiZTNUWGNMSytZUjNzdi95RThQ?=
 =?utf-8?B?SFhDVzF2UktycWk0MTZTT3ZyQmcwRlRLa3FOanRCYlhPZVd4MkRvOXJrTndS?=
 =?utf-8?B?a2hMVlgvU3kyTkpXNThsTDZMcnF6VDVlUk5nN2RFSEZzaGhlcTBqcTBwK0Ns?=
 =?utf-8?B?cFc0QTVhSkczVUNXYUxzbER6d09JTldrQWtTcXY2M3F3NStSVmpUQmQ0c3pJ?=
 =?utf-8?B?RHFOZUYvUEI5eFVvSUZuZEJ5SE5FQTlpWTI1Zm84S2w3VlhFZ0RqakhQMFBt?=
 =?utf-8?B?cnE1UTlEQThJencyZ1VqYlFBZHNXc2Y1NHZ5eTkraHJsTUJWRCtDOSt2ZjlZ?=
 =?utf-8?B?b1pwbk5XRHg3QzBaOEQ4YWxKSXdIMUxkUzhZUWVrK0dMUmw3RmJTbkFOODly?=
 =?utf-8?B?eVdscDd4aHg3RWpaT1V3RE5BN3F6M1o4RTVQbDZGYnpoUW5qNXAyRnQ0UHpt?=
 =?utf-8?B?eWFreHlZQmZ2M1NZeWVxdm0yM2x6LzF2REdTVG84T2s4U3lNM0dtUXpJNlBD?=
 =?utf-8?B?aEFLUm9qQzlKU0RtZUtQNmtneTlZMU5rcHIxcGxlLzl4UXoyd1hGUVZScmpM?=
 =?utf-8?B?cDhSdndHM21OYUJjRGlMY1BIY0o2ZTV1c2xrNkU0TXRCYVBDOTB3SFkvZjhu?=
 =?utf-8?B?Uk11TFRkMERlNFZGZVh0eEpLdHhSaHd3ZVBFZXZ2eE4vQjJxNEp1d2dyZWxU?=
 =?utf-8?B?SG9paDBjRGk1b3lvaU9iY0dzVUdKcUZ1T0JYZUIzZXlkWGVWVVJ2R2pGek92?=
 =?utf-8?B?RUoyL3kvQVpNQ3RkT0NVbjJNVTVneHY0WWJkbnBDYkRhc1lLZXFDM2Mva0RE?=
 =?utf-8?B?TTJFMWh1YVlVbmJkTVBJcHNLUU9Cbkd6MTkzcC9FWmFBNVV2MVExcGRPZHpw?=
 =?utf-8?Q?Z1IYWa5VyVe5g34zBDDkK/0B9mSgybZDf31qokZhXsSy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5777513D8EB6346AC34D0469EAC1A7C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45605598-1cc4-4541-51e0-08dc95b8bd98
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 08:19:46.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: payovB3xskV6sItzwqHicq5vQHmW9+6PJ8/bZsuZI2aImAFsgep5mZsT8V3hJmhtFaLLUYDMXK92ow2qT6qwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_011954_524684_B6F3120B 
X-CRM114-Status: GOOD (  13.40  )
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

T24gNi8yNS8yNCAwNToyNiwgSm9obiBNZW5lZ2hpbmkgd3JvdGU6DQo+IEZyb206IFRob21hcyBT
b25nPHRzb25nQHB1cmVzdG9yYWdlLmNvbT4NCj4NCj4gVGhlIHJvdW5kLXJvYmluIHBhdGggc2Vs
ZWN0b3IgaXMgaW5lZmZpY2llbnQgaW4gY2FzZXMgd2hlcmUgdGhlcmUgaXMgYQ0KPiBkaWZmZXJl
bmNlIGluIGxhdGVuY3kgYmV0d2VlbiBwYXRocy4gIEluIHRoZSBwcmVzZW5jZSBvZiBvbmUgb3Ig
bW9yZQ0KPiBoaWdoIGxhdGVuY3kgcGF0aHMgdGhlIHJvdW5kLXJvYmluIHNlbGVjdG9yIGNvbnRp
bnVlcyB0byB1c2UgdGhlIGhpZ2gNCj4gbGF0ZW5jeSBwYXRoIGVxdWFsbHkuIFRoaXMgcmVzdWx0
cyBpbiBhIGJpYXMgdG93YXJkcyB0aGUgaGlnaGVzdCBsYXRlbmN5DQo+IHBhdGggYW5kIGNhbiBj
YXVzZSBhIHNpZ25pZmljYW50IGRlY3JlYXNlIGluIG92ZXJhbGwgcGVyZm9ybWFuY2UgYXMgSU9z
DQo+IHBpbGUgb24gdGhlIGhpZ2hlc3QgbGF0ZW5jeSBwYXRoLiBUaGlzIHByb2JsZW0gaXMgYWN1
dGUgd2l0aCBOVk1lLW9GDQo+IGNvbnRyb2xsZXJzLg0KPg0KPiBUaGUgcXVldWUtZGVwdGggcGF0
aCBzZWxlY3RvciBzZW5kcyBJL08gZG93biB0aGUgcGF0aCB3aXRoIHRoZSBsb3dlc3QNCj4gbnVt
YmVyIG9mIHJlcXVlc3RzIGluIGl0cyByZXF1ZXN0IHF1ZXVlLiBQYXRocyB3aXRoIGxvd2VyIGxh
dGVuY3kgd2lsbA0KPiBjbGVhciByZXF1ZXN0cyBtb3JlIHF1aWNrbHkgYW5kIGhhdmUgbGVzcyBy
ZXF1ZXN0cyBxdWV1ZWQgY29tcGFyZWQgdG8NCj4gaGlnaGVyIGxhdGVuY3kgcGF0aHMuIFRoZSBn
b2FsIG9mIHRoaXMgcGF0aCBzZWxlY3RvciBpcyB0byBtYWtlIG1vcmUgdXNlDQo+IG9mIGxvd2Vy
IGxhdGVuY3kgcGF0aHMgd2hpY2ggd2lsbCBicmluZyBkb3duIG92ZXJhbGwgSU8gbGF0ZW5jeSBh
bmQNCj4gaW5jcmVhc2UgdGhyb3VnaHB1dCBhbmQgcGVyZm9ybWFuY2UuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRob21hcyBTb25nPHRzb25nQHB1cmVzdG9yYWdlLmNvbT4NCj4gW2VtaWxuZTogcGF0
Y2ggZGV2ZWxvcGVkIGJ5IFRob21hcyBTb25nIEAgUHVyZSBTdG9yYWdlLCBmaXhlZCB3aGl0ZXNw
YWNlDQo+ICAgICAgICBhbmQgY29tcGlsYXRpb24gd2FybmluZ3MsIHVwZGF0ZWQgTU9EVUxFX1BB
Uk0gZGVzY3JpcHRpb24sIGFuZA0KPiAgICAgICAgZml4ZWQgcG90ZW50aWFsIGlzc3VlIHdpdGgg
LT5jdXJyZW50X3BhdGhbXSBiZWluZyB1c2VkXQ0KPiBDby1kZXZlbG9wZWQtYnk6IEV3YW4gRC4g
TWlsbmU8ZW1pbG5lQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEV3YW4gRC4gTWlsbmU8
ZW1pbG5lQHJlZGhhdC5jb20+DQo+IFtqbWVuZWdoaTogdmFyaW91cyBjaGFuZ2VzIGFuZCBpbXBy
b3ZlbWVudHMsIGFkZHJlc3NlZCByZXZpZXcgY29tbWVudHNdDQo+IENvLWRldmVsb3BlZC1ieTog
Sm9obiBNZW5lZ2hpbmk8am1lbmVnaGlAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9o
biBNZW5lZ2hpbmk8am1lbmVnaGlAcmVkaGF0LmNvbT4NCj4gTGluazpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1udm1lLzIwMjQwNTA5MjAyOTI5LjgzMTY4MC0xLWptZW5lZ2hpQHJlZGhh
dC5jb20vDQo+IFRlc3RlZC1ieTogTWFyY28gUGF0YWxhbm88bXBhdGFsYW5AcmVkaGF0LmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFJhbmR5IEplbm5pbmdzPHJhbmR5akBwdXJlc3RvcmFnZS5jb20+DQo+
IFRlc3RlZC1ieTogSnlvdGkgUmFuaTxqcmFuaUBwdXJlc3RvcmFnZS5jb20+DQo+IFRlc3RlZC1i
eTogSm9obiBNZW5lZ2hpbmk8am1lbmVnaGlAcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhh
bm5lcyBSZWluZWNrZTxoYXJlQHN1c2UuZGU+DQoNCnRoYW5rcyBmb3Igc2hhcmluZyBnaXRodWIg
bGluaywgdGhvc2Ugc2NyaXB0cyBhcmUgaW4tZ2VuZXJhbCBoZWxwZnVsIC4uLg0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0KDQo=

