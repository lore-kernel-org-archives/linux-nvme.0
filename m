Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB2FC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 04:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V0Ai75mOm570RjFgb+/CcU7hcxL6GuQ7vilso8afa24=; b=RFTHFh5TLBSueYmFkAAJfIgMtf
	+n3DxkUa0DA+waJV94ADNtra9BdqsrnMq0m1j9k5Py5u8/5xzuShCiU1rBCYSZpV/wOcjUkzCl+O/
	Upk7AkUr2p1E6qrXyXwkS6/qrSkc1wtoFxThhSSM9CC3ZO1L/iDjiCGfpBEFgeygcx9gW26byr5jq
	oNr42l/28EKOICawWC25kwurjwobeUDAslE1HspQFQMvg1fp8bPji5wUa4U1YmR/a+7U6WrjSvY3M
	mOr3RhtMucpoav60+mVklkAK7fSW1HVDWKHFfDd0qSYVYXymT+SMTR2SwDwkXapfk3ZtwBkXLO73+
	YpPnn9Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxJKK-00000000tPk-32b3;
	Thu, 18 Apr 2024 04:24:48 +0000
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2408::600] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxJKI-00000000tOr-1cFF
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 04:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU7ZrVTlsU61ak7o/5zZmtKJPDD/ldH9Ox9zM8RpWfuoE6i2IEC8b7yEao8YigR3JEf61PpTy0++Bj2jom6ffvRlAnsYlrogKsEIlfy49c9aNMXX3JRmOv5KF7SHnu8ewJP9GICTROt1r4a34jPL0hJz1pMz0PhDVow6GmZXYIqG3q7fMoqt7tblFDkkGEQBbsRaZMtOr7Fq+t7V9QcyBb67o5Y9rHYy+lnGP6UZT5soLWkkQTVd8dRPgebFhn1lSBNk0TQ7EL4++PGVSrXduCwMRm1/hfRzkIamh72yIgeyXMhanjnmX8GzhrlnG0e9baSW57bUmskhx/Y22lnx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0Ai75mOm570RjFgb+/CcU7hcxL6GuQ7vilso8afa24=;
 b=TbDVU6Q3C4OQl0vbruOOWQ8A0KgkQg3y1vldEn8OGow0VQWJofoVgG+hOsLgoeXHqTxtiQUXquAzf7wQ+AJ1lPWHQADmWXD5SgYhmcZxD5jfCu+veuPjsF6Fh/ScoZI6sE0skGhit/9aK0ZKu7OzPA2CvEMFPynDioQ+JGa2Yb0IRHLmC7IEh+x2FBysTCKCGyJfyoSIDJZLA/ae5/+f+6ozmyFHD+Vd+UziPgT9CylY9jZrWYa3y6WDoDCitFbcrRrnXsIwJDqrpLnzjL5URaOrNLMp2oU9yOix1HtlXRHsgFe3LJdNmvFtIXN8tqQmn60Y9JEAUgYzxSNoL2SizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0Ai75mOm570RjFgb+/CcU7hcxL6GuQ7vilso8afa24=;
 b=rPeXIgzfAw0VGa5dSU+t5KwF/FOitxGWxiIoQQDaYAgkdLyU3WCueHU4Zr73ff2FDBbw1D1bzIBg+V9KUT1+7zCUbuBZgvpfa74ZavUXRlqyUiPVECnKjv0S5suXtQsZLVQ4oNDqilFZgFhhDPQZ/ZAH+yA4uhmOSBibo5/BS31gAkapALgkKOgMZqys0FMQUidSJcBJN8dNG6d//7D5NfBD/B3halPxCmo9sZh/QmfoC2NOBd0DTfz4qv3iNNiUsmA+IopybiDYn+J/FmA8sLmuKl89v44Gmv8L2hC//p8vd6XhAXRvu//cq+o3eytWPgUQiWypUyk/Qi70ZbVv1A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 04:24:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 04:24:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/3] nvme-fabrics: add post connect auth code helper
Thread-Topic: [PATCH 0/3] nvme-fabrics: add post connect auth code helper
Thread-Index: AQHaWleHSwGRjK9xZ0u7skhDOgpuirFqrpgAgAMtVoA=
Date: Thu, 18 Apr 2024 04:24:31 +0000
Message-ID: <374b839f-49ea-4d0b-bbf5-b711f4854862@nvidia.com>
References: <20240208062427.31255-1-kch@nvidia.com>
 <e8a819fd-3e40-47dc-8ad1-1932d7a271e3@nvidia.com>
In-Reply-To: <e8a819fd-3e40-47dc-8ad1-1932d7a271e3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6353:EE_
x-ms-office365-filtering-correlation-id: 1a3b90ea-4c58-4ec3-30d0-08dc5f5f7206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUxwu7J+qLUpBjVCqKEwX+Tkr9qzZJQx4swvfmhxnW2Q+1QWue6JIwyoP/5MKqnNHu1+C0A0dD+IDfTc6dC3iwXTyrrBeZ4fkP5D3S51x648lGKjf27rkmSTr2Zhk6yaMADFo39VLnxV0EC5HdTn1YDTyOiaSNBjsW5bqKDVvuoDgHpWXoUA3Kw3KMwJ+7u4RxB3+TxfjBuPBksOM5ZC7ig3dB1pjZTJUsirv03aodPqAqkNRxYFRf/WGcZPB+urr2ZvCywpJ7++NM+DzJ6Rr+unL9jDvWjmN7bOpGTQQ4MmRzbUeUeAUYE/dCaCINPN+/o9bbSEWnxfscdt3h34hNF8hCM9d9GYf45S9euW2yQdN7+izrqQFyEi7hu8Hh0WYXxtYxqxKf1hCh9rUadXigtHeQoh7HxSpe/H2UOXenI2C5kFoSsnphvj6tbqB3l62cBl9daVCoB/BTXnxzjbQ+usGkCgjF7vetpsdNaSWKez7OwNV504qReivxKosrI2Yc8m8Z2p23ap41PWPYdFrLOd5cFbE2/d0uvlpwmIkunYeN4BODuJoaCirp5N+1fhDwkPaHGo8mAxvMMr55QzEwQHBw1QW5INxYVafoOQuGuDEvuh96hveJR7+Fcp/19dDwh9uAmZ2BjUXPsb85vr/RGyz0gUWhcsnXeV2onIONSdHdJZ0jqC/RLCL+nSUgQ1geCgJQx3xEBpjde0P0lFxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHI4L1ZETk40eCtOSVlnUGhFekpSNHluMktBaEF6WnJkNXNSSjdrM3RPdDlU?=
 =?utf-8?B?eHhqNzREbkNIZHVtd0ZuQ213TTRMTG5KejJGYWd0dWxORWExYjVGdUZRYXY1?=
 =?utf-8?B?Q0RZSTkraFdxKzBNVFJhUXJ5L0tORFJJQ3RNTXZHcGl6MDNWMnNLdTlmWm1W?=
 =?utf-8?B?VTNCdGVaTTFicG1VT3ZTd0RoNm9TTTdvcWdOL3RNSGhvb0sxd3Jsc1VsbWZ6?=
 =?utf-8?B?UEswdiszdTlRWnAxUTRaZTRVOGpmRWJIdDJQOVZwNUlnWTBmZ2k1RGw5MDMx?=
 =?utf-8?B?VmVLQ2RUZFg3SkNWck9Va29GS0ZNaUlZWW5kTm0vY2F3eTQ3UEwyRGVUSk9E?=
 =?utf-8?B?VUllNEFHZUxwMDg0WGtPZ1F0QzZGYkZFODFDYzVUU2xrckEwMkd2cElPOUFw?=
 =?utf-8?B?NU4zSmJRMS9HbG5mSDByZ3JGOENHZk9CN0NNdEJwL0NGVFdodE5Yc3VqTVlV?=
 =?utf-8?B?TlZSUDlad2hDODNKalNYQ01HK3lSa0VMVGlWaHRMazA3NkVmZ3VuS2k5cE5W?=
 =?utf-8?B?NnFrT1VVMXRXSlE1bDNuR3BHejcxNForTGtHTXc0NzRoRWxMNUVSc29uVGZv?=
 =?utf-8?B?aDZMV0RhQ1JFS0xkbU1NWnV6N1hDMWRibkl4T2NxVjZwTjk1RWxoVlFDb0Q4?=
 =?utf-8?B?Q3c0Rnl4WHZuT0pWTUFpc2lJSVYvWHRHUGJiQjVnNHZkbjc2Z2ZTd1pNUndk?=
 =?utf-8?B?ZnlyakhmdU5nQzh3TElYejdhSENaazJ3a2RUbG80UDZDTmdST0NxV0lHVzZp?=
 =?utf-8?B?QlF3STVSek5jS1BUM1NENUR4RUNEMTVYQzlrRndPLy9hZXd5N21qMGFqMWJu?=
 =?utf-8?B?bCsyQjFzY1FLSVpWWVlnY0ZaNkZEUG44WDdFYXdJVUJsZ0dVOW1RUFR5VldL?=
 =?utf-8?B?Uk8vMEpJcTJBUlc2aW9EdlIwa1Q0UDdPVU00aVZGVmd6TFpCd1hmZWptZEgw?=
 =?utf-8?B?UkJLVXlHb0pTQkRsNlhQd1hiTEJYdENUOHN5M3hPSEdqVjg3ZHRkalhKTDVV?=
 =?utf-8?B?OEUwNGdBSkZUUTd2ZHhNVC9HZ2luMlhuSHJNcVBIT2tQbHhYN3BPNmJ2QmlO?=
 =?utf-8?B?TnAzYjFRNDUybmdHRFBkWXQrNUxhVGtiNkZWSXhGKzloQTk2V2VxczhmalR2?=
 =?utf-8?B?VUc4TzdqS1VrQmliZ1Y1dTFYYXRoOEd6T0M2ZVRvd0oxTGdQbmxlNXd3RzlM?=
 =?utf-8?B?eTlJeGNCbjZEV0RmYTFXWWgxd010cDVVRjdLWTBrTzhOL3Uxc3dWcE04UnBD?=
 =?utf-8?B?aHRNOGZocnlmZStkOFhXK2tTYUlvcSt4a1JkeXN3dWFSaE5tOGRTRVJNdHhw?=
 =?utf-8?B?WW5mcEpSdzFBMUpzbis2djFMcXNMQnBSdXlIT1Y2YTVvM3hrZGx3VEJtc25x?=
 =?utf-8?B?T1I4Z1N1MzljTml5RXk3azA4TW0zOUtYcDNJVFBNa010L3NYR2FZSkNKNnFM?=
 =?utf-8?B?b0RlTzVZb2NmTFdqU0hTN09FVW1tOTFWeUZMLzlsQVdMNWVIazNnNlpFWjJr?=
 =?utf-8?B?S0ZHd2xwbUdKYVVRWVNSOXZlcU5kMXI2VFBhbDBqbTkzS1M0L0R6RmhKQjVz?=
 =?utf-8?B?d2ZmQ3NUWUhNTjZibHNKMGlQUTNsSEpEemxzZ09KcnROWnltMUptME5VKytH?=
 =?utf-8?B?VlVLWmVoSXNKQmdoWnozVUZmNmtwMEU4S2pxdGhsSjZqb0VSUWNhQkp5ekVJ?=
 =?utf-8?B?UFhkeC9hNmZ6alJHcFp6WWVUUWhJUmQ4WmJsNWlkb0x2VHpDOFRoeGh5bXpM?=
 =?utf-8?B?elVjdDZwaHdHSTgvRGduYmFmNmhwY0ZkbnM5RkpFaTRRZ1NjTEdIWDlxRUlq?=
 =?utf-8?B?RjZxVWtzeWJ5d2IvZmFTdzcvMjQ5SCs1djBqaTNXYTloZWp0bklEdDBRQWw1?=
 =?utf-8?B?elA1NnZOOGR1VmJlWEIvMklQY1Q3RStiRlBJZGk3bERGQ25MOGcwQm9yOHFj?=
 =?utf-8?B?ZlEyUkI2NStSbVZiUmQ1WVRkYUxldlpBYytRQkk1dnBQeWVlVk9EcnE5NE92?=
 =?utf-8?B?RXVlL2xLSHlaRzlPWFRBWC9ma3pxTCtoT3llcjAra3Z5VWFmdnVXVlgvdkNt?=
 =?utf-8?B?bnlCNExkZ1pGWG52b0JWWWc4OTNTaEJjMUxMZURNb2VZcVFDeWorQkNoRXRQ?=
 =?utf-8?B?bFhCUytnWkZTMTJ4UW9ETjI1MzYwNkFLdXFhZDVadWZ1bTdmV01KdUMvZEs5?=
 =?utf-8?Q?XLCcP/C8quh9c6U4qpRvg2cLw/fAuMxL9rvWva2o/tSQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD92C805B26734449611B530A54AC199@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3b90ea-4c58-4ec3-30d0-08dc5f5f7206
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 04:24:31.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8fljQQT4ZzGRjBunO/X5hNMCu277lxGtJqNnX5CwH/WPRdDV/ELE3PLqZD10IuYwpyBJZpGUsFebUMQBLpjXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_212446_472533_7DAFC1E5 
X-CRM114-Status: GOOD (  16.26  )
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

T24gNC8xNS8yNCAyMDo1MywgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAyLzcvMjQg
MjI6MjQsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFBvc3QgY29u
bmVjdCBjb21tYW5kIGF1dGhlbnRpY2F0aW9uIGhhbmRsaW5nIGNvZGUgaXMgcmVwZWF0ZWQgaW50
byBpbg0KPj4gbnZtZl9jb25uZWN0X2FkbWluX3F1ZXVlKCkgYW5kIG52bWZfY29ubmVjdF9pb19x
dWV1ZSgpLiBNb3Jlb3ZlciB0aGlzDQo+PiBjb2RlIGFjdHVsbHkgYmVsb25ncyB0byBhdXRoZW50
aWNhdGlvbiBhbmQgc2hvdWxkIG5vdCBiZSBhIHBhcnQgb2YNCj4+IGNvbW1vbiBjb2RlLg0KPj4N
Cj4+IEFkZCBhIGhlbHBlciB0byBoYW5kbGUgcG9zdCBjb25uZWN0IGNvbW1hbmQgYXV0aGVudGlj
YXRpb24uIFVzZSB0aGUNCj4+IHNhbWUgaGVscGVyIGluIG52bWZfY29ubmVjdF9bYWRtaW58aW9d
X3F1ZXVlKCkuIFRoaXMgYWxzbyByZW1vdmVzDQo+PiBhdXRoZW50aWNhdGlvbiBzcGVjaWZpYyBj
b2RlIGZyb20gYSBidWlsZCB3aGVyZSBhdXRoZW50aWNhdGlvbiBmZWF0dXJlDQo+PiBpcyBub3Qg
Y29uZmlndXJlZC4NCj4+DQo+PiBJJ3ZlIHRlc3RlZCB0aGUgY29kZSB3aXRoIGFuZCB3aXRob3V0
IE5WTUVfQVVUSCBjb25maWd1cmVkIHdpdGggYmxrdGVzdHMNCj4+IHRoZXkgYXJlIHBhc3Npbmcu
IEJlbG93IGlzIGEgZGV0YWlsZWQgbG9nLg0KPj4NCj4+IC1jaw0KPj4NCj4+IENoYWl0YW55YSBL
dWxrYXJuaSAoMyk6DQo+PiAgICAgbnZtZS1mYWJyaWNzOiBmYWN0b3Igb3V0IGF1dGggY29kZSBp
bnRvIGhlbHBlcg0KPj4gICAgIG52bWUtZmFicmljczogdXNlIHBvc3QgY29ubmVjdCBhdXRoIGhl
bHBlcg0KPj4gICAgIG52bWUtYXV0aDogdW5leHBvcnQgbmVnb3RpYXRlIGFuZCB3YWl0IGZ1bmN0
aW9ucw0KPj4NCj4+ICAgIGRyaXZlcnMvbnZtZS9ob3N0L2F1dGguYyAgICB8IDM4ICsrKysrKysr
KysrKysrKysrKysrKysrKystLS0NCj4+ICAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyB8
IDUwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgIGRyaXZlcnMv
bnZtZS9ob3N0L252bWUuaCAgICB8IDE2ICsrKysrKy0tLS0tLQ0KPj4gICAgMyBmaWxlcyBjaGFu
Z2VkLCA0MyBpbnNlcnRpb25zKCspLCA2MSBkZWxldGlvbnMoLSkNCj4+DQo+Pg0KPiBDYW4gc29t
ZW9uZSBwbGVhc2UgbG9vayBpbnRvIHRoaXMgc2VyaWVzID8gdGhpcyByZW1vdmUgdW5uZWNlc3Nh
cnkgY29kZQ0KPiBzaXR0aW5nIGluIHRoZSBmYWJyaWNzIHRoYXQgc2hvdWxkIGJlIGEgcGFydCBv
ZiBhdXRoZW50aWNhdGlvbiAuLi4NCj4NCj4gLWNrDQo+DQo+DQoNCmdlbnRsZSBwaW5nLCBjYW4g
SSBnZXQgc29tZSBmZWVkYmFjayBpZiB0aGlzIGlzIG5vdCBuZWVkZWQgZm9yIGFueSByZWFzb24g
Pw0KDQotY2sNCg0KDQo=

