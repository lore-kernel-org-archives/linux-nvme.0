Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E050CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=; b=AzENfehr+Gih4UyMT3CKTj+kjY
	BfAiKslgw0P/UQI2dA469ZEEU1teyBJZOEzNaW+pKwJOoz9x7EzjyYjRwx2IBFJQz2OFQHCSpXVYg
	/NG1pLPsJoUCwbhL72peBBxBuscseRXZENiPOoepOE+aSPB7VMyj+a3q5nLdAqavjLmmfIO3VizkQ
	HExj+ZYSwH5WVF3MbZwvdn7swxtUI0BpkJCFWiGcbByUeEvj7aFjcME3K4CMYIZqDe1dyGwCVP9VY
	l197dTGFn6h2nQ+c8q9feEHYO1mCtNwEvktW0I4SwU2Q5qAZmHtR3hLwy3BK2kbFmx9r4EAGeNfed
	QtBY23XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFv7U-00000009ynK-2KzI;
	Mon, 03 Nov 2025 14:01:16 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFv7S-00000009yms-01YQ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 14:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762178474; x=1793714474;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=jBYK+1Q92vjx8jztv5cxXSJQsYzqhnnMTf25dhaSFhXnrNBoSqTRD80I
   oem5fjPNV4PBcM3JwsJQIQ4LW4cjva1cZlamuva0/ZKNXRzx0OY9FiSQ8
   K0VlSyLN/nrRoWuA04v91wZBIfBNy80Gtes0+CK0gFSjNvArlRFx+lDL7
   fzDgW81+eQBRm5B+mPHI6E0GX3HOwdBMlWV56v3CYQppYD1bupjSAtqfA
   oV3N8e+5GOqZNHs6VkT80ZmXQxmc8qyGImACX6Fo5b4kCDtUnoHnSoHDG
   5JC8rkKHt4tkdykfN2GWpUX4S8P6jmWgzA41nENJKFE/m3WfGCzpiteWf
   Q==;
X-CSE-ConnectionGUID: EEdl0si9TuexVkcGlkeveA==
X-CSE-MsgGUID: hIy7KncFRFmjPKQZgELhLg==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="135343551"
Received: from mail-westusazon11012012.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.12])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 22:01:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHtJu+QQhiIsId9QiOGditSFXGs+9xDUKFu7iuR1DkQizXZlE+qGAS+Gx5XAY0PyhY9L6spt8lg32BAdPOVYUfPKI4MrGb+s31hBdlwhJpVmvssET4onzL6ZqJRqHYSP8Z78eHrcFq5Vb1d6lO5PZ0hSYlvWDK5gS+5vkeQeQSJmBn8ZMQSNCtYcbud1exQBjDbSvUoHmVWqV0FzGHWGsA91zOIww6KHmX6a7+ot5zvTNhTb2ldwUDBSgxM6nu4lZOk/0X/0+tx08y1gnOhpGMQXxxqnlFWHYzO1mKehkqtaTyh8sJGeSsnL2hdfMsdKi7NY/qsAHmWo5rpEZ+tUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=NzbwshxRV0UEchjyMmQwY3V/jSluNlJC11qPne1eAQa1tuC0LJmDbP480izIGpmXhXkxvuSARmCtlzKcVIMigicyFUn+deI07O3gPapNCOjwNz10uKJXJmT6s+C/MBYBV3ZCuZxIYxSU5nQd9bypxu4iHUPrBBBiVhMw3osPDEt//bUxdROde21ru83/71tL0WSPPaZU88FjMEqJs3HVGTCJh8Ty0pcS/aArg5FUWgAr8kndPbVQ2fg+ww949S+wJCoGHLtx4R2mz1MYJVHvTPMiATVJQEYmyJUfmh8dI0SlG1i7muwMlYDkI+5Z+daWqSlGNeQopbFmcA+e7B+4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=oC9QgsOGZBWMYbr8K3cf4fxo8OuFTEl4EN5/AbR39hWJpen5CkjgR47T5QPxZzmvpN/NRhB7J50BPEcFn2ihNRtYeldjI1mJMRWzPRqiVW2yrty56CRYrAKQ1+go+kVLiVgZE71bbbykCC9KhS9Tgy7n4Th2vE0kA5gec/g8JHI=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB8387.namprd04.prod.outlook.com (2603:10b6:510:f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:01:11 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:01:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 04/15] block: introduce disk_report_zone()
Thread-Topic: [PATCH v2 04/15] block: introduce disk_report_zone()
Thread-Index: AQHcTMbZw4hd+KALQkG/4xSe1Nw2krTg+w8A
Date: Mon, 3 Nov 2025 14:01:10 +0000
Message-ID: <b1080752-6bac-4fc4-a06d-d5b5f21c5de1@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-5-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-5-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB8387:EE_
x-ms-office365-filtering-correlation-id: 7f84fd85-4f40-4ee5-f848-08de1ae1716f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|19092799006|7416014|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MDlUeFNRNHZ3aXpJckVVeGZrWWpneEhETHVtdG5OeU9IdVdGSm5adnFOZ2hJ?=
 =?utf-8?B?aXJLT2ZPL3BlQm1kSEFZc05oU0UzaG1pcjFxcHpaRVkxdTBGL0hIWlVHdHRI?=
 =?utf-8?B?OVArZHg3T0xJZ0NReXZ5a2RPcmxoc2svYkhtejN6UmtKU3V0WDhyak9pOFg0?=
 =?utf-8?B?bkJtS2xQUHFxc3lhRjYwWVQzbjFXNFg4UmJOS05jdEtRRVppeWR3U2lPYUpT?=
 =?utf-8?B?eXk0dENqT1dnT2JESzduSmhDdlVYeFRTKy90WDdTVFNVcmhjNjI0bXhKaVll?=
 =?utf-8?B?cGc1d1V2c0htaFpqTWYyWGhFdVpoN3pIc3hxQmpCSDlESklBS3ZrRlFXN3RM?=
 =?utf-8?B?Z1cramVyRFliOFg4Q25sSHgvcXRtS2xyTDRlVnFJdktoUVpsVHorK2gzYzdY?=
 =?utf-8?B?MzJwTWhKM3pRVFVnMXpvOFBwN2lQSFZLZkZHS0g3Zld3OVRPc2RpM3RDQkkr?=
 =?utf-8?B?cEJId0toNnJ6bUQwSk9IK25uNlBTWEcxelhCQWVUQ0xud1dneEkvcmRvc213?=
 =?utf-8?B?YWVyZDQ5eE16ZXJsSVFLYXFFeXBTaEdhOVJxSHBDTlptdjN0SmN2TDVKemdM?=
 =?utf-8?B?dHZPdmlvVS8vVTA3ZGR0eDY3UEtDWmNkcnJWZ3dmZDUzenBPWW9OZ3pTcFI4?=
 =?utf-8?B?Tlg2UVhld0g1NVg3OUpaVElHTWtvUmFYTFBrS0NWUHFpYmM1bmFLalFXTnRG?=
 =?utf-8?B?T1VYcVA4cXhWQVUvcnZMUzk3aUpwYVJHdFN2UzVVaVJvcFVFbzhid0tCUG9n?=
 =?utf-8?B?UERpb3h0cFIrWGhjUjZmb1VsakxWdVltem8vQXA4eUNGV3hGWll4WjZ5WHpq?=
 =?utf-8?B?VjJMcTVIby9oeW1WZ1hKN3g2MWtCZ25ScEhTUFpoRlVYdkptNzFEd1Q1YW9Z?=
 =?utf-8?B?ZnlIVk5BcjNQcUNkL21YRHl6Ylg3SUVvb0xsYzRyMnBQeExHSDRHaitSSEpP?=
 =?utf-8?B?Y21jUEFHcFhYY2dWazg1U3MwRGNEUlZKNkNpMGZSV3NscmpZSGo1RHpCVWx2?=
 =?utf-8?B?SW4xYm44RDN1a3FMNkZmR3FnNDlhNlNoZ25UWG5zcmZ6Z0hYVFBTbDloYXVC?=
 =?utf-8?B?OTl2a1dxUWJZOTlBMUV5UWExcXBtTTl1eitiN2JzOFcwbzNPV0lGQ1pvQXJn?=
 =?utf-8?B?QlpKT3U1MGNIbzdsYzJVdEozOWthRlVNRGNyeWRSN2RSWE5oVEtBaUs4UEJX?=
 =?utf-8?B?aFoyMUpSODk5S0s3bjFIb1BGeXptL3M0bFBYVkdzbnZLUUgyd3Z1eFZ2NVY0?=
 =?utf-8?B?UEIwNnpvVDVoSTVFL1BVZjVlTHQvdWpzd3J4VEdZT1gweTNNcEg0OE91ZTQ0?=
 =?utf-8?B?aGZmUTdwQ2F2QUJGWkxLZlYxTGx2Q2xVOUZiWFpyWWc4Tm1YaTlGdU9EZVhk?=
 =?utf-8?B?Ry9PYWVmSkFHWHdWRzdFUG04S25QbDdhZjF0aFI3ODRlclNDTFU3RTB0QUJ1?=
 =?utf-8?B?U1drT3JnZExwVnE1SjB4cmNJQUtRRzhwZUV6eE5DT3crTENVT0ZEUnNKU0RW?=
 =?utf-8?B?MkV3L2ZSQzBlMjFQQUs0Y1JSbHo3U0xmVTBXUnNTU3hXVzZNVEh3L3RnWDZa?=
 =?utf-8?B?QURwcTFMcXZLZ0RBKzdkU21HRkhMWVRzN3JMTGpRZXRVRWFESXdSRVlVYUh1?=
 =?utf-8?B?cy9wRUo3VUp3SHdSK1B6d1o3TUV5QkdPRFl5MW5acGtRNmh6NmdQUndsRDNU?=
 =?utf-8?B?c3JJMC8yUHAzSStEZ3A4T3hERUlvbWtXODdHMXhsS1ZoK3NSaWJkL3p3WWlS?=
 =?utf-8?B?OTJBVVlkZTFFbllkbTZWQ0luUnFiVHkyQnJTci81WUJJVkRrL2g5ZGFTclpz?=
 =?utf-8?B?LzZqVXdyWmYrUUtxZWU2YUt1dEl1L1hPU3M2akxsU1RrOWhvV09QN25nRE5R?=
 =?utf-8?B?UFNtYWd6S2pqSjN0WElOTTZUNEo5dHltVjBwVXQ3MlZQdUIzMmpSUjZTZWRJ?=
 =?utf-8?B?N3A3ajZjKzJkNjBSQ25nV0pCUVlhVmN2S3RZU2tWWDluZzUvVTRlMzRuQUtr?=
 =?utf-8?B?SEVVN0EwelN2VzBBWUFqOVpDNENodlkxcWR2dWJldVpabWFKQUlGbk5id2dh?=
 =?utf-8?B?dnM2QWVkZXBuY1JwQ2hKWjlaVnJ5Ymc5eThnZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(7416014)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG9JU0UwZVFaSVIyL3R4YTBCcnZ1WXFmRWI1UWZ2YmI0MjNoK1R6Y003ZGJS?=
 =?utf-8?B?WDVraWJiWUU1NkVEOFF3d1d4V0s4WHFqeUV5bS9sZUl1emRZWTFVOE11VFJJ?=
 =?utf-8?B?RTd3NWJZTDFZSjU3MU5KWWNyUTlqRFpvZ0tRRXkvSDdOV3hYNkF1Uk52cjla?=
 =?utf-8?B?d3Z2RktiR01sWWczWUQwRnlkSWtNLytoeCtiazBVbncwc1ptMUdoVG9LbU1a?=
 =?utf-8?B?MGF6UTdsR0thRjVCMVlTN3dKblQxeStQL09NN2VzcWViRE9WWFJuclRiSkdR?=
 =?utf-8?B?dndRYVlLbGxqcmRUMDk2MEpOb2UyN3VJb1Z0ZS85ZEs2RktXYnN2a2xnQWJv?=
 =?utf-8?B?UWFSWGQ3OXh1a0lUcmsrb1FFQ2RBS2gwT2NRNHVlMWRzbUlMV0NLZThZc3pU?=
 =?utf-8?B?dUxtV0V1YllBWGhFL253MitkWGdzMjhxQVRVMWtQckRrcGY2SE5NMjJjUncx?=
 =?utf-8?B?RmtrVEpmRFJEU3dhanM4aFArUm42ejllV3dndUR5TEs4RmIxSjFxbmRwSktv?=
 =?utf-8?B?VUF5LzNKek9LYnFxVUdPU2YvQUh3aEZMc0Y3WFZuK3c2MVR5bndpWDQwTkxY?=
 =?utf-8?B?RGRHL0RFVWZUeFRTM0d1cU9sWjlqZFRtbCtyUjRFQnFtV2VzQnFUQXNNR3NY?=
 =?utf-8?B?dzI1Njh0blMzY1VzczBYTGp6TjNSRGFDSjk5a0tpbHE1dFF2QU1hRTVZYS96?=
 =?utf-8?B?VStxUkdxNC8rY1c0UVVVTk1MVStTemw1RXVIQWJqNkdBWkl3aUZvcWZRNzNi?=
 =?utf-8?B?ZmFZUXZaVisyU3RzQXh4NGFpWUorTGtwbUJzcW1MM0NnakFzOHBCOEV4OGRY?=
 =?utf-8?B?VXlyUks2ekkrUWRkRVY5RTJUVUtwbGpEc0d3YlpKQ1pPREVUOExyOVlTdXZO?=
 =?utf-8?B?RFFTd0NaUE41aTFxbkRIVWxEK3VjRHYyT21Ecy8zbkNteCt1eDViVWlMT1Jp?=
 =?utf-8?B?SVN2MDA4T1VMeFY1SnlEUU5CQ21BTkNWOHNwVTBOSHFWVldLVFVPTjVDc1Zy?=
 =?utf-8?B?ZUZNaVJGNlJlU1lQaFV3SzgwUHNMZXpCYWlvSzNRbWM3Z0x2UWFhaHBPVTc2?=
 =?utf-8?B?NlY0dWtZWjdJZi9PNFRmS3VGS09hUkxQQ2tRTDlFbStUOUgyZjFLeWFWRVFW?=
 =?utf-8?B?Z3M5UXZJbk1aTGZFa0Z2M0dWNjg1RGJ0b2lBVWsrSTZoc3poLzRGeDhRUVE5?=
 =?utf-8?B?WW1qTDFwU1FCbGIzcFBhSSs0OHZURVJVbmJOR21LTU9nRHBlR0o5MzZ1OGF1?=
 =?utf-8?B?SUM2YWpkYmwwb3FNZ1JTVU9rVnZCeDlnVXFHZ1g1SFpEcmtNbFpxVFllRW9P?=
 =?utf-8?B?bTVsR0F3alh6V1BqaGxua3dKUHZvQzdNNXR5NGVvT0hIQWhBaXJFd3NXaVpI?=
 =?utf-8?B?d2pheG1iTnVqUlFuUHJkV3dzMTdMcWcyd1FSNkNtTnFMallac2QvanRnRHU0?=
 =?utf-8?B?TzNpVmFPRTdQQ2NDK2pKWTQ5UDB2WC9HWWp4ZzAzc29oZC9XUUpXYXYxSnFm?=
 =?utf-8?B?VEhlM0NZdmVJU1NXZy8zYmQrOG4vSlRsMEV2eXVxd01tNEgwMGVaZGJuS0c5?=
 =?utf-8?B?T0FudVNJaDlPZnpRUUhwZ3dReFlibExpU3VlRjI4S2NlQmVUaFN6aTlwcUo5?=
 =?utf-8?B?QkFZUjlGeTZ1dnR1MVAwNjNva0NKWjNzcFpsWGRtT2pqL3FuN0RjWks0VFJy?=
 =?utf-8?B?cmptYWFQMzJkL1UyQ3QrZ1dpbUlNSXhoRkQyekl2cmZKcHhOSUJ3ME1tc2Fo?=
 =?utf-8?B?U1BMalpuRldnQnQrZ05Jeml0RHNNSEdHNVpPQjdTZDRzeTc1Zm91b3hxUTQy?=
 =?utf-8?B?WFVSeGhpOVVMa3lQOEZ1OU1jMmhyQk1zRVVGUElHMXZvQ0F2MWlhVnM0TUs1?=
 =?utf-8?B?UWZldWdQMXR0aDkzZnpPR2ZNdmNZd0dGaVZ1MGVodUM2alEzRkJ2QWZBQlJM?=
 =?utf-8?B?QUlKendxc3Rsci9ocGdtdHBNSHFuRFNTamR5NVpVNVo1SkhzV0lTRytDYkJQ?=
 =?utf-8?B?cnkxYVVHa0hGNkUwYkdZTVZ2cHprc05Yd0FtZlRuUlF2RFFaNzN6eng0MExx?=
 =?utf-8?B?VXhXRk1wc1pVYm44dHNCdTBLNGtoSUFud2lxaTBJRnFhV3JsL0l5eE9STkQy?=
 =?utf-8?B?RzJRRHNRd0ptMDh3SkVjOEt3TldTQ05GM2tFMHpvRmNxOGxPTzlNYkF2Y0xG?=
 =?utf-8?B?M0ZXeUpySVlKK2oxOUlabGgrTG1ER2NIYWpXcldqL0pRaFREcVNZdktZZEFs?=
 =?utf-8?B?Y01SL055N1h4OGRzZG9GWnVCOWFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CF643490090F84CAA0F0921C68A42F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OroZm6mzPhyGsiegImsRIdBtgtEHMO9nO9JFginQs3VaN3VzPWJ9VlHphcEkMvUk8AkxQV5Qk9S1yDNflFU2z8hiSTrHUluq4FBVRi9yCGzssqVjE/K8PPLPc+WJWKcM/17qNf5c0YCSMltW7KTZz7Do07aPeNZ6wNkCQwJ7xvsbgFksL3hjzPHI8BrdY/SyB7ZZ/xX425EFALvTKAfoK+x+0g8X6DnjZYlZ/ieWSbRQrRIbWAeG/zQ+MH7RcnYToieHLFUNJ9W/hb3U8MSnr5pcyAkPOxvBqj9YCcyN9rJrMRZqdH0Gb6Pf3v4YYcLP8i0qSqQFo+QQDr9fGG5rRbnz9+aD7n6oAXJ0yRjCs20r8oHsuZb8qe0Zf8fd5heTs3NfJ2AkGPKEk5IV1iY6yN26s4OIR3YBPV7XOCedt0YESp26RCJ2rUKjTaqcX3SykSlv/g9ctx7zgxt0JnmptjM4dFdZiSgli9SLwuKYBps6/rBnWY+3w41LAatV2njmpYEGIccqGWvYcPOIMAhPRf1U2TP9mJW8Hn9SSf6Ty6/IFBOucC9UD0Y95ppfQFiOBQDHZ2IQzfm6m68s1D0nNn+xcl7kT6i7YU+3cjcG/fwUryL14uwSLTwJMkncJae5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f84fd85-4f40-4ee5-f848-08de1ae1716f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 14:01:10.5702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMxmKjqMVBE4mwOK9/EquFdHVe/jdDY9q3yt2WAekFA0P1EZbA2H9zjtOT00QQvF4BMoJ8NfbfFgWswRYuPDIKMZvvQu1wEsqI3wREt8PsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8387
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_060114_053005_57803A4C 
X-CRM114-Status: UNSURE (   8.84  )
X-CRM114-Notice: Please train this message.
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

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

