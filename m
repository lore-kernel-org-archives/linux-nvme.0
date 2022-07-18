Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C353C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWJ63jC75Mk3PO0sXM/GgQ6iU8FZfFyfwXLChhLtSB4=; b=C6G3Ph+1wt9LlFBVcEjTMx6WDn
	zK3gj73AWmjrRukl11eYpQm9k4cYrDu44NGA8fsluOrVuOXv0yL4iujR3N2DmcJg8L3flbPgtG1ID
	PSr5yl1bKYpKKC6eUwgXn0X0TbFB87aa4pNPW8pAUhWgqfVUntIb7rMosEXpJ55cQAADeTw+ZoVNF
	m0emU4RL8NHhEow4TttvgezOHqybkgjD+VV6StZRJlOlEbqGd3QdFOrnsTJMcRvnMTV0vpU+Kegpp
	JPb7wEPkjhC4faArowYocOomyYacVlDpDOMFwTLgOUQBDR7qUXrATwdgQivcz7i8RXSop4PA7KvV8
	Oxd0DO0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDY2W-001Rv3-Lo; Mon, 18 Jul 2022 21:12:28 +0000
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDY2T-001RtC-Tl
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 21:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7H1h45+XmsV4vfMkVBF6DkfvYKxVwpbmFM0vd3HU6+V+vt+SYbEUxCiFZtXE7/dVYR7T35M2AnqcsgZ3ZTe2o4IOFqVQwzGPy7L4uExVDxP8RDxt1mrKaquuAq2QXlrJtdqMoVynW/45I+81iQyKOvGgnOH/jxuNzdEUADKZq66WLhg7HLGc38rNauA+aJXAaGmAkewhrz5U+KnEZx5upCuQSvTexn33F3GF63eJIZh/w8dLjnWwCVXXobJBptTE2NDxH5WY29IGjshi1YUiicb4bxqXDBliuCnZc7mLZQGkNpkyOwaJuZrBi0Pw7SgiSjs2gxu6DJGkB7E/7Pn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWJ63jC75Mk3PO0sXM/GgQ6iU8FZfFyfwXLChhLtSB4=;
 b=ea7E4GU9I6q+pj2aPY/RU3mCOqszZWIdP7uIVI/x4pqKMT+A73O3JS4osMTJFUR45t6xoeHdcM3gpONXN8CGZN1QzFvfJjaPICKCmSSjS7D6tcdA09f2xLqYSmH3NMqflMwoU0iH2fQNs+ShszcYXZA/S4AUsdek4I0ZPxvvu5ByBbS2oT0Xy2WsSzVhFhg26aIsOGA8lUC5RCORu0ouBeyzqo73mt6QqF27L15J8bHDPfPQCp5Pc4sCSU9k7o2xcTKghkBjcY2d7E9pPZts1DFX/LPt+tCSKXMVPxXKzGcB+0YLwN0mH9RTckkXPaWNvag3dWLEbtfryj6QS/9+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWJ63jC75Mk3PO0sXM/GgQ6iU8FZfFyfwXLChhLtSB4=;
 b=AUJtSS8PWcnBLfR4lU4JplGZQVcH8qYxYQOkY7MlejM617BrO8gdXOfnuTrCjQsIH5A+NWGfgIoi0eX1/F6iYSx2V5az9us2lDlA7j7R2Q7+PvO0Hc3xt5kn6NmwU834Lc330SALjlC+TwYVJ5csO1AaY3f6tK9L4jEqE3SYAO6xjhzCccoHSZVpIFhWqzWfQYQvXFbxOjReXeUh7LJOiVBlMqy1Tgi3xlc9sZkHu3YVzrU0Kx+joQbozkfTXBnUdfkeZqvGqZqg2hgJESXj+OLAuCCjLjEKJdCOxASJjeDuhYe4Hhi7OiaZv273e+J0NNQz5guYiEXzFSctbRHyiw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1860.namprd12.prod.outlook.com (2603:10b6:404:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 21:12:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:12:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: print the command name of aborted commands
Thread-Topic: [PATCH] nvme-pci: print the command name of aborted commands
Thread-Index: AQHYmmVIpp8FUznMFku9i1W4Tgjgca2EoVaA
Date: Mon, 18 Jul 2022 21:12:19 +0000
Message-ID: <bcf34557-d903-2910-0d03-2916f8cad2f8@nvidia.com>
References: <20220718051357.232697-1-hch@lst.de>
In-Reply-To: <20220718051357.232697-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0cf5c06-e1bc-4d69-074a-08da69023349
x-ms-traffictypediagnostic: BN6PR12MB1860:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  0CHwcR8zxveGEHCf97uy7/6avRRpmx9Jee91A8YQmc83d9Cb/J7QsJSSIHfnojzK2LqIjdiQOJuCHXJGZUoGtt4Tq7V42u3+TGJ8l0LMP0H6Vh5fGoKyMYLKkrDsQILTeF7HGttTLadrN1X3VPm/E063Icz4xuRV/hTNdFe6n+1aVCTKhzNNxNWGtrvZewFtHeDLEcOjtIXkoK3N+kz5mqd3WTXYa5Ws4eAh2raGEYX+uhw0UBNxFEnCBLzAp9GNw+V876j8kRqOQdS+Ke0aDaLXKua0o9QIYZPeSYahYF9n2Wkpm9ocqj2aE+MGMi/f78JDbNjYFGoQezRnDPwqO9kzzqKquiAI/zZzILhAU+xXpQ5K625kkgDoNQeb2GsemCnpy87SvTZZO4b/zBk+Qx9Y4Bufb3nHZ4zSFVqbugSS8Rdgad17toimpZPaqSW/3RfjJQOOj4HZnLWlJ0EIo6RiwNKbsM88V5+NLgIkmKMjpnmN6veXF1zQ4QReWmp8JCt+kBwodEhD/IGxE6b2kzj6C5JVvwxQQOtF536UPFaoro4cLEnnUSKw43FKdthOFiyfipIwlMiCd9BffeuPg4gUvAisYj/49q229NP4Rm2SGJzrBQ1fWzSeJZDi1HH3oOYtEFL6MRd3fMHjw2UBJG5IHWAb6LU42l45IytbNzizphxOkXOIfIR/PDbbAIdDFxu4PT+jDJ7NlwGZqZTSaWWhsAsxnNI7fFgfqxoEQVA56JGzRy7yU1YUgTbeNIvDLqYeKy1/tdSOVB3vq2aL6l56yqBgxFoWOZeOL/LlITT/0bdWc5hSO2A5DDYWSXgipTvJ6OrKznZhXI0rqWvAHRWt4+CYVvazFpPI91X2Us8WZzp8jEvEww1oXS6lSRkb
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(71200400001)(478600001)(6486002)(38070700005)(2616005)(6512007)(53546011)(31686004)(41300700001)(6506007)(91956017)(186003)(316002)(36756003)(38100700002)(110136005)(8676002)(66446008)(66946007)(5660300002)(66556008)(8936002)(76116006)(66476007)(64756008)(4326008)(86362001)(122000001)(31696002)(2906002)(558084003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RnB1QlQ1YUFadmdzWDgxanAxNnBYdFVuZGNsZjR0dXJiQUtzUnVEWTV6RE5j?=
 =?utf-8?B?MENkN2Q0M21ySzExMEdMYU9sYmVTMXNsbWNpQTFDaVl6U0ZuYnZiVTBXdFpR?=
 =?utf-8?B?azE0ZVVFendyMTczTlFpd0J4T3lTNXJ2S29xS2cvYTZXemUvRUlBZUplSytC?=
 =?utf-8?B?V3dla1NyMXFhSXl5T1g1V01KY2hjQTAxM2FpZ0xkV1VBSXV5MFI5OFhjYUZu?=
 =?utf-8?B?TGFMRWN0YVpTREhTTDZDLzM2ZWZ5c0RuYThrdkYxci9mdXo0Y0hOblVMVzdz?=
 =?utf-8?B?U0Rnc3ZobVdudG4zUGpENDUyeUhYOEhSZnlwdjZQYVIzSGtyYUhkR01vWG5o?=
 =?utf-8?B?SG5HckJveitRcnl5c3hVSWkrTS9oVmdNWFVPT1NOTUlvOG80em5xeW9FUTBX?=
 =?utf-8?B?YTRGbkllV0pwNS9qQVJ1V2I5NXZRMjkyMnNJNXFJWlROV3VEYSt6NGZlb0R1?=
 =?utf-8?B?WHM4b3o0SDB5dDNVaUFmM1lINzhQSkZxUDBTSDgram9rajJWS2FBVWVnSmti?=
 =?utf-8?B?MHNNNEtUdzNEQ3ZWc2RldW45MDFFU2p2ZkpxYm1YSjVFNVN3bkdRSk5IbHpE?=
 =?utf-8?B?OGxWL0o0MW84UWVRUU12ZXAzOCtoZjQ3alVVcVBkY2pnMjMzTXdyTEkvcCty?=
 =?utf-8?B?MldyUHFyNW1vNnJjdnZkeUc5UjVaMk1sbG9TdTZrU1FyTEQ1a2xhdVU3aW85?=
 =?utf-8?B?bDlock8xdjN0SUZjV0hpbGJlMXZTKy9jYUk4YnZ3akpmTU5OQ2FobHVNRE5H?=
 =?utf-8?B?TGFwZmNSU2FVcERXaWJ5RVVPT1NPZTVXbUZUL2xBT2R2blo5UmEwK3ZkQjlm?=
 =?utf-8?B?WHNaMVBERGd1M1RhUW9kbEU5bHpjMnhIQlpDMk5XaVpvc2JPR1h1ZVZ4aUxq?=
 =?utf-8?B?TyszSmRyTjArZm0zQnQzT2NMVW1jNFQzelRmdWVCam9wVlNwaDlPb01IVity?=
 =?utf-8?B?U0djdVcrbXoyRElDcUJFR1prdkErYmFZRHkrWTFtcmNVT2p0MTE3bUR4UUFz?=
 =?utf-8?B?Y3g3eW42VEd6eEpFaHExSWFUanMray94L2NJZ2JEYUViUVVoeVB5c3FNMm54?=
 =?utf-8?B?dU1sNFUyZGQ5ak14NjhocHdSOGF5cXkwT1RNUGpzbXpKYURoNnZJRjBBekNC?=
 =?utf-8?B?RS9UYlJZQlBseWt2cEFUNFRPQWNjYTdFMHY1ZzA3eEhPL1NBamNUY0xReDZW?=
 =?utf-8?B?THpTMEROYnNRcEU5SERYc3UwTG5EVU9qTklsT2IySWdQWFVFZWJESjJRRGFm?=
 =?utf-8?B?UEpaMVNtRWI0Sm1vRkRyRGZQTU5CMVpQa29QTnZjOVUydU5KcjRpT1JiR2pP?=
 =?utf-8?B?TGFZdlVrT1dmVWVDUXFFNitBUERlNTRnTklnM0dYbkFmUDJKK1Bqd29qL2NP?=
 =?utf-8?B?cmNNNExPOFFhcFdmRmxrbWxXeE5wNDdGSmhHbUNQNzVhdzhia2NZSVJTTGpj?=
 =?utf-8?B?enJIbDBnVTNQUFVRajJaVks0T0N3MUlrV1hhOHVhNEVGcUlweDRNS1lwd2p1?=
 =?utf-8?B?UUdGcHJJUmVtV1ZCMSthZEdNWkJRakVIUmM5ZFh0Y29DVUNrSHo1S3REZUVJ?=
 =?utf-8?B?RC9ZMUM2ZW5NRTR3L3BJSFBXLzczc0piV25relEySm5DZnRVc2RLZGZDVlRQ?=
 =?utf-8?B?QUl4SmFJYWxZcG5USTRTZExJTS95MjdkYnJBb243UEhtRGFxa1lDL0Z5akpS?=
 =?utf-8?B?dE1idFdwcGZydHJlNHRxdFg3ekFTcFJkZVlOcHhZbHJKTExneC9GY25nSWZV?=
 =?utf-8?B?L0xKbTNieDI4dk9LZ3RmSVB2YnhPUzBUeUNDMk83NWw4cFY2THFtdHFwbTNX?=
 =?utf-8?B?dzNQYkd6Y01TNzlWZTZKNGU5cjlsRm5BQU1EeFc3OUZvUS9ORlRCdVdCcDQy?=
 =?utf-8?B?S2ZjbzVoNjh5VzZYQ2M3d242TEJMT1NJajlFZndWVEVESml2dENpS0hqcVB0?=
 =?utf-8?B?bjk4ck1OL3pheHJOZ1h1OG9DOEI2Mm1XQitKWVdDZGI1UW5LRS9ZT0NSWXhV?=
 =?utf-8?B?WTErYUNFRU1teGR6azFBN0V4ZWFKamZMVzVzUmxOcUVZQ2lnMVp4MTNjd0x1?=
 =?utf-8?B?QXVEVWdtQ3ZPbm9IQjRIbklvMmdYZG0xZ3JCUVE4aWZHS2ZJNlN4N3pSTFQr?=
 =?utf-8?B?cmQxWjVGcURvKzRGK2JjUjRLT1daYU5aMWlEQ0g1OVdkd0FHYzhLTkk4MFlw?=
 =?utf-8?Q?y+QNIVfBxJ6J0Xw+uQ0dpvl1Wxr5daJApAHyji5WP5Pl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C16378F02F4384B9B99267F650B2BDF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cf5c06-e1bc-4d69-074a-08da69023349
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:12:19.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrZM8uRnStppmFO1VH3bv5BKzb/qUBcFWZqbs7o9R6rblPbu1We2FnrbAUu+ICcysCKuuGJ9iBix2gvLc1ihlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1860
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_141226_010118_EC0A921A 
X-CRM114-Status: UNSURE (   9.22  )
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

T24gNy8xNy8yMiAyMjoxMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRvIGFsbG93IGZv
ciBzbGlnaHRseSBiZXR0ZXIgZGVidWdnaW5nLCBwcmludCB0aGUgY29tbWFuZCBuYW1lIHdoZW4N
Cj4gYWJvcnRpbmcgYW4gY29tbWFuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KRGVmaW5pdGVseSB1c2VmdWwsIGxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=

