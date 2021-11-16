Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0969CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 01:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE00B61A4E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 01:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE00B61A4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qeM/s/gTWQPKRmibL3w4MNmz0xNVsHtTflpNmULlAeA=; b=y8urYKRGqnMmmriuEHISZZ+Ew+
	GEH+w/W8GDcZLZZuTF99aHL3J97iiNm1ZfgnC3h81jrQ+CDzKriV5CBhZQIfze3PiOQDISUfmG42L
	IPuT+cGKlEF1VLkVId/sNlaxnGb25RBSCK/SVVPkn3d8W//ng4V13k0LH6pc4WsBNXEjmt8M2uss8
	YtZQLfWLpHmJaC1aTURQqkZz+osMSBXYl0EHelKrLXWQyyh31kqx9s2r6fGeVT73FRu03s43VBaIJ
	Cvg8ua0+3Np6w6E36QOv4C7QOHRNbH632ylHqBlnNBdHPiO0ud4P8qej8A1bKkBlfeKPtJqhkU10Z
	IVVdXjBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmnSM-00HZuW-Ld; Tue, 16 Nov 2021 01:40:18 +0000
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com
 ([40.107.244.41] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmnSJ-00HZtA-B5
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 01:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lViWJfIf584QrnNE4BCQ0AUCK5t7bUm4UsvYcqWrpIEqHDGtFvamcYPL45q4ryA2ZNB3jFlceAPdmnk/iSM357DZEwF2ImuT8MzuFb3qADT6XiUHenfHsaAz1a7gJAxzRY+m4vKO0JfQZExIwKwn1nLSpOoDEZuf/qQTYqx9BITpoplay2857SiIpWXdFFLQJFU8rfy/7ilxbwiTFv319T9guovY7CSrb3V2TH2PR53E+87Eo9tSdzIxEUfllx5dkJKyC9/WpWd/QSV/h+ztYCu/QWL9LesyYjBTGr1pQd+5ivOo1eYT/ymFT+a+3QrY+Eb3kiJuzB8VNwyaGP/Nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeM/s/gTWQPKRmibL3w4MNmz0xNVsHtTflpNmULlAeA=;
 b=FnGX2+JaWB6wMOPQIbX4gASeZ/+ilAKARtXBzPXyToxB1IpDr3ycp0e4ocyuljlVITviE6pMndi5nw8JZni/+G2hRkkmdCK7I20Mst2094n1OwcC2K0fASsAYpkJDVsx2CwvZIe0QlX3WcIvhAKL4KBd8liA9TFGUg8scadoVTY1E85MDo4semJy27YvDgv4/S6n2OoAH355FPzn/ORZurXmSrMSi1U1uBJzrUoNvBufpFf6mtA9MDXPNOeT/UI1bnE9aPyq1LDRnWybm9phnbjy2dSVBn9f75PQZQYxHtOSU/AUgz8HaWUC/CKomix9hMmHpQR+KvSDiY2dh4GMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeM/s/gTWQPKRmibL3w4MNmz0xNVsHtTflpNmULlAeA=;
 b=dTjxYwJGQEUyUNoo+Jc2UlJxvxa6qp3gCkcNx8bMI57XLx/AxiAHcukX6PAJs99dh3PwEc4b30C3BLMRoqcJ0PcCP2srAV6OrirXlAn0dDBuYgFVrhuSLXwK31bzS3rggZnqiYaZVBXeT3GzCJm0ef2bRBmUdSGjZA4QV4u82TSY1nVbib11s4BbnRiY4s8xyp8KZ7xbrrkTRgijCYmnzB5U1+MWZ61clqUBaWuZz07GWrNDCuty3Hp/rXHVc2CnAYhNRNIXIJSLVoY/Zk7GeXaRwRypdYEilzeDu72TEgSLEwNm4RMjDgZ0bTS0xP09HcA6fisl5uOZOAcv107V4g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0222.namprd12.prod.outlook.com (2603:10b6:301:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 01:40:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 01:40:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: honour O_NONBLOCK during resetting
Thread-Topic: [PATCH] nvme: honour O_NONBLOCK during resetting
Thread-Index: AQHX1uuFYucJLahCC0OoP17xeeTHr6wFZ+uA
Date: Tue, 16 Nov 2021 01:40:04 +0000
Message-ID: <9c8da771-c5f9-923c-4c03-5d5ac8392ef8@nvidia.com>
References: <20211111105953.63072-1-hare@suse.de>
In-Reply-To: <20211111105953.63072-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee8494e-1244-46af-c8a7-08d9a8a20359
x-ms-traffictypediagnostic: MWHPR1201MB0222:
x-microsoft-antispam-prvs: <MWHPR1201MB0222FBEB1FAFCF6EDA66EEE3A3999@MWHPR1201MB0222.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hk3QBfKlhqeOoGLuKj2FgCSuj4njgKqtwylRlt1TQBTHPSKiGAITczZccMPh/Phf71L6UyDw4LSD+3SpSwDreOmVdLuEIgISRJsXf17zWC11H+aBdraH/XjIyaYtZLORyDaZ5YmDyBjN8R9sjMeqALZiag5j3HxzeYXJCaeyXQPtjb7e5kkhrfXZWJSxSsG6lZoZPALk5wqZ9oqfLwzDwdHNwEWsewmNoNKK1lyI//8fDzaw9RUc1fW91xilS3MBWz0C+iz9ho9wd3ColoI3O1SjyEbBTLQ3EwfD7bwdY7A+2x8X3gye+HDsRXeDH1Q51nt7o8tU9WISORtzW21E3zV7rgoHUAurPBKX/B9hNNAVZ78hvSr1Nszsh77VmjNjcBwcMtF7C5gEk9Y/ghqqPOCaTJG3uBAHQq2jAeBbWWi7fFO8+EmSmyLbg7Z3LO6faQcP5ps1I9swLpd7KgmMTLHLUD9MvUpN+qRV24FWyuLbl0IVayFxB6iA3v7oLWdCj9qKy53CbWxtJU+UaoE35AH2ttRhrkZNoV7zu0PKxmfnJGHRG15xFtP8oUkiujhc3CWyjS9fHGsJJu8kGjPMk/ujHUDdKv6/8gcloZN+KUCHoY2HBFJygNZaQi5zOnjZ8l9hfQ9K1hFEDybnB7DdAEqwoD3kNv9NsuWbgBFnEYTwOKq0ERQ9Ej9bFrvlhHvwVddhfd3ePYhbqXizuL8y5MayBw6A+Xnd0V0yaK4/7DyNL2EO3WwYwVRZUjgB0rGtvk02u+TSSM+Hn/9b4A672w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(6486002)(36756003)(83380400001)(66946007)(38100700002)(66556008)(8936002)(66446008)(2906002)(91956017)(508600001)(31686004)(6512007)(316002)(66476007)(76116006)(8676002)(64756008)(5660300002)(6916009)(6506007)(4744005)(53546011)(2616005)(186003)(4326008)(122000001)(26005)(38070700005)(86362001)(71200400001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRMZVJjK0wzbGNMRmVxVWZKQXFpdjEzYnByU2RiemJjMWNoa3IrSzZzUEk5?=
 =?utf-8?B?b3M1dWFwc1NVQnNMYmN1bDFCNWp6Tmt1eVRLNnhsYmN1Ri9QTzVhMVlJK1pZ?=
 =?utf-8?B?dGtnTWJrL3h0blFGL1VCZ0JUVGw1eUI0ZmhacmdETWVjV3Y0MDlWdXg2U042?=
 =?utf-8?B?b0ZhT2V1QzJDTE5LVHFjeFdMNHVqSmxGelFmRXA3cDZJczZGcGM5MzVNRU5i?=
 =?utf-8?B?NFV2Tmw2ejVpOXQ1SnV0cHBFeERocE9oanpwVklZd0hTRzh1dXpCUlZyc1JR?=
 =?utf-8?B?a1ZwbDNzdmlOcnkxYU0vc29tcGNPT2VheWQxdnF6SEZuSUozUnhLRHhabVBi?=
 =?utf-8?B?L2tQYThjYWZtbU9jdDNsZnNNZWd6QWwxeE8rR0pTOThKVTJOam4veHVTYm5F?=
 =?utf-8?B?eDN6VDAvWGNTNEZoSkV2UEt4cGZydERram56UnF1QVA3S3dFc2FQVHVVUDBH?=
 =?utf-8?B?cWdaU29UUGthSjA3Unh2MkMrYzdXVzU3ZWNwbkJ6N0ZWQW0yYUloelVyb0VW?=
 =?utf-8?B?RXhpRWNGODNjQlgxZjRCY0NUN096eDlHQ1E0cjZxQjBHQ3duNE1QMmc1d3dz?=
 =?utf-8?B?YnduUVdJVDFqTGhXU25NWEJlaFAzR2xQc0hCa3IrcDdBU2cwTFlBaU9zUzZM?=
 =?utf-8?B?K3AyR0Ryd0ptbG15dWhOQjhoekw4ZXRoK2FyMk5ZQWdQV0pTSEIxY1VudFVH?=
 =?utf-8?B?aGRSa3Y3TUFCK3lOemtRMU1OZWoxRzBPSFMyL2k4a1hla201ZjJMUEJlMlRx?=
 =?utf-8?B?TGs3ZllzbFNGRCttcm1TeUJja2xSOFhKaGxlSnFqM0J5UHRNdHdsTXVGWm8w?=
 =?utf-8?B?bnVCcktHTW1BK1BTU3NsbVB3UlluM3hpcHdNMGhXRmovdkV4NVpReFBDZDF6?=
 =?utf-8?B?ZHpFdzlrMVB4dll6bXhjZndac2RTdE5VZVlsNXZYMDdnSVhNdFBudGNWeU9q?=
 =?utf-8?B?OThZR2dLcUZFbkdyWFMrNXYyZGtwQmhDR00vNDZMMlpFNTVNd0VyQW9vUld5?=
 =?utf-8?B?K0FGMXpOWU5scG10cDIwTWFsSkFKK08wWWlYcTh5T3VLRFZtMEtGSnRCbTdZ?=
 =?utf-8?B?ZE1zdy82S2tqbjUyeUtIOW5iWTFKNUtSa1NJSDFZb2pVM0JYTW9EZ2t5cW4r?=
 =?utf-8?B?U2pZSkFsakZpZmZTdlV0dy9IK0dacFJWMUJuNzQxNDIyeVpneEVxc1o4S2s3?=
 =?utf-8?B?YUF3c3J1ZjFMbXR2RTU2SFViTzRNeU1GVW4xMk1TQ0hzSWpKVHczNzJ4aWdC?=
 =?utf-8?B?cTQwQzg3b25mWmhxa3ZvVmdNdThudHNxQXNOVFZuV2U5NlR2MVFiZVcvWllh?=
 =?utf-8?B?KzV2bTZJdFh4eSs1YlBncm45cTFPNitWY0wwRnQwamR6WHJzbTFjTlpyaURm?=
 =?utf-8?B?TURBODgyd2FJc2puQlNQcnBnaHFjMVIzRnVOOWozNzdEVWpTT0tTZEM0QzlE?=
 =?utf-8?B?TS9scmllbFIrM1FOWnFkd0htQ1ZEZy9XdkxkZ1lSUjdMM1VRNlJ5SmdjbHU5?=
 =?utf-8?B?QStmalVYZi9FMXVQMk1lUmtMbTF1U3FRaGN6N1F1Qy85YmlUUGQ5Y2h6ZXhQ?=
 =?utf-8?B?T1l3dnZrc1JvYzVJYUZON2x1bEUxTDAzMXl3QjJ6TXNEblpKaWpVd0FWL1pn?=
 =?utf-8?B?eW8vMW1KNW5sQ2lCM082WVpoMmE0Y0dBY2RJQ25GK2Vkb29KZDJMRFBkUDVO?=
 =?utf-8?B?bkFaSk1TQitOZldWYTBsYmhEZVpLbHNEZndCekwvUmVHeFlwYTA2NUszNGN6?=
 =?utf-8?B?emZnaWMvTXpVSmYyS1NaWHlIK2pqZ0Exd2U2TXF0UXU4c1FnY1dsOGRTRlU4?=
 =?utf-8?B?b21XUnVUeW1paWNXUEM5L2NKUUtTQzlUWXpJRmZFenp5N05Pc0Y0dmttZUxY?=
 =?utf-8?B?T1RmdUk5dVZzcVpjeVJtbUJUako0aVlma3lsTVVlN2ZjZklDelhwMHlSUGdB?=
 =?utf-8?B?M0QyRWpWWVZMN28wUjcxY00wYmdTRXNtRkRLMXRiUFc5Sm9rRytiK3VwNEZE?=
 =?utf-8?B?UWxRck1VQ3FhMG5wemhkQzVvVnpOK3ExdFVIaENzMDl1Q2lLZW5pcmxWOEwx?=
 =?utf-8?B?VXZDS0U4UDNKWUhiZm54TGRCWTFnTlozVUdOMURzY2pnUmRKdm4wekpEMC9F?=
 =?utf-8?B?eC94NjAwOFNmVGQzTTJmUXJSTzRndXRpVXd6bWk0SXIwOWovaE1iNmttZ2U0?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <819B55EF444C4344BFE353A24BEE7E74@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee8494e-1244-46af-c8a7-08d9a8a20359
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 01:40:04.2730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnynXovkDOmVAcKtD5rBC9r1u5d5l+qyUOELCvR03awb9tLzv9nhRCbngoHS9afaWSX55pFLzd3zj/G85Z0j6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_174015_413096_BE0130B2 
X-CRM114-Status: GOOD (  11.55  )
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

T24gMTEvMTEvMjAyMSAyOjU5IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IFdoZW4gb3Bl
bmluZyBhIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUgd2Ugc2hvdWxkIGhvbm91ciB0aGUgT19OT05C
TE9DSw0KPiBmbGFnIHRvIGFsbG93IHRoZSBkZXZpY2UgdG8gYmUgb3BlbmVuZCBldmVuIGlmIGl0
J3MgaW4gc3RhdGUgJ3Jlc2V0dGluZycNCj4gb3IgJ2Nvbm5lY3RpbmcnLiBUaGlzIGFsbG93cyB1
c2VyLXNwYWNlIGFwcGxpY2F0aW9ucyB0byB1c2UgYSBjYWxsIHRvICdvcGVuJw0KPiB0byBmaWd1
cmUgb3V0IGlmIHRoZSBjb250cm9sbGVyIGlzIHByZXNlbnQsIGV2ZW4gaWYgaXQncyBjdXJyZW50
bHkNCj4gdW5kZXJnb2luZyBhIHJlc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+DQoNCldpbGwgcmVzZXR0aW5nIGFuZCBjb25uZWN0aW5nIGV2
ZXIgcmVzdWx0IGlzIGRlbGV0aW5nIHRoZSBjb250cm9sbGVyIGR1ZQ0KdG8gZXJyb3IgY2FzZXMg
cHJlc2VudCBpbiB0aGF0IHBhdGggPw0KDQpJZiB5ZXMgdGhlbiBhcHBsaWNhdGlvbiB3aWxsIGhh
dmUgaGFuZGxlIGZvciBzb21ldGhpbmcgdGhhdCBtaWdodA0KZ28gYXdheSBpbiB0aGUgZnV0dXJl
LCBzaG91bGQgYWxsb3cgc3VjaCBhIHNlbWFudGljID8NCg0KLWNrDQoNCg0K

