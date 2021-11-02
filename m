Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A780AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 03:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A62760EE3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 03:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A62760EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O0yMgDnILawUFDrU7TduX0FXkX7cVGKLLNx79OmdzVM=; b=D5Lw6tvKT2PO8yeYXuYHqevVFc
	xUxtT08SDDEhHdM6Ic3m3Sp+HLvMLFTv68gj6/cnT0jhAFB9U1UFxsa8yt4KJ+uQ6xJTIorTs2p1W
	1ZAGqRCy53yqdoH+xP6G1HuyPeU813L37PEx1eB/eV1D2kZgpPiPYENJaU/1qkPKRm39eYy4EN6bJ
	67XqvEqsDr+1xsPQ8Ue1e5GS7UqhwwOfAQ9pSTcC/b87t0f44DBfqw6SsOVfFMU2FlC4mmx+X/oBb
	ITEbGQxGsL6mKBxoIzw+3xaPoBQIHxAg54FheayafSauTsBc5O/qA+JASPx8wM1liIvFryqOWspsF
	jt2npIBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhk4N-000O6u-Jn; Tue, 02 Nov 2021 03:02:39 +0000
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com
 ([40.107.244.66] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhk4L-000O5m-Md
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 03:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2it+HrTO1e56lI3QwRn53nVOLSjzeYr1+zC0077XbUvrc0s6mF5kMJBdI6p+2A17RfqLms1o0pjMNx78xebqbtgd6dQGYrapZS4eCr4G05MnZcQgq708AjIhgXAs23KFPmhofgIVmFsT9FbmF/rpuiUOdsXub6apnl7fJXIU4e3+A0G+x/RbDMGTq/tZKWP1IcadLObCLGTbBjLebR/GcUQrTGleCxS9aop/O5tkDihXYYJpa/aC4wsYahM9dQBRASiweRce5Xdcm1BlatNHCxksWIeUXD9La89mhuu+7v8g44upi26WFM5/PXxUGJYIjvuu1ehBi6c2TWf9Q+7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0yMgDnILawUFDrU7TduX0FXkX7cVGKLLNx79OmdzVM=;
 b=nD/ao55tAWT9yN+7J6KQgIa1JEX8YUOLjVSnMKwNYJL78c6awxmNwUL58judl5bliZ7hvT/jY6N27Xx+otvtaxaD/n6nz/51VUBbpWjf0yuCV7GjmEKL3cdj+6Ihlh5JRskM6ch4VxoXPlewRETg8lFUiXd3KA2wwITLcts2UprA9vKVZukDTva2G+h+4sSL4D3m7Er8Ci3T7ZVlXO0BZNiyB74JSrobkOKbFYPZzECvF5dBLW9rvAY5yxBfAmM3qpl5Jx79U2nPySxJQTZezBLJ5Hxb/S+edLBaLpkZhLsbKrc2HHXIpzSVfzXMKAEbBvy4PnJWXdQbGUbeIw8jNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0yMgDnILawUFDrU7TduX0FXkX7cVGKLLNx79OmdzVM=;
 b=RU+XRElqPGqWkWb7Qb3mREK5Sh2rKAiODdXZutG6LVhIIFQtATTDDtLhGtvBJ0o+fjyH+H458RDp/2qYH6llpu8YSnIFlNqKnYh5HXSNQqlCI+k5gLo3gUXAolZWMaF0XiodxmX6R4LGeA8bx2I3Ik9yu5deU2I0XpUUnPZpMvCqo6LttQ/ya3pQ5DSVlsVib3H70z16Ivf9QST5yY1sPT1VJF9wm5INqi0bfd3OLiWSWESoycjMnwFcFqbWBNMb2NmoOu3N1mdqb/8jeQ6k9Fac+sKLbZidH/Bq+zOISa+6YoKSoXF2UKbPCWtTpD9ANi0Irl9DwJ13864rRRPOWA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 03:02:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 03:02:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>
Subject: Re: [RFC PATCH] nvmf: allow user to choose cid-genctr feature
Thread-Topic: [RFC PATCH] nvmf: allow user to choose cid-genctr feature
Thread-Index: AQHXz3aoLXOHDyeJs0ampjki68QegqvvjUOA
Date: Tue, 2 Nov 2021 03:02:35 +0000
Message-ID: <378d5392-38c2-bf10-afff-0cae564970ce@nvidia.com>
References: <20211101231719.10256-1-chaitanyak@nvidia.com>
In-Reply-To: <20211101231719.10256-1-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85d92bfa-00aa-46d4-d041-08d99dad38d2
x-ms-traffictypediagnostic: MW3PR12MB4395:
x-microsoft-antispam-prvs: <MW3PR12MB4395AB9B2D728D8B416011DCA38B9@MW3PR12MB4395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXyomVF15tgJPNZ9AtMa5bfVq90b4HdkcP2jD7NCv2QSD7jyngHCzUcSc2ozQnK77GaDEUeEt+L4yP7wwSCSrnGwZF0DZBwXVPQvQPyu8NItMOlLXh1g8te9GSa+kJ+uMLn83ND7ewz+D51OjSxWUDKA3taHLUrbAw6Xxd/pLs2MQKVESzKX+nyW4UUk4X4jm9wCx4iTElwfHfvDM5wHwUYH9I+Gd7nch5PACyhxMiKKYJgVk4i4IgHP3PUwyFXrhazFUSkT8Ue+TOVLhyRy/2XQXite1oQ1T/W/f66iSEC7vmLodZTYEpoDTkVzxwxpYKlOlDJ6wamSnUKeUQkESwWFC0WjJbFB/KvB+KtDPpLhz7jNW/OIgRBRInwJhvcbjwfBeOCsIKoHiMLm8o5JJB1JwO/1Imo07iB9CLLkgw7apJDXJhcqc3diOQMF11gEDeJEgOVCABGByLIKL9KaK+YW2ckMvjr/dqfDTLrwuz4Ipv3L0QUGpDFJTyPyMCwLQ3IyXwwhorEQjZmxqUDhSj9c9aw2udLV/x23dVKd7/smjRhO9bs+NToY4cceuyWamOBlWSgg7tLf8L94Q6/4W5WT4p+4wAvDF3x12f/Nhy70YLU+DMCfZhZ94aJFGmOVtCWSlbin1pZ5WeW+YH3vjxf3WdEiAPyGaedrIIdQ0lBij0hKQCwf6FMXmg2KN5GB41dAimQtH3OhfUlTi00Vy03pvI7cr5dQXsufyBMu+i3f7nEGAOEP4LDjGxnCSwaUswMu4n7hKUTlq4HmwrGkZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(36756003)(76116006)(508600001)(6512007)(4744005)(107886003)(66946007)(83380400001)(2906002)(5660300002)(31686004)(31696002)(2616005)(38070700005)(64756008)(66476007)(38100700002)(66556008)(8676002)(4326008)(8936002)(186003)(54906003)(6486002)(6916009)(86362001)(122000001)(316002)(66446008)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0lLWWU4UEJhcmpNZXY4aEF2UCs4T2wzMzR4NWhieVRKZjVrTUNURFo1VC9S?=
 =?utf-8?B?WkpMdkQyZmxXdTlBZUhGYVZnSEZnclN6ay8vQUVGQ2l5S0ZlZjZMa2pOUzFa?=
 =?utf-8?B?anZNMmNmZmtHZHo2RWI5U0x3RVNWMHI2ZGJqNWNQc0JXME9tNEpGSngyV0Ez?=
 =?utf-8?B?eFRjc09xZll2SmpjMW9JVUQ3SEw4MXQ5bStCNnBVaWZsK2kwRW0vY1o5WE1Q?=
 =?utf-8?B?Y3I1b1U4anNSckw3dVNyWC8raEdXOUN6OGs2ZzdrQmU1UkZ5QzJwei96clhn?=
 =?utf-8?B?WmxsYnBMTU1ZV3BKQldCSWVubGQwTldSVklSU0lkOEFWMEZ2dHlHL3o1b2d4?=
 =?utf-8?B?d1J6MFJ1ZEZpU2xmY0U0aW8vNGNpaEd6Qml1U2VBUXR2Mzl2RUlHNlhjaU90?=
 =?utf-8?B?Q25tcjIxZHRJNERHalVQY1Y5MzV6eTdtTWZBMHNuT01HcUNmbU5NRVB5dG9F?=
 =?utf-8?B?NXJnbWZBVlN2WE9TSUp6Z3pVcUdZcHVZN1I2RHQ3V3NqdndoeWtpSjZiaFd2?=
 =?utf-8?B?ckhxMEx4Z2hleEZtSlFXRkNGUlgzUlJTOGZMZ2FVWTBOakdlaEM3c1plQjc5?=
 =?utf-8?B?THQ3OUVETWRCUjJ4WVVBNGVtN1NOTXB2bmNsMlBSZHpDd3RlMGNyTGlDdXJH?=
 =?utf-8?B?QmhhWTdHR2ZqelZ3Z2ZEczhOTjZ0ci9BeXVrUFVBTEQ4UFgxYTNjdmhMZEhv?=
 =?utf-8?B?SUMwOS9TNVJ6aHZTTUJveCtUTXJJSEYwWnFhQmo3WGRvU3YxMXIxUGZNQklo?=
 =?utf-8?B?VTAzYnlZYkRHWmRSQ1VyM1hpTGNPYzU3bzBWc0JOK1pzeXRIWjg1ckJjNStQ?=
 =?utf-8?B?Z0YzbHhmSTBxK1MySlZ3WCtDOGFEVGRZdDlCNEI4SE1MZ1JRemw5Sjl6ekRB?=
 =?utf-8?B?RzhWSmdpbm9DNUZLU1FoWnZycFJVNjJsU2tGWmtpMnBwSHpwZ1dEOFhsYldN?=
 =?utf-8?B?TFNLMG5TWHEzQ1NaZi9JcUVqVkIyb0ljbWRXUTM5anQ2bkROTjVXK202OWlW?=
 =?utf-8?B?MGpmSDllbThuTXpTNDZLSDlYaXk0eGdlcTNnU3MyRDBjVlUxN0VRcUF3MEJh?=
 =?utf-8?B?VElZU0EyeWJZRjB4SUkxbEZoZEtaV005TEZ4M2YvVWd1aTVCa1YvRUhkRVl2?=
 =?utf-8?B?bnFEL1RCMW5RS2d2Y3ppc3RDR2ZDbHM1YUhNOGVlc1YwM3hUSmo5eHdjK2k0?=
 =?utf-8?B?KzNRRmZTMTBjRFdyMkwzVzdGNzNvYldZNjZGZDYwakVOVWhWa0ppcWNVV2d3?=
 =?utf-8?B?U2tPQ0d5OVJIbzVqQTh0QUMxSDlWU0hwRUFYUktqSkdqU3dxTlBTMkYrZnp0?=
 =?utf-8?B?Unl3NVRKVjNOZTEwdERtT3dDKy9yMlhDci96a0Ira1l6dVpuRUxlNWF5ZmtZ?=
 =?utf-8?B?OWZnbHAvY3NrZ0VoaW9rdDZhQktGN2c4U0tzUDJ1bmpNT1k1WFphV2lXcmZT?=
 =?utf-8?B?Y0htVlRTbmdYK3Z4N2pVa21CTWhyY1I1VC9VVjRhdjN5L0hlZmduektKeEgv?=
 =?utf-8?B?SDhjN0JCeUYvTXYzUHlROGZxSmVTVTF4ODJGQkQvUTJvaE03V0RVRFQ1aCtn?=
 =?utf-8?B?cEtWZ2hSSEE0Q2syYmhab05XUThZL1ByNmNidXQxZHlOUHdTWE94Z080ZFV6?=
 =?utf-8?B?ZUpBTmNrTEFxTDNnY1dBMlFGQkNHeUxKSmcrZk9na29ZOTlHKzNrMDI2VTFq?=
 =?utf-8?B?S0RJeTYvMlhsejMzTmY1WjRNQ095UUg0b3h5TWh2YzFhVngzVnVPNWhuN0JJ?=
 =?utf-8?B?Z3FqVjE2R0F0TEorQytzZDlqSi9RdWtiZktWYlFFUnhBOHlJN0QwUUJTdHpm?=
 =?utf-8?B?dDM4L1NlRUFUaldQbGp0eUZBR2dNOVpMSmlkYnIrZTZkeGdjTWp0OWhIL1hH?=
 =?utf-8?B?OThuWTNJbDlpcHYrY1BTWDlOOHFabHlRd1pQTmY2RS9pbTBxTzczaVNpWTRC?=
 =?utf-8?B?UjIxdzlUTWhVdEFPaEJVRThxWk44aVBZSjZlS0hERWJ6ZVhmUDJxdUlBWWRF?=
 =?utf-8?B?MzNjNkVjZU5kWkQ2QjU1S0VDdzUrRWljbmdPYlhURmZUZ0ZyQXEyazlEc2RM?=
 =?utf-8?B?Q0ZpeFpvaXpJZWJyOERqcmovNEZCcnpvcHRHbktvNEJNL2l1bHpmVVlEcGFt?=
 =?utf-8?B?RkhQTlBPY2Jsc1AvUyt3dUFuNkVGajlQN2JOMVRXcUpxRWJ6anE5SXJZUGxV?=
 =?utf-8?B?aTZYTkF0WVZvbEZpMWRjYWZHaCs2N2tVaXpRSUhpbVVDZHQ0S0N4dUZzNlIz?=
 =?utf-8?Q?OuPc72LUeyYakM7k8Tn0zzsZ7yIFIfa/rPZ7UP39ik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CBCD1B43F314048BA3F950068C0844C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d92bfa-00aa-46d4-d041-08d99dad38d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 03:02:35.6659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: injRWoXe1GLnBEXChLNI/HU7aadu/5DgAQB0K18X1QIx92KzmNLjcvRmz1ExVzH2HqOXornggWIef70y2meCBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211101_200237_936451_9B524474 
X-CRM114-Status: GOOD (  13.15  )
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

T24gMTEvMS8yMDIxIDQ6MTcgUE0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gRnJvbTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gDQo+IFNvbWUgZmFicmljcyBj
b250cm9sbGVycyB1c2UgdGhlIGNvbW1hbmQgaWQgYXMgYW4gaW5kZXggdG8NCj4gaW1wbGVtZW50
IHNwZWNpZmljIGRhdGEgc3RydWN0dXJlcyBhbmQgd2lsbCBmYWlsIGlmIHRoZSB2YWx1ZSBpcw0K
PiBvdXQgb2YgYm91bmRzLiBUaGUgbnZtZSBkcml2ZXIncyByZWNlbnRseSBpbnRyb2R1Y2VkIGNv
bW1hbmQgc2VxdWVuY2UNCj4gbnVtYmVyIGJyZWFrcyB0aGVzZSBjb250cm9sbGVycy4NCj4gICAN
Cj4gQWxsb3cgdGhlIHVzZXIgdG8gY2hvb3NlIHRoZSB1c2Ugb2YgdGhlIGdlbmN0ciBpbiBjYWxj
dWxhdGluZyB0aGUgY29tbWFuZA0KPiBpZCB3aGVuIGNvbm5lY3RpbmcgdG8gdGhlIGZhYnJpY3Mg
Y29udHJvbGxlci4NCj4gICANCj4gVGhlIGRyaXZlciB3aWxsIG5vdCBoYXZlIHRoZSBhYmlsaXR5
IHRvIGRldGVjdCBiYWQgY29tcGxldGlvbnMgd2hlbg0KPiB0aGlzIGZsYWcgaXMgc2V0IHRvIGZh
bHNlIGZvciBhIGN0cmwsIGJ1dCB3ZSB3ZXJlbid0IHByZXZpb3VzbHkNCj4gY2hlY2tpbmcgdGhp
cyBhbnl3YXkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY28NCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNCg0K

