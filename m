Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4466C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 05:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xx1Qi6leeIq5dJZncBG4UdkUZ/iK9YsPIFLUwGHQInk=; b=T+a0bB7qOi5EHBJg7lntUlgj+V
	tR8R87gBKdabWN975u+OvBH0KejOoYcbNTFn6K8a8MQbJ9yWesHZ9Aa6TSWwu4buY4xKWM0erQZOW
	t/rfrcZX9W94w1zZ0/WerEdAOEUFFwkxMTMJgEbtuWWPtqBj0F5EpcMLDukNnQmeIw1RO78Co9LCc
	EidKJp8dwfOCZMQJsB8p6AaKsxV8Lzh+8UpkXAlvaZ74+qov/sajLkYHvEROywLobIoxTX0IMMc4y
	eG0bAKq4C+T+A9e4Kz2ppUSoTxxOd+uCNVtT1idNztNZWCBc4rYPWyTIRESW2UqGr9cgxCDwtYL2c
	nZjP68ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peqqX-00Effo-23;
	Wed, 22 Mar 2023 05:17:13 +0000
Received: from mail-bn1nam02on20610.outbound.protection.outlook.com ([2a01:111:f400:7eb2::610] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peqqV-00Efex-04
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 05:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3n8n6+oTOPa8T6Wup4fp1sGsHeuCR4TwPllARIieoJMgECNjXL9b7QtBONblvu5q0cxEs0IDc1ZWMZTLKhBoi3JWwskJ7reODc+6P6THAZ/PZXXoETEvdJed9aPEk0TbRJThHmRRE+/+LXCOuBpC1IH7sk3nk/nQZJRAQkYjrgCtpaYrvX4Vw3/yYYYaViPQuemTTrirjgBl/L4xp8vf/rfIgnD5LgMnsSRzBD1NH6q/clV+mItUjCdOAgYuNx+ZrKix2ti/bMo/TSO4gOW9nr/yc60GuFjvn0TMtjjsC7gKg+clUfXLEsf0NxrdlHr0mA5OYHKLlu/4cxzuWErzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx1Qi6leeIq5dJZncBG4UdkUZ/iK9YsPIFLUwGHQInk=;
 b=mWuDtsyemHTQ9fa9Lq1L+67Bbx3w2ySDZPPxAex1UIrtD5Q8xY6WLnUgRijZeRUSMZQ33sIZCRKTzwKAdgQkEnXdHJr2bKKoiC5bGMP6cJqc10pqgPpoiKT2MYwI+FWEzoumOVni9p+f6gFGkCRy/pILGOuxi3PkehlR0aoAkbl9RDm3DmekrUIPqNN6DiTEFDbeuzMOvXWf5UGxwBvloOYMTzBWOOAojpqhvlj3Ne2y0Wc3VtGetpgW/xnl18O541qzmAAiY1bEDVi1YQqpKBOw0YsvG3WtNRrUaGPrlfnCJSYjCqyYV0Usm2DxOu/iAGxXL0UtvkLix7Gi6yRNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx1Qi6leeIq5dJZncBG4UdkUZ/iK9YsPIFLUwGHQInk=;
 b=Yd8SIUsiEjDQyzDl8Tv8uiL2mfD9j9wB8nSL/E2Xb4vFFtatgYDQicPadSMraWi7wcceP8+i1XD2eZQcfp8Je+GcZ/EenPmegIEp8wKVS+cGpawB3mXF063QevUgchFgbr8LI0BtKBxUlCW5ByO1mzJrljT6vINP4gvL2pcrBsJAB9yhRQmc0l+PYNR+V9j3aJIwYRyT0j62W7HGjdN2USxrtHqJbBv8gDwAYkd5FT5rwO4EdJdrNVc3PLv3zwXqptI5bKbC8MpAIXO0qiJR+oqBZ0aN7bSct0KvfUsOxMrjAobpLtFMBVBgvdKvrdgnD8s1iDOg48DJRq5ZMEifrg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:17:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:17:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Martin Belanger
	<Martin.Belanger@dell.com>
Subject: Re: [PATCH v1 1/2] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Topic: [PATCH v1 1/2] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Index: AQHZW1LEXdVEx1qDa0ilhWRAD8zngq8EseuAgAAisACAAW/VAA==
Date: Wed, 22 Mar 2023 05:17:06 +0000
Message-ID: <46cdafdd-6ce6-8852-7543-0ef358ffd20f@nvidia.com>
References: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
 <20230320173806.12784-1-dwagner@suse.de>
 <20230320173806.12784-2-dwagner@suse.de>
 <a46e4e5a-69e2-509c-2c20-7ea01bf94f50@nvidia.com>
 <20230321072034.drd6nhkpop72yqac@carbon>
In-Reply-To: <20230321072034.drd6nhkpop72yqac@carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 4bf41e11-3467-44f3-3140-08db2a94ae0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  agFwpwsYMKoIK4AIFdlC9GxBQVskcQq+QD+7wwq8bvVjduacvt9oyrWTxRbbDR2rt6jElIQ8D9p8HmrgIs03eHr1pPh3AvApgwPs4B957XditeXTdZR1JDEaat8SNFz5EgbJSjM5WFnMXOmX9Or26cocrSP8DEXgRth4vcuRXGftGtrBQWkLcuIa0e9Y42FTTE3gcp6nS7LjtTU9e9wsFdfk4vEkFUuOk7hyU2yzB8lz2hnxX2BJm0CCOXZW6pZ0UEMQTvzO2nbw+ACQG965DTFwEMPBBtUeuDssNR/Yf/EOXaZEXDVAqJvxdw2qKvOgYOJMhNdfU6JmcitLKaqxtVfIGvVa3n/zxi8HZzUqxlZvnMLQeFGPkmL8VlwfQJEo/i0Df7KyXZqRUpw65u3hTOMnsfCg60b4mC+9Bx4wphEpIyTrBx2fwI6TyzNZcutxxbK7SxUQYF6w67vaA9fiK2T7CFjHvVV0iLO6Z9tWW3+ProeN16jzcKYUs1GzN8TfGxSYO+Qqhsdi5rdDrXfoIxL+9wbXBeRIhgjLtN5PYrMO5FM2ISE922YG3c2rmKSFl9cg/13iVp69Vod8wa5eMhadUNJbegL7Gtqfi1Lq0SVgaFz8dvFAtxGk3dVfrOZHHI5hqTJJ4nO2Y82Pdl+sFIQR/Gfqr/MOqQsfPBp3ucpmESl2YYPmmY9CPhW/yhYDZRuJoWkjivzAhVefs8QgkDAyHqR2lhF0LU3/r3yUrVbU0pHNsmFplJDUBgrzBaIidMLHx8VRNOuYyvyn/kPjYg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(6512007)(122000001)(38100700002)(31686004)(8936002)(2616005)(5660300002)(38070700005)(4744005)(2906002)(186003)(26005)(6506007)(6916009)(4326008)(53546011)(8676002)(64756008)(66446008)(91956017)(76116006)(31696002)(66556008)(66946007)(66476007)(316002)(54906003)(86362001)(71200400001)(41300700001)(478600001)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Mk5HTThXN0o3TXhYSjlUMjdFa1RLUlJ4NEgvamxDOG9aYmJjY3ZmdkNnT3dh?=
 =?utf-8?B?Z2FnYlY5VU11THFuY2dnUSsvSVRUT2tXRHBVS2VaQWRqanhsWkRsamJyRHJE?=
 =?utf-8?B?cml4TTRrL3pkcEFWZjliNDNKTk9SNFdQZEdDckpxVG1YY2Q0ZWRxR0paV3JF?=
 =?utf-8?B?OEhwK3pXcDd5ZzZDSFkzYWYwNmZHdmp5eDRRNFl5ZzFKMnlaVjg4NmJDd3lR?=
 =?utf-8?B?WWFYU0F3ZHZaS1FiMGRJTnpsUExxYTlDeCttWWhYRTA0QW5xQXdjOG1WQ0pp?=
 =?utf-8?B?bWNwMlFNaU1Gd0w3amNLWWFXNkZqYjhBSVZCV2xZSW5tRDkzbE9QcHozdFVM?=
 =?utf-8?B?SFJJSlVNejJPMzZaMHhzM1REazRJZmFTaTRKcjhWcTRuMm03cXgwTjRkVXdt?=
 =?utf-8?B?WGVCcTB3MTRveUhlbVlwd2Z4MCtaVU95SUlmbmdtbFh0YlNXOGx2MTN2eUhC?=
 =?utf-8?B?TW8vTnpkTlRjZU1LYkMxc3RranZZMjVnQWVKbkNrSWlJa2pYWVpqa0xsWHR3?=
 =?utf-8?B?ZU1YVVhVWTJmSGFzSS9GcDNlRnpiTG92YjlqTUd3cUo3eVMxbGhrYTIvdS8r?=
 =?utf-8?B?OGVudU84MG5nYS8xbXdNSGVRbG5ZVzB0aUR0dHFKNUR6bVBwbWJqRnZvV2J5?=
 =?utf-8?B?UG9XL1RVYzFDSERLR3R6bnRVTkY1L2lFRXhYY0pXemRkeVdyYjh6QkQrUTZF?=
 =?utf-8?B?eWhaa29ZU0hTb3paUHIvdUVYa2Nhd1BsYnRWOUpneFJISERoNFZNamZxNXZM?=
 =?utf-8?B?RGlLR0RYNXpDN1p5czlLTVdqeEFwYUlyeVdxNy9hTjZqdktNbjhxN2Q4VlVW?=
 =?utf-8?B?Vm5VOUkvUnRvMzZ2RUlVaHE3b1U3UTRLZ3F3aElFazF6eGEwQ0VRVUxTUTBz?=
 =?utf-8?B?eU9kSCtEbGhzc2lnOG1SSGFPaFBoVVJVMzFCcGNJTHRhWGZrditJZzhBb3Bi?=
 =?utf-8?B?NURva21MK2pVWUZpTWtuT0Y5Mk4rU1FvSXRWb1gzS2pvUnZqUHZBQVpEenNk?=
 =?utf-8?B?dzlDdGRzTFYwYjFTVGlmV2lubHVGcEx4ejlrdlE5TzNGMHlrRHZzRUZYakh1?=
 =?utf-8?B?R0lRcnNEK05ZUk1wU0I5VUZHR29zNmlhVE5JU2ttQXA1MDg1WDRjV1VWRWE3?=
 =?utf-8?B?UVJIaURJUmdSYTJ3eGo2d2RRWFg0V0tSckcxRXhmVzJoMFUyRHNRZXJZVE1o?=
 =?utf-8?B?S24ycEpyMFhkZU9GUzNrdldLSWdmTHRDc1VwRzVyM09RZWFiYmQxZVVOL1pk?=
 =?utf-8?B?dDhYOTYya0ZpOENCamwrQnNjUnlMSGFIelRhY2h4QkgyeDBNU1Y5bTY3bUd6?=
 =?utf-8?B?Q3BRNVJZOGZzUGhzUzltR1FudFRVampJVFdIbU1JSzJBTXVmWGd1Smx2VWEx?=
 =?utf-8?B?a1VQUDdQQTAyaHYrSzYvZTlEUWtUTFhoa3lxWk02YjVHSzVSMDFLVUNkSlRu?=
 =?utf-8?B?YVdyN0w3QTdLQjdZK2NjUTh4T1FCTjYwMnZodjhxbVh0aGQ1QXVXN3VucFdG?=
 =?utf-8?B?M0ZqRDJJdnU5UDBIUVl6dDZYSWlteUZCV21xeXA5R2JPVmxmdmZnRmc3TWdB?=
 =?utf-8?B?VGtsNnFlSVphZDFZZy95ckdkanJvTnQ5eFM0R3JTV1dsVXRyNEVGbU8rRW4w?=
 =?utf-8?B?OGQyekFFMFgyeGR5eDRxckRSRC9VQ045SURCUU9zTDFQMlorRTRoY1VpRTBH?=
 =?utf-8?B?cCtKWDhOQkFSOFIwVjhEcWFMMVFYT2JYc0RrNXdkT09KUlFRWVpYOWRYUXBj?=
 =?utf-8?B?VnAyalp0TWgyTFpDaG8rSVFYM3kvOHRnUlh4UnFaWElQNW02ZFNzUVp6RjdI?=
 =?utf-8?B?Q25tOUNDVTF3ek9odmE4cXM1anZWd2lESVJ6Uk5QdGZENHNyZ1FDOGxxb2l2?=
 =?utf-8?B?UlNtNUUyRXpWdHVJYU1KSVNCWUR6L05CTmRTQ2lnanE1V2ZITklIdis0NjFo?=
 =?utf-8?B?N0MyMzl6cHdxT2ZCWUFIeXlzRXpQVzN0L09vcFVrS1laaVJRYXMzQmhmY1B0?=
 =?utf-8?B?M0xLTDY3MUlBQjZKZUdHRklLbGFwYlgwZWltRkw2TGNEeXdRM3FEZG9CcExI?=
 =?utf-8?B?N1dFN3ozN0JKZUhadG1pRDFDdTBsZ2RsblZzeFc3dm9MeDNZNHhTNGk1NjRy?=
 =?utf-8?Q?/RYqqYpkBUO8pN2Qwf3P82qMF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A801C6C6F54548499599B8B5DA81A3C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf41e11-3467-44f3-3140-08db2a94ae0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 05:17:06.6461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6r+D00licfDzwPtJRNbjQzDkKHYwBiNZ6l9zqcU/fZ8l0p+fp5v/2TLxTlFSbX69Oq+qWOUt7Gs9dy0vTHH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_221711_088674_3A331D90 
X-CRM114-Status: GOOD (  13.05  )
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

T24gMy8yMS8yMyAwMDoyMCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gVHVlLCBNYXIgMjEs
IDIwMjMgYXQgMDU6MTY6MjVBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+
ICsJc2V0IC0tICIke3Bvc2l0aW9uYWxfYXJnc1tAXX0iDQo+Pj4gKw0KPj4+ICAgIAlsb2NhbCB0
cnR5cGU9IiQxIg0KPj4+ICAgIAlsb2NhbCBzdWJzeXNucW49IiQyIg0KPj4+ICAgIAlsb2NhbCB0
cmFkZHI9IiR7MzotJGRlZl90cmFkZHJ9Ig0KPj4gY2FuIHdlIHBsZWFzZSBoYXZlIGFsbCB2YXJp
YWJsZSBkZWNsYXJhdGlvbnMgYXQgdGhlIHN0YXJ0IG9mIHRoZQ0KPj4gZnVuY3Rpb24gdGhlbiBh
ZGQgdGhlIGFjdHVhbCBjb2RlIGluc3RlYWQgb2YgYWRkaW5nIGluIGJldHdlZW4NCj4+IGRpZmZl
cmVudCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgPz8NCj4gU3VyZSwgdGhvdWdoIHRoZSBhc3NpZ21l
bnQgY2FuJ3QgYmUgYXQgdGhlIGJlZ2lubmluZywgd2UgbmVlZCB0bw0KPiBnbyB0aHJvdWdoIHRo
ZSBwYXJzZXIgc3RlcCBmaXJzdC4NCg0KDQp0aGF0J3MgZmluZSwgaWYgcG9zc2libGUgY2FuIHlv
dSBqdXN0IGNyZWF0ZSBhIGhlbHBlciBmb3IgdGhhdCA/DQoNCg0K

