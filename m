Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE924C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 04:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xulDYi2IzEcd0otQTRKQsw9+OhGFP1c5LY/U+64vOIk=; b=3cohQtx2LVrDhq16R4+vIiDqhm
	mE5RAICjw42YmkYIcrRloexNbC1gmb1jcCVleBnbJFru0FycK51sEpzFNld8rw1th9TeIDOCYW2Kr
	WthjghN1AU94Sz6eW2fJDRiEXpxqYclZQ6hduKkosclIj98w2Ic7s3sTrHJYIeLM7zyRNHpsCjYN4
	YNDm0AY9j+aj090l/FnDgCPHn7P2p6JTrLYy4rS2LBhxT8yYbFmkH6zDdDA//StEC/bKOEqo+UgtK
	OJx7EVo3Ud7FV6Pp57KyEC23nbdnRkEbsH49rH0kW3rU7T8c2vtMFJMDo9q3vi+P13KWm3XfaxTm0
	XI7ozlhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozsFq-0065dw-JA; Tue, 29 Nov 2022 04:29:58 +0000
Received: from mail-dm6nam12on20603.outbound.protection.outlook.com ([2a01:111:f400:fe59::603] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozsFo-0065cH-Fo
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 04:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chd/vcQkfJVEeqUdlOybDa8foi/fM4yJQ4e60dVnz713bSYCwJIcAzVL9kUn9sVVMCd4Avfm0GiQkBtiFSn5d7ImnBIz+9+eyLQXg9r7/rZ9oHbTZ7eu+8UM7gqOgaGsP81dBSgpZOF1vfz0DA4JmHZsWsLC5xLKa6OyJGsClaNb5woJXwHdthe4qxkd2xRVUfMD5siu2SqheYSdv5kggc2q+v/u3xLEGMQ0yx/CTl9XZYNefamLUcz7mVCh/BbPC/vvrx5hsthbstvpBhuLSbyROoN62O+lBvtW2jt3q3GqnKUHNZkQwLAvv08nO/UXmP/dHQ5RYWH2FeHrLp/GCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xulDYi2IzEcd0otQTRKQsw9+OhGFP1c5LY/U+64vOIk=;
 b=kkou537z0Sdg5FcnM+K5fqMNBwME7EY6V0deDjve8mpk8HFFT+ITXrdOEL030faY9ZjYHXiFgBd50QM6cDQAFO3uHNWaR4VPvoqKLCFtdeSfdW7LHz1pj0BgtOREyq2mRv7yQGrgV4Z1RI0VuCOOFXAqMYggHblfC5Tm+8CCvrpOhfe+ARMDsFm27Mph1YVpkHn7K1IO7IZBp1nRLDQOAmqZmjvVsbitGRLRFfMFmKgEPaWf26Rg7Xh7/e58fOdWY0bqx93MEMpA+TnBDiq2XyWKSOyh7GXPO/ujL431JwBUEFiEMCAe437RienweRlCyU2P0GL3zC0M69QyW7GtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xulDYi2IzEcd0otQTRKQsw9+OhGFP1c5LY/U+64vOIk=;
 b=DwQxslbo/3bXiWkvkwIeCdYNzwjbYPtE8DdZl8AKg1dWOuqJqjDNNcgp7r1cNk6XD11pIN3/J23DB2SdU/FnLjsd7ztOv/m9kNI7MZSl5ys0eJPJ1iLV3bYKmCy0ZarBTjstV2u/6RIkrPjCotCmbyVag05/qCydjkqaHOU4bK9MJOgBKL66F9PwcZ7czi/wggCHFisCPlZ+blZTNrItAHRYpUAkPpTMuQQa9TahgpGpAq18Oda+RfI/gl6cFDYQRk/+1PcjXF5mVes7ZDH3mO41cKZkE3qzRAYwjaJUknmeeZBjXa2J3JtIaO1x8Joq85wcrmfd0vGhBTwdnoRCoQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 29 Nov
 2022 04:29:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Tue, 29 Nov 2022
 04:29:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Zhang Qilong <zhangqilong3@huawei.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Thread-Topic: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Thread-Index: AQHY/i09uk2KN+nIPUOiBzwVUvdcTK5VWhgA
Date: Tue, 29 Nov 2022 04:29:52 +0000
Message-ID: <35dc4edd-704c-45af-7198-ac57947242d2@nvidia.com>
References: <20221122044929.27600-1-zhangqilong3@huawei.com>
In-Reply-To: <20221122044929.27600-1-zhangqilong3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB6989:EE_
x-ms-office365-filtering-correlation-id: a128a582-a272-43d2-63ba-08dad1c25c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ZxJkFktOFSEAkD1MF3bRE2OHem5ItIztWxqnNhTU7LNf+jwCvzUDDoJ6uhl18Hy4NNJGyzc4FcPwXEVkBurpijtoMkuaGVZRU5FeMTkG5XTWnsEfiYTJ0IElv0arUEjL2rSlTs+qelidxBQ2VzRiACDCQFOu7NGSGsQ2KO4e5vzfEGXbrzZVnKLP31P9O4kt8M76KcV/qh2hGwynNM3rgzLt+MHTSPOkyA2qefXEJwzcv8hz0qRAIg2g7lq5zkaZp6mlysuVvlQsbL0hmiT4wZphyT94+FzbDZBd98LLugoRZ4NNpZamAsxZ0vIWB88ZwqTWZ+L5sKpMzzRpULYTYhw5U01J6iPAbz0bgimbMNrYw7EOWuYzwQpwR6GGn5y47VbydZHX+PTGmJlkfaTkQ0ypk4DOrFHGvJ4WWVlGf7wRHzUUR3SaCajLU/mG8h19kb/DvEiYif1sPUlzZ406WqCrOREph+bOp8oZTvo8utxl+G5AxN3TbleOt9LQQKJbwQkEWRImoLQbTfzFA24Swptfm0QHSC8fJihWg5pYMTZ2clIGOjfP/tRGBMcDOH6NHK9dazM9VM3IbUMi/+sO/ACxavZj4wEIPiZK7e0w4MG+BOPYQsTbTQVbUas8COF336K8uN0uBHjyvaxGOdQQEf9hUYT0UuOoX0m6aZFXMpYWm4sNbe4Tb+cQtkAMAuq0KGaoUOHe6cSQeEDthnK8K3u6XKwxE7p5T5GkyLjmuU1B2/TmZyg7sd/8kkloR9vV00WFOqw+AnubWDYetBKoTXmW18MyP1A5Ly9MZqUcYkQ=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(31696002)(122000001)(86362001)(2906002)(38100700002)(66946007)(38070700005)(4744005)(41300700001)(8936002)(5660300002)(6506007)(4326008)(53546011)(6512007)(186003)(64756008)(316002)(2616005)(76116006)(66556008)(66476007)(66446008)(8676002)(91956017)(110136005)(6486002)(478600001)(71200400001)(36756003)(31686004)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?d3gvZ0tvV21pSEExUUZ1Mk1MejcvZ0NNTWFZTEFSSUJicjUxWURrc3RrVXY3?=
 =?utf-8?B?L1Q5c3h1RUhZRnFkQXZqdVlPOEh3SkVSY2YxTkxFTTIwTWdSaEY1OGkxWjBV?=
 =?utf-8?B?QlM4eWJidk9xTDg3TUk1ems2S3oxMGZQNnE5VjJVYndVVGU3YWlNUjdISTVE?=
 =?utf-8?B?RDNFSlUwR241VUJvcFhuZHdlM0dUMFZDM2NqbG5uM3pZOU1ETXh0RVB3dENy?=
 =?utf-8?B?UkFvYnZoVjMvakdlaUZybjI1MDNDVXpUNTJiZlhvV2NLMGJhdjd0RlFIZ2F2?=
 =?utf-8?B?R2ErdEtkRVRGRTFKOGpMVlBaQ3A1b0plbElzSEtKZW5qL2Z2K3lsZHdvcmJw?=
 =?utf-8?B?MlJwV1JsVjFsRlpyQll4cEd3VzM2cUx2d2VUaFY2bVh2R0FBT0w0L3NsNjM3?=
 =?utf-8?B?K3M3Wk0zcGJiUm5pWGZCNjI1RlVScGR3RldHN1J0enlyb29LYURQOWNYR1Yy?=
 =?utf-8?B?MzVESkVGY2syWVVrZlhldjgybDdrZXlUYUZoRnVTMkFYN1BxUXlValBzbW9x?=
 =?utf-8?B?UjV5akZkSG9ndXRDaEpPWnVZWFFYMXE2ZitwT3g3b0hoZHFLSG9qRktrbnRR?=
 =?utf-8?B?WlFXbUpZeDJPanJ3REhxVnJYbUFOY0lkN0V0Y1FMQnNlOENuZmw0aEZMVkhu?=
 =?utf-8?B?QUt0RXVDNHR3a3djdHQxNmQwdG1UTGlHTEROa3orZWMrVUV2ekRqS1pnSHlG?=
 =?utf-8?B?QVYrMnZBWktXWmhtY0twcitWLzFMWHZDVHEvZXQ0ampVN0ZoRTNKblF2bFNT?=
 =?utf-8?B?azN6L0ZiV1NBRVpIbDRFNHppQjhRamVUR2FNTnREbVpaUDhyRnBMVmVGSlRq?=
 =?utf-8?B?VVdGTTBLTXVGZ001MGx6OTZJRmtuVFJQQ1IzRFdGZVh0U1FEL0FlMkJrUjhD?=
 =?utf-8?B?U01zVUpNV1lpTWNGUGhuQ0VPUGpGOGg4RlVuUXhjOWpwcFJncFZESTNackIx?=
 =?utf-8?B?MXNmdzR5cXhBTFE2anhoWXpzN1JPTVRSclRieXZ2YlQ2RXVlUk1LYWhKVGV1?=
 =?utf-8?B?UHlHbFFwRGxsQUtrZzNQZnEvK0NKb0R5cmtuZDYxYkZXZmFvWHVsQVVRcVUw?=
 =?utf-8?B?cTcvUHNrWUwwQ0EwNkpNY2VlNEN4OW1oSU9Hc2pJNkNCRGRLRC83Rk9lOWVw?=
 =?utf-8?B?K2FuMVBQMVEzbjhKWXN4ZFRnUFJ4UWQ1aUJjbDVGdVZhTWVhaXUwYjRzeXo4?=
 =?utf-8?B?TkFZcU5UbkNGSkg3YkFMeGVzTEF4L0huS1JkUzFGOUtacDFNUFh6UmpFbzIx?=
 =?utf-8?B?U1gxeTVzVWFMUEh6c3RaSm9xTnJFR0UyTnBVK2hXZ1c1R3RhaXFIN2lHNUtI?=
 =?utf-8?B?cVQ4QjQ2Tm5LNSs4SGE4QXpHaEQrTmpwOElQZkREKzJBQnN3Q1RWSEtrbzJa?=
 =?utf-8?B?RXdodytBY1NjdWRWRlpjZ1pjRG9yQkxnUTUyWTY4MUdPMSttcmpBTWZDU1l1?=
 =?utf-8?B?U0VWSmZOTis0TnB2a3BVdGh0L0lDNVlkL0pQbVcrNUlyOVlFdnFqM3JrdGR4?=
 =?utf-8?B?WUpiZjNCSnl1ZVp1MzNzU2ZRVWplb2FPTEFBaUhnbkVxQ0VVY3hzZThhQUlX?=
 =?utf-8?B?Z3cyTXNBQUFNUFhiMTJqemdYZkVrWVdjYW9KMWJNUUVMa3hJaWp4Zk1vZDFS?=
 =?utf-8?B?T3pFL0M1QXp2NjZVQ250NjI5eXJxQk5uVW5CTEwwSXNham9zVUY1VFR2bzFS?=
 =?utf-8?B?ZkpRNElwRkpqWjdVYXNoYTRxK2pXMTFXcXVrZURUYmVFSG83aWN0Ny9tbVFK?=
 =?utf-8?B?UlloY3JPUElSdFZBcmg3ellhSHFCSzZDZzZpd1FCYkJqVm9lZ0h5R2RBd1NJ?=
 =?utf-8?B?UjBCbno1Y01kV202QmF3NnJEd25KVkJZQjVHdmFKblIrSS95aVJLdG1rQ2Nx?=
 =?utf-8?B?eERhWG1Zd1dYbGxpdWcrNDMrei9GM081cDg0Uk53UTV5RlNJc0luYjl3Znk5?=
 =?utf-8?B?bEZyRkFXcWFKN01xQUVKUFMvUDNtT21OclEvVDczT1VDYkFGVCtyTUJrbmxI?=
 =?utf-8?B?dVRKMzZ0RGtQUUo4elQ3MEIyMGdtRENOU0xjRUozV2JrYmNZTTJ6RjZSYTVo?=
 =?utf-8?B?ZTA5K3BxQVJjOTlYLzQxcCtCcTJoUmtDMUJ0c1VrSy81Y0VjckI0azlGUjl2?=
 =?utf-8?B?NTk3SUZ0VWVPbzFJc3pQdkJTWXNzdEpwVCthNmQzYzZCYlRBRUU5bmduVTR2?=
 =?utf-8?Q?5k1hFcEia//g+yaa8sFwrpYyBzReh8pvFBoj3nwveqFl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C25ABF9E7FD9DA45AF851C08D6FCD497@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a128a582-a272-43d2-63ba-08dad1c25c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 04:29:52.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqCi/reyHkZWwQaOMnWGS55rDKRQu0lOW0LBUBdEOUpiWr8M3LSzfGW75WkCWSRVGrP0T1iON/CtDNpA5U8AXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_202956_552460_9DDB1579 
X-CRM114-Status: GOOD (  12.61  )
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

T24gMTEvMjEvMjIgMjA6NDksIFpoYW5nIFFpbG9uZyB3cm90ZToNCj4gSWYgZGhjaGFwX3NlY3Jl
dCBpcyBub3QgY29uc2lzdGVudCB3aXRoIG9wdGlvbnMgb3INCj4gbnZtZV9hdXRoX2dlbmVyYXRl
X2tleSgpIGZhaWxzLCB3ZSBzaG91bGQgZnJlZSB0aGUNCj4gbWVtb3J5IG9mIGRoY2hhcF9zZWNy
ZXQgdG8gYXZvaWQgbWVtbGVhay4NCj4gDQo+IFdlIGZpeCBpdCBieSBjaGFuZ2luZyB0aGUgY2hl
Y2sgc3RyY21wIHRvIHN0cm5jbXANCj4gZGlyZWN0bHkgYWdhaW5zdCBidWYgYW5kIG1vdmluZyBh
bGxvY2F0aW5nIGluc2lkZQ0KPiB0byB0aGUgY2xhdXNlLg0KPiANCj4gRml4ZXM6IGY1MGZmZjcz
ZDYyMCAoIm52bWU6IGltcGxlbWVudCBJbi1CYW5kIGF1dGhlbnRpY2F0aW9uIikNCj4gU2lnbmVk
LW9mZi1ieTogWmhhbmcgUWlsb25nIDx6aGFuZ3FpbG9uZzNAaHVhd2VpLmNvbT4NCj4gLS0tDQo+
IHYyOg0KPiAtIGNoYW5naW5nIGNoZWNraW5nIGZ1bmN0aW9uIGFuZCBhbGxvY2F0aW5nIGxvY2F0
aW9uLg0KPiAtLS0NCj4NCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

