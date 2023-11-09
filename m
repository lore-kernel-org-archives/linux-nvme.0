Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E6EC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06vLlgnpU3YiWOS8gVWspEvUfpBXMSrGVmbl9WE3lwk=; b=rZdXkKwmtfahBOFG+1FpPbfbIs
	njv3hWYivPfSwsknFQvS96ekBhsu+ZJdTsonTdz1kSb6vII5mOtbDVbU9q5re/WCilMB/xYKRCYXv
	2gd8vdcYl9AidNcaLtk3tGkdgDwKESfa5YEMHv0jDKdFn8BF8bMK9KcVkF/4jCMUJedHzzRKuO8s1
	VQuUif5G1JF//QjIGPciDWX/4Kyf6HXtqH1COuUGFgkfJ0vGX6OCffRDSgtk1jfEFIn6wzgMQZdP2
	UVfhc7HVguNUblDQdc52le+FI9dCaFUf0UPiiTpVqx8PCHLMafgOsoNr4As4cmHTmpQkwp5jqBkFh
	/8B/oPLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r10jk-005fAa-2C;
	Thu, 09 Nov 2023 08:50:04 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eab::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r10jf-005f9m-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 08:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TesH0Kv+hi930WHuFkONN+DPDtkQToYbh9ukrQRfe44D5JxaOqF0vysP47vhHzOd/9CaSFxz0WH+wFYyShzPdcNhq9pdOnay/gZOaqajajnPISdGOzVbNg/7gA1gtqHxv6OHac/+noSIS8EamxlEvEHR3UYWoRN9hy1W7A0twg9F1tyEv/Vx5wMkg6FAbu9/dcAi0XDZBnNpIk1UGjb/Ki9yj3XVy8h6Nzd4d4Rj/gV332M5t5tXMGeD8vLxoJTZ0Uqk29vsaAPUw7RNcXvLmldOmWK0NFgBgK9Q0LQTG1mvRa+unOqPhP1pOItgsdQ+77TS6qHHeYn/ALWhgdF02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06vLlgnpU3YiWOS8gVWspEvUfpBXMSrGVmbl9WE3lwk=;
 b=AV7/nNmPRyLU9vKvR1QUbANBO2kYxJTOPFDZwQ5bz/u60+bIJYKoPSoLrLQ75k1XYnTAsmY+oHS8Vs9x12vXieFfa8kcVEt/VsIpVyBTBwxsx+no7qZeqSX7piiyYVSiIw5fRj7yMchBk4WD9kQXm+rEU7CQa3cCGVnVu3KExu365SchF3mQHrQuSM5YfFKcbiQ9lu3U2DSOuOTG1ImdYcEYI+5eEmAuFi1EmqvZRBjLQUxgGYvUU652CzwH75hTwZDr6iHQ5uibZmt5yxokQGol90EQWHlvznYmWOQRchjqMzhjnV979Q7NGmpcmYRv9Ul+Wb+4LoAas2rdiRLjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06vLlgnpU3YiWOS8gVWspEvUfpBXMSrGVmbl9WE3lwk=;
 b=P841F20Rl5XDGjX9uxNAaq0fKCVcsil4EbNhqdDNMkOjAiqvlZCX3IyXsVGQhMptCPTbRJWvKqA76JYdgShODxVjcSb+ZoWtJD/Jw268+v8pFclWXY8yUJ9qa3rqt50hINGP/s1t6laZQ6vtXPNcyssFbxCeo5OFlDJf7a9vlEO712FYtkNEIkOT0LJQ3wfBi7aVQbGL7cIQrAsrnNYR8GkRc+gHmkcumMWVdkrZtCqYAxm6q0/xGtOJcHuY39aj3bt1pwg8/7h62iC7gBzMeatf/bwEHIaxzuhytjFCRJLUXlDqfOI4qtuA3w8v1h/MyVWFGqVvc7FWgcij+LEkrQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 08:49:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 08:49:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Alon Zahavi <zahavi.alon@gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in `nvmet_ctrl_find_get`
Thread-Topic: [Bug Report] NVMe-oF/TCP - Slab OOB Read in
 `nvmet_ctrl_find_get`
Thread-Index: AQHaELZzBoRn8E2uo0yWhrH10lGud7BwHqkAgAAEQgCAABEdgIAAELYAgAAycwCAAIfcgIAAcJMAgABCXoA=
Date: Thu, 9 Nov 2023 08:49:52 +0000
Message-ID: <b58a2dc6-cc8f-4d19-9efe-e1d5b4505efc@nvidia.com>
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
 <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com>
 <CAK5usQsOP+4oV3YEcNN6Oe6_kBqP_u=e1DggJvNanH3qDG8+wA@mail.gmail.com>
 <7942920c-b3f8-4f52-b6a4-78a3cef2cba7@nvidia.com>
 <CAK5usQu_mi68_ChP4OckVmY42djdPx8L3hGg7_Jj0fa1yQ2mPw@mail.gmail.com>
 <20231108140312.GA32730@lst.de>
 <afbb268d-5098-4b81-ab1e-a25f0b9013a1@nvidia.com>
 <20231109045222.GC28458@lst.de>
In-Reply-To: <20231109045222.GC28458@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BN9PR12MB5180:EE_
x-ms-office365-filtering-correlation-id: febb6a3e-7897-43d7-51bb-08dbe100d6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aR8MJ36fFiPxXJypC4pD8LOW8t78Qvued8OjAPiX45Ktyp3YTDz2kjIqsnCOTMUf2+hi9+v0c0bvyQ3e6+RRynEGv3UgrpuVD8wVr1nn6jLu3rUEs1586JVtTWaspsXWagTkPAPKQtJtM9L6c4fmE932tEN15P+GbO7eCpJdyYSlyNfHlCV3oM7PKpWdKJTzIaV1jeBo5dFC2RyaaSb7b0idghi3dR+DkYWkgU8Jxdk2tsbGpjYtZAO8leEmG+dbK6jCLmSukBKZdocah6aJf8Vvsn0pIEo7APyqnuUvEY53x4otX/VTKvV0YYB+MEZhVE5MLwXtSeaUaYWAnGFzxaglbjJlwn5CIo6gEItJjXyVU1/bRblVvc5jxfXhEFyh8KGWAFyiCo56B+1DNsvt811SxC5XvrFadAJJ3oc2X9OsnCWNnDaSFG6nlh4JOYImjuIka2B2ZRptl9vinaMDXHqss3ULSy+zFByFYuJhca2WpG0L4gAbBehDKkVmuc+FHkoNnvSLXRlaFD2BbYQvQ9lYxe1safPsML5+a5hSy5O8k1wTPYY6X5GUFWnWzwd3HldPV9k2M5QccQjWsPbtGo+hJqvz4HVg6xqfutKWQTJoSl6Hi+/tGebhyAbGuWuQDtaxaQz8w933gtV++LswcLaqbKLPC6sZ2KDwqD4cum+AxsTzpdQ9w2zOchhkwJFcWswA5eEOuKnfiqJSSEOZLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(41300700001)(4744005)(86362001)(31696002)(54906003)(2906002)(122000001)(91956017)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(31686004)(38100700002)(8676002)(8936002)(4326008)(6916009)(316002)(5660300002)(2616005)(478600001)(6512007)(71200400001)(38070700009)(36756003)(6486002)(6506007)(53546011)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VSS0RQOVNEVnY2ajg1UnhCdzJXa0l3RnNYR1o3dy9VTk1CNnM2eFVmMVZs?=
 =?utf-8?B?enI1cVF5bHd2U1I3bWQvRStrcllIa09JN0F1ZTlic2RKYjFZck1rVkVJZjR3?=
 =?utf-8?B?dzRDTUdWMDJJejZwdjUwSXhSZUxsOHRnaTZPd0hmVkRRb0l5RmJtR041VzA5?=
 =?utf-8?B?WnFhZXFhTDk0OFNXenhFMnozdlE4c1Jjd2loQTZ5ZmhEMkVjZGFnNHVYWGR0?=
 =?utf-8?B?SCs4ZUErbkFkNUhEZjVQMko5YlM1S1BDbUsxVEZSb1FNc0RsOGxUbythQ1dT?=
 =?utf-8?B?RTBiUDh0aEJMc1MvenhjRGFzeEdFOXpRV0hLUkg0WHRZUzJBV1djL0xpY1pU?=
 =?utf-8?B?ZDNvRFdtYnFpMm5JK0JjUm1qcUY2L0t5Y0d6TVRlRWxoVjh4VlR1VlFUZFZ5?=
 =?utf-8?B?N20vMk92ZjhzeVZ3T0VqZ0Rnd25nSVUySEYwMDlPMWQ3cmlwZStnT2tNTitq?=
 =?utf-8?B?Yjk5dkhyMTJoQS9HSC9Jd1VIWVhSQkhkeitJV21GMnRCV3dQbSsvT0JDRlM2?=
 =?utf-8?B?eTlGU1huTGRZcmFXbDhEbkNFeXd1d3dQbk1IbGhiQTlacnpKdkN3T2JyaGxp?=
 =?utf-8?B?U3JlaVV1Y0UxQnJRK1pQckhFNkduc3BDbHhsZVJXNEhyMmswajhNVDFJdVdZ?=
 =?utf-8?B?M1o0U21PamJJV25TeXB1NW1NUXl0d1pTKzJGdEdDQlBVblljY0tET3R5MGQ0?=
 =?utf-8?B?RlRncDFJWHJxcjFzZ05aTi9EU1ZFTG9lTnV4aUR1d2xkQUUvYUJ2d2h0dlZ5?=
 =?utf-8?B?V0tPak5RVmtwczd2bWxWS0kyVzQ3QU9VVnMyLzREbGE3dU4rdmdiS3ZIZ2E3?=
 =?utf-8?B?MHdEdjBtOWNZdURMMkdPSTZrSHg0V0xUWXBkVGxsL0w3UTdFK29mSWtMempD?=
 =?utf-8?B?MlVsT1BSZHExQTJWbEdLV0p2OUJ2VEorN3pCOGhHR2hZai9JUEs2bjhWUDdZ?=
 =?utf-8?B?ZW4ybVhxbFFTSDF3SHV5Z0lpUVZzRTBVVGVjcGhBSlpHMG5IU0JyenZWdzZr?=
 =?utf-8?B?QXB6dGpRSnArdmFhdVBkMGxudkZQRDhFb3IvYXhpL1M3VjNOeXhnaUt2L1Vj?=
 =?utf-8?B?bE9kTUkweUU1Zk9vTUNMVDlWd0VFWldVOUM1UmVONk9Cb2dLRk5vcjVVRFFI?=
 =?utf-8?B?M0dPNGlma1N0VUdyWFVCV2M1Umc0dGdieDRSYnFQQ3dzcHhmT3VzQkhwWmxP?=
 =?utf-8?B?V1BUa04rUEM2bnovdWxnbjA1enl2QlRlb2hjeGpHMFpGZ1RYclFBcFkzR01n?=
 =?utf-8?B?b2VQUldyMzhtUVdSb2tFWEJKczY3cHR6UnVDYjc5bGJWTTNEWmJ4T28wcElt?=
 =?utf-8?B?UnkybHFyL2NjamZpc29QektZanEzV0tzNTBmcDd1c09ETnY4d01sZURhQWVY?=
 =?utf-8?B?enJTRmdoVHAyKzZsdFMvN1BnRnB4c0RmRzVZcXYyZnZoOVQ0MkNtZk82Q1ZQ?=
 =?utf-8?B?eDA5YzFyeGFJbzhpN0sxOENNcjB5VTczbSt2Uk5scVdpbU8wbjh3bFVwZlVO?=
 =?utf-8?B?NTFYUXNleVNWbjZiRTVMbHo2UUsvQm41ODZ2dmcyOHhuRXhxdjhZZThqSXRW?=
 =?utf-8?B?c2syUW81elJHdWd2UDZZVng2VHF5dXJ6UkRWZks5T09vWnBwSHlNcGZZbnZw?=
 =?utf-8?B?YVV1VWZLbVd2M2twZExBQmVydy9ydEd2dzZQQW94bTdOR0Y3ZDZOcGJqQ0Nn?=
 =?utf-8?B?eHhaS0tnOXhRVUsyN1kzay9UUEFJcXMrYXlOVGMyMVRUTWI3YlUrVFFzNDdt?=
 =?utf-8?B?Q2cwWlA1bWRuNnh2THJpWjNDZWUvYjdvK0dxY3Z3cTlIQ3lXRDVaUkFaVk5L?=
 =?utf-8?B?SkMvV1hIMTVkREYvSUtuTEtiajdleW9VSXNrc05UZ0ZEOFgvR081dCsxWlpE?=
 =?utf-8?B?ODNvdXBmV2grd0tKVmZpc3BZd2ErYXBndVByV1A1aTJiNmZSUFl2NVhUeENH?=
 =?utf-8?B?eE9tTWw0aHlERFp5ck5mcEhkdk9BS3BVaTRUUUUrb2dwWk9yVnNXOWtMSU9q?=
 =?utf-8?B?S0tFTVhHRUc0MStKOVVVMk5wbDJJUUFKc0Z1c2U0VVFhdEx4U21RYngwQ1l5?=
 =?utf-8?B?Znl2NURFbldLZ2J5M3dOWE1HUGRNOHNqcDhEQW8vblNNbjI5R2Z4OExzb0dz?=
 =?utf-8?B?V3B2eGJSRTRBOTIya0V4TWdEaTNFckxaVTYxTTBhNTVsckI2czZMcC90TFhX?=
 =?utf-8?Q?dSFYQ+TzdogsbCw1r8yhRSCKxehzZhn1ciNSd642Msqd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D487BD2A6799DD49AD191BEFD53F24F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febb6a3e-7897-43d7-51bb-08dbe100d6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 08:49:52.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZcTc7pGs1rCR0uMS5Drd3+hq4CH9f5YfBmGjR+yC5jsK+pq1vWEyUyHoeV7J9Hn//HAQgT57ePYOCrVaJQPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_004959_526297_9E98D631 
X-CRM114-Status: GOOD (  12.68  )
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

T24gMTEvOC8yMDIzIDg6NTIgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQs
IE5vdiAwOCwgMjAyMyBhdCAxMDowOToyN1BNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+PiBJIHNwZWNpZmljYWxseSBkaWRuJ3Qgc2VuZCB0aGlzIHBhdGNoIHdoZW4gSSB3cm90
ZSBpdCBpbml0aWFsbHksIGNveiB3ZSBhcmUNCj4+IG1vZGlmeWluZyBjb25uZWN0IGRhdGEgYW5k
IHllcyBpdCB3aWxsIHdvcmsganVzdCBmaW5lIGZ1bmN0aW9uYWxseSBidXQNCj4+IGluIHByaW5j
aXBhbCB3ZSBzaG91bGQgbm90IHRvdWNoIGNvbm5lY3QgZGF0YSBhZnRlciBudm1ldF9jb3B5X2Zy
b21fc2dsKCkNCj4+IGNhbGwgZXZlbiBmb3IgdGhlIHNha2Ugb2YgZGVidWcgcHJpbnRzIG9yIHN0
cmluZyBjb21wYXJpc29uIHNpbmNlIGl0J3MNCj4+IGEgZGF0YSB0aGF0IHdlJ3ZlIHJlY2VpdmVk
IGZyb20gaG9zdCBhbmQgc2hvdWxkIGJlIGluIHJlYWQtb25seSBtb2RlLg0KPj4NCj4+IHBsZWFz
ZSBjb3JyZWN0IG1lIGlmIGNvbm5lY3QgZGF0YSBzaG91bGQgbm90IGJlIHRyZWF0ZWQgYXMgcmVh
ZC1vbmx5Li4uDQo+IA0KPiBXaHkgd291bGQgaXQ/ICBJdCdzIHB1cmVseSBpbi1tZW1vcnkgYW5k
IGFueSBkYXRhIHRyYW5zZmVyIGlzIGNvcGllZA0KPiBpbnRvIGl0Lg0KDQpva2F5Lg0KDQotY2sN
Cg0KDQo=

