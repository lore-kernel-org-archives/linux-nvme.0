Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D4EEDF04C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4g31HkPUoA0oNpR7njJ+9YXt4rqGAubpieNkoTXytU=; b=ghhfjhfnSoNFuFTLw4KM3MksTT
	mkx0Xjc3PCkZ53lpLTbsF06tVxCg376hjEV6ZxJDxk+0Kld8PRVP1ObkEgczywHT09HGLTD8nE736
	OfkoEpVL4PSunuLMQEDZkMvElT4Q2ZE5OwTgm33Uu84/hmUqjkS7OtJMpCDdpkK4jtbaVOPydLgN4
	3sShAs2r/773TE4JGWsXiaywyD/8tJkVhsRXQuxpohyLiBoD5JMowtfUhBoQH9cUWlypslaXPik8H
	2XBwW64OJB5PPAyMmyr5Mu98lSQCnmp8dMMMj5xPHCs8Piw54H6u350gM8bpVP+cUoNFJvfW+b9QR
	8Myn16mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqRZw-00000001jJ1-2lvC;
	Thu, 12 Feb 2026 07:57:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqRZu-00000001jIc-23k2
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 07:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770883054; x=1802419054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G4g31HkPUoA0oNpR7njJ+9YXt4rqGAubpieNkoTXytU=;
  b=m7VuQpunYc+tT1cCDvWwg8T0xyjbQRKVT+221UT39XS5XFpRowmhscnf
   Cv+q9Qo9YVnUDxh/+/hpB2eVzbh0a1AjsGK9BIHTr+xA+bXNfUAXYp7+Q
   xdYZpFOfPP04h2E3CHWp1MtZbnCvDsEv4oZ6ybJwYMwcZ11QrdQkC567S
   cw5Zcjpf9bVxjqPYzfRbGi8FH9768O6XLtSXt9rT4rDtoJ05sKVIh7Kb3
   rnqgyRTtaDm/yYAS1dKaITpyEYEBk4vaN9zNxhtLXGjImvZiPmiV61Zew
   UlZ69mrN4//L3MKDmWEHnpT3e1wOGUFlTA9ed1lENLUX/ZLxcJGqorYKB
   w==;
X-CSE-ConnectionGUID: keSU422fSsmqBdOrxJ3KBA==
X-CSE-MsgGUID: 8y5Vzj/jQgeywVX+LZ1TjQ==
X-IronPort-AV: E=Sophos;i="6.21,286,1763395200"; 
   d="scan'208";a="140596376"
Received: from mail-southcentralusazon11013018.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 15:57:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEolRBpef1072xi7miwkLIJMQMKbP7EEhhwBZvJIwnHJpeFVInTi+JKsPyKua4/3PIFEdRGmcmjmOXDAobKpAAyLSUmS0YXrE4uQwpel2n55kI5eiLhiDVbdw4akoncgbpodZmQRzP7A3PqOoCDer4utHg4OextoZa2L8VnlPGDcjVdENCvKUDRms8XmtjrfX1z+OYyqaEOJfRuXgILvLH5KEfrkBCx0i/YvgOOqptnL5lMTQZ7zgrJXBAOvsLzp3s5ImX1o05B49ip/nmRIPJK/jFO3z6zDhtwtSvj1QQd/U4idfEqlKCD+ElWrL9PYEnzU9/06jesSrdWKrFaMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4g31HkPUoA0oNpR7njJ+9YXt4rqGAubpieNkoTXytU=;
 b=iNx4ZJs8tw2+3IbpZmh2KJvQ3a2NbVe71icP1mYRJIY35wLDqF6lyXuzDszQN7duQweMwtYwoE3K9ojlQxnOIEpErnk97H76BHeuZDMjAY12VYq/vv+3ERxxtfEgAAkdWP3AKLP3wocm1OBS2L6q0dM/fTbsAr+QB8H3ODCN7xhz90Sc3uQw9TjhwGqtr3qEJ/JtbFYjLbRYGL08rP16ziWYr+2rEAAj3+p2rspjv7P4w0PiTrUigUvCvuSr4bjTkcIHNsNegqjiiS/PP1iGaFs+VnaH4e+XqlPixgdXIO8S4CfPnBgZn1mY/C3jtzChNYQIUp0SlbpJcORwM7MiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4g31HkPUoA0oNpR7njJ+9YXt4rqGAubpieNkoTXytU=;
 b=UQkWQRRTjUOQNCIUJUTyPseAj1YAd4f3MeMMT1uZ0wogIeY8xza4WhGhVZmmxkKr4XaxWsnm1akposDszD1NIN1fZXhMozCHQiUIrtisoanqCKwLhXhGJNj4Zhc/9W2t+EUuAeDGYTeD7J3NBA7PMqwTKf4EA17qFMyOI5habiQ=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH0PR04MB8100.namprd04.prod.outlook.com (2603:10b6:610:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 07:57:29 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Thu, 12 Feb 2026
 07:57:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart
 Van Assche <bvanassche@acm.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, hch
	<hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, Christian Brauner
	<brauner@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	=?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHcm5X2GyQlbhzV6UGhlrLvCD3GoLV+sd+AgAABawA=
Date: Thu, 12 Feb 2026 07:57:29 +0000
Message-ID: <24634187-a4fd-4fbd-9053-03484eadf16f@wdc.com>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
In-Reply-To: <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH0PR04MB8100:EE_
x-ms-office365-filtering-correlation-id: 70ef3527-9e36-48f8-5002-08de6a0c5eaa
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b1ppWlJWQklMcTdzVmhXUWFZdndzK0gxQVJrd1BzdXNuZHVNZFFvV3hXUjhz?=
 =?utf-8?B?Y1Y3cGttUTJlSy8rcDJ1ZE54MXV2Q0FzKy9BM2NLZXJYR1hOMXRWU1F5RWlM?=
 =?utf-8?B?SmRRSVQxZXhocUduM1UvSXcrWFY5c1VITktsVEZ6SWMxQzFnRlJHb0lqZnpS?=
 =?utf-8?B?RllmQjY2TkJXNTBmbHl5cXgvNVkza2Y0aHRQU01ZYlArQW1pNmlaODR2UEIr?=
 =?utf-8?B?bGh2c3VTRU9tUzRSaXNkRHpaa3RpUnpJMXpJc1lrQUluaEhjL3RTRjNzMXJ2?=
 =?utf-8?B?THhSZVlkcFo5N2NVd05DMjljTzQvYzhEVzJXOTlUK2QzNG1McTRTUjk5NjBT?=
 =?utf-8?B?cmhFQTMrcGljWEFEVjBPRUxDbDlqZWJmQnZpTXdlUmtwVlJLVGdVcDBqKysw?=
 =?utf-8?B?aDlZNGV6K2MxcGlzdGt4TktVK2NCRDhnKzBtcTlsMVI0aGs5YzRFdEY3bGtu?=
 =?utf-8?B?RFQ4QmRsVktqSGJhNFd4aU5KTm5tUWtmVlo4ZHpsbCtVZE9CSG83NHJmSFk5?=
 =?utf-8?B?aHBkRGVNR3o3c3Q4SHNJbTY1SkpjYk42eXBvZFM0WTZ1Z0RPSWd6Y285Tnlv?=
 =?utf-8?B?Lzg4Z0w5QXFZb0xUNXl6Tlc1YVl0MDBmdkVEMGtseFkvekhmajFHVWJpcWNV?=
 =?utf-8?B?V3RBWHFtMG4xa3cyNXRqNFhHakMvYkZFMXozUS8zaDV5eGJOMEszZ2JhNkpn?=
 =?utf-8?B?d1dhdVVUeU5ORUVBNWJzWUVQUVdYd200SVZrMEl0VXVpTHBOMEZ2M1VPVEtj?=
 =?utf-8?B?RERDM0ZnREhMSko3bVc4YkRsOTh2bzRYeDZXbmNxdVQybEtaYSt2MDVpM0Fv?=
 =?utf-8?B?ZTRVTm8yZzNhQUtyS21NWmk0VDdSbXF5anF0TUJ3VklMdjlxZmwybUtab2w1?=
 =?utf-8?B?NEFTYy9iUjdXa09WYmV6UFRaWFI3Y00rVjdFQU1CUk5YSllDUzl5UGlTcGpF?=
 =?utf-8?B?c3YvQWkvNXZJN0tPdVpIOWxUNWRRaDl1eWFIUEp0ZkRJZm84VXFFK1J0YXQ2?=
 =?utf-8?B?cGUxMWxIYnNiMmpwNitxei9sZEpXRklSUHZCNWxrZ3ZUTWN0UWJ3di9wMFZv?=
 =?utf-8?B?Ukpjd0laV2ZwVE5JRjJ4UTNkNmxHTEJuTHUyam43M0ZHMk0zR2V2QlpHbUFF?=
 =?utf-8?B?R0hCVEx5UE0vYXpFYWFScHdDVWsrOUlRbHhwVldFQ24vM3RuWjJQM0xuNlp5?=
 =?utf-8?B?M1J6eUl0bi9KK1JPZVpzWFV0dTByYWZXQ0VPTXdKbnRCTisrMmZZUEtZOW10?=
 =?utf-8?B?RStsVjVUcnJVVXlSREpRazhpdmZmZm51TmdRclhSU2o3WmZVNTUxYTRWSXVJ?=
 =?utf-8?B?R1RuSzRzM1JEd01namx2emk1QnlmZGNBNXh2OGxqZTJPNmlkbXRLMFdzdENG?=
 =?utf-8?B?T3IvVkJXTzcyc2VCUVd3WUpMVmFJbGExeGRueC90TEZRNHRXeFZrZVRVYkM4?=
 =?utf-8?B?d0I2aWMvRVpwbGhOMHRTZitFTndvK0puNVJEVHNHdEJIOU5XQ3YvdWh6SnJj?=
 =?utf-8?B?S2x0MjFqQ2hPakNscFFHK1pLaWlDWi81VTZEajUreXdYYUxkdkQ3c2JaRGND?=
 =?utf-8?B?K252VnArTERBNXA4K0dvRFF6Q2ZTS2M0OWViY3VDUjFPSEs2dkFkZTdkTldz?=
 =?utf-8?B?YlZJeHJRMWU0V1pPOXJJb2RGcE8vSGE5bFdFUngveTh4M0VCWkFVSGZTbkti?=
 =?utf-8?B?TkNWcHh2b1FWU01EUjIrcWtoQ3JRMStpSE0xdEp6Z3MxWDRPZGVpa1RkK2Zm?=
 =?utf-8?B?TnBINXlZRWRHOGVNeUY5cXZjUnJnUER6bUpRa0VvbjFDVFViaVhOZnBWTFpm?=
 =?utf-8?B?VnlZM1YwK0EvcW9lWUU0aUlXV01OMTFieXo2Mkwya2pqNThubWkrWTljNStD?=
 =?utf-8?B?NEQ5Y0FnZ1lOdmg4dDN6d2Z1ZFg3bnhKNVE2ZUNlR3hybUp5cFYxei9LU3ZD?=
 =?utf-8?B?dmR6aUxUTU83WTM5V1dxYzZOdXQ5Y0Z3L0x5UDhKUUpPQnp6V0lFZk1LdWxY?=
 =?utf-8?B?L1VWUGVVeStTODdSSkdKYlVieE9vY1ZKSVN2ME40N3BpY1NsbTlyWUZXSm9W?=
 =?utf-8?B?YTFGdnBuU3R3S1RwVGY4eEdHeDg2M0RqTkNteCt1a25RSWFDcElIa1JNUFNI?=
 =?utf-8?B?OEJwMVE5MnFRTWxhVURVUThrdE9wejdlaFQ2VlFzMVhkK3ZDa2ZCT1RDeHRM?=
 =?utf-8?Q?vTKenY7qrqck7SqxwvGuzxE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm10TDBUekJUYURIUVFRWTBUeGhTRW53OE5XOEpFT3dvR0oweFUzd0NUR1Qv?=
 =?utf-8?B?TTd0TUY0ZzZLZ1RQQUdyUXU0aEVjckRRQnowMGRNUzFQNVZMQXdOVGwzcC9T?=
 =?utf-8?B?R3dqQ2xvMlZvOXIxalZPOWc5ZXlycXJXRklDSjhRTXMzLzU0Z05ybEJibWpa?=
 =?utf-8?B?MGZmMkg0S0lYdi9vS0dlT0g0d0ZCYzJpVU1uaWdwTTNjR1Z0YmQ0QkR6YmVX?=
 =?utf-8?B?NTFSQzN3UndPbkdWTE1JUW5ITVVKQ09mMlcwOW4xb3hISE5wak03OHZKNFcr?=
 =?utf-8?B?ME8vejlCblZaSEwyN0laUU41dmFqVUpLQzZtWTJQam02NlJTNDRqL2NaT0tP?=
 =?utf-8?B?NzFOcmFiYTlYY1dveS9RZjE4c1VCZ3RISWduRlk5MURMc2pBcnVWRUU0ZGEz?=
 =?utf-8?B?TXlPeFVhUEV0N0hHcUJiWFhhbFY1WTY3WGVDQm5tcWVNSEtCcUNmSVg0L052?=
 =?utf-8?B?QnJnKzZhRGVBLzdpbm5qa0hRZUZOdW5JOGdqa3RMRlpsS1ZZNU1pekEzOWNl?=
 =?utf-8?B?MHhUWTlRSDZERVN5QmpnUDdpeWN2WWJMWmYyeU43aG9BdEJLT1Z4MG5Ma25R?=
 =?utf-8?B?Y2RpaFhFVXBZYzlPZ2lEQTd1UmVpakVPdGVKWUFtc2dSSGY0WGt6dlZNNEdK?=
 =?utf-8?B?WnVuVitnRnY1N0RZRUtrNjdCQlhaTXIvcXdlMFl5azdpSTFCQ3kwUUxST0oz?=
 =?utf-8?B?SndiV3l5MU1veHRFb2hONmo1MTVuem82ZnhwTGVPR3AxT1VzZGV3cWtmd0ps?=
 =?utf-8?B?azVTbTduZGxCRktNejFJWUpXL3RWOEpGVU42eStKQnVCZVpzZjh0L21FZFRP?=
 =?utf-8?B?MS9zaUZpWGxVYjFEOTJHYnliT1BqdHUvNDlPL1UrQUROQ3V1L1duRTlLVVFt?=
 =?utf-8?B?TWtQMzlrNG91NXFxcEgrSnJibTNueC9pUmxtanNVTWRKQ2dyMzBlWEp2NFJW?=
 =?utf-8?B?a2grY0Joc0ZLTVBPOFJJOS91cUhLc05TcjRBWGkzSHRJWW1ENUYvcExRTWhK?=
 =?utf-8?B?UVVCeTN2bDV1YzR5ZHBabklyeDNnUXNJQjJyMjJyTzYwQ1JoT3Z2SU5vWnpE?=
 =?utf-8?B?VG5ZaFlaSStVYnVwbzhIVmVWa1pNTzJtNGFzbHU5WEVEdmFya1hPZk9RMFpp?=
 =?utf-8?B?eFhvZHlUcnhTc2lNcVNKa1l5emI4b09jT3V5bUwrUWhoc3NlbVhyeUxibEl2?=
 =?utf-8?B?cytXeEVsMXFLVWhwMzZQL2oyMDNEZXBSVnZiaWx3S0Z1aXFDenJuQUgvV1Np?=
 =?utf-8?B?VVViZTNvazRDeWhRVVFyczhYaGVhcmxMandSYnNtVFFiNzBQR1FsWVU2TUVj?=
 =?utf-8?B?WnRpRUJTN0JiUXBhd3lhcHpEb0svY3dWZFdVNExzQXhKV3JiYVpKdEVGVm1q?=
 =?utf-8?B?Y3JvLzI2Wi83amxTNy82UGRiejhBVk83dWU0c1pHTkJ3Ymt5K0xjZjJLUGMx?=
 =?utf-8?B?S0FvUmhUTHlTdFlEdytGa21yL0FONUttS0FjL2ZNTHBkeGJpUlExdzQxUGhO?=
 =?utf-8?B?SVJVU2ZiZXhxYjBmS09HSVJXMnFOR1J1Ykt2QjBiekxJRDJnQ0psSytRY0tR?=
 =?utf-8?B?ZnJZYXU5T241S0hVSzhjNVBLN0FsY3dxRkRrOUwrWUhOZzFXeEttbkdSTUF4?=
 =?utf-8?B?dExHTzV3ditwS1VYWlNDN3RLTXB4TlA0NTZvRklmMmhSaEk5bmhLZ2tUSlAv?=
 =?utf-8?B?QkVVZlFtSkVXUEk5S2pEVFlob0R5OEIyaWIvcENBN0JRdHZ1YTgwY1U5VkFM?=
 =?utf-8?B?N1VUK3A5Smdzc3RxVkdtNVdUbEZiRXRBTDZtWG9Wakt2SElQckViWWdPRGhn?=
 =?utf-8?B?ZkJJTVVRRlFzQW0vUFZFN055M2MyeHU1YUxRWUZ3QlpUK3pVanlxbDNQYUZ5?=
 =?utf-8?B?YjZjUmoydWVhdmRQS0VtN3FPQVppNjl3b2ZmN3F0T2lTRFFDZ2lSRGticXd2?=
 =?utf-8?B?aVpaOG5rSXRNVWFpOHNLQnRNbkRKUm10c09uUHpHYk1Bb3JJMlZWVXZYMkhq?=
 =?utf-8?B?WENvVWdaYnloQmtDdzh0eCtNWDd0OUh4R0JrQldNa0FMUVdlVlQ4Znp1U3VG?=
 =?utf-8?B?MWxXN1ljNDJMSWZqTTlhczkxeTZnVzhBWmpnSDRzc1ZldUV6UjNuRWsrdXR3?=
 =?utf-8?B?QVJIVVJRUTBsQW5hdHFBekl4VVAyZi8zS3R4WTN2bG1wZVdubDBvL1hWemVj?=
 =?utf-8?B?RGlwaG1tL3U2NlllK3NrNkp0NEpEcFZodG1QOW9xRExIeGFzZ295UHZMK0RS?=
 =?utf-8?B?ekRWYnhtL2pmdG9ZUytvZUc3dTdQYVJjVVBmbUlLb2ZRU0FXbzZkTXRocHZl?=
 =?utf-8?B?Z2ZRUmkzNGlLdVZpa092RDlzTDlVczd1NlZ5TVlTaXlET1Bjckt6OURZKzMv?=
 =?utf-8?Q?CjSLW8nslwF858N91+bDDfXrhKe9iscUvJSbEGRSH6Het?=
x-ms-exchange-antispam-messagedata-1: 9mkoRvvkUI4utNpIEmsLgYlefcQOn2JMKFo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63260A0839E7D499058C1D95CF53012@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iWFrNkh8VxEtv1qRdsx4IENADGYvDfOpi6XLkKplR7pwt48Yl7Zt34MKspE3D1uOeQhtxR891aMeXmyEEkqPLK2oGTaDiak4Qe5Sf2X+r6np0tLexfKq9RKaA6w1OPGQv8Ah5PbuYn/tT+EeANGrok+I9seDWaGmyMxyI6JRNZcp82QVazlfljT3OOqJ48PCPfQkFX4nIid+u96s+NAuIUMr1B/l6DATWtr6SbKo35JV+7F6sUU3k3+G8YS3leabcACWZyiFBREFWtSxFdI3j1rjhL4jiF8kkxIwSo+6oRIsuP2z5dFVGsAFT4+sRZxv39Hr9L/TRRZ/K/z8GMGjY4JzsKlLe6G93oD5Ax4DLe+70Dq6f3I7SwBosslOf0g5c60awjlW69cAnYyy6Wp3DPKFkuxV4deRR7BgdNFsDIFAHgoYbDa8s1dD3z44oy9UqJf/6QwUWCbmCmnIysSdcr4JBhSyjl1qQBjaW75C7ZnaPrwrHL09jQnpUk6xYrxJvS9iIc8LWW/bNR/NPk264f9B040NcLNpcqXEv+uc5Y6NJxXSEYOyVMGu3MbvxL5cHLaR+7gA9zlU42wGNATh01i8+gOgDo2VDFBHnF1DL3tKl25kjhrpDAha9hBjoChE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ef3527-9e36-48f8-5002-08de6a0c5eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 07:57:29.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DE18gAiXBqjVpJp5urxpCY3lQBTodDscXhWUgC/mrF2D8kXtRBtVPrnJriPJDv9xKpXU9sPEEdG4TdJbitR1Il35IVRhaAqChZz1opw0P3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_235734_574495_1E4173E5 
X-CRM114-Status: GOOD (  17.01  )
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

T24gMi8xMi8yNiA4OjUyIEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAx
MSwgMjAyNiBhdCAwODozNTozMFBNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+
PiAgIMKgIEZvciB0aGUgc3RvcmFnZSB0cmFjayBhdCBMU0ZNTUJQRjIwMjYsIEkgcHJvcG9zZSBh
IHNlc3Npb24gZGVkaWNhdGVkIHRvDQo+PiAgIMKgIGJsa3Rlc3RzIHRvIGRpc2N1c3MgZXhwYW5z
aW9uIHBsYW4gYW5kIENJIGludGVncmF0aW9uIHByb2dyZXNzLg0KPj4NCj4+IC0gVGhlIHJlY2Vu
dCBhZGRpdGlvbiBvZiBrbWVtbGVhayBzaG93cyBpdCdzIGEgZ3JlYXQgaWRlYSB0byBlbmFibGUg
bW9yZQ0KPj4gICAgb2YgdGhlIGtlcm5lbCB0ZXN0IGluZnJhc3RydWN0dXJlIHdoZW4gcnVubmlu
ZyB0aGUgdGVzdHMuIEFyZSB0aGVyZQ0KPj4gICAgbW9yZSBzdWNoIHRoaW5ncyB3ZSBjb3VsZC9z
aG91bGQgZW5hYmxlPw0KDQpPbmUgdGhpbmcgdGhhdCBjb21lcyB0byBteSBtaW5kIChhbmQgdGhh
dCBJIGFsd2F5cyB3YW50ZWQgdG8gZG8gZm9yIA0KZnN0ZXN0cyBidXQgZGlkbid0IGZvciAkUkVB
U09OUykgaXMgYWRkaW5nIHBlci10ZXN0IGNvZGUgY292ZXJhZ2UgDQppbmZvcm1hdGlvbi4NCg0K
U29tZXRoaW5nIGxpa2UgdGhlIHBlciB0ZXN0IGttZW1sZWFrIGFuZCBkbWVzZyBvdXRwdXQuIFRo
aXMgd2F5IG9uZSBjYW4gDQpjaGVjayB0aGF0IHRoZSB0ZXN0IGNhc2UgaXMgYWN0dWFsbHkgZXhl
Y3V0aW5nIHRoZSBjb2RlIGl0IGludGVuZGVkIHRvIA0KdGVzdC4gQWxzbyBpdHMgYSBnb29kIHdh
eSB0byBzZWUgd2hpY2ggYXJlYXMgb2YgY29kZSBsYWNrIHByb3BlciB0ZXN0aW5nLg0KDQpKdXN0
IG15ICQuMDUuDQoNCkJ5dGUsDQoNCiDCoCDCoCBKb2hhbm5lcw0KDQo=

