Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3839C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x75pGR7OjkOLNAilMNMkvg0W78j9IL4k1DNc+TGxhAM=; b=v9B/jPM7ZkMQSKSW6yKahAsoB+
	VDbQzSHKF6sEC5spE6dBWjrrZ5EfmU3vBssI4jU2aRwXWbkq7DnJv8cg/y3WO126lpTPyUlJceUrB
	IfRK7hcewU82z8eL8GqMNO11YttF5+8VqW0MwkNEkMacXhZ7nxMt/DmGY6O4rsKAOoS7HYHf1ftIA
	1W1TQ6UkJRVsKUz5D3Gudm+T5EiJM7hYF/FxR0vB7ZBQN6vQeNb/37UGm/ez4DAulZGM4x0Q0XzDn
	lJBBtD2qGUf6aaUrmWYyLXn+9VFxE45aChxokq8cM+3IcwyDzYEQycx1OLey7FD7fFOhKHTdMG57J
	9eTeN6cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMEV-000000045AG-1oqW;
	Thu, 21 Mar 2024 17:29:39 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMER-0000000459Y-3com
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 17:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCDFVk+gcLAO7zC1jyMnxbd1DsYTip9AI41No7O5azQq1AVFJmpml8bJbTdGTTVU3/hbeFWNK2OUpPluVCBd6i/TSCLTBK8siySN5uAbp+pPgslx7LJSEbtWKEVVlXHFHm0x3n14y5rwj4Tl2Nd2H305vpQBFC0RIOIfz5q1X+B6B0KEkXsDEnzoJkcDgI1AkHIYkVEvJ/CMjlQNUWONJLRDA1Gs474tnsLpyaiGxZ89cSrlHx0KvsAHAB8/n+lKbMbTeJVWhlU4Kokx5c3jn3t+FuUi/4Hp42/gxKP6w03keYCYVODNsFYmat4Q0DIZuUWgVR7ZjL3RL50Sj+nTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x75pGR7OjkOLNAilMNMkvg0W78j9IL4k1DNc+TGxhAM=;
 b=RdCY7xB/rdJuz0VDzZzLTgSaLMQ1PhjnUGAYl4Fv938VIrvW3kLeR0PLACzWbulvaWhbaYhRNYdjLMrkSlNtoPE62p066Q+wS3QInlm1bpnPTTSl0G6KXaF13hNyrSNcC645jp5ee4mxuhX04Bp6Ci5e8Zw9baOFTcRZCzfaxASO53n5oILlDb4FWJu7aC+DCCFojIcUvPpsV1NKRs+a33cToh2bpLqlS+qeCU8WQZ7ayRaHQH2WQJoTaWRzI68DB13IphOyDZ7C+H/iUeHgjOH9YejdMVZd2lSdXmpocsT3WjAfzUZaF6GkrBLpDsfqN8QBPslzMxhV7e0GCntPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x75pGR7OjkOLNAilMNMkvg0W78j9IL4k1DNc+TGxhAM=;
 b=GDBmq92b7SQ9NPli6WjDMKEy9PoLXlA0+8+CDeFPmY6JsIUK+hcwcGmXu0GUV7OSVK7UZO/UkBYBRmC8m8IBFieObcuTl+RUHuZaWB6Gj/wL77frfiRzzmM4btV2eNTHI+1dfPI4D+5nF4n11BD/n2LOswZ7li4s73lKylfkaf5LEknNMVWtGXM4QyXPgF6mnGIXpZZBlcZOR990RhR+YBdcQ7IxzTqL339yxRUPV4fBkvE/Qd0M+hOfj7IgPhKOwOwyyn9JCcAG8syw4Jf3KJIsEmxrjE8YGSuRh5vKTt9zUtINQjfR7KVBu88L2+HrFPXXaghaXSq615VyId57gQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 17:29:19 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 17:29:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag
Thread-Topic: [PATCH v2] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY
 flag
Thread-Index: AQHaerbx4B6fP1i8bE6MqyPHEIUmpbFCdS0A
Date: Thu, 21 Mar 2024 17:29:19 +0000
Message-ID: <153c9abd-360e-4fc4-bae9-88e4a1b905d1@nvidia.com>
References: <20240320110821.60775-1-kanie@linux.alibaba.com>
In-Reply-To: <20240320110821.60775-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: 1342cca9-2a68-4e95-0f16-08dc49cc70b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: muKesZmHWpHwncKZgu3eB9LubWeazBwYCJmw7f8Y3QO7ztgBpJOUnSoRVdM9Jk2JbJGkljrEIWA4JyP3pEyc0Phc/TzNgz77sdC/IIwkY82EwEWatMMixxfoFcJ5GSknXUYicyp/fFalXWcgQEzhazci+xi4POdCO3FmlOTgDcxV+XYCY7Lj7VjVtGxTARGWNHKFkIgIfzXEl0Dh2LF/9TLC7ymx77rrc1EWzdPJXfg43wqAJKebAc6useXZW8bLFXVbokhpL9ykQi0eJzP96dHQ76U1KrVtmk7w6ZTony+G0nF19fn/aAQc8posmxiPiSwVY9jnEK3EE42MuR1bVZXxwHi69PPZCSM67KbrUKJbshydJTNh6uMaRk4PCHpmaPRQ1LBKj9R/+NGjjwaTO3p3kJIbgl9KgbQQpy3ePqkHwwkqFz3KA8ZiXS5gNnoAOwvRAvjfaCrYckcPh9Sy1jJfY3TEF3oHTcufgZnTxlLCzuYf2G2FYMU8oJOtT3UU9X3cE8UGhY/P5dSYm9KFDyjH1CiDLY4dIt6A4EVcKxXBnKRyXccdLXElH9+rySxAWkl9nfbBKIPej+1sl171yDhnvKc9F0rT2TQ5EJmF7at27n76UMIMENpsaNPSQE2aSoHU0tPDNx9bDVYrJCzz7Jh/N5JXRYvKwuV4hA1eKP3pdMy/por0mDuzPffEntVTcaocLIeEFmQ+gwJrZMfeVrzdBGgVadKjvf1AIewqTSc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmYvSDJqM0pyM01pNVZ3MWExNFhrU1ZQa0UvdHVBaEpHaWsyK3JLbGlCV0hi?=
 =?utf-8?B?TkovYVJaSXdzN0p0ZHpTdnBYdGs4ZCtYZ2h1WFltQzR5ZWlzTUp4OURuNnlq?=
 =?utf-8?B?d3UxYWh0Zkh2TzEzL3djWnhDUis1YmdhY1lodFFDWW1POE9iSEc4dUpJa21C?=
 =?utf-8?B?RzNUb0FlYUhUZmw5clB5emxwd1Y2SCsxYW0vbEx2UXdjNXBuZHJIdVdvRE9n?=
 =?utf-8?B?SGJSUTNUYm5mMUJqWVI3VnhRY0xBWWsxY3ZtbFpJTlBzVlBjcjIxT0hRS2Iw?=
 =?utf-8?B?dHpGQm5DWnVZaG9sVmhMVDNvbHdMWUQ4bEovSzRpSVpyNm1hOUU1azN2VU5F?=
 =?utf-8?B?SGJYV3lYcjlETXdOWEtVZktVYWZxdVJpUStxSkFLQnF1WHprMlQ1YTB1MS8r?=
 =?utf-8?B?TE9LQUhmQUl5eDZ4RGd3VXIyTlJJOHA1M1l2cWhSNlhOaFFzckxOekwyclh1?=
 =?utf-8?B?RkpUTnU1eFpwQ3oydzZsM2hMeHNWWkdMeFY2NnA3TWJVQmtDK3plZFgwakpN?=
 =?utf-8?B?RXN4dkN4bWhvV2xzcWRTQ2tmeWtjZnZ6ekxDTGJEQVYvc3FiQkZhRkVZYklP?=
 =?utf-8?B?NVB0bEV2V2d6Y0ZMTDdKQjJHN2NVZ0RBSkNrMWowVWZiTzI1aFozMDNWZDdY?=
 =?utf-8?B?UlJQZVJ4c0pQN0ZQQWNnRmxWekNRakVoNHdodG5GaWJaSERjWjl3S3lnUjBM?=
 =?utf-8?B?UllDOTN5aU1TMWZjdHNNckVtM2x0RThyZW5hTEJtTXJ0OFlzcXlqNjJ2aHlB?=
 =?utf-8?B?UXE0MHdPWGIvbTVLSk5MNC9QWnNwYXZoOGxiYW4ycE50UkJZU0EzYXVrdjA2?=
 =?utf-8?B?c0hUcmVvdVFIcjFTN1E3WU1XdmQ1YTI1aHA2WTBFTXh1ZW1uZVloVnZrQ1h2?=
 =?utf-8?B?VTlYUFQxOTR3QjdMSHRqb0RnU1pmaVdhL3BOeTQ3UlFFUnVoUmUrOS9sY0Nz?=
 =?utf-8?B?eEMwSnRZVElMbUZmNkNVSEQyb3hPTkVGSGloQTdKbzQ0TTI1emI0amhNbEs3?=
 =?utf-8?B?NFMxMFZpTFE2aHRLMVhybVNaa1B4TGpTU25WSnRqWnp6THY0c1AzbEIzMm5N?=
 =?utf-8?B?Q3hmcnlRTlZ6WnVXdnBhMHRTeVNLbXdTRXpPMlExcFVTbityRzdCWWJCOUI4?=
 =?utf-8?B?czBNSFFBdGRKRXlnK2hrSW44bDJjTDd5d2gwTHpxdUdzMXhSNExLN21tcTNr?=
 =?utf-8?B?UW9VU0NndUI1OC93Y3pOeVB1WlRqdzg4OXhHRUQ4d1Vuekt5dkZjMXZQUzg5?=
 =?utf-8?B?TUhISFhXcUM0bFNNOFQrTm5sd1NNNUJoZ0w4S2dJaUtySVNZbTFpMS9BNHJ6?=
 =?utf-8?B?Z2p2NVM0dWhIVTYyVnN3ZVVGT1FKeEdqVEQ3ejdRM1BKT0QwVkF5N0Ivb1JE?=
 =?utf-8?B?dSs5REdYdVlSYjlOaE5FQ1c2OTNXQnJIeWR6V1ZOQUluVGJJank5cWRWcmNk?=
 =?utf-8?B?aG1udkw2OTRwMEt6SzJlRlorVW5LbXVqN2E0Z0tpNTUycHRWVWZNWmdCSmpn?=
 =?utf-8?B?TGU0UVY5aEN1Tis1K25hOVJldmxtOStVd2VLd2w5VXNuMHk0MnBHUGt4K2t6?=
 =?utf-8?B?QVNGeUpwWmNVUzBzVTFReVprb1lPQ2lsMGRSQjZ1RlQwSWRleEg5ZENtYzh1?=
 =?utf-8?B?WmQyQkErQmJhaUlXNlNPdGZ3MGZ0aEJiY2k4WE1wek5TZ1Zodk5mNjJEbXQz?=
 =?utf-8?B?VFdTQmFnL2w0NVQra2lKNGFWRElIOUJORGRRYmtCZG5VSXJJdFZiMy94WTE4?=
 =?utf-8?B?WGFISVVTa0F5eWlycEZDMXpHTUxaQ0ZZOG1lUzc3MHVxTG9VbmRGcmhlWGJF?=
 =?utf-8?B?KzhFYVU1UmhNUmtHbGRkREd0NWlKYmhMRTVWTFJPZVRXWnUrTVVBY3JRQzhj?=
 =?utf-8?B?cDlpcXc5VFNPRkFBTm9Ed2NsYjVod2tlL3U2dm5PempTdVlhV3RrdEplbFRL?=
 =?utf-8?B?dHZsZlhPL2gxMmVKdkZUNGFKUDhSbEdXcmczOHNQZWNLaGk4RnNrcFFMTzR6?=
 =?utf-8?B?bitQWXB6NG9RUjNuVW54bjZwekdBalgyWUZIQmowV0ZTRThjVHUwSVBybGx2?=
 =?utf-8?B?UGhCYkE0UldpNktTbzNCL2c3ZU5zdk5SNWFnS05RYnBrS216UW0xMlBmaDZ1?=
 =?utf-8?B?dGVuWGVwdnptQUN3cXBnTm5sVWUxTC9EdVBhTXp4ODV3RmRreXZiSnVjOUlF?=
 =?utf-8?Q?54v/lF4xsYzqwvbccQHwH19SMupHsTltbHs/aDsP8EUh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B85C0643C41334CBDE91AC3E82E04F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1342cca9-2a68-4e95-0f16-08dc49cc70b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 17:29:19.2766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpVoVjHY9ntL3l195JXS97hrSaclUV9ErtXavxtB09ds1kTTI2vzmgqljqfma7r9HcpVUiOe0IxXJQqrxXPaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_102936_096505_0944A602 
X-CRM114-Status: UNSURE (   8.55  )
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

T24gMy8yMC8yNCAwNDowOCwgR3VpeGluIExpdSB3cm90ZToNCj4gV2UgY2FuIHNpbXBseSB1c2Ug
aW52YWxpZGF0ZV9ya2V5IHRvIGNoZWNrIGluc3RlYWQgb2YgYWRkaW5nIGEgZmxhZy4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogR3VpeGluIExpdSA8a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQo+IC0t
LQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

