Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E602C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3vcCvkQxC4O0ecm/v6FFm/ck3BlFBqZqioz9VXLyjgQ=; b=ve8Lagu0P4fl3PIBzHPnPMQfj5
	BXJvwr8uFkli5kPfy+vVhyYm+NdfMEqdL7Blsa2S0Ok6SeYa7Ubtv2m8jeztUABmiNx7AWoqVlfPo
	EGWXjgsC9dReYgw8SdYdDfM+5N8OgKPbvk/3cJkMrDp9LNI+hFy1BWC+WT1L8Na6E0CPHF+ut2qJm
	08XMDen5aoHFSdoqdag0B3d+Lvqn8YhQgdXZbhdNekaxONEDLqbswXOaVL8/SMyw9p9/FJA13DWfb
	GG9WM2UXaB6wwkoUzwdoxWCLeqslj8bmOVXl3E6zCoGEfTB7RTknxqqkzk05+emxQAYYPYRvFscws
	5daxyYpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounG1-007TC4-Jo; Tue, 15 Nov 2022 04:09:09 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounFx-007T8B-Uu
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq4AaL2Ux29/cVU6n8MS2GiSA9GayJNTweNo347hS8OvvbwdgF6Ue1q/yIXrNNAINyQgjUGy0+as5Rb6LNr2giDIhP4NMv8JNw3urHr9C2K5H5iMsTYXEtc2KRT8z7GuPjJywbixVw5LY5mzh1ma+5mUwlemfESqAzc3NYqtZBPbN8ismm2v0ektMiJzMXpaVDhPAYbmZN5UZhKMEEOSdKuFk7cgyjJzFv8an9auKPrvRjlta8D8xmVSGu3N7eiKwUuTtQC6nTVEat0kZWKhbNW0M1uJOtl9IS0gAe2iLSRylGt39TS8avYbsUpVR8k4I38OtpBgxaH8pS4WRj0wuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vcCvkQxC4O0ecm/v6FFm/ck3BlFBqZqioz9VXLyjgQ=;
 b=NnHAG7wSdUhx9k1AGFi3wC7VqYSbwe13t1wvODsZbrjMPy4bQkU6Fko4JWJ/1a34OxfBUG2enY2vDV0kfJHtn/zxfjB9DXPSsKRCM2iNyoazZFEQwzOXtSWmaro1b1we1sAI+tnxnjDrFT68wOloUGo12ATLw9Hyz4FdyLPTAq0a81QGr5woXHsOPT49o5GcCxhbD1YLNG+ZjToBKj7udZ8GMboZYcThplOXnvH4SUCjKbyFnePcO9kGnpladEpWFYDK4Zq42TTaTel47m7G2Ml7EWtodsCdRL4A+rvIpivzRiPtIgv6qIrHhz6heE9M8v8pa6MUMtW0KVHYbAfs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vcCvkQxC4O0ecm/v6FFm/ck3BlFBqZqioz9VXLyjgQ=;
 b=gM4GPupwKzF5JINgX1wDG1sGspMHH3gSu5Ev9jFAODnRlLaW5d2QKFP2ckoqsemoQfDf0l7tqt0SYvxUAxKFoGJ8e2WXXx6VRv4NZobqGr+5C+phyx5s6+M+3IBG4ZrMnznHIy80GwUN7B0bDoMfsUAROgmfu9ZQjI3RpIE6uAMxjNVSnSNpE5NAGY7Et2TOh/4WvbSk2ISfFQ6EFINAPF06mWn/bxN+MN7BPeDCwCogoFOFb1NEDjQHn45xj7zBlSKtHCOW6HeahnlpS80xnnLUjUUfc+9XCEFjaZv6WlBBh1ydB44PRCUaObDBNb+hktUQBJBc/VJEHRKBJul1LA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:09:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:09:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 12/20] nvme-auth: remove redundant deallocations
Thread-Topic: [PATCH v2 12/20] nvme-auth: remove redundant deallocations
Thread-Index: AQHY91MCHiengfcy2kukx+fxsc2Wwq4/YVYA
Date: Tue, 15 Nov 2022 04:09:02 +0000
Message-ID: <aa826a57-86ab-96d2-714e-6492cfb7c272@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-13-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-13-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5997:EE_
x-ms-office365-filtering-correlation-id: 01309423-6e86-448c-6106-08dac6bf2142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  OK8TRbgW6qUOmI0htPCInAyWd9zcTiw/WKmdc1bOvRmQ4HKubgSGbXH5rp41kZ/s4PQ8X72rps6XNlBGC91gmOvVxiF8L0frtvx/0nz43AVgU0qQtGBL0bsZ/ZiMrmQENYi0xMzfTrAlj8VinMRPgI1gO5vms/63P99+rTYTw9RPiReSU5HKHWvgiG1rtgW7t4wDVB7TJ0Dd76E3eGjpGvfOUOKMkF3FSoxISCp7FaWu15d3Rpo3ag5LaiKX9IgaIaNgFQqr8lFyKOQHuq638/zmpmEor8dfbKLxcIITpJZh1eJNk376+PLJlgU8c4CFO2ZHDAFz6cLz6epIPsbTjf921+WEPm7+ykoclUEea9zpTAwVPBhG+OjX9b4+HvMpDM/ATGMFbhlqpKOBQ8us8rxG5c+IccJ3RFajtzwO7ucv0TZyTBGflYpLBRQAcmBMh/Du+uuhDk5Ssh4ms3Cf4JKkTmkS01Ai854feTgqDpDgYGLBza9VZ/dEF7FlN6V19yyjsRVx62TUsF88PFVKVrMoAEosyfQR7Dzj2zswf+vEilt7fRrcQqOesZOXu8Su8K3KaCKRBjq09TQylet/MaQkdUyFUAb1AH1XV5Cuox90Ci1pPQEB5adM2Rvw8QrB0oFz5ZLiuSb1vgaktt0XaFY6CV1oe+rJOd6ySTWuWuRNLjso3QdfjK5YOF+GEC4ZEfN3VzbRto8gwGJFqHcmayhpPFuZQFLKlZzMQ9k1ymJBK7l/CODimfryGGyr59NbbLiZHPpSOqfHFv+1z+r9q/2ck+ajtKpk3H8vej6vIFuk8x4VdP6PHcTwDjRipJbnPYdHOrM9C1Dh+eyqYoaqAg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(36756003)(186003)(83380400001)(2906002)(38100700002)(2616005)(5660300002)(31696002)(122000001)(8936002)(4744005)(6512007)(41300700001)(86362001)(71200400001)(478600001)(53546011)(38070700005)(31686004)(6486002)(91956017)(110136005)(76116006)(4326008)(316002)(66476007)(6506007)(64756008)(66556008)(66946007)(66446008)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YjhzZDVIMlFsVWFwZjBad1Y3ZnFDeFBVNFdqTGZ1d1Baa2VQcGVCVm1sYUw1?=
 =?utf-8?B?NmRDdStlT05HTVRzVEVwUWdPTGd6V0ZMQkE5eFp4emIzS2lyWW1WRFZmRERV?=
 =?utf-8?B?UmNrdnkrb2NCQmFreHlhYWpPSFZpTUduMlRIaXJYR052bjlZa0llZU84NkRW?=
 =?utf-8?B?Y0VTNFJBdmg0Zmx0c2liQldQL0N6ajBxa3NsRFg4bjYvb1pUbzlWdURiR1oz?=
 =?utf-8?B?b0w3anJacDlOMHNYNG00QmRUT1VqRGthTmlKNkV3dXdBcnpkSVZObWMwaEx4?=
 =?utf-8?B?dUxESDZBL3N4eXZmYmxHQXdSVWhIdCtVeUErdE15aXNCZGZmMWsxTjdIV2V5?=
 =?utf-8?B?TnZIempTNXNuYzl6YU9rMWlsZHc2dEgyeEJ4eUo4M0gvbkIwclJpSVhlR2Yy?=
 =?utf-8?B?Q1NGMlZ1SUx3TENrY1lqbEI0WW1TaEpCYnJlYVNHYVlhcW0rS3JEL3Q2RXhC?=
 =?utf-8?B?Y2Q1dDdDcjJ5cGx1eDF0b0w0T0Q0Y1BJekR6UFBsNHFyQktnOHFaSTFtZU81?=
 =?utf-8?B?djF6NXBrSEYraTFrMFVsLzBOaVZvSklsSlg4Q0pza1ZzMGtMOFBUcitweWpq?=
 =?utf-8?B?Qk1PdkRIYmR3OUVBKys5UnhrVllrcWx6TytTdmc5LzRpSGt1TEhhdU8yOTBW?=
 =?utf-8?B?a1hLbDR6MnVobU9RdmNnVDdidlA3Q1ZZRmVRNWhKdUFqZTdncS9NdkdVVmhj?=
 =?utf-8?B?aGx1MzhKdkFySHYxb2U0a0FHRmpBRVE4RzFGU1puK1FkY0p6bTNXTkh2THMz?=
 =?utf-8?B?UUhrL1VzbkF0eDJBamtla1lFMmV6U1pQU05Bbjl4cDZRbUNUaXNLZW9VbHhu?=
 =?utf-8?B?MVdOZURvcTlpakpjczNYbWVrVW11ci9nSC9BUCtyRzl4SUNkVkJZblVsdjFr?=
 =?utf-8?B?WUpmVHlkMHp0ekJIVlVnNDhzVnExWW04Qm92ZSs3UXZrR1VwUkhLZSszWGRp?=
 =?utf-8?B?Q016RTRQWk1BUW5YNkJVcVBobHNGMU5rOWQ2SGs2VUpLdERXZFhXT1pnTnMr?=
 =?utf-8?B?RzdMclZRbmt1bGxrc1U1ZVFjR2ZLTkZMdng1b0JxQXRDTlVJYVY2WXlER2ly?=
 =?utf-8?B?cGZ1bkpHS2J6WWpOeXhhRlg5RkVkMUlGMmczaUZEc1ptanFvTWRzMERtQm92?=
 =?utf-8?B?ZXdBWFhoOVVGM0Q3OHRMVnFxY2RKTXRjQ3l6aVMzVk1VVVdFNDd3UW9sK3Jx?=
 =?utf-8?B?Q3UwNDh2c0hscHFQaHdoSlBFQXRzaGJkVmY3VU5ibFpXMldoMldJb0tjSVly?=
 =?utf-8?B?YzJBTDNJVGhPZjJ2QWtoWjR5c2ZRQTFQakJVTTFhN2p4N2tldUY5cm1Fd2RO?=
 =?utf-8?B?NngwVmFrOFJEeUZNNEl3V2FkaElsc25QSmVmcUlGblJ6bXNpenpiRUZIeUpD?=
 =?utf-8?B?NFNoSkRjdnM2OHlWR0xEcWdRVnhiY0ptYUtaTWJTdWFQVzNuTjJwN1pXNzQ0?=
 =?utf-8?B?YWlsSDIxcG9sU1B2Y1M3Tjh3Umd1OVB1M215cE5WeE4yd2JpSFpLODFQRzBC?=
 =?utf-8?B?M2liR2N6bDh1ZnQzUUhxMVVZTEdoOGdnYUwxaXNESW1rS1R0WW5Ra2p5UUJh?=
 =?utf-8?B?K3puc3ljNWJ1ZXI5ZFA1YllRd2k3NUdUVWxqekJmVVpHVjZlTVY0MFYyQk5U?=
 =?utf-8?B?S1pESWhTcGRCUmt3M01GRXdtZE45WjdLR0o1cldnWGk1YVZzaFZvTDJ1Q3Jh?=
 =?utf-8?B?dGZmOWRYYXhxTHh1NmZKQXBjZEcrYUd1WmpMTUJNK2FZNTJza1VuS0U4dEtM?=
 =?utf-8?B?bWpBbFpzVHhwNVpoTHNTNmlhd251UmVlWVJoQ0dVdk1LRytUTTNmNitmWGZK?=
 =?utf-8?B?Vk5JQ3RWSVJaeXRCMU12SFJ0NjcxOXpSZzdndGxiSzBnVE9mN2ZCcFFOeUlL?=
 =?utf-8?B?TmJLVjhGSEl3TFh3MjRpWldqVVFYRWQ4bkZ1cXZrMC9MVE90VVR3UjZHZ292?=
 =?utf-8?B?U3pBNkVzSWhXakhvb29ML3l0OERkbVd0bHRNZEdTcS9sVkpoOTJrQjE3OFdO?=
 =?utf-8?B?SU9HMGZONDUrYmY5eGlPekJNSXlhRFR0Z3phUVkxa2hBMWtUWUxEeWZyN09k?=
 =?utf-8?B?TUdMQ1hpdFdGRVhpN1E0SHNOczFnWWQ5YlZ3Uld6Zkp3S2FZSjZ2MGZlZEJw?=
 =?utf-8?B?UC8zZjNTYzFiVGlYdG9sQVB6WUFKc285WjQrRXJUdmxZb2RoRTVQalNVN1V4?=
 =?utf-8?Q?TJL2yuMiwnkKg73QhbHMtYbz6glDTofjf7bQ+0LUDsVb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1A14F39CF90D248B35BD3532A436248@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01309423-6e86-448c-6106-08dac6bf2142
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:09:02.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSTa9YWCDKD8XqqiYcwPswgSyB9c13NBQxD7DIHPTiiPCse+9u7JDqAbmZEXe65eCgdc65i+dFdfcEqHYO7o9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_200906_042379_390F8011 
X-CRM114-Status: GOOD (  11.57  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFRoZXNlIGFyZSBub3cg
cmVkdW5kYW50IGFzIHRoZSBkaGNoYXAgY29udGV4dCBpcw0KPiByZW1vdmVkIGFmdGVyIGF1dGhl
bnRpY2F0aW9uIGNvbXBsZXRlcy4NCj4gDQoNCmxpa2Ugc29tZSBvZiB0aGUgcGF0Y2hlcyBpbiB0
aGlzIHNlcmllcyBmb2xsb3dpbmcgcHJlZmVycmVkID8NCg0KVGhlc2UgYXJlIG5vdyByZWR1bmRh
bnQgYXMgdGhlIGRoY2hhcCBjb250ZXh0IGlzIHJlbW92ZWQgYWZ0ZXIgDQphdXRoZW50aWNhdGlv
biBjb21wbGV0ZXMuDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9hdXRoLmMgfCAyMCAtLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBkZWxldGlvbnMoLSkNCj4g
DQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0K

