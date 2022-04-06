Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0226BC4321E
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jovff1jDngE2EE6HiPH6Xdz/t7EL8ZK3XHXwPijHgTI=; b=KAIqjaDmBwo3L++dIu8K6dreUy
	hcdag5MxigsohbJZbUwT9LlWLMVjGbBMlFMs0xbQX7BjeFxgTVqsL0hWPVtw1oe1iJVlmQxjJ7uMh
	yR8Q/fOPJJn35IVxVC2CeIMgVJUTf9qmBWd0+NmEk8XPP7cvMLPHlH/drNe+/xifj/GhI2yugTjjD
	Uiv4i0eZ80KTLmilQFtCOpt9zsz6G3V7Sema+Z52s5z89otP6U6u+BDPdv8ifGMNeyeC1vd5pECcT
	6a4GAar2jaIRzWtyi2C5F7LoJ5KeTYi+yk+cMms31mcygLbWNLNvpb3AeUi6VuZu1Gpi37cvPCVY9
	K5f+9zbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc9Iv-007KGj-1Y; Wed, 06 Apr 2022 17:18:49 +0000
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::613]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc9Ir-007KEb-D5
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 17:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGHF7OFKOMa4DKt3OUd4ahuyb57R4w85dztyOzmrMNayuyi3xytPKaI9LrGSTgBrVfe4klDlnva2yC0FED8LsR6VSFHYXqpS+o20uT23hNrqodzjxD2g+QfZjjmblcjHaWe8p+izBYhB2WGk+FYLr7Ct9QVoQo0lFyiC+cRIVY7PdLJ1N3Zeh/nPs72/8/q6LV7w1KC1/tYaopCJ/f6FdDI1S4uD2LLirWs003auZFWZ+RwYIm+y4H6vAjfdW9aoQotIBdtf/0Nepon61YjT1Flcrspdjp1eHjQ3h9ceBaz5qEMSGaunn8J9OTgSpK+HusjLY7fpkdsmYV1pRwZAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jovff1jDngE2EE6HiPH6Xdz/t7EL8ZK3XHXwPijHgTI=;
 b=GEewyPkk70XJH9U2BOa8856f84ZU827x3hPxgmwKwnycvldS9fU/+i1sDbMP0TxnYiggEGAttcH09qn6x1Pha1ozJe2QzWcodmsTO35Kev6YQ5UwDd0Vb6RQbh+qhEimxDphyYQ+G8hkTYG3jbvacwsJHCom8mdSGFR2xEyB6CAcHaY4ixxRxQYYEd8bwfRtOa2o9xPB7Lqq6CHqWUoWPP/vj9Xh+QFUN0132gdfTgeLz7Ytz1TDALhIvtO7WyhY9YKwHEZnKgdfzfnXWnqusSDwab1/Se7L09QnyvKrZlXcIT6B8k8EWgZuBpHiyGR34XoqHKE2qbgQtxYklx7J5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jovff1jDngE2EE6HiPH6Xdz/t7EL8ZK3XHXwPijHgTI=;
 b=GZMICQPkjaJ/HQ6JCr9kz5M9ULka5fodVLfFaE0CSBbhtGmlCrVN6vmg+YQs412ENBGcDqYGHKp0GjWBRAXIPMUa3wQKfSkwh3+6HgA4BPyPub7NxbFYofN1DIXg0Rg7gPVENsf595FPx/gmFynxvG+skKWSp0p1shcgmMHCnBjT9X2ij9E/iuqI8cAeDFBQh8uztAdM3XIYI58C9gW5mqK6SHyJ2Jw4MNRbqR5376Yl7eIR3fEao21fAr1eN+1xj+2pIkeD45Ly/K5+h+3Q9gN4ABr8oXopqY5znQhjj0HB6fhNDnNvZgBGWzCjlWxKRKhufcj3qYAJPpDGGPeGYQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1298.namprd12.prod.outlook.com (2603:10b6:404:17::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 17:03:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 17:03:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "alan.adamson@oracle.com"
 <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAADIoA=
Date: Wed, 6 Apr 2022 17:03:43 +0000
Message-ID: <5a6ca93f-0542-762b-587f-312c9e429626@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c77c03a-d94e-4e32-913f-08da17ef6830
x-ms-traffictypediagnostic: BN6PR12MB1298:EE_
x-microsoft-antispam-prvs: <BN6PR12MB12987EA2453C9A3AC7996AB7A3E79@BN6PR12MB1298.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJZABEGtuNqCMiuicmyo3lfjbxl0SxeHf1+75+j2AHIgMQpM0/5oYacVKAS58DvsgySdDMn+/CYiRsBpjcXZM5QO7R01+xVGQ12Xz3BoMXOAA2xfz+j0oD7Ca4xjiQQ9+MPwGbOmUb74W0RL7CUsFoNA7qAmT13lbnaXqRFjodXLG3/nM6EwDzkwti+WDwfUKgZhjxq3j0po7+pD+E9e+kSLEI0v5Mujms2L3J9Us0vovdhRpLsNk1RokrK8IT4PCc/vipXttlHPLs7DMXCR9oHsrtAZSkd+Gn77HzTpuYS0uEzP4Jrj0S6UOMZbFNNPXnVOjt9AoDxUNnWHtpngRYGWC3Zk7BmyWvG9dMcqI5x/9TX1Xvt3YTGX7GYMQyckfjGTGpaYcvevIIg5ST7Uq8l8yDtIv53HKTKWlW7HOh+xOrKRKCSUNy0sudN1ygcnt+AMFhcsPzj7uRGYWz9vB7YjXS3sqBqIB9H35TIp84RyflY/hAMT3+Zkx3qvJEhfseZFlzh1GWEwmqvBA+jtKOQih0wYz50rsQY2dkOBBXKRM3BW7qxjfpfsE+1ofFPnC5jNWohMgnF/UZe01CNhZD9cabXizqsn4dQf+pR3tYhr9V5lht/4iHzeJQjQBQahdeqIXVsdDJIZRzqsx92mgkhOLmXuQBu4t05xpAzAuXei+kksXF66lKFCIt1f1Ou5zZr5W5SYlcGyhYoRwroNc9yPfbRkONvEBRF1xDtQWbb7+3JfqRxr2VkMhr+cufnq1g69XcqIs41GNLzDDNqMOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(38100700002)(8676002)(66556008)(4326008)(66476007)(31686004)(76116006)(66946007)(64756008)(71200400001)(122000001)(38070700005)(54906003)(110136005)(91956017)(36756003)(66446008)(83380400001)(6506007)(2906002)(53546011)(5660300002)(86362001)(186003)(8936002)(2616005)(6486002)(6512007)(508600001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlZtajVzQzNZa0pHQ3ljdVVXNTBnOGRFdlIxRVVtVklVQSt0dmlVdFpuaWl4?=
 =?utf-8?B?eGZnQ2ZENDF3ZjkyR2RrbVg4bkJnMzJ1Z3RSdUxNTmlVZUtia09qamlhVFJB?=
 =?utf-8?B?dWVUUzZFVFpwK0pNTFA3dEtabUk4bHUzamNDSUhOaHkvdWFETDIxK21UczQx?=
 =?utf-8?B?eDlhcklOWHhWdVgyU0hNYXg3MVJYZE8xYWRUWjhqZDVnY0Y5b1A3TkVleUZV?=
 =?utf-8?B?NVlaY0dtR3BKUDc4azFHd0VUNU12RWd0bVdoQU0rK2Nad0lKWmIrcGUzWlg1?=
 =?utf-8?B?YUlIdGpUMVErWWw0dzNOd2JiSm9PSENMYy9zdTJtanhFQzE4Ui81S0hxWlRl?=
 =?utf-8?B?djY5ME5GYVp4b1FmMUpZcWRzV2NRQzIxNU4rNStqc1phb0ptMjdIREhkUm5s?=
 =?utf-8?B?ZEJ1b0xqakRzQ00vL0FwWVZKNXZhTEVpRjAwaTFld2t1TVloK1Fmb0IxMGps?=
 =?utf-8?B?NG9oRTZYdEpDb1IrTXJMR1ZXZzNjUG5VWWpsdzNjb2k3TFNYejR2Z0d4UGVL?=
 =?utf-8?B?UWVNR0d2c0dTc3o3UERueVlQWU05R0lmdlpiRjNKNEVMa0gzRVpGVE9YWldl?=
 =?utf-8?B?d3ZkcklGckdqQkpCR01XV0JXcGhtdDFYWEo1alF4ZmpINlRuN0hPNDFyRVlN?=
 =?utf-8?B?ZFJ6d2l5S3E0RTZGNUZ4elZkelpwMjc2ZG9wZEJKVlNDQlh5enhqV3BHeWhF?=
 =?utf-8?B?a3F3THBxQmVPRmZnK0xKU0hXNkttWWxqUElyZVRKREtCdGxIelgzZm5WK2Mw?=
 =?utf-8?B?c0YwMjdOeWwxRk1aZ2daZ0ZuWVBEYndGUG4rTVQ5NmRvbnRoNzRCSEs0Y1B3?=
 =?utf-8?B?YkRSVjAyZXd6b3JNcFIwdGdDOUVTV2RtREtNeWtwVDR1eXlTaUJrWHY3dmpk?=
 =?utf-8?B?Zy9xdFdGL25kd1YySGgvUHFURzJ1MkM5SStucmRLZFFQOWJMVEh1WS9HcXMv?=
 =?utf-8?B?dEVvSjYrRFR1WjlnUGRHTnFOQ0VmUmFuVlcyUnE3UkNnVmJsNThDYkZZV2Jl?=
 =?utf-8?B?MzZzaFU5ZkNEaE5jbHgyOE1uKzN4Rjdva01pQWx4b3FCTkZwb2JFbVNQNkV0?=
 =?utf-8?B?aTJFUE40bmZoejFON0puRzU4TVVDSW1Kc3huKzFQRUZiRVpjZ0VTbHJRTGxh?=
 =?utf-8?B?OGlNTTd0a3pxL2lBYmRXOUQwcjgyYmhZV0NlbnM2c252SUlRbmhLRlF4RW1z?=
 =?utf-8?B?eldzekYxdi9YaVFFQjJYWHJETW1NUVRDUnFuaGlscmZJV3ZCREdXN0owRHFN?=
 =?utf-8?B?NXZWU3RsbGtCV1d3WTBQSDJhNW1NUXN3d0JET20vZWpRT01EV051UEJjMlVM?=
 =?utf-8?B?Uzg0eWp5UDM1ZE8zSFpOR0NaS3JGdmJRbEhXb2tUbjFOYWtQNTNjaWR0dmZh?=
 =?utf-8?B?VTJ0U3pZMjhrTmF5QkRyVm00emdNUzhPaFExM3U1MHVxTDNWU0h2cXFOMGxW?=
 =?utf-8?B?alZHOXVQSmViNmJReVNDcEFvMDZoMVhWUGEyVnE2UzhKK2ZjUFh5U0pHVDVL?=
 =?utf-8?B?cEpHZmlQVW9zdkxWdDVwU01pRTJadmNHNTcxd1lOaC8xbnQ0bHlZLzJYTEN1?=
 =?utf-8?B?dWY2RjdmQ1V3N2lpeHM1ZVNoTzNmaklRV0xJYlIyNE80QVhHT0w0UkpQSjVi?=
 =?utf-8?B?cFZjWGgyMWpKWGUxMVd5d2lqaWk2cVE5U1FxMmpCeG50R0M4aVdNS09GR3FF?=
 =?utf-8?B?ZWYxbFkrK3htekJuYTcxUGZ6VnNHT1NxTUoyMC9XL0NKMjlqME11TmFiSUMr?=
 =?utf-8?B?NmhGaEhsRFREWTdoYTNRNDBuN2JYTzBNbWlEMmlGa0phVUhwelk3YysrWFQ3?=
 =?utf-8?B?RlZ0b1B5eW82cC94MVNxRDV1aDh6eWVoNDM3dUJ2eVRmQ0ZnSzN6amw3M01m?=
 =?utf-8?B?Uk15WG1lOEhCbWRDQW1IQU1ydEIrcWROS1MrRk1MTGordXlCVkpUZmszZkRp?=
 =?utf-8?B?RVZRcllRWHlScXA0MFZ6eDZJeFFGYTQzK3lvc0t2RFAyVmxjSEJnOCswajRE?=
 =?utf-8?B?Q3RQeG1CUmUyVCtrSCtLYmRsdjlqb0JWa1VFcTVXTzU4VkR4Uno5RFJLRC9Q?=
 =?utf-8?B?VWJoZGlzeEJaYVkzRW82WUxQendjOXJSeUwydUkvSmIraHdjcWl5OWx6M0tP?=
 =?utf-8?B?OWVvWTdhaHNrMitSSHIxQmxta1oxOWdFbzlCYVVNUHllWGxoWEpadmN5VHln?=
 =?utf-8?B?UlFrRG1yWmFNTUhFZEFYZlppZTQ0Z2dmaWx6U2d0ZEtld3BRU2ZvOUt4WDZU?=
 =?utf-8?B?M0VNMUc2R3ZGTXc0WDF5QnhwN1VBRXZ4NVdkL0FxVGFnL0FOZmZ5VTR6OWxi?=
 =?utf-8?B?SzFhQjJSRWN0MXlLVFA5WGppOEsyK2xNQWZRdUZRcmdha2h1eDVCb242QTRQ?=
 =?utf-8?Q?W5hBo7yVT4uxB3M8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BAC7821FA04674E9194837B2F53FFB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c77c03a-d94e-4e32-913f-08da17ef6830
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:03:43.8357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1f0nuEIcL3cKtKD7Ahv5M7GaWHng6ClXylRFS+u396aPyXx9wL4Y84r+NbloD4P+EA9uwEVMnhMMpC7F4FyOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1298
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_101845_474730_70670548 
X-CRM114-Status: GOOD (  11.56  )
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

T24gNC82LzIyIDA5OjUyLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gV2VkLCBBcHIgMDYsIDIw
MjIgYXQgMDk6NDE6MDlBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gQEAg
LTM3MCw3ICszNzAsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9lbmRfcmVxKHN0cnVjdCBy
ZXF1ZXN0ICpyZXEpDQo+PiAgIHsNCj4+ICAgCWJsa19zdGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vy
cm9yX3N0YXR1cyhudm1lX3JlcShyZXEpLT5zdGF0dXMpOw0KPj4gICANCj4+IC0JaWYgKHVubGlr
ZWx5KG52bWVfcmVxKHJlcSktPnN0YXR1cyAhPSBOVk1FX1NDX1NVQ0NFU1MpKQ0KPj4gKwlpZiAo
dW5saWtlbHkobnZtZV9yZXEocmVxKS0+c3RhdHVzICE9IE5WTUVfU0NfU1VDQ0VTUyAmJg0KPj4g
KwkJICAgICEocmVxLT5ycV9mbGFncyAmIFJRRl9RVUlFVCkpKQ0KPj4gICAJCW52bWVfbG9nX2Vy
cm9yKHJlcSk7DQo+PiAgIAludm1lX2VuZF9yZXFfem9uZWQocmVxKTsNCj4+ICAgCW52bWVfdHJh
Y2VfYmlvX2NvbXBsZXRlKHJlcSk7DQo+PiBAQCAtNjUxLDYgKzY1Miw3IEBAIHZvaWQgbnZtZV9p
bml0X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgc3RydWN0IG52bWVfY29tbWFuZCAqY21k
KQ0KPj4gICAJY21kLT5jb21tb24uZmxhZ3MgJj0gfk5WTUVfQ01EX1NHTF9BTEw7DQo+PiAgIA0K
Pj4gICAJcmVxLT5jbWRfZmxhZ3MgfD0gUkVRX0ZBSUxGQVNUX0RSSVZFUjsNCj4+ICsJcmVxLT5y
cV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+IA0KPiBUaGlzIGRlZmVhdHMgdGhlIGFkbWluIGVycm9y
IGxvZ2dpbmcgbG9naWMgc2luY2UgZXZlcnkgYWRtaW4gY29tbWFuZCBjb21lcw0KPiB0aHJvdWdo
IGhlcmUuIElmIHlvdSdyZSBzdXJlIHdlIHNob3VsZCBkbyB0aGlzLCB0aGVuIEkgc3VwcG9zZSB5
b3UgY2FuIHJlbW92ZQ0KPiB0aGF0IHVucmVhY2hhYmxlIGNvZGUuDQoNCg0KUGVyaGFwcyB3ZSBz
aG91bGQgZG8gdGhlIHJlcS0+cnFfZmxhZ3MgfD0gUlFGX1FVSUVUIGluIHRoZSByZXNwZWN0aXZl
DQpjYWxsZXJzID8ganVzdCB0aGlua2luZyBvdXQgbG91ZGx5Li4NCg0KLWNrDQoNCg==

