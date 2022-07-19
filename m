Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D7EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JcAi4Ef1q1f5o3FjqRbDqQQe0+jpRTAcycKylTawMWU=; b=oa/BB9sFobVlatTlX+NnLhcD/a
	nPN5S2FRq0hluAk2Ps0vFss8ZgBvmcNOEi17eIS8Lguys/JrpT1w6Llj0U1wxHWewUUJ+m+/9IMuv
	/GJwjgswO62Y3HXNE4FlGyqb5Exkg31Z8mrfmeqIR2xg9DLTyt/ZM3IqZBDDGiB3YfFbFsgJbx12y
	9mSElEMYGrcIMYm8NX2UWU3Km9R15CR3eSxNB8+E6SlKaSSPal8OfQfNnzBDDF5QnU/E91KTN8X46
	UdFLSJVJ/cHbzozy5hyMLsU12/a+mTZH6spwP2ZSpLMR0LB+K4EJE4/btprG1aU5rFg7kaQnQgZyH
	V/UWaYtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhBu-005kqF-F9; Tue, 19 Jul 2022 06:58:46 +0000
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhBr-005koH-68
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 06:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZQxNYaBNnvZWMIGEA38Q3Ep9jI4TV/Yg4b7lf/lyUUGqFeuyuBFxJnNR/WlScjmHDrCxDQQe3Vxc4ai046jtThElDrff7gKIckAFf6zIghnjA5ghWr+/S2+ihNmOjhPDwP3RSoJl/bzQE1Wx0Wb/9yUwyge66HC3noYNujppLLbrqaL09aOkvA1WMKT7ErkYJTdH82DZekycUr4F1feT483RJqEgSSF/S2z58fMfBmp7g1J76bvblQAkJ3j0UuRw6waMXvUugvQFEZl64DyYzWCvsCEOfuto/CjQxF1lpo7vDlwIE6VV/k0ynjI7vYJuFZyzQ1Ku9KmZ8I63OGo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcAi4Ef1q1f5o3FjqRbDqQQe0+jpRTAcycKylTawMWU=;
 b=i07FUVUKAbE78VtINv+hktf3H3FHv2HtMvKVeZ1/yefvaI3kfXys0s2Y+SDxYRYln+1NSVO6RkmpSiinXpBSq4S410VYs2K7s21fxpxHQ9SFzn5tn71lGTCpytXPz0bWDkoInTmIJKLksPMGTn+9TJqt89qtSpMNYlFcdtb2jV0tFnkQe+0lb232NZSuLasbkBZLp2DSLwN73J34px84Vljh20Di7ZcPDBzeYYZl2jL3yGsq0LWQST1m4qn3RhwIusUOndU1EwauM1MQ5L/gaLGHaoLZnwqdbdb6FdMYrk4ajyAdBdjscgakTcfFVoceG1xBOnlW6jbkgKWW4NoqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcAi4Ef1q1f5o3FjqRbDqQQe0+jpRTAcycKylTawMWU=;
 b=l3v/r5JvUUQ4CYrpTlyTfD8+chivGkxvPiph8E3cJ2ZZ6XuAcgCWH0CM2pPs5m4Ii9qwoPX0uSG8rF5AMpO0chzlTyd1TxljlkFWqgMamKFUnDXQ84d4alfVjeABatvm+YvBjMkF9b7loBPLJQe61xea3FkuCzbJUNTjyC3ljfNjRKlyXaKs71TcpgNcc+zaMpVJyJ8LgncK7Ul/fMVQwo1w5DQJbNuOvN7aiTNPIK8ZK9gwUpeMaDt6gHOAXD3BYHptVHlbOYTlGdkVLVZ+ARwwPB3VY91Xc4wm6Ni9IL9SqepieML/9li93LyFCYp14OkkHyFyzhgjrBIJvVrBGQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 06:58:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:58:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: NVMe In-Band Authentication blktests status
Thread-Topic: NVMe In-Band Authentication blktests status
Thread-Index: AQHYmv7CoKmZfXV9NEWBBHTpa/U3ua2FQj6AgAABtQA=
Date: Tue, 19 Jul 2022 06:58:38 +0000
Message-ID: <cd52b338-78b6-12ff-6af1-4bf477f924f6@nvidia.com>
References: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
 <c96380c1-8d12-e67f-b9fd-0e5f55b05a4a@suse.de>
In-Reply-To: <c96380c1-8d12-e67f-b9fd-0e5f55b05a4a@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f4ac9e-6957-4f13-88b1-08da69541b56
x-ms-traffictypediagnostic: DM4PR12MB6253:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Vv2skbvNJHLFJKfIEnUONl4GrT+fhx4EbGSmcWNUg2GyJnDumEiT16OwHpQim4HHDzeup8rD4nOV86G1kzaWBHGXCiprIig7H4LwB6VFgbjCEUAzF+GhceHqBw6XpGIUQK3FuTHPVNXJUkuVAoEoGOYNvp9BljET/r8HZgrAF3B7DHLAZkh+aIr6hoiYbaEtcACZ1KJCajDLFN0NWBu8w/5TOBUNo9GTqBY5VpC3RfQs5nBGneBs2W3qtHUWM+rj8ERIgYTkcn2XTfLZ9bV0VNnwsdEsN9WI3SEx3nT5G09Hiq3rM/SJPCX98RjBYk/r2Nw5YQRcRy5oo13RWVHVFWSSautlipeySr4/EdUApHPKdOioApoDXlBLuTQxAHTWT7iSwzsyZslNlqH8UKVd55C4bfu1nlsGsr+Q4XWlsuGmOBAoNqbw0tpKZP2CstnlLiZw7+K1dCj2Sfm2E49K9KGAtUp5/yHNUjq3H3KIVRyVzIcu4i7IwUWWszHh1MVfIjcKiRU3xvE6u/U1nV6v8w8zoScNJu1pTyBrD3Fdss1psYPAjjwguGKg3XubVVqxWUiywx992fA7sMB0uitls9mEqwlATaREaQsR+AEeGsVn0b+hPR6SJQxl163TL3wPnQxXwTyYFIgjF+YUnpybnvtH0nhI8gFu6zkGO4Xr8hb2Q9soU8DbC0fl1KbArHyruTHuCslhZBbYq1rGYAijUO6/h/1TiYSSeUpUCIXk8FyS7ap66eFAO5n6WxHwXpYDbpzhJS/YxrU0DQ3qCY8CuMwwjLL2iwy0HCpWcA/Kt86BcazzKtetVM1QzfFwF+emTXIMoBsQcTffcHaywkykAvnWGZtUevSgmCiqhnrgJ8U=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(316002)(38070700005)(31686004)(122000001)(36756003)(6916009)(83380400001)(54906003)(38100700002)(66446008)(186003)(76116006)(41300700001)(4326008)(66476007)(66556008)(64756008)(8676002)(66946007)(71200400001)(2906002)(5660300002)(4744005)(2616005)(31696002)(6486002)(53546011)(86362001)(6506007)(8936002)(91956017)(6512007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RXJzbjJIbmFseW83K0xvYmNsMzExR3Z0dkoyR3ZZSk5CZGhMamZxOU5haFBC?=
 =?utf-8?B?TFUvUklqdHJSaGl6Z3FEdTFXTjczSjVGSjNrQnRESE5qbktJTlFhNThZc0kr?=
 =?utf-8?B?S2YvbHVSOXFjaHVVa0VPaFBtcFBETldCaEFraXduQ3liaWFnWlZxUjRVWmtU?=
 =?utf-8?B?ZWFvTHdJZytKczM4bUh6L2luck5ESURNV0tFc1NuNUE2S3dEa3BrbURrcWJQ?=
 =?utf-8?B?OWNDeXkxL3ZoRTNML2RmazMrdmtUQkxKdGpvbzdXdG5VWFRlMzNFMFVvdE9v?=
 =?utf-8?B?TDRJUFNJaEs2TEtVVXlkRTNZZCsrVnJJNXlXcDRqZkdJV0NEYzBxL1c4RVpy?=
 =?utf-8?B?T05VSElNdEhaUFplZ1Q2alkyQnVXdkxUdWVpTTZiNjNCSGU1VS9ZaGpZdXFh?=
 =?utf-8?B?Zm90YXdtZE5TS0FJWG9CVlYzOWNWVldBK01lSkhrZ21udFpIMkp4ZkkweFpD?=
 =?utf-8?B?U1VLeFFLdHlpMTg1K2FXa1h3M0Z4TUZFNFBDUDc5bmN6QVAzMWlaOG5CT2s3?=
 =?utf-8?B?VjN3S1lXcDJJbE11S2ZVSWJWRHRhRURLK3Q1eGk3SnZiZ1VkTjF0bHdLN1Ar?=
 =?utf-8?B?Q0xDZEVKNlc3SDk0aFhXM21wd1FUU2JiQmJzT0JYYmhsZ0JJSm5DSEo0dnQ2?=
 =?utf-8?B?MElTNldVekJ4TDhmYTFnQXBTSzUzOVNSSFhkM0MxWWoxNDhoTlp2TnpmRVRt?=
 =?utf-8?B?Tnl0VG1sSjdJbnNrcms4VHFGVDBkeHZwbzI3dXJTdWtUMnluWUc4UDBsZnJK?=
 =?utf-8?B?RnBDdk5wWklpQmwwQW95ZHpqS1JCYjF1UjFxRmZLYWFGRml2QUpjcnJPeXli?=
 =?utf-8?B?dUZ0RDh6N3cvZmVTS3l3QXU0L0VkbFJIbVdXdm16eDZsMXhDWDRUNkxCMFVQ?=
 =?utf-8?B?NEtobjNEZzIxUkJsZjkwT2VUZEdHMXBSblh4Sk41RnJWUTRLNGlCc3UvKzRE?=
 =?utf-8?B?a2FyRk1CZC9uWExMUjh0WTRpcDhvV2RUdUZrNXpkTGRPbXp3Vm9sSVVacjgv?=
 =?utf-8?B?L0Z4OXdva3RwSGVaV2VCRjFCOVZhc3BQU1RUdVBFNEltYjFmcWlsSGczYXQ1?=
 =?utf-8?B?S1NnWmx1cmRJajJDcEFqSCtBMGFmdEd5eVRJYmNNdHFNbEg5a1ZPVXpNSHBD?=
 =?utf-8?B?Z0psZGJsYS9mdS9FYXFhNHlHK2JVYzZKZFlJbGZHQTA1aFZyN2llYUlXT3h5?=
 =?utf-8?B?VE9PcUEvMVcvejdwV2xpZDJvTmNNZzFRR1FEZVR4ZzVtcGlGQjhvemZ4aGw5?=
 =?utf-8?B?bnFMMWwyUTJGWDh4OFZxbWlYNFExTyt6ODZzc0FkVmU0NkhFSlhIaXZhMG1z?=
 =?utf-8?B?UkhMRUlNZHppc0hudmkxcVJuam5iVkdjQlRTMTdOb3pzUXBhVnZkVUo5bTVk?=
 =?utf-8?B?LzJmNXhxb3NFMUg2dzhiUFhZZGhCZU9qVklXUmpJTFp3QytoTis0K1VWbmQy?=
 =?utf-8?B?Q0RvQjlQWUJueUR4SjRYTElBMTdrMDVJWlFhUkpOMnRzRGVIdTUzeDFwOW9Q?=
 =?utf-8?B?cTNoU3NuK05mMmt4K1gxYnlNQmlLeEVsRnRNTjBNNVdUeit5ejZKalpQd2Ft?=
 =?utf-8?B?QXBXclVhc3RZMVYzTndVMkVVNlR1NVZhMlB3K1BKM0duNXdpQ2VUNTMvVTFP?=
 =?utf-8?B?NEJDRVA4OWU3Qi9ta0tOcTdOQ3lGRThNcXUrc1BPMCtJVXBtNzdWazEyaGE1?=
 =?utf-8?B?dk9RMm05WFZwYUp3QkhGdHcxWEFFNEY3ZzkxSXc2OEtHamdmVTRVblVoTGkw?=
 =?utf-8?B?elk1enJ3TXdwdEpJbURneGhXSXNsZ0t6dGpWWkhqandLSUE3eVl3WTFEYit1?=
 =?utf-8?B?eFJxYXNYVitGYUY4bUU0UFhMMWM2ZXo3STVSbC9KczJTdXh2VXBJQnBiSlJI?=
 =?utf-8?B?bWIzNGVEQzU5R2ZaMkg4aFlQYUkwLy9wWEdjcXVQNjJCdWhMUVBodGFtTXJG?=
 =?utf-8?B?ajN6WGtSWHgwa3NTQjZ6RWNPbnB4S21wNmkrSzlManltdXUrRTNqY2dwMHd2?=
 =?utf-8?B?K3Znclc3cXB6elFRaHVERnhxQnczcCsxVWQwVlR2czZGOUZWd25SWURaeU9Q?=
 =?utf-8?B?WUhUcEpGWHlReHdiWitVbjhLcHJhdGtJeWJHUm1neWNQMVRxRXRpS1BqeU1w?=
 =?utf-8?B?MHRieVhBakFqQjV6LzRRN3dYcnBZc2ZLOTVEZDhpZVpnWTVoQnJKMllzdVJl?=
 =?utf-8?Q?EFJ+viA1eyzf9BDMASExesrMZ+NGX70LUSpiZVCDMAZY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <094F256CA1F24D4D8E1CC40CDAF3185A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f4ac9e-6957-4f13-88b1-08da69541b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:58:38.2703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DxZ/BtVPrlNXJqZ073iSjIFP9nG/PDZ686l26sB70S1odyYbt9Fok8UNfH9ZXqK9va/gBsqrr3PU14hZEWVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_235843_262975_32D7D993 
X-CRM114-Status: GOOD (  12.91  )
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

U2hpbmljaGlybywNCg0KT24gNy8xOC8yMiAyMzo1MiwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0K
PiBPbiA3LzE5LzIyIDAxOjMzLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBIaSBIYW5u
ZXMsDQo+Pg0KPj4gSSBqdXN0IGNsb25lZCB0aGUgbGF0ZXN0IGJsa3Rlc3RzIGFuZCBzZWVtcyBs
aWtlIHdlIGRvbid0IGhhdmUgaW4tYmFuZA0KPj4gYXV0aCB0ZXN0Y2FzZXMgaW4gdGhlIHJlcG8g
KGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nKS4gQW55IHBsYW5zIGZvciB0aGF0DQo+PiB0byBnZXQg
aW4gdGhlIHJlcG8gPyBhcyBtYW55IGFyZSBhc2tpbmcgYWJvdXQgdGhlIHRlc3RzIGFzIGNvZGUg
aXMNCj4+IHVwc3RyZWFtIG5vdyBzbyB3ZSBjYW4gcnVuIG9uIGRpZmZlcmVudCB0cmFuc3BvcnRz
Lg0KPj4NCj4gSSBoYWQgc2VudCBhIHB1bGwgcmVxdWVzdDsgbGV0IG1lIGNoZWNrIHdoYXQgaGFw
cGVuZWQgdG8gdGhhdC4NCj4gDQo+IENoZWVycywNCj4gDQo+IEhhbm5lcw0KPiANCj4gDQoNClBs
ZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkgaGVscCB3aXRoIG1lcmdpbmcgSGFubmVz
J3MgcHVsbA0KcmVxdWVzdC4NCg0KLWNrDQoNCg0K

