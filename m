Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 01:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5Z/FErTlO8R7xMsMJY71yIwhAybMwWdlTawFOK+QSI=; b=GN/DN6eRl96sxhTRNhWMOzlHZX
	AQawWSU5+0hL1fhrgJkPcaYordEeT/44rd8rpHKnt9+b9Sse3r/8tHlrOKfkCHm6KFDPQaLIUWiLI
	1h5mDCTrjqpYARFHAPVHAcR6bxxx5FEfdWu5+M0AXcWZtr2u0aWnwdzsBNHjVBbXMbAHAr+lqs1tS
	ZzBuaKXPT3OlsIhKqESadpO93VRJ1asrVGjorc7nNKNbZgKF+9/R/SvDWO1db0S87k5229qgg6fEj
	c7raiDmoQwaEUuXfXt/4FTH7PrgwcDpsWRA8rZlPl2vDwU6rcNjdF/VFdm7rE7vD0WmQFrx0pWt+O
	mtS1msYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofX39-008GsP-4I; Tue, 04 Oct 2022 01:48:47 +0000
Received: from mail-sn1anam02on2059.outbound.protection.outlook.com ([40.107.96.59] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofX34-008Gq6-NG
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 01:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lokaQJYIBlGoYKY8fb59p4wrjc5BGEGDD+eIkZqFE7lepOzMiZEW1Vm0ihgq+7UAqCy5+QWK/rhUaPTApd0e3lfvtqNRZmKVK8hnWB3Q7yXKnUJ+YWEE/mbj8bQ/MosP6Y0gS/Gu9CpU+4NBjzEG8NyuMj6skbpmZPKF8V7mOXXQ+GHCJHBBThHX8AW4o6QmN03aCK1+MAW/ZfTu1HJSt7CVJ1un5ZfVsyFsYhh3G1X+5GdFs7DS8icKyyS7JKSSjON7s2SNOQ7NFOIDQrQFo8XBLIYQVEgNB16/dc6sx4KGYeUsRBrFBMtfv9gxnjY//JSTSMIpZ78JU0uLCdQNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5Z/FErTlO8R7xMsMJY71yIwhAybMwWdlTawFOK+QSI=;
 b=N6ESZ+zH+JBl3u00J++x8Gv5GUAlVtUfHtd/uqGo7pHt24HSdsnkll73oaqyXv/OUyAHuGdythMqpM4Je5jE5GyWllw8LhFQ9mE0RwTOHaNgqrJPpagV9RoqWLC44teYwqm9LQx8GF02JUiOljmP7nTwIB13Br7k6rLM5Ne/Yc39YJjBMHRMpTtIfokDbi79jqHnTD2NxZd5vWbyMcnUhYRy8Yu29VwpEFOhIO3jQ2dHlGmovtRoWWqhAbPurwcogNpCSDSFuLI1I8LibjIlcMtDHwKl0ivOWUUBauw/Ou0yn64Ye66yfGuU0iwZ6kY/ncBiUzp1X52Qb6gADUf5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5Z/FErTlO8R7xMsMJY71yIwhAybMwWdlTawFOK+QSI=;
 b=o1m0j0krJnkqVs7QWH7jlyCoPAxJgSoVsaoGZCIfpHci/Sl7Y8QkbKUJI1kUj5dvp2VZGmlduy3L0D62rqBiYSQWSLsPoGeyYTSktiWThPNKLH0VY0cOZyRAQoe9S/FbyLnlKYJ8uQsm2lk/IMAvts7AmP3f8vZq/YNMyG9AfZEATIaP7QQGZqROuU7/Bb24o/Bz9A/hEwcSHAuP9ylMrgN5GPcDk44oLtbMEXixSjE+RB+2dSt7yUeAFrTIEOZlFG8jxFGB20/qQr7gFWOc80BYoAmBD9rszN/v7hlhhl1ahvbB/CMMki/jVcCfX4ruGM9/QsKGqcFzuuMOjZ8QMg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.23; Tue, 4 Oct
 2022 01:48:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 01:48:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "clay.mayers@kioxia.com" <clay.mayers@kioxia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Topic: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Index: AQHY1FSLGEN8L/xoy0yARDTtK6PgSK39fimA
Date: Tue, 4 Oct 2022 01:48:33 +0000
Message-ID: <1cef55e7-26a3-abac-315c-5f7f56f4771e@nvidia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
In-Reply-To: <20220929223955.3275715-1-clay.mayers@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5832:EE_
x-ms-office365-filtering-correlation-id: d399373c-5ac4-484b-2980-08daa5aa8bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  O+RFp8Pqc+0Y8upbckbk8OtQwuNV4ieQku80Y+yCB4f360aVIUIhiV/9dnP0tMHlmMD/3YWcJ25P1vzmyrxHnQu+KB6wKw0DMZxCCkIlia6Hle7jx0f/Ykx7sFOdxbQ6WG7tyspuUYJmNAXU96lOwvxITmuV4MsNO4EwA5HK4P/eOaUFWYEn6T/dKfCDeBLW1GNLf8/vD/tHTpKgJnGXardQF69Gq5KOK/loc3la976FcqOgi5Sa4DaSdlQ+Z8Xsi786DNih+MDPwunEQZMQqKFmL1E++YR8QtDBrLR77y33nkakClWX7BqtFU8EJYubF5BtVv+zGvUG7MRQnY1zGenliZmpULVfEFtfIiarI4By+VmPpRsxQypjtr7PUaH+9z7rBeRHHxpOw9cAteW3HXzRGWcBr6qlc0z6RHwYGuCiakLgLTbAWyPcdQpcM3OkOzs8YQr9jr8+6jUUzEbuITqHs3rUPEAmCzCSDqDmKogwuOdSdlFO04Eg1FzLdWe6Xaj4eUJ3e5pQ5oFqVAjQTSE3iYuxxE2Y76w9fOUp4CaenErs42222gl1364Hd9a6nhoLYX+vAzBYTpaKKHVgYYI1mfUSEEkavqo7PhmzqDV73JrSosHQwhnZxP4F2Jx0ylBtnindbpw7h3SkElLE4kKDO+3TBQvzwT49rh8w6W6iiRnJCtnYk4hOSF4QuJ3LxLTj0W1rgAMuM974J97FUOo57LlbRin8pjzYxvgIaU3hRNkNR/p++GwvXHitbs2XZ1NZmXRNZpWzkBIy+CiHGMWz3aHHct6cHDUtKjZ6O/MYMVdsF6H4qFYMwGg2QM8H0ngKxJJBbTLe5bGbyi1o4g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(31696002)(8936002)(91956017)(76116006)(66476007)(5660300002)(186003)(4744005)(66556008)(83380400001)(66446008)(4326008)(66946007)(31686004)(8676002)(41300700001)(110136005)(71200400001)(478600001)(122000001)(6506007)(26005)(38100700002)(6512007)(2616005)(53546011)(2906002)(36756003)(54906003)(86362001)(38070700005)(64756008)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?U0VnRmF4T3dyc0RzRVB5c1V5SGIvQ2M2S2VDWWt1YXRsc2dVdzVHRnhKZm8y?=
 =?utf-8?B?Y2xVSmh2VGtBNkZmeWNmK2N2R2FIRU04MU5qNDBIYmJSVndoejJyUHVlQXM1?=
 =?utf-8?B?RUlWa1FPREZmWE1QcEEzNjVXNzdpZEtrTnB5b0VpLzNlQ1oxeE5PQWJUQmxl?=
 =?utf-8?B?MWVYYUZOcmZVSEFrdytxam0yK2FEd1RINElwNHZGWURjWU81MTFxcnVERFBT?=
 =?utf-8?B?WmoxL2JWZ3pITEdCZVYzajI4S2tBZWx4anpQOWVzQXRlN3V6cEtmUzhPcjFO?=
 =?utf-8?B?YkVDTmk1ZHM5QUdpQ0JySHM1d0ZWMFpMS0lPc2pFaGZuTzZjWk04T2ZMd1A0?=
 =?utf-8?B?WXhMa05HRDlyNVo0dmY4dTRDRi9ORjcycDk0SVpoQ1Vna2dyY2I4a3drQ0lq?=
 =?utf-8?B?cUlUOUczTDN4aG9PSTNTTTluQ1BpYVNNQVJLMkN5NTFLTUtIWmpNQTU2WjNO?=
 =?utf-8?B?eCtabmpCYi9JNzlyWnVMUytjcFhUZU1ocXJ3dEhBRk84elJ4bWZUYmJaS1hk?=
 =?utf-8?B?R0hJMTJOZU5iY1lYTGVrR1dYR1ZKZUN5VUpyeFZaRXBXOHN5ckJKMkRtWEJa?=
 =?utf-8?B?eFR6Y29XNURGOEVvYjRIOXlyNkRyNmNzV3lPRW9Sc3BuKzlSRm8zQkhlVUQv?=
 =?utf-8?B?WWJhQnNVVkVkZVZUZHU2YXpLQWpJcUh5MTBpRkNpeU5CR3l1YXRjSVQrcGM5?=
 =?utf-8?B?c3NQN0NsUjdXL3JJOVpGa3lHV0tlMnYxcUtwdkFDbkxqOVdQRTFIYWJQYndN?=
 =?utf-8?B?dEFib25RdVd1ZkNTMCtEWHUxMStURWdxcFR2a01wMEluZmt5SXpQMnBLaCtw?=
 =?utf-8?B?QWhwOHJUNXI4YXhsdlIvWk5mZjFuUXUyUXZLOGFndFZaaGg3a2ZPeXRMZmFm?=
 =?utf-8?B?aldzVFcwK1FpRkNIeFplaDFTczBXekJMK01ZdXhNOTY3R2lpaGtzWnBHN3B6?=
 =?utf-8?B?eDZPekMxL21Qb256TGpSTXA5YlFBTkorYXJXR3RXdjQ2WjNKeVB4SzRKUHdv?=
 =?utf-8?B?emFmMHRFUTVDdTU1Rm5qczA1QTVrT2lDamIyTStuWU1zWVBadUxiY0xYU3Nz?=
 =?utf-8?B?cW5vaGNCUVdOWnlBRWFOQ3MwRW1HZG9wbXJRSWJCYklYTDV1SmM5VG96YXpB?=
 =?utf-8?B?VEV4TlJTWjhhaldaOURPb0I0TEM2VGhjT1NMQldXbkJOM2FqTXhzMkl3S1lI?=
 =?utf-8?B?RTloNVdxOVhpYmpFcnluaVJKb0QzcUNsS2VCdGNFb3gyc2ExcjJYMHpsSE5H?=
 =?utf-8?B?SkVkdHd4VDBnVmFtR3hVVC93Zk1KTEVZVzdSVXA4RDlWbDc4S255SzVvbmFQ?=
 =?utf-8?B?VURSNFhnQTZkc3RBWUZBVWsyb2oyN1YyVHJzcDg2dUJ4VTFyOGZ1dEdvWVN2?=
 =?utf-8?B?dU9oc2x5OUQzZ3RWZjZLRllCMmVqS3dtYXc2L2pEV3BLbG9YNXJvdlNTTjJk?=
 =?utf-8?B?anZRQ0hjMGFRdjIzNVZSMVR2d1ZRSGdsbDdiWUFHOWQzWFh6SjNzZ2hSMlFP?=
 =?utf-8?B?bTJLdXhjbncraHVBMVRmbEcyNHFiRFBZWGpWaWtReFZEcWJmNWpCdkowZ0gx?=
 =?utf-8?B?ZDZoa09tc0ZtU3lXWXBvK0VFZUpMMi9aSFRIMFRqQ3d1YUZ4Z0Flc21TdDZX?=
 =?utf-8?B?emdlV1lzRG5paE5CUmFwVlRUa2NHdk5NSnZldzdZV0VNZGw2NWtUdzFXSGlx?=
 =?utf-8?B?SnlqUGpCZG5aY2JxY1BHRTlCVGF2NHVqTWlwVEIrWWE1NnFtaHJLNFkySTdW?=
 =?utf-8?B?WkR1OUQ5eTlVM3VYVXpvcUE1dmlJOFJmWjBOSHlsWDljbEZmU3FIb3kra2Yr?=
 =?utf-8?B?MXZJWlZZdW8vUjFPcU0zOHRxZlMzdXIwZXBaTjFnbUk1a01LOGVCSUVtU3A0?=
 =?utf-8?B?c0FHTC9pUWcraHFKUmFFMkFRdUxucjgvdld1YzcwMEZYOXRxVlcxN2VqRS9i?=
 =?utf-8?B?K0puaUVjNUMyUHJRQlh1ajZXRzVRZXN5Tm5OSFRPZzJIKzVQNjYyZEU5dDZO?=
 =?utf-8?B?YWM4VU5namlmNTYvZzQvWDFXMWhrdHU1aHhtRHlWZFprOHd5aHpUeUlXSldp?=
 =?utf-8?B?TGdJclRZamlQVFZmU0U1UGRSTlNILy9qK2t4RHJnOUQ3b24xRkVZNkZSeVZw?=
 =?utf-8?Q?I6hraSCV8zwdyz5pTUUc8PuzB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B53AC30367EF174FB794A53ADADB9EBA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d399373c-5ac4-484b-2980-08daa5aa8bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 01:48:33.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6aQPAncS4L5vVLi6EGsyZoBEyHx1RToQ3NRBy5B5O4mUD19PStARXXqtCNwNVqrLryTdSBzjssLxNhrIA7pjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_184843_140770_AF40782C 
X-CRM114-Status: GOOD (  13.70  )
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

T24gOS8yOS8yMiAxNTozOSwgY2xheS5tYXllcnNAa2lveGlhLmNvbSB3cm90ZToNCj4gRnJvbTog
Q2xheSBNYXllcnMgPGNsYXkubWF5ZXJzQGtpb3hpYS5jb20+DQo+IA0KPiBUaGlzIGFkZHMgc3Vw
cG9ydCBmb3IgdGhlIFpOUyBab25lLURlc2NyaXB0b3ItQ2hhbmdlcyBBRU4sIHdoaWNoIGlzIG9m
DQo+IHR5cGUgbm90aWZ5IGFuZCB1c2VzIENRRS5EVzEgdG8gY29udmV5IHRoZSBOU0lEIG9mIHRo
ZSBsb2cgcGFnZSB0byByZWFkLg0KPiANCj4gUGF0Y2ggMSBhZGRzIG5vbi16ZXJvIE5WTUVfQUVO
X0RBVEEgd2l0aCB0aGUgdmFsdWUgb2YgQ1FFLkRXMSB0byBhbGwNCj4gTlZNRV9BRU4gdWV2ZW50
cy4NCj4gDQo+IFBhdGNoIDIgZ2VuZXJhdGVzIGEgdWV2ZW50IGZvciBhbGwgdW5oYW5kbGVkIEFF
TiBub3RpZnkgcmVzdWx0cyBpbnN0ZWFkDQo+IG9mIGlzc3VpbmcgYSBkZXYgd2FybmluZy4NCj4g
DQo+IFRoaXMgc3VwcG9ydCBpcyBwbGFubmVkIHRvIGJlIHVzZWQgYnkgYm90aCB6b25lIGJhc2Vk
IGFwcGxpY2F0aW9ucyBhbmQNCj4gYW5vdGhlciB1bnJlbGVhc2VkIGRldmljZSB3aXRoIGFuIGFs
dGVybmF0ZSBjb21tYW5kIHNldC4NCj4gDQo+DQoNClBsZWFzZSB3cml0ZSBhIHRlc3RjYXNlIGlu
IHRoZSBibGt0ZXN0IHRvIHRoaXMgd2lsbCBnZXQgdGVzdGVkIGV2ZXJ5DQpyZWxlYXNlLg0KDQot
Y2sNCg0K

