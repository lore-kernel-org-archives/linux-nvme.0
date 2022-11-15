Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C2DC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smlPqv054uL6FOo6W10TOyKxs+2P+Oo3pC8llLCEpS0=; b=cnh9EzIQ7Qm1F2DZIvZvVRQo3s
	x9Dqq9kJsNmRUDMihYXN3hsB7cBmC7WqGhdgvAzeYD1cWu6dEhrTyALOnEUiwvM2frOrX/KcgcdEI
	Q7O2u0bbcTGJ4COXAbPjAGga5yYVpD0l1HIz932McEUYH7GciOLFb53auQzvznd1KctWi197dbW+4
	UZk+URC0+U7g6RplIt+qNMoARADMmFnyEmwe4eIm9KqUJaTknMqU9UoFLMg+wn8ArwvzuS1Z0w3UK
	Op+41abkxWfEmoXduMnlD+AOhjb2tCKglEKHVKH1MP+eipUtW00PxorW4yQZ7I/IFJuB5qzVJQ0TX
	GOcPeKUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounRH-007Zuc-4o; Tue, 15 Nov 2022 04:20:47 +0000
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounRD-007ZrB-7K
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz9u7bX/+FtbbdAAs4kPOAdEMlfNO5xgA8BqwE4ud13fJSy9Dyo0lZLFlFTEpkYJJZUqRWSB5qe5SVjQ7yFVn1dPBOpUQwda25g0gl7yRFQeAUGHR9lM8qTQUmyTzL1y6Yqh06SPJss97Rwn53twp+nywroJc431tVSaBCsS1zGSbfEWPL1w4vMxcwOAKrAGvIinNx+k//DvGXL7OJm0SwlQT7YATM7sWwzFDzdCPWXzrK1qYKx+JdE07XDf/BzGeCp1iRLS161eORkcQyi86yZKh9O7BGqX268SwyJUcX2hc70W4xUBpr/MxpmEU7EiNkMeY/K36QOMIxHSxJQYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smlPqv054uL6FOo6W10TOyKxs+2P+Oo3pC8llLCEpS0=;
 b=PxjWnjExUMaHBUcZTygKFEUb0E0eX9gQs+6vqGb7wY/HbJKvOo7bLvaEHO9yxv6TeH7DOrEkIjhSm6BqShTnVtANY+krFX+jV9HNym5pKjR4XNvG4nhX+r4B0zv8jfaLlpIyuv0PY7vPXGcsLRkSaJCfKedjdKWf006Mii1jrib4LS4vcx2uBM9dxDEccUrIHbw0t1hAu5V66p4I0huzbEPJH8wz0Eix5PHat28Mlr1lK3CA5FDx43JTjy7Cm8iZithyuGowjbpKAk8wG5eUedFwn1espQXxukgqzsJEO8vsU+khgiYyG2T8nMY+u7mb3jhpA5YPltAptZ+wNWWkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smlPqv054uL6FOo6W10TOyKxs+2P+Oo3pC8llLCEpS0=;
 b=Qi7b939oYWdEqigiWcl8hMax4k7U39uz1v320fmKCA0guqTTA4DRRtcf/G7hRLcDaug6i4peJPIHqnydEdRBG2br17gpH3PPK9e8V9aG3DR5LikI6zq3rH9mPfnGp7/x4AWlx44h+2V5BUrgh6FZhJ0c0StTLxKRWMyQRSPPlngstC/sAQtpOC9r+NixFEVw4Y4LuzzkwcM/r4yedwoo1stG0uXlbTUivKqH25q1XKU0OeDjtqOkutxEhhpqNeDSb64xRsQV9PRXEYF3lkRtraAy1ulwZz54V+N1S4XCmBr3csBoUdewveKD3ptqcT76LYYsnJwEYvuySK6FWgB2SA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:20:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:20:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 15/20] nvme: move nvme_dhchap_queue_context declaration
 to nvme.h header
Thread-Topic: [PATCH v2 15/20] nvme: move nvme_dhchap_queue_context
 declaration to nvme.h header
Thread-Index: AQHY91N2LZsFUmBVM0SiIJiFSA0suq4/ZJKA
Date: Tue, 15 Nov 2022 04:20:37 +0000
Message-ID: <0226ef28-ec4c-689e-03ed-d2d8a85c1c98@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-16-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-16-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5068:EE_
x-ms-office365-filtering-correlation-id: 7ae3661f-0a56-48ec-4a3f-08dac6c0bfa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IjC2uYSSyptrehP/ndSMUBI2S23M+Mxn9F5lO9wZILyGz5TZ1z17JzwNveA1JXDte9dtNduuA8nbnyyDcFwGCX2l1PmIO9+fuShju/IDUykQurJi39p/n4i4q+Y2HKt7vUNJJA4ToNN1uN5K+MJEGyKA531a1VJbAcSCUbe+OzgaHffO9duBQAW2+j8V5k8QxCLzAUnuLyQKC8MzPQXRrioKoXDvRM80hFMFSfVHqhOV3stRtD6Vt6tDAqIHT3OjhiLTfp+fXAtsaMeN05aj5+6dG+vAvPodUk4PM9SC/M2AdVx5P5q06lZRHag72kv6UtpF4AhaURD6a3xVtYPbBSWPoGGFIeNv6PXmVcFRHBGIT/ZEc7dnh0h8FMpH97csF4rKhtAnn9HpnkAwI/IpZgFVTVhYr8CMgrtDfjPFbQyhkylPAjZ5N4exEizn8Ycg6tkCNbhuVLPSCcRaGwbUTvi4qAsOrj1Iu1VZpBQyTuPUjauL9NFrZL8cqMfdp4YkCu2d/Q5A5c/U04rMjtVw+ZTyg2SZB8L3EpJL7s/LfCyqIZdpvM7k73C3+pVR4LOEGWBbAedidHcjQOylsL1HN8QdHI0fDV0uj9gH6ODv3fafEsPHRBlz+9Z6zijigaROQjxFPqjwNJMBFdNb0k1zEAnq+VhUH9SO3JrxxifaAMWbjmITIZhpCjUFvM+TGj5IH3XzTmTkSAMkVXSpKFoeGoAdWxfkMdsRs54RmAfnNRgmVHpld+w1+0DhY5NcfxlelpZyEom8VaSJDUqfag7viCMg4d4LQUTvarr6fqFgE5/ZbaGPtILWDy5f3ooak2Ki0cu7UaIeIm0ivQ3yM6u8QQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(8936002)(31686004)(41300700001)(186003)(2616005)(5660300002)(76116006)(71200400001)(6512007)(66946007)(66476007)(53546011)(6506007)(66556008)(122000001)(64756008)(66446008)(36756003)(8676002)(6486002)(558084003)(38070700005)(91956017)(478600001)(31696002)(316002)(38100700002)(6916009)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eHdSbkcrRDZWMGNIOUVHVCtjR09IbzNnQlZmOXg0c2lCc1NQS0tCdVRBK3lR?=
 =?utf-8?B?MXVEdStzblhsVU5SOWsxZnFxOEhoMzZhSFhTSHROMWwzeDFnMmh4aFNSZ0xh?=
 =?utf-8?B?UURGU0ZpaU15N1E0YTg5bHkwVGcrcXlpb1RkY1o5OXJ4QStKc2tLdFRXL3pi?=
 =?utf-8?B?KzZIOWxUOXZZemZsbVNDaGtFNUZFMUFPdVZLbGNoWndnU0RDMnlIaXBERHZq?=
 =?utf-8?B?Y0xqTEtBRHpWdEorUnZZaTRJSHdXS3pTMDFtMTdUZ2lNL2tiWWZzUFZtUlh3?=
 =?utf-8?B?aDlEQ0xMMVFad1kxU0psd1dzelBxMkRuZDZ1RDdFUmFlN0lzL3FIZjlLTXZN?=
 =?utf-8?B?VlB5SjErcSsyN2FYWjlmRTByVGRLTTVreG5sakpjTklHQjhPM3BEdVBwUWFT?=
 =?utf-8?B?enlnd3ZMSlRtajRoOFZLWjFJa1dJbmFJdjBLSmJvYmxnMTVTOVpNdDlqMi9I?=
 =?utf-8?B?eE5qQXdHek5RaW9obUVXVGZhSlNlNnFDa3hYbFM2TS90QzNUR2hGcGNEL3Jv?=
 =?utf-8?B?eUZ3SmdWWUxVeVMyRm16V3pDY3ZoWU9oZ25peUFBL0NieG5KREtWNGdFYVcr?=
 =?utf-8?B?TnhXMXZNb0l4UTh6NFRGcWl2cHpocy8xUUtOYm95ZXJLeDFPV1NhY2lxb3Zo?=
 =?utf-8?B?MDNDRHRkalMrenA5bVBkR0NFRjc3aVNIb2Q1RlFaY0tBYmdaVFFuTlV2bjJY?=
 =?utf-8?B?dkN1MlBKQi9MUlBkbU5pWGZpMkdodzNVMk1URWczUlFVRDcrUmxhelJqNHNh?=
 =?utf-8?B?K0o5cjd5Q2JPR3ZPRTBpT0E0dFM4VVZBS3dUbHJnRmFtMW9zc0F6cmhJZWVn?=
 =?utf-8?B?R2JpNEpwRmpCY1JLbFFZV1BYRjFYODk3Z1UwZVk4UkNScSs0VjAwbVBYWXdS?=
 =?utf-8?B?ZUlGazNjTzBhQzZUNDVNMXB0MjMyNzcyazVidGlZZ1BqajlPcW8rVDljWWhL?=
 =?utf-8?B?TlFEN29DNGtZZDNsMkdFdDMzK3UvQ1phUU5Id0oyZmE3aXhvaDhwdlhOc0sx?=
 =?utf-8?B?NkRpUTRsTlAxL2txQi9FWmZYUzhDSXhVMFBEREFkUlMvSEFIY3lqSFlicDFE?=
 =?utf-8?B?Z3o5UVBKdkFtejNBcU1CWXRpRHYza2xBWTA4cmw5M241K2lvb0VCZDI3OWI4?=
 =?utf-8?B?NGNZcFZHZUtMVCtEUklMbDdKZWRLaWVIUVhLaDg0L2g2bHQ4bERHb24yaUNy?=
 =?utf-8?B?UjU0NVlpcE9TUGJ6aGRNL214cVBqTjBaMk1aS0x2WjhDclh5RmVZQ0xGeFpy?=
 =?utf-8?B?N2s1VDV5aGZZM2hMeUNxVjQ1NWxEUlZYZXQzY0dLaFh0Lyt3VGhHZlFwekpO?=
 =?utf-8?B?cGhqTDY4MVFaWXBvdUF0TE1Ra0JLY0ROdVhvSmFJS005S21jODVZQ0IxcWRz?=
 =?utf-8?B?VFQyd2FGRllKYThTclJoajdDZlFJTlczYlR6WFJBVGZJTXRKcWRyYUt3S01Y?=
 =?utf-8?B?cE14M1hjczExYlZ3bEZsNHlKZ2srUUZyaGZPam52amg5NjNNS3FYZm96aTZM?=
 =?utf-8?B?Q0srczdqR1ZBQjdmOXdjMUFYU0gzeVI1TkwzUHdmelU1VXBEeE5OU010dUpy?=
 =?utf-8?B?alRhZXp5bzkrRy95aHE4NU0rOGY5bmpubndoUjlLMFlRTWs4ZFRMLzU4d1hl?=
 =?utf-8?B?UEpkTUkyc0QyNHIxRy9qYURSaHEyYkMySmc2SXd5cTBSVjdYNUZuSm12WS9Y?=
 =?utf-8?B?Q1haZFJMaS95VFdhbkdYZUQrdk9uZXZVbFFBMGNBR0JlZlV5ek52TTl3WUdv?=
 =?utf-8?B?N3Zvakg1c2RHdEZzWXEvZFhsZlR3NHV4ZFMwMi9vUzhyNklTbmZFTzUvWnRr?=
 =?utf-8?B?dW1VQlVYVzNhb3FlYWV3WFRmb281cWtOOXZ5dWtHZUJqUHV0eW82WU5aZmUz?=
 =?utf-8?B?eFhSMFMvZm15MnkyQzl2cVRUcFNOT3lzRzVwYjFsb3pTdzhUYlM5SkM4N211?=
 =?utf-8?B?Y2VjamZqVjgyUTk1YVo1REpQOHRYR3lhWXVjcm85RCtWM004VlRMYkJjSXdM?=
 =?utf-8?B?UFJWemVYVit6TVBjclA2QkNnSTNXQ0Vpa0hTMTR4ajBaSXdPSDVhRmo2ekpI?=
 =?utf-8?B?U1oxZDkrZjNHUWphaFJlemg2MmFNT2w0UFVLZlJPQllPWDhkUkxhb1U4N1NK?=
 =?utf-8?B?MHNOdnZ1Z3VnS1M3TVI5VFBQOWI4L2lIQk0yTVVwUy9BdmNBRFFNNElFb1JM?=
 =?utf-8?Q?PtFxqw1WYZQrfaBcGelLA7xMqmimuJFumpOjPByBg0x6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB8D852D913172488E23804A59D265BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae3661f-0a56-48ec-4a3f-08dac6c0bfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:20:37.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGhzGxd50Jlxh5yFfMSWAdimJNb/OlOSkelRui6fMIR4U12Wyuphw7mwS2ObxlH5J0OSrqSalHtMtVY3EVlUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_202043_280703_EBB59F55 
X-CRM114-Status: UNSURE (   9.93  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFdlIGFyZSBnb2luZyB0
byBoYXZlIGFuIGFycmF5IHJlZmVyZW5jZSBmcm9tIG52bWUgY3RybCwgYW5kIHdlIHdhbnQNCj4g
dG8gYXZvaWQgYSBjYXN0aW5nIG9uIHJlZmVyZW5jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNh
Z2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQoNCmhvbmVzdGx5IEkgZGlkbid0IGdldCB0
aGUgY29tbWl0IGRlc2NyaXB0aW9uIGF0IGZpcnN0IGdsYW5jZQ0KbWF5YmUgdGhhdCBqdXN0IG1l
IC4uLg0KDQotY2sNCg0K

