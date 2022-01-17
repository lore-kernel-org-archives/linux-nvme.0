Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jan 2022 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3R8aVrDqadf5OcizvpoH9+HJv82y70yuloaOksn9uKQ=; b=Z1CpvD7ouVqj6h0819KQe4uWUL
	FIXY0MunvR3YIWXq9MyZAZboEj7YDrBhJ09RQ5rT7QWR0vNIo8pR1xIZZz4ySQUkqbrCYdgwqNfin
	In50kI9Mr4kJ1vC0qDhowsemmFcNOm5vX4pRb6FqkIZirtYCLs/D8UqUkpxfjU6+F5grTpeBjxwm1
	nLW3EUL7Tktu3AjbUdadDqc2YCC63Qxax25RmtOQMLC8KzBl3cA0WQCzswfvyDgbP29LphJlUfPxo
	plEYEpx2Yhb4MPyXxnzMO4DUdZm6EHdc8DTuFB1r5augg40es0YJG3ZqDmluN1Lwn1n9z0heYCVbs
	URlU7QnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9Nip-00E9gp-Cn; Mon, 17 Jan 2022 08:50:39 +0000
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com
 ([40.107.243.81] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9Nij-00E9fD-Bd
 for linux-nvme@lists.infradead.org; Mon, 17 Jan 2022 08:50:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNj6gcKmd/vbk0Nd9nhKnEdtBexGffHX6en6apqcc0YfwuM/JaJQIgWVPbjHxtWJyQ3PAiTB0NthqVxJ8RBh6DpbJE1PoN2NOpDVN/PlVGMhoCtkStQx4UFkgT5wRp2jhhT8UITaPKrKjA7xfG+Zf2cCW8fBELmXrNser9FAfVSO0XoM8nZPWANYSjEqQNZgP6dA2g5tw/4cvfhrzISMknnsdlKMKxe2VIsuRmByfT9aQ/NRFLsn0cdJE3RC34hnGkyj8LKVlJe3yl2/k99YCB9hqC8mflWqtf54Yd8xGd7j0a1Nz5z8i3v4oTG5OJd+pAUvj9Pp7trKw5Wu5gCO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R8aVrDqadf5OcizvpoH9+HJv82y70yuloaOksn9uKQ=;
 b=c8x9iryW8w1x1YdVK4HLFioTwxK6Vce149vOxR6gXg3VuG8rRJi15RbQ+6D0mikQSuuLobESC0bLJoDkz/l6F+f97P2YGeYu+tcHBfRSce0YMpOTkioNh8V1wyvi6lQ6RroaYBZi4SKeFLJQJGORh8XtFEIkxQozmQ3XgbxOP6/pqhjqqDvpf2YiFhglq/AomEPFPJnoCMhAtYARaoH0lxDD4LoTZsQYtKvyIv18/Gob69MgEE9344Plyx94zOYRTtBlRtmRZIMVc0PyfyukCIcBXRnXoZiJ6TeENy4IuPJgkbMo6ReFGktK54OoAVtDgzssIuXuaHQlT04OqAbBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R8aVrDqadf5OcizvpoH9+HJv82y70yuloaOksn9uKQ=;
 b=ajpmvf4p37slZxFT+UQ+ppyWZYdE5WPnldfLFh8QXsooQ+1/EsJ+BH+w8Z698yCy2iyUETOmqjILgrbM0aVR84bomgtj7iUuAx7uKiRIwNJYm0NqRAe/Yi7GltVgAMFC/IOLTEOD7C8TFjbmzoToHDGcgYAHQDQW+trwjyWJw83888zX27UjWjrKPqP0w0k5VKzeFyMFdYx2Cx25zoW3eiQ0hZy5jp4NfCC+47fsHOQuyvqYA22GJ2aaD661XbOSU8Tz7gTK7XEB8GeUVEwVHG7z13MUOa9osY0i8POuAQS51JahuaV756bciqaKMUzXkwnPhBBYH+i1HmSB1+aoTw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB2817.namprd12.prod.outlook.com (2603:10b6:208:36::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 08:50:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 08:50:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
Thread-Topic: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
Thread-Index: AQHYB3zBc1UHYcUK4E+PBMYxx/+jVaxhJkUAgAXJTgA=
Date: Mon, 17 Jan 2022 08:50:29 +0000
Message-ID: <09ae3d37-d22a-af44-9ea8-5d6f95c70ede@nvidia.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-6-chaitanyak@nvidia.com>
 <20220113162840.GE3230285@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220113162840.GE3230285@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72860f3f-fe7c-42c8-0cee-08d9d99669fa
x-ms-traffictypediagnostic: BL0PR12MB2817:EE_
x-microsoft-antispam-prvs: <BL0PR12MB281733CA12A25F712C7952BFA3579@BL0PR12MB2817.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFlVaal9lRqNWu0H4UgVwvRewZXbfAr1Dr/8cqyWe0XmApUiNnDKDzUZLy6gzVl0OAVCD2D4sUgtfDXqcM0TA9UGgls3r4Hu+wik1z2CvIkWBeihAOLlKoHE/Pzb6EFoShLdV6W2tHOn2Fwjj5RELb+PJeghwvjbaL11nsTHnjPubdofnh3ANozZWZG+fhEHISZpC8xY7wHR0KFl7r0YeIc14tRBlzCILpf5GNDmGJ7tYEN7ZI6VD6SkVg2RLLoPDcZji5UtJCfzColxa/KoWbyclO6boIUet70VIvdWBmyCVLMW2ObwQfTT7rZpEGKvfTP9uu2rsfpaAXAvXGuUzlodknMrpyNRn96e6+A8VkDmKIt5SONzO+nAbZvLmER99FYmTzQ2ayKXFa59bWz4cJ4yn8mggCs5GYZJqlJawmKTkTyY2ZOAVJLzx9tOBW4LK2GTjMmEN7B9gE8fMVV91egt5fq34/CTkjpIXP+V1qz1/gKWKo0I7bcviytUl/oiPmHk0N+TPkuvT9iwihtq9AXP4G7I5HcKQ02Qs2FmzKDpXQnUKVfgxgL0Ki+LnvoKMBJCr+x6KbmPV53KQfyntxAQsr9WyKadleasCvG2+y4qis35+Dxo1M2/j/eqVhMC+XZLiBvynhleox7fT2XlD7484YBf2K6j5fVL8zPwBY6D+R62dLtmZuhIobjXXoS1xvJ9YMoHaWAINqOMaiXiUmMBVQ1YVcOVivb7HKiwx6EMLLxhAVpt9fN0jdv/3GdrQ+wog3hOxpQ+GFcMD4dj9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(53546011)(6506007)(107886003)(186003)(8936002)(6512007)(5660300002)(31696002)(38070700005)(6916009)(54906003)(36756003)(508600001)(316002)(2906002)(4326008)(38100700002)(2616005)(76116006)(122000001)(66946007)(6486002)(66476007)(66556008)(71200400001)(66446008)(64756008)(86362001)(91956017)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3M3WjVnUGZrc3ZPN0JxN2IwT09Xb0J2b2dWY1lldWsycnNtSHgvZFpJOVRL?=
 =?utf-8?B?elprUi9pTnpNdlNjSU5lYWdWbjBDWU5Ub1lrUExjbVIxM2hrN04wM2kzTmkw?=
 =?utf-8?B?Zy9GRWhwTzRoenBzVHYwaGdvRFZ4bGNvTXQ0RHRCUUNuL0NKL0xPUmsybEdV?=
 =?utf-8?B?U2ZrNU9oTWYvNU9XdXRiTkFKYU14aS9YVHYyNlEwQjY5N3RsYUZIRHhWY09k?=
 =?utf-8?B?VVVqdFkvdHlPV3VvaHF1S1ljZkNqRlYveUpiNkRyTjN5a2hZUStFSjJUUmcr?=
 =?utf-8?B?MDcrQVVEYkRmaVJhQWhQSGg0ekdldjJnRUI4ZWd5QjFWM2tFL0U0REplWktC?=
 =?utf-8?B?dmE3b0tMenZjTWpBbTQwMGVKUjJ3MHkwS00rM3FLdUlDTDlQcTVDaW4wYkFo?=
 =?utf-8?B?dGlZWGJocFZVMFRsOWRuZHVhTnRRRi9PUTFGbmhHKzNCbS9pRlZjeTN6LytC?=
 =?utf-8?B?WDlmRE1ySXFlZHZUMXpweWJtMGN4WTBFQ3hlWUtpZ1JtNTNvUytsK1A1WmRn?=
 =?utf-8?B?UUc1TGl6N3VjcmNhaVR1d3RqaGIzYXlUN1BqejFSN0lwZDlXdHdXUmh5NkJy?=
 =?utf-8?B?OWRrNW1SRGUrQ1Y2SklRZWY4bkE4U29TblV6dlZad2k0YVQzVXhQMFpDNDVx?=
 =?utf-8?B?Z1hJbldRbmJMYXlNNzFSbkNzT3hFV3FiZVp1aFRjZktnRVNpamt6eDI5eXJC?=
 =?utf-8?B?b1dodkNiRFpsNGk3OHVZdE5tcWRlY1J3bnBaZVdoU1BGL3R2b2RkWW9YREt3?=
 =?utf-8?B?WjBwQ1Y2bXd3aTVLWXhkRXhEYUpZNzBicjVxY3JkVWt2R1JmV3hqd2pFY3Fr?=
 =?utf-8?B?bGxPUUZsRlJxc3o0QW9FeFJiZUxxTDlOMlU4b0VlL2hqbHdUNmpuaTVJN01Z?=
 =?utf-8?B?UzZkR3RWeDZQQUxsMk9pcjlTTkVPQXhvUEt1cmQ2Zkk4SWFITUFnMDUvb3F3?=
 =?utf-8?B?S0VGY2d6bVkrQUNVZ0ZQcGxTTThOTmpaZlZ3QlpscVpLZW5IRXgyeExSdksr?=
 =?utf-8?B?M2gwN1Z5QjE0RGo5YVA2NlJMdjVBNUlTd1F2cFpmbmNqNlNDTkRFVTRhU3gw?=
 =?utf-8?B?am9tNlFzRlpzWnlqcnpNeDNUTlZKUjlUakhNSzJWK2tQTkR6c1RTc2E3V0RU?=
 =?utf-8?B?a0tuSWxDSXppVmZvL0VXdG1EWmxZczZKYTVPbTN5dU9Kb1BKcVF0dlE2c2hN?=
 =?utf-8?B?OWJ4Z1ZRRDBDQTFQQi9KTHdTMWFsTEJuZFZJeVd0blM2c0IzMFJDWkN4U0dO?=
 =?utf-8?B?RXRNNVZZWkpBN1JRNDk4UnpIQVlMOUtLeXBUbnNubnhGSjVSa1cvR2ovNUNN?=
 =?utf-8?B?cXlaSTdXclBEY3hPdHVRNmpxakxDNmxIL0wyQ3JZclFyU1c2Wkd2c20wYWZr?=
 =?utf-8?B?N3F1ZkRBSnBOdFJGTjJ1b3dCNFBSM1NFVityVUNTeDd5S0xVUDhmdkJackVt?=
 =?utf-8?B?dGoyNFY4RGdLcU9wTUZkS1FRd2QzZDhRNk9udU52MHBWTlBUYzhWTHMzS1J2?=
 =?utf-8?B?cTQxZC9BYkNDeCtqR1VnYWxMM2RvUHRjVGkvcnBCQjZQdjI4SENkZ21SNytv?=
 =?utf-8?B?U2RvUUlENXNzbU9aTzlnRnhvMWZ0UUZaVDMvamJPZ3cyNzdxWmlndFFWZnZB?=
 =?utf-8?B?TzJjMDRHQjcrdUdrOU4xSjFuNXNlaUhKVnF2SVkvT25UMDZ2VnQvblUxcmpj?=
 =?utf-8?B?S3R6VmM1dUFLM25mZmxJaGdTdXlHUHFaUmYrem9jYWhjcytMNlVEL3ZNUzVq?=
 =?utf-8?B?ZitqQyszenpCVHlLRytYL3Irek03c3lEWHBRTi9qWWJvKzVBV2tWaFBFb1BC?=
 =?utf-8?B?Z0l0b2NTcEc5bjQ5R05ockZzZGFwU01LNnZKQUxJT1ppMngrZHgyVWcxVUNF?=
 =?utf-8?B?bGpncnFWQUFIOERMT1o1UjllaDIrN2R1TGtUQW9Oa1NvZ2Z1czRCSzNJejZL?=
 =?utf-8?B?Vy90bDlLUFZvZWQ1aTltaWVab3ZqV0FVNVdlc2tNa28rZklsVWh0UkNVL2s0?=
 =?utf-8?B?QkdLeFUrSW5pbmE0azlja2p4QVdkQm5FQXpqK1ViRFdFb0VLUXpuTFFhYXJL?=
 =?utf-8?B?bnhNQ2pKTWcyaTJHeUI2WHo2VDNaWFpUcVVyK0V4TjJWcVA5WVVhN2NwN3Zh?=
 =?utf-8?B?QjliVUVPNFNwMmZ6Y2FQN2puNENtZmxSaHY5WkxJaXF3dnF1M0ZsN3ltN1F3?=
 =?utf-8?B?L0lEY0RsVkNvanRKVGNsdVJaZW5JazByTDdqRzBTSjJMN2FCWks1aWFFWGdL?=
 =?utf-8?B?cXBwTXZSWllQSHBsNWZlTDVaV21nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCAC4ACD602E249B3A490E497659769@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72860f3f-fe7c-42c8-0cee-08d9d99669fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 08:50:29.4390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrxoOCwuSYsis5YbrOsubDNXLKuww5PWRSkquQL31OGHYDm6IDM2WsIqbCWKnVz2rc0eBr8Q/gKwJFc0tJJWrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2817
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220117_005033_446425_F85588B0 
X-CRM114-Status: GOOD (  17.37  )
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

S2VpdGgsDQoNCk9uIDEvMTMvMjIgMDg6MjgsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4g
DQo+IE9uIFR1ZSwgSmFuIDExLCAyMDIyIGF0IDEwOjIxOjAxUE0gLTA4MDAsIENoYWl0YW55YSBL
dWxrYXJuaSB3cm90ZToNCj4+IEZyb206IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQo+Pg0KPj4gSW4gZnVuY3Rpb24gbnZtZl9kZXZfc2hvdygpIGlmIHdlIGRvbid0IGZpbmQg
dGhlIGNvbnRyb2xsZXIgc2V0IHRoZQ0KPj4gcmV0IHZhcmlhYmxlIHRvIC1FTk9ERVYuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+
IFN1Z2dlc3RlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4+IC0tLQ0K
Pj4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgfCAxICsNCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0
L2ZhYnJpY3MuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPj4gaW5kZXggZGYwMzI2
ZGIzMDZmLi5jYTIzYWM5MjY3MTAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9m
YWJyaWNzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPj4gQEAgLTEw
OTcsNiArMTA5Nyw3IEBAIHN0YXRpYyBpbnQgbnZtZl9kZXZfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUg
KnNlcV9maWxlLCB2b2lkICpwcml2YXRlKQ0KPj4gICAgICAgIGN0cmwgPSBzZXFfZmlsZS0+cHJp
dmF0ZTsNCj4+ICAgICAgICBpZiAoIWN0cmwpIHsNCj4+ICAgICAgICAgICAgICAgIF9fbnZtZl9j
b25jYXRfb3B0X3Rva2VucyhzZXFfZmlsZSk7DQo+PiArICAgICAgICAgICAgIHJldCA9IC1FTk9E
RVY7DQo+PiAgICAgICAgICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+PiAgICAgICAgfQ0KPiAN
Cj4gSSBtaXNzZWQgdGhlIGRpc2N1c3Npb24gb24gdGhpcy4gRG9lc24ndCB0aGUgX19udm1mX2Nv
bmNhdF9vcHRfdG9rZW5zKCkNCj4gYWxyZWFkeSByZXR1cm4gcGFyYW1ldGVycyB0aGF0IGluZGlj
YXRlIHRvIHRoZSBjYWxsZXIgdGhhdCBubyBjb250cm9sbGVyDQo+IHdhcyBmb3VuZD8NCj4gDQoN
ClRoZSBmdW5jdGlvbiBJIGZvdW5kIGluIHRoZSByZXBvIHJldHVybnMgbm90aGluZywgaXMgdGhh
dCB0aGUgb25lIHlvdQ0KYXJlIHJlZmVycmluZyB0byA/DQoNCnN0YXRpYyB2b2lkIF9fbnZtZl9j
b25jYXRfb3B0X3Rva2VucyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcV9maWxlKQ0KDQotY2sNCg0KDQo=

