Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29100C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmpSgbv2j3YSOU+qj158npAM38/cUhpBeIoCHyIv2OQ=; b=WOi80Uw2xt4q+zJaw/HHm8iVeb
	tbf6MP0tbTMSGGoDTx+3PuXkk6nz3RU5q03YsWOMH9WfxSntNyPIZt3JF+UUDVywVj/69HZdjeGWj
	FobH+jwbilPepBbGmQ1dKjkP5HG/QOiEItynbUXefOK7eQKDhNTMZI0uq3yGpReJ4VGNeWVmDSe6B
	ejutyTEL3KYFf3yYHiziiYUl6QLutSgy7+Qlc3k0o5QavhzGWqFRdOlasBzLPmC3AiaBUEniFhhwV
	d6eWL+sRhbHq3yTPto0rZXZJIaleuQFDFVHmauC2wShsuSeA7dsTA1mcd2CYRet3Dpn0MOhmPziDK
	PNUB1WOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF9RS-00EKT5-CZ; Wed, 02 Feb 2022 06:48:34 +0000
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com
 ([40.107.93.57] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF9RP-00EKSD-Hz
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 06:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG2LQXhyDK/d9AT2X8Gzlh4w3OdO8psqSD9X9PBt0F7Ox11TOX0Bf9PrnT4DeYWlM3W3IOegJoYuXDrS1ZYYz8SoNTDBydHxHS1PPUc+8D3vn24xwdG9u50o4hquttDBMXg2sDEDYakfow3qSbdy+LbusO9NPilHeN1/dDx/tc9HMMyEufNggIqirgCmwaqSk07/nslaYvUB3F5yPPg9/N32TLdR0VRn/T+t+vHz4/mBgEx/PLQRucbZTjmt1nAtgRi+Hkpp2hYFRlcqNtebOAz30ArYMl0fbniBvitndZzjoV9/petQiEDER/pZQ0fkN7b6bLD3D745lZI5EpMtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmpSgbv2j3YSOU+qj158npAM38/cUhpBeIoCHyIv2OQ=;
 b=BeNBRmht94qH/xNaOnKJPN7D+o61rGVT6gLi2K/iz6fAwaEjbKVHvU4/khss3WQodaSxJ+mZOGn40u6vI2BqBOMOTwXEknEiFdVh3WDal+4YBclKXr191oZAUDvG/IBVPDEmD70vHi4dtVJ7ncy4CC2l19J2gkjzXWdIpGrQg9JYmAPH+47GYIXqs2Smk8xFDo/DZ2lSiMQTnkjNIjz5mcsqd7Fv0fe66aQBispItQjlHE8XKNj12yM4GeT8/mmBQEFwZfAdJke1cNlgo3yCx7pkLyraOWSl3QMlcy6sgKueROnDDSIClDwwUIOejjEfGN7nICT/9TxfIiF1DFSE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmpSgbv2j3YSOU+qj158npAM38/cUhpBeIoCHyIv2OQ=;
 b=ncRBwhLKqQUTgWnJfamNOIGtTDZFO+RSFjL196AsAaLE2BmVyxoCcIst2D/weE+dxTpJuCQYC0yq539rOBdHKBUJU60kDVJDAhzF0N51lLdfnX580BZpJ5+HX8/VGA12bN8pnNu/FO7Xass8tsa8SpALb98vJCprKdOGtSxDscY6+hZ3AMikvtqndmzexYx03YWVCStzjWcmwPZOq7fGvLIVviKlysLzvS4ME7sWQ/sPNGiFrhxqXR15WyuEzH0qjJeu1JF7btIrP9bQ70hYPZcdQ3k1ELTJ6OnR+aqfHwAwPootVDQU/W8ZO7DC+COrZDkMsH9JwqYp/zn3UNF15g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4986.namprd12.prod.outlook.com (2603:10b6:5:16f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Wed, 2 Feb
 2022 06:48:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 06:48:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Thread-Topic: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Thread-Index: AQHYFCh95lgiCCmEvUGD5FramLij8qx7VIeAgASE64A=
Date: Wed, 2 Feb 2022 06:48:28 +0000
Message-ID: <6b10d268-a1ad-2cb7-595a-74729efb8aa3@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-6-chaitanyak@nvidia.com>
 <4d067af3-5ce9-8337-efde-6410dff4c904@grimberg.me>
In-Reply-To: <4d067af3-5ce9-8337-efde-6410dff4c904@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 011a137c-acc4-4092-2cb7-08d9e61804a9
x-ms-traffictypediagnostic: DM6PR12MB4986:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4986628FCBF01183B5B82816A3279@DM6PR12MB4986.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAzi03pERO2EUg400phCZOGq7BnERKJZGJHyimzhgqIkfHWlPg89tJw4HHAFuFfJ4veO/E0SRYZ72Khh0ZcJJWDo0AM+he73Us1X3k/F6EY9smG1Jz7QSLoAKe5spwftJNqfko1fZk2scSxbh/XwzdQSC6xc9YVGhVd37mkvPjmP8WQMalaTwUIXSv5BA+SGzMLfov+vbqucAxHpwXeI/jKNvkp4Ef8cuJlg7sezMiisRGEmzL0xMq5XYQleFDk/nADp8WL5VoBK6qgjz8c181zQQ3069Uw5EOy2YchQlwePS2lN7Lkh/MB5XZCL5robjEP55ZDodTxm7hQ3KVLehEk2JMJWBtcqKCi+MBXu3njL0+8fYoFTYIp+aT3F76J2JzTpkr8XSPxZq2QVt9uVfLXsm7K3phujGGS+6lhtxpJ2wddWRn4YLOa3T9mxKYSqDwdbuSeNkDERftQr22//ofCf2R0iDSZ06LOcFx++TdIdgXX8j77HWafVwOnu2y/zbkoPOVpvUZmA5ifwArykKWVZwzI6MghKuCtbOTjX5Lrz3qX7m19YtmiUxTLUVIVKE3/yX3yJsNVOnF7EZbPo8D3LNNwqlvO+ZpTCCnMeQISQoeFSyC31yaje1EWdCxZZIi//OF8WKYxVthFC2wAQsBQ2sEE//TZJyP1dexRjH/UL7UtUfZ1vxuw4UUdyilK033nmbR4yQLrMZTOEpENCVlueCfXURPjSQ4N5JEVJBT7/PVPgCLLqL9EaPonFiPcABEKUyibT+0ClAd3XBZ6Ngw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(8936002)(4744005)(36756003)(186003)(2616005)(54906003)(5660300002)(6916009)(316002)(86362001)(38100700002)(91956017)(2906002)(66476007)(76116006)(66946007)(122000001)(38070700005)(83380400001)(6512007)(64756008)(66446008)(31696002)(71200400001)(6486002)(6506007)(66556008)(4326008)(8676002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVVpeDVlWUNFTW04Yk1zKzhNS3MrcHZEeGIvOVBvcytwMExLb1p5UWYzZFB6?=
 =?utf-8?B?a0VWbW4rbjkveVNnenBITUREYWdUeHkwNGgxLzdEdzRhOHBuN2VNbjdNdWFj?=
 =?utf-8?B?Smk1cGdqWmo5YldqWDBHNSt2ME1Namk2QTdTTDFIalhiUG44Y0IzNjl3WXVq?=
 =?utf-8?B?NndrNWFlRHBkaFV0TlVtVEpuT3d3TUJybzcrOXQwdU1YdGFTR2tUdlRTWTRj?=
 =?utf-8?B?SlN1Y0ZLSEtGLzRJSXFiWUFyZFBJdDRIUzl2T1kwbnlZUEY2Y21DVWF1SWQr?=
 =?utf-8?B?RXpHN1dKdkRiekJXSmNSejhBZlFKVEVzYjlVb0JqOGErOUxnTFRUSHVLZlgw?=
 =?utf-8?B?c3dsa2UyWmhJc0pOSnZBZy9TZXErMFBEam45TkZQa0lPV2E5T3BnWFY0TkNz?=
 =?utf-8?B?UTZ1a05ucWRtSnQyeDJ6cCszV3BSQ2VKYW1GNXdiUDlVdjBDYmYwRkpRL3RU?=
 =?utf-8?B?MDBQK0hZNnhuOGJnVW5qS3Z5eWhNVkRBTXQwYW1rNGFya3N5WDhiTjNTNWh6?=
 =?utf-8?B?N3FvWTlQa2dhUEc2dCs0NWdHYkJFS0VrVytTdVNQRTc0aVlkdUlYZitHMXB2?=
 =?utf-8?B?TTd6enNvbC96VS9aR0J3Wk1jOXY4UG12eUt3UERWb0wrTmw1MUxVM3BremI4?=
 =?utf-8?B?VHRyQi9xMWN3bVhod29zY0V5QXhGNTlSVkhvTUF2VE0ybFR5bk9wVW8vRFJE?=
 =?utf-8?B?U0hCQ1JmdUZJY0MraDc0eHdkMlc3SkRFL2kvZUVKU2MzVW1nR2tjNHVaOWdn?=
 =?utf-8?B?Qnh2b0VuTjB2enFBb0kvZzFSOVhpcWtiZk5aS1V3elJWdmRaUk51UUdDaFV4?=
 =?utf-8?B?OFVGNTZZOEsvc1REd2Q3UmJkMGlid3V0UTRNTUhXVlgwS044OXlNM2NYYTgy?=
 =?utf-8?B?QkpKemlrcU5EQzVUekpwaGE3cjd4VUx4VCt0NjBnTTR2ZHluZTBXNGExSFBK?=
 =?utf-8?B?TDZ3R2swYmxjOWJDQnRRSm1va1NlT1ZvNFpjdDM3YW5yeDRjM2RTQm5uSlJ0?=
 =?utf-8?B?SHF2VUdUcW5qWVhGc1U4T0hsMkxVQVFPd09uOUhyRXBpVTZBWS84TTkvbTNz?=
 =?utf-8?B?TnlkOGRnMFBoYWg1ZlRzVC9JRk5rNWppZEJpeVQvYUlKbklZQiswM1FUcUUv?=
 =?utf-8?B?cWNTVEpsZ29sUVMwU2FRa3NneWYzcVJocUxUTHBOZ2tCQ2k1YnFPTUNGTlVn?=
 =?utf-8?B?Wjg4OWdzbmQyWFVpcjVBN2ZoenJtOTVoMEkvUXpkSEFqeDhzSkdYUzBXQjdT?=
 =?utf-8?B?VWJxSk1ydnIzVzRNQllIZ3JOR0UrTDJwUldKZTBPejB2SXBxaVNjK25BMTV3?=
 =?utf-8?B?N1hIU3Y2RW8wOFEzcUhQZFdGWjNGUHRkMW9yMzI3MGlZL0hLMG4xbmhYMVgv?=
 =?utf-8?B?SkptYXJpZ3BpRm9TYjVITmhDM0h6N1BDQU9VY1U2ekRHN3J3dUNqZDMyeG12?=
 =?utf-8?B?YUJmbEZvUDYvdGwxRVZXQ1A0cjlKTGsydUNBb2tmYmZ3L2VQQm1Kc3NPQWw2?=
 =?utf-8?B?dXhMNE56OVQ1QzN0SGVoYkVZWHplLzlxdjBlMnJwb0Y3UVJrTGUzMUpDUUln?=
 =?utf-8?B?T3ppZzRiNWhXMTRWNEp2WTE0dnhIK3hQVzdON3Y2YTlPZEZiQ1NWVjN1WGJB?=
 =?utf-8?B?bHBuN2FUKzFQN00vR2ZRVzQyRVBXdEV4S0NMS2tTVDVDeFQ5VjZKa2dxSzk0?=
 =?utf-8?B?YTlIQmd1TU5BWW5sMU1iclBGaWlKOVFmYjZ4ejh2TVlJM3FGeE1JZTdBdkFn?=
 =?utf-8?B?NWlvTDdvWVBUcVlnSzNoQzFpcVNFR0lEV2UwdDBONjArU09EeGl1aklEYy9n?=
 =?utf-8?B?OFBsaFdyajFlV2hCUWFPRGJCcDNjS2ppelJ4Q0dRREtJSkNhaWxCNjg1QVFn?=
 =?utf-8?B?ZjRYbU9BRGxwQm03QlExQlo0empUWm1MUTV1YWNiS0M3N1RnSjlwQ1pFVEhN?=
 =?utf-8?B?ZjUrYkJoMXhIbVZ6TFpiWXh2eEJkaWgwUUFJU2s5bjgwUzI0aGxBZ2F2RmRv?=
 =?utf-8?B?NFU1cEZBT1d4N1ZsZDFVUkNCalFrcGNkUW1mbGZhbnltaW1DcGk1cVFPZ0cy?=
 =?utf-8?B?VlcyckVobnVTdkc3WW9NYkRTWlIrOVQ3bXQ5S3ZwUk5VUDAvR3Y4VEdOczV0?=
 =?utf-8?B?NkdWTmZzTmZydVlBY2MyVWlqS2ttU1M4ZDVLV1llbWlEYXBLMWptM01ydzh2?=
 =?utf-8?Q?Bi/G2Q3rCzriqDu9MPoF17r8dQdgsG3P73Xx2gl9BUEK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6FB89812A43C94FA2CE3589E353A7A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011a137c-acc4-4092-2cb7-08d9e61804a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 06:48:28.0341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMtzgP6vc8aCgiLUj+QquhgvD2ezW8SDN8K14VAdYw3FRKMxCSCnlCVWuo3SNEDI3wYms9wls26NDhqCSpIz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4986
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_224831_626642_531579E6 
X-CRM114-Status: GOOD (  11.54  )
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

U2FnaSwNCg0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2luaXRfYWRtaW5fdGFnc2V0KHN0
cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAq
ZHJpdmVyX2RhdGEsIGludCBudW1hX25vZGUsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25z
dCBzdHJ1Y3QgYmxrX21xX29wcyAqb3BzLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgaW50IGZsYWdzLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHJlc2Vy
dmVkX3RhZ3MpDQo+PiArew0KPj4gK8KgwqDCoMKgIG1lbXNldChzZXQsIDAsIHNpemVvZigqc2V0
KSk7DQo+PiArwqDCoMKgwqAgc2V0LT5kcml2ZXJfZGF0YSA9IGRyaXZlcl9kYXRhOw0KPj4gK8Kg
wqDCoMKgIHNldC0+bnVtYV9ub2RlID0gbnVtYV9ub2RlOw0KPj4gK8KgwqDCoMKgIHNldC0+b3Bz
ID0gb3BzOw0KPj4gK8KgwqDCoMKgIHNldC0+ZmxhZ3MgPSBmbGFnczsNCj4+ICvCoMKgwqDCoCBz
ZXQtPnJlc2VydmVkX3RhZ3MgPSByZXNlcnZlZF90YWdzOw0KPj4gK8KgwqDCoMKgIHNldC0+cXVl
dWVfZGVwdGggPSBOVk1FX0FRX01RX1RBR19ERVBUSDsNCj4+ICvCoMKgwqDCoCBzZXQtPm5yX2h3
X3F1ZXVlcyA9IDE7DQo+PiArwqDCoMKgwqAgc2V0LT50aW1lb3V0ID0gTlZNRV9BRE1JTl9USU1F
T1VUOw0KPj4gK30NCj4gDQo+IE5vdCBzdXJlIHdoYXQgdGhpcyBidXlzIHVzLi4uIGhlbHBlciB0
aGF0IHRha2VzIDYgYXJndW1lbnRzIGFuZA0KPiBzZXRzIDIgZHVwbGljYXRlZCB2YWx1ZXM/DQoN
Ckl0IGp1c3QgdGhhdCBjb2RlIGlzIGR1cGxpY2F0ZWQgYWxsIG92ZXIgdGhlIHBsYWNlIGFuZCBt
b3N0IGZhYnJpY3MNCmNvbnRyb2xsZXIgdXNlIGNvbW1vbiB2YWx1ZXMgZm9yIGFkbWluIHRhZ3Nl
dCBzdWNoIGFzIHF1ZXVlIGRlcHRoLA0KbnJfaHdfcXVldWVzLCBhbmQgdGltZW91dC4NCg0KLWNr
DQoNCg==

