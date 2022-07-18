Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A17C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1c32+mkhxDLk4BT/1YRWGzwDQqG17o7mZdEwSYIifXA=; b=XeM793NPxK2kfxzdXEABRLH6ub
	AG9TgtafQsv7qPVTGPK5vFEk8HDlK10ajtnRs9q1IJNYBWEuv+1fHJUOhMnClUmqBWPC/GBR9VByd
	qZI0DIk+ShVtJjdDdqTGo1yYtG22Fd8I/x9ntCzGDhT053w6udr1XAmAb37R4xkGKBBz6WxjvWFBW
	YJSDVg0URX4SjaMKLgdVLm4OHa9s97rZ+m/sfdkIGtAFnjN4VWDZrmAO8rEVFdbs4p/O6j76dmAXu
	/s2a9ZIx11lqt2jz2qF0hIasEMDYBTNheVaQTM1nDDUVSLrlCJO1CqVPmo07A9CYArwWV5iMEUGVu
	QhlZcK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYLt-001YiN-J7; Mon, 18 Jul 2022 21:32:29 +0000
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYLq-001Yhr-PB
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 21:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuGP6+5n/NoFCtAMj+JIY/3+ij6oGcdg/frvBjWypIxMWmlAgczh8DmTBUbR/1ZqDt2WXQF5kwtrBjKWHQ80oTerS6v/o/hNCnVG1FcSi44DJxhrMBiC9fYN1GuseOn+ZrL+xWlzxZXzpefq/KtDufszefLtshMq++2+L0J2lZbyw9g/9IcpNPVXseiYWPbskfPvaEz2RFc9hPxOU8cnZoyK+cKqem2P2UdLsc39UkYrpPhoicEbwsRnpKoYnuxLb/KNoeRoJMOUiD34gRiVAXHpvmLkzPKd5Gpd3mKPRqFzk1fBoEeboKUPsrHGiSlZtidHIVCeGWWbAxgcwS7+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c32+mkhxDLk4BT/1YRWGzwDQqG17o7mZdEwSYIifXA=;
 b=ZWQXi2S0JAJIQ8ymz+Q3kTTTo069kl9rvILxgNHl2np3nKCrUGj18ASkBaRJfWne1XqlG5i7swnoBeyxDBTv4iUD6POXEcXqlojWcdaqKDl0ugbMufrDhn4HnuSJ5wTJgZ2gMzdCHQgZxpK3BPjRGvtOJMCNPI4Tm6ivSOboVVqVk3MPv8KoU+zuvDYzp3XXTOW9WJ8TDF8RDbXxVlnioyFeymDCtb9q1G1PkjGnbb8/GWWX+MdcXAsvW5sLECjC3WEsnXMzbAAQN+HNSYohkyvHyrRds0ugtK51gg5lyqDxnz4JG0LyImv5garMJ0hzBEN1sXF6/C7XQS0q6PIO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c32+mkhxDLk4BT/1YRWGzwDQqG17o7mZdEwSYIifXA=;
 b=P9MwH9wDcpVC18SrWUCO4v4ftL5w0yWm6a6469n3ydcY0SZjLYlLusYDiHKpJ4+B0be9inWXIsUhNe459yMjj+DIMSB3CjO4S6Ns6xicpk0JERQpBcdLKHFt2zQuhMKKavSA/zArgiMTL3a0uJmKL6gdWk8VLGst7evd2I+QwU+IOJRUHgSQDFsfNUMTyV00zijVl+IxkhtSIG1C9ZJRO1Pua7wx5yZGjQ7iPjAluCFiSazGc+Gvp+bZ12Vh3Wvrj6wNi0DetVFRr4nJat57lctN+G7SinXaSxXPGnKhIvtuVhQz4o90Rz6lNXrbon8ZXIaQUJmVeSF8ahkDEb3ClQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Mon, 18 Jul
 2022 21:32:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:32:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: don't check for NULL pointer before kfree in
 nvmet_host_release
Thread-Topic: [PATCH] nvmet: don't check for NULL pointer before kfree in
 nvmet_host_release
Thread-Index: AQHYmmOUmt8367iSQUCY9XtFSkXij62EpvKA
Date: Mon, 18 Jul 2022 21:32:22 +0000
Message-ID: <6972729f-b3c9-5d31-b3d7-4ddc413ecaa3@nvidia.com>
References: <20220718050141.226774-1-hch@lst.de>
In-Reply-To: <20220718050141.226774-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6c48747-3e5e-4a23-5acd-08da6904fff8
x-ms-traffictypediagnostic: BYAPR12MB3415:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  GdZFXuvqED5tPyue8zNv1Dx4xapFJNhvUexTGgRS27SknDZsCMtbQanogBmxuAc4npks6V4FthRl6NCnyVM2wDqNpDqiuPqDvb0KLYn7LiswOOtcdIZwzX3GvxBxaADrkGvNoJb7J13jEGwCi2G2esl1dJiV8D51CHGxI5u7jw50k8X1ygSHw2bBtdkUaHrawhLp+TiCgHrSJ1NYOpE9kZGrVStmy7jCO2UrugV164V9uuqysuedcarjN9FAZOYvVhPOoMElmgQ+u+5RtGS1bCUp6mvqteAmYI3k5+PQL3q6di355VNyO0CQEUSKDhYuXdiEEWBhrffmAmdW7FZLf4NaKv+HNmmf+oqIE+g+Q7ALlivuNk0zln9IPSb1nlI+Z+bw+AUl0wy5OOdTSzQZwB3/ukhMKpbBGIfZG+E9QlbgUMdLFIbwMY1IOuJBYrOL09hBuFPIUWB4kU488IHkJa/eGBSvXMsX6V1+0fnYE7gSocI7ziVSorMt3HtDIKjXAwrx0oBTdMK85sR0cR5R5uJfM8peIoM5/4ugK87Ii+7ESi5S5o6hUpLXl+0oWawjoFRj/qYB71ZY5hBTU4Z2xVljiNsImoUO6cGOx2H00yTyHfs9v8UWpH8ZGfuLhRy5+Fu1twJvO3LEMYzxOTHczX5Fo9njDdYDcuF1coZ3FIu+F1L2sOopeIPAyxpO/1S9bcui2v2816pbnn9LwzX3Ak7xekM7emW/hOtE3AC0Ng7oZAK764AvgJUgaR2ZG2A3FNBA3xxRURGFm+/HG5drF6GgaVNo/fep2Qvta69lN4yJScUCn1wSkh4Inm1kr0GFfdROc8VCmN+PWDYI0QJDyMVUKFp7k3MZXpUrrsK6hC4=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(71200400001)(478600001)(6486002)(38070700005)(2616005)(6512007)(53546011)(31686004)(41300700001)(6506007)(91956017)(186003)(316002)(36756003)(38100700002)(110136005)(8676002)(66446008)(66946007)(5660300002)(66556008)(8936002)(76116006)(66476007)(64756008)(4326008)(86362001)(122000001)(31696002)(2906002)(558084003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?am8ydUdvd2lKT3NRUmxsQWlUQ0lqcFdTY0VzYWdWcUc1dXlVSktJVVVPTEV2?=
 =?utf-8?B?WVQ5bXpJeWd2VWtoeUZqdW53S0M4UVFKUzZlQjBXVEdTQTJaMUltZDRjUTlE?=
 =?utf-8?B?azIweFhuQ0x4ek5velU0VWRLTU9zMDlBVDZSZ3o3N3czdUFxSnJtQ3BSb2pk?=
 =?utf-8?B?cWxFcVdhVzlqZFFBQ0libE80UjBaN3R2OWxGbEQxN2NGbDNicDN2MmozaG5F?=
 =?utf-8?B?RHdLZVNjRThSeU9pVjMyZU5yZ2ViMjdqYTI1akZvdkFtQUF5NXpNRytaaSt0?=
 =?utf-8?B?dnlTTzFaNkFlR1lGVGhsbWNkUkhaNkhKNUxYL2JGL0laRHBDUlBsMTZvVE9n?=
 =?utf-8?B?blAvQ2dQMmpGbzVvdU9sZDhQbFlIS09DQUdSWGF1d1JZS1gycGNuVzg2WTBV?=
 =?utf-8?B?RlZBdTkraFpqSlI2am1RM1lQZ3paV3hJUnJxZ3FGVTZNd3FYSld0REdGZEU1?=
 =?utf-8?B?cy9LSGIxNU1oNzdmbi95bHhXNGdYQUwyeFd3UHlTZitXREJ3eVZ5WGlhcDgx?=
 =?utf-8?B?andkL0E1UEdEbUwrQVB5UVZ0Si82eG4xNTlHcXJHSEFMZTAyeUM3ekROUHNj?=
 =?utf-8?B?aXVNRXk1Yzh1NDAzc3BkaGNQM3JkWm9qUytuNURSOUZKeDh0QmplT2RvWjlJ?=
 =?utf-8?B?bGw5OVBHdFYyc3NrT2E5VWZYUkNZUUtoRkhzMFZtNWNDcVF4RXJlTVdjQUg5?=
 =?utf-8?B?L2JmeHdtdmgrZjdjWGlBRDVXaThYMTAwL09nV1BkTjhQeEljY1FXaEpiY090?=
 =?utf-8?B?VXBFU0VaMUhnaW9NNDgwWnh0ekFlQ29aOEZ2Z0JwUWFtM0FVdkFycndNWHBw?=
 =?utf-8?B?NC9LQ3EzZkRaN2VYMHB1M2pHem1seUI2Qm9zU1ZFdWtORnd5RVk0b3FwRlBC?=
 =?utf-8?B?cG9QWHlKVElpYm0wYTJRdVBKR0pOUHhqcDd3Snpvam9pZ1p0L3ZjTUV4M2lV?=
 =?utf-8?B?V1ZOcXFaeGpVbEtDZVV4NHhnQWtEL25Rb1FUWUNQNlV6K3NoMW1IVjNTNGYr?=
 =?utf-8?B?dGU4VGhxc011c1ZCSkY3LzluUUNyU3B4WTRDVndoaDhkUEhTc1hPcEl3U204?=
 =?utf-8?B?YWF2WWRHanh5YVRySVdhc28yUWduRHJQdFNnWUIxcUVQb1FEandUWDZSY2dv?=
 =?utf-8?B?MHl4YVgvZkNGdWtSUllaOTJLM21wYU1URzVlTjZ4Y3pUSlRuWjVyN1lEV24r?=
 =?utf-8?B?ZVF2MGs2UUorM3FOOUcxOVJObHVNQTAyWGFQamg1YzlHSE5TeWlpWXpGTkZE?=
 =?utf-8?B?UWlSdmZOeUpDS2hQWktWQ29EME1qY2tkL1AzcDZWMVhtcUJ0d0FHUGRaUGZx?=
 =?utf-8?B?NlRVSld2VVVlUE9LZERDM1lIUFMydWVSazVpZGhJajUyb3RQbDIvNmxKZmxQ?=
 =?utf-8?B?Z2pEd1JLU0ZNSGdlZEFya0J1dlpuM1Q0bXFkOTBuT2xxNEgyREVrM1pVQ1A2?=
 =?utf-8?B?TC9LSWFFYWx6Q09FZlB3cXAwYVlJYXRzYm9ZdnNlVFNsRTJWVlhuSlJ0SCta?=
 =?utf-8?B?ak5YOUo4RUlmSzcyM0xpZnN5d1c4RlcxZUhVZjZQK0x6VjJRUjFPZ1U4R2cv?=
 =?utf-8?B?bHhXN2JxdHBpVERxUFFTSUVDQTZ2SFA2UTdDY1V5MllNTklUcmtTcktPU1p4?=
 =?utf-8?B?RUc1K2d2QW5hN3gvbFdySXpsYUM0YjlObDhkelNYQnlVQlhGQk9BMkx0eHRZ?=
 =?utf-8?B?eU9WaWQxU1I4RlVnOEVuUllmOFNzYmhnK3RnV2ljN3VqeG1RdGJlZjdEQUgx?=
 =?utf-8?B?TGwrTkNRbUF3ZnMreDJuWHI2eUpKenM5bU5SZEl6TEt0NWJQN2hEcmRoZnl1?=
 =?utf-8?B?dVc2bkI1RlNZWldhWW5oUjhJUk12WElYZ0NzeGQ1OCtYRjB6UnpxK2wyL2p1?=
 =?utf-8?B?aTN5UlNqRktYMmlvMWpKZ2JSWFFlWDZNVXhIU1J4ZkZORVlvb2gvaHN6STd5?=
 =?utf-8?B?Ukdwdmc2d0NCTml4RGhFdVQ4T0ZjeW5KZlpES0RqM25tak1rYUlubExCdjFY?=
 =?utf-8?B?NGo0Wm5jZUJYZ1pUS1kvMVlGN093NXNnUHQ5Z2Mvd1k1NmZoczZTT1o0ajc1?=
 =?utf-8?B?eU9MQ3ZJbUVpeU9WNHFhaFlTMnhMSkk2S21nZHJBWnp0WDhFWFAvRUxadkx6?=
 =?utf-8?B?ck5IL3BsRk8zdmp1V0JWQmRUdnluWGNNaHc0dzdXTm5nVzRjM2hZdCtwUlBC?=
 =?utf-8?Q?KSbgdelz+sxfrZZehrOuDih0SyVg1KkbkAv5C0kJoAV0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EA93A9F8EA31F4C9DA9E085746836DB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c48747-3e5e-4a23-5acd-08da6904fff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:32:22.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lKtt2780641iVayP6TAg8xfiTCMxFMrGCcuSTYdJ28ODrJhVdX2SePACDrEr8CdcriUrlI1XqXXK2SsGWbFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_143226_862378_57630C36 
X-CRM114-Status: UNSURE (   9.18  )
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

T24gNy8xNy8yMiAyMjowMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFuZCBhZGQgYW4g
ZW1wdHkgbGluZSBhZnRlciB0aGUgdmFyaWFibGUgZGVjbGFyYXRpb24uDQo+IA0KPiBSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==

