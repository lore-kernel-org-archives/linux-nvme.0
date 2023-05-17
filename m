Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC0CC77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIQ5xt5+yjudLSnrM3xmBtLOIk1m0Vz9FaczeG1iqhI=; b=hFa0jlCwVtOs8JgDfOwPCify/+
	t52Kz44Dio+0ybvVjL+olz8UPDd94vDVc0V/Fz8sv75D5yiSdQDQdFAPmDvNwDla6WOvqbxdm82oT
	NHHsbRgMFVKHskHLxa0hm+Ra2w5D8qTtICWyZb9PQRvqeKUH2/FCJwdd71D34lSh7blQlUhq8Veih
	2bNDqIEk04nq2Bhp7gq5Wq6ORc5j7EKS0v2bvC7mJ+B4xhkZYzHdoqNOcA55DpgyqfFtaoX2scJ8p
	V45VtjjGrhAUqkgxbXIplp9OfO2MSvq7WmZvwsYUPqoZGsMN/Ir99QQjAlqn32u41ilBaBJ2iL2zL
	iCH3ys8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzC0n-008kra-2L;
	Wed, 17 May 2023 07:55:53 +0000
Received: from mail-dm6nam12on2061d.outbound.protection.outlook.com ([2a01:111:f400:fe59::61d] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzC0l-008kpy-0n
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4Xfyf23eROrhaZeEh+ZGzK+zX4fljyG7DYwP8loZOEg+J32wRFPb/mhz1aWCk04EptbBreLlxW4UgJIKurvwd4Fdq8LWZm99vgTGx6oW+IjTJMVRdqhZ95J5uLYkhI4ei93IhdHKmmY8bYVdhYqy+raCZktG47CKlVXZ3YbyQ9JpIgNpQgEutzW4chSjoYRhSy4ftbAvyKTUQ98sUZ4/CQi9gDzdjG10W9/heNcOQkXM8i68TGyLoELEfB39tblwIgeVVszGM4Nh58YmkTmdVMAjCHIIWKh7xNUsKnlKGmzDnr/ZBFlLDcgILKvCviPwROMUjOYjwACb7lwKZ19xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIQ5xt5+yjudLSnrM3xmBtLOIk1m0Vz9FaczeG1iqhI=;
 b=DQmuBnu+GV59MLkG9rwPU1kvxIPYufvPx69SbeusXfJJnye2CJ0Kg/Ththi/Obn+a/8n+RmQVbJ4EQYBH2QeOsknx4ecNRbzrCeZvqAJc3uFtdIBOngq82QeSKBCTFclsa3HOFs7VhyRR9PUVRyALty7iThoSHA2EBomczU67rbmhhqUTuXGCCDwGy8KA6Q+DtDcn/exlJWe5GDdfhS6vEvOsy7mF4JoowZ/pYBw+s/bGUSWCGCTaslKnMLWfBLMk8F8Yd5AmwIwNCVV1noRljAT1SQm+xfvlkKYKSUo/ZKqPYZKxFTQtqIOqfY4X8YycILXCSqN8HlAtecB8oZBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIQ5xt5+yjudLSnrM3xmBtLOIk1m0Vz9FaczeG1iqhI=;
 b=ThTy9QIKF/bnFohT41ViuKor+XwevpYVJzMlnct1zefT+qPhiKcfR2yIFCRfSOYNR0itrXjGJHozrjbJ8K6R4xvF3YIIy2/dj07cZ/V0OPdWWdgQXRcmCKSKIS2xAYwmmPN5oCPrah8E4Yj7UQMbpgekU5QB03G4IBNT8QUl1kS5tsDihoC7l7OOJbndZbARrM+iQvksEQOOt+oE5Fb9+pxwAHQqz65GXJogjVEjzkHwVxIrefGpYLoKXz8a1K6YL7YKd829gJG90hxDKXsBQl2MZUyKMp20JSra8zet00guGWOXtIGt+XWAg5ep+yxU3rfdacxuIJrNz/zXYid7uQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:55:47 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742%3]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:55:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ch@lst.de" <ch@lst.de>
Subject: Re: [RFC PATCH] nvme-core: add helper to get nvme_ctrl from device
Thread-Topic: [RFC PATCH] nvme-core: add helper to get nvme_ctrl from device
Thread-Index: AQHZhKrjpZabGiR68kiusbReAJoDvK9eFJWAgAAMDgA=
Date: Wed, 17 May 2023 07:55:46 +0000
Message-ID: <4c52ac51-73fd-97c5-4bfc-7e897dc9e73a@nvidia.com>
References: <20230512082206.4788-1-kch@nvidia.com>
 <0b182e1b-e267-81da-dbda-95ea04ade338@grimberg.me>
In-Reply-To: <0b182e1b-e267-81da-dbda-95ea04ade338@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|CH3PR12MB8970:EE_
x-ms-office365-filtering-correlation-id: 0345069c-c67c-4a8e-1093-08db56ac1fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8pqXF7yMf6yjs6srmD5eoeU/zQkldygTYQYBECFQUEJOmmYxg0ikERx44nwTk+KuhZ0YZRCA3yrDd9mbC+RTBGTatpHfAGij5mqXYQccD2UKRIyK7xvM0lCZlrYVvw2MOi7tj5YxYXp8uDYHTd7F01y/XEAcl9Si0sU3W+LswBKKhMQ7jefvceHyjoRX/nJHrzbc38bg9aqYXv7t6wOruweyfEijflMfZgK/tWImATLJbjsBRST9+tZxunw0jePWu1RpiewaNRAY6MwI3eaAgNf5fIzSkh7nM3ntVXJuSNnOJao08yDH8NqLFbxrkR0HqqtTSMsMkfg2X/jxgTOJ0zdDNwHT8DDJrPHjtjwn6b63etj3hWiBYYwdFwyHHoTdNjWGHbDkAnwuNM7N6cOkZaqOHu0Uqp4Xb6pTwP50eP8NZN+jdZsHFaVDmdvHnabSTvSQkNH3dIVxzQEcTbBLRoCHrr91ixJR7atymmYiZl1G8haV8qH+Jkpz8cyYhaSVSq+BdUq8OVR1SCbbUFHwZIuSeMXLZyDp6VAI17OmXg1e4rXMMSvFOPODBmEy/JCiJbMviFljpFP1cM8xZpJBBHwjMz4d6bRNmNlSLLX5YdwLrdSYGqt/S5MCi3OdEJli0J/+SX3zEMgQvg0KhPh/My1Ip9YCpvYbjfnVqAfmNRfrkczp3qs0qjTTYyUf8RJT
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(6512007)(66446008)(66476007)(54906003)(91956017)(66556008)(4326008)(66946007)(64756008)(478600001)(110136005)(76116006)(316002)(71200400001)(6486002)(2906002)(8936002)(8676002)(5660300002)(4744005)(31696002)(122000001)(41300700001)(86362001)(36756003)(38100700002)(38070700005)(83380400001)(2616005)(186003)(6506007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QW9wNnZxd0hYT0l4RWR3dDlrcXkxL1ZXQXVVWWNpL3RWem9hR2N1L2xnaUFl?=
 =?utf-8?B?MzJnazh5N0U4b21wTGtuaER2bk1QdVVaSGlkVE4rOUNiZVpvVG4raDdWQndN?=
 =?utf-8?B?ODNVb2NUa0dlTlkzcU1MOTA4ajJ3Z0ZQVFFzN3RLRWQwSHdmRTZVTG5xVGdH?=
 =?utf-8?B?elp3aGpWYWV0YWRQRUs3S09FZ1UyZEJXa0FaYTJYaWxZcVM3SzkyK0JWTFFs?=
 =?utf-8?B?Vk9JK2Nic2hsQmRYcDR0RXBya3lROU1RUDJ6QkZJR2g5cmtnbFFSYWgwUDQx?=
 =?utf-8?B?RmREYnEweHFBS2lEMlhWNFhLZVNrZ3BGV2hGNDRrcWU1U0lOWk9WeXlKQUs0?=
 =?utf-8?B?YTlIb0ZWdUVucnRjZjdDeTBIdDB3YXlwVUlSamlJdi9lZ2t1eEtVeEZmeXY0?=
 =?utf-8?B?WDhsZ0E4OFFGTlJDa3lXczkzTjJjWEhnSEpjWVlkaytqZlpjd2hXR1d0K3hQ?=
 =?utf-8?B?SnZJbUZ3eWprZzBKSEhhVWF0bTJQZWFCWDFUREhCWVdYb1JyTUZ2YUpReWdn?=
 =?utf-8?B?SDFmcVF5QU9icnlpQmdKcXhiRzZNREVxbEEvZHZ5N1VkYWRlSENXTytlZDRj?=
 =?utf-8?B?a1o3SEoyMGY5M294dkl5bHZZQ2Q2UUp6eG1zUmtpU3hjMVJyWGxwVGo1SUF2?=
 =?utf-8?B?STcwK1VBMzMxaUp3WGdXMnJiYzh1UnEyVFlaZ1lMMHRLMnQzZVQwenZ6YWsx?=
 =?utf-8?B?K3Q3OHhjaERpcEFXQlZnV1BBQVF1ZVhJWGdwbnlySWc1d3o3c1U3Sm4rZlNG?=
 =?utf-8?B?ZUsvcjA2d0ZXZ0hKUGZtMHVIN3hjVUZYdFVRbVdBVS82T0RpekJiZWo2U3NB?=
 =?utf-8?B?Wkt4eC82TGh6cjg4Wm15emxKbUUzbmM1TEkwTTdGWnY1aFN2R2t4M3BmSURJ?=
 =?utf-8?B?bUlNNXl0MkppVm9vTlhCRHNsbjB3RVVtQUFmMDhLMXQ4OUU4VmNwWExyalZ1?=
 =?utf-8?B?OHVUcndaRXBDdDV1S0hHTGtOZlplS1ZTQ2F2ekNxV0NYOTdlQjQ2YlZFdFk4?=
 =?utf-8?B?VWZ3eHA1YlFQY0MrZHdReG12VFYvU2ZFdVRtbVExUThNclFEekRrbUZqeXNu?=
 =?utf-8?B?OVRhWFhSTUlmOCs1M2tRd2diZEZGYXdIelFCcTRTS1JBUTk2L1NOTmNZOGNX?=
 =?utf-8?B?ZlFsNURVcDltOUE5c2N3ajZLWFYwV1hEZnlqdURrKzhBdTQrVTU5M0hBNTBS?=
 =?utf-8?B?SlBKWUxRY2ZsV0lhM1dJUW5DSWMxZ0lVNUFSNWlGME1QMWdHUDFkSHhHK2ZJ?=
 =?utf-8?B?U0JhY3RweEprNnNZOWZNM05jUUV5bzdxYUNKRkNTL0JFK3FzMFJFZlNNV3A1?=
 =?utf-8?B?NHZRWng2QlA2Y2pwWVg4S2s2L3RXclcvc1NCZkVxSzYxNW9DYlVzK0h2SHla?=
 =?utf-8?B?Ykp3MUZtSWVIaVFUL1ZXZVdhb0hTMHpURk1MdFBoemtSVEwxbk5yUHJCejA5?=
 =?utf-8?B?TEgreHNkdVNpTnVnc28xdUZyeGgzYUdRdDdSaVc5akpZTnRWdVJUV1ZCRFNO?=
 =?utf-8?B?OVhLZ01NMVJIM2pJaHhqMVdmQjlsUDNoa1hJMlNHTEUxdkVVMlJ6eUx2eTls?=
 =?utf-8?B?TjZiQTA2WllHQ3RQU1NSZEsrUjNOVndoekdoZkY4TmVsbGNhMk10SlRJanBY?=
 =?utf-8?B?NElqZzl5R09BZFZQUStrVzdxdGdDRFZnV3RMZ0ZFVXg5UlBMSXFuS2Z3L3c1?=
 =?utf-8?B?eUs0Y2V2ODNOenljRDVqanJwdHdnUkhIdnNHTTVsRFlIOWt1WTVzaXNQR0xv?=
 =?utf-8?B?ai9FU1RNd0dPRUhqOHRUbk0yS1U1S1ZFWk1lZDZRMmdkWGxQVU9LVjlqQUdF?=
 =?utf-8?B?MDQ2UWFSRUhhZmlPSDZESXJmanJTWFQvc1JzYktjMllhclIrNDZUc0VZNWZW?=
 =?utf-8?B?c2cxOHdWeTN0L1UxSFRFSjZZNFhRMjcwM0x4bis4cjJnc1BCc1I5emI4UEx1?=
 =?utf-8?B?ODByQS9XRUl2QTVFemU5QmJERzVvWDJwOENYaHo1M1JuZG16c2E1N0FBT0RI?=
 =?utf-8?B?ZitiNGFjKzYveU9WRi9WNVA5Y1JzRTg0REFSZHI5VDIyaStDYXJTM2VTcjNY?=
 =?utf-8?B?SlZKMW5Nd1BOQ1RMM3hHSC9keGo1SDdHZHduaUpIWldFdHR0VEdZdnVEdWh4?=
 =?utf-8?B?ek53WjJHU0U2NkVsVXZReFVOcHhOWGxSbVNROHg0ejB1SXdSYTVYUHEyNEtl?=
 =?utf-8?Q?PDq3zR6rp2LghorUP0U4WIQ58/gI8EhfDHA5ZM+BZtY3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A61A20207A390C468FFF5B714D41C046@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0345069c-c67c-4a8e-1093-08db56ac1fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 07:55:46.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKLtwevFqP6PFga8sx3KAtmawDTieLWXd1FR3lfhqrz7aiulKbjtA6EUUXd2z4fsKZ7eUzBh6LrMgIk+aBHB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_005551_282459_AC9BE11D 
X-CRM114-Status: GOOD (  15.38  )
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

SGkgU2FnaSwNCg0KT24gNS8xNy8yMyAwMDoxMiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4+
IEp1c3QgbGlrZSB3ZSBoYXZlIG90aGVyIGhlbHBlcnMgdG9fbnZtZXRfcG9ydCgpLCB0b19udm1l
dF9ucygpLA0KPj4gYW5hX2dyb3Vwc190b19wb3J0KCkgYW5kIHRvX252bWV0X25zKCksIGFkZCBh
IGhlbHBlciB0byBnZXQgbnZtZV9jdHINCj4+IGZyb20gc3RydWN0IGRldmljZS4NCj4NCj4gSSBk
b24ndCB0aGluayB0aGlzIGlzIHZlcnkgdXNlZnVsLg0KDQppdCdzIHRoZSBzYW1lIHBhdHRlcm4g
d2UgaGF2ZSB1c2VkIGV2ZXJ5d2hlcmUgaW4gdGhlIG52bWUgY29kZSwNCkkgZGlkIG5vdCBpbnZl
bnQgYW55dGhpbmcgbmV3IGhlcmUgLi4uDQoNCj4+IE5vdGUgdGhhdCB0aGlzIHJlbW92ZXMgdGhl
IGJ1bmNoIG9mIG52bWVfY3RybCBkZWNsYXJhdGlvbiBjb2RlIHRoYXQgaXMNCj4+IG5lZWRlZCB0
byBnZXQgdGhlIG52bWVfY3RybCBmcm9tIHN0cnVjdCBkZXZpY2UgaW4gdGhlIGhvc3QvY29yZS5j
Lg0KPj4gRm9sbG93d2luZyBpcyB0aGUgZGlmZiA6LQ0KPg0KPiBJdCBkb2Vzbid0IG1ha2UgaXQg
ZWFzaWVyIG9uIG15IGV5ZXMuLi4NCj4NCg0KSSBmYWlsZWQgdG8gdW5kZXJzdGFuZCBob3cgdGhp
cyBpcyBkaWZmZXJlbnQgZnJvbSBleGFtcGxlcyBtZW50aW9uZWQgYWJvdmUNCndoaWNoIGFyZSBw
YXJ0IG9mIGV4aXN0aW5nIGNvZGUgcmVkdWNpbmcgfjIwIGxpbmVzIGluIGN1cnJlbnQgY29kZSBh
bmQNCmZ1dHVyZSBjb2RlIGZvciBhIHZhcmlhYmxlIGRlY2xhcmF0aW9uIHRoYXQgaXMgb25seSBh
Y2Nlc3NlZCBvbmNlID8NCg0KLWNrDQoNClsxXSBkaWZmc3RhdDotDQoNCiDCoCBkcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgfCA2OSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogwqAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygt
KQ0KDQoNCg==

