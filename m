Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921F0E7716C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=692+AQwuTDAPTIfgg+o2BlOO8aRj39+a8aMXLqItFKI=; b=ATRsTGwgagFJD77Zi+UsLjBVm0
	0hajx5JlwOGid5diF+9nQFtcWQGWVgTsZT0clEcfAo2TVXy9vFMDrdchJ1i1O1zbGeAls/5FVNCmb
	41b6QA/wVVT+KE94i3Eoj5trEbrsXF4vjwNSdVug/+nmMFKRLzqLJK2PVB01vMI9R/qw468BwUnGZ
	OXaTKNGJqL4gJa3WYpycKBzZ+e6BfaMz3EoX5JdGLb4OtQq/i51ntKN7idD3riHGSw0EY7ykoMuuG
	zxGAJSAv9axH6Hprc9yHIhFrGqFGqDBmixWDy0bAfcl79qz5IBj5HBD1TdkHBUjwTJupiv1eO4cGM
	N5QATLoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ6Ms-0000000F1sw-2rKi;
	Thu, 05 Dec 2024 07:33:46 +0000
Received: from mail-mw2nam10on2060b.outbound.protection.outlook.com ([2a01:111:f403:2412::60b] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ6MB-0000000F1dy-01Tn
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 07:33:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsB4jJb1QfILE8YQAftn1ria4lRfo6PuTb3g1ft5w22YcbAnT4ufBWCFjepqE8v3vAxkKsMEOum/RxEYqNAZO2AEA1rVGjcI3zGewcl0erXELxtmm9+BmYuOxXUsPxk3yPz2QTSYuP05obIV/mx6z/ob8RmwpQN9/U46sADHNvQRw8ytynSDEKP/zCJXSRfEcjVvq4trm341GbaeNxxNlX7YYxqdp6YI9POt6F1kWtY/PhpbLduASfBQOEiGg2bIxlTzIK9gJr9R99rSle3QWZjVO0mzdkyhmx4JUB6zR5VjlFAdX48ivQOo6n46gujaYW6E8GxoK4+MtLn0/EeZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=692+AQwuTDAPTIfgg+o2BlOO8aRj39+a8aMXLqItFKI=;
 b=XkvFlH8u6GPmjD6nYoJbqQr007MeLV9n9seEg/CNqLeH/70z5Pl6bfvPexpaZhtshpr9XbgsK2ZJr/5zgu7Wt3oGiuEJR4ZpNA77hFv4pVmVKheB8qF4EA6ybcQZJHuPpiWftm9e6gZ7owUEEDSyjntvpCfnItmydbF1fSIEnI/4pkf+FvQNiw6og6eWHH9/NFK3CeQ2EkCh36XNCxiFar97N5k61xooz4h0JL05Z98B4+1/ezdgRvPT1FzsmMVLPSLBydnsLV12rOZIVfSQIKjm6cQcthYbYH2x+w85ahqHKFTpq52NGU8rHyjBMSlqNHANzPCCp1xc8Jzcjn2Gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=692+AQwuTDAPTIfgg+o2BlOO8aRj39+a8aMXLqItFKI=;
 b=PjxJXdDRvG8CsfE/GAG6mQKftlgc6CeH8KSCrna6ucyJ0HdRO+q/YpNmiOA/hqmED7rrlnrVGQoV5rz7/1ZKwEZ2kX1wF/9imTkhLn4fyNb9RAeqUn32d4JJtMkmVorTRTBpKDh9LJltMHcTkZCuNVhf8dVAN9zlaidEhXeP8iBHJsnQ/037Q4eT6XmsK1HDihfPkY7nceRBLrPhRjoRTiPxkqcxUfKnq2otwL1t8K4VIGxe31ZbblgKFn2p6jdOXFjol+8uTMk0iRJ60ZT3RSyjN2DYSLrRdD0SVo/toWDqF3YsxEGiQDQQDKj+0vhQMlammKptuuoirOx9f7aGZA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 07:32:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:32:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Nilay Shroff
	<nilay@linux.ibm.com>, "dwagner@suse.de" <dwagner@suse.de>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just
 after disabling it
Thread-Topic: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns
 just after disabling it
Thread-Index: AQHbRkJqWILH7zOT9EC5U/i38vIXyLLXQ0eA
Date: Thu, 5 Dec 2024 07:32:55 +0000
Message-ID: <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
In-Reply-To: <20241204114755.190660-3-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7247:EE_
x-ms-office365-filtering-correlation-id: d32b98bc-3172-452e-9087-08dd14ff0935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WnBRS1lHdzhhR09FT3hJang4YUxMWnNodGxGRFNiUmNzM2ZNL3BLTFFUb3hX?=
 =?utf-8?B?NmMzeE1lZEtESllyQ2N0KzJyQ0g0UnM4bjdyMVB3RXNML0lLSldhOEt2UTlp?=
 =?utf-8?B?MDNDS2FmVmNTM01xT0hkaVpESjNUWWtyY0dvdkQ4ZE5CVHdIbzJzKzllZlJ2?=
 =?utf-8?B?eDduc1NiRFhmR0ZxdEx6aDFvWk1mUjdwL1kycklxSG9jbWV2cU95WmN5TFJG?=
 =?utf-8?B?WjlDRnFUQ1dyWnoraUtGd2Y5YnFLRFVIMDFhaG9BbGFUVG1PZHVBTHpGVnNK?=
 =?utf-8?B?UFZHQ0dvd1M4QURVWFRXOUYwczMyc3JKWm55S0dYUFkrQTZxdy9oUys5dWxS?=
 =?utf-8?B?TmtOcDZBSlpJQys0dnJtZ0Y5OFdyVVJmL2hZdFBMVzZITnpkdDFHczNJd0I2?=
 =?utf-8?B?RnE5dkhScHhvY29wdENnWFo5Rjg1L0tlenlIY01KeTlLN29iMDJ1YkJUck13?=
 =?utf-8?B?NUEzcVJ3cUVuUHlnZFphUFZrR0k4MCthV1pOTUQxcEQ1MTMwOEE5THd4QU5U?=
 =?utf-8?B?WktHcHY2R0pHV0FFK0ZsaE1ncSt5bE9CS05TeWJJdWNidlh6TjhsSXVQS2Fi?=
 =?utf-8?B?NnRxOUFYU01iSzdqQyszczVlVTJVZjFaVExtUENEQW5XVG9pcDhwcmdsR0U4?=
 =?utf-8?B?Y2ppOG5tSWY0Yy9vRW9BRlN2N05VWkRVVVNidDJYZDhqb1FidnVpaGZTYy9D?=
 =?utf-8?B?U1E5bkpMVkVvSHZtVlI5YTlFeXlXUzl1RGdrWmlRQmF2TXREUlVqaUlaWVgy?=
 =?utf-8?B?RTNobDVRM011Y1dFUWpoWWZ2OFEzWFh6c1NQckpIRU8rNkJhQ1JSQ2RwWVhI?=
 =?utf-8?B?ZWU0R3VpRkV4QXZvOFhaQStyT1dDZi9XZGVBRlZSUUhybWFyRlB6ZW92SE00?=
 =?utf-8?B?V2g4Unh4bHJGYkc3MFJoRGkrMFpKM040eHNNTm5Xa0RwT25rMlBMN1lQSmND?=
 =?utf-8?B?UTJTSHIyNzdmczNQZlcwQ0Z0MHdrUjNhb0l3ck5PMm1Ob0d2ckRRL3pEcTlo?=
 =?utf-8?B?WGIrbXE2YTNicG9jbDhkaGZvOWtuWUxIMS8xdnBjZGc1dllnYkNzYml0WEt1?=
 =?utf-8?B?VTh5RzYwMWQxUGNXUHdHQ1lhMyszUjdPOUNJMDdaeDVoOTJJUnNmU1I1eXpU?=
 =?utf-8?B?MUFYcCs4YUdhZUJWSVpRY1pQMU04SjJ4Q0phT1pkTXphdGhvbzE0SjI2cldP?=
 =?utf-8?B?RmhlSk9MbzN4Z1RRNm1TdVFjampWTm0rTnd0RThMcERUWDBPTWJrK2NmT2hZ?=
 =?utf-8?B?cFQrMHhFOVR1VU9QOGlvdi9kN29xTGUzMkFFZFQvMU1yMWQ3TkViRUZuMjN0?=
 =?utf-8?B?eUNZdEUxY2pPeEF1SWV4cVZXQnFIK0hxRzNaUW10L2NneFBORGdmaXJra1BY?=
 =?utf-8?B?UXV4aEE5QjU1VHdmY2RlMlRnNmJ6bGJjWXJHWnpWa2UxMGEwdDNScmVrd1pV?=
 =?utf-8?B?dFpSWjdUa0ZvVU1qNnZDNllzaTBuMDdvb1gzUXpTQktVMC8yMzJYZWNUb3dp?=
 =?utf-8?B?S21QR2xRSmszTmNoQml5aTN4ZDBPR0U1cmxWY1p0bXh0VitORkRxM1VpMzR6?=
 =?utf-8?B?OEQrTWVLVVoweXh2WXNlSzk3ZDlpdm5mdHRFbnhHTm5LUlVseDF2SGphRWx4?=
 =?utf-8?B?QWRNTW9XRG0wbi94TDhHRTMvV2tad0pRaEFXUFFZVjlkN0tnVCtlcDFva3lq?=
 =?utf-8?B?aEF3Qzg2YlcrcGF0SVhhRlhvcmVwNHY1NkR3SVRrNGdhMS9hd0dtQ3FmSDFv?=
 =?utf-8?B?ZGFhVGxqYVNyVXlpL0lwaEo1Qlo3cEYycVZFSXl6SFdhQnhCUncyTzcraHM3?=
 =?utf-8?B?cWIvQlFHTVc5blNVT0dRNlBDNmJ2WVp0UEVBRCtWWWp0SFVVRWdHRmdWOWtu?=
 =?utf-8?B?V1QvRVRVUCtjZTA3V0RNZmd2dnRVSUVUK2QvTXFjaE9GM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STl0QmZXNGxheWNaMGxVbGRaYlZjNHQ4Y2djd0czaVRwZHh1OUV1M2lzMUZL?=
 =?utf-8?B?RjNQdE56em9uS05vSTQyMTdRNmhZNTgzSVh1VVVYeENyR2gyN284Y0RhUzBY?=
 =?utf-8?B?ejVXcW1TVFZ3REE5TWpvRDA0SVpZQ0EzQWcvWXNPdFRHdzh3cFFObFE3VStV?=
 =?utf-8?B?N0p4ZTFTdEdhd1FHOGFtWGE2SCtnNXQweGhNVEJSS2tNOUR2QnoySmFKZTQ3?=
 =?utf-8?B?WWFOejdqMmhEeW5Ldy94VWV0SnVIV2trUWM4R2I3WkxKckkzTzZRaHJUc0Nr?=
 =?utf-8?B?alNoUDZqcm1qZ0FmeDhRTEJaQThoZ2txN0RNanJDRUVpK3ZIK3E5UFVQdUNM?=
 =?utf-8?B?U1IzcjVYQTFiWXl0SU5VVkNnSTJxSTAzU3JFT3VCQktnZHMyczMwZnlnbGNs?=
 =?utf-8?B?YXRCWk13VU5sUTVraWRiQjlpWm9sQUxQcEN2UTdGUlNpSEsxQUpoaDgyM1FN?=
 =?utf-8?B?MUJLd3ZjSERoOUVTL0IxQmY5bVBVdXplWVRQQ3BseURrOWtVdmRjMDdwMnlB?=
 =?utf-8?B?eE9FRUNnYzIzU0JkcHlzU2kvanUwODN6QmR6MEF4OGcxS3V5UUladk1mMU1B?=
 =?utf-8?B?WWhDYWhkaFR2S1VaQmVLWU8wUkdERi9LSDRnY3lGTTlpMmZmVG16K0VVUWdB?=
 =?utf-8?B?ci9nZHhTdEU5V2RPN3pVdzJCQmZiOXNHRE0zVWp6VzhKR2QzUnNCWG5NVWFu?=
 =?utf-8?B?cHZTNklmcXNTNk5WYXlaTDd3WjkvZEd5U2wxTDhOQUE4RWgrUTlEMStUMm45?=
 =?utf-8?B?YlRhVS9NWDRIN2w1RUdSOTdOazYyK3hWejFnbjJ1ZWl6MnRpOWhvSlYyUk5D?=
 =?utf-8?B?bGZJc3dDTVorTHNKUUlLSWN3aEphdWtyYjFKSnhRaGQ4b3pLcUMrRXZsQU9w?=
 =?utf-8?B?Q2pqRUFCRnptQldFdUNCbnhWOHRvYXA3SDR6RjVFbXFVdklSN2l4RjlaUVA2?=
 =?utf-8?B?SWYraXRSeDJ2R283cmF2a3BBd3hpcTZXNjF0cUlKbEJMb2NBS0FIdk9NOXlL?=
 =?utf-8?B?Q01PS2NEaG5FWFNXMUtqUmJyZGp6bG5JYzBMTnZwRk5vdW0zcmphMGxrM2tp?=
 =?utf-8?B?Mk9VVjkrTUE3WTQvTjV5SG1zSEwzNXdPak9hcVpUZHAwOUJWcHFzOG10ODJJ?=
 =?utf-8?B?YnF1SGhYb2RjbjYyOGdST0UvU1RhVmFpOFdDUDVoRlMxaWhlN3M5OHJwRXVl?=
 =?utf-8?B?TUdyV2JlVTd1dmdGb0orSVR5QWZLUDhOUWNUdHBaVGJUc2FENGNlYXVnUkRD?=
 =?utf-8?B?cFR3MU1zUVlDSmU5K2JIZXpucnNuNTlxZ3NiT3IzdmpmWnZKOUNuV1BkcVND?=
 =?utf-8?B?VDhENmp4b2U2QTVMZXYxMUN3dnpJWFdHQTQxbC9pVk9uemVGRDB3Q2lvcUxP?=
 =?utf-8?B?Z1BxSkRPUWFjdW4vT24vRml3NkYxTGsyd2hKOWFGQi85ZGY3SVlFMEM4M1ZT?=
 =?utf-8?B?VEs2NERMWFB5bmtGQUduOXZranNzbVpOdUxxTEJMOG9qUXlBTVB5emxHQ05x?=
 =?utf-8?B?NDJuZk9PREpORlY1RTh0WFFpYjV6c1ltUm84bHRhb1daOHlpQkI2c0w0Q0NS?=
 =?utf-8?B?cmFkOWN0KzhnWlN3Y253YVE4dHVLdkYxejVCUVhXVElIaE1rdk4yU0xYRlpZ?=
 =?utf-8?B?K1NpWlZKL01tWHQxYUJveWFlWE9Gb0FSZ1dqS0JORnRvUkF3bEZLNTJwQTF1?=
 =?utf-8?B?bkpjWkNBckxZWkFQRHRtbGRObHBFR0gydEJ2clFmckd6N2RwQmEvdndNeFV5?=
 =?utf-8?B?YlRCeitTRy9zZGlpcDNRNTNFQXpwVStsbmVBVkdnWDMzZHRUK3VlMjg2OUF5?=
 =?utf-8?B?bUM3YkpJdS9teFVPTW5kN2xnS2FCcTZHWHFwM2dlUnR0YlBJM0lob3JOSktM?=
 =?utf-8?B?RElZV01jc0tNTXh1NWx6c3ZzOHZlZk05OE5XUWlPbVJQN09KQ1M4MjFWQ0hV?=
 =?utf-8?B?bVpzbWtMV1pqYld4Z1huQ0NsVnBLQzduM1dpSTAxakxoYWJMUFNGcEMxUDc4?=
 =?utf-8?B?V0pTeDl3UjN1M21SamVleTNPQ1poWlI0YUlTNkJxTVU1RW8weGFHVTVmRmxj?=
 =?utf-8?B?RFQvTnJnUGdkd29SL056U25NSjlCRzlTQ3dmWnk5bHZzbmlaRGtPTHpBTlh6?=
 =?utf-8?B?RnRuY1lDQ2l2REtqMlZUdXF0VFdGdnVqb0t1OVpBYVpGb1hCaElrSXRwVnJ1?=
 =?utf-8?Q?v7BBM9EWjbmvhzMMlbyWJvJFm1+vSJhA4Qr5/g9P4rRM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5491CACF4C07A64E8D59FF465F2171B9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32b98bc-3172-452e-9087-08dd14ff0935
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 07:32:55.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoSRWnwewOY1KqomurJyUb3OI/8zlYXp3qplXXlTiguPHeuhBskgrcCVpuvDq3x523laXOkgf40ZvGqsgsjE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_233303_059468_9679B6FF 
X-CRM114-Status: GOOD (  16.06  )
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

DQo+ICt0ZXN0KCkgew0KPiArCWVjaG8gIlJ1bm5pbmcgJHtURVNUX05BTUV9Ig0KPiArDQo+ICsJ
bG9jYWwgaXRlcmF0aW9uPTEgaT0wDQo+ICsNCj4gKwlfc2V0dXBfbnZtZXQNCj4gKw0KPiArCV9u
dm1ldF90YXJnZXRfc2V0dXANCj4gKw0KPiArCV9udm1lX2Nvbm5lY3Rfc3Vic3lzDQo+ICsNCj4g
KwlpbWc9IiQobWt0ZW1wIC90bXAvYmxrX2ltZ19YWFhYWFgpIg0KPiArCWRkIGlmPS9kZXYvdXJh
bmRvbSBvZj0iJGltZyIgYnM9NTEyIGNvdW50PTEgc3RhdHVzPW5vbmUNCg0Kd2h5IGNhbid0IHdl
IGp1c3QgdXNlIHRoZSBzdGFuZGFyZCBibG9jayBkZXZpY2UgYmFja2VkIG5zID8NCg0KPiArDQo+
ICsJc3Vic3lzX3BhdGg9IiR7TlZNRVRfQ0ZTfS9zdWJzeXN0ZW1zLyR7ZGVmX3N1YnN5c25xbn0i
DQo+ICsJbnNfcGF0aD0iJHtzdWJzeXNfcGF0aH0vbmFtZXNwYWNlcy8ke2RlZl9uc2lkfSINCj4g
Kw0KPiArCXdoaWxlICgoIGkgPCBpdGVyYXRpb24gKSk7IGRvDQo+ICsJCSMgV2FpdCB1bnRpbCBh
c3luYyByZXF1ZXN0IGlzIHByb2Nlc3NlZCBhbmQgZGVmYXVsdCBucw0KPiArCQkjIGlzIGNyZWF0
ZWQNCj4gKwkJaWYgISBfbnZtZl93YWl0X2Zvcl9ucyAiJHtkZWZfc3Vic3lzX3V1aWR9IiBjcmVh
dGVkOyB0aGVuDQo+ICsJCQllY2hvICJGQUlMIg0KPiArCQkJYnJlYWsNCj4gKwkJZmkNCj4gKw0K
PiArCQlkaXNrPSIvZGV2LyQoX2ZpbmRfbnZtZV9ucyAiJHtkZWZfc3Vic3lzX3V1aWR9IikiDQo+
ICsNCj4gKwkJIyBEaXNhYmxlIG5zIGNoYW5nZSBhc3luYyBldmVudCBub3RpZmljYXRpb24gZnJv
bSB0YXJnZXQuIEl0DQo+ICsJCSMgd291bGQgZW5zdXJlIHRoYXQgd2hlbiB3ZSBkaXNhYmxlIHRo
ZSB0YXJnZXQgbnMsIHRoZSBob3N0DQo+ICsJCSMgd291bGQgbm90IHJlY2VpdmUgbnMgcmVtb3Zh
bCBub3RpZmljYXRpb24gZnJvbSB0YXJnZXQgYW5kDQo+ICsJCSMgc28gZnJvbSBob3N0IHdlIGNh
biBhdHRlbXB0IHdyaXRpbmcgdG8gYSBkaXNhYmxlZCBucy4NCj4gKwkJaWYgISBudm1mX2Rpc2Fi
bGVfbnNfY2hhbmdlX2FlbiAiJHtkaXNrfSI7IHRoZW4NCj4gKwkJCWVjaG8gIkZBSUwiDQo+ICsJ
CQlicmVhaw0KPiArCQlmaQ0KPiArDQoNCkknbSByZWFsbHkgbm90IHN1cmUgZGlzYWJsaW5nIGEg
ZnVuY3Rpb25hbGl0eSBmb3IgdGVzdGluZw0KcHVycG9zZSBnaXZlcyB1cyBmdWxsIGNvdmVyYWdl
LCBmb3IgYSB0ZXN0cyBJIGJlbGlldmUgaXQgaXMgaW1wb3J0YW50DQp0byBoYXZlIGZ1bGwgZnVu
Y3Rpb25hbGl0eSBydW5uaW5nIGFuZCBhdmFpbGFibGUgc28gaXQgd2lsbCByZWZsZWN0IHRoZQ0K
cmVhbCBzZXR1cCwgZS5nLiBmb3IgdGhpcyBzY2VuYXJpbyB3ZSBjYW5ub3QgZGVwZW5kZW50IG9u
IGRpc2FibGluZyBBRU4NCnNpbmNlIHVzZXJzIGFyZSBub3QgZGlzYWJsaW5nIHRoZSBBRU4ncyBl
dmVyeS10aW1lIHRoZXkgZGlzYWJsZSB0aGUNCm5hbWVzcGFjZSBhbmQgZW5kcyB1cCB3cml0aW5n
IHRvIHRoZSBucyBvbiBob3N0IHNpZGUgdHJpZ2dlcmluZyB0aGUgQlVHLg0KDQpDYW4gdGhpcyBi
ZSBhbiBleGNlcHRpb24gZm9yIHNvbWUgcmVhc29uID8NCg0KU2hpbmljaGlybywgRGFuaWVsIGFu
eSB0aG91Z2h0cyA/DQoNCndoeSBub3Qgc29tZXRoaW5nIGxpa2UgZm9sbG93aW5nID8gKHRvdGFs
bHkgdW50ZXN0ZWQgYW5kIHJvdWdoKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rhcmdl
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYw0KaW5kZXggMWY0ZTk5ODk2NjNi
Li5lZWRlM2E3YzU1OTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYw0K
KysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCkBAIC01LDYgKzUsNyBAQA0KIMKgICov
DQogwqAjZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9NT0ROQU1FICI6ICIgZm10DQogwqAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQogwqAjaW5j
bHVkZSA8bGludXgvcmFuZG9tLmg+DQogwqAjaW5jbHVkZSA8bGludXgvcmN1bGlzdC5oPg0KIMKg
I2luY2x1ZGUgPGxpbnV4L3BjaS1wMnBkbWEuaD4NCkBAIC0xOCw2ICsxOSwxMSBAQA0KIMKgI2lu
Y2x1ZGUgIm52bWV0LmgiDQogwqAjaW5jbHVkZSAiZGVidWdmcy5oIg0KDQordW5zaWduZWQgaW50
IG5zX2Rpc2FibGVfZXJyb3JfaW5qZWN0Ow0KK21vZHVsZV9wYXJhbShuc19kaXNhYmxlX2Vycm9y
X2luamVjdCwgaW50LCAwNjQ0KTsNCitNT0RVTEVfUEFSTV9ERVNDKG5zX2Rpc2FibGVfZXJyb3Jf
aW5qZWN0LA0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiZGVsYXkgeGFfZXJhc2Uo
KSBpbiBucy1kaXNhYmxlIHBhdGggaW4gc2Vjb25kcyANCihkZWZhdWx0IDApIik7DQorDQogwqBz
dHJ1Y3Qga21lbV9jYWNoZSAqbnZtZXRfYnZlY19jYWNoZTsNCiDCoHN0cnVjdCB3b3JrcXVldWVf
c3RydWN0ICpidWZmZXJlZF9pb193cTsNCiDCoHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp6YmRf
d3E7DQpAQCAtNjQ5LDYgKzY1NSw4IEBAIHZvaWQgbnZtZXRfbnNfZGlzYWJsZShzdHJ1Y3QgbnZt
ZXRfbnMgKm5zKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF91bmxv
Y2s7DQoNCiDCoMKgwqDCoMKgwqDCoCBucy0+ZW5hYmxlZCA9IGZhbHNlOw0KK8KgwqDCoMKgwqDC
oCBpZiAobnNfZGlzYWJsZV9lcnJvcl9pbmplY3QpDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtc2xlZXAobnNfZGlzYWJsZV9lcnJvcl9pbmplY3QgKiAxMDAwKTsNCiDCoMKgwqDCoMKg
wqDCoCB4YV9lcmFzZSgmbnMtPnN1YnN5cy0+bmFtZXNwYWNlcywgbnMtPm5zaWQpOw0KIMKgwqDC
oMKgwqDCoMKgIGlmIChucy0+bnNpZCA9PSBzdWJzeXMtPm1heF9uc2lkKQ0KIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdWJzeXMtPm1heF9uc2lkID0gbnZtZXRfbWF4X25zaWQoc3Vi
c3lzKTsNCg0KDQphbmQgYWRkIGxvYWQgdGhlIG1vZHVsZSB3aXRoIG1vZHByb2JlIG5zX2Rpc2Fi
bGVfZXJyb3JfaW5qZWN0PTEwID8NCm9yIHdlIGNhbiBldmVuIG1vZGUgdGhpcyBtb2R1bGUgYXMg
YSBwYXJ0IG9mIG5zIGNvbmZpZ2ZzIGF0dHIuDQoNCndpdGggYWJvdmUgY2hhbmdlIGZvbGxvd2lu
ZyBzdGF0ZW1lbnQgd2lsbCBibG9jayBmb3IgMTAgc2Vjb25kcy4NCj4gKwkJIyBkaXNhYmxlIHRh
cmdldCBuYW1lc3BhY2UgYW5kIHdyaXRlIHRvIGl0DQo+ICsJCWVjaG8gMCA+ICR7bnNfcGF0aH0v
ZW5hYmxlDQo+ICsJCW52bWUgd3JpdGUgLS1zdGFydC1ibG9jaz0xIC0tYmxvY2stY291bnQ9MCBc
DQo+ICsJCQktLWRhdGEtc2l6ZT01MTIgLS1kYXRhPSIkaW1nIiAiJGRpc2siIDI+PiIkRlVMTCIN
Cg0KLWNrDQoNCg0K

