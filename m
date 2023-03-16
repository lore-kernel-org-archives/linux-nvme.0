Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A236C6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLTPpu/lx6h5pnUoqdOu7eInnUtXkXCTyPd0QQRUEDE=; b=N/w+8VCsoLZEHvM074sf+/tW9t
	dV6hZFriIXIb6pFT0cxwbECA9A5ZtkPvc2N8yp3412YWcxJeKKljupYSCO/yy8QQNuPrYUW2wBpFP
	g5gK56NspBWEamZ0N/jimVca8F5yUW8EnKK+33mkjsJN+BDWstUy9R5eT42CosbfuasLWD5TthtPR
	bgWpRkGSTMxJO1w+kWXbi/WtDsMj7UpQH0yqZ2gZoDe5ovOdSJthx8PTmG/uAXiXgSB3jnN3HxThS
	Yd52NtElDzsoHwIQ1J5avccxKhrJsbfpFlShlegEyP2ywF6Y+xKYi+jEdXrXEtYRYgTrneNtOUEW0
	l/1GZ01w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pchp9-00FRy3-1c;
	Thu, 16 Mar 2023 07:14:55 +0000
Received: from mail-sn1nam02on20604.outbound.protection.outlook.com ([2a01:111:f400:7ea9::604] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pchp7-00FRvk-2X
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 07:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYIoGRLjykflbI5BolWQ+wS5BEAbT3csMmR9z9KLl2ebYz5hymLTm5aqWtbc3aqjdPuvL0iP6ihJGVlQFrCrd/8LjCXS2sy/DrKf8i8H8FzCZXnIXSHGSsmbdsjLUg3Ed0sUbDFF8oPtg8blwPFl/PUg79pMlYwgoKRZmaXH3/yLzxhiv9ooTpm0/30SpLmSh+MigLHAAjltiVfFBAoc4eoOi4irIp3r8dFiVqinSR0uIbfnNGa/BnYeFAyzAaeZDadQWpWdF3jJjhvWk8f3LVLBidH+TCfwV84PLHwGG7iy8TMBVuO4m+zZeZQf9zi0a5dymUD3+LJjzTyzKPDswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLTPpu/lx6h5pnUoqdOu7eInnUtXkXCTyPd0QQRUEDE=;
 b=iou0ArytxX0o2GoxJtECWO1jLIqvyarTmWewu2xy+N97tUx/GOsBz0l0Uez/eK5GIoqyN7wxV24rND75ljlzF7NKoHpfb9jiRi60mE+5LodaX1Bwv2yWeKqPYe5oe3T31SgY/4y9xS9lW8zmMBi3LYBtcAJvl8uZqrsKShZvlaUwUUHucP34vy4UmUrmFVDYdzr7ZOByyV/WNe/n5WCjpba1jlHNLGICNu5u8nGnkixg7Y63oLK4zoZDlb9EHjV8C1HB0poZP1F/mwzMuaeqZqfX8K0BqBInybnzXiF5YiGYB8LyEV81sD1no6keyxIM01NMJ9Fwdn/I/dF7W2CLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLTPpu/lx6h5pnUoqdOu7eInnUtXkXCTyPd0QQRUEDE=;
 b=AJ8DQ4FU6fRQ2TwGZsvg51vErxcYzYEFc/29hlKYlTbE2RSVMeSQZCX0pHI2ja2zT5Kmil35Cd5z7NML85ER4M5b0LknCGsWql/MyvYW9saNthnc/P40tRKKaqqm1UeKnqrPutEK9JCjV+cx6Koh3743IelrA6+pcyOgbsa3l82lRB3P9rVyRTpm3RxKJQMbEjCeQVAFy+Q5vsQ5yTV6l2NFgRa00JC+lsm8X3HqDoztfV8L5etH+WU/nKj2pN8JBN2YwV7SMYpFuSM29nddUx7eaca+x+L0daloAaeK17cjQXnkuwrqo2/5UvqBkydvLoAic9NChS/MxlziWbpRCQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:14:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 07:14:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: more nvmet Identify fixups
Thread-Topic: more nvmet Identify fixups
Thread-Index: AQHZV0lRyuE1Da8B/kib45QV6DqYZq78cxCAgACMWIA=
Date: Thu, 16 Mar 2023 07:14:48 +0000
Message-ID: <5042ab75-3ef9-fd3a-25dd-38b240075467@nvidia.com>
References: <20230315142032.507083-1-hch@lst.de>
 <0fe36f74-b9d0-4b68-1cf6-4d436b15df3a@nvidia.com>
In-Reply-To: <0fe36f74-b9d0-4b68-1cf6-4d436b15df3a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB9025:EE_
x-ms-office365-filtering-correlation-id: 39132c86-14df-488f-5c8c-08db25ee2088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  VLV1ZdJbIcLZMSsh5ehtagQlr19Rg/7hrsljsKQ0sEx+t1OjduGayJyk9S4Dsv0o41TRov1xWGbOg72+vDfbR5xDnXquByUV1fT6HmV05Nm0uKolEdr/0ZevgeVdJUF4ry1KCON4LStZkCQ9a/OSx88ER4f2StXBAJwC8+UPVovfggfQzudJZ4/P7aap8rHcKNwLh7ptfrDnyOZd5Ohh4xpyuj8sKb4MbuDjIjPotxGkFgTm/iZM8kQK+Gn0IFhTEU5WYt9P2T6jTRPyvipeyEk/Fr+TdNceXD4KgckJGZPXuFF1I4yWI0bPGM+zxkiSxdLCbFT0ZBzzO76HgXvNXhQPS+PxQrcnRbenmAu4oH4woEPaRIGAIweq2q19gVwxECZJzrPgoOgjMTAjWbS61DHjTznE14Tb4S3fEjyVWIgsnNu9VVY9NuAb/WfUKJAgQwjHdtbA2BAiqchHECZtXQwPdBnS2DLQ9a11rW0pvwbxuCOSpA2tVG6mTaLmidXuJMPVPpnFhjC2aqsEjFzLOXVl5JUh66Qm6SbWQAE8Y2D5UeCkb6fFwwYXLu9d7OHakhCTE7M4UAr/98wGAbKFnSICQ1aCf5+IWkro91GiN0NBmvjdRcjo6HVvXDym00gxGOjeTm2NpolRbT+1ya2lBuIQsPZtmgd9GHXijR8VIjTcKmC5CU8NLcwpz0KAjI9e0xiicLxCglvUz5g41oOoZi370fIPOCuWs9HfaKABKINRmOkB18xVL4wMna9UOKvzBNlzlB8Oc6++fKN8hhpVWw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(83380400001)(3480700007)(31686004)(38070700005)(6486002)(36756003)(31696002)(86362001)(122000001)(53546011)(6512007)(6506007)(186003)(38100700002)(2616005)(91956017)(66476007)(478600001)(71200400001)(316002)(54906003)(76116006)(66556008)(66446008)(64756008)(66946007)(4326008)(8676002)(6916009)(2906002)(41300700001)(8936002)(4744005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YTN3QjhXTDh3MzVZQ2RJVmQ0ZzN0dDZBcUJHcVE2K2JYaEIxcStnTUpBbWZQ?=
 =?utf-8?B?bnBzMEc0cWt1TXNIeFFqei83U3N6L0M1NDhNM0dCVVVtQnRWbjVxbldJeHYy?=
 =?utf-8?B?Wkt3VWZIeHVlWnVUdGZsdFdPZzdYWjlqRWNYUWxIdS8rUkVFL3FCZ1dJZU03?=
 =?utf-8?B?VS82dEV4d2IxQnBVbGQ0dnB4cWo1ZWNXR202R3V3TTkwc0NYTzdxR0NVUmdy?=
 =?utf-8?B?MURWTEJ2ODJSeWZvVDZnZitEUUF3YXpDUWdTNzBZUXF2Sjh0bzVqR2tpallv?=
 =?utf-8?B?M01PYURjd0R6WHNJL3BSV21rakFHdm1NKzJ4Rmd6amxuVkFIUzFJMHZ4M0Nj?=
 =?utf-8?B?NHNjYlAvTHp1ZkxoVEJOREJPVmtZM0Z4VFdQcXlHNlQzSHhycWg2aXVFeUdP?=
 =?utf-8?B?ZlZYaURneTBxanJSY1NURm8wQkhYaHVFZ3U1L2tUQzJFQ1QxR1VtcnY3T1Bo?=
 =?utf-8?B?U2FxZkN0R1JhcEtGVVdlM2dQVlRFMUpqbk8vbHY2YlNjaWxvNHhOS2lyS05F?=
 =?utf-8?B?MHdVNDQ3bmZnYW5taVRkSkZRTzlBWmpyQzVUZUhFY0hMZlZJWWtMRXlod20z?=
 =?utf-8?B?RU5Lbys3OWF2aWQ5Vis4R01kM3NoN3d6ZXFtSVFLSFdDem9aeU9sSUdmVXlo?=
 =?utf-8?B?VDE1c3pueWFNNlIwM2FNakpMT0FlWUNLWExvR3FmQlU1ank3UnNSOXBSZFFp?=
 =?utf-8?B?THNXaU02UmhvREoxUjE1SEt6bTNVOUZUdkptcFJHQlpDbGtUbjFwd1RHTllq?=
 =?utf-8?B?VHVCUWI5VFVIRENDMG5xMFBpZlBmWnhVcnVHajc0YTE1WERGTzIwRWhZaGh1?=
 =?utf-8?B?alF4eXJwMGxacFlNVEZwSkMydzBROFRiZGVEQTErRCtXditHODR1aWFseDQy?=
 =?utf-8?B?cngvYTJpZXh3ak9iWDJhdVUySVlYS1c2OGpVTFN2SU9adWRTbFoxVDBsQk9J?=
 =?utf-8?B?c085WEI4VTNuUnYyWjFKMXFiZHowTDVnZTlGV3dUQXFSeWhqUWFveVVhTWh0?=
 =?utf-8?B?ZnA4NkF1RDV6bzRJbGNpaUVta09DdmJZQ2oxV3RIRDFZYk1WTG9JMjE3SE9D?=
 =?utf-8?B?RnQrOGtMTityc1VFVG9yUHFOd1JQRTZoaVVSMjRBSFVYNEtGaGplL1BoeUtZ?=
 =?utf-8?B?L1FDZ1BLVTFFbnp5eTF3R2pISDJtbUtxNkt6eno0WlJja0RkdlFiRzZnVm9h?=
 =?utf-8?B?L2VuMnE0WitoN3RkdHNOV2hxaTh2S09XQ0VCQzdTdy9iVVQ4VGVldlc2b2hD?=
 =?utf-8?B?OFJMa2hDejMrNU13SWxnNEJYSDQrMXBnSUttaHhXNjFBekVIS0grc0srazJY?=
 =?utf-8?B?OXc2RHQ3QWkvWUNlWjlWSFBUdHI5TC9rczFHNGtXWTRmZVRUeitrdnAxMmFZ?=
 =?utf-8?B?UkNDL0RQZGxMU2NVNXVDYkhKczRKd0FEOVJGOC9GKzVEdk0rZ1p1MG1YOWhZ?=
 =?utf-8?B?SXFJdy9SdVB1TmJabFlaSEEvMFNYYzZqMVVTeUpRNC9YTXNjWDF4VXZqT2Uw?=
 =?utf-8?B?VXk1aGcyZjFQQ2l2NUZqbldXL0JqVFF6M2xqNGh6ei9CQkF5SC9Sa3BIWExW?=
 =?utf-8?B?TXFmcDVBME9ZN1Rra2pQTng5UGdUbThwcWN0RzhsR29uMUdzT0UrcythSFNC?=
 =?utf-8?B?V0ZPbWsyajR6WGJ6NmtXTVBHV3lRa3RLQ3BReWxCd0NVMU1SbXRzclJmQUd3?=
 =?utf-8?B?dTF1cFcvUDc0bll6ZmlCdFBOa1RGS3NOaXVJTU9FTE90eW5ld3piV1dNK0Jl?=
 =?utf-8?B?Rk5raFVnTnU0ODV2NEpBakZubXFkNkIydEkwWWtPTUlpdkIvc05ZRkdSZW9K?=
 =?utf-8?B?VEE2TloyN1BBSWpqUmdKNUF0OFd4b0JlSzBHMXU5SU4vTUJ1cGQ3NUxNYzFa?=
 =?utf-8?B?dUt1OFovdFBtKzNZSE4vaGlGSVdoeVRuWXRPb0ZTellJQXBsRGw3TlNFeTgy?=
 =?utf-8?B?eGZQVEFwUGpCN0xlWmJ6UHpWdEJyRkVCZ1I5SGx2MlpFbjRNa0hKNzQ4OWox?=
 =?utf-8?B?MDNhbDJsZm1ncERja2JXVTdvZmMwTkhsbFBCSWx1d0JCLzM1YmVicEVKd2ph?=
 =?utf-8?B?NGorWUpZQTFwQXVqUE1MTFFpTHZOYnJjakxBL2hvTVpCTkxzMEFJTnBjdlcv?=
 =?utf-8?B?NnUxT0xJc01NQWdJdzNmYmd1dXU5ZExBYm54QjRaQ0c4TmRPMXRPM3BnbzFk?=
 =?utf-8?Q?BoV0wW8A1diA3pPGCluej41gSwWgwtSxdR8PbgYg6cfb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7B0A4CE6F72F49AA779CA9EEFD34E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39132c86-14df-488f-5c8c-08db25ee2088
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:14:48.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +95AppO/3QI25C+9Fth4xlJuj1CPC1SA4cRheDBk10e0I+/2UPBcvKhRoGMAYbS/0N1zehw56iAspDLIhgAPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_001453_825109_61530C06 
X-CRM114-Status: GOOD (  13.13  )
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

T24gMy8xNS8yMyAxNTo1MiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAzLzE1LzIz
IDA3OjIwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IEhpIGFsbCwNCj4+DQo+PiBoZXJl
IGlzIHR3byBtb3JlIHBhdGNoZXMgb24gdG9wIG9mIHRoZSB3b3JrIGZyb20gRGFtaWVuIHRoYXQg
SSd2ZQ0KPj4gYXBwbGllZCB0byBudm1lLTYuNC4NCj4gTG9va3MgZ29vZC4NCj4NCj4gUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+DQo+IC1jaw0KPg0K
Pg0KDQpJIHRoaW5rIHlvdSBuZWVkIHRoaXMgb24gdGhlIHRvcCBvZiB0aGlzLA0KSSBiZWxpZXZl
IGl0IHdpbGwgcmVzdWx0IGluIGVycm9yLCBwbGVhc2UgY2hlY2s6LQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYyANCmIvZHJpdmVycy9udm1lL3RhcmdldC9h
ZG1pbi1jbWQuYw0KaW5kZXggNGVlMzBhNGRhNTA5Li5hZmRmNjlmOTI1OTkgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQorKysgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L2FkbWluLWNtZC5jDQpAQCAtNjkyLDcgKzY5Miw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4
ZWN1dGVfaWRlbnRpZnkoc3RydWN0IG52bWV0X3JlcSANCipyZXEpDQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCiDCoMKgwqDCoMKgwqDCoCBjYXNlIE5WTUVfSURfQ05T
X05TX0RFU0NfTElTVDoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfZXhl
Y3V0ZV9pZGVudGlmeV9kZXNjbGlzdChyZXEpOw0KLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnJlYWs7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQogwqDCoMKg
wqDCoMKgwqAgY2FzZSBOVk1FX0lEX0NOU19DU19OUzoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3dpdGNoIChyZXEtPmNtZC0+aWRlbnRpZnkuY3NpKSB7DQogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgTlZNRV9DU0lfTlZNOg0KDQotY2sNCg0KDQo=

