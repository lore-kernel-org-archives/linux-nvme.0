Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10056C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8oJIdGu1lksWS4v+B74yaRaT+1x2I81+RJoxQ4uLYtg=; b=DF9EajqOs5ajN6ZqA4jPDxjDBy
	1ex1/vz+qeLOci62OZPPz8PWmFU3B8dQR2HmosviL2HIp8hjkoNbII87WhqtuPgEcV8Qk4ODDmK7l
	HMpMOOevLjIMaoqYsMgQW52/Z1SIYFhi9kgb200OyQ/7clP4YqskLCV7nClFtp8pHlmjajfUZR5Gd
	Q3l+M3klBs/idD+/3m7Rn78wWRAhOZnjyxFVfpcfyFE3cy4Jh8z1LXRhJyfylsJUsCbj4y0em7H9L
	9+PFP+lBO19coLQ3o1OYYgDGiPo5qACRm9FcYk2Uc/y0jkv4sM7OthBFaimSHOVC0xZWjubhfWGDT
	mfaYqZeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwuBd-00BsDA-DS; Mon, 13 Dec 2021 22:52:49 +0000
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com
 ([40.107.93.87] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwu52-00BqIa-81
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1O2VO7RceYK2xTr3M7xTuSpbZ5y/kM1zpdOHJXWXriG/8mU/u6fr5uMuPYawGr7dN+aNafuveymk2YnoWjBWMm8BJj5loTa6vNW7olm5vROHV5CpmTq4yxQx7tDyUk5S+4TIJPba1YavqEhIMy2AToDENiVIxdOpQ0OmdIBsTeoM7t+cDBMsnmXmS+pMTXAFDwws4Z4hJAazzjuJI9ztBur+OiygXLp7Xo3obr4M3oW6uQbZSrlRlgYqP4pvpUvF6tnG7/B6z2vNvDdRwBhYO/Xb+Zistrjx1X6A5FFBhApCtN3ELn5EnR6X6Aumw4L9sEVO7EBPjY1TBmFTrL0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oJIdGu1lksWS4v+B74yaRaT+1x2I81+RJoxQ4uLYtg=;
 b=D9Zig8siiLqdFFYtyRP6/xcA+ZJzxoegnaspc3cgS2a4+MrG6/8l3MBGjb/02qc9gXxjR6l9v4I66raw5EbbcvJYEBELqU+izyz3Kkgjn+j1zM+QAQgNudjUXSfJhBHlSmBY0dWIFzPEyvBWrpc6ZlAR6fIDIyNS3dhZg3qEnEuGleOoqJh+thiNt0HKdFGHEXyJ+7EiaO2zRsTZvjuvqQhhiYHkBL6AHAzYGsnAiSoXnQTUs+6k2vmLFFEOb66c+Eu1AFuha5ir6vzXszEneu+0o73sK/KcOXZqRyzdemYLidaQaAJ7X9rwKamYEFi+nEBvdpqdxDy3tS5zCQNtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oJIdGu1lksWS4v+B74yaRaT+1x2I81+RJoxQ4uLYtg=;
 b=JHTop3G7EFXcRGFl/U3spCmPrBkRqyHkm31xlxM6tOlQZ982RKoOeMuNcnhNmmIZ/bynhO7ulRT+0Lb99CxcCHYBFv3UWoxQWOQ4mo0ZYkh39Ctd//vRKOnsy588BCPzLiiqp987GQ7nJ2Dz2dAhYG99O7C0oA8T3mlRavdXGCiCXz5s7CR7UEBvlNuMNUTW7+21w2cyRlc/4QsSzEwtTr57prPVStkF0j1ozKnqwSOxod9Lghe5RFGeaKjp7o+78Gp81Ps8Jn1KGoONomXPVG5enDmhaiHr3GiIULH84A2mYUH3RocQebxxcoPxEc3UrF7aUYQmzK9sXVb8Jgb4Hg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:45:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:45:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 03/10] nvme/rc: clear hosts directory in _cleanup_nvmet()
Thread-Topic: [PATCH 03/10] nvme/rc: clear hosts directory in _cleanup_nvmet()
Thread-Index: AQHX4D8VuL0CdtfcC0CVrQZSjpMQbqwxJeMA
Date: Mon, 13 Dec 2021 22:45:56 +0000
Message-ID: <97dab511-e1b3-c463-9f51-3643175436eb@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-4-hare@suse.de>
In-Reply-To: <20211123074940.113390-4-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27baffa0-243c-4c51-4c2e-08d9be8a53b0
x-ms-traffictypediagnostic: MWHPR1201MB0160:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB01602C6B50937D34298CD5CEA3749@MWHPR1201MB0160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hk2Py7f2DsIW44KDpBVkmMpakNwiJ14i86d8pQh2JaVjg1nJuA3RlbFAJVXFTclVV34NW2I6Z1WbxX8qzFAc0fQ3xt0aAQQK+zfQPXzneubKHo4sGKntsik3Icj1PqQBbUR15Mu6sXrg4ywPW2Vie5cfA7q58u4fC9Ml/IQOMzrXGIgac1g8u6luz8WJA5m8xf1COiVA1F1LxFuf/rfKHPwxSYzhkC/ufCU0oMWyv+4GJ+RG/SO6CzfHcDCCZNVc4uE8H+nSLGO+hd6qtsALek81tf7AbnKYqBIP7JMvtzwVowoYMkaCMnssLryX38+AasLdJeauGNJxlOxWE9QH3k+Q9U38LsXX23SXSEHG+2i1Bzrd4R25RMM448oAgz3ZMv+MNjfbnepXkvhXT6/omNsD+becA2+uaxJC7fK/alnF984rV3qw+5UlhNmDa5UL4HKv3gpWUpVlEXPav/4k6kDLPF2LGoxRpY+mj3dPkidqiTPHxXiJS6eETYWZSC/qiyapI83JUIK8cbyAdTuEQvJx3PFv+XecCKoVQEm5L0R6gUKGgP+NoPr6sxY9RAhnO9p0qcQ6Yv1wtNfzpWNREBHeeIgd/zlJJONbCsMlseRBd7oJlIgrNMPwu0w/kwvzxnGSIwEDE+8SDIbNEKD6R/PwKPmqw6MPOiDYgKMSl0xP1PIhEqpPR8pdwPV0Gy6AD4HcnuHGLEvx+4trlEH027xzR/fFCD7RbRlRjarKoSPpOjDeX3D+4d5meP4kIgtOMmD8GiZ6obY7tDaWoIy6Gg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(110136005)(2616005)(4326008)(6486002)(31696002)(6512007)(186003)(8936002)(316002)(508600001)(54906003)(5660300002)(66476007)(122000001)(6506007)(2906002)(86362001)(53546011)(66556008)(8676002)(38070700005)(66946007)(76116006)(71200400001)(558084003)(91956017)(31686004)(36756003)(64756008)(66446008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z09aREdJY2QyMnJyMEFTUUR5VzdDSjRYQnZIL1Yzem5lNXdtRWpSV082QUxD?=
 =?utf-8?B?Wi9zT3VoblF2OUFvdEs4endONTEzV1lFTGtsM3AzeTU2UVErSDhScU5UamtN?=
 =?utf-8?B?cVhLaUR1TmdSanBhMTdTajNkcDQvVGZBWHB5dUczRXgxbzdFTlg5VHVyaG54?=
 =?utf-8?B?bzZKTS9tNkpCVVZUclhXR3IzeUFyVE8rVWlOcG9OcUJtbndRZUFUWGFxNFN0?=
 =?utf-8?B?S0pjUWFQQTR0UVpDVEg2ek5vZHh2S0VLb29ZN29VaDZ6NFhvMFR2OTNad0tj?=
 =?utf-8?B?d2xUZ2VIQm5Eam1pMm5ZZFhpSnU5Vkg4OVZtc0JybWZiKzhxOUxna2FlQWgy?=
 =?utf-8?B?TjUwWkRDVTRqc0Q1dnRwTWhWMENSaXRNNDJnQmpXZU96YXlVZEk2ajZadDE4?=
 =?utf-8?B?c2xLckEwcFZpVkpOaXNHdm90eHlvMUdvOS9nUzhjZDkyalhEb3NoMXFXbk5h?=
 =?utf-8?B?aE5ZN2lIVmhVeGJTdER4TnB2bDVKRndwU0h1dG1lVlRyRjY3QVM1OTZDdnZY?=
 =?utf-8?B?emxKT3k4d3U5Y1NDNHJSMlVwYzlCSVpUR3VabWdSNmR5VXJxZ2hyVmZncXhC?=
 =?utf-8?B?aWg4Nkc1TUg2b2NzZHlzVGl2VlBNWllpcjRudUhHQndpNkdHdHI3VFhFb1pZ?=
 =?utf-8?B?dE4wZnpHOXk4emFVOFFlM0Fhd2VmVlJ5OUtacUhSRmNUVmVwM0oxRTlGSXBh?=
 =?utf-8?B?emdFc3ArRHpMaHg3L2k2WWpPSURZUkprQlZ6WWVjbHNFeStFVkxmUytlTzdj?=
 =?utf-8?B?TmZaOStJZVNuMVRjZEVZOHpHNFZHL2s2RWEzRmM5UlRlVzdmcTJHQk96N3FP?=
 =?utf-8?B?dnZJbmtVTERjbjJsU1ZoNXhNOWM3NXJ1NHd6OU16MHpHREFmOGQ0cUwwSjFv?=
 =?utf-8?B?cERVVHBMbGUwUFNBZTFkdHRnanVQdjRFdU5EN3QxMlF6M1ZlUDlnNWdlVVQx?=
 =?utf-8?B?TFJyZXFHUTNOU1pQU0VXak80SjZ1T2lYdkF5MVA1N3ZLYXAxZ3VhWThLdGw0?=
 =?utf-8?B?MzlOUndjZjlzRWtXUnVqQk5WaGhPUHF5NzZJWk51NXhFUGw0cFc1Q3ZaUTFS?=
 =?utf-8?B?WnJ1NHpES0psQzVNM3FBaU9uNE51WVVvdEZLaTArSG55N1RieDY4Ty8zck5a?=
 =?utf-8?B?M2NnMUtIS3VwRW5kdkZRdi80a05UZEFLQzM4Lzd4MFRvWnRXdE84YUVicjRM?=
 =?utf-8?B?U1E4S3ZZQkZRRVZOYmtNbGRFaVBwMm94REZ2M3puUGN2RVFyOVVpcDlYeEpi?=
 =?utf-8?B?K1dhZjcrUHY4TEVFVFQ3L0wyZEMwbGpRUFJ4NDJhanY5cGhHMytZZmZhL1dV?=
 =?utf-8?B?c1RETVRxb2c4S0JJYjZ3Y05NY2dFL0o2T1RyVWJ3RlRBRkFCL1h2VkxGb1VU?=
 =?utf-8?B?YlU0czZXcGdGdGFkeHk4bWEzdnRhVUZ0cnpUaUtIdUg0N0tjK2RhWVpVQXFi?=
 =?utf-8?B?MTMvRC9zLzV6aENFVUFHaFhlWm8reFRxOEFZZVh2UE1QeHcrU3lNMGM0NWRV?=
 =?utf-8?B?UTBsbU9CdUwzNE94M2xVdHZGSDNhNitNOWtUWTd0ZEp4dUlEanV1MC9rQmgw?=
 =?utf-8?B?V2xuakwyQVhrdXlQd3hGaWdXcTFTaTczcXU0QzlnMVhSYU5DU2hBUFIxSVVV?=
 =?utf-8?B?REh3VHFsRDJYVGsrWGswN0xFZm5Wa3pwQ1lNU2FJbzB5OG9ubHpETzhTdFFl?=
 =?utf-8?B?dVVxY3JCSkdnZkk3OTk2TnR0dmdhKzFkam5lNnRuS2piSnhpZjRzd1hMaTh0?=
 =?utf-8?B?T0dEL1V6bXdDZngrMzVXR1pwaGJwSjgvSEI5b2EralZOYTFUN0lGYWNRUlBB?=
 =?utf-8?B?ZnF3Q2VBd3cyTjhERElUN1daZnlhaEl2c1FMOEtieEFxMkJPanJRQkY0VHJh?=
 =?utf-8?B?QXNXU29ZRU9VazRDeWx1YWxnYmtRVUhFc09sT3BuQXFDQlVLSGJtaWZhM2Qr?=
 =?utf-8?B?SjNYRHY2aDJrZlVvYkhtTXMyeFJJbUJVUWZyYjNYM1ZVblV5Z1R4VGpDTjhx?=
 =?utf-8?B?eXU3NC9KUi9FSTJwRG5SZGVXUmhZMFhqQ1gzd0QrRW0yMVlTTVVmSko2b2dN?=
 =?utf-8?B?U0VrYTE4TGlVQWdLMnFNcDM1U1Fwc2wzSUFiZEJLTDhFNkhVVlFyWFNoOGRm?=
 =?utf-8?B?c3B0TllhVzhTZ01KY0RkU1lqN1p6cDRsMGlYMUdxYW1GYTR4dGdtVzNiNWdq?=
 =?utf-8?Q?zcqVVLEBwsrSR8Tp4tAtzJuESUoummrrF4hKmZDkFFAt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E7BD2DBFC75E247BD79728BD66BFE96@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27baffa0-243c-4c51-4c2e-08d9be8a53b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:45:56.6843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcWZO9lyCECepAHouTEmXo4Ut9wncnN3B56mgWnyxSVotj7mNaOktX4+j8pNYwtxOgIMGDfSjI+43Ejt0OWJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_144600_329641_5D46C026 
X-CRM114-Status: UNSURE (   9.31  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gRnJvbTogSGFu
bmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuY29tPg0KPiANCj4gV2hlbiBjbGVhcmluZyBvdXQgdGhl
IGNvbmZpZ3VyYXRpb24gd2UgbmVlZCB0byBjbGVhciB0aGUgJ2hvc3RzJw0KPiBkaXJlY3Rvcnks
IHRvbywgYXMgc2NyaXB0cyBtaWdodCBoYXZlIGFkZGVkIGhvc3QgY29uZmlndXJhdGlvbnMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0t
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQoNCg==

