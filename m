Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D133C38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 21:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwzAiDhI21w5a9uK6YBEI+WZDmG4IgPEnkbf9CTaQ9A=; b=pm5x8mW34s+1fjF64uXvqx1B0R
	1+aQ3R3yeO+7m7nS6LiRPxqRGnUEl8eYfpikWm+k6+v4DlYN8ZVAw7Qm16INfSppkagCBMEra62bS
	4gfiWGGLbPKPqUiU0G2JvAtk9vQKhcnudYg2Fq2feRNxrF1ywL4r1xwUI0b8keau3KDLpMG1H1fNQ
	9KCH/eRlJP/q941BkpicUiThNI9K5AZ0AhsuK2tQ7R2gBQwqEB/DircAFIU5i+GSzfKMb3a1rM6dP
	LHnA8r6BpU02eaud6aEVamTCUFszVBiPzOJmdpTQ4m7njIssRXbe0+VyCmeQgoB3rH2abRVjs+vp2
	Y58bPhdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMya7-009RoM-TQ; Tue, 31 Jan 2023 21:54:23 +0000
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMya5-009Rno-31
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 21:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if/SYrZpOWa6QBQs8V0xtdNT74W05+Ve/x+ZwVp5zHdCQWAhGS4eO73LDRqVn+DD9bu0WWrMNkyV4XjhGNLHHdcgBrczbBhF8gE+j/rVVZLxRl1qJlCIH2Dc13sTiuiVlYRtNiMT9h0MX7tpTaavAfdY2HpAp4dThlR9CzfUtbOqN+g1Z6u+esJfDN/YDdaDQ6z6FnHiawRJXKLTM94wXH5dX7/wPWKY7bDCA+AZAuzj8TtfOYAfbsmy90pbN+lceSnnifHnTJSQrMpw0Y+/MeeyhFiKEIeroMKnGF8AVgC8U+6Q2HI9AGTlg1khCQZa6zWKID05Zv+3bVbiANlGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwzAiDhI21w5a9uK6YBEI+WZDmG4IgPEnkbf9CTaQ9A=;
 b=S9AWshhHnE+xzVCWhIHwh7h0gnOefbhQ4McmpQTlq+X/WCzgMIY/fCAA6rX5P+3o6Yjjc01s9eC11zAT+hFQX+W4F2b2eAIIwxpldm0vUv/69JlNkCcruKB1d5ieILHA9tz4hoye7Gj7h0gpQV2AP12ivo7nYfyTgZoBeqnUnMzq5q5w4ALwxTx73gp7t7njZMeSimeef2oWQfPSek3hAsVv/yB93ZsfDWsgc2WPahzirRVxzFG+98QmLs/G7vsRobKkwEWFwQy4VBAPrWYEJl9Deaf8o93ki5Mx1cWL8aT15DePvR7ByZ7P37VddNmP4ahq1KM2R+EwVzBoLn43aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwzAiDhI21w5a9uK6YBEI+WZDmG4IgPEnkbf9CTaQ9A=;
 b=tQSEZPHb6CXDZZEzJU/a9Nx8VZ+NcB1Wa4g1aYFdrwZXLBeLRdFVp+gqjNQugr57GsY/j4CdugfuoKwiedn9VWis2PVYP6EA2UR8oXrNiMdda6QirdBkNBKqvZQbjWxzNIw7zoYVh71/ymifrSOlHkmVt6jS4p9uBGnr/qs427MbiZJws4YsI+QFtbANbyXo2rvY9eLJ1h/KVFrddq5acb3QVmxrSrAi7Zh0cCedcQU1rYzM4MrbG4MXVO0Hwa+imBVJNY/HZaykHteomEN1y4t26pMTkYioZk+8vXqAlaqdyF91H8I7nbN4r2lLLoSFcgGBWo3mWmfwJ9XYggIhOA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 21:38:41 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:38:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: fix a potential invalid pointer dereference
Thread-Topic: [PATCH] nvme: fix a potential invalid pointer dereference
Thread-Index: AQHZNZKmKB7HVDgOr0CNIVLcLsifFq65DZ4A
Date: Tue, 31 Jan 2023 21:38:40 +0000
Message-ID: <9d46b3e5-4d99-bc2f-9582-d09121182af3@nvidia.com>
References: <20230131163842.431543-1-mlombard@redhat.com>
In-Reply-To: <20230131163842.431543-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|SA1PR12MB5657:EE_
x-ms-office365-filtering-correlation-id: 8b5cb5a6-d4f1-40a4-714e-08db03d38517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  qt23YdcCI3QnqSL6Kr9WCEAXKss55vXY9T8WXBXjNVoYqCHZdlk2Ti44PCq1WZeO3qYd+JerNEqY3Y8FQkihkcQjzeeAAUfeKmDykV6FeIV8nH71hcUzoEEU4Lyjjk0YPY/PwtYH2M8AFLiGmGWFwrrYnPMqeWmk8xoOdAVmt0li9Yztqabb4Xs0EqzgDCgYHaUr9v0+g7Sj3iYnNtZZh00/l6w806A6pmoHuPxnwotOCuLncUicS8HDp3rJgYOgRSTDjdlzeCVwD/PpaUJCBfdhMjW5C6B/woaQus0FEO6Pav7ILNYzXoKrDOIz0urv9/tryKPxpPJLXOBEWCiplZXD+vQ4tbD+YcwDYUsiJFA2+vdFHcDmhh6Lq71yj0TAZJ+nx88YggYdt77Be1UbuGzS1vnZC2K6Jczq085FLqEZ+zAE+K8GiNVM59LCP5HeMcCdSnUftHg6HjtBib+RHLPn6JJA+e4wO87ynlbNkuQ984Fix8rejB4hXPy8hVy3SEPW49YDuXdh6Kam5lXBDWmN5oxWKA8rnKt6rExB1Maf2s218nnPS22h3J2oyfNoQK7ctyl0keRgjVj+rhi5BrclkTX+GEqn8CSBmcTQJJAlRt07qG3YZ3oOoTCu0kfSkK0HMRgyOXn6UnXg5fwOkREXPvCLy19TMuej0KO+DuSp3Ctn4jCx4V0Q1GIfYJ3YE4eHOSxx91FOCHGPQePrqJpOluDjyJmuyz6LZDYlyqn8ZYoBGWbsVh651zZRaeR970mSbGUSAyLUC0XJXluKow==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(8676002)(316002)(478600001)(86362001)(4326008)(558084003)(54906003)(36756003)(71200400001)(6486002)(64756008)(91956017)(66446008)(66476007)(66556008)(110136005)(66946007)(76116006)(2616005)(31686004)(53546011)(38100700002)(6506007)(2906002)(186003)(31696002)(6512007)(38070700005)(122000001)(41300700001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SkJOdXl3b2hpQmw5eENxNGtIRlk0M1FzcEJIb3BleUF6OFhaT2gzY3B1RlZq?=
 =?utf-8?B?R1FKdFBsenlEYXZhT0hYbjFudkJDU3daaFBnZEtKRlR5NHp3YzVUc2NSVCs1?=
 =?utf-8?B?VGNqa04rc2x3QUJtemtHZ2lFdlU4a0p6clRwZzFZNFJOMXZsR1VaZGxXa201?=
 =?utf-8?B?ZmNSaFUzQ3Q1bU00bVBjeGVwYzRxMXVRUWorbU4va21HWHZCTHZXYTRmTC9h?=
 =?utf-8?B?Sk53RHhWYzRvWFJ3QjBJdjZnUTVKK3ZySWJlc09iUWtUeElTZisvcjlETWZt?=
 =?utf-8?B?KzdiNXZrKzAyb0piYTNwRS9SK3h6U3A1ODYwendrVHI1YnZka1RTdWFTclZp?=
 =?utf-8?B?OVJkMzVJdE9QSXZ1U1EzdGJaK00zb0pzQkNqeXp4bWNHYXJqNjdhdi9GRGY5?=
 =?utf-8?B?S1h5VUpoZFduT0J2L1cxbkpWUHZRdnI0Y01ZbjBaMjVPKytFdTljUnVtYk5U?=
 =?utf-8?B?N1NTMFpkcmJhclJpazZrZVBabEYyOEx5ZzFONHpPSXpUNGN3MDBIcGJiU3dp?=
 =?utf-8?B?MnEyam1LdlFzUHFSY2l2ME9ZWEVKZ0Z6TVFOeCtNbXUwVVdiTnllWUtYVlFQ?=
 =?utf-8?B?aGp4eDB1cERSbnV6ZGlVMXJLQ1RVckJYRVZpc1lpSElXdmlRdmdBWmJyZ0N0?=
 =?utf-8?B?S2VoYWZMNitNMnlVVnJ4cWQ1cGZ2eXdMdGd4d1l4NnRmZXI3Y1JEbXZ0MDQy?=
 =?utf-8?B?K1I4K2hqdWhmNGxrZXdvVU9JMENtQWFFY2ZYMS9VanJlTHZlVGNEWFRRUzV4?=
 =?utf-8?B?b2lUUjgzMmxRS3g3YWIwQ2lXVUlhdkJBRytTUUZkYUpXZG55UE9saHZua3VR?=
 =?utf-8?B?WTIzNXV4SEp4T25Yd2tpY2FEb1BQdlZpVVkrMjAwcDNsTWtQZmVrU2J0UEFH?=
 =?utf-8?B?NW9ORmR2NGxrQ2xHUDdoeHFEMTBSUGxhbmhSelQxdG5NVW5BMmR3dXBSSVpn?=
 =?utf-8?B?dkhVZzJhZzlZZjM2WkU5V0VpL21Nb293cG10YXRRWTVML2dLb3Y4SjFzZklm?=
 =?utf-8?B?M1dvM3FMd2JKb0FoOW11Y1FsTC9NV1JzQnkrU2JmTXlyL0ZQNWlUNGdHQ2pa?=
 =?utf-8?B?RUdMNFpDYTlGZU5vSkxpRmhGNmppeXV6V1lsbXJBTUNNWk0wMnYzQmZpQ2ps?=
 =?utf-8?B?andkV0FRZUZHYTBWWWl3Z1UxNjZ2R1NnblluaXBOQnhNeVRkNTRXdmdFZWVa?=
 =?utf-8?B?VDZ6N0NqSldETkJQSGkxK2ZYclBBdVd1Sy9xc2dTOTQ5SUNtOThBQjZja0ZF?=
 =?utf-8?B?THQ0d3FxKzc5SmJ5NitTbFNPN1pJVVJSaDhzUWIwODRRNnhteS80dWljUE1h?=
 =?utf-8?B?SU5HYVUzZ1U4a09vbGRqNW1qUGxLblF6Q0N2NWpQbHJYeXZvSUZnWEVxeXgz?=
 =?utf-8?B?aDJpTjV2Y2lhU0hUUk9adWtLS1o0MlR2SFA5TTBxWWZhcytJTHpMU2JmL2V2?=
 =?utf-8?B?UFk4Y05hQWNBdVBFSzNlOE12YTdMT2lWMFhWQkUvd3p3WU5TUnc1Zlhic2JR?=
 =?utf-8?B?WEthekppNVVOZUNoK3dUWVdsSk8vQ1Q0NnI0ZWhBc0x0eml1eWYzZXJvekRG?=
 =?utf-8?B?dVZ2ZzM0Vm9KTVZPZlg5Qms1d0cvQ1FRckVIMnAwOE1zeUpURkVxcFFWV1Js?=
 =?utf-8?B?aXljMWQ3SnlTaXNuUGdvMnJwTWVmRktCQ05qSWEyd3o5MHdpZnNZQmlNeTcw?=
 =?utf-8?B?WERuSHFhODFvT0NqQ0VSZktPTUhod2JEZzlIMi9hWlhRbUxvUHYvMEFqbmVQ?=
 =?utf-8?B?RUNMZFllT1MvS1A4YjFvWXFxWnhqcUpVcExuRjQvOXZESWRVb3hWVWtsZkpW?=
 =?utf-8?B?VHFyQ3lUMGJrcVBmeXlIbVJ6dHpPV2czdDJyZDVTcnBhaWRHT2pNVEhGcVFz?=
 =?utf-8?B?Z0ltcmVJKzhyRnFBbmY3ZlBIQmVDa1BNaE1wQVRFQXdXODZjWUdWUVFBeG9M?=
 =?utf-8?B?TFRFazFTYU45M3QydDRLbkNEZmFrUUxHWXl4VWZRbUdRUlpFMk9qYXZieDRz?=
 =?utf-8?B?bTQvMDcrMHI2L2RMc3hiUEFZbmNuUTlURjIxdkNIc0VqQXB2MHBNVGdwZVRx?=
 =?utf-8?B?b0xQUDJGWTdGbVI2alZOR0xWTm9yYWh5OWsvN0JTT2ZUL1RZSDgwajJTUVo2?=
 =?utf-8?B?NHdwN2ljQmRSVXhuY3Rna29BM24yTjQ0bjRYRmtWT0xUQkE3N3ZjNEVKempK?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46AA06BE5F766F44AE6684472B1B3C20@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5cb5a6-d4f1-40a4-714e-08db03d38517
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:38:40.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBvIV3iT7jN3vBYPK2YOPKZFfvvRzB4XxHPuivqD5dH8pXKIiD4g01u1ux0yyMUzJP7g+ebZs3698torM6HN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_135421_164230_9A719821 
X-CRM114-Status: UNSURE (   8.62  )
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

T24gMS8zMS8yMyAwODozOCwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IEluIG52bWVfYWxs
b2NfaW9fdGFnX3NldCgpLCB0aGUgY29ubmVjdF9xIHBvaW50ZXIgc2hvdWxkIGJlIHNldCB0byBO
VUxMDQo+IGluIGNhc2Ugb2YgZXJyb3IgdG8gYXZvaWQgcG90ZW50aWFsIGludmFsaWQgcG9pbnRl
ciBkZXJlZmVyZW5jZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVyaXppbyBMb21iYXJkaSA8
bWxvbWJhcmRAcmVkaGF0LmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg==

