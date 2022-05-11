Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B9CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 07:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIROvzCzZ2PsPmVqvqGrsivhrFLmG2xZS+cGEmj7+PE=; b=NI0zqiDw5VOEdx6TgLdIv2CQl3
	Tt/8KQ7xXNCxGO9PL8n8iBsZ6cDZRge3uqRWvbE976E0EKVfARB/b2c2AKF7O0seSMlIaMVwcPR1D
	ndsFYjLi+bsir9XNwMwWiLFKYLaAmLOEpELM39W+7fXXwzJj21BrQkhgjn3Q+HOMnLCODTIFnFX6u
	38U0g9twW2euBSKhdXWHXEGN+UGs7t0Imp7QiQv2vi3HfJD6nQanTazTlvltyDPbput42i8UqZTqo
	KIQOAIxuK1/2rxkVZR6fxT7oXEPdVHZ+V1dB+nJ2HP704hIWfRj7iOWIi5hYMDqqHN3pM09IN8/nQ
	Jmw46LMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nogbU-005eck-Gh; Wed, 11 May 2022 07:17:48 +0000
Received: from mail-co1nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::604]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nogbR-005ebB-So
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 07:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeX7nOeBwpPUt3UmOnHjBGKheFHitnOXlCdKuQ8abtcJvIErZwKLshrENwi1pM7uIlwpxR0sura8HoaHZs003j99cOd1KCumXuSQGnjb1r6+ZxMamC/bqNCpdYp4/lgpsAGLXFc3QlzX8TbVVOs/5vLT+8JolHLKVNxSIDZvPoYhk2aLustrHTTjOH20YD88Rv9LA1c/z9CBeRtYIdwBtQ3B1Jpv7vhpJloE7VZaTNBrhSkiHEJjp4/7jqMXPk5bHlgxRSJyvURGsG9LGt2N5SYlEO4waZMCj8t0zCOBwGDl4MtIv4LiXnSNFyrmNusORXF/h4QXOCTfLyYFU64EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIROvzCzZ2PsPmVqvqGrsivhrFLmG2xZS+cGEmj7+PE=;
 b=IqyRfphu2oZQQJ9/+5lzfWbNasROPkG5jtGGmlbJs3mhAO0D39OqorV74IG3dE9yqkVEVYn++P/s74o6v2pxcWQcJr+T1wM3LC6rl0GmdOS1e22n58qtCMStSc0sRap1jM8czh522C+6EF9ry9vnfAhhJOm/AZZIIFEtTUqebjrreZV/Ta9YluPipVlD2AYtQQ01ASzXAdRBz27bcOUgFMxXTFnyqojaZaaAMxqzCaQ1pB3O9OjBrIHd8wlakUneKhQf0r5TkFj6Qxq3wFWeitAmeElJSZRkhqDNRubMtVuqheWgBsRmbZshjHGRhzMD+wU7UofjUDCMIu3hls3ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIROvzCzZ2PsPmVqvqGrsivhrFLmG2xZS+cGEmj7+PE=;
 b=L8TychfYABxA8CWYFGXyxBqSCms6TREUU8SkTAvWkNrMwRtZpXqj84Kl8JzLUhipQEll2CnZaLe4b7/ATi0r+S3RHS/jcq5GDicniqlJ6XIk+cpYGSTRF7eqyPY8Me9wEx1kpYDIij9voRzgEj6dZR9DJqvXlPkNlwRW+nQjjOvMb4Y2FT74IpBiGEvvwJ4q5ndtSmktmgVkIWviiVgldYNlF+wptMFtC9waRFaeDqYLCe5rTgtWz/U5auKxXC0XGx7V3qzpPqkahf/ygdauzeabCM09nDgeCjpGlKaE2+eZpVbJx+mSXa6TDrvH7PSVursg9js15X0p5Nw3wP9nkA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:17:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:17:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] NVMe: use kobj_to_dev()
Thread-Topic: [PATCH] NVMe: use kobj_to_dev()
Thread-Index: AQHYZFxKuNLXlNG1lUOQhDhbUf9x8K0ZRa0A
Date: Wed, 11 May 2022 07:17:40 +0000
Message-ID: <fd20a4ec-f71c-b052-bd43-dec0d080755a@nvidia.com>
References: <20220510105303.1352342-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220510105303.1352342-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68265939-544b-4203-31a5-08da331e55a2
x-ms-traffictypediagnostic: DM5PR12MB1916:EE_
x-microsoft-antispam-prvs: <DM5PR12MB19164234C05DCDB72A70765FA3C89@DM5PR12MB1916.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAfsBYSAEK+YsMRaocqMl+elaw7bvDHkeLiY6HbJhY2701A2Wf82MrrVNSP5eNgTpf24F/dCAPVytozbInlwP+CdbvL496TiVbKMrdHQnQRcVOWNh/LQroLVs63/lcBwhZLmaxL2lg00a6iQoAxGNQDDae131LSxvvUYl12J7c1XE2470HIClEfgS8gmuc7H38szT0Ltrg6/k4hEKGLBIwtwCkFfgKp/AWKgbLplN7XYHuDnqlvsCNS8jdi2RRkSaJTwj5fOblHReZJ6ms7YcZuWePDb7/t8U22rKiVYvYGYlw0BuzaUjbD0XpTKoVPduFjrzmejb2D+N73Oo7nGMC2arLvUlWT08bX5AfOMil6m0kYz7z6+ZXZIJZI9LcFQzUoEK4XplVstu9hJepSNUEYf/XiwpzTtKxyCde1BcGjMAH/GR/p7aBwK7CmAK+FTS7dnhkpSWbtvoXNdIpG/K4p2cVVFRPHCjCxAzjdSie0CR55zXkRSRFBREfPOgDfMH+n/SpqXv8LWjjtcaGoGu5UtUJyx+6fnwb4dPJNOmMqsy0jM/xmpqob7LnGTckg9+XrCJODXScIQlxfKd9ETGxBauFyo8ZIMqHxOmKUxVMAzuY0oJ8KdnGqgDZ9SGM6xX0h3gaonz9s47qxb5ENLO7F8Q6aNgfT2oaHKX7xGh0ZojrPD8NBNqOU8qUbY+oAOzhDWeS9np579gdf/z+dxeC1EGu4TK0x8cixG3+lDSpH/Z1z1xubfVhrzO2gUWeyV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(558084003)(8676002)(66476007)(66556008)(66446008)(6916009)(8936002)(316002)(6486002)(36756003)(2906002)(5660300002)(76116006)(31686004)(91956017)(66946007)(64756008)(6506007)(186003)(2616005)(6512007)(71200400001)(53546011)(508600001)(86362001)(31696002)(38100700002)(38070700005)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3BwNTRvbnJRVHlSUm5mWlZQSGFxZlNFTmF1K2V6Q2RtU1o3cURpMEJBVlIv?=
 =?utf-8?B?bHhXdDhiNFhXNEI2dGh5bHQ2MmVnTjA0d2RxK1pJTzdteTkrSkxmZzkzdFhJ?=
 =?utf-8?B?dXZyMDNjRHgxaEVnZ1hmWnhuS0pHNjFPOTRKc0RnYWRhZXVXZ3k3UEplVGIz?=
 =?utf-8?B?WXN6L01Jd3lLQ0hKMktDRk82Y1ZHYXNZa1JadlFrV2lMcHpKcmlaTmFMVUc4?=
 =?utf-8?B?bjlLb3g4Zm1xZzZ4S3BQQXpPbmt1dmVXY0dvcjYwMy9nMnNKbUxDbWM1bGJ6?=
 =?utf-8?B?RVVVTWxGQ01yQ0ZGbVRMZXZVTndEMG96ZEdYNTd6T2RPc0hQWG1tVjZBamo2?=
 =?utf-8?B?Vlo1d2RFbG5qOVZvSkxaRiszNXlRYVpuRzUvYllqdnhmV29qeEw1a3lJYWFx?=
 =?utf-8?B?Zm5oWWtiSThmcTQ0cFpJdjdqRC9RNmo5QS9RM09UdmZLWVYzazZBVEg1M1RB?=
 =?utf-8?B?bklvRzBVVFNpY3NXckt3MThGaFNlUDdadjlpekgyaG4rd2NrbXpSck9hY1pr?=
 =?utf-8?B?MmdmMFdZV2xUbmJXaStqMTVhOVpmTFFmYnMxSWsweW9NWXd3UUVoTDFGK0hi?=
 =?utf-8?B?Q2N6clcvTUNZRktVMGFGY25xZWQrS21BK3dvVVJjTlM2dytxNmJUTW5GeW1o?=
 =?utf-8?B?ejJOUWJpOXhhRm10WHNWS0lsNThPa2FISU4raVY5c2t4SWlveFQxOVBtNTYr?=
 =?utf-8?B?dW1CTS9QNmZMMVhDM3RxUE9oRlFqd2pSbGdEeFVvS3ZrQ2xMSzhCSkl4VUp3?=
 =?utf-8?B?Q1JjYjY1R2lSQzdqVWdMWGM2Zi9tcnlTN0VPUDJINzVRNE9yUTB2SlBndEd3?=
 =?utf-8?B?YllkN3grclAzSVhFTTRoSFhTU1VBV3AraDNmS1N0Z01qbCtMU3RQMnJsdnZ2?=
 =?utf-8?B?ZjhaTVowZmpMT2JJc2hCTW51aWg1bkxQdStIOVdhNzNTNnREM3VlVkZyd3Bo?=
 =?utf-8?B?RUN5UXRjbGFiaC84NXFGRU1HOHN4NHBTcW5ZY3g0UXZxSzcrUDdibkpBVVAy?=
 =?utf-8?B?K2dQLzJZTXVnYUNUVmZCYVBNZGRwRXUwZ20xb1JsRmwyS2trM3A3L1NaQVEv?=
 =?utf-8?B?T0ZhT2c0clhtK2grMXV4S3VUamV4eUhIKzlaUmYrc1ovZ1hwd1Q2Y1ZNQW1P?=
 =?utf-8?B?SExPNmpzUFc4M2dnUlc3MEJZNkhTWlJuMkxDM09LbTVZd3JLQ0pXbk1GUUkx?=
 =?utf-8?B?aVBPOWVxWFdFU2Y3Z0p6SUU0Sll5VWdmVjJwMnhlRjdlbTE5TGZ6ak54MTNJ?=
 =?utf-8?B?cW5mOHFNaXN4WmZNN3hMMWdGQ2ZzR3A5eElrWU5hNHJVME1tbWJ1eVMyb3VD?=
 =?utf-8?B?b0hEUHJvLy8yVDRxYmh5Vjlod2JWNnA2Y1ZpTS9MZnpOckZEOGxJc0VVamJs?=
 =?utf-8?B?SVZxNVJmaHRNZitDK1Fydks0UTUxdEtoeGdVWjBwSkRTWmlNeGZXNE5GNTBX?=
 =?utf-8?B?Wi9FTHByYTM2Nmk4OFhKdGgrV0pSR0FYcVN1MHdTWEZUR3NHRkRGQ2IxWnFt?=
 =?utf-8?B?M0YzKzR5bk5QUUZSUkE2eWJSYW5WaW9OSG5mdEdpc0ljanNnQm5vbloxemVq?=
 =?utf-8?B?ZXMvMVRxOGc3SEVWSzlCWVpUWlpEVjJxTC95WkNXMkRBckhZSXpWV0ZEL3J1?=
 =?utf-8?B?ZmVzTktRVXhiRm1PT25jUlpVMHROZ2RRVWJpZXhKRGpJN1lPNENqdHFqMmpr?=
 =?utf-8?B?bHhkUkxxREducGpKNTZoVTZmaGF4L0R1c0dPck13ZjVFRVlKUTNNQmc5SjZS?=
 =?utf-8?B?dWRBRzBRYzMzeW5WdkpSZWlHR1FuR1ozZE1NRWJJSEdINUxDNjlOK1VJMWdH?=
 =?utf-8?B?UFI3MUlhNEF1dkJRcWtRQS9NNHdjY2NUaFB2VUNDM0RJdFRGRWVWa2g2KzhN?=
 =?utf-8?B?WHVYcUtlbzBONFVMb2JCSm1ibWR6UGdjSVpTYW1CeXg5M2w2c25ENGVoQnNX?=
 =?utf-8?B?MXFsL2cwVkJWcEh0TVdEUXY2ck41ZDdiakIyTXNpSlZWYzVQTzE2Y1F5Y3Ja?=
 =?utf-8?B?eEZMNi83NGJQaDN2K3NCZ1F1NTgwazRPU2J6UnBIMHVYbEREOWVBUUtpWlRV?=
 =?utf-8?B?bEFxaVFtOWM2Q0dDb2JELzN0bEFuOEU2bTBuYnhzM3B4MnlIa25SdDZhbWRq?=
 =?utf-8?B?T1RzVU1NdGRQcmtaSWduWGRXRFdwVlMrNjJJSlo3WUpuM0dtbDVnU2JZNW42?=
 =?utf-8?B?dk8xZ3hyLzVPMEJVcGkxNVliVVVOS2hWcmtkZ0RPd2NkcW9wUEJiaW9ob1p6?=
 =?utf-8?B?L3B3KzFzdVdYek93Y1g3MXVnNmxUK2J6VUpOM2l5ckZFbjI3dzN5eUhad1Uy?=
 =?utf-8?B?ZXduQ2JXUG4xSXdINnVNS3kzUmRjcHBzeTNURk4xQ0MzcFJiRDNRaFpkMWdR?=
 =?utf-8?Q?+uWA+P93c759TVunB3D/SMEy0x9GwK+XolUUrLXhRp6Gy?=
x-ms-exchange-antispam-messagedata-1: bZ8mKyEIiEdF3g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7A17B76548E42499412010B2FD7DBBC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68265939-544b-4203-31a5-08da331e55a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 07:17:40.4762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70g/pbRHu+C9dH3kN1FOOA9u6Z9bKiqo/9Q+AHtz53QPduBiDA+Is8FdX/NJ8FIr9NJrfu2qRul3PsTEi44y3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_001746_163536_ACF320D2 
X-CRM114-Status: UNSURE (   7.98  )
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

T24gNS8xMC8yMDIyIDM6NTMgQU0sIGNnZWwuenRlQGdtYWlsLmNvbSB3cm90ZToNCj4gRnJvbTog
TWluZ2hhbyBDaGkgPGNoaS5taW5naGFvQHp0ZS5jb20uY24+DQo+IA0KPiBVc2Uga29ial90b19k
ZXYoKSBpbnN0ZWFkIG9mIG9wZW4tY29kaW5nIGl0Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IFplYWwg
Um9ib3QgPHplYWxjaUB6dGUuY29tLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaW5naGFvIENoaSA8
Y2hpLm1pbmdoYW9AenRlLmNvbS5jbj4NCj4NCg0KSSB0aGluayB3ZSBoYXZlIG5hY2tlZCBzaW1p
bGFyIHBhdGNoZWUuLi4NCg==

