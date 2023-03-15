Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AB9C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 05:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asWYBlWdYDTABA0bgcuDcTAY/PMbEMHZcqIQ29qPgro=; b=MNFaZsWPreIq0i4EC4oIPltQlT
	ThXKeek1ZI+PCNV0VFnXmPz6wf6li+pKR8RTyC2/dJpBBSHVKqI5MyZkx1HYqAA2pR/cA6WL08zzG
	Ul51gcMnNvD48iKxP/IBb7wFTcbZehTveYTGoNXukDPgoOI6zanhfMVps7cYafcr+JjwIF34sAS5u
	jDVbPfBaTk4vAWhWxyXSgE+2VgTbcI/Cbljm1nZEv8MZia4iDoSxym5h1ycBckgtIePrGaOzXX9v3
	Fkv0C7ROkUwJu0ok/E8PqI20/S83ssX1WmWi16ABnqSY1EhNSaO/TQkgCVQgmz9OnBdQme974A5jD
	H1ratWBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJSm-00CM5K-0j;
	Wed, 15 Mar 2023 05:14:12 +0000
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com ([2a01:111:f400:fe59::619] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJSj-00CM47-1s
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 05:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpAaJLe1pKV+vpwF2rnPSs7QOTLmPjdcj16Q+4v0jkjnsIrP3/1H5xnfXCLE+VNlcen9fe8skRTC6OFkJ/tAyzn7Z9sso+7//m3ukbYjPRm5K8WZain+SDOif4txcVCO43uiH9o5xT5daIRgQoqGae3bL34BWTzUWwLdSLo4R3hffvwHhhfpQXKAVruTWka4EYmuNpy5RQ/KHvBQepBALnGfJDokUMY9i6oim1eMOwCDh/qwABJHxsoveLbbT1Dn/QwZq20WRKjxYMsWecKLa0Xv/rbpCTCPwOi9zIUXlZY/DLeqNTCLhj2c8fHZm3afqfRsbCxmug3wCIgQgYMidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asWYBlWdYDTABA0bgcuDcTAY/PMbEMHZcqIQ29qPgro=;
 b=SNPFDXY1m7GVi/5UIXbVGsgnGmzIB4MDWZ/epEqjjZuuAUpUl60PxYQFPjUnkSWA8BwjBOH/HtOFL+ct8Pkx8w4qkNIhG5Fs3lhiyFR8aKfi0qN1q15vuaL1S+vFSkbjuIZZWkhB0aP9VpbqZh/YdrBWOF8KKJHCyOoZtu+jPUTb/Crdz77A5yL5QDyf7Bc3QKoAgEqD+XHGe3BQs4oI69f+dfqIr9ATjXP8q4oNdkx6Yirooqtavq3MHAet9yaBLcsMcGY8o1r815trDDDtvXKqj1NoZWW3vOkA8+JKqCSR46+FcMRhShvVmO2+g7iXOMgOHZw0PXdP5LiV7YHkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asWYBlWdYDTABA0bgcuDcTAY/PMbEMHZcqIQ29qPgro=;
 b=ezkPQs/h0V2VKteSb1U7XTjPZ5UBNggW8BBbRt2J66gxWA96mU6m5WObO0svXflkCNWGMpojneoWDmmbtxB39BVpwQ2Jj0cyllEGhYcQ6HZ0n7YY9gQkM9VurKPT+MHi0C/sl8Hrzk5QlPUBTsTLlHacG5sqDeFCbNqM7rbEBmwzUBYXLTDtXrWmDrPwazMQG5nkId3Ce2kuXQAStUwD+TBPGksBkBZX7hp1FVcEN3OU0RRdAkfKJEAbwIm0UzNyaz0CQplHdSZmc2iNyV6viqZXaq7ZMNp5uyUtEsR/zNIN3Gpo4aPuCjViA/Lu4+HmIvE7KP9Jy9LEEJwRnuay5Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 05:14:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.023; Wed, 15 Mar 2023
 05:14:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvmet: Fix error handling in
 nvmet_execute_identify_cns_cs_ns()
Thread-Topic: [PATCH] nvmet: Fix error handling in
 nvmet_execute_identify_cns_cs_ns()
Thread-Index: AQHZVj0a+gbIqpEsbUS5j4mHsflPrq77TXCA
Date: Wed, 15 Mar 2023 05:14:04 +0000
Message-ID: <bc96f62d-8bda-4d98-a8b3-6f6e40aa7746@nvidia.com>
References: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB7039:EE_
x-ms-office365-filtering-correlation-id: 968ca116-2be7-40d2-f9cb-08db251418ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  zuLRL/0KGvYB94X1T75QFfd6rlWRCZo3mqw9WIOoeOMn2GOdhnd7Cax9v+mGz7BVsRpqkeD3nVDs+MRxVjbY0haE5VVF4sm0SnoneeshhPjGf6Ba6zeYQr0ZGBJbsN+PdpUhGxhvo+1bc14GXA9rck7F95qC8Su6IzuBnEFdS8G5M6gVAR61Jo8xvyPBAv2aMFvFBFCY7icLNCdMP3+ZqtrczoZrgXoKhfwlX2jsNrXjGHsc+Eptgm+zKquDBcmZXNh940Ds80VHLO3yH80JXlWxfZllAJgLd6dLIatjjKsuQQS7H6d5VR1a5xLqYh7P5ilqhvcmhtfYvQ2shbAYxYpFZWhSYyt1MTePoEBeP5XyEfGyyyHqvUwGsp4qg/AopstWKdHYr7KC88sTxIjP6DrMgjySI+dmRU3Ul7lcplFBYl34wYz7y4beq3gI+QYhe6FMM9vrg/pT+gmCgD5rdo4k+s96uj8txDoiq84gWNZkCKQXxfjR24ZwKaEQh2xcOsCxkYZBOLD7vDD6B7QIvzHsKZcii8VyhW2mMmJBJzFd1nQamJci8v4e+KlYpxGH5oCfusniSuw83WVbY67O2ttwzFZUWj8YYJAAhuFMu9T3QYKUXeOD4D1VivrxEGThas+fMMMZaLpPra5FvsV24KlyMjq0QteEzzhBIBze4r36DK0qmNzXV+e7imP3xX9KriUxRluTZvGbaewi84XIiZ88gUrEKcrGqDLJHRT602hrhClZ5P+XP/EmH3HLOLaAPMQm4KyPRxdeAq5fAQNEWA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(86362001)(36756003)(38070700005)(31696002)(38100700002)(122000001)(91956017)(110136005)(66946007)(66446008)(64756008)(66476007)(8676002)(66556008)(41300700001)(478600001)(76116006)(8936002)(316002)(83380400001)(4744005)(186003)(2906002)(2616005)(71200400001)(6512007)(6506007)(53546011)(6486002)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SjlBcGZwbThMQ29QbjB4UXd0WEFaSG1zMmRMZjFtR0RvZmJCTWJyYXdqMlFH?=
 =?utf-8?B?TkVxbFBuL21yK1p6NERaSzRzaWRIS3FyZnN6UVlUdE5TMGFhaUM2Tzl2SUlU?=
 =?utf-8?B?OE5jSVVaU0tsRlpmU2t3clYzVXdsQkUzV1hDdHBIV3VkSXFtVVNCODV5d1dj?=
 =?utf-8?B?NGRBdDh5YXBvN0E0T3VIYk5odXhEZEpRcXp2dGl0Ujd6cFVEelBiU3VpV2tu?=
 =?utf-8?B?S3Y5RDFoSEh1TkE5T3FGM01NcUlyL09qc1VtWUZ0Z2I1VmtURDhDaDlSYlMr?=
 =?utf-8?B?cG1MMm9Gb2dpbDVEWTBTY2xjZ1JWMkFMSFFzc1hMOFM5cVRkU0N4NHZzMTNm?=
 =?utf-8?B?SzJvS0RwcHNodGdvTzBZSDF4UHVORktla1pET0VlTjliQ0FXa3IwbVpiaHVQ?=
 =?utf-8?B?TFI5N0pUYWVVSHk3bVllL2dsdzNoWFBETnJhcGlmRVB5ZGcvUjZtR01HOVpG?=
 =?utf-8?B?cTJqbmc4amtqNnFSUWdYUVAwelBvVGtURzNPTEM0THBnREs1Y2FSMGdKZ0xx?=
 =?utf-8?B?UkRkTU9UWHlha0h2bGZiNTJqbFpUOE9MWFo1YzBXYnkvZ1BYY24rMzlVazBP?=
 =?utf-8?B?YmxLWFI5a2tQYWhRR2NLd2JFYmpHTjdHRHA2VTA4aUtZTU80bUxoUUc0RzlC?=
 =?utf-8?B?S2dQbGwxZm8zbTZrOGphNkNjN3UzNXN4MnhsNC9WbWdybmVlWWhYWnV0R3hP?=
 =?utf-8?B?MGp0WEdmNy9jWG9FSFlKSThIL1pXaCtEQStUZVdNdDYvSE5VWHBmUzJ2bkpO?=
 =?utf-8?B?c0xTcnpVVEtiaSs0RUk1dU43TU53UjFiZkQyQ1h3Y2xJdnRmRHlMTFl0ZG5i?=
 =?utf-8?B?SXIvSFR5aHJOVnU5WUg2S2wweG5HM09UWUtLWU1jYXpQRDQ4QWUzbGZZSVYx?=
 =?utf-8?B?ekwwRWRTanJiUHFKWDRmMGlybDh5M3B4cVh2ZTloSU5NMnJlMUtGSkc4VnBq?=
 =?utf-8?B?WS95eHVhWWJhelo2eUFxbFg3OFNJb1lnWWk3VUFLbmc0SGh3VEh2emVZZmhl?=
 =?utf-8?B?ZmFYSUR4NkNuWEtpWWxyTnVvZjNJQld6UjYrMWlrNlRKK2ErRkpsdWYxeFQ5?=
 =?utf-8?B?THYrTURCb2J5ZVVIcUp1VmYyYXlNaTBOc3FhZzdQRTFUSitmSWpTWDgyUUI0?=
 =?utf-8?B?Mlg1U081bDF2eEErM2E1Rm1SY3lxNVN0RkZ4WkE0RGttZUdCa3ova1BBN04x?=
 =?utf-8?B?SDNaR0t1bGYwR3ZQWWkrZDI3ejg0NmhabEgvNnZ5d1ZJaVZjNGdMcVpNMlRY?=
 =?utf-8?B?cnY0TVRaYXVudGZQdHdtbEdiSjI2QzFGRVpXQi9rbkV2N0NXZCtla2JZcytv?=
 =?utf-8?B?a2xJZU9mVGtJdzJRSUQ4RGlHRSt1R2c1VElCYlRMaS8vaFUvLzBtUmJJU3Y1?=
 =?utf-8?B?RlArNnBsU2JWZ1hOOUtxcnl2c08rT2RFQU9HWUptZ2lXb2tQVVl5M1IreXBG?=
 =?utf-8?B?V3RXRHNpSUVjS2tDZFVKeGNXSmdGbXEvaUwyVzc1U0grR3JYSERZRzZMMEZC?=
 =?utf-8?B?bi9jV0lwMHd6MWZLbndDNE5ZOHI1a1ZMTVRIOGtwbkZza2pTLzJvWDZOYzFi?=
 =?utf-8?B?MDNhTDl5dm9hWWNKRlVwMVVTcVBDbnpCSXZKZHB5OUpCa1l2Qi9HeldET0l4?=
 =?utf-8?B?dDFGVVk1b3hoL1A3WlJVbnRmeXR3Rkg0SDFMODlDek9nVGhSWlI2UHhaeVI1?=
 =?utf-8?B?UHRLdkoyV00vMzl2bCs0Z0NsQjBhTUlmZGtFSEVIVW9OUnFOZ2o3emRRT2kv?=
 =?utf-8?B?UVhGKzlvbDhFcnZXSjRaM1JnQ2pDdGhrdERlZC9jbFlCM1doYURpTERZUXNB?=
 =?utf-8?B?TjNLYVhnUDA3ZitBbDhqZXJEODJuV0hZSWUxYkNiK1MvNXp2TUlQREtUcGt3?=
 =?utf-8?B?dVdjS3ExRExrQ0tYdjlSV0R2K0tsSkFUL3Q3aUVsUDVLai9RekVmaXMyeUdt?=
 =?utf-8?B?SE5nQzNVNDZrRVI5U2NNN0VHVFpxM3p0WFNVWnpFQWIxd1R6OWRicm1tbUo2?=
 =?utf-8?B?UStpRU00WmRPdG9qaHZWSjJqN2I4UnF1dXArWVo1bXBtT2g4Y3RrRzEyZXZu?=
 =?utf-8?B?bjVzUkpzaE8rNS9VdnZ5Q29UVTZDaHJ4bEduZzB6Qnd2ZjIvdjdPWkd5SlIr?=
 =?utf-8?B?OElkWkJ5SDZJSUFwWFA5WmtsWkV5RkpwRmNzNXVyWjZhaW0yTmVUSEVQYXVm?=
 =?utf-8?Q?kPh6ylg1yQJ/sWxh76ny7skmfdpwT5XCI4/gRGbAClSW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A848A3E8368E484FB8D4F3C015E0B47E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ca116-2be7-40d2-f9cb-08db251418ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 05:14:04.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Htz2iUUTXIcie59mV6nj5zmQt3wvOluYSJj0tqtpr4OqhSEecaG0IZf7p/wiUmDSFpFzdamKYFaX208to17Z2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_221409_867746_CBCAF00E 
X-CRM114-Status: GOOD (  14.74  )
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

T24gMy8xMy8yMDIzIDExOjIwIFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gTnZtZSBzcGVj
aWZpY2F0aW9ucyBzdGF0ZSB0aGF0Og0KPiANCj4gSWYgdGhlIEkvTyBDb21tYW5kIFNldCBhc3Nv
Y2lhdGVkIHdpdGggdGhlIG5hbWVzcGFjZSBpZGVudGlmaWVkIGJ5IHRoZQ0KPiBOU0lEIGZpZWxk
IGRvZXMgbm90IHN1cHBvcnQgdGhlIElkZW50aWZ5IE5hbWVzcGFjZSBkYXRhIHN0cnVjdHVyZQ0K
PiBzcGVjaWZpZWQgYnkgdGhlIENTSSBmaWVsZCwgdGhlIGNvbnRyb2xsZXIgc2hhbGwgYWJvcnQg
dGhlIGNvbW1hbmQgd2l0aA0KPiBhIHN0YXR1cyBjb2RlIG9mIEludmFsaWQgRmllbGQgaW4gQ29t
bWFuZC4NCj4gDQo+IEluIG90aGVyIHdvcmRzLCBpZiBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nu
c19jc19ucygpIGlzIGNhbGxlZCBmb3IgYQ0KPiB0YXJnZXQgd2l0aCBhIGJsb2NrIGRldmljZSB0
aGF0IGlzIG5vdCB6b25lZCwgd2Ugc2hvdWxkIG5vdCByZXR1cm4gYW55DQo+IGRhdGEgYW5kIHNl
dCB0aGUgc3RhdHVzIHRvIE5WTUVfU0NfSU5WQUxJRF9GSUVMRC4NCj4gDQo+IFdoaWxlIGF0IGl0
LCBpdCBpcyBhbHNvIGJldHRlciB0byByZXZhbGlkYXRlIHRoZSBucyBibG9jayBkZXZpZSAqYmVm
b3JlKg0KPiBjaGVja2luZyBpZiB0aGUgYmxvY2sgZGV2aWNlIGlzIHpvbmVkLCB0byBlbnN1cmUg
dGhhdA0KPiBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nuc19jc19ucygpIG9wZXJhdGVzIGFnYWlu
c3QgdXBkYXRlZCBkZXZpY2UNCj4gY2hhcmFjdGVyaXN0aWNzLg0KPiANCj4gRml4ZXM6IGFhZjJl
MDQ4YWYyNyAoIm52bWV0OiBhZGQgWkJEIG92ZXIgWk5TIGJhY2tlbmQgc3VwcG9ydCIpDQo+IFNp
Z25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2Rj
LmNvbT4NCj4gLS0tDQoNClRoYW5rcyBmb3IgZml4aW5nIHRoYXQuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

