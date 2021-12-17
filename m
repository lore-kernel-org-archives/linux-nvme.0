Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFE2C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiocv4vJpTiP/dD85z88IV6iH9xmI16WeZvnFW2lK2s=; b=BAXmD1jL1F7nDgj7ilOWuCe7Xe
	pDoZmECtfe7HpcxmPurJQrKECEnIcncy8VMR7RX8XHodUaFqsnjJ/wpFDB58WyBbBCyxGlG5A4Xp1
	bWpHFoH8SZ023MKyR8PQzTCPmJCqi10eWtJDdvPx19X8AuIG9SW8hcz8q9y8LtQtzd4v1qngZ2KZo
	ZeYW1MZHICkO6a1L2iqINiScDiw+QzNbtJWUUNoxfLqN1/BSv0kvxPbfmEhcOj1z/GeKczO1K9+dI
	497Plh/xlx6BTlvOTEhUXnmixh9Uv/Z2H0oWEHXY0Hpj2ChQknZ6Zn2JpNo9ARisJHJ0Z+J2AYgE5
	J/7yxClA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1my76d-008nII-BP; Fri, 17 Dec 2021 06:52:39 +0000
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com
 ([40.107.244.59] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1my76a-008nHb-JI
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 06:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCAiFk4BcbnZc3HZ2pRc6shKEmV+uNsQLRoC6wirIk4P9Y4hrISD7WzOL7O/GdmBwb6DawT3SZjlT4Wsu4iwSZPMqAiPSye17LsQS6R+RtM45Suhu8gPsqGQnIR0IoXZthN1LucVDTrmXg4K8YM8Ma8AL+UOO8ZUEw/VlOW+GD6ZTNH9Bzr36ROwT2Gd+5hjbYAESOGHLmHPcgvBc+6bieqF5nHdZ7FUhBK+AN1OSMobteZxrHAV2R2FqorSn5B7eGdzyjUVpqZhRpcDMluafwW0fGjFvwTlbC0wnZZu8+xgA+FjczEJYLUHc8esqfUZ3LK3ltwX1MsJeASS9ZeQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiocv4vJpTiP/dD85z88IV6iH9xmI16WeZvnFW2lK2s=;
 b=SMo3BAPdTS2pB+Uy7hSRbRgxiuQ5nN+RQMZDsH0Nuorev/kD43sgyFS6RtpmB2f4Jp18cGjh3ur+HS1jqVA/m8EWGrXVQGfNgpXypwnb4KdyC8ELzFvmx6YNWjKuxZN9dH+xlvc7kP4McZQtd35mCeJ9/JtkKR6sZm6eKb27GL3i5kg/6iAb4VOc+NH2d54LxZsa0nXojxxZ/jVQK6LTH6wASjkVmm8AAzbi917jPLmq5FDJ3VgtZO2PSEhH5urEbe7mJvzrc3aDichGS97trKNy0Ak1PBriYKke3caueiBPK1cTFhlNG+EXc3cNGv428D3dYBIETsv9h2gRL+4vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiocv4vJpTiP/dD85z88IV6iH9xmI16WeZvnFW2lK2s=;
 b=t05q7mLwlMP6Uls1d8yrkU1dTJhMbJesLZwsjJ32s1aYw2CitZchzN1VohDMWlJ/SZYy6oK0/inaQ5xYMs9QEHwoWVhoHHNMjSN+E84Uany4ENkF55jCP0PtPaGAmg44keyfCyqmoPSVojZ8M+6HbjSjFr6vORT2txWLkTgpzH6vf9tB/nXFXEdOt4gcgccr0MnezqPj56+HS1t6mrF+lPVSqyJ3YoMyDg+WAKi9IlR7oCR7GQT1Lslg8GT8p3hzrRdSMwZTMD18DlJmgJMMimWJVKka8ygj3QXlzLDrKocQJH4ghY25tTf6tGjmH8MUNOiwmu38wFDtOqrnILdzLQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0015.namprd12.prod.outlook.com (2603:10b6:300:df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 06:52:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 06:52:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme: add KConfig options for debug features
Thread-Topic: [PATCH 3/3] nvme: add KConfig options for debug features
Thread-Index: AQHX7bg+0z2vwmZ6tkKVZ870DSJHNawumBKAgAF1qoCAAB4HgIABeF0AgAA0+ICABHDLAA==
Date: Fri, 17 Dec 2021 06:52:33 +0000
Message-ID: <41fef62e-8e48-d286-8156-c4745f767370@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-4-chaitanyak@nvidia.com>
 <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
 <492750cf-b031-5709-0836-c28e475c29fd@nvidia.com>
 <6a1d326e-ce96-ef9e-f09d-7ebdc9ef6084@grimberg.me>
 <8dfd8447-426b-21e5-c988-43877fc851dd@nvidia.com>
 <916e5eeb-8cda-b369-f216-6f7edefebb7e@grimberg.me>
In-Reply-To: <916e5eeb-8cda-b369-f216-6f7edefebb7e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5222bf5d-7591-4db2-8e8a-08d9c129cd51
x-ms-traffictypediagnostic: MWHPR1201MB0015:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB001545CF400BA69A27B5272BA3789@MWHPR1201MB0015.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhnHddj0AM4Nda3kr4LVG6OFQZi+S8VPkH6cNv5HeoUFSUuakuX1NZuAbBl7ka9VIVqWtEGieYjSJ2cYlfO5OjyPeBN7kgYtIE07KpyUmrxpD3HQFT+gWsfzZUPhsEgWIpe88aSQ1aRFIi9NLqaZS0HjU20JoRElz7kauxuu1Hwvhn78mZNbod7tJfUA9ZR/QDevbFNbNOEwQR5GNeV+aa/dtd1Dl2MWrWJJaPFDtlrGBEoH5etj9EJbBT6MxYY+Yvk0HBk60wOv2lG9YR3J1yr762wMi8fvvHFBUsHSunGIRfdkR8LAPAYlZpnbdbCJspzEWzXJK5znPAslEbkul1pWBKv1b1CHHkXFBGKZzVCBjTBS6XaXTMD8fjsK7UPNENPsVqzA21zpyuW2RbNXMmZMmAjbd9qlLAyhURFmzPMPVbD3I0Vxavu7uuO+YjsqikrXAfNI4Qhk4E8zcon3dZGtefhMNNSTKwQsac6BFDWuwJIc8cOgozaBURxzHngtZ6QcE2GVJifETnollMWpzpGpNHQYxHGtYpcr0Z5xfxbWIuApRJca2KDrUJTqzjK4bAxwkv+u21Rmp0YmenLwvkh0ZZyeOYjbGqfDrgg+SndI8DQTNwK3h7HdoVkrHPGCghNf6fsYFWndM41fjdx3ezGH5Ru1W01VnO4DUu/vHfjKBB/hiBnDCORfXds8kMzxHD+bAzyUakIvqUyt6XN9CesmEjsp+Ht18w+clxv1BYxHC205BtfK6nJaDcmbcxGXevBxLWUlGrhgAdOva8JWGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(8936002)(31686004)(6486002)(2616005)(54906003)(4326008)(83380400001)(86362001)(6512007)(71200400001)(508600001)(38100700002)(122000001)(316002)(8676002)(31696002)(66446008)(64756008)(36756003)(76116006)(186003)(91956017)(66556008)(66946007)(4744005)(5660300002)(66476007)(2906002)(6916009)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUQ0OHRrRVhkSEJWUVRyaUpBYWVpZTQyNVk5WlMxUmtQMzdZWkFnLzdBbUlz?=
 =?utf-8?B?SWlPd1gwQ2lodmZsNVBhWmR1NkdwZVl3blUvUTVZNU80Tk5vQytzZXNOYURk?=
 =?utf-8?B?bWpRR3E2Q2dMVHZoWGxLSmloOWxHQkR3bDlGRmNlRWxLWUl6L2xGNFNhZGVs?=
 =?utf-8?B?VVVpT3M2OTdETU5XTnNzOHkyOS91eE5sSUxxZEdtbURjT2lGcE9keWxSR2tU?=
 =?utf-8?B?dm4rQ2swS091NXNFNThtaDZaTmVzSmtZQUF4bmZiRGpPL294RFViWDNIVERI?=
 =?utf-8?B?dVVWdUtLWUVUYlV0WVNEelk4WTRudnUwTU9IRU01WC8vTU9zcHlpMGc0ZElH?=
 =?utf-8?B?Wm9VVHlrVWtqdTVwbnlGWnFxWTRySm8wRGJYcUdYSEVUMHR3MzlzSUlVNnJ5?=
 =?utf-8?B?VFROaGFoMlEvc3ZqUzNQT1RkbVZSWGdCU1pRSklTSGJyTkp6MFUxRm5VazBh?=
 =?utf-8?B?c1FHM2FybnA3WlV4VkJlMGRYWVVjVTE4STlPVVRJSDl5SUNraXIwaytvUnY4?=
 =?utf-8?B?bWdtTE1Id2Y4T0NObmlab2tud0dscEc2b05ENUNWMXFpTFNBeFNHZU91MHFi?=
 =?utf-8?B?TWt1YW9Qc0liSU91dk1abUw3Y004R0VaSlYydGdURkRqSGNJcnRtbm1BTXpn?=
 =?utf-8?B?QVkrbkh4TDFjNjBxa0l2TkNrRFVBWG5DN2pld3pST3Y0d1ZvS28vRE44N2Ri?=
 =?utf-8?B?N25pWmVTeTNtOG02d3R6ZXA5YlVZNkg4dkVtZitIcEo5WjE2cUgwQ21HQmdB?=
 =?utf-8?B?UC9Pb29oL0Nid25xMFVTU1B5a2NzTnJJNTJ3K2VrZ09xTmQvS0x3YkF6ZzFq?=
 =?utf-8?B?ZkVvQmFIYVdOMDEzcURndW5FejhLU3YrY2RhMzhmT3pkWmdjNkp1VlpKNXAv?=
 =?utf-8?B?bDNMSVdxVmwxc1RGKzgvQ1pHZFM1cFJVU2N5aXJRZTNMVmdtNnloU2g4WEJS?=
 =?utf-8?B?MVN3elVuREV6N2pRSHBvWGtCb0FsbGRSUUt6M2FtNnZWR0xRd1VZWmZZQmZs?=
 =?utf-8?B?Q3lXSVlvTWlSQnU2UDhUbVFWWC8zZ2xjaVgzTVl0NmplbTE0SWVzK3FrOU9v?=
 =?utf-8?B?aUMxeDBDQ2UzTW5MY3ZTcFpSaWZxdmhZdHBwNVUrM1U3SnRzcldwMnJPZFZk?=
 =?utf-8?B?TE5SdUpFTHRUMWVNbzlMTDg3M2pqcEV2NE9GTzJCM0lHTVpPRUQ3TDI2SGJj?=
 =?utf-8?B?cVpDMlFWRGJubHNqTnZyd09GUHFiZWxrdzc0ZnM3SWFmci85akd3MUEvSTh2?=
 =?utf-8?B?ajQ3SlBncVFSSWVmcXVpbXF1azZaS3VWRUY0R0FQSUNuUkFta0hTckt0UHZ0?=
 =?utf-8?B?cmlGRmlvc2RDTHArWmVGZU1PZzRqTFVNaTEwT0E4OHJpZzVJSTdHLy9CQWw3?=
 =?utf-8?B?cW1LSnI1Q0RDdnJsYXI1OUVnUjJSZ0dycXJDTTQ4VzV5b09WUE10V2pEdWhS?=
 =?utf-8?B?MFFRTzFrYVJTTzZrdVdFNzdGRC85bytLUkhPUFNxRWVxOTI1TmJBaDVyYy9p?=
 =?utf-8?B?S25RQmcwcGUzTG01T1VVbTcyNm5kYW50RmhnTmczRXN3aytuVDAwSng5d0pv?=
 =?utf-8?B?aWJrVVg4L1JGU0J4dmpZcXRzRm9TREVBRExzak1UVFU2Y3dvRGVCM0duNVV5?=
 =?utf-8?B?UWhYek9FcTh2WGlLa1Z0TjBYN0c0Skd6OXBWYmc1TDR5c2NBVUJ6S3RZcnhx?=
 =?utf-8?B?dWQ3enlZOHlwSnJYem1iMVkzdTFYS3FGZnJTRzc4dy9ZM0EvOXUwNmYwb3Zo?=
 =?utf-8?B?ZlBxQU5aOHUrWWJKUTIzZGpLME9OTmY3ZFcybnd5MkcrcDMxaitDRXE3aDdP?=
 =?utf-8?B?L2NEcm0xLzRNVitpaXJSaGVmb1FHRFJpZWtLQW13VzdPV1F3b25PZFczY0Jy?=
 =?utf-8?B?R2tid0tYQUFFd3ozMDBld1NPbExrMVB4R0NrTHFlYUZIMzlJNmNPaUx3cXdH?=
 =?utf-8?B?TVIxSW96ME12KzV0Q0FSNFcvZmIyRnEyQ0l5VkhZK3k5Nm1ySlNXUWpDM3VN?=
 =?utf-8?B?Yk5tallBbU0rVU82UVFWVUlkQXUrMmpKaE9xU3dld2lJakhrbjRPQW9RV3Y0?=
 =?utf-8?B?TG5idjZla3EwUWhRdlY2TzFuSTBTajNmTU5rOU1wTUF0MGV6ZWF5MVIraVBj?=
 =?utf-8?B?dHFjRmoyL0lhSXZDcGdkWE93S2N1M1gwM2JEa3VSRkhPUkluKzVBbVJhSWw5?=
 =?utf-8?Q?2df9DFrN1+nZuh2jRsnUHcbIB9m7LzS6AGXrfUB9ubSt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D734C99C636C084A9B6B864488F737C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5222bf5d-7591-4db2-8e8a-08d9c129cd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 06:52:33.1120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Te+SvkAUeGuATE4e61dCcSR6UDIRmSAao6Tv9tiOCJpxMEokV+xy4LUsnXdgHIW4ZmWnJr7CMutCKrRorpc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_225236_750226_6F767305 
X-CRM114-Status: GOOD (  14.94  )
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

Pj4+PiBBIGNvbnRyb2xsZXIocykgdGhhdCBpcyB1c2VkIGluIHRoZSBwcm9kdWN0aW9uIGVudmly
b25tZW50IGdvZXMNCj4+Pj4gdGhyb3VnaCBxdWFsaWZpY2F0aW9uIHByb2Nlc3MgZnJvbSB2ZW5k
b3JzIGFuZCBmcm9tIHRoZSBjb25zdW1lcnMNCj4+Pj4gdG8gbWFrZSBzdXJlIHRoZXkgYXJlIHN0
YWJsZSwgc29tZXRoaW5nIGxpa2Ugc3B1cmlvdXMgY29tcGxldGlvbnMNCj4+Pj4gZGV0ZWN0aW9u
IGlzIGEgYmFzaWMgcGFydCBvZiB0aGUgcXVhbGlmaWNhdGlvbiwNCj4+Pg0KPj4+IEkgZG9uJ3Qg
dGhpbmsgdGhhdCBhc3N1bWluZyB0aGF0IGEgcHJvZHVjdGlvbiBjb250cm9sbGVyIGRvZXMgbm90
DQo+Pj4gaGF2ZSBhbnkgaGlkZGVuIGJ1Z3MgaXMgYSBncmVhdCBwcmFjdGljZSwgYW5kIGNvbnRy
b2xsZXJzIGV2b2x2ZSBkdXJpbmcNCj4+PiB0aGVpciBwcm9kdWN0aW9uIGxpZmV0aW1lLg0KPj4+
DQo+Pg0KPj4gVGhhdCBpcyB3aHkgd2Ugc2hvdWxkIGtlZXAgaXQgY29uZmlndXJhYmxlIGFuZCBs
ZXQgdXNlciBkZWNpZGUuDQo+IA0KPiBPSywgc28gdGhpcyBhbGxvd3MgYSB1c2VyIHRoYXQgaXMg
YWJzb2x1dGVseSBzZXQgb24gc2hhdmluZyBmZXcNCj4gbmFuby1zZWNvbmRzIHRvIHNhY3JpZmlj
ZSBhIGxldmVsIG9mIHByb3RlY3Rpb24gYWdhaW5zdCBidWdneQ0KPiBjb250cm9sbGVycy4gSXMg
dGhpcyBhIHJlYWwgdXNlLWNhc2U/DQo+IA0KPiBGb3IgdGhhdCwgSSBndWVzcyB0aGUgY29uZmln
IG9wdGlvbiBpcyBmaW5lLCBidXQgdGhpcyBhdCB0aGUgdmVyeSBsZWFzdA0KPiBuZWVkcyB0byBk
ZWZhdWx0IHRvIHkuDQoNCk9rYXksIEknbGwgc2VuZCBvdXQgVjIgd2l0aCBkZWZhdWx0IG9wdGlv
bnMgc2V0IHRvIHkuDQoNCg==

