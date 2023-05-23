Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18034C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMcmhs/ybDpx1JPEyRaVXXiZJ2+5Df9Pv4J7V56gcAk=; b=47gp+TXKefOFc7Kk/qTw/l6hSu
	B58b1tWov3wyzIr+mybrn4IhH9t7NB3O37xb9EQ/Mx3kfesz80gr7KZdT+bmSTL5UZvGST4P+qgXC
	cn7bTOiJgRxqDo8T9xLN8RWYJbZ0rpk9W87C0PlIbY0u3k4tOq84Guoup2VR6q5mZ05KrGIMdpeJY
	f/I8esQHTTZoHbci2JZnSgQuV+hNRvZdxLyG30Z3dV3sg9s6cW4ijFMa2lfTO3lyAUmgePiJlxAL+
	fGLxV/R3JxJopZjz2vTx2ZkoEv+VWrHCKfSBHQwjM3dno9oR36d4Rs1jKSdjOY4qmN7bya8b8CLjy
	Obqn37FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1NRn-009RtI-16;
	Tue, 23 May 2023 08:32:47 +0000
Received: from mail-mw2nam12on2062f.outbound.protection.outlook.com ([2a01:111:f400:fe5a::62f] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1NRk-009RsT-2S
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 08:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5Zkiw3mYIlyIYO6Ho/KGeH6lIG04eCD1oT5NKXqVKzkjjaUnnLSDLcsTiI+QV/c35dgmGs6XFp2FefKmTiwoUVhc8hoHb5BMxVCTww5nn2U891IPdOnc8EasEa0Au2y+J6ABRFwTYfJA+5BermqtENwATqIbEpGMxPAAX3ZvGSSNbjp+d1Zm+BWASgD2z1nOk3tyMVrGRbu7iklgOVHEu7ncmzwpC7ssDz23/+34z3SlyiUxm0OcepcEekmKlx8XYTGyaA3Cug6mFRzdM7kUMPhDDC5HrEPa2sXElFXiCjZn/Xy68q9UVsBVTQqbDARWq9WtyXk59Bb0oEInC/ECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMcmhs/ybDpx1JPEyRaVXXiZJ2+5Df9Pv4J7V56gcAk=;
 b=KX00bn0HnZGCDKNS1JXz4SwfynCopZUHmxrzWEuHNf5f6BL1AqTEHJ2qVug+l1k4DY0FA7TBJgq5ZMlKWuPGDApqBPCcGhNUZCy8jecLVUIf0bLiD633CZZuBpbmZ99xHWUq+r2FF5eRbTpDBdxjdol+hHOHiB5FD7htIoLivTivlbhwplie/MM8pRACieG5Eve9m1sqsNInfGJLVNGVKXK0ythMjSrUt/oDrE7QpoZMIV3lH/weXcUmL8z81o8SFZhpaRsOpz31WOByj6h2prQUqr2gTaBVyE4cK25ni2xvBS1hpH9RWN+o1zXjnFB4hBI6/Cmtqtn2cyU9R/sTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMcmhs/ybDpx1JPEyRaVXXiZJ2+5Df9Pv4J7V56gcAk=;
 b=oImrh3UMGU+eFVAGyzRzwX6blOt6jhtz7ddpDRtCf0FbTz+wb0akw4RUrG+5W+66nSTJGzTu8Ayz6YgrSxcJcOOKE/DJ+YQbzcRVmIBQRV5J+VYwGfa5Txnn6anajdfYhXDid57DheMzAOKN85svOf4b0CzROmrjRZIW00uiHFjZkqlQJNXMCaZoLwf3U9VnnZ9I6fBaO4LkKJ8EP25WWAqFPFZhqQTn5puJ/peOblzvt6TH2u7rt2RTETZeTp4PbSJNhq6ATC83Z1Es4faiVG6UybZcLLmgba9OzOjrr/ZajdjhLnxWyu/tkOSF6HriagIXSUAki5n6HKxwlDphzQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Tue, 23 May
 2023 08:32:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:32:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hare@suse.de" <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: init auth ctrl early
Thread-Topic: [PATCH] nvme-core: init auth ctrl early
Thread-Index: AQHZjIz/5fAatsHSlUaoU8b/LDn1yq9nbr6AgAAaawA=
Date: Tue, 23 May 2023 08:32:38 +0000
Message-ID: <a16f3d8e-0c19-06bf-933c-e4752217ccb8@nvidia.com>
References: <20230522090813.135540-1-kch@nvidia.com>
 <20230523065805.GA8411@lst.de>
In-Reply-To: <20230523065805.GA8411@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7856:EE_
x-ms-office365-filtering-correlation-id: 0660e564-af6c-45bb-bda3-08db5b68441f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmObBWeQckcu6ZsezPJ/fBaqOuStq7Cs8SbS82sS6kWaxmamoOEtE3Zp02nuNHX0/6C2SIPYjr09m/H4Ly15TuBAvO666xubXnmw4Muw5iNJXeykK86kOKV0+C8GvoQXA+YWLrHQR5v1OxjghNqNKFIlSGU1wjmihoowUwp4KfcvQ+c+0pGzq5xL6b5NubPnF7BApDCjCgQQ8Pnuc7XUOziNeEDdlkNMmZ4cZUM1/xF1zptwCUzoWjo4jhaMdJDlgyKEuxNBjS5RBh1wCpfLXcKwWGSeuR2n/KTVIE6uG5KB9NjA0K6Hs5F/g4cvMBuGuNyKUUXL3/FuCuZhU5krX185uXx3FpQmD7nEbKG2l/GEGTSJvgV2pUsulnvbBvVijgTu3buu0hTcVJafV2QFQfiMblWM05V68riEPT2ozad/CRrpKFR5MmeI5yujwVVY5IV1DMhlF0tJnIsaGba+f47de4fltJ6heF/j6qnSy2NquT2Dh78FApFDcp1beyT9Yihg1h0iCWSmcT8AvU2+EIKCTAqQCN0CfecmMrA1t9E1f03PynYdvgjcr6Wfk0JG4YH1DaCedoVHLgiofEZHUl+b285VDpzY+hYBXZqdxunZLQxQq8j1gKoJO9ZtD+YRDkkOwPIMGY7jnzLclTIMXLNQlPoak9j4DAt/e/5LShgT0zxHUCPxdUrWjN+kvoDw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(53546011)(6512007)(8676002)(8936002)(66899021)(83380400001)(38100700002)(86362001)(31696002)(38070700005)(122000001)(36756003)(6506007)(2616005)(4744005)(2906002)(41300700001)(71200400001)(76116006)(66556008)(66476007)(66946007)(91956017)(66446008)(64756008)(31686004)(316002)(4326008)(6486002)(110136005)(5660300002)(54906003)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDVKcWIxdGE1Wm5ZK00zUzgyaUwxaVNzaE8yaXhYdXpqRTlBNEtvUjdQd2Za?=
 =?utf-8?B?T3hzRHVPWHJlNWU4VitJY3hIcHlCWU1PVXhOMElhSTVtUGRRY1pCL2FjZXlQ?=
 =?utf-8?B?R25KdStya0w3RnlhTnZrWUpiaGhLSkdLa1dsTDdtV0pUU0hJWGJxQmlQbUc1?=
 =?utf-8?B?VC9rb1Y1UmRORlBOeFVzaENEZ3dabVBUOEI0aGNWcUxwazlGc24wTGpjVlpJ?=
 =?utf-8?B?aXZEalNOa2phVzR4c0hScVVhN05qNXl1WUFpaEhCcnFZMWdUVmM3L2xxOWJr?=
 =?utf-8?B?S3JJMCtwZXJRZGFhQncwbTR6a0kvbG9OR3IwWE5ENURyQjdXQTB3OERNdmc2?=
 =?utf-8?B?c3pMNmo2WmJ3MEtMN1lsdnIyRWNMNitmZldUbEFOOUMzTkRvWGdFSmNWamJw?=
 =?utf-8?B?bGRPYjRwNDc3Uy9zK0txNTlXWWdNS2U2K01Va2RFbXEwKytVQlVJRHZPNEh2?=
 =?utf-8?B?RU5qM2RBeE1WV21qeDVEQzkyaUdPNlVRUFRWRDFqWEZpZ2VqUmc5ZkdzWDQ5?=
 =?utf-8?B?RTQvUFY2azlFY3dtUzUwVlpCMnZnQ0R4SXpUYUlMVXE4VkIvaEU5Y2NhUlNV?=
 =?utf-8?B?cjN1dU1YbVptcjNITitydWNwYUNMenh0TXdGT0NpMDErTnpwT3EyT3Jjd2xF?=
 =?utf-8?B?U1ZQWXBjRFhWeEFyVUdRNGtjNHR6ODNwd2xwckR1bm5RZVRvNE9YUGUxREE1?=
 =?utf-8?B?ejZ1dE52VlloUERVUy9lZi9NaEhXSzV5cUtGVVpvdVNidVNRRy8zcTZBM0NL?=
 =?utf-8?B?cHQ2b0UzbkkxaDNHZm82NWxQR05zSENmZUpDRCt2cGVNaVN2VlFyQjVCOEov?=
 =?utf-8?B?WHllTWlHaTVkcEg2ZHlRN2FHdzF2TE0vNGtBUkgvWmRQMVZkUldpUiswajF3?=
 =?utf-8?B?T0t1MXZqbGVXY1NrUWpVT0pMNWdQMGk5VHlaNStoWFAzbzBMcHlyOVNIVEE2?=
 =?utf-8?B?ZjFOS2NBWGYzNkZkUFVqU3ZiU1dtOWtWUXplRVo5clVGTEtxOVd5Y0YxR1dQ?=
 =?utf-8?B?OUlQdmN4b0RBQ3NNeGhmMElXN3MyblV4TU13bjB1VzVPOXJSSTB0Z2trbW15?=
 =?utf-8?B?Y2tPRWZQY2poa0taNm9XYWp4TCtxVDZ1NVZTbE9wdHA0V253Nm9NZ3IwVXJP?=
 =?utf-8?B?SDBIeXNPRTBOdnRNdlMvbDRRc2JxeTIwUzZLZFJxMnZNMzAxUTFOWDlDc21W?=
 =?utf-8?B?UnlheHFGRElhTjdnOUpPTVJXeWNZZGMxa2Q3S3FDeFg2dDJNeXZnSEVueE1p?=
 =?utf-8?B?ZitWYllONHZxYXZGT1JTR0dWbWVScXQ4QWVjODlWWU9MTkNzRmxLOGFBc0ty?=
 =?utf-8?B?TkJxM1hXNGFjYUlSV2U3TWp0cTcxRDZ0M0trSTIxLzRnd0NxRjdzNmpIQUYy?=
 =?utf-8?B?UEJsOUNoYjEyMEJPU3NOMk45QUFpY3l0RG5KNWhtNU1tUTJKTUZTSkYxTWRy?=
 =?utf-8?B?SG9vWEYwbzFDRmJJS0RiUlZDVUNUWDlScXF4ZHlnUjNLWjVTZ1NOeUFkZXdk?=
 =?utf-8?B?YWI4UngyMFNzNyttTmN0dnlWK2lBRWhtSzFYUk9jV2tDVHF2bFY2TllwWm9q?=
 =?utf-8?B?eFFGZ2NLUFpzR29TR2dHdmFmZVdNdmtVd0hvaklqa1lvQ1lHd2lkSzJvRUpz?=
 =?utf-8?B?cjhVcFAyRTJKYWcvQlBEUHFKK1RLOG16NDNHUlFySXJjNHpOUmxDanVPQUFD?=
 =?utf-8?B?U0hMaXBKbnl3dHI5bjdGTjdiNVdIZnpxYmJxUzAxZFRzKzU2ZDFEeEVNM0V6?=
 =?utf-8?B?cTFoRy9FcnRleTdlNFg2SXRvTk14Z3M1eUdXQUVYSGorWUYraDNWRjRHYUs5?=
 =?utf-8?B?V2pMQlBITVppbVRGMERRckY3eW1MTWE3aWRWbDN4NkMxUmRwOWVuV3EzWUpz?=
 =?utf-8?B?SHdVbkV5KzJMVCtYeGtPR1JxU2NuM2dKM0ZvYzdpVk0wUjMrdmowOEdxc1BI?=
 =?utf-8?B?Q2tKdWNrK3MrcU44OGNnOGM1ZW9ob050ZUhEQm52a0dlMXBhWi9uY3d3cjZI?=
 =?utf-8?B?enZCTjBBd3NSWXdsL0F2NmNhK3NYdjk3d2llbUFscjRDcUNwOUhuRGV2QmR5?=
 =?utf-8?B?d2hadDM2SXdGc3RrTG5QWVNQeFBNNElIVDJkM0cvNXlsenAybmZRa0RBL3Aw?=
 =?utf-8?B?bkFsU3FpbkxpVGhZeTB6bS9EeVVDMDVCM2UwU2lnanF3ZzRhMU43eHpEZlFi?=
 =?utf-8?Q?/lJ3MYC9Za8T6f9Zj2BXW3RRuDbBgEdON/dqklc8ugzi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15322D609E22E04BB0A253B26713FE36@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0660e564-af6c-45bb-bda3-08db5b68441f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 08:32:38.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YM9qY3VxaN5a/IyAfpeY6J5KnOJRd34uJsilqUNddK24chWgQAHXsAW38oqsubkUyTczC3qO9NjpiFA2l78SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_013244_806295_F78E1EB5 
X-CRM114-Status: GOOD (  11.70  )
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

T24gNS8yMi8yMDIzIDExOjU4IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9u
LCBNYXkgMjIsIDIwMjMgYXQgMDI6MDg6MTNBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdy
b3RlOg0KPj4gSWRlYWxseSwgd2Ugc2hvdWxkIGF2b2lkIGFkZGluZyBhbnl0aGluZyBhZnRlciBk
ZXZpY2UncyBhZGRpdGlvbiB0byB0aGUNCj4+IHRoZSBzeXN0ZW0gdGhhdCBjb3VsZCByZXN1bHQg
aW4gZmFpbHVyZSwgc2luY2UgY3VycmVudCBwb3NpdGlvbiBvZiB0aGUNCj4+IG52bWVfYXV0aF9p
bml0X2N0cmwoKSBhZGRzIG1vcmUgY29kZSBpbiB0aGUgZXJyb3IgdW53aW5kIHBhdGggdGhhdCBj
YW4NCj4+IGxlYWQgdG8gcG90ZW50aWFsIGJ1Z3Mgd2hpY2ggY2FuIGJlIGF2b2lkZWQuDQo+IA0K
PiBZZXAuICBDYW4geW91IG9yIHNvbWUganVzdCB3YWRlIHRocm91Z2ggdGhlIG90aGVyIGNhbGxz
IGFzIHdlbGw/DQoNCmFkZCBvdGhlciBwYXRjaGVzIG9uIHRoZSB0b3Agb2YgdGhpcyBpbiBWMiAu
Lg0KDQotY2sNCg0KDQo=

