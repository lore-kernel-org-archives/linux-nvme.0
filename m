Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD55C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:08:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1237361266
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1237361266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r4vQJGYz9YMLinuM9/ZNK6qerYeToFs0jdCdc+32TAg=; b=1RMIrgL96VVL9G
	HFXfCZQdP7nccttThnYtSCR+9hwj4feWqHfJ3ImgmQsnySW5SuRBWxcmWd5fR0nkXgViIgDc5HheD
	A6IsCHgBOJ7n3SJdleNWSvLaoPIXpRb0J8udZY2fIUxT6pOSTQacirjBwdXbAAy+m+DFSBuUMmSw1
	e7YIYMBo33hMZIxBS1KW3DvBeCyLTJ6mGpqz4ypO8ZSCmnhQMfF1vJS2PuLDFUbzjAabAG/6nBm3u
	/brqKu5Ine85Z6ccZYAE6eEsEjnd3aJOaIAtxFf6B9nSgqfSCFCh6qQQG9lkD8LDJlYwtM43Zkvgl
	hDbabNbM26BjPl6oIJSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwM1-007F6L-JN; Wed, 22 Sep 2021 07:07:41 +0000
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com
 ([40.107.244.74] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwLx-007F4a-Tn
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:07:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW+/VcOKHTIWOv/Uloms0/nETSHq9mhrpaFvXOdwY2N1DUA5pxfFPLprkMiNwwuDuIcLjqqpRz9oCDf4tJsNAsuLl9C/Ye2dq/MH0I3f2oh5s3vUp5OgUqosuYINYXJ/Aq/Q6H8X3QcutuN/hVWPOtzVB8/rqnot14R4ZPhHF1NIf9vCAOdXum4+FeIDzA4pBJo9p1drnyOKTAjmDGBIyIHlNlx7+AfJ2m4fFmaIBL32aC01aVoONOXfr274V6b4FG83Tia6hdxMR9s/Q/EyCoEK3noUbpUAtPb6saDPZIuYT4ezyRNg9D3fKoy3yzt0n136L3wWdhfoK70ZV8/yJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cxpUYRLRlXiXZb8CmZlBBNplUJNhtcaNgRCVbikPSpA=;
 b=gJ4nfkZc8zP76xnxUgZ0/DfqeBvrx1F7IIfWZ5SyRb2ATDflzIRph+J9xVSqS2PmwxI5XepSeUPx0cWOn1GTGgy8SzxJmmquqEE8YAHWj2BO9KTUvZ3D+CGSEg8Ev14ORpVGaE+AuhNWFTZzAhz4ylwOlHkYLHyiKbXLVVRMHrntik5UO+b5BJVszPCXB+uaPwiJ12jyj4DkknbN+jw9Hj+Ye+IlLaRTIacUwjlhkvkwLlKPwX9HUbiFOIGX9kgsFaiqa26fe0k613VUHN3KDElWLIB+jCQfSP8xuT2UqY+efHtKR3sIK1A9O7esfJHl4m8KKeqtiKQy8CwRL6eEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxpUYRLRlXiXZb8CmZlBBNplUJNhtcaNgRCVbikPSpA=;
 b=c8sfPfO9HWhZHKZE09q6DywrEqOY1HptVubR9XzlEdjEshQmLI9IAuDDO1H6mDIp+r/pmUzgntJW/U3Wr1G3FcNeNDwb7DYyOlCcfFmjxy6sl4pZtKZBpMCFnCBhOykHyDGrZcuy5xsqOKgXwd5+ZIxK/JUC8sLFpYQZ7cB5/IvKH1rq93kOca8xzHgPUMaR1iHs75Qu2xpoe2HTRf6NcTjr+gWXVQ28m8aCKgMR5BcamDicA6aoh4BtoUoD9B8ys5jp5jHxCLQ/HzG53W81hi3KCy/I7KgRbjMFkUaUBzDuyBl28ztwOXsNw8EJs4cqIPPNMjb0CPEmxHfH8YWF6Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 07:07:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:07:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/7] nvmet: make discovery NQN configurable
Thread-Topic: [PATCH 1/7] nvmet: make discovery NQN configurable
Thread-Index: AQHXr3wJzTMo6w4N+US6T40H7glkdKuvohGA
Date: Wed, 22 Sep 2021 07:07:35 +0000
Message-ID: <71d0c150-3751-e8ee-05d8-5c01aa293e70@nvidia.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-2-hare@suse.de>
In-Reply-To: <20210922063525.143045-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7dfa82-2e3d-4e79-a2a8-08d97d97a7e3
x-ms-traffictypediagnostic: MW3PR12MB4459:
x-microsoft-antispam-prvs: <MW3PR12MB4459667992C09F4F0712FE5DA3A29@MW3PR12MB4459.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zY+p4NZkEyLQsV4KfgwhC4ZaXyn+jyWfAik9Rci2hoC4sH7wjaaKJIMzvCyGoZUFnsPK/jhxCSCZFYQg6D/yAOiLPyLLOUwh1UyKvWP/x6S3Up3A9cwUJ5d6GK+4gv7j5mYkrzyOeBMOywxEnlTpdDEPbmsxBQsRPvkAORVUOZa90Z0zO/RFPqXA+W/zaqViqoQR2FuZkDAJlrnBAEYQ64pHqGQsn/V8784341iJ/JAad8RSfhhOAfVEKezMOpAXY1loD0eHNnHTw73f5BCfnxwBgdrSzd2fM0yRDSccNN7/yKuSSg3dQ2uqik62FaBlQDYbfH7DFAxnkLC6fVPYoYKPxC74x65kEPFLXTdYQxVFaxGbQ+QBLjTbNTX3XLTXLQkgtiv6Zc5w3e/0AWVqRikhrZhE+XcTifyBzJm7sYvVs2feGNIOHrw2a6hf3sb5xE+aTxbZrMepnGVQSGtbwTL3PjQej2J8TditCczsEzwCSTwMI87ZszvFM7miXr8K+BSxsEJO6w7TRNzgZpowbVjhfzJxykOnuEi2FEz4ixE8n4kZikYO7LpRDSeGyD+eDLhWBF1QKc9t2Vg+GHvuFPoXJeoeNU1Hr0r9ve8c0mpRM6b8JwzRaOHadulrsfBuMicIou+WoMEL+luYic1izPcZVqfcv6ZAjqb8j0VlU474k/wJ4RSmUBWrs9L5W17GvFCYuDTY338yufYo5r2GP6I86GIe02tlE787jDUqYWVHZLHe7sEpPuolG/I2RH3HiEoqbvGiey/J8aqpR7hhBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(316002)(86362001)(71200400001)(6506007)(122000001)(31686004)(38100700002)(38070700005)(76116006)(66946007)(508600001)(66476007)(66556008)(6512007)(4326008)(2616005)(64756008)(66446008)(53546011)(54906003)(5660300002)(6486002)(4744005)(110136005)(8936002)(2906002)(36756003)(91956017)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStEZk1vck9jVkkyZDFQc2VaY1VuakEvUlhyNjdsTnpSSEVBYVVZcFkvUzBV?=
 =?utf-8?B?bG5rTjdKTllxa1VQT1gzc1Q0dDNYVVB5OVRHbHNySFFLOVhrVEtQVnl5RkZt?=
 =?utf-8?B?cFZiMXVXckVIZXY4d2JzaDY5UkdVUVRjZTA1Z1g1OWkreFRuMGtCaEsxR1JB?=
 =?utf-8?B?Q2srbXlMZ2t0MjhWajNiQWJYQytxRWdhelhoZW1tcGtXSEhLWVR2dkxyOTU1?=
 =?utf-8?B?WkJEeU92VjMxaGNraEEzKzNRZCtRRFFuWHBFTkw5dURJVXptTUcxQTVWYk11?=
 =?utf-8?B?ZE56VSttYzlmWDM3bEVoaFVrVmFTRFRINTNtV1grN093Q1ByZ0V0dWsvMzEv?=
 =?utf-8?B?aTRqTVJCRTh3bFhscHptWXFuNUwvU2hWd1lsQjUxTkowc0FJSGJrblJubE5H?=
 =?utf-8?B?dER5VyswTjI0Q2hFbjFuT0l6YVh3d29ZdnYwTXhJNEhlT0t6RmEyQnlIZnF2?=
 =?utf-8?B?VEtWc0h4bk5vVVdTalRRRDdOSVowM1crV3hjR1dXRk1qRi9LanFEcGtBRU9j?=
 =?utf-8?B?REozNUFxVXBtWlJjQVhHRmtoV29GWXoyZnl6WlI2VXE4aXhHN3lkR3padkJn?=
 =?utf-8?B?WEVnT3ZqZ0Q4OVFQN2RXNnhWdDlOdk1yQk82Y25YRVdCOERBN1hVMDJwT2Zu?=
 =?utf-8?B?RTBCdThvdmpzb1plSzhCRVl6eExGd0U5Um9QWldZUHBMWnVQV2pLa0RCeWhl?=
 =?utf-8?B?U3lNUVBYenc5b2RucDYxOW03TzRKWlVNTzRtYjVFVWFKb01iUkI2MXlodnVs?=
 =?utf-8?B?dVRXK01reDB4dURRaFh0Mm1pOXhCekVKaktPUFQ3SHFYcS9pUUt2aXZhYjcy?=
 =?utf-8?B?WEJDUkk2M09WbkJJZlQ5am1FV0JUNUtPWktNSWhrZDRaYTBxV2pyZFZyUVp6?=
 =?utf-8?B?WVh4NHNmSUFSakREWW15MTRzNDNkU0pCdSt4RXRqTG1ZU3BOc1pYeDBNMmk5?=
 =?utf-8?B?S2NUY3NrVFpHUWswRndUOURTTTIzOEJhSDJsQnFGSzF1MGRIVTJNRGFGbmc3?=
 =?utf-8?B?MmRnUkxNYStuSkFudzZXOU5yYWtlMy83NXpiQkcvWDNHdndjWUtaUy9HeDly?=
 =?utf-8?B?bDNSTFI4SUdkVjZqWkFDZkJ6QXVBZjVZUzN0RlFPMEdkSllWcEdXb2JwWHQ4?=
 =?utf-8?B?cGU1LzVuNlZwUGVVQkR1b0RId1BjMXUvSXZjeUNWQzcvTWZqTm92RmJ2bFhn?=
 =?utf-8?B?d0p5UElOSTBjQVN0UmJuYllPOXcwc0NKamt6SGFPMm9QTk4xZ1NBOWFCYi8r?=
 =?utf-8?B?c1kxK0d6TjlLaWNiQnFXNXBOYzFrWFQyZ00vN01lbWpZRWlZOWJQN2ZJNEo0?=
 =?utf-8?B?bUFqUFlYcnFnZCt4MTcyMlRqNHJVSC9GMlQwQzZIUGxiU2tFUkpCbWdhSzdD?=
 =?utf-8?B?ZzNmQzlZLy9VK0lDTGJpVjB3c3pEdVpHS2RmeDZROVNGNkRnNGIyRjFzTEpH?=
 =?utf-8?B?alJFR3V1alhqUXdhTG5wQTNOcEgvNkFoMkFycEw0T1NoTjYzZ0FGYktvYTNw?=
 =?utf-8?B?MXBDYm9wNnE0QUViVkI5VXMzMXBxT2ZEdWs4QnkvSTBDbFRPUk9oWU9iL1Q4?=
 =?utf-8?B?OFl2bldYYjl1dHBvQ1RlMzNmQ3lSVWNUSGdGTkZKbVFCaTM4OHVuY0pKeWVl?=
 =?utf-8?B?UnpKSDdEZ3lBR2l2T2RZNjA2L0tsMkk2RTMvU0p5QTVYV3RieGsxU0lEVkJz?=
 =?utf-8?B?dGprSFJsc05SNHhhVCtUWHJnU2FyeGU5bEV4aDNiSjJJMkljLzE2NWJHZzdz?=
 =?utf-8?B?ci9YaDR2U1VJNmtXQnpUK2FheEliYVF4eWRUbHA1d2RDWnpMVEpHaTZSeEFi?=
 =?utf-8?B?Ky8wUTJwRXI4VWFIREVvQT09?=
x-ms-exchange-transport-forked: True
Content-ID: <70B6C8B22C3DF4498CB98958F6B27A39@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7dfa82-2e3d-4e79-a2a8-08d97d97a7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 07:07:35.7554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIMvbaQocrgSuS6axYsPBKBolCUrkM1NMLy6+TJsha8K0LEa2y8bEKnx/7CaLgO2M4mEHkQ5zd9aOymUM+Nw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_000738_017221_44D82F98 
X-CRM114-Status: GOOD (  10.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/21/21 23:35, Hannes Reinecke wrote:
> External email: Use caution opening links or attachments
> 
> 
> TPAR8013 allows for unique discovery NQNs, so make the discovery
> controller NQN configurable by exposing a subsys attribute
> 'discovery_nqn'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---


Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
