Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B4BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqzPaj1d2tHauchTOHySl4wt55khYdPBr8dNvvGg2Cw=; b=nv1m2JPkZBpVcZKHK8xXdkL33/
	U6HgVXJxG9svywZtBpzkQoJP9gFDyiAeSFG6HG9AqtZY8p9/MrXmSMByoCnz8f9gjw0otm4a6ErKh
	YUdmILoebnfbXsmx+Eqx6jxKipBaYoKrs5LMVr0wx8jtB8hlc/C90YGVW5DUUQk8RMVYRmq5u4Svl
	4pnGHzUqc17dIZ5hPY7tn8gFAQalbskXZf4TOS3/gnS391cHoTWGxhMbcc4XOP6eJG2DYTKDZvwFK
	/jmaTFx8IQ6+Fsa2CBnOGLNhbikeEvszcBMuK5uvVEirw/RzAlFRBV37WIzu1MbOP2o5TjuKaf/xM
	1LF8FikQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhMc-005pLa-8v; Tue, 19 Jul 2022 07:09:50 +0000
Received: from mail-dm6nam04on2079.outbound.protection.outlook.com ([40.107.102.79] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhMZ-005pJR-EP
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 07:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFH/J2/BYxlA69CFoybD4+wEUcHi9I4ElC9IHLp4e+7GdnWnBIyuXpxiALO/RYtsQol/fZngtSTJJ6BJCbNF6fKUJ52zbUTnZMeUx6kUXj+ndDu2a9L8gGpfaIjooyPCYVSoU8hQjMO9djRa/+KbxEW53X6Fg7hIQQDK1ZD53MhSLh6S3/p1+Umqv+wkDet3nnqUXZ8hCc+/p/pDEixXs/D2ZKtmjbjfLWK1QpKdA0va2meAard7c14j8TlsJgmy0ORGnMiivfhDsR1lbWt7YdmH6+5Qk8wtj7MaoD6Gz3u4bmQwHGL7yOG9rYQT9C75ioKgqfPb67LRk/3i337PQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqzPaj1d2tHauchTOHySl4wt55khYdPBr8dNvvGg2Cw=;
 b=WZjRFtfMcNqBW1+XAW7H1MwWWC6YdKo5Ld0zNGd9gJLDtDIpAWyrTA83fT7aJP7UWKjX0v24LgZQ6mJMPjVlux/WyUDaLM7He2YXFDEN78pMB0+5EcJdOgHOrNkS9rFTpMLpGg9VdoblVFas5lxNvPiUWTGBIIu88d29OGjBbE+ZGanRrEUzlb5Tk5t7QQOB0dhaI09F/WH5EFxajk7dq60cyseTWmrDJDYNO11wRFJkbtvb2sSeVtnvCpKE72rPzs6O/C1PY3i5Y2j1uEA4zAtjKJDqElqNIypMHkCKckomnx/gv3t6ykKGi3Yg3Ffeb0nXatS/ywlgrW02H/3cDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqzPaj1d2tHauchTOHySl4wt55khYdPBr8dNvvGg2Cw=;
 b=ScOcwAtUyGfOcAmx8krdPXeudI//g/vd15P+FTc0FjxnQiZk4IQDfF4lZEX3MP3Aqy9ZLOIBD+U8MOClg9m1G9Hx7KjAoBqZsFlSNu6zUm2ZhBwjVGJPmDvs2khDwjmyPBggT0tIJ1Qlq2OiUID6oDfbQZKjGWlA3i9/mMDdpG02NUob4s8kMaakKvJCnOE4rYMAYMArT/Yi5ZwyS668LcYh7GHWoU0D+dfMf0Xp8cq+/2zssLPDJ0ctInG7pbGu36XvKCZtSEjfrUH9aJVcGVS8kJ3SK2AlFVVFtTWTK7gtzUPAhgKOPR/xcxrH3YWXe4+J+D2IkadL5052dHblFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN6PR12MB2799.namprd12.prod.outlook.com (2603:10b6:805:77::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 07:09:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:09:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet-auth: Fix unsigned comparison with less than zero
Thread-Topic: [PATCH] nvmet-auth: Fix unsigned comparison with less than zero
Thread-Index: AQHYmz0+6YMaEPyXNk+0TLqJLJZ6mK2FRo4A
Date: Tue, 19 Jul 2022 07:09:43 +0000
Message-ID: <c87665a9-14e6-38bb-361f-2d31352d8104@nvidia.com>
References: <20220719070005.39531-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220719070005.39531-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ff4e126-b317-4641-13b7-08da6955a7ad
x-ms-traffictypediagnostic: SN6PR12MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  oT0l2N5JO+iyh7eEM7ZTc7ltZUCWmNUvZSKiAlbZ81ydboATrKWillKzEiQHAQEGhRDby+IKHZB12clB46190ZfebCwci/mRvp82ulkLLbkrBUb64v8HzgUdEBSx7/Xq0XbQ/MMvZiZ2r+oaz0KMdtujHCQP+k1orsHkUNFMzvEBWBYXnYtAtP16FsfdlYdlZHwQ81UhiMINzR++BwK3QF7pbLtFfH1izAGp8O0kABCaSmXzRBC+qD+CJAi7t8aw3XB7BR88wwECE6IdKWKTI1e+5tnpoDjcxxqqy6bk0TdamkmGttIBq3F39yWcbA+cBBjA/JCamjLR3wVuZfBUAKvM1KpvPrq1Aq/UQqI+PLWCwAMgxZ28mDTJRgfRp7u8k/eQ+4rEsWegpYh34l3Lpr4bM7tDpBjM+3CGgnypTYHiIFx1tCjL8qm8CIsmToI9HaRUeATnEWLG5/QWJkLRLXYeOn87aMuKoC5I0JNv04z3RIr6B/8FILDInmyUkFnmxwwft0fHhM/6V+DoaHVNjhkPUId7Uq9sL+TG5O1oOkeFrcmFeYLUWieMuOxXC8jEvqwxtMJDNAW/6NoiGueDDQU5ZdNsJdUhHEq8aZcisON8v/xgOEhOZImhGxt9UY1GpAEgVmcfPF7JUUfViyXXqc96/4Nx4DN6bVASrK70qZHaNJCB1ycbwyrkZjsRI2kYNirGWVMzpT7AeoQwQopZ+HefAbeuvNemM5JcCf+ERMCUdUs8fQN2B4/aLR2vQXzEqoj0XQ4+f1UP+p/+spCT/YbeE/8+QlNE2a2oH6SGGFTNs69EOPNq7EqTWKa4hfMzpENIRSjH3LpUQcQ11hLBsC/sSVm1sn8Z0ccNey5JIvU=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(4326008)(8936002)(5660300002)(66556008)(66946007)(76116006)(4744005)(66446008)(64756008)(66476007)(8676002)(54906003)(86362001)(6506007)(2906002)(31696002)(122000001)(38070700005)(6486002)(71200400001)(83380400001)(316002)(478600001)(53546011)(186003)(91956017)(6512007)(38100700002)(41300700001)(31686004)(2616005)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UHlvSU05TmFwc2ViSmRPazNNM2U5TFFHc3dqTXNVb1lERDdhalpMTC9hL3JO?=
 =?utf-8?B?YWNvaW1EelFxM2EyNUxJNHpPeHk0elM1SlR2TUlvd0wzSld0Nk90TFkxVzVG?=
 =?utf-8?B?MWNnMjFzc2lENmJFRkdWQUV5Mmw3TEp6MTUzMG9ydkc0eTVYNkJ0ZUVGdHZw?=
 =?utf-8?B?S0JQTnNEbmtUTFhNSHJHczZrQU5zVWM4STNQSWl4eU15VXhTWmVEcllBclFB?=
 =?utf-8?B?eitncTdQT0JNRDdjRWUzRDNjU1RpcVFzQmlaMTlKbXdUQThLOWgydncwNnM2?=
 =?utf-8?B?Rkh2SUNJZkQrOVNSaEVjTzVFWXNoa1VrbUFzS3VRN09DaFRrblZDSCsvVTc2?=
 =?utf-8?B?VWFnU3Y4VGIrU1FNSE92VnFacW90RnI5VHlTdnFvYWFXZC9JVUpGNHFzZC94?=
 =?utf-8?B?UzB4ZnFOVXJrejhaOWZjVzE4R0w5bTJEcXhQYmR0ajRGZnhNVUJTaVhCdEdx?=
 =?utf-8?B?VVZiMW0rbXdxc08yZ3JmakhvcWFYdTdERHZCL3k1dzZaNnJyd1ZFRXY5UTlt?=
 =?utf-8?B?WHNmVy9ueUdaU0xjeEEvbzc5VjBsRmo5V1lERzBTaG42ZjlEbml3Z0J6aEV2?=
 =?utf-8?B?aUVhQ3ZnSkkxMEJaL0NVWU5qaVAxQysyOW1KS1BneVZNYVdCZ1J5ZHE3M0pm?=
 =?utf-8?B?dDVqNGQ2clVhWUhoa3lZQ1QxUkxSVCtQekRudktXbkttSlVFaDZoWlRIK1oy?=
 =?utf-8?B?MDJ2c0hLT1dOR0FtaWo5SE1CVHFoYTBDVWg2QUg2U1ZRZWM4U2tzT3R4VW5I?=
 =?utf-8?B?cEIxTlo4MXdveGM5dkRwQzRZRTZQWXhVemRIUmVPZUI4OWd3WVZRM2dOYWhr?=
 =?utf-8?B?RWFWV3RzZVNqdXE4R0VpSDh2M1BPNE1JRHhETTRUemNQbzMxUWNaN0lrWUxo?=
 =?utf-8?B?OHVsNGxCNStYeEN4V2xucDJPTHp6K29hcjRicEc4ODJTb2hja2FoSXlYRkhj?=
 =?utf-8?B?QjFDRVRJRHI3aHY3NkN6NDBrZEFDd3p5dUtoc0orZ0txMUN1R0pwMkhRZkxo?=
 =?utf-8?B?UkRTMnVhcktDaFBQSU1WSksrdFRFb2FKQXdicVFYWDg4U0JFYTJhdzlCN2I3?=
 =?utf-8?B?Umw3NDV0aEJCam9IaDQyendhTVN2djRWQ2JGaE5iVVRIRDY4N2RQYVJnVzVu?=
 =?utf-8?B?YTR0QTEvVWc2RitGWGlzTHBZNk1PM2txSmYySDZmQUVOdW1DUWdJVGV4bm1I?=
 =?utf-8?B?blFheWNFeWdsT2kxVmNuc001L1FLSnJGZU1sT2c3OUZGcHArRjdnVXJyRFNi?=
 =?utf-8?B?RmFJWHQzK2ltaTBLc2dnZ0Z1K0xFUUxoY0QrR1JkZko1TWtrQ0E0N20xWmR1?=
 =?utf-8?B?ei8rS0xjZWpvV2ZQSEFvV3REMXQzblQ4M3IwSGdlYktOOXVzOXlGTzk0alJu?=
 =?utf-8?B?K00xVkNBSVFlVVBlNWdtcXVRSFhYZUY2eGZIT2E4M3gxcVdlbmVEeU9TWGt4?=
 =?utf-8?B?bEcwODBTSWNaT28rZU5tNzBLN2dMaVZjamREbVpkODZXNVM3R3drNkprVXpw?=
 =?utf-8?B?ZUVKOGhlWUErbGE1OWdINXdFS2hvYWJSMmZLanM5WFhHODFHeWRDeEtmTDZ1?=
 =?utf-8?B?MURYZGFWM3d5OGVLRDNSMXFleFJNcXJNekd3NHJJMWRXUS9reWhueGRTZ0J1?=
 =?utf-8?B?TnZKbWtYdkNpcG5JQmw1NlBuUlBZU3JRZGpldnhjUHNzMUtQWDdiSWlBa1Fk?=
 =?utf-8?B?cnY2KzluZnE0Sk41V1VpVUZMQi9ncU00bGo3TnNNVWNBV0Z5aHRpT0krblZq?=
 =?utf-8?B?a0gwT3F4SVFmdnhtejdSNG11TGpONnYvVGk2azFGeTl4T3loajV4dVdaSnUy?=
 =?utf-8?B?SFUxcXVGc201ODBRQTB3MmtKUWdYUncvcU5YQ0xxMEVlUDllcEpOaTNLOXNj?=
 =?utf-8?B?UzVOdWVYQWRuc1JXRW5IM0ZOTjJJUjRDa3drNk5YYW5QK2xGSEVURytldmtX?=
 =?utf-8?B?bVlXR1g2R2V5YytYOUdOTlhyK3pxcGlDazQvY3RtZlBRUTFsLzVnZ21IMzR1?=
 =?utf-8?B?S0Jmc0t1ZExnc2s0SGVMN091RTN0cVJKZkh0dmI0d3A4dGFOY2FvWWgxdEFF?=
 =?utf-8?B?NjRhbWxrYXh2RitQZ0xDTVZqNlBnbWlVcVlkUFFWcENxbUdQLzlBd2VDVWFN?=
 =?utf-8?B?MTFPYTJKT3Evcnl6T2dXK3lKc2tGZHVuL1BwdmREWVN5Ky9YT0dsOXh4ZUty?=
 =?utf-8?Q?wbpuslkEk/4xvoVLm2UzYJSWgvrXm1QsNYXhd8GLe3wf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07A6B347C1686A40BF88B1BAE08B00D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff4e126-b317-4641-13b7-08da6955a7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:09:43.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5sw9779ZPgrBzFbfwIVDjw11yTFkJrQDnTe8kPG5iIW/KzvZ9SMxdEdJUiAorwSmGq+NCwt51ze6LRDjKGfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_000947_507328_C1A0CE69 
X-CRM114-Status: GOOD (  12.41  )
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

T24gNy8xOS8yMiAwMDowMCwgSmlhcGVuZyBDaG9uZyB3cm90ZToNCj4gVGhlIHJldHVybiBmcm9t
IHRoZSBjYWxsIHRvIG52bWV0X2F1dGhfY2hhbGxlbmdlKCkgYW5kIG52bWV0X3NldHVwX2F1dGgo
KQ0KPiBpcyBpbnQsIGl0IGNhbiBiZSBhIG5lZ2F0aXZlIGVycm9yIGNvZGUsIGhvd2V2ZXIgdGhp
cyBpcyBiZWluZyBhc3NpZ25lZA0KPiB0byBhbiB1MTYgdmFyaWFibGUgJ3N0YXR1cycsIHNvIG1h
a2luZyAnc3RhdHVzJyBhbiBpbnQsIGFuZCBjaGFuZ2UgdGhlDQo+IHBvc2l0aW9uIHRvIGtlZXAg
dGhlIGNvZGUgZm9ybWF0Lg0KPiANCj4gVGhpcyB3YXMgZm91bmQgYnkgY29jY2ljaGVjazoNCj4g
DQo+IC4vZHJpdmVycy9udm1lL3RhcmdldC9mYWJyaWNzLWNtZC1hdXRoLmM6NDg4OjYtMTI6IFdB
Uk5JTkc6IFVuc2lnbmVkIGV4cHJlc3Npb24gY29tcGFyZWQgd2l0aCB6ZXJvOiBzdGF0dXMgPCAw
Lg0KPiAuL2RyaXZlcnMvbnZtZS90YXJnZXQvZmFicmljcy1jbWQtYXV0aC5jOjI1MTo4LTE0OiBX
QVJOSU5HOiBVbnNpZ25lZCBleHByZXNzaW9uIGNvbXBhcmVkIHdpdGggemVybzogc3RhdHVzIDwg
MC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBBYmFjaSBSb2JvdCA8YWJhY2lAbGludXguYWxpYmFiYS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEppYXBlbmcgQ2hvbmcgPGppYXBlbmcuY2hvbmdAbGludXgu
YWxpYmFiYS5jb20+DQo+IC0tLQ0KDQoNCkkndmUgYWxyZWFkeSBzZW50IG91dCB0aGUgZml4IGFu
ZCBpdCBpcyBiZWVuIHJldmlld2VkLWJ5IGF1dGhvciBvZg0KdGhlIGNvZGUuDQoNCi1jaw0KDQoN
Cg==

