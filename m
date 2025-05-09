Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47164C3ABCB
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4lDK/8UjS27VfYkb20ixZXVk5yTuTdO5rUt13hW+5AU=; b=rXz6O/XY0tEto/xrLb6JAYdq6n
	TM1nFmvRoVDUoizYhuweUrIVBBt0v+JVFETplLruNThTlXSHFzkV49cGcPqCIZFBT37YUSPTiVUsK
	RqPeL91pvvkzehF4NOSNpozTR2hyt7L4xvVlcRN19Nr69EQgV1kH/q1pMHlgtRj4nDteV5RMGreun
	YC/63TAF4vMLL+w2qIhLXwfAfascL313Hfgl+/pIQtOmLvOGXxCxgLBL2YXxAfWPzoA7PUr2wlHZG
	e/AWd+mLYLdFph/4a5kYT/0PShDpnqS4y/uLdxo+RzbRM/lqzPxQEUfpteUqU9WpEFRrvQ4o3l8Pw
	x3tBI3nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDW55-000000053bK-36qH;
	Fri, 09 May 2025 22:20:35 +0000
Received: from mail-sn1nam02on20717.outbound.protection.outlook.com ([2a01:111:f403:2406::717] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDW3c-000000053W9-2fpE
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 22:19:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOZcPgOR8XUtshrpNpZCGbx0V0Xkgo38SGso+MmAp+AlJnJfABqI6PoGO2/6whakX/iOM1gMr6XPovQ1tzYlQW/MMyp0K+Lgt9FsaroA6mpWQ/za00YVE65/PVw/4LuDqJIoZb1XLLGv3MP+oESfw+AB2/Apa0ZZ+2mAgvhWxYyoQS8R2ZRXyt0l4aJZyOxNxGICZgQ1ks/PmHJ+LtECq8Aus3CCDcORIvVYNsV3QLwdVnEqEXkNJQkKZj83zyJPuixm8idhYfzF8DgsfVYkj21au4iY0yNpYg6NXdQUycDklpc3hhXjW/i7IHq3wdqfWLtmkwpQhkhuK78qnNO0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lDK/8UjS27VfYkb20ixZXVk5yTuTdO5rUt13hW+5AU=;
 b=LQLBSrBctREAXvKrlSdoN5WFJc6WVcV1q324zpwxP6tFR/vNHopcSWuOT4k3OS8OgBtttWB2itW2zKyvQkRT6kBPeqhiUOtQKZT/VViZf04dVqlIFk9g+UVzJ14O7dUY4X/Mx09eni3Z1+RXZk8IeTWG5XG6tTvfu0Ag1f2rGJZyzPKNpNjgkBHCAv19tlZHCpa2rNvENFHZhxkEkyLg7W4IGBkY5fixysWWoV0VPks+H+Zl9P8xn92vfNbOhKE9r1tFUXTyPqQzcUhRWaAjVhVDJX6QBRcaphu5rTbjYY9Ogiu/0b824Ov4AV0O/XHiWyOtzsC9q+kqdDVAAJbgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lDK/8UjS27VfYkb20ixZXVk5yTuTdO5rUt13hW+5AU=;
 b=rfGGOlJfvKIn1bdzaaTMReQhrZXJ2JBo+bKy5voaY2I4UqdRSoKFAVxe0G5H2Ay8r4ANqlwraIK8tM49DMOkb5glkolEEciUzCJwccKtXhZy7v4e4VOqil+pJ4AHPwwvObbnG1FTW0AoTwNmdCS6UpWalOr3i+MFvHftxo+AToJ5O7ry6TGzR2y5DET6pO9E+TGC06yUqB25CoANlKmDG6NUB/mBB/9SkrNYLE4asWOCqvTJ8EjDmfLciJz0LMAU1QNZr6W2hw6nCo/jbQmsONUUGGlUn2KbKeSQlBbg1Kh0Q7QHrAQeL+3az3acODXR7Qsk4dihkKDgLj3hjK858g==
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 22:18:59 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 22:18:58 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Caleb Sander Mateos <csander@purestorage.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: 'nvme list' shows 100% usage on empty drives
Thread-Topic: 'nvme list' shows 100% usage on empty drives
Thread-Index: AdvA83kFx6m6RPjHS361DwMdkX+71AAGHbOAAAkSEBA=
Date: Fri, 9 May 2025 22:18:58 +0000
Message-ID: <SJ0PR03MB6501AF22AA6CFECE844FF442FA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <CADUfDZr_paV6iK-KrABtf5OXTrxD6vXc_HFTAsqgMp8OyDwz9g@mail.gmail.com>
In-Reply-To: <CADUfDZr_paV6iK-KrABtf5OXTrxD6vXc_HFTAsqgMp8OyDwz9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|IA3PR03MB8021:EE_
x-ms-office365-filtering-correlation-id: d31c1181-9f2c-490f-72cd-08dd8f477ea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UmlwekduVGkyajRxd2w0VUxmWmt3ejZrUlVUdFk0eTlQdEFFbzR2MjZKRTV4?=
 =?utf-8?B?VGowbzB3R0ZPYmRGQmFLYXIxS0wyM2FlQzNpZjgvNkJTVGkwdjJnR0dPZGN6?=
 =?utf-8?B?MEtaV1RNS1dSRnpOSlF1Nld3UzBpMzdHZTJlSkRvZ2xQYVFuUnNXL0NGM2Fi?=
 =?utf-8?B?RTBCaGZGYzloV2pVT1czQkhpOFQzZ1NnRzlnVUhiRGQ4b251THVEc3ROenFR?=
 =?utf-8?B?SjI1VVorK21yZksvTkNueDZmWkxYaWR3VEMyNXYxOTFab2dIV3U5c2Iyd1A3?=
 =?utf-8?B?OFNSblBhTGdLVkRCaHlKdllJN2RwdkZCVlpJK3J2eXpuemJkTTlxNlpweWVu?=
 =?utf-8?B?VStsdDhrbDBTZklwOVJWenllNHd3aE5LN1NEMG9Yd3pkUHM3amtzcGg3cGdr?=
 =?utf-8?B?eDJOZXROci9ySDlnTmwwUFRNSlhxS2pXbmprTXREQ0hkZzdmTlc0blA3Vmdu?=
 =?utf-8?B?N1JHd0FsWU0zdk9KSG9INmZPNWlQZ21LaitCcXBDV05SeXFhbStoWnh3Sy9M?=
 =?utf-8?B?OVJOM2NvSzNDdkxxcW5oVFRYT3lSZmI0cG5vZVlmajZEb3RSelJhZnN5STM3?=
 =?utf-8?B?Y1hJcEhFSlJ5dFhlUW5scmVXcjhUZDYyQnloQ0dXN2ZZdGdYcFROcmp5NDlp?=
 =?utf-8?B?NXk0UTk3VG5nTXRUMkRINExIRXo3S1dIbkhvazBGWm5yZHNWK040ODhpUW0x?=
 =?utf-8?B?a1ZWQ3lpMXJlM01RcWRPTTRta0Z1cEp6cEdnc2t1VjUvcEEvZWswaTFyQU5j?=
 =?utf-8?B?bFBZb2k4YjVoZnZqaEliTFJ4OEJlZjd2d1V4SEp6UFVST1BvOEdScjk1MEJ1?=
 =?utf-8?B?eGIyL2JlalBPNi9XQmFqVkNXcm5xOHRJRGVVUjZMb2tLWlR1SWpFNjM3RVNn?=
 =?utf-8?B?VWxXM3FpT2lZTjUvUEtIWXVIQnFQczBWSVVPWTEwZ0R2OVY2ZGtDS1ludTlj?=
 =?utf-8?B?RmV0ZXhycC9DRy9aeUQwam9hN2FoZnRLYXovUmJQU002QWlOamplUHluSzdJ?=
 =?utf-8?B?S0x6RU9ickNRZndFc3l4ejFxeDR3TTJkVVhnSHA3R3ZyOXlPQ2RqWFcvNjcz?=
 =?utf-8?B?Z3VrbUFpRkJrM1B4ZGo5NHNoTVNLdXJTRFNXWGNXSkpwOW1iRWFWKzhCUGJR?=
 =?utf-8?B?ZlVnOHRESC9Ic2RmWGZTQ0hpNWlNa2ZhYkNUNGJYeitCWnh3eksxN1o1aWZE?=
 =?utf-8?B?NjNkOExPRTJoMFhIblJxZU1PUHVtQ1RTUyt4WVIrUjBVbDlqK2M0ckphVkZs?=
 =?utf-8?B?T0Q1S1FvbUdMbm9tZnVQbDhPUENyZzl1bm9vbkx0VHZsbkFSMWFxVTdoUWpl?=
 =?utf-8?B?c2FKdWp1bXRvcG9JYURiUUdiSVRCYlc1OUh2aWxadDVubUNUK2tqMi90OVRW?=
 =?utf-8?B?SktBaXRuaUNGcmNEaWRnUXZETmZLdjd0RmtXY2RFejRYa1plOHJkb3hicUlI?=
 =?utf-8?B?SmdQZnJjZy9PT0VjWndEMVhPYlhkb0ZXbC91d0lQSlFINFlLb3JWcWdLamFU?=
 =?utf-8?B?dUtjekNHWndpTXhVSGg5VGJjd1hsOWdreVZIZFRvRzBHWWVQdXV6ZlBFSDkz?=
 =?utf-8?B?d2lrUjFSN2cvanNSUWdaR202MkRYVTJHS0tvaFRieGRCNUh0QS8wZFRRdjcz?=
 =?utf-8?B?N3V0am84T1U2ZE5Jc3Z1RE1SRnRwMytiUzVyWEFIT3dGVHp4OEUvdVVZbC9r?=
 =?utf-8?B?eXBSZG1sYXZSaU1BMnIvK0tKcENDZncyaUR3YndWdTdxMHdvZTF0Ym5jazNY?=
 =?utf-8?B?RUVzQXRLZnVNZjQxUXlKTUVyNnFsbW1ZSVVHSmErN3JSYU9ucmgxVDd5REoy?=
 =?utf-8?B?eVpyakhLcTN3cWhYRlUwU2FtMFJLSHBtRlIwY0k1c2VvYlNIT0hYSjhZTFRr?=
 =?utf-8?B?RFNteEEwcktwYnphazFSUGVwcU0xc205NWYvOEs4eUdnM1MzVzc3akRkOG9B?=
 =?utf-8?B?OEdTY1JCYmI0RlRmK2VFcUtWNTdMTWRHaTVWRzRjMHhkQmZnK2ZoWDQrdU8y?=
 =?utf-8?Q?OREKfAPT1mH67qeEX9qxTSIli22PD0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1hGQWkzSUgwV0FBYVhGMkt1UCsvMDdBa0taK2N1WEdHZ25hSkd5Sm9VNW1S?=
 =?utf-8?B?RW8ybVhpRDFNVEpkdEo3WXBzS2VPa1lGVW5BN2hxaXFUNTc5UytqVHFrZEd5?=
 =?utf-8?B?QXVQRzZGYWV2TllMd1g5QjNCcGFEOGs0dzdBbXExZ0FQcm5CYWR2NEQ5VGVC?=
 =?utf-8?B?dUhiNkhHcVY5YUpheUhWeVpaSGV1R254eFFLSnVWYjNJMFZHOG5jZjJYMWVE?=
 =?utf-8?B?MHlHd3FNVEM0eWp5MTJxVWZBZkhseGUzeDFuZ0N0OWwreDBpZm5nZEhyV2Jt?=
 =?utf-8?B?WnJEdHVuOWlHR1lldjVMNzMvSEZlK0F5Vmo0Z1ltUEp2RU1QSXVPcE1KY0xx?=
 =?utf-8?B?aG0reFdRQlhGaksxQXVSeU5SOGdqR2RHa2JtYVNPRFJLZXBneHorQy9tZ3ZB?=
 =?utf-8?B?ek5oNk4wNHgrcFpvWlIzV2tncmlZcTcxWFJJWHFSbmNVV3RpeFljc3FHZ08r?=
 =?utf-8?B?UEFOUUZKZldYUUxLckxjUnNGenhsaEFzNTByUWNFbXNTRGNZWkRRTSszeTdB?=
 =?utf-8?B?T2V6RFlicldOT3Q2aXIydzR4SERGc2ZxMHh3Tm85NTJCNjYxRXBBOFZ5YjZa?=
 =?utf-8?B?bVpNNVJBOU1KVTdMQzZMb2twQmtPeFVWMit3Ly9SVnh5MkZmVnJMUU5MeG9X?=
 =?utf-8?B?VGJoT1N1RTFnNGxMN0dUYktXTmJWZEtWVFlpZlY3QVBLNXJyY3dQWUhPeW9K?=
 =?utf-8?B?Kzh1TkYyUVhvMjZyVll5UXBRZmpFWGdUVGRaUnFLNEFZd2hRTkVFaGYvam82?=
 =?utf-8?B?WVQxcnJjbXJSK3M4bnBEM0UvQ2dtbDZHVWFmT25sQkFxMG5kK1Fnb0lmb3lq?=
 =?utf-8?B?dE5iUkp3bi9VSWUzcFpZT3NMamZ6TDJKNk54aGxuaG5uYllKK2FzKzdKVDNi?=
 =?utf-8?B?NkE5RUh5MDNPQUJhM0hoTUpWd1cwZFJzY1J2VGQ1VUhhQWVtOU5XL2F3UFRB?=
 =?utf-8?B?dXNuVUc5My84TlZ3WHRmMnZ0cUtwSkNZdlRmRXhXRGp4ZG84MHFIdUhUUlVu?=
 =?utf-8?B?WE5FSndkb1BLaXNocTRMaWVIclY4YWNmbU5uWTlkcHlBNmUzUUpTSENLamNi?=
 =?utf-8?B?R0hlbHZJaUNOWXkzbWs1a2oxSTFCZmdvenZMWUZPWFZZMGJhVHpXbHhjT0or?=
 =?utf-8?B?dTBwZHUyUHZ2VlNReWk3M2xJSW5CTlIrOWFHNVd4RDhJQlQ5dEorK1ZzUnVl?=
 =?utf-8?B?WlBPQ1N6dVJlN1ZqL1k5YmR4QkExWHBSYmhrMzkrbDNkbXpMQTRKMSsyOHdJ?=
 =?utf-8?B?RkNQOWFZdkZ0YWp3OUNhMlBWbzRubTREeUhwNlNBNnhPTXdicnBMR1FicUdQ?=
 =?utf-8?B?YU4xQytJU1F6Vld1WXIvdHZ3VTBmY3g0SEhVb2pJeUsra3doTnVUZmdaSEN4?=
 =?utf-8?B?UTc3S1NVa25oYWR0V2xZcUtLWjltY2MwOXhOdDY3UmRZQlFaa0JQTlFDWUdK?=
 =?utf-8?B?aHRjSStlY2o5TDhWZGtVTG5LdEc3VElMOFlOM1plUmFISW1Jazk5bm9PMm9t?=
 =?utf-8?B?OEN6L3JVT0xwK2ZyaDZwK3FZczVNcWFCRm01bmM5UXNLUWVEandHYlNBNHBW?=
 =?utf-8?B?SGh0YkpxTVhqbVpnMkhKMUlmcGRBVmFhOExCeEQvaVRWb2dhUzdLZXFhRnI0?=
 =?utf-8?B?MjZmTEVzVmpKcVRWZ1kwbEhGK00xTHc5ODZZcHptSWkwWkxvdGErWG5KaHBv?=
 =?utf-8?B?OUphTnhDZmdBYW1meTNRa3VocmVneUw5MVgwbk9MZTBjalpkR3IyTHNNWStk?=
 =?utf-8?B?cWlkb1M1aVhZMHZzRHRra3BydVZRUmFlK2l6S3U2bThZS1hRMzR0NXNYU1pv?=
 =?utf-8?B?YWxHbE5telM1RHpEVEVCbEN3UGpudE11NVdZOUhCMWpjTi84c0g2WVN0enow?=
 =?utf-8?B?R2FsVmlCaHhBNFA5UnNjS01hV2dCNFZEalFISnhoSGp5L0dpRGpoQ0RiVldW?=
 =?utf-8?B?QU9NS2R6eFp3MS9HdXcybGdrVjZLQUQ0cmQyNnNaUjYrS0tEZVBPTFJKMG02?=
 =?utf-8?B?dERXeDV2cWJRWWFRMlRPOGFxSEMxd0IzbW5Td2huNGdkYTc2YWFoZTF0bmd6?=
 =?utf-8?B?RlRQd1FhVHBJVG5SZ1ZhZDlmejFyeC9aRk1VcXhyMWFNMG9vQnArU21kR01y?=
 =?utf-8?Q?F0Wm/bjgnywnZ3e3VVosasEYg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31c1181-9f2c-490f-72cd-08dd8f477ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 22:18:58.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uTdEGNkmi+H6coH/010gC9p1zlLJ17hxqTMv/abzHRmSpUXcp+dl9x7afFl6xVqoSAAZvW5q9vQrJqkCpvL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_151904_689924_26FC7F44 
X-CRM114-Status: UNSURE (   8.48  )
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

PlRoZXNlIHZhbHVlcyBhcmUgd2hhdGV2ZXIgdGhlIGRldmljZSByZXBvcnRzIGluIHRoZSBJZGVu
dGlmeSBOYW1lc3BhY2UgZGF0YSBzdHJ1Y3R1cmUuIElmIHRoZSB2YWx1ZXMgZG9uJ3QgbG9vayBy
aWdodCB0byB5b3UsIHRha2UgaXQgdXAgd2l0aCB0aGUgZHJpdmUgbWFudWZhY3R1cmVyLCBub3Qg
TGludXggb3IgbnZtZS1jbGkuDQoNClRoYW5rcy4NCg0KLUVyaWMNCg0KDQpEaXNjbGFpbWVyIDog
VGhpcyBlbWFpbCBhbmQgYW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVu
dGlhbCBhbmQgaW50ZW5kZWQgc29sZWx5IGZvciBpbnRlbmRlZCByZWNpcGllbnRzLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgbmFtZWQgYWRkcmVzc2VlIHlvdSBzaG91bGQgbm90IGRpc3NlbWluYXRlLCBk
aXN0cmlidXRlLCBjb3B5IG9yIGFsdGVyIHRoaXMgZW1haWwuIEFueSB2aWV3cyBvciBvcGluaW9u
cyBwcmVzZW50ZWQgaW4gdGhpcyBlbWFpbCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3Ig
YW5kIG1pZ2h0IG5vdCByZXByZXNlbnQgdGhvc2Ugb2YgUGh5c2ljaWFuIFNlbGVjdCBNYW5hZ2Vt
ZW50LiBXYXJuaW5nOiBBbHRob3VnaCBQaHlzaWNpYW4gU2VsZWN0IE1hbmFnZW1lbnQgaGFzIHRh
a2VuIHJlYXNvbmFibGUgcHJlY2F1dGlvbnMgdG8gZW5zdXJlIG5vIHZpcnVzZXMgYXJlIHByZXNl
bnQgaW4gdGhpcyBlbWFpbCwgdGhlIGNvbXBhbnkgY2Fubm90IGFjY2VwdCByZXNwb25zaWJpbGl0
eSBmb3IgYW55IGxvc3Mgb3IgZGFtYWdlIGFyaXNpbmcgZnJvbSB0aGUgdXNlIG9mIHRoaXMgZW1h
aWwgb3IgYXR0YWNobWVudHMuDQo=

