Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC44C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjnNHUANKDpmWsik2I8sn86X6eyaBoarVAfn1I02G38=; b=AldP6uzsqv9V1Diw95Wmi5iglH
	CJomnlPz8ltBbgid60EpB2Pm2iT43UASudpcf5HmU5K34GZLf1jG2ZeGYJMhB2RvBa/7BXShHCobq
	5cvvInau75dMjZCvGPA3EKOa7MWJr2QvTNK4iK1wquSW8hkfZOPbd95R7sYzwmfeopwG33dYcohyr
	9uu6zlTwSmqKhnDCzubiMLb6MoJlVx7bgUpRFhILGnCiYsYFZ8IE9X26ed2rpwCr50+R7J0T+YtiK
	yuB0UZ7vRQN+1mrGM+NOWq5cs8C0UGVBSlUG4rsgjDnE+B6JrGxhTMIP3pNltI+WltgRwmvUwYe1c
	PaaMrgow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oumyJ-007HwQ-Qr; Tue, 15 Nov 2022 03:50:51 +0000
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe5b::61b] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oumyH-007Hub-QZ
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXuJbbmLs1zsQPESVlx45xbW19DWvwLk6x2tn0y12aUa/JXdq13PzbFclhDvmE8ND/Bzn+riFR7P5PFf+PrqsCTaQoCd/v58CSZ738m393S35nWdAIEzI+cz2QMACKN9gjcS6Wx1Q6j8KGlhPJVek0ZofylGR4Ezn3inORf8jDN8R29GzL25qKCdsp4JNQ0vXsReNXG4QcY61Fx+SZH8EyqhXKnZE1EhtXFHNJz3Led79dcI4clniyTD+Ze812BDmTApyedWM5UYbWjcBlwqvDg9/TzpQgiPRzLFqW9cQGErdvLG3qdiMDyO5vPtXSgohfbv8yLJHdCdSFdHTIhfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjnNHUANKDpmWsik2I8sn86X6eyaBoarVAfn1I02G38=;
 b=hmbmvILHwoDF/Dr8sLG8Al8CGA35rg5dEo6EfqQvO/ay1jXAnshJyi15K5t8x6LGKHeS8BSStu4q1/WY0OxQS25tAYT7QAD1wkwLwL1z3MnUEBjgFTZp+H2Pa4O/wbSAK+y6SkdMXP1vfFrhqVO0Q6kkf4IuMpPKliuwz+SCJmT8569gkGOv18ZTjG+uVHqJNFk2ZHi7fefOcvsVJ7ttFjkfcIZUKsxbBRDsxvc0ImuZrQrUp4qct+ti9HwZMhIzd0GKHwP4A1Cur2/KPll0uQm03VsYN6gpwCw8x4hZq8RETIRQP5ZfcZp3lsjT8nO7IDALVf/lwNfQdZ1ZTT4NYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjnNHUANKDpmWsik2I8sn86X6eyaBoarVAfn1I02G38=;
 b=HYJMWhqFq3+C7Vf2RVS6vJcsi+YFoXd5Re5+NSD6pSRNaf2k00/QRblOJrtXZoHFnuXlwdwYkUWLTgiYqiFXkWZqrqUUKSofI66WT6XoOuuyaG0rYAEKIJ8J27niCp/zIouEvulmfV+WcGHUCeZveQfn4wK1spTQfn6kXYYP09l2xo4F98gnUiUDMTp+Pi1ucQ/e9eo6VcYJ6Vfia9Tx5FRZ+E4oDsgkziFnt4W3KbcgB0h+D8gBJTtHKpYdHqB0YwJ0qCii2kt3C0wtDxuhAABXx93nNOhSaRRF1d+HjdfUAL8iAjkd2cy+VKWUXizodOI1velhKDuFZuOhYuA0Lg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Tue, 15 Nov
 2022 03:50:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:50:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 01/20] nvme-auth: rename __nvme_auth_[reset|free] to
 nvme_auth[reset|free]_dhchap
Thread-Topic: [PATCH v2 01/20] nvme-auth: rename __nvme_auth_[reset|free] to
 nvme_auth[reset|free]_dhchap
Thread-Index: AQHY91Kh4Hf6jaq9Wkm0pePohCBmWq4/XDoA
Date: Tue, 15 Nov 2022 03:50:44 +0000
Message-ID: <e0ae373f-b6ed-69b4-2d99-0ffb8373a967@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-2-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6600:EE_
x-ms-office365-filtering-correlation-id: 341a561f-4d63-435c-12ac-08dac6bc92b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5cciyp2ce99ZXQkyHdLX8txPOJ4w+ctxKE3z0UBiCn2/O7baNNMdh8Tm0NKHb0sG1//iIeuiM6AoRJjnauktW14sz+3hHPdj0VY2zSyTL4865wiY2CeauaHwA27yPQ/eLEjTnDluYzlG8SJTnxsIeCAQ8lVS4JbXyxolcTXhrPQp0Vq60T3N0RDpb8+P8G93Ocki8/2kwmHzjBJVd64kmLXfDxHbMgcf+wmXV7kdu24WMDFqXSFLLGANmWk+FD0JVEnSxaogLw4Ya1N8rjzq6C0Z8HydJPNIVvvZWFTzTc6ZqxGvGyQok8Gmm2iDsV85ZUakOeoxxsHqam9uPySXqvcl40KA0u4AceoAWGmkZs+P1nZHdxBza8lhCvitmpn3iMCYBBkueKfMHoq5PFEHOjHSo6T03Txw3k8ScX1kNQexunWtyWmzId7AoE6KQpgmCNjCh0Ycl2LK+bAeGSRNeAmG0WiCfSaTY0FHQlVTYjpRLiAFkzFsjDghGC2urh4bXPywbmQIMVEKotYd8ULWnQat9wlrcijLAXZV3cwiuasOCbKUb2qCKoxaNdxzypnN1w+DmYcRzrby97URYw4Q+MbtGjE6nljji6NzmehkI+SIEvj/HEWspWn9nzJCYmhgirpJ1S38JdWjFC8imJOwH4AhV2s/84Eyljs60pHXQ6GSZTEHSY+okImj5F7qDvJlDavqQnY7/0PVLDXSKShfWArWuswCIKRflBGhSWNhrrLoBdIOcUue8tZFAK9Ty3DbJfFUvNDpVUwKMfHKLuwS6mqmCLYUG720/MqiX3s4E7NJqh+8RiePqf8nxjHXC8qaT/JuB7mZsQH4W+xxOxPlqg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(31696002)(86362001)(66446008)(38070700005)(2906002)(4744005)(38100700002)(8936002)(4326008)(53546011)(316002)(66476007)(66556008)(64756008)(122000001)(41300700001)(5660300002)(8676002)(66946007)(76116006)(6512007)(71200400001)(107886003)(6506007)(186003)(110136005)(6486002)(478600001)(2616005)(36756003)(54906003)(91956017)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eEZjL2FPbXc1Z3RCWVZNTEszWktJSVZiSnIvNkNSd093OUtxaHZOS2wrTnE5?=
 =?utf-8?B?T0w1Rlhwc2w5cjYzbEMyNlc4TnNsV0xlVy8wR0ZxRWc0ekZrSnJJU0xpVmtn?=
 =?utf-8?B?K2VhMXljYzFsZ1FYNjdrWjhjSGVpSUU4b2lZTFRTY1RjSFNuNWMyWVVNaVpF?=
 =?utf-8?B?UU5DQ2YySnNaNHJ4OUFRQXFnSjhiblU1NnlCZFMxQU9TSzBaNHZuWW4xQnZ0?=
 =?utf-8?B?RFNDdXJTdUl0RmlVZDBIZHBLSEljdnlMSVRuYzl6dUR2SG1zbmRoKzRoRG1H?=
 =?utf-8?B?TXNVWHNaNmhzeTF0eUt5THVaaitnNys2K21FL2gyTHpPREFVdDhHZHdPRWdQ?=
 =?utf-8?B?RHR6bkk1MEJUY1FYQ3BJU0hLdjd6WWNiV1M0c0NyakhuWnVXdlorNjlNNlRI?=
 =?utf-8?B?ZEMxajR4RFZUQUVLVWprZjBCd01KZE4ybHowREtqaTlBeFFqK2hIRUxRODVu?=
 =?utf-8?B?QVgrdU4xdTlUK2pndVVJb0Ewa1dTZ1Z5N0srSWtRNUVXbjJIY0YrZkpua3ZK?=
 =?utf-8?B?OFA0UUpJQ21jdzh3YXFOeUpDSEdZTk1DOEQzRHdiY2QyQmlTRnZTWW0zeHlJ?=
 =?utf-8?B?UmFPZDA3OFZ2b0k5U2JnaHN3TzhuS00xcEptaW9tVnUvRUpzek9COHJXZUFM?=
 =?utf-8?B?eXFYd3g2bU80d2JzMlRlQVB5NjRqWE1BZjVJcFRWZzFVTDJBMzJwZW84Z0N6?=
 =?utf-8?B?K3hPc1g5STZTYndoVUlwLzVYUHRoaEsrd1ZXTlZQWVNTUG11M0lwTGxzVUlO?=
 =?utf-8?B?cmYyRExTUEVkWGx4c2NSV2JJVjcxa1RPNWNZTEU3MTc0VXpMd3lIVFNGdUta?=
 =?utf-8?B?cmVlemtjQlFYQ1VWdFAyM1d2L2dlMGJsaDJSYTNTZXdDRlA1cWV4eDZ1Tnpq?=
 =?utf-8?B?K2dzTVZ3WDg1QkEwRU5IdTdkTHkzY1loUS8wOWx3RndGaFRESW95RW15eEtT?=
 =?utf-8?B?MTJUQUVoNytiOTdsdDUwUXdhQ0tWZm1mS3J2SDM2T2tXMXNqLytTcnREVlg4?=
 =?utf-8?B?NjlBR3d4VkdvL0dQMUxTbWRXVWFPTlRuM0E0cml4N290aEg5Nmsza3ovUm5y?=
 =?utf-8?B?LzIyOTMxMU43eVNtTXJBM0FkRCtEcExXYjZwRlJjQXMrTGdFYmg0QUVDSWJK?=
 =?utf-8?B?OXVSR2F3dnBqV2UzRENnRFREVWhkdkNRRERzQmU2c0VxZHZRaDNBb0svZHhT?=
 =?utf-8?B?aGFmL2dMWGc0aklXQ1ord2xqdnhkemdWbWR0cFJFRG9Na1pkZC9RY050eXdY?=
 =?utf-8?B?cUpxM091aHdwK2g1emxPVEpPMTArejd1TFZlbnArQnFZZHRyc3BqZUd3am4y?=
 =?utf-8?B?Q2E4bU5lamNRSTA3K3M5MkpUZWhXemNWclQ1RllqbHgvMml5YXIxeDROYzBY?=
 =?utf-8?B?VnJsUnlFVGtJVW5tY0NFdjNUYVdGWlZoNHkySURKNmQvTlRvSW1NYnhkUE94?=
 =?utf-8?B?RXQ3N0RwcVhxWEQ3SGlZMTc3bVpvMUsxWGNaVTdWWTFUanpzaS9CQW9kUFRT?=
 =?utf-8?B?WldzY1pYS3JqdHREQ3JER2tCVGFXY2JvcnlOYm5tbk0yUnZyek9qRURxL09M?=
 =?utf-8?B?VnB0V0N5Wm52ejdBUkM2MFlZK0RwemlrZTVXUnpOZkM1bTRSVml4QTBnTmps?=
 =?utf-8?B?SndZOHhxZ21ucU1kaU10N2ZSalNzL0hUSi8xZkMyNndLSk8zTTE1WWppTjFN?=
 =?utf-8?B?U1M4RlN5TVk2dU1ubVRzV0lkS3dyZE1HUk90WVdjNmhkcGhqcW1QZ3RidXhn?=
 =?utf-8?B?VnRBRk1MbFkyT2xIZFFTNUFnam9hdzV1Q1dnOW1MMlJFTHdrbFlXY1NGaFM5?=
 =?utf-8?B?WUw1Lzl0VVYrb1FnRVRxWWFISERYR1k0YlUwUUtIbE1tTXFKakVTanZ0Nm5a?=
 =?utf-8?B?WkFVY2RxVCtiMTVVWDdzMjVYNUJyVWR4TnQ1MnNlWk5Vd3VNOGcvQVZaektq?=
 =?utf-8?B?by9lWEZ5Z0YyVktNNVVvRHAwdHBiZFRHWTNNaXF2RnY0d3Y2enNUYnlKQ0VZ?=
 =?utf-8?B?Znp1cXVDaUszNWVMYUJ1MlR2dUNFenZ6STdGQzlUVnI1SjV1R2FTTkUyZUtG?=
 =?utf-8?B?M3MrRk40bkswcFlLN2tTK3AzT3RLODBHclBmSFlqNWx2eTNQdmZLcUVzUUNU?=
 =?utf-8?B?YS9rMEdab0dWbm5manBZdkN0Q0I4VG1SZWE4dUl0d3lVYkxya2Nic3QyTitq?=
 =?utf-8?Q?9vXyzIvDpf+cwH2SkZ4clsJ7oqp0A5OkGBm5Ha29tK2o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D24CB45244EFB84F9AE278976D37AC82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341a561f-4d63-435c-12ac-08dac6bc92b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:50:44.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rK98sPDnTQHo0gfGEGq3vszR7JCL/g8aXpRm7TLElxFr5AVsem2BiMMcCMerbrnp9gnW7CU5oKmafL9EsaOk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195049_879158_72DA3DF0 
X-CRM114-Status: GOOD (  10.59  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IG52bWVfYXV0aF9bcmVz
ZXR8ZnJlZV0gb3BlcmF0ZSBvbiB0aGUgY29udHJvbGxlciB3aGlsZQ0KPiBfX252bWVfYXV0aF9b
cmVzZXR8ZnJlZV0gb3BlcmF0ZSBvbiBhIGNoYXAgc3RydWN0ICh3aGljaCBtYXBzIHRvIGEgcXVl
dWUNCj4gY29udGV4dCkuIFJlbmFtZSBpdCBmb3IgY2xhcml0eS4NCj4gDQo+IFJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBH
cmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

