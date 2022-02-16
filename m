Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E91AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HemLjNHb6UAj5NzYShY5WqGLzjpCmKSHCb3RCL7eUOA=; b=Kvz5tKlPv1TbMkh1Jilbfug9AE
	uUglqYmyh1lKaY1mmQC7v0M3k/NXfkklbor1HE1+n3zjtjXNZF6qyA5C6a1Yn6z+hZzFKQHY8Sj+8
	doOCPJbBvnHmeQbTbmwuDaJb8FiK5x+Ye+ucabGZjrjC7FXOSHjOCphatH0HPxJCNHdWRLLjn8AEn
	i7uiVeZqzBAwRqWe7enfZSlWzQryK3MIep5g+64sboSQT6LjsTublHAGQxaX9iO+WRiFnCpzgoHV2
	QAo7ajzAu5uYk5RrUWMJIX5mVqplmtV79L/Ib8JALeDwMhrLtcOUWxIUXh8SQ+OJWMVtyRDAjcjY3
	l7KBm6zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKGTN-006ICx-AC; Wed, 16 Feb 2022 09:19:41 +0000
Received: from mail-bn8nam12on20621.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::621]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKGTL-006IBa-3D
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 09:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcwU14C9RbvbI5ynBFirmkIBjPaa2uoTMJXxoiAvP72a99/HCvu6mEed1wPhPnWnFTFnKGiNEUMaYvog5RPWM/FTHZWEaMuucShLMnLWJWmNDwKowvM1c8rNkr1eRdUH5WTFy0vdXfowa4t+0L+5ujZbnvuybBg9RGBvdwy+ROh5upNqcdQD14CAa38ty+xgCd6e+zBo67Li8l6eX2W6BA77p0UNspLL0oHeEwY05b6/keuqX/cjxRcV0dB0dUFw2dxGVsyxDpEwjKmGUNyWUc04HKbtoDdK0ki6f7NPpOX4sAslDCi3M4bew4Bd4z0DQyQ2L0sk0ZQUvd3XxvYxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HemLjNHb6UAj5NzYShY5WqGLzjpCmKSHCb3RCL7eUOA=;
 b=Zv8eS89Xtv4asN4woEWe8lNYDyU4RYrz3MSevAeu6UcJwpNDfXhVOBGIYHa82DjHtJjpgnHuN/aD637NTOURZwtVBUxF9K1DGtK14gtfB9LXvoEaXN/M7OvKJSgYI1BPa8wsZRxXDLDO+ffknqLblvIbpHemb32DIdlmodNwsPXMLFL84uU6r7TpgRI4w2qvpzLQQctmN23RIOZcrPxmxjpTi/YlN+G3AtTcIoaB98KGFR2Z6I7j5Kn3rwLGwEcJykGOILLmXC66tCA+yqh5HmEr68bCo2hHYlDrpD+wOB4XmIHU3WHCY/9cS1DCiJHoTujER1sA6HQ3czuRVKmKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HemLjNHb6UAj5NzYShY5WqGLzjpCmKSHCb3RCL7eUOA=;
 b=F4ngwIXAvJGTzEZR4y8gcb+NzqLtEICHYIeubH+GJ9VBHIxyYvx1eauJnGm0XrTRdf2ONgR0+JP+k7o1xGvjW/uqzhrlRv8jIoO/rG947tqQJiRuCzUlWo9AlieyQxel3QOs40dnU6+7F3vBP0snAZQMEJwDFombIdlAcU4ZdsUn0C3spX+SnIjBSq8tZyKZ73DHObqbjeUgM1RCtQz+dl1o2lhplEog9io4cmBOBGaM+lAkOuknDU79sD3boc2jrUr201Vcx9fUjpg29Ncm9itMSamYudeoJmnlzF3R09eQ9DB/piYVAj9ukfd+0NtavP4va/tklSIQBPuetmCblw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:19:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:19:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V7 0/1] nvme: add verbose error logging
Thread-Topic: [PATCH V7 0/1] nvme: add verbose error logging
Thread-Index: AQHYGNXKscLwt7z9hUybaRybLtIYjayV5RKAgAAV4oA=
Date: Wed, 16 Feb 2022 09:19:35 +0000
Message-ID: <25d819e7-7cf5-2244-1550-7df10c3f049a@nvidia.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220216080115.GA10554@lst.de>
In-Reply-To: <20220216080115.GA10554@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd20d537-c353-45ed-d27e-08d9f12d7362
x-ms-traffictypediagnostic: SA0PR12MB4575:EE_
x-microsoft-antispam-prvs: <SA0PR12MB4575FA56A889D5F525124AD2A3359@SA0PR12MB4575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQo8DD66LBkFmgRhb3I/3a9nOBK5ZFvmiJz0bvcX+Bdc1fK9IvgdgbSM7P+hKmXCmDpLJSjbz/vVskQFw+Q1AVqra/PwZbkhG546XevC5m4oghuLQ4fCKHd7K4Yqj1l6IbVlgAuWtZZ09zPT4eqUN339zCqJ07b4fL5EndGEYIpKOg1INRQYBAXWu76PlE0+clFtypLRW9dT7sC8VhXMF98uItJxGlqHvklguPRe+VrvUNcqFXxt0z/kVKCo/HZ/bpNaNM6oAnBuKfUg/akJjoetMLZOYnuBIKMf67kP69OxARpaLkiux6YADtuNms0spAOy8T+VvGRp4W7F6CRpV5ksV+6eatWKYQWzN/MdT+Oz+Cbpx9avzQbqQa9Ay/tVaTY8l3/HqhReYycLaiNcUhedxwnlxOgNegtbO2RxcpW1GcUFJXTbW9nrRL8aDzwYbJJN5JaoFM6VSf0AS7M+Plu867dwljYWTo+WxlyFwwcxpsHCLFYFp9atTM2u4LbBmYBKaRVGbdEEr1W6RUDdsNInbosqWYP72YrbNKOkzUC4aGBp5vSXUsl7186SYgmYe/GdYQ7kXcdU5EeL/418iFTbuLOrzs5+4WO78SG3A8lRB8Nz4L7UyHw0kLkfSILGm+QiYvpRa80lb59foDnVWRzGw3SJeGjk9iBM6PZ9pTgOj2KEFUo1EjvIy35d4R6ridn319DYfjEJedv8iC2Nie7gs5b1bzMuUskc8NE1K7tIpSa2zVKH/qW6HTBtS75VSpHI6hWJ+u4AWA1d1PFngA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(186003)(2616005)(83380400001)(122000001)(36756003)(71200400001)(66946007)(316002)(91956017)(76116006)(508600001)(6506007)(6486002)(558084003)(6916009)(2906002)(66556008)(66446008)(31696002)(53546011)(6512007)(66476007)(4326008)(64756008)(8676002)(5660300002)(31686004)(8936002)(38070700005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW1tazBRVS9NUWlsZ1B0UDVhR2NmeDdzdmwreUhQU3BFejZLN1V5QmpLUXVt?=
 =?utf-8?B?TE15T2R1Rk51TmtmRkJDcDgzTjlPdHUzamp4ZW9lbE5uVzc3R1JhSGNGNHor?=
 =?utf-8?B?TUJjeGtMdEJZMGNQRmNITlpHdjlsRE9ReElGNnNSd3IrZTNMWE9NTEg5bVo2?=
 =?utf-8?B?SlkvUWVyTHE2d09hbHpxUkdHRVdoa05neFYzdnUyMks3SkhyQll2WC9CTVVn?=
 =?utf-8?B?S25Bck9CWW9JMERMVVQ1Ykd4U3F1TDA2MGdSQnQ3VjFrZ1FpK0NPL2dPcjVn?=
 =?utf-8?B?NEI2Q29MeERCeURNVGFWRG1sK1NEUWlMT25BSDlCV2JpSjFRaXdNeFR6WXpo?=
 =?utf-8?B?MkpoTGhRM0RxSEgraHRqTG85MnM2MjJiYitqOGNOcEhpRG9tbEE3bVV2WXo1?=
 =?utf-8?B?L1pBNVVRNERxNmdqdVM3Tm5CQnVkQjNUMnpxVGdvQllwQnM0QVZ6RlhDejRx?=
 =?utf-8?B?ZHJlZUl1TE5rQi83ckc0TTNmY3piL005bFUvaGVsdmNzTTcxSmcyTVZTaU1h?=
 =?utf-8?B?cGVXNjh1NGVXUVpHbyt4eFpXTWowMW4zVHhiWm1tc0ZTVStrOHQ0Ky82ajE1?=
 =?utf-8?B?dnhoeVRneGxjejdkWkJmcDJKRXNDVjhTbTJ1OTJYcHppTDRLWVBuU3VPNnZh?=
 =?utf-8?B?aitQZDdUK0lsazBad3p0NVRVWDBnSzJ5MWRSVXdyZGMrZ1FoNkFrWDJqOEEx?=
 =?utf-8?B?eVNtb2NHOU1ybm1EK2QzS0N6QkxZTTBzZ1M1eG13QkZmM1lJVi8vb29heC9k?=
 =?utf-8?B?YjNYQ1hlazZNSStBQ3hoODl4OW1qTGJmNU1LK0tGNS9mUWV0Vlp5T2V0c3E1?=
 =?utf-8?B?SUt0S2pIN2F3bUp4cEZVZlAwZHRWemhSMVRuNGdGOGgvL1VJcHdaazBCckNW?=
 =?utf-8?B?ck9JeW14Vll3bTRTaHZCT0UrNnNoZHdsL212V1pLcmpkWjB4YWxXMzhZWmts?=
 =?utf-8?B?K24yMy9CUDRpLzlMdFIvRkkxTmFiR2pnZlp1ZHBwUFo2a0dQUjRaNHc4cjF2?=
 =?utf-8?B?K2hjTDhDRDc3MmE3NUdzd1pWOGE5MjdKOFV1L0ZWT2xkLzUyS1d3akNsVDJn?=
 =?utf-8?B?MjBTWlp4Z3dpMGJPMUdLV3VHRFVjSncrTHlkSUMyVzc2LzJTOUw5NUNCaytY?=
 =?utf-8?B?c2xqVUc3amxKVTk4NzdhZnA2STVzOVNjb1lHeUhucEU1a3F5aGcvcGh1VDZ3?=
 =?utf-8?B?ODA3NjJxVGpJYUYrbzcxWUJiZnlrcHZPWElqa211MHdHZlljc0RIUHFYOWJr?=
 =?utf-8?B?VEJFZXNISjZZcGVPVHhEeWRUWndsV1hnMXpJYlgwSXFYTHNoUnl4MFhVOVpG?=
 =?utf-8?B?S2h5ZEptQlJvUGJWQUwvck5zMTl6T21KT0h4WUNRT3ZXaFc2UG1vS1llZldX?=
 =?utf-8?B?N0N5YzU2bjdvT2RmSmtDc1p2eWMyd3lNL3ZzTm5IU3hVdG9SVXlIYjVYV3ds?=
 =?utf-8?B?V1ZNeEdXbnFObE8wcXpXUllHTWFNK3E0UzIxNzlMa09Cc0xvSjZacXBFMW9I?=
 =?utf-8?B?a0s4YWM1TTZGNGZQbTFJakFEeDd6NTJ6WXN0Q0p4ZnQ4QW0wN09xc3NtRlhy?=
 =?utf-8?B?bEEwRG90SUdub3FXVjVTMGNWRk03eG5Xbk4zZi9pZ3R6L09lclNPQ3J1UW05?=
 =?utf-8?B?RXRTNU0vZDgyVVlQSHdndFBObXY2Y29MVUpCcktGUGw2dzJLa3JKNjFnS3Jy?=
 =?utf-8?B?UTRwZzdCbVExNE1Gc1YyVFZtM1gyRUFDMEhzeUxNK1VETm92eVk4OThoNWRj?=
 =?utf-8?B?dWNTSGYvUEc2cjh4WEdYS1dFNGNMbWk3cStuNk1NbmQ1YjJDZzkxYW9WaUx6?=
 =?utf-8?B?YkFqaTIyYnRrUDhwRWRRNXVGWFVQd1ZJaytJWk9ZMzdVQU9GdjlwS2ZkSHZk?=
 =?utf-8?B?Ymd6cmN4UGt2eGU5OHBtNTVXR0hSSXlOK3NWekQ4RFZUS3VUKzNqUzluY2F3?=
 =?utf-8?B?cEIvendWSExURHJSdTJVTXNJK1o5T1diZFkvSzZydHdNbysvMjVpaVJGb09R?=
 =?utf-8?B?bGlGZXRwamNmM1Y3SEN6ZWEycEl2Rml2ZHhtSHpXdnk1TU5XSnFjaUFiRE1S?=
 =?utf-8?B?WXF3NGhuSnAwd0V1NEczVmFaZERkNWwrK2VzTFYrSEgzRFBEUnRRZUEvSnJY?=
 =?utf-8?B?WE44VUo3MHBUVnpVZ2w0WHhVWmhrZFJmS0hXK3hOU2JiNVdBTUU3UStJZWUv?=
 =?utf-8?B?eVJsREpDRGZmM2tLMmdmSWV2R1Z6aU5iSCt5TU5KN200ajNzem93bDNyMDlZ?=
 =?utf-8?Q?bVjJX6IXTXxdTz23DiAwW1owKlKRtqwDNybH6S9Bdw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47041542857A1F488F466DE3EA36D2D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd20d537-c353-45ed-d27e-08d9f12d7362
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:19:35.9908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLx+ECCpWHnharkxBNB+xB6JBHz0dxP4sDQfVe+SMGFc6goAGtCOb/7zuPJG3oizpWtmG46dll0cNk9biF6ztQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_011939_162946_E57C3D55 
X-CRM114-Status: GOOD (  10.20  )
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

QWxhbiwNCg0KT24gMi8xNi8yMiAwMDowMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRo
YW5rcywNCj4gDQo+IGFwcGxpZWQgdG8gbnZtZS01LjE4Lg0KPiANCg0KQ2FuIHlvdSBwbGVhc2Ug
d3JpdGUgYSBibG9jayB0ZXN0cyBmb3IgdGhpcyA/DQoNCi1jaw0KDQoNCg==

