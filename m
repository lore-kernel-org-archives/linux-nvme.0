Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6F6C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8apDoOKN1iTEGKOLUiFOpQUNQV6iWixX+fJHy14kOnA=; b=i1fL0g3KJajybAyT+NPyzYE+H2
	UIDIQAfeJftoVjAj025vsOH8HdsGJddqJ0sXaDWGZ0G8iNkK1IxdPv6scZDO647djDZQdPId5bAjT
	hEvu0WZNs6JX2J6F8XS+xST2LtRxiYXvT3WF/o5lldm6NiNFvfMDH5UrqxlqpWoTQnTkvjbdvHUy7
	2qVgFKw80nXUYh7N4Sv4szijmCdhRSBWtqmqTU+SZL/v8DhpqNE4ked/62WQO9CjNlj2e1Di1/nel
	E4O2lZ+fObE3UX+ND4d5mRwnlBlhc8Qgo3DsnNjwMCMVKyp4xsWft6aRrufu8oVIBN2pQvzlJhYX2
	aCywOJJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz6LB-00FMq7-KG; Thu, 09 Jun 2022 00:48:01 +0000
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com ([2a01:111:f400:7eaa::605] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz6L8-00FMox-87
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 00:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMB54lQ4L+E2tH8FT8rOtYrH9weaEmZWW8zQb7rLU+Gv+r800Fy2c7wCpHGBKLIx683KMcvXwo7WxOc88I8TlvRaTf2vWQwPW930XxNGnbrAhWfpj0V9Il3Co6Y23QU5U0wwdMpM4vH0AW8+8IWtyP4/bxbAw+p2iGp4SPDe2iIsQOSr7DxGED52j5HexF/aevotemOiFEnAGccDZzMe12uTuuSYkBf0bOxQBLweWwdm6nUtYe6X5V5RmWwLTcRQyoOoTeZCgBlK4QG3XWzoo+jd2OyxrCWLApG4er2A/AB+DR0iIA2z0YYqr36Bxp6xuI9WyZeluS1Av9bWyPyWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8apDoOKN1iTEGKOLUiFOpQUNQV6iWixX+fJHy14kOnA=;
 b=NEeXMMZ8Y6i5jt97A8cZQf3U0pyz4m29Z/9P79jsKNlsD8zhepJnkkQRemfthIWFJOoAg04RQ5B3jLTXgU/wkA6Y1I7jtac8PT/mpdSaSS0tma3UI/IZOLIQjcYMr+foSHNuPNu8JECxBuCixftAUkKpSwjokuQpzYt9DK5PN1y/kNngHqn8pJAzyvQrQt4w1Ym/zEogkoTklb6VV3GgGKCzOXRHpIaAqE578jzCFTTm/VeRiZrIKqrZyDxDbOeQ+xhhf57cktMNWb2++8AwzOukpdAXC1yEJ4NotcqEAtGfrnBVCJ19XUYJZ/loiB/rSAr+R5GsVqF+JtLNcCCIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8apDoOKN1iTEGKOLUiFOpQUNQV6iWixX+fJHy14kOnA=;
 b=E8O8Sna2AbXS+t807B/zvZ2kEsuFOdpmc9TFdRjT7SQFK85EglQ5md0Z6DWc3C+z/rs90BwFPffreEh7naKDemTGRJ0QPnn2OfWkY4l9F2RboHzAdoK/DY2COTujYpwT1cEq+/rpRn5Nx8+R9NW7mZxokHC/dTK3QIZ+mPT2qft7S6bUXSODeKnm0LO5T8J0PprbuEHK/LwUs1HeQ8U95ZRPltZXVz7AqtDf6j98zZ+7yFehz7fvf99jU3ujaOdjFq+DCDos2gL3wtpRcGQqMeSjSwmqHUVXo4mfvhPDFznc7IcYax3MvMhdhMQkQgc4hKnGzy1FM0J9TbpQMOTJJQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 00:31:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 00:31:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jinpu Wang <jinpu.wang@ionos.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [BUG]LTS 5.10 regression NULL pointer deref in nvme_ioctl
Thread-Topic: [BUG]LTS 5.10 regression NULL pointer deref in nvme_ioctl
Thread-Index: AQHYew5AuDWU5K+iFUG70DavdJBes61GOosA
Date: Thu, 9 Jun 2022 00:31:58 +0000
Message-ID: <9d630d8c-f872-ebf5-2ccd-b7097e726ca9@nvidia.com>
References:  <CAMGffEmx1xk1MP30NTzn1tcS27Mc5fVudnkfYeqJrOxs_HYZfQ@mail.gmail.com>
In-Reply-To:  <CAMGffEmx1xk1MP30NTzn1tcS27Mc5fVudnkfYeqJrOxs_HYZfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1239939f-6ec1-4fa3-e8ad-08da49af768c
x-ms-traffictypediagnostic: DM5PR12MB2422:EE_
x-microsoft-antispam-prvs:  <DM5PR12MB2422C09C4C62723102AD5E12A3A79@DM5PR12MB2422.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  lJ2LnhYzBFCpP6J4dmtktg5+FA0812R177AuXCGAOnY4cpFhCr+Rv5Daltys6jX8sL0Fa2QYEvrab+iWVGgugIBBRtJbZxZ2m85dmdBS8nI7wV1sT8Pn8YOJipE9UKOMUDKp/7oMegTD8ibL7qhpds5adkxVf2UYyoVTmF5Yl7g5wS7frwXg8E/MMGt9CgOsrnujfYJ0qJbUL/Iz1N+muk1MBCLnmbjpAZaV+Pk1rldLmMWWCboO+b+eQ85JaHgx9GI/Fsev9VLlOh6GYHTZ9Top7dVkxKw+cqHGSuYmWfEI6XspXTLWVDMTEqzBr+0ITZDuzTVSp6yx+t5ftxqwNcso6LxL8hzKaNYkTfxkypzFa7IDb1uRhFk6YwR4m0f2oGIF2lVsEpPkAtVzn42IQCS9ce2a+xlZ9SQDLZvS8m/+bbFvBOmhmyJTYPsvhuO/+KpRCcFvi1ij9cqyos0FyXzOyZ6VtDzVhUBJ7LYi9bQD36M6I7d2HSL7R2porOfId/K9kPyRW13OZgdnDgQij4Ci+YcgxCgQdk7z0BitId8bp6PB5kTOHCegwKiK4hZo9rB0VbpyXaqlvRlVhj8WSrLUv/+GOqcnfTdCVs8SvbMlnUjZEsxXkGmN4lx2fRg4QyWdejl1ISPXD4hN/RKTGqqV1JUxKBB15pywCIchEjhN1J/CcUPI0zKIMJsuiob+Sz7pSfyDSF41fYUGlKNQOVxqClx5GBnjidFT8XC90XXjL5SxJ3lJJjcrl/188gXx5TLD6L4AaL8iq7/4mlCr1Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(122000001)(31696002)(83380400001)(38070700005)(38100700002)(71200400001)(6506007)(66556008)(66446008)(66946007)(66476007)(64756008)(53546011)(76116006)(5660300002)(8676002)(508600001)(2906002)(8936002)(6486002)(36756003)(2616005)(110136005)(186003)(91956017)(6512007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TUNNbkNmVjJaNjd6QmNObHRieGZNTFdBcUxHQXNtcDVUdzl4a0NPMkpkTjM3?=
 =?utf-8?B?VFQ3L25mTmF0TWdzZUkzTG40cXoxOUNHdytITGdkbytEbVZJOTJRQTZ6RXhW?=
 =?utf-8?B?SnFOM2VRVS9lUVF5NG5xRHlnbVFhclVlcU9JZlUxNWVTdndFOXlwWmN2elNT?=
 =?utf-8?B?WmdGV3FKY3c5Wmp1RktyMU1rZ1NrVGFseWhKc2xubk13L3JXRmQ4YUpJYndW?=
 =?utf-8?B?UWErTjhuUFYzUE1ZZjBYaFhXQm5QTThvbnFtUnNBcUpaV2dNeS9MVTI5aEJi?=
 =?utf-8?B?Y0ljNUlTeGlyRU9YakRERlI1MzB4Y3VEa204Z3VjaTY5Y1k0Qzl2SG5lOS9C?=
 =?utf-8?B?aEJyeldKTXcyRnMyQ1BzTlQyM1ExSXA4Yk5oRkEzOTI3SWlOS0tLeFNRUXpW?=
 =?utf-8?B?ZG1yTVExT3U0Vzgram52U0VFOW4yYkQ5Q1h0SzU0SHpHY2hCWXpyT0FHSVpX?=
 =?utf-8?B?ZjhyYjVacVJDRDZIaDM0MHRydGlRdEEwelZRaWlpQ3RNamFMV3hHcDZlcVZB?=
 =?utf-8?B?eEhSNFBLY3MwTGxYc2FFU29ERXJOUXN6eFRUMkI4R3htM0JyTzk0eFZNUFhW?=
 =?utf-8?B?WWh6bzI4RU5DZElzeVJTZGV4OU4zOU9hRThOd1BHSUZmWjNyU2YwdStBcjA0?=
 =?utf-8?B?S3h5L09yUWpzSU56bG5HSVUrYUtCcHZOY2xnRkR0WmZURGRvS1BuWHZoSWZr?=
 =?utf-8?B?VHRUYlVYaEVNRzFJR2FyY0ttbmdEbkFXbS8va0VSQTV5OWNTa3B1SzVrZXo5?=
 =?utf-8?B?U3hSS3k2Y3J2MEpIbmJiWnNVZGU0VkpDeGE3Q2EzQjZWaG1OcWMwL081MGVz?=
 =?utf-8?B?VkNUTUx6UEVrY0s5eEVyeTNKaE9FRWsrVmNTOEhKS3NOc1NhN3RqcHdjemRa?=
 =?utf-8?B?ZWo0TzJMOWp1SFM1U1BWNjlXaEVNeW9TdFlqQmVzWG5XQVpBWkNGY3ZSUXEz?=
 =?utf-8?B?SHQvTlh3S1FGTksraUpOZUtzSjkyMHVmME82M2I0Nk5zYnJEYkY0Z0drM3ZZ?=
 =?utf-8?B?aTUyOWpSLzJWem5CWUlaNnZzbUN5T1VWSnRZa29kb0lTNWQwYnZMZEtlVGxt?=
 =?utf-8?B?K296dHkrekNMK3FSaFlnKzBoZGVSd2QrdmNyWGFFb0l4MnRncnpZUFhSa2kr?=
 =?utf-8?B?L2o4Rk05bFZTR01KSytIcXJZbjQyZG1MMGQ4VTZ3ei9mS012a3l2cEJ3eXB2?=
 =?utf-8?B?ekwzbElxazQ4aDBoVVl2REVtYTBtUUtzNW1udnNEVG90amxNL2FadUtRdWY5?=
 =?utf-8?B?c2RoK2JtTklQS20reWI0ZW1YeU0yUStZNTBLQm1rNFk3VlMwdWVqcDRaWndB?=
 =?utf-8?B?SW9aWlB4UjloUTNhTHd1K2FEUzNwTkhEZndhekJHT2xwdmJDWkk0dTdrRTdJ?=
 =?utf-8?B?NkROcmFJbURDTnorRHhXQnlnTXdzREpCeUZuckd5Z2FtZTh2MUR1aDl4SWpa?=
 =?utf-8?B?L3l6THhRYjFNN2Rrc1U4MndvRy9XelB5dVh2NmNEamxVUGVyczBETUNza2hs?=
 =?utf-8?B?YUNJeTdYVmNlNmVIWTFhVE1kTjg0c0d3YmdzWGd2bnNRaFpzZy90SUVzcXR1?=
 =?utf-8?B?VVRQdVJDZmpRY0srTHBYMm1aY2g5d0haYVpOSFBzdWV4all2YVdLSlE4YzU0?=
 =?utf-8?B?K3p4SkxrT29XQWd4dXJJNHIrU0lZOEJEcnNUK0JGdGpEdU83UTBKYUVuNXJE?=
 =?utf-8?B?dTA3aXphWjdGTWJYRkZEUWhTaGZjZVIvcTdCUnhYSFE1OThlUzBZK09jWVNi?=
 =?utf-8?B?YVpvOWZJZmIvcE9Nb2dhS3l4cjAzNml3T1NBcUs4UGdSUG15OVQ0Y0lnV2hF?=
 =?utf-8?B?azU2VnIzSjh1MGJ6cE1NTkxyNjYxTUVwaWhGbEVKZTloTXJCb00rUitJdGpD?=
 =?utf-8?B?VjBMVnRuS2VRNzNmU3BwUFZpZkNGYUgybzlZci9qV016SmJHejRrRVpzbjR3?=
 =?utf-8?B?VWNNVXpwM0ZuNXBOUmI1K0pVSDVUU25pd2RsbzJMTHhjSW10SHlLSGRSK0R6?=
 =?utf-8?B?NlVZeEJ0VTZGQ2YzQzVCQy84VTcydlVsb2JnRkJDTnk3OU9qOEpqSHI5Tjlk?=
 =?utf-8?B?cVY0ekY0TUQvVDRIRlFtSWpSbk5uUE1UU1JZTXdOallxcjJwTmVJUVlPRnZR?=
 =?utf-8?B?R1pnV0lXL2FaQWtLcFFNbTdoWDNPOUhHb0JyY2J0blVwZ2h2WVowRFhvSzlX?=
 =?utf-8?B?K0p1MGROVTlGaW43eGd1RlBtbjVDNEZkMHcwTzIzS3lzSVZNM3lOZzJqK01T?=
 =?utf-8?B?VHVkaWxwSmw3TCtqYWNxRkJFMy9LbUJPUFdCcGhKeUpxaVk0TWNEVEcrQ2F5?=
 =?utf-8?B?SDZnQ1oyREp2eHhuZG5QWkMzSGNYUFNxWkhxcXV1ZWNRdU5wd1Vua1dXeDR1?=
 =?utf-8?Q?oN9kvbxQ76SSLvbuH5KpHD5WfhGlY3PPWD8ypfAH3CbME?=
x-ms-exchange-antispam-messagedata-1: iNJXNH1QrU8kaw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B1BFD813238249B4454ED02120F58C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1239939f-6ec1-4fa3-e8ad-08da49af768c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 00:31:58.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vjtYxXfR5LXKU0WSEVRGuhgxYskzxCATbwcYsHf0CH5wjsBe7iKTc5DBl1IyQf9xTq5zYB5zym+LGqAx72g9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_174758_304846_37584478 
X-CRM114-Status: GOOD (  11.47  )
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

T24gNi84LzIyIDAxOjAyLCBKaW5wdSBXYW5nIHdyb3RlOg0KPiBIaSBmb2xrcyBvbiBudm1lIGxp
c3QsDQo+IA0KPiBXZSBoaXR0IHRoZSBmb2xsb3dpbmcgY3Jhc2ggd2hlbiBydW4gIm52bWUgbGlz
dCIgb24ga2VybmVsIDUuMTAuMTE1Og0KPiANCj4gICAgICAvYnVpbGQvaW9ub3MtbGludXgtcE9H
WHlzL2lvbm9zLWxpbnV4LTUuMTAuNDIvYXJjaC94ODYva2VybmVsL2R1bXBzdGFjay5jOg0KPiAz
NTkNCj4gDQo+ICAgIzQgW2ZmZmZhODBjN2E1YzdkMTBdIG5vX2NvbnRleHQgYXQgZmZmZmZmZmZh
NzA2MjQ2Nw0KPiANCj4gICAgICAvYnVpbGQvaW9ub3MtbGludXgtcE9HWHlzL2lvbm9zLWxpbnV4
LTUuMTAuNDIvYXJjaC94ODYvbW0vZmF1bHQuYzogNzU0DQo+IA0KPiAgICM1IFtmZmZmYTgwYzdh
NWM3ZDc4XSBleGNfcGFnZV9mYXVsdCBhdCBmZmZmZmZmZmE3N2M5MTllDQo+IA0KPiAgICAgIC9i
dWlsZC9pb25vcy1saW51eC1wT0dYeXMvaW9ub3MtbGludXgtNS4xMC40Mi9hcmNoL3g4Ni9tbS9m
YXVsdC5jOiAxMzI3DQo+IA0KPiAgICM2IFtmZmZmYTgwYzdhNWM3ZGQwXSBhc21fZXhjX3BhZ2Vf
ZmF1bHQgYXQgZmZmZmZmZmZhNzgwMGE2ZQ0KPiANCj4gICAgICAvYnVpbGQvaW9ub3MtbGludXgt
cE9HWHlzL2lvbm9zLWxpbnV4LTUuMTAuNDIvLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRlbnRy
eS5oOg0KPiA1NzENCj4gDQo+ICAgIzcgW2ZmZmZhODBjN2E1YzdlNThdIG52bWVfaW9jdGwgYXQg
ZmZmZmZmZmZjMTBjMTAzOCBbbnZtZV9jb3JlXQ0KPiANCj4gICAgICAvYnVpbGQvaW9ub3MtbGlu
dXgtcE9HWHlzL2lvbm9zLWxpbnV4LTUuMTAuNDIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oOiA2
MDkNCj4gDQo+ICAgIzggW2ZmZmZhODBjN2E1YzdlYzBdIGJsa2Rldl9pb2N0bCBhdCBmZmZmZmZm
ZmE3M2Y2YmM1DQo+IA0KPiAgICAgIC9idWlsZC9pb25vcy1saW51eC1wT0dYeXMvaW9ub3MtbGlu
dXgtNS4xMC40Mi9ibG9jay9pb2N0bC5jOiAyMzcNCj4gDQo+ICAgIzkgW2ZmZmZhODBjN2E1Yzdm
MDhdIGJsb2NrX2lvY3RsIGF0IGZmZmZmZmZmYTcyYzMzMjkNCj4gDQo+ICAgICAgL2J1aWxkL2lv
bm9zLWxpbnV4LXBPR1h5cy9pb25vcy1saW51eC01LjEwLjQyL2ZzL2Jsb2NrX2Rldi5jOiAxODkz
DQo+IA0KPiAjMTAgW2ZmZmZhODBjN2E1YzdmMTBdIF9feDY0X3N5c19pb2N0bCBhdCBmZmZmZmZm
ZmE3MjkyZmU0DQo+IA0KPiAgICAgIC9idWlsZC9pb25vcy1saW51eC1wT0dYeXMvaW9ub3MtbGlu
dXgtNS4xMC40Mi9mcy9pb2N0bC5jOiA0OQ0KPiANCj4gDQo+IA0KPiA2MDcgc3RhdGljIGlubGlu
ZSB2b2lkIG52bWVfZ2V0X2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gDQo+IDYwOCB7
DQo+IA0KPiA2MDkgICAgICAgICBnZXRfZGV2aWNlKGN0cmwtPmRldmljZSk7DQo+IA0KPiA2MTAg
fQ0KPiBUaGUgc2FtZSBjb21tYW5kcyB3b3JrcyBvbiBrZXJuZWwgNS40Lg0KPiANCj4ga2VybmVs
IDUuMTAgcGFuaWMgd2hpbGUgcHJvY2Vzc2luZyBudm1lMiB3aGljaCBpcyAgYSBiaXQgZGlmZmVy
ZW50Lg0KPiANCg0KRGlkIHlvdSB0cnkgaWYgaXQgd29ya3Mgb24gdGhlIGxhdGVzdCBrZXJuZWwg
Pw0KDQotY2sNCg0KDQo=

