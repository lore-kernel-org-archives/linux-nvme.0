Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687A6C004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ef74c7aXQMt15HgsUEeoPfqwryP1I2Rb+Q8i4Et1dG0=; b=pPfMIklb67LnNIClBIPYqx1Ukl
	LNrGpYUeMKACVANigV9FjjH3tdASjamgaQ/SVnG0tYr7DzBtYtj7fyEJLEjAW5Srp2DBCZ317G8r/
	HT2OMMZXKzUryUSz1nw+9yv8QUuLDEIcXbVZBo9VEP7kqMxyNFMcK1nDLXSPZLVmWCxSWidcTaW0q
	RSs73rT+kRRzvmwcPuYV9qd6Wr+4colrzkHSw7YGMF57SBpQqPgqKXsoVaS6IMNvclxMPqwgi5bdG
	IIlYvoJqMkCVuXgxyU/5JOXFHKhoZxjXZESnF0iVy7rcUgBEiL1i0fJgViOHYBfoQH5CnF3AvAS+X
	vuSnSGCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI5fc-000MR2-T7; Wed, 18 Jan 2023 10:27:52 +0000
Received: from mail-he1eur04on2094.outbound.protection.outlook.com ([40.107.7.94] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI5fZ-000MPM-2d
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 10:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC643dBp39iFU1CRvsUJmCejZlpi2kxSvo5JJRByRfYwVUSF+DI067uF0hrYy384VYPvEF8SJ/fJ4mb/w+ju0uSDmCz/9ys9LB85X/fcezacKM23nS78n/wuS2/S8wZDp7QYcFuh6Zi49XyWgNgZgG91kIC1GXNffxXSc3oxwuJlWQG1tEvcr7wLGtjQgFbKrmyCuO49Bye8ppUwxje5+yv6gzpkSuZYNd/LJuJc2XtVvPQpP1uI+ET41M59EIdFfafilWia37u/YCzL12Ae9+ChzfkoNaCzGjtEoFZKZp22Vx/0O/G3yMRNGzQ/d8oQlXTjhVrj2uygUthsjDma+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef74c7aXQMt15HgsUEeoPfqwryP1I2Rb+Q8i4Et1dG0=;
 b=LsIb+XmkJ5Vrwq1V31SXK5/0eMsmO9LhbuVxWi5Xnm+59HVEIgPehXgf/WkQGjnK/ybVKdT1kNA5EWm+nzRfoPUT4QGm2XRCWsJlT7Duo/I1sSuRyOFeHqKT/RhFp4ccqUcXNU9z7iOYP0rSVdObycQ8IHkPPHaFMtaQBhkG/BgH9HY5xute724D3u6lFSljKdo/1yBjB685hJTaTes/+qmJPNjZ0qfKDFD19jASStkhB3KMoer8d9DlpL3Egfw0mXkGv57EcoM++bLVv53tC1Zq+rVuIii6FhgktALZBtPKBpoPtoD1Sd2oyESJIyYZO5TXEzAPHSVcTBKlNcLpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef74c7aXQMt15HgsUEeoPfqwryP1I2Rb+Q8i4Et1dG0=;
 b=ptDBP/5KCf1UUXVo3GElTNIbDYuKI7k/RXIFRcXGXMWEJyex9qx9veBJTnBEYHdoz2iTVvd6NtZn0IMm7wuWCZ2qCGFwFYdMCkNrin2w16Ux30OzP2ZG22RVpzdtlLD7N6dIR2aLNkw4575wmOc205mWjxfpLk+d/nF4dr7Vapg=
Received: from DU0PR03MB8647.eurprd03.prod.outlook.com (2603:10a6:10:3ea::13)
 by DBAPR03MB6534.eurprd03.prod.outlook.com (2603:10a6:10:19b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 10:27:41 +0000
Received: from DU0PR03MB8647.eurprd03.prod.outlook.com
 ([fe80::aee4:bc88:b920:97f9]) by DU0PR03MB8647.eurprd03.prod.outlook.com
 ([fe80::aee4:bc88:b920:97f9%5]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 10:27:41 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: "jfhart085@gmail.com" <jfhart085@gmail.com>, Keith Busch
	<kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Thread-Topic: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Thread-Index:  AQHZECYGMPD3JUMzFEa9MFYdihO8z65unMsAgAAMPQCAAACZgIAASbYAgABDRoCAAFLhgIA0tfUA
Date: Wed, 18 Jan 2023 10:27:41 +0000
Message-ID: <EA186883-29E6-42C5-904A-9B4E2753F481@primelogic.nl>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
 <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
 <20221215090941.GA5062@lst.de>
 <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com>
 <Y5tambspBYRHU5B4@kbusch-mbp.dhcp.thefacebook.com>
 <581e0725-93cb-b796-e2c6-455737cc8ea1@gmail.com>
In-Reply-To: <581e0725-93cb-b796-e2c6-455737cc8ea1@gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR03MB8647:EE_|DBAPR03MB6534:EE_
x-ms-office365-filtering-correlation-id: 30f4735e-aad5-489a-59cf-08daf93ea147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  OTVBzIjutjGy8uiXMp8D3NLaZOhU9RwjkwuzFYAKXt0O16lSK5sOJfjE0W+7y4PfFZBF9eh1DrwI3TC/tqLaO68Aom2jAYPOUh1Rd2hosLWSlcJkoQu3mITmWOnlWZSInEEErzijIknE/byky4Mye2ui2KazE5jxN4z4h0fVK8sjdcOml9lmY8yxabt1EqsjFNdgoGUBXY9w3u96RSkTXYCOCFSPLaugZSSPmxehwCRJVOirz3Iw0MU4zQHtXHidaVTRdOvovMKk6p9hm0aK6ylFfRaEseUN/yTWLps+qwxU2h9L+NTjzu6tUHwvsfdUd0VRY/fcm82oRdwCVAcpYmWA8uaFwBGEVTQqzmE1JWbEUJkcYjsazywQba7x7U2v1zpKaTQstHMY3/vBg4gUBQCEIGwD9O+s/47QSptbsK1uvxDoUPG22IQAy7MnIeY8drM8N0GwLitVaIlxsrjGV4QAnLa1ojnstyBsHvtQKa5DmXzkJR4zHxFlRRYd3Q61JAr5xF0dnGlKrgcPBZBBW0I+hguDkkh8BH/W+iHhYxU5eoZ0qxPvjclyySzF/s0QSmFCg8trLNcI+d/rj95J7WMGCfVSnzsUoB5sis/z/YtfsNdMNGizRr04Yt2AtWQbyF7wwDvTkeAYvwmG6WdlRGdKG/kwpKHgycaRxg0m14QzKoPZaJhqqCpHfadqOt+cV6pr/KdxRCI3JDsoD9hexqX7oQxeMGJyhWDoHlNbGMo=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB8647.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39830400003)(346002)(366004)(84040400005)(451199015)(86362001)(36756003)(38070700005)(33656002)(122000001)(91956017)(71200400001)(186003)(316002)(6512007)(110136005)(38100700002)(26005)(6486002)(478600001)(76116006)(54906003)(2906002)(53546011)(5660300002)(2616005)(8936002)(8676002)(83380400001)(41300700001)(4326008)(66446008)(64756008)(6506007)(66946007)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UDFUelg1VGJ4aWltTE1OZ01PVmFvTytmME5GalV1Yk53eWtPQy9rdTZrSzlU?=
 =?utf-8?B?SGNUeVUzYy9nM05Eekh1alA4aUlaSmdYWnJCdU1qSE1hWFVTQTcxb2swb2Er?=
 =?utf-8?B?bUlMMjdmRjY1VFRlZlZiTkIrLzVKK0oyZEdxbmxDOTVRRG5WamZxL2tFYStx?=
 =?utf-8?B?Yk5Xbi93MEtjR1NmRUdkM2hZK3FDYzNQRm1iTDR3YXFCK0VHWGJ2SjVLc25U?=
 =?utf-8?B?bVNncWk4U1FId0hUSFZjUGQxeXZreW8vaXVMUjZvMUtDMGdCUXZlMjdueUZD?=
 =?utf-8?B?YXBadHBvWFVqWG5PUHNDNStnMjJ3YlRQT0Ntekd0dXN1RlhkaE1kdHRza0di?=
 =?utf-8?B?OUFDWk5JNkc2L1VvUVFmU3hmN1dmczRDMCtEeE56MU9PV1BSN3NqcDlqTDFW?=
 =?utf-8?B?QUFHVktNZGJXaEZRZzZkZzJyb21ydGdSOWpzdnJsVFNJcXYxcDZ0b2swajQr?=
 =?utf-8?B?elFvZXk4MUFnM0dSbTJONVpqazdpbWRyT3hPUTdyK1NGY1pRNzdBVEkvclZH?=
 =?utf-8?B?YnIyU1lpaU42SjRaTmdDRXcvNkY5d0tDem1PclAwajEwSDJNMk9uU0c5S2px?=
 =?utf-8?B?MWNtV2ZLTWVubmdySWd3Z2FWNzVnQWx5ZzUvbTRzWWZ0aks3MnZRdEh2WitH?=
 =?utf-8?B?M0hoSlVqdWNuT3BYSTJjZUJub3FmNk9ZeUprNXVTc04yUlc2TWpvbUdhbjNj?=
 =?utf-8?B?STFKc2drMDluODAyZWU3Z1d6dnN4a0g3S2kxRGFva255ZFlvVmt5MDFyQ3ZF?=
 =?utf-8?B?WmhMMmFsenB5ME10bG12WFpNNDJMdTIraEJQNlN0enljcW1mc2c1aFhpcklq?=
 =?utf-8?B?OElvRlVYcGlvbUVBTWJEOWNEa0pmY1UvN3V6M2FURGtJSUszVGZJN2M0a2FH?=
 =?utf-8?B?UElBQk5sL3dES0tqN05Bd2xVTHhjVEExdGFPLzJNMlFaMjFiN3gxV3UwOXNs?=
 =?utf-8?B?U0I4VVM2b2NYdjNkdGNBb0Y2Sjg2a3lSRnNqMXd0YWFaU2srRUh3RTdxeGpa?=
 =?utf-8?B?RGljNzdoZk5uTDZ1WWVnOXRKeThGbUxaL3RPQWd4MXpQTHd6MjhxL29yZVNQ?=
 =?utf-8?B?cFAwc01FODVXeFdYV0VraU9pbHFWYW16OWwxY0w2NmNLVnh6Si9WZVlhSldM?=
 =?utf-8?B?SFNSK2o4dmpkUHd5QkJvOUl2ZXB3T3YwOE9BNm8vM0NVaVloTWdZOUlmQTlP?=
 =?utf-8?B?dUxjS2RqTjQzanNQa1hqd2ZqVEw3RVZqQjRjN0xwcm4wSnliNGpkR2JGWTRu?=
 =?utf-8?B?NEFHd1F4R016WTlvZUhmU3VHYmYyZTlnNWtRMjhqMHI1bU5keDRUS1kxMVRV?=
 =?utf-8?B?WUlkSTVpTGx6Q28rcVZtT2RpclM3bFN0UjRkWmtXSmJkYUVXaFh4NlJDS0tQ?=
 =?utf-8?B?emYyZ0FhancyU0pVbUJkNHhOWTdZNTZJd0syS25xMmoza2tzN1pFa2ptdmhq?=
 =?utf-8?B?UW54Vm1ScDBBWDZHeDNnOUdYTitXeTBQWDRPdU01RjJzbEh0T1VTZHhnUmJG?=
 =?utf-8?B?MXhJTW1yTGtiU0NrbGMyVUZ4ZVBTMGw4bXFNZHJkNTAyTEpMTml1RWNIY3d5?=
 =?utf-8?B?WDB4aW0yK3F0TmdIaDF0amxuZ1k2YWhJcmZvSXpaVTJaOXlzZUpmc09YRVRG?=
 =?utf-8?B?Y2o3TmtUMWtCUkNMd0I2Q2FBZGx5SDhYN2hwUEwxVlY3ZzdNbERlOWZpZUJw?=
 =?utf-8?B?MEhzV3RraG56dSs0dE1SSXVQVURmdTZpaXROUk9ScnFMUEVuSXFScUxYZTRi?=
 =?utf-8?B?bjhnTUJXSlJja1VGYWJWa053TVZoREU0MldzOWswS2tUWEN1WlBIbm9pY0pl?=
 =?utf-8?B?aktMd1k2elJPY1RhdGdsZXpFWlBDUmg3ay9sUTJOTnMwbCt3cGkvOXIvSGV5?=
 =?utf-8?B?ZEN6Mit2NHNBSE0vTjRIanJqc1ZsSGxoM0dWSWw0ZGEwdWxBV1ZRNlJPVkYv?=
 =?utf-8?B?Q0tVdlpwQVJQN21MdlBidCtqSUI5Q0M0eWQ0VWJjd1RPTlhtTmc3OU8xYUdt?=
 =?utf-8?B?M205U2JwQ20vRE1uQWdTVnBkTG1qbDRLSHhuQkFGMEtUQ21XRys0VVpYMjJI?=
 =?utf-8?B?L0I1QlRaTEpHckU2QUdTSlE3dWJ0T3B6Q09KMUV2aFJJRi9wbUJ4cmhNWTBQ?=
 =?utf-8?B?YnM0UmJjQ0JHZFpYS2dmVjRDUnNCZ2NXUFZ3TEVVdHB6a0UwNk01UVpvd2My?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE283874263AB47BB2ACCA2B66A4DB2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB8647.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f4735e-aad5-489a-59cf-08daf93ea147
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 10:27:41.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1c8RZK7ZJvuksnqa3mhOj/7wbFf1uxCyEOCkgzoIyitK/txsH7NEZU5pKqvqDFxFd1osGCAL+yIMKUTfz4RGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6534
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_022749_356037_4A627D78 
X-CRM114-Status: GOOD (  15.24  )
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

Rm9yIHdoYXQgaXQncyB3b3J0aCwgSSBzZWUgdGhlIGV4YWN0IHNhbWUgcHJvYmxlbSB3aGlsZSBy
dW5uaW5nIFNVU0UgTGludXggRW50ZXJwcmlzZSBTZXJ2ZXIgMTUgU1AzLg0KDQpsaXRoaXVtOn4g
IyBkbWVzZyB8IGdyZXAgbnZtZTQNClsgICAgMy4zNzE0MDBdIG52bWUgbnZtZTQ6IHBjaSBmdW5j
dGlvbiAwMDAwOjIxOjAwLjANClsgICA0MS4zMzM4ODZdIG52bWUgbnZtZTQ6IERldmljZSBub3Qg
cmVhZHk7IGFib3J0aW5nIHJlc2V0LCBDU1RTPTB4OQ0KWyAgIDQxLjMzNDgwMl0gbnZtZSBudm1l
NDogUmVtb3ZpbmcgYWZ0ZXIgcHJvYmUgZmFpbHVyZSBzdGF0dXM6IC0xOQ0KWyAgNzU5LjI5MTY3
Ml0gbnZtZSBudm1lNDogcGNpIGZ1bmN0aW9uIDAwMDA6MjE6MDAuMA0KWyAgNzk3LjMwMDAzM10g
bnZtZSBudm1lNDogRGV2aWNlIG5vdCByZWFkeTsgYWJvcnRpbmcgcmVzZXQsIENTVFM9MHg5DQpb
ICA3OTcuMzAwMDM4XSBudm1lIG52bWU0OiBSZW1vdmluZyBhZnRlciBwcm9iZSBmYWlsdXJlIHN0
YXR1czogLTE5DQpsaXRoaXVtOn4gIw0KDQpBdHRlbXB0cyB0byByZWNvdmVyIGZyb20gdGhpcyBz
dGF0ZSBieSByZW1vdmluZyB0aGUgZHJpdmVzIGZyb20gdGhlIFBDSSBzcGFjZSBhbmQgcmVzY2Fu
bmluZyB0aGUgUENJIGJ1cyBhbHNvIGZhaWwuDQpSZWJvb3RpbmcgdGhlIHN5c3RlbSBkb2VzIHNv
bHZlIGl0Lg0KDQpJdCdzIGZhaXJseSBlYXN5IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBvbiBz
eXN0ZW1zIHRoYXQgY29udGFpbiA+PSA4IGRyaXZlcy4NCg0KVGhhbmtzLA0KDQpNYXJrIFJ1aWp0
ZXINCg0K77u/T24gMTUvMTIvMjAyMiwgMjM6MzEsICJMaW51eC1udm1lIG9uIGJlaGFsZiBvZiBK
LiBIYXJ0IiA8bGludXgtbnZtZS1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmcgb24gYmVoYWxm
IG9mIGpmaGFydDA4NUBnbWFpbC5jb20+IHdyb3RlOg0KDQogICAgSSd2ZSB0cmllZCB0aGUgb2J2
aW91cyBvbmVzIGFuZCB0aGF0IGRpZG4ndCBoZWxwIGVpdGhlci4gIEkgZ3Vlc3MgSSdsbCANCiAg
ICBoYXZlIHRvIGdpdmUgdXAgb24gaXQgYW5kIHJldHVybiBpdCBhcyBkZWZlY3RpdmUuICBJJ2xs
IGdvIGJhY2sgdG8gDQogICAgbm9ybWFsIG9wZXJhdGlvbiBhbmQgdG8gdHJ5IGFuZCBmaW5kIGEg
Y29udHJvbGxlci9kZXZpY2UgY29tYmluYXRpb24gDQogICAgdGhhdCB3b3JrcyB3aXRoIHRoZSBs
aW51eCBkcml2ZXIgaWYgdGhlcmUgYXJlIGFueS4NCg0KICAgIEluIGFueSBjYXNlLCB0aGFua3Mg
YWdhaW4gdmVyeSBtdWNoIGZvciB5b3VyIGtpbmQgYXNzaXN0YW5jZS4NCg0KICAgIEouIEhhcnQN
Cg0KICAgIE9uIDEyLzE2LzIyIDI6MzQgQU0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KICAgID4gT24g
VGh1LCBEZWMgMTUsIDIwMjIgYXQgMTA6MzM6MzBQTSArMDkwMCwgSi4gSGFydCB3cm90ZToNCiAg
ICA+PiBbICsyNi44OTAwMThdIG52bWUgbnZtZTA6IEkvTyAwIChXcml0ZSkgUUlEIDEgdGltZW91
dCwgYWJvcnRpbmcNCiAgICA+PiBbRGVjMTUgMjE6MzVdIG52bWUgbnZtZTA6IEkvTyAwIFFJRCAx
IHRpbWVvdXQsIHJlc2V0IGNvbnRyb2xsZXINCiAgICA+PiBbICszMC43MTk5OThdIG52bWUgbnZt
ZTA6IEkvTyAxMyBRSUQgMCB0aW1lb3V0LCByZXNldCBjb250cm9sbGVyDQogICAgPj4gW0RlYzE1
IDIxOjM4XSBudm1lIG52bWUwOiBEZXZpY2Ugbm90IHJlYWR5OyBhYm9ydGluZyByZXNldCwgQ1NU
Uz0weDENCiAgICA+PiBbICArMC4wMTQ3OTZdIG52bWUgbnZtZTA6IEFib3J0IHN0YXR1czogMHgz
NzENCiAgICA+PiBbRGVjMTUgMjE6NDBdIG52bWUgbnZtZTA6IERldmljZSBub3QgcmVhZHk7IGFi
b3J0aW5nIHJlc2V0LCBDU1RTPTB4MQ0KICAgID4+IFsgICswLjAwMDAyNF0gbnZtZSBudm1lMDog
UmVtb3ZpbmcgYWZ0ZXIgcHJvYmUgZmFpbHVyZSBzdGF0dXM6IC0xOQ0KICAgID4+IFtEZWMxNSAy
MTo0Ml0gbnZtZSBudm1lMDogRGV2aWNlIG5vdCByZWFkeTsgYWJvcnRpbmcgcmVzZXQsIENTVFM9
MHgxDQogICAgPj4gWyAgKzAuMDAwMzI0XSBudm1lMG4xOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFu
Z2UgZnJvbSA5NzY3NzMxNjggdG8gMA0KICAgID4gDQogICAgPiBUaGlzIGxvb2tzIGxpa2UgeW91
ciBkZXZpY2UgaXMgY29tcGxldGVseSB1bnJlc3BvbnNpdmU6IG5vIGFjayB0byBJTw0KICAgID4g
Y29tbWFuZHMsIGFkbWluIGNvbW1hbmRzLCBvciByZXNldCBzZXF1ZW5jZXMuIFVuZm9ydHVuYXRl
bHkgdGhlc2UgYXJlDQogICAgPiB0eXBpY2FsbHkgZmlybXdhcmUgYnVncy4gV2l0aG91dCBhZGRp
dGlvbmFsIGd1aWRhbmNlIGZyb20gdGhlIHZlbmRvciwNCiAgICA+IHdlIGRvbid0IHJlYWxseSBo
YXZlIG1hbnkgb3B0aW9ucyB0byB0cnkgZnJvbSB0aGUgZHJpdmVyOiBqdXN0IGRpc2FibGluZw0K
ICAgID4gc29tZSBvcHRpb25hbCBwb3dlciBhbmQgcGVyZm9ybWFuY2UgY2FwYWJpbGl0aWVzLCB0
aG91Z2ggdGhhdCBvZnRlbg0KICAgID4gZG9lc24ndCBoZWxwIGVpdGhlci4NCg0KDQoNCg==

