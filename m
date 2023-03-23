Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A72C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+aYPr70TC3O4jGudsNKG42ZBu+craJLXwBQI4z6/xY=; b=wtaw4GUPcQDZYcAVLzVPNiwX9r
	PiMGWKIf7e76T/EBI9f5TG5+L0KqfAWfJEA5Iyn9CzRuZZksZ5NaRkQKFM442knbngxIXKiNI/vMo
	15GZMboULhQNq8UbxeaPiBClBuRVpngriSQWo3K6wMN6PV6SPeANWJcC2e/uRBORgk9qKJQRrN99K
	2U7ITLtsoCnnCqfg9uiU8oa7NTxTm8+jpm5ZLDYR9rPcIVW2OVT4gbrZ71OhxqcF+Ooyl5KRSaH+5
	Hqnpr9t5TVwg4iKPVlPdpP+NSU1FRLC4m9WysMSoOwOmJVAGcSFqMxoUITh2NpnCj+RHL79V6c5iS
	3WAkoPeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTZJ-00360o-36;
	Thu, 23 Mar 2023 22:38:01 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eaa::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTZG-00360H-2o
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 22:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH2g/H1HqwoXQ+iqtODkO4pOlLgTlFj7FZwbWic55RaxtOMijtbd1XiIcqHTSWfdJOi7f7mkbE/RR9FDbswXBXt1LIGe541NaZgty4G5GE9Ukgs7zPvekJuZzp6rZTTJFiQBc0lo8m+m4y0USOCrR36DXCVtPeWGyesdKwmBr45js7bBsV+KDk+3YzdxQhdgXu9Gea8FLJ+GMliL4QmZzOg9gJSQKUOi+u9rSKJx2atbGYJ2F/As1Z70eGC7R4tWsKfso1tQ3cBFwFKXPZbd4xHvsBQb3qBGD83Hr5qlsVc8yCqNDWPztjSt0hXXMZCpCIb630nSBtpXOyvzv5lRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+aYPr70TC3O4jGudsNKG42ZBu+craJLXwBQI4z6/xY=;
 b=aiQq+9h5WExWp0gnhSj84op9KDNMJA4FU8kGKxjir5owhBpDBp4O1bHDJUSvRk6X1hvJIjFfdpol22pKqiSy9oAsqpjWSRg9kJ6Jqx8DM1WULYx71iYrfgqln19Bl4FesdnKaGDzGgGIpiDXrAV9cCBDfJ4bggPMu+CmzBlreyM+KrVx7+EpaLziE3H3fgEnva5hrb+CM0UKUYMOXR4122/TImkRFWKkvq+Tca7VQfZJ1enAFvJ6//KETGV7nZnJNTKHBE5erDmJ4fbHXD1YxToVszN+4c+spRqu0BGvFHRr4mq/CJJebZ7bshDfvxRB7WKQDPU9BxG68xC8sFNV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+aYPr70TC3O4jGudsNKG42ZBu+craJLXwBQI4z6/xY=;
 b=bgzZpfO9N3Hg9qWJ9hTDepAQTKaF3Tr+FoajWqGAXJbZmb0Zm8zdOE14capWJBxlsSV2RscZpRDhNH1ISfdDd0EYxo+EVUqQFlcF2KaAszYShLci+0pgP9DnzPLHiGE+JobhLE2/J3DmlYoTxevqKcwaSkOuaSdV9ayA5vPA5F1WLDEReWLVPfih7bFmZLdQT1Hz5K5ENXUJIjyui8QUDaM62/XXox/B4y7QOhh0836Twq2gtL6r0t8SBl8G74P+K70wizp6hbeKxPtN/c3CJVGzSEqewofgpjx1jk1PvebdN/xptfP30Prmus+wzGXTcQpP1L6ALQIIqnevnlnxVA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 22:37:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 22:37:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Thread-Topic: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Thread-Index: AQHZXTjBXaqTKuNmt0amN2Iq/alJAa8H/26AgADxvICAAASbAA==
Date: Thu, 23 Mar 2023 22:37:54 +0000
Message-ID: <3584deb2-1bdd-4980-b2e7-a87067302118@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-2-kch@nvidia.com>
 <5639f28e-ec89-f2f8-5737-8209b36088e9@grimberg.me>
 <2745623e-2b0f-edf3-2cf1-7a8ca9415545@nvidia.com>
In-Reply-To: <2745623e-2b0f-edf3-2cf1-7a8ca9415545@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6638:EE_
x-ms-office365-filtering-correlation-id: 5717553f-d428-4d9a-d69b-08db2bef3e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  c4PnpuLTE+LiqxUnM4LmKktUtyX6OCIjablPM5yQNNTP37WjyXoAq4yMNp+cCezh1JhmDMXCoQgmxGfcqPy8jwAzg006e6hqZ25CI+tU37bDiRr00RYwQ5WtxeOQ3fuauY845GZr6bsIg3Zf/xBnuk4EVvjDeQ83Bu+kI6tK39E8L40fzuhBu3XAXoa0bw8hqqmHm0VAYdPloLoqMdseJAVS6l+zJ4C/AqmJnPGbYIZV/qf4YwwoHC/qGnL4F3Gl97p8L8Xj61ji2hqYccPQ8RemUULcDh29pOxdmwyLew7WOMeSdrm8O2NG7uOECm4CSA3qCeqFKZqc5LsnZBDkxueorLxm/QCCDjfrb4pU730jwFG1kxU4OH5k94Ga1iggmOJTH4+5FSoK6YZLsFoON7KPBXPKNLmtRohHuNMqBU3y/8nW6QpMaDc4cs4Wkbn2ZnG5IHgkLO4uJifAkCD5chdQGaGAXZ+R3X4tYZhKRz95AnJN8exx8hpy6X39BvWZTFpASXsml7FBPquRO32X2rYtrwC9a78TDbBZWJqJu8hqoaRfhStmABkuNQnCkPl6yGCAcI5WUWtFGcdnZLQPyuGQghSxZwDY6LgbA6fuErrkp9JEv5lz109OlwkuN6lJXtT/x+4EZzw7MyaBAujR0qmz7cWjrQQI391YUzS/LQJDdmVN3YXCru86KQL5FnP5/sBMCuRPWOoNP7MDXSuVMrapLM/c5UxreGIzNqWhVEBnohr/X1Q5GjH90zp9JdPa
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(36756003)(66556008)(66446008)(8676002)(66476007)(54906003)(76116006)(64756008)(66946007)(4326008)(110136005)(91956017)(41300700001)(5660300002)(122000001)(8936002)(316002)(4744005)(26005)(53546011)(6512007)(6506007)(186003)(478600001)(71200400001)(83380400001)(2616005)(6486002)(86362001)(31696002)(38100700002)(38070700005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UlRscnkrZHNIL1R6ZXFwSkx6SGJnQ1hiZE5ObnBic1ZTRDVKRjMyL1BVUEsv?=
 =?utf-8?B?aDgrNTlJTllzeE0rblE5NFZKSTZhWkJ5UFpOcXg4aGF0UkdOTXlQT0psZ29U?=
 =?utf-8?B?ZC8zT1FkajNhTmdtM0Y4K3dla0tTZXpmTHdKcE1rb0xrbU1qOFloM3lnVWhp?=
 =?utf-8?B?dlErY2pIRE1GMjRHczZkZVVycnNjb0xCYnBwanNBOVlsMlFxRXYveEJEMzNU?=
 =?utf-8?B?YkM4cW1aS1NycEE1TUplN3dsa0N2dkpFOUdhSHVsT2dNSG8rTk9zUzdkbFYy?=
 =?utf-8?B?Vm5iT3kwQ1hDZEdGcmpXdk9WdjlEOGlsUzRIL2E0R2JMVGJLRG9sUXNFUkdu?=
 =?utf-8?B?NW40UElJc3Z1YnVOTW45d1NoOEdXQnQvRFZLWko1blM4Q1IvcHB2cVNZQjRz?=
 =?utf-8?B?a3JIcTUzc0ErVG1GSjdsUlhCY0dYQzc2ODF0K2x1NTQ4cE1FamZ4bHR5b2JQ?=
 =?utf-8?B?UXJwNGl1aktCdEp5b1g3VlBheXdub2U0MTRody9ITlFoa3pUNld2V2UrY1Jo?=
 =?utf-8?B?NExMMkpqLzRrUHgxczBYb3RmM2hZb1VpdFNjSmlUbUtvaWdrWVl5R1VQeDlm?=
 =?utf-8?B?TysrczlNQWxCOU9qQ20rTEpNVWFqSmo2YUZIZFRaRHJOS0ZsL0VTV2ZySFRW?=
 =?utf-8?B?ODA3RENNTExkbnpJc3B5YjczS3BCYUV5ODFNenJubUQrYXJEVlpnYVE2Z0pZ?=
 =?utf-8?B?ZzVzQ0djVW0zTlJBaXFKVjZSUDdaT1RKTkxKQ1JCcWlVR3ZLQ2JSNWVaRkF2?=
 =?utf-8?B?V2dzUCtubTFkUFFKSHloTk5aN2JPb3h1RHFUNmI1bG1tWDkyUmwzdzVhbXRE?=
 =?utf-8?B?bExFbmRseTdHR1A0amx0cnBURUVTQlU4RUhCSlB2ZGc1UHQ3Ujd4bGpEZUVG?=
 =?utf-8?B?RGZzR2l5Z1JRUHRCUzBxTXhUK3RmelhBVzJGTE5Va1ljYmRyUjNTUzFwSkFo?=
 =?utf-8?B?QXIrbjIvSWdFbXB5ZldvSjRYb2trbHpUN2FxNHY5emhyemJMRkdHcWNXekJs?=
 =?utf-8?B?ZlJFMnVkamxCZjRERFRsd3VNUE43Y0dtY1VxbGhGYngyejlGRHc0dkJra09R?=
 =?utf-8?B?eCtrR0tUYXpYVFg4akxkTDYrZVQwR1doNjlGcmNmVzU0ZFYxQzRnMmc5M3pw?=
 =?utf-8?B?OWMyY25TVHFLam1TT1gvNnB5MTQ3a0ZIWXo2U0N4U0Z4R21BZU1rdmJadkZF?=
 =?utf-8?B?bUJBeTdreWdLTE5OS2ovbmkwYmR3YVlSSzIzRURHcEk2c241ZUxkcWhMbGZh?=
 =?utf-8?B?alhmZUZVaVpiZXhvdCt6eFZ4S2lKamRBV2F1R2hsaW1xSFNxeHUzTitBKzBq?=
 =?utf-8?B?Rm9zY2hzeU1lb1I2bVR6a0t4VHB2YlNwNWRMSXE0TW9SNXFReUQyell2aU10?=
 =?utf-8?B?bUViSWU4RzhZTi9zZnpocjVYKzNXQjJYK3VuM0V0OWJOVFVXcnFySzFsYWFV?=
 =?utf-8?B?NmRiaU5kSTFUc0s1SDJScXJDUlpRSkI4c2xueE9jbVBaU1JoZzF5VlpVMzcy?=
 =?utf-8?B?RnY2WHpsVjFSQzR3SXIzQVlzSkVFZnNJWWc4NjZlSW9kREZYdGlzcXRVemZW?=
 =?utf-8?B?NWkwR3BRUGFtczlkcVZRMStkN002TThkRzZ4ZENzK0lXeWdNQ2NLNk84VHhV?=
 =?utf-8?B?T1VxWjhZOGx0YXFTMFFuQmdjeGlzZXZrZkl1ZEtTQStnSWJvOWN2V0xtT2M3?=
 =?utf-8?B?VlR0WHAxaDVkR1Nlc3Y4TzZqcTd2THVtSFhkVG9GWDZIYmJ6cm1icjIxdHp6?=
 =?utf-8?B?M0hkcm0vc1lYUW4yeWYyeURqNnlxWFN3dUF1NlNmQzE3cThuWGdYR1RJZm56?=
 =?utf-8?B?Nk9QaytTMnFlMjFFeWxRRUxlbFpFdDJDbHE2RUJYbU5WRGhsRDB2cnVYbFMw?=
 =?utf-8?B?Y3hqU1dpcjZmV1oxQmp4cVZCYnNYV25HMjB3TThtd3FpWmZKak9BUHgwbjJZ?=
 =?utf-8?B?bHhha0RraHpNVGhjSVFhV1d1QVMwTUwwblA2ZDdCZ2Z4ZzkxN0RodktCaDhG?=
 =?utf-8?B?YXdhTy83OFk1QXRZYXRaNlQrelVwWUZaVjl4S1lpM1lNZmwvVGFHK2R3SXR5?=
 =?utf-8?B?aFY0eWFTVExMdCtyS1dMRjAySnJPZ25WUlVKK2s0djcvS1M2UEF5Y2VsandK?=
 =?utf-8?Q?hn4+af8iUm8gGnwCzLWdVegEO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8866A5CE725E541AA54C1F8B8331817@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5717553f-d428-4d9a-d69b-08db2bef3e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 22:37:54.5211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R7l1GZfy5G+dvi6Wv5TakM4Noj1Ue4TTKF6Y6FkgEVGc/P4UXs32/vtgArACFQttUl0Gq2DgZUisYx3R6rr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_153758_913090_81DAE664 
X-CRM114-Status: GOOD (  11.17  )
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

T24gMy8yMy8yMyAxNToyMSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAzLzIzLzIz
IDAwOjU2LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4+IFVzZSBjb25zaXN0ZW50IHR5cGUgdW5z
aWduZWQgaW50IGZvciBzaHV0ZG93bl90aW1lb3V0IHRoYXQgbWF0Y2hlcw0KPj4+IG90aGVyIHRp
bWVvdXQgdHlwZXMuDQo+Pg0KPj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGFsbG93IHNodXRkb3du
IHRpbWVvdXQgdG8gYmUgdGhhdCBsb25nPw0KPj4NCj4NCg0KdGhpbmtpbmcgb24gdGhlIHNhbWUg
bGluZSBkbyB3ZSByZWFsbHkgbmVlZCBhZG1pbiBhbmQgaW8gdGltZW91dA0KdmFsdWVzIHRvIGJl
IHVuc2lnbmVkIGludCAoc2l6ZW9mKHVuc2lnbmVkIGludCkgPSA0IGJ5dGVzIG9uDQpteSBtYWNo
aW5lID8gYXMgdGhpcyB2YWx1ZSBpcyBpbiBzZWNvbmRzIDB4ZmZmZmZmZmYgaXMgd2F5DQp0byBs
b25nIHdhaXQgdG8gZmluaXNoIGFkbWluIGNvbW1hbmQuLg0KDQpwZXJoYXBzIHdlIHNob3VsZCBj
aGFuZ2UgaXQgdG8gdTE2IGZvciBpby9hZG1pbi9zaHVkb3duIHRpbWVvdXQgPw0KDQotY2sNCg0K
DQo=

