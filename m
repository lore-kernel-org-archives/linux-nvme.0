Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B618C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTuoBK0xyRuh7LgQGP+bn+pq1EdtV9S1lmM+5pEeSgU=; b=pqYT7duzBKX/pcApSvCM5W+yRq
	b1L0nhT1//M4jSe59YHK6pyTTsLipf47yr2M4vsWHM8HrwHR8Rx7/3nF3qppofqjPyhz6EQgeF/W/
	3X0cnsTNceA/Hnu4DOPZyClLVB2QTtvcXnKIBhAdSsdUY4FI+/QML6Xa+98pK362CGBeS/TmkedIW
	B2A8ahLY/ZySZIwM4suZRwdt4Ct7+aZ9xKbouozI0+mzLWhyjT4rnpWneKlsE8jl9TF1U0y1HWllb
	byW+MEvG/DzwczT8dXXTKL6CnUF6MLf+k4K+2yuvp134+knGgPGjzo0BXVFFi7x5+Fe76dz9AYWTm
	rjKmDNFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJe1N-00FxtG-Fy; Mon, 14 Feb 2022 16:16:13 +0000
Received: from mail-dm6nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::606]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJe1K-00Fxs7-0H
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 16:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGkyuJMhZ9+CzjLFl1AsPVrbtMk/og3o4xpJT6iuN+raSsr3cfDmDdqb9eb/Wy+WvtMc1fLdt0DJ4yFe8VGpCGPMKHzXktaJIv22vUuaEGht9nHingsma++ELD80OgAf8LWs/h/ka2RxliXRa9rlbh2GF82ir1n6lfsa4L+raqWvyqNlynpPusSDLZCpUabpVZggyPQLhrFpJ0ku/CQKuZdMRemoUvTI0mpwtT5XycC1/l+dnAnUiszRjEbVYzsAyPRV5MWY3ozq4zfM4FARpwBIRZzAW/JgkItbLq8KvEM2gVVSm10uUhymea9qUc0k9KdAn+zK5hg0rDwr+4s4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTuoBK0xyRuh7LgQGP+bn+pq1EdtV9S1lmM+5pEeSgU=;
 b=U26ADtA2Z2btvTyDZGZzPruKZeuAhMYZiEsigeyunl0SG9K0KHCmkzpII9m2bf2teU9kQBAP6NuyioTB95kPOjZui5J2sPBYK9McBNdavgJ4kFmxAWdTyVtQt1ZWk1VzJ7Pdh0lBlcKoO60O9irRy/Pj/8t5NEZmCQUMmb8n2uQjrxtOBqaLaYsW6s5oUmxOjbZK9vmOLlVuTBR+ArKSEWRMJNIBEbimoj2317ViDmXnuNQElSJi34ASDO57yt0qc/0BLv8srxcuWOH9d2Wa9gp1PhQPAmVy3OwzmcgGZHeGPxCwJtZVs+EdXOPNeocxnm1YTQagP6O47C2XBjaAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTuoBK0xyRuh7LgQGP+bn+pq1EdtV9S1lmM+5pEeSgU=;
 b=CFm4qYjHu8zf2wtOTzziVI6o1WfrSKXJi/+UD6q/jKHj9DPf+EULlR3/2YTG0uI1j4OpOcD+LmEx/Oebl+IQk126nc2j7wu2iUbZfQAlbVBmRdE9sOpy+P/3yGPvgiE6nNjZNoefR7JgTwjsQoOXOuy4BO1ATDAXVPZ8iLecwEJnq3kCfqYD+MQxDXivJbYPsvu/tGbHZerxi/XWJm08lFsbhsayCfK5W8/Leb8num5OLC8SFCOWErdsO7SiuygjU2GH7lQkAjEU5CaXuvp5amH4kZo4O9+ckPjn1ptV1Cl/jkujrghOcl7k9FTNupd/MJu9MS6t5UhyMOFB1pCm+g==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 DM6PR06MB5276.namprd06.prod.outlook.com (2603:10b6:5:10e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Mon, 14 Feb 2022 16:16:04 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::9840:ae48:4da1:d462]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::9840:ae48:4da1:d462%3]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 16:16:04 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Hannes Reinecke <hare@suse.de>, Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: RE: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Thread-Topic: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Thread-Index: AQHYHs0Be/BEM6D7ckeNgD0k2kpTw6yNjQdQgACG5wCABPi+gIAAMDFw
Date: Mon, 14 Feb 2022 16:16:04 +0000
Message-ID: <DM8PR06MB7704D092EEAE68C75EE33CDEF1339@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
 <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
 <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
 <3de626e3-4d03-50a8-9bd2-c974227add02@yandex.ru>
 <4cd1f9c1-e31a-2a41-1f96-ba54103cc3a2@suse.de>
In-Reply-To: <4cd1f9c1-e31a-2a41-1f96-ba54103cc3a2@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.400.34
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f66ea74-abab-43c4-4709-08d9efd54ca5
x-ms-traffictypediagnostic: DM6PR06MB5276:EE_
x-microsoft-antispam-prvs: <DM6PR06MB5276D90330563E8A5AB05E7CF1339@DM6PR06MB5276.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYUE/1z9xce6tIVJTcGPrxGCe8Oz+lpIiMSh5PsSE6nJN+1QMeY/eXbT45kYwMVlsPWuWyn4WVfq8F1nwOqQKswgQwIdHcFxFWpImdqL9u7jXg6g8ZqsU9EWpkuKhLgWxd8Hyg5XcwNICJo321J5LtzLg8PUKZCdlcN+ZENjYNQO+kHqujRd/XV6MhmBpBtW3sm+DkCkywIg/4ZFqKtz7DxS45FwzA7k/WVtplBC+qpglyPSRenekyu8OjhFH8bVso1ZFNS5cyw8GlYk7x6h04T4n/1ntEMsB2qaJwc+zX59v4t7oR6Qdh0+J0Gh3F2QK3KWrt41x9WS6xttGdymIBWL4pD8+nAWgZn36F46NXjjgXtGjz5caVGcsc/cSMXwfhMkerbTcXRfkWuIelDvXpHSguQskhGmtAvf/vEPvKFDB9IDegc5nxhsOT+J45B86EFVAy14HKdWgP5BPF8x7JmQMn1Dooz+rcewBVc3fDMTCswKnyi90X25M8aGxxQsc/Ko6DvX6t+CYEHwUV1PFeHSFoYVZFqbiSsJQmoQC1owCqyQsvn4CgzpEpmDwxdkLsHv66ibRlQJEAgiWn1UWn7TXQYtDkFbtI8F3ZXga00EiEp+/d1fStJiumoHUwOB+9itmSqbWQpMVi6AKhkUHrr6VuSWR2CGbiSFih6NM1SYMxUpquozGlhgX0QouFDA7wXdmPE94pnaL8k/eAbvXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR06MB7704.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(71200400001)(2906002)(33656002)(5660300002)(66574015)(55016003)(86362001)(66446008)(8676002)(66946007)(66556008)(66476007)(64756008)(53546011)(110136005)(6506007)(52536014)(38100700002)(76116006)(9686003)(122000001)(186003)(38070700005)(8936002)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkdsOWZFdnJtZktZeWxDUVJod0NCOEdhQ2NqQzVqZnh5MTdvb3FxeGdSTjEw?=
 =?utf-8?B?bUdML3piRTZEOTk2bUY1TWdmYkRYc2NqcStKejJMVjlUdDhsN3Irckp0L05F?=
 =?utf-8?B?TXcwUkJHRytHZElSdVFZVmhRdGFCemJCZjJ6UTltTjJCZy96YkhGU0kvSnBN?=
 =?utf-8?B?OUdpRWhNckVyRkxIcTBPODM4aTd6K2xZTlgyOXlXV0JDc0VZSHJSN2FqQzhS?=
 =?utf-8?B?YytzU0ZsL1RtU0hNVnIvbElPQkhZd2lqaDFMZjlIYU9RK1BMZ20wSnFkUDQw?=
 =?utf-8?B?dVdoeWYrSXhHWWVjclpXSmpHbVFJSjRlZmpGWGlINVp4YU1WTWg2cy93YUdx?=
 =?utf-8?B?Qi81MjdWSkhOWVBVSEJ3ZFdLU3Q3N3JOVzM4MWJxeXlqSWlhenh0RlY2QjRh?=
 =?utf-8?B?STlrMUNZblVsNVhmL3FhaGp0L0JlT0ZPL0FFbUdPYzFPZFFkNmUvYVpGSVNJ?=
 =?utf-8?B?UWFMZHkwL0VnRTdFdHpqaGRWTVBWSjY4cnNja0dVaUczUWFSek1SZ1l5bUx2?=
 =?utf-8?B?UVMwK0gzc2N0SWJwUDhNb0ZCa3V3N3prOU5KQ080UW5kU2laQWxnVmtaTDRj?=
 =?utf-8?B?eHpON3ZSVTZsT2RWMjB2VzUyMTBLVm5oRmV0TTY4NzZrK3lwM1RxTitGVThs?=
 =?utf-8?B?YWZJdW5naU5zWlNyaEJ2UlFTemczZzFtbitEUDVzWXJXb2FlWDZaTnYyUndZ?=
 =?utf-8?B?citkcGprbmpUOHlvOFI4MjRWV3RQUC90K0JoSVJVS1pUdjJaV1BpZWt4Vlky?=
 =?utf-8?B?ckNGT29ibDJzL2Q4OUptUGd2cm9yVFFXZk5IMU5tU3BoRVBGeVYweTBZSUNN?=
 =?utf-8?B?TS9qUS9ySDFKYUdHVXNKRGxKTlplZGs0YVZHWlYvR09TaUdFRlRXeGZCVUZ1?=
 =?utf-8?B?Zzc2SVVrNm8vZnVrRVN0Z2owbmdtYmgrTDZjQ2RtZVZvTmZqM0JiZG5pWHlv?=
 =?utf-8?B?OUY4Z01JQXhzRk1SQUNwNHhOc2N3bDhlcWFpN1FrVDVBdHJZWDBmcjhKRG93?=
 =?utf-8?B?QXJVaklDRWU5UnFscWVPTWhUZmwwMWo1cmdSTldJbjhmNTdwWW1hY20rMmJH?=
 =?utf-8?B?djZqQWVpeEVLYUFYbGZNYXFwOElKRVc2aDZDZThkV0R0MlNZSVY3N0c5YS8w?=
 =?utf-8?B?Mm1CSEdrc2NaS1F2cUhOU0hheHJISnBPeXBDUnMxc2ZWS1BiUUNDTmlWYzJT?=
 =?utf-8?B?QUZYWkoyR0xTK21xUW1mTUVoNmFTVXE1OEhvODJ6MWwybGdISlV0L0lOME4x?=
 =?utf-8?B?SXF3cWI5T2FMNXZVUVI3L0txWVJweHh6dmphWnRwZCtHTGM0RWdWWmVnNzRX?=
 =?utf-8?B?bFMwVytZUE5ic1NQd2kyenBxR0NnNEd5V2FyR1NNM3lET25vWTdLZ0lHNHBC?=
 =?utf-8?B?Sy9YZ2dYbTJZdkZ2TmtFc0lwQVBZc2s1Q2VMdjc5WnZIOTkyZjhITHNtRWtG?=
 =?utf-8?B?a1FiRUZCcVY2RHhSMFVWUzdneXpIWXRWN0p1U3FKZC9xOFR0UmJZUEJlOXA4?=
 =?utf-8?B?TGZUeVU4bXFPNWlEcDFWOUN0b3VvK3dvYUpEQk15VElGc3ZGOStkdHVEUC9Z?=
 =?utf-8?B?WUQyT3plV2xXL1NNWlluSC8wR3hHZDg0cTdobjBFMnFOV1FPd1IvMTNkdnJl?=
 =?utf-8?B?U0c4NlhoOGRFdkhrRHR0cFBWVkkxbTl3SUlUcEVUZVhmMjh2b0tlSjhlTUtZ?=
 =?utf-8?B?SzdEekJTTExndTVOOEhhc3VwY2NiWjB2U3BoYW9PcHFIQ2NqamdRZFlqZ2VX?=
 =?utf-8?B?UjFOV3ZhMGc3Mm9nTmRaSDM5Z2JZL280Smo0MDYvZEpWRDdQbXhEZmhScHht?=
 =?utf-8?B?a1VrV1dnWTFnSFR4TGhCSkJieXJTQklsV1VFcUl2UDYvZzZXNXB1K0F6YWhj?=
 =?utf-8?B?NEpLREhZekJvTU9tRnRTOHBROTdVR1BZZVRGLzNid1hhajYwbzlMTFJMa2hx?=
 =?utf-8?B?SGp6ckNnVkpMTndhZWxEMEtaYm91UmQwcXRoUmdtbytuUUZhKy9CUTUxd256?=
 =?utf-8?B?MEF3NHVjK2VoVFdPTDRoSWtPd2hRWlRKenhZbS9oUWZIUHp4cGdBdktObTlq?=
 =?utf-8?B?RktCdk9LbFh1VnJuU2N2SU1VQ0U3RmFISHZyVk9ZK0tLQk9JZURaWS85Nmxr?=
 =?utf-8?B?YWtqdEdRRS9sTUp5RG5nUng0SE5nT1dNY1Fkc0RXOWJORHNJamxsTkJ5Nm1G?=
 =?utf-8?B?UFhjOW90L3d2K3NjK2FzRHp5VTN5aDk2MTN0Y2tpYThjdkg4RnhQTUxDY0w0?=
 =?utf-8?Q?TnlQ35mYvoAGsT2WKMzKn+KJdDSksDnuryDv5dnBv8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66ea74-abab-43c4-4709-08d9efd54ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 16:16:04.1827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQolkiQ0ffqOUKP1nD2cCYRSdY2srwhcifGxvP2DEQ8CubSnMRtil7xrY83Uk56Gi4lIhAwKfFsLxCQxecXFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5276
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_081610_946028_25961A8A 
X-CRM114-Status: GOOD (  30.89  )
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

PiANCj4gT24gMi8xMS8yMiAxMDoyMSwgQWxleCBUYWxrZXIgd3JvdGU6DQo+ID4gID4gW0ZLPiBd
IEkgdGhpbmsgSSdtIG1pc3NpbmcgYSBidW5jaCBvZiBjb250ZXh0IGhlcmUuIFdoYXQgaXMgdGhl
ICA+DQo+ID4gb3JpZ2luYWwgcXVlc3Rpb24/IEkgdGFrZSBhIHN0YWIgYXQgc29tZSBhc3N1bXB0
aW9uczogV2hhdCBpcyBhbiAgPg0KPiA+IGVtcHR5IEFOQSBncm91cD8gVGhhdCBpcyBhbiBBTkEg
R3JvdXAgd2l0aCBOTyBOU0lEcyBhc3NvY2lhdGVkIHdpdGggID4NCj4gPiB0aGF0IGdyb3VwLiBN
ZWFuaW5nIHRoZSAiTnVtYmVyIG9mIE5TSUQgVmFsdWVzIiBmaWVsZCBpcyBjbGVhcmVkIHRvICA+
DQo+ID4gJzBoJyBpbiB0aGUgQU5BIEdyb3VwIERlc2NyaXB0b3IuIFRoYXQgZGVzY3JpcHRvciBj
YW4gYmUgdXNlZCB0byAgPg0KPiA+IHVwZGF0ZSBzb21lIGhvc3QgaW50ZXJuYWwgc3RhdGUgaW5m
b3JtYXRpb24gcmVsYXRlZCB0byB0aGF0IEFOQSAgPg0KPiA+IGdyb3VwLCBidXQgaXQgaGFzIG5v
IGltcGFjdCBvbiBhbnkgSS9PIGJlY2F1c2UgdGhlcmUgY2FuIGJlIG5vIEkvTyAgPg0KPiA+IChz
aW5jZSB0aGVyZSBhcmUgbm8gTlNJRCB2YWx1ZXMpLiBTbyBJJ20gbm90IHN1cmUgd2hlcmUgdGhh
dCBpcyAgPg0KPiA+IGdvaW5nIChiZWNhdXNlIFJHTz0xIGFsc28gY2FuIHJldHVybiBBTkEgR3Jv
dXBzIHRoYXQgaGF2ZSBzdGF0ZSwgYnV0DQo+ID4gPiBubyBhdHRhY2hlZCBuYW1lc3BhY2VzIChp
dCdzIGEgd2F5IHRvIGdldCBncm91cCBzdGF0ZSB3aXRob3V0IGFueSAgPg0KPiA+IE5TSUQgaW52
ZW50b3J5IHJlcXVpcmVtZW50cykpLg0KPiA+DQo+ID4gVGhhdCdzIGV4YWN0bHkgcmlnaHQsICJu
bnNpZHM9MCIgY2FzZS4gSS9PIGlzIG5vdCBhIHByb2JsZW0gZm9yIHN1Y2ggYQ0KPiA+IGdyb3Vw
LCBmb3Igc3VyZS4NCj4gPiBJIHN1cHBvc2UgdGhlIG1haW4gYXJndW1lbnQgd2UncmUgaGF2aW5n
IGhlcmUgaXMgdGhhdCB3aGVuIHN1Y2ggYQ0KPiA+IGdyb3VwIGhhcyBhICJjaGFuZ2UiIEFOQSBz
dGF0ZSwgdGhlIGhvc3QoIm52bWUtY29yZSIgbW9kdWxlKSBzdGFydHMgYQ0KPiA+IHRpbWVyIGZv
ciBBTkFUVCB3aGljaCB1cG9uIGV4cGlyYXRpb24gcmVzZXRzIHRoZSBjb250cm9sbGVyLg0KPiA+
IE5vdywgSSBkbyBub3QgZGlzYWdyZWUgdGhhdCBoYXZpbmcgc3VjaCBhIGdyb3VwIGlzICJ1Z2x5
IiBidXQgcmF0aGVyDQo+ID4gYXJndWUgdGhhdCBBTkFUVC1yZWxhdGVkIGZ1bmN0aW9uYWxpdHkg
Y291bGQgYmUgb25seSBpbnZva2VkIGZvcg0KPiA+ICJubnNpZHM+MCIgY2FzZSwgc2luY2Ugb25s
eSB0aGVuIHRoZXJlJ3MgYSByZWxhdGlvbiBiZXR3ZWVuICJjaGFuZ2UiDQo+ID4gc3RhdGUgYW5k
IGEgbmFtZXNwYWNlIHZpYSAiQU5BR1JQSUQiLg0KPiA+DQo+IEFoLiBTbyBub3cgSSBnZXQgd2hl
cmUgeW91IGFyZSBjb21pbmcgZnJvbS4NCj4gDQo+IFRoZSBwcm9ibGVtIHNlZW1zIHRvIGJlIGFy
b3VuZCBhIHN0YXRpYyBBTkEgZ3JvdXAgd2l0aCBzdGF0dXMgJ2NoYW5nZScuDQo+IFRoZSB3aG9s
ZSBpZGVhIGJlaGluZCB0aGUgJ2NoYW5nZScgQU5BIHN0YXR1cyAoYW5kIEFOQSBncm91cHMgaW4N
Cj4gZ2VuZXJhbCkgd2FzIHRoYXQgQU5BIGdyb3VwcyBjb3VsZCBfY2hhbmdlXyB0aGUgQU5BIHN0
YXR1cywgYW5kIHN1Y2ggYQ0KPiBjaGFuZ2Ugd291bGQgYWZmZWN0IGFsbCBuYW1lc3BhY2VzIGlu
IHRoYXQgZ3JvdXAuDQo+ICBGcm9tIHRoYXQgYW5nbGUgaGF2aW5nIGEgJ2NoYW5nZScgc3RhdGUg
bWFrZXMgc2Vuc2UsIGFzIG9uZSBjb3VsZCB1c2UgdGhlbQ0KPiB0byBzaWduYWwgImhleSwgSSdt
IGJ1c3kgdHJhbnNpdGlvbmluZyB0byBhbm90aGVyIHN0YXRlIiB0byB0aGUgaG9zdC4NCj4gDQo+
IEJ1dCB3aGVuIHVzaW5nIF9zdGF0aWNfIEFOQSBncm91cHMgdGhlIHdob2xlIGNvbmNlcHQgYmVj
b21lIHNoYWt5Lg0KPiBXaGlsZSBpdCdzIHBlcmZlY3RseSBva2F5IHRvIGhhdmUgc3RhdGljIEFO
QSBncm91cHMgd2l0aCAnbm9ybWFsJyBzdGF0ZXMgKGllDQo+IGV4Y2x1ZGluZyB0aGUgJ2NoYW5n
ZScgc3RhdGUpLCB0aGluZ3MgYmVjb21lIGlmZnkgaWYgeW91IGhhdmUgYSBzdGF0aWMgJ2NoYW5n
ZScNCj4gc3RhdGUuDQo+IFRoaW5nIGlzLCBoYXZpbmcgYSAnY2hhbmdlJyBzdGF0ZSBpbmRpY2F0
ZXMgdG8gdGhlIGhvc3QgdGhhdCBhIGNvbnRyb2xsZXIgd2lsbA0KPiBuZWVkIHRpbWUgdG8gdHJh
bnNpdGlvbiBiZXR3ZWVuIHN0YXRlcy4gQW5kIHRoaXMgdHJhbnNpdGlvbmluZyBvdXQgb2YNCj4g
bmVjZXNzaXR5IHdpbGwgYWx3YXlzIGJlIGJldHdlZW4gJ25vcm1hbCcgQU5BIHN0YXRlcyAoaWUg
ZXhjbHVkaW5nIHRoZQ0KPiAnY2hhbmdlJyBzdGF0ZSkuDQo+IFRoZSBzcGVjIGRvZXNuJ3QgYWxs
b3cgdGhlIGNvbnRyb2xsZXIgdG8gc3BlY2lmeSAiSSBuZWVkIHRpbWUgdG8gdHJhbnNpdGlvbg0K
PiBfdG9fIHRoZSAnY2hhbmdlJyBzdGF0ZSI7IHRoZSB0cmFuc2l0aW9uIHRvIGFuZCBmcm9tICdj
aGFuZ2UnDQo+IGlzIGFsd2F5cyBhc3N1bWVkIHRvIGJlIGF0b21pYy4NCj4gKEJlY2F1c2UgdGhl
ICdjaGFuZ2UnIHN0YXRlIGlzIHVzZWQgdG8gc2lnbmFsIHByZWNpc2VseSB0aGF0IGNvbmRpdGlv
bi4pDQo+IA0KPiBFeGVjIHN1bW1hcnk6IGhhdmluZyBzdGF0aWMgQU5BIGdyb3VwcyBpcyBva2F5
LCBoYXZpbmcgYSBzdGF0aWMgQU5BIGdyb3VwIGluDQo+ICdjaGFuZ2UnIHN0YXRlIHF1ZXN0aW9u
YWJsZSBhbmQgbm90IHNvbWV0aGluZyBJIHdvdWxkIHJlY29tbWVuZC4NCg0KW0ZLPiBdICBUaGF0
IGlzIHRoZSBwb2ludCBvZiBBTkFUVC4gIElmIHlvdSBnZXQgYSBzdGF0dXMgY29kZSBvZiBBc3lt
bWV0cmljIEFjY2VzcyBUcmFuc2l0aW9uIG9uIGFueSBJL08sDQpUaGVuIGFsbCBuYW1lc3BhY2Vz
IGluIHRoZSBBTkEgR3JvdXAgdGhhdCBjb250YWlucyB0aGF0IG5hbWVzcGFjZSBhcmUgaW4gQ0hB
TkdFIHN0YXRlLiAgQWxsIG9mIHRob3NlDQpOYW1lc3BhY2VzICh0aGUgb25lcyBpbiB0aGUgc2Ft
ZSBBTkEgR3JvdXAgYXMgdGhlIG5hbWVzcGFjZSB0aGF0IHJldHVybmVkIGEgc3RhdHVzIGNvZGUg
b2YgQXN5bW1ldHJpYw0KQWNjZXNzIFRyYW5zaXRpb24pIGFyZSBhbGxvd2VkIHRvIHN0YXkgaW4g
dGhhdCBzdGF0ZSBmb3IgQU5BVFQgc2Vjb25kcy4gIFNvIFlFUywgdGhhdCBBTkEgR3JvdXAgbWF5
DQpTdGF5IGluIHRoZSBDSEFOR0Ugc3RhdGUgKGJ1dCBvbmx5IGZvciBBTkFUVCBzZWNvbmRzKS4g
IElmIGl0IHN0YXlzIGluIHRoZSBDSEFOR0Ugc3RhdGUgZm9yIGxvbmdlciB0aGFuDQpBTkFUVCBT
ZWNvbmRzLCB0aGVuIHRoZXJlIGlzIGEgcHJvYmxlbS4gIFRoZSBkZWZpbml0aW9uIG9mIEFOQVRU
ID0gdGhlIGNvbnRyb2xsZXIgd2lsbCBOT1Qgc3RheSBpbiB0aGUNCkFOQSBDaGFuZ2Ugc3RhdGUg
bG9uZ2VyIHRoYW4gdGhpcyBhbW91bnQgb2YgdGltZS4NCg0KPiANCj4gQ2hlZXJzLA0KPiANCj4g
SGFubmVzDQo+IC0tDQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QNCj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OA0KPiBTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZw0K
PiBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXINCg==

