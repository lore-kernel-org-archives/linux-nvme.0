Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C03C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzjkEveuPcUmo0jquj8HABlQ3MyJ75Bx+NL7UAMzMGU=; b=dCH2gOdQHY3KVs5R+14ndI003c
	lCgy9uto+IFWuMm1CXTyJbFhWXK4WKEKput1GMGuhDVcgpvIT3aH2qflt8v17UahL6F5xtZ5P1UaS
	NhxM+HjxO1wLka9+0jbpI4qT6McwasWhH7qa71wTP6DxhydvD7MgVM43uoRuPDQdiJfgbKxSq4uTT
	CTAdOKFKl2UX57WuJ5LI96tGL1KCOBNH5MuPDGRNQKoDuPuCzFTo+zoWqOYQB56J8kWsyNYSvyt5W
	knfQpQXyw3r2gtwMTLOj0xPWC+IUuy14h9gyOAix9QauBNQttXTz+fjfQbiHgCvKshrFduLqTUW7l
	3i63Ks3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfGEa-001FOl-0F;
	Thu, 23 Mar 2023 08:23:44 +0000
Received: from mail-co1nam11on20605.outbound.protection.outlook.com ([2a01:111:f400:7eab::605] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfGEW-001FNr-23
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGxsM3W8fIMjO6oxRl7rpqq9UiL8JLjFphTCxa6XEeUFjVo55nnQ5vXCzrptdg0jAlmHLEQNI79lTykesJ3X01oxPD4hsGVv6QiXirmgJ9+TFmlwEzmT1UEzDmtJ+aVlyz49lwSnFRp0Mnte6Nxm8UMONsmTc18hakKZQQBIyEFYUGRrPg0Ej1zm8L6x7XZWooP3+KkjtKtxTIIEJI9M1FG2XQCUxr3nbradpBaRXYxfz4vPkDDse4ZfZy/Uh4Ogo5ezj0FqA4KcNuaZbsNJfxllMuSOK+K4kliVQrwlOmww1v+kPwlaPdtuGENjdXR1XSgAiG8JAf5241rlXm0Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzjkEveuPcUmo0jquj8HABlQ3MyJ75Bx+NL7UAMzMGU=;
 b=PDy2UdJ2jKCI3Y6oiF/jxmrQN1CCtCPMhix9QbClprl7uo54oWiTpNfYNtRUrb2+AeJX8cO2ikWo2Dm8JKpPk7Kma9CiOCsoayBoZy0kQo9oq+dB6PPgrV6891o2SHtV4LG2PNKk8XRN78PQrZV0fVSAO7SAfp8jrrR2NHlDuNvysNHFqu5tB5Hdf4bGbN52cOPflj03Xu0jCP0QOnCtCVN/hS1AEViRIkDBtit/X4es/yXj0m2lRa995xCDyHvVpimxwzL2d/fPGAEoNqT9tLrZICBGFLxaBnMUuvLNgwbQt52YmcrwzuLr3OCveUavvTZR+VbYH7u1N4Dd5qkA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzjkEveuPcUmo0jquj8HABlQ3MyJ75Bx+NL7UAMzMGU=;
 b=X2ddoBXzJQFku/HCNcUIReOi+kVJ/uGm+zrsjQOAzDxSQgKeq4mQVy4EhPMNOZBqRcUGuErEy5DXSc6b3zNbnv8IpfPNNBJFCnXks7/6jv4s/D9W2x04wYnrlKvJP5hSOhAIMHGxJn52uBhT2wFqfTtpQIBeZXQrHvPZ8szoMw51yL13Pjp9zWFFJRgjYeho51pQbkJH825K7VR8aZtJ3umZ/zR0twTiwL8SLwOdmNvBK79LqL/PsqCt4bUPYAgmzpig18rptJHGwTEl5XSXe442sgGw++HjOV+4NwWt+kmy5PrFGprTbGBGpTCwvfaSDYeuy30EQUiYHH2dgNP5GA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:23:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:23:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH 9/9] nvme-core: fix nvme_submit_sync_cmd() args
Thread-Topic: [PATCH 9/9] nvme-core: fix nvme_submit_sync_cmd() args
Thread-Index: AQHZXTjxwEsLKsfZFku4zbO+84A1kq8IBPuAgAACFwA=
Date: Thu, 23 Mar 2023 08:23:34 +0000
Message-ID: <a62764ea-36a8-f7af-59a8-537214fc7956@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-10-kch@nvidia.com>
 <33627b01-b3e9-6200-51fe-baa9cd3ae30e@grimberg.me>
In-Reply-To: <33627b01-b3e9-6200-51fe-baa9cd3ae30e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA3PR12MB7829:EE_
x-ms-office365-filtering-correlation-id: 80a5dbb2-5a62-4ff2-192c-08db2b77e51e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  fsf8weQI70xEe4/5gIi23ruiCvEj/Z9FlbirK1zb2BWsdZEy0qU6ZFc1dKJxvaWTktYUSGYFJwILWZ/3uWrT/VUUFl3+CYf2TI4GJHFiK4izsCLYozmpjd2NhfVOYYZzV7ww2zRYy3EHafCw0x6UHsQ+nSvITBiUW7IvPTsOaWkYPU8uvRAPM16SPor/5gZdvYV7mD1RrQPM/fmvC0NithZQmEUMbbrTfSTCDaRjVdXwbEjQ6MpNqLResexd8vBg25LPcDcWKxtAXdK0nNtiS7THZuyrtLHrN+SecXbM6lmDZ5qodh75NQ+zqBK26/bd1Wx+vthI1VwBUuC7w9W8o8EKeniP3tfFgE7L2cbM48sDCdvMklAryfTZrQVUbuB94lcmT3pBTAzOFy5Lkr5q0rgX1VUI7KhVgvVWRjUR7AcGapq9355IObyYZZ+isD/JQOduxy4IcFEuEplZJ0AzpA7WT5VDt84C84qLF1zsXWGaybgroIxTttonoBXsiT++kWyAzPofAupL6iBXz8XdV0b2YaaPremBb0iGIq0uKzQtnErAz29Do9iGfWerGxqAwDHo+91/NbkEp6Nj1xQKJ/9Kjzi4W/vdjFioPFKCaWsx34i8d5GUL6MsAAtEoRNiGOuuRb7hx6G4HMXiFXRO0fAozhVah5oTRWi5Q6RvDrgTBBOc4vhtg4h+Z2HVXX60ukke2mVN/dl+iHGRrOPB/EB6wiNmgBYYTqh22wxDuVHZkpVDomW9yc+Y0DLTTXDRlZzlovKXzfKgO5X64xdNpA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(8936002)(5660300002)(31696002)(41300700001)(86362001)(2906002)(38070700005)(122000001)(38100700002)(71200400001)(2616005)(31686004)(6486002)(186003)(53546011)(6512007)(6506007)(26005)(316002)(76116006)(110136005)(66946007)(8676002)(91956017)(4326008)(66446008)(66476007)(64756008)(66556008)(36756003)(54906003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dTJGNmw1OW1NVmNBNEN4aTErM3MwMWM5YzF3R0RnR2gwWVFuSGdyamdUMWR4?=
 =?utf-8?B?bHpkSnZGWTlWUGRpd04xbDJYOHpUTkNrRk1iN3RlNjVVRmRoRmVyZUJjbk85?=
 =?utf-8?B?YjRtaEVQN1JsdTJHT1owSktuYjZQSWVsMUQ1bVg0OGJ1SEtWRmtONEI0RVh0?=
 =?utf-8?B?WnFlRDN6Z0NqSytqOTA4S0VNR2dlUjNIQ2VDakZ0NUZrRTl1ZFpTcWJIdUY0?=
 =?utf-8?B?d3RmcEdkV3FIRThtQUtrL3RlSFAwRENLdklTcDZTRzQ0dE1jamp2NnZkcG5Z?=
 =?utf-8?B?TU4zNTZCYkdnb0dVZzh5ZkVZUXI3V01VZGluVGFwalVRV0pjMm9tK0pGZ2E0?=
 =?utf-8?B?b1I3SS9WYWFwcHZzZ04rRGtCVURTaDJNWFIzcW1pRWg0WU1sOWg0OTJmYzY4?=
 =?utf-8?B?K1dzUlYySE41TUEza3JFZWdwZ0lZd1RYeldmMVl3SjZ6Y1g1MnJhUGpEa1JM?=
 =?utf-8?B?aHh3aXU5Z2V1RGVla3B4TUVlM3V2U2Q0b3ZFUk9sdDNESThIK2VPUXg5MkJy?=
 =?utf-8?B?Z1IwTTh2dTZtMnpDY1lyTVBHY1Y0bHJqYmxmTExHWnNOU0FoUmtCNUJpYS9n?=
 =?utf-8?B?WVF5WmtEVG00ZW5ZemhoeUllWGxpRTltR0lhUlhhQmNiQ2k3RnJsdU9Wd1BS?=
 =?utf-8?B?YzBpMDRKMWNYeHVkb1pQTHlOMVlib0JpS2ZXa2o2MDRCdUlYajV1K0JmdXVU?=
 =?utf-8?B?b3VMWXdOY0EwR215Nlo0Z2MyVE9nU3pwRm16TllaRUVKcGNnSVFMOWJJUEFX?=
 =?utf-8?B?ZkE1ZE5PaHI3SnZacGpzUmIyUjZOdmd1L2M5bXdUUkhncjlwenVER2ZyVkRV?=
 =?utf-8?B?d1NsaGJmUTk3QS9seHA2WE50WlZ4a2VieDVEc1FGTE12SWt0cUliZUV4QVdC?=
 =?utf-8?B?UGdvK2V5eDgvbUNwdzR3N0lWZTFETi9GdGE3cDJrRFlsWEVWRDJUdjZFSk5q?=
 =?utf-8?B?emRyZldXUjZqSjJuK2ludGdHdlNMOFY4ai9STnA4TWpYNmJmeDhCTVJ5cFh1?=
 =?utf-8?B?MjBXSStVS2ZSWkEvaFdIZTRqUzBxRmQrUm9qV2NOWThEMk5YTUJyVjdrRUZp?=
 =?utf-8?B?dlVmS1YzZ3hMVXljcVV6bkJmcWNoa2lDdUNjdEV5R1BOQTQ4WHpPWTZmZ2Zq?=
 =?utf-8?B?L2Zia0l5ci9MTkpFYVUvQVF1ays2Z3V4ZTRvYWpZYktmb1o3SVEvUjdJOXFS?=
 =?utf-8?B?QkI2MWhReS9EWkYzejBhU0tHZ3ltaFFMMzk0ZFpBczJvTzVTYWRPdFVNUmdG?=
 =?utf-8?B?d1VTbmFrNDBLdDY3QTk5NXVuYU84RUtTdnYyRXhLZllpOGlnZVZHTmQxdy9h?=
 =?utf-8?B?d3RLY3lnZ09mc3JVWmxNaVZqYi8rWVZ2b2dXQkJLNzAzRjVURFB6a3YxK2xm?=
 =?utf-8?B?aTRUOXhtRHdGY0RFeWRLYVk4aWRuRHdEdGdpeGJqbjFuQVMvQmQvREZOLy9l?=
 =?utf-8?B?Q2FDNlREVUNuMXpiUWVWbUdUQ29qQzFCYVRUdmNCOEZCU1FLU3BsNkN3cWJ2?=
 =?utf-8?B?UTFvS0N2WjdkaWhRQ2lCYmovN3FKNVBCY2h6TlZhWWFWc1gwVTgxQlZMMDdi?=
 =?utf-8?B?Vk91MWJOTStGMFAzbW9kOHhRbUQwbUVxMEo1Nm1rVzhYRWZPRVJXOVM3MkYy?=
 =?utf-8?B?MjR1YWZGYkdJRlNSdnV5TlNqQ3pNUUI3VDdRTGpsRm0zclFjL0x3c0RlSmFE?=
 =?utf-8?B?bVc2NDhnSTdqR1BZWDNybHpUUGh1UERoc3BUUTVpYnN1N3ptWSs4aGRRa0pV?=
 =?utf-8?B?L2wyUGI1WEtMT1ZQSlh1VjBoYmV2aHhibC9FbVI0dFRlYlNVbDEvK0ZQS1Nm?=
 =?utf-8?B?T3lNaGdVN2tYQTJKSXlJRFlLTjhIZnc3K3p0NUVXSnN1OU1ac1lBUFdQVFla?=
 =?utf-8?B?QmVndVBkd2ZDT091MFdtSnZoTnJOM0hUMVEyNGZ4ZzBxUFY0bUxBNmMvNTVG?=
 =?utf-8?B?NlJobmdUN1lDcjBnMnZ5TU1HbnNndTUva1F2dUxHWTNZYTZTNURzYmRJYitV?=
 =?utf-8?B?SVlDNHR1N2wwWnArbndybno3ODRQMHBkNlovelRaaTJoM2ZjNlZsREorVnZE?=
 =?utf-8?B?dmZaSVpENmY4cU51QzE4MjdJa0c3UFNRNkJicVkrMHJVbzhIZ0I1VTF4dmJ6?=
 =?utf-8?Q?lNB5utbKasdbMmWNZNwkR+Ts1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E25F69BEA813F2449824E602DC6EFCE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a5dbb2-5a62-4ff2-192c-08db2b77e51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:23:34.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRjDyOr+vOnuvAqdrJdNWvIp+ghklErWio0vf4r7WSCbMsTN8BzLsqoFqRPCSNKzYlqyESZs7/XMH02Rb8I9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_012340_675432_97769180 
X-CRM114-Status: GOOD (  18.57  )
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

T24gMy8yMy8yMyAwMToxNiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4+IFRoZSBfX252bWVfc3Vi
bWl0X3N5bmNfY21kKCkgZnVuY3Rpb24gY3VycmVudGx5IGhhcyBhIGxvbmcgbGlzdCBvZg0KPj4g
ZWlnaHQgYXJndW1lbnRzLCB3aGljaCBjYW4gbWFrZSBpdCBkaWZmaWN1bHQgdG8gcmVhZCBhbmQg
ZGVidWcsDQo+PiBwYXJ0aWN1bGFybHkgd2hlbiB0aGUgZnVuY3Rpb24gaXMgY29tbW9ubHkgdXNl
ZCBmcm9tIGRpZmZlcmVudCBwYXJ0cw0KPj4gb2YgdGhlIGNvZGViYXNlLiBUaGlzIGNvbXBsZXhp
dHkgY2FuIGFsc28gaW5jcmVhc2Ugd2hlbiBleHRlbmRpbmcgdGhlDQo+PiBmdW5jdGlvbmFsaXR5
IG9mIHRoZSBmdW5jdGlvbiwgcmVzdWx0aW5nIGluIG1vcmUgYXJndW1lbnRzIGJlaW5nIGFkZGVk
Lg0KPg0KPiBJIGRvbid0IHRoaW5rIHRoYXQgY29tcGxleGl0eS9kaWZmaWN1bHR5IGlzIHRoZSBp
c3N1ZSBoZXJlLCBpdHMganVzdA0KPiB1Z2x5Lg0KPg0KPj4NCj4+IFRvIGFkZHJlc3MgdGhpcyBp
c3N1ZSwgd2UgY2FuIGNyZWF0ZSBhIG5ldyBzdHJ1Y3R1cmUgY2FsbGVkDQo+PiBudm1lX3N1Ym1p
dF9jbWRfZGF0YQ0KPg0KPiBNYXliZSBjYWxsIGl0IG52bWVfc3luY19jbWRfYXJncy4NCg0Kb2th
eS4NCg0KPg0KPj4gYW5kIG1vdmUgYWxsIHRoZSBleGlzdGluZyBhcmd1bWVudHMgaW50byB0aGlz
DQo+PiBzdHJ1Y3R1cmUuIEJ5IGRvaW5nIHRoaXMsIHdlIGNhbiBwYXNzIHRoZSBzdHJ1Y3R1cmUg
YXMgYSBzaW5nbGUgYXJndW1lbnQNCj4+IHRvIHRoZSBfX252bWVfc3VibWl0X3N5bmNfY21kKCkg
ZnVuY3Rpb24uIFRoaXMgYXBwcm9hY2ggc2ltcGxpZmllcyB0aGUNCj4+IGNvZGUgYW5kIG1ha2Vz
IGl0IG1vcmUgcmVhZGFibGUsIGFuZCBhbHNvIHByb3ZpZGVzIGEgd2F5IHRvIGFkZCBmdXR1cmUN
Cj4+IGFyZ3VtZW50cyB0byB0aGUgc3RydWN0dXJlIHdpdGhvdXQgaW5jcmVhc2luZyB0aGUgbnVt
YmVyIG9mIGZ1bmN0aW9uDQo+PiBhcmd1bWVudHMuDQo+DQo+IFRoZSBwb3RlbnRpYWwgZ2FpbiBo
ZXJlIGlzIHRoYXQgb24tc3RhY2sgaW5pdGlhbGl6ZWQgc3RydWN0cyB5b3UgY2FuDQo+IGltcGxj
aXRseSB6ZXJvLW91dCBtZW1iZXJzIHNvIHlvdSBkb24ndCBuZWVkIHRvIGV4cGxpY2l0bHkgc2V0
IGluIGFsbA0KPiB0aGUgY2FsbCBzaXRlcy4gQnV0IHRoYXQgaXMgYSBzdWJqZWN0aXZlIGdhaW4g
YmVjYXVzZSBpdCBjYW4gYmUgY291bnRlcg0KPiBpbnR1aXRpdmUgYXQgdGltZXMuIE90aGVyd2lz
ZSB0aGVyZSBpcyBubyByZWFsIGNvZGluZyBnYWluIHdpdGggdGhpcw0KPiBzcGVjaWZpY2FsbHku
DQo+DQo+IEJ1dCByZWdhcmRsZXNzLCB0aGlzIGxvb2tzIGZpbmUgdG8gbWUuDQoNCmV4YWN0bHks
IGZpcnN0IHZlcnNpb24gSSBjcmVhdGVkIHdhcyB3aXRoIG9ubHkgcmVxdWlyZWQgcGFyYW1ldGVy
cw0KaW5pdGlhbGl6ZWQsIEkgZm91bmQgdGhpcyBvbmUgbXVjaCBlYXN5IHRvIHJlYWQuDQoNCi1j
aw0KDQoNCg==

