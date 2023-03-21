Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C645C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 05:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kb/edF6kxIvFCrBJziNnWlni997Ek7GwG1Zpnq1Y6RQ=; b=ZlX5Ez3eTZE8Sex1D6dOVnyRJV
	nc0YPK5TtJTZDNGGYbmRKFylWXQ2m0QV8O5GioQPrbomkukMdpBrG0Gyp6u6UibAalqxSZygTZiIo
	nejl3uPUXEtYntJG1Uc5s/fTrqIsOFJIrMFmTSeZp8VDOPf4dwzc+JKXS72Uxuk3rWUTS1Zzd4Qz0
	a37P/CkGxzOQ+yKi6ZRm3N9F4XM3fz/WPlIRtLOpwR4fES9woqx1sC8loM8JYJxeuX5Z5UIJJJITL
	w8rc05d2M55bZieA3WZKpLeBMcCYXEp0HZUlvyOIJT4IzAtQSgc7sNpAPN+p1/eDR+QwCwolS//c6
	Gs8/lyzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peUJ2-00BEqd-31;
	Tue, 21 Mar 2023 05:13:09 +0000
Received: from mail-mw2nam04on20604.outbound.protection.outlook.com ([2a01:111:f400:7e8c::604] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peUIz-00BEpi-24
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 05:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRgbWjV50Gch7grmvSeK5cZm3iLmo1mF2DJTXuqXblTii3ugONAYKBY9wOyCVeian9jmOb0+s8dK+W03ajI/BX7CiB6V+n5YKmr1hxOCW2H2kVDDdz6fd+xoF2C5dZvbQCiG31HLZZ+BqnM+0Trho4gbWj7p7fXWkLY5ORlqwwQyj/+PSED1wddHz4mtYhunsf0LGYdtmGmN+3Wx6bsJXERdu+fi1kNDfKWNP+D+mCsMNH3qLdI1k8t0SGwcpq5SfY0TKtIRolPUdrjHE71QRSuQdvlG70WJiWK8eCLMMIdOpiGAS7qDz0S4kcc7g5caMN3tFOBFGu1rEUgdTEiH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb/edF6kxIvFCrBJziNnWlni997Ek7GwG1Zpnq1Y6RQ=;
 b=hc9UlAeX9bDHCzmKt4ATswuC4tHZtgytkQSmNpSZa44Y2+0eVaB8ntel5L8ndUuDU25DdBNXUpKfxvFc+2KgodmemyrEREn7yHVqQK2PBPP5azfXc6uOf3nwLobNvSNzVRDvIctt7nkfXLgswg1h3VDbVl3AbJnC8guc5GmMxGfcaNbOkDLLI9oUZ7+ZjJ2G172NG5rQwYfrfR9RptQuA5beQQk4dLyU/8xnzFBM1mtaNJMtFkxBbsPTjWxDTVHAsBYtLHxELDTzSiTAJl7wdw8SbiQhuWDtwcA/IA/kwviunM8ORLRUo4+ooavORoMLfaFW9XyCU5hIuoEoqwC5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb/edF6kxIvFCrBJziNnWlni997Ek7GwG1Zpnq1Y6RQ=;
 b=hZ2Dm21+1YhrXHxTnLr6sYuF7u9tqTMVSJ+TsTpJMngE5ovjLhUboAbno3HbQufZXfxgdycsPiXUhT5ORaLpGNtrLJelZV0HnaGxugwfFLvL94yNqQG2aPO1dFdFTKrR6ikadqCoil1+Wzzz5kfSZ2hneT3iPdLuzE/Os82Lxb0DhZVDD46lRctW07e3Pk9ks7fS5J3eHNrTnL9KfIHruSIRYf0PiBAi4ebCAkKmi+ouAAf7Q+B6PZq5Y6wRbntAc9/Z2eho/sDjEHTTIoH+8zu34xXHglMuz3WwPjUzV/mxmxfYd0LSf0j4Zr/Z6d4tuj/Fx65ZvZF1kP8+8mGF9w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:12:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:12:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, Yanjun
 Zhang <zhangyanjun@cestc.cn>
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Thread-Topic: [PATCH v3] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Thread-Index: AQHZWzCpaCjSe5dDWkOjoCGzTPmbrq8EsTeA
Date: Tue, 21 Mar 2023 05:12:57 +0000
Message-ID: <915f65a2-226c-ae20-0575-e20120e72a72@nvidia.com>
References: <20230320133334.57325-1-sagi@grimberg.me>
In-Reply-To: <20230320133334.57325-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW6PR12MB8959:EE_
x-ms-office365-filtering-correlation-id: 35ad5fa8-e351-42f1-4313-08db29caeee5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  SzCkoWYwNixxXhBzVhFBH9S64yd4tMnPaIlas/8OIMwoONMu2sk+OCTBwGDNDovKCRe98cVYWB3B8d+GVKO4PvFowVjLQGsLWIFA+NXS8AFfLeEkijJPAR6fTGotCTJDkA7fDeJuMmtPOU4AZzVTrwzNIugc9jt9K4Iy0Jcuu8SrwkHZlikpAECSB2O9o6norPObKhTw7T4hgdlJ+HsNcdKgY9SQFRGzI83S/uW6pMWnedYZCi2aLG5y9mqkLD2qnmW/umcyWeF3lFaGIr5YmtdF4ZC0Xl4oX66HYEt0rlZpQ5Q/yWYeVDal0puQdpQBf9mHb/RrQr2oDOvA1myt6NCPU0ceQtwc6dvAVJAsfv3APWC13NHmvvy67DzRLyPeEKh4iHnXV0crZ76KXmEkp7gv1TZ3dFzWHvhUzb5m5S7XWxoJIoGcePYxEp3cU6qIzJ8jscqYMXS5m37QA6uQS8JjckgRCb/4vAiz1tQTCtn8GZRuqS0qwP8eQuImSgSzY6fn2swl5o62kpdx/g96yYQ7s0fMidFJhlMy/L4Wf+f0+ETwaMlzHYlAVJnt6NR9UUpwQQuuwhN9ctIGta0TXIg/3rblo0QZpgSWNjKDgDx1NYGunrgT3tI7Arp63rJyngGnQaf5qZBDfAzP/z+VjZfxydvSFnhoL+p2sPPX8nIvX5p/K/UWoxIIbCz/sfVlJgZVltP+qCWyZPTw4p0EDKRaXPfjGpViiMzJbCszr0J+sSyXFYdrGoyJjqOg+e91+rR9nrhXL8uCZaKZ/yQo8A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199018)(4744005)(8936002)(5660300002)(41300700001)(4326008)(122000001)(31696002)(86362001)(36756003)(38070700005)(38100700002)(2906002)(83380400001)(6506007)(31686004)(6512007)(478600001)(186003)(6486002)(8676002)(71200400001)(66476007)(66446008)(66556008)(76116006)(64756008)(66946007)(6916009)(91956017)(2616005)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?R09sMTFlck5zT1JacG1ndkwzUk9iN3Y1bUZqVlFrdFZ0cklraGFIcVFrOHMy?=
 =?utf-8?B?Qi80SVJkN3dkUUx4MWVWcEdqV1owZGRUVWVlUlFYZTVtVi9MWFRWc28zdUxl?=
 =?utf-8?B?cGE0VEE2V3o4dlNmQVp6T1JlT0ExWGt2U2NXKzEwaUJMNXJ4UjJiMHRXZ2lo?=
 =?utf-8?B?VlYzN2o4TC93TnlPZmFyTVJlb0ZDTDVQK0lLQWFoTkNDdzZJcnBYMzM0WkJZ?=
 =?utf-8?B?NE9VU2dVem0wc2dybjNxTmNZaE9hQWVEOXV5SUcvdVMrMUZja3I3UkNqdXV6?=
 =?utf-8?B?dG8vUk9BVUhwanZPTms3M1dtSjI1b3NDdTlZeGt4NVNYOVl4dWdzVmNwakh6?=
 =?utf-8?B?S2Y5ZDJxSEIyd0VPKzlWeUU5Qm9CUXRQN1R1MW1qMUx4bHJPbHlxZHU2eGxq?=
 =?utf-8?B?SnlCQm5ucTJuQjFEcmtoZjM0OUpyNWJuSm9OcWNsZFdjRVFWUUNDQm4xTUFZ?=
 =?utf-8?B?MUtsSkhhVnZudWg5c3RWYjRkdUpxckNpYzNMekNRbVB6K1ZDL1RHdEJESlk3?=
 =?utf-8?B?czY0aUk4MHgrYU9mQXNPV2hvazFPQzlGSDhJdzVLUW1oUnpjT25ZR2pXSy9i?=
 =?utf-8?B?eEd5MEdHUmNlOHV1KzlxcUtDc2wvdFNFdVFibU1KNkk0M2M3WnNabmZUSUJN?=
 =?utf-8?B?Y1ppRWVtdnRwbnNrSzZ2QTFKS3FoclljU2xCK3RQM2M3YXVCNytQWGFFYTBZ?=
 =?utf-8?B?dHc2bUFLa2lKZVhFTXpaMC9NMEFMY2luazFOQlVFZGJTL0haSkoxQndMSTU2?=
 =?utf-8?B?ck9FelhqbGhSUzhZemU2cTkyb3Zqb2tmYm9SdTUzQkQ5YXFJc3lqYVJUOXlu?=
 =?utf-8?B?blRHOUgwREFjTlRZRFR2N3E4Z05qbXJEU0VTM0o2YlFxTFN2amJ3dGd3NHho?=
 =?utf-8?B?bTJTLzk1dnJCV1p2Smh1Nkcra1kwd0toNGMvUmVyajN5Wmtya0VWMEJRRG9o?=
 =?utf-8?B?Tmc5dFFRSjBMZlZ6ZmNmb0NvN2hsVXJZamZaYUhkV3lMSEJIYnlEQWw4azFU?=
 =?utf-8?B?aVR3a21uZVJFaTVKcHBVaFp6OFFxZUpneTEzRWQ1K1dWbmtwRE01R2k3eGwr?=
 =?utf-8?B?ZWFyUllUeVZDMmRvSjRvYUc1MnhTRXBWQWIvams1aXR0cW53ZGlEZUJ4Q3B5?=
 =?utf-8?B?V1lNZFEveEU1QUxWRGVvUVNGMTd5Qnk0QWJFTDVFYlErSDhEUksreVZvZk1O?=
 =?utf-8?B?VnA2Rm1BVDJJdFBhNGRiNTFUYXZrZ09xaWkvRzZPb0p3UERkWllWc2h0MXp5?=
 =?utf-8?B?K2VHZ3ZCNFFDMVZZd3ZLMDA0U004Kzg3WUFrcXZha01CYnF6UzEvUlRQOUxF?=
 =?utf-8?B?NnQvSFNOVndlSCtWdGZSTEM1UHZ6SmJnemJGelhuMW5wZWh0Y1JTM3J2U3Rz?=
 =?utf-8?B?d1ZDcDVwSC83WTVZRXhqNFBqeGhVVmhTcHVIdnNPUFVzS3VCNDNDancxSFFy?=
 =?utf-8?B?emtyWkRwWHJHQXMvUnVibkZHSHdabEN0RkhJWU1GRTVkaEorcGk3dUxJRC9B?=
 =?utf-8?B?bFE4SjJPS3YwRlFJbjVkd0lqK0VJRnNSZ2ZncEt1cXdIanJNWWZZZTFxWFpu?=
 =?utf-8?B?SjR4T3FmYzI5V25QRXV5ejlueWREZGw3UXBsU3A4SUg5VDlsaEV3Yit2TWph?=
 =?utf-8?B?Z09vT0EyYzkxV2lRcVdNV3pVSDM0Y2Q4REdVYWFNU21zRFJDclhzS2FPVVVS?=
 =?utf-8?B?b255eDkwOWRMSlZqSTBwRGNrZWhrekVvRWtPa2lGUFBDNmlrTXRKQmRzaWU5?=
 =?utf-8?B?TlI0NzkzeDhtMTdIVVZ4bVFtU0NOd2N4dDdXSFl2blR6YVZTRzRTcGQvRVFP?=
 =?utf-8?B?VERIdW9iQkJQWmFVYjNZWktrVlpIekJkZzhHMEJPUkpkYWRxcnI0cVE4dlRZ?=
 =?utf-8?B?SFhtOWZwNFRmclR0aUF2b1l3L3piczhzbEFNWXMvaXFEdWVRajJLbHdaVEtM?=
 =?utf-8?B?SWxjYVVJditiZTB4TEh3TWI2eHAwY2pnZnk3S2kxQVh0TkNEQXBnVUR1M0Zw?=
 =?utf-8?B?RURqRlUyVVJhRXUxZDJJMjJQL0xXbFRkRzhWdHhmWm8rM3JEUHJBZ0RIVnFj?=
 =?utf-8?B?eGc4U0g0L1VCN2xMUWpkTXl1Vjg3Wkh0bFRUZjloRm1WNVd4akhJc1dPQ2E0?=
 =?utf-8?B?ZWU3UGttYVhQbTJSeUovL1EyZFZvQW51V1J2c2Zmd3BlOTQrT3Q4LzdML3l4?=
 =?utf-8?Q?46EXeXEdYmcicNKpoYQJxKTzij58NIW8JpGLRl26H2wC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46319D43975E614AA154664119D2017A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ad5fa8-e351-42f1-4313-08db29caeee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 05:12:57.0567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PjyR1a8fUSgxbVOagHNRlqfUwKvXrclUQ2PayKzr9YhLvpVDCcoltEZDc6sXds9WTEgp7r6WmDQZRct2zHuIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_221305_895054_488AEA09 
X-CRM114-Status: UNSURE (   8.70  )
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

DQo+ICtzdGF0aWMgdm9pZCBudm1lX3RjcF9zZXR1cF9zb2NrX29wcyhzdHJ1Y3QgbnZtZV90Y3Bf
cXVldWUgKnF1ZXVlKQ0KPiArew0KPiArCXdyaXRlX2xvY2tfYmgoJnF1ZXVlLT5zb2NrLT5zay0+
c2tfY2FsbGJhY2tfbG9jayk7DQo+ICsJcXVldWUtPnNvY2stPnNrLT5za191c2VyX2RhdGEgPSBx
dWV1ZTsNCj4gKwlxdWV1ZS0+c3RhdGVfY2hhbmdlID0gcXVldWUtPnNvY2stPnNrLT5za19zdGF0
ZV9jaGFuZ2U7DQo+ICsJcXVldWUtPmRhdGFfcmVhZHkgPSBxdWV1ZS0+c29jay0+c2stPnNrX2Rh
dGFfcmVhZHk7DQo+ICsJcXVldWUtPndyaXRlX3NwYWNlID0gcXVldWUtPnNvY2stPnNrLT5za193
cml0ZV9zcGFjZTsNCj4gKwlxdWV1ZS0+c29jay0+c2stPnNrX2RhdGFfcmVhZHkgPSBudm1lX3Rj
cF9kYXRhX3JlYWR5Ow0KPiArCXF1ZXVlLT5zb2NrLT5zay0+c2tfc3RhdGVfY2hhbmdlID0gbnZt
ZV90Y3Bfc3RhdGVfY2hhbmdlOw0KPiArCXF1ZXVlLT5zb2NrLT5zay0+c2tfd3JpdGVfc3BhY2Ug
PSBudm1lX3RjcF93cml0ZV9zcGFjZTsNCj4gKyNpZmRlZiBDT05GSUdfTkVUX1JYX0JVU1lfUE9M
TA0KPiArCXF1ZXVlLT5zb2NrLT5zay0+c2tfbGxfdXNlYyA9IDE7DQo+ICsjZW5kaWYNCj4gKwl3
cml0ZV91bmxvY2tfYmgoJnF1ZXVlLT5zb2NrLT5zay0+c2tfY2FsbGJhY2tfbG9jayk7DQo+ICt9
DQo+ICsNCg0Kc2luY2UgaXRzIGlzIG5vdCBpbiB0aGUgZmFzdCBwYXRoLCBpcyB0aGVyZSBhIHBh
cnRpY3VsYXIgcmVhc29uIG5vdA0KdG8gdXNlIGZvbGxvd2luZyA/DQoNCmlmIChJU19FTkFCTEVE
KENPTkZJR19ORVRfUlhfQlVTWV9QT0xMKQ0KCXF1ZXVlLT5zb2NrLT5zay0+c2tfbGxfdXNlYyA9
IDE7DQoNCi1jaw0KDQoNCg==

