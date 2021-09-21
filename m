Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC652C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:23:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698DF60F4C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 698DF60F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dq6eTUnOnnT0Fihc/D+hhxN+eMAudoE5nIoZkG+hNnk=; b=LF4JcPmfgvrLwL
	MQOBbo4jTKFFEEPhx1uErBNoLV9OFg5O/tjrGZTBXjOiDlWuhLSCTm7YXTvOWtkSkCUpILNaiC777
	6faPL+6r9Ay+EIzrVL6y3vjUcNnZvj3RdjmJMuX5XhLfXDyqREz9UK/zhvnT3aacJUs8HWh7CYEI2
	3VOwF1BdMmIEsvpqGhpd6Xoh0uVj5oEK6NCN9J6va9iAa16x9xqdNmGfxPZ8bWREAkYOFokY5l4Ey
	ZR/L/jHdzys+sE3M2hjclA2mehzDkGYDRSjjCMsS1nN8JUYnTHuheZSJYXdK23Vif6mLhDc2dCpZU
	TJaz0jD/TygjuI3gwhjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSlM2-005bFm-3G; Tue, 21 Sep 2021 19:22:58 +0000
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com
 ([40.107.236.66] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSlLy-005bDm-CH
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/GTyM4kjZ1zqoE+cv7qabYLYKiOO+ZEtNePUdPBTVyntypD7HCcfxHzhIHrhyom7tCr9VNQUYTyhKcbjc6mKVWegmN5Dccnh6ffFms74cyVb59jYNuxUNCImwCCO+jOYw03wC4V1ECuIDMlO7ePG3qU8RbmteEbWQcWJYaqxzeUE+fgIa3Z7pCg5hRk6S3dtQ7LbqkEAFaaMxMqoZTcJ8OeEXrSUGxuNrFmmIoDmksmfcvimJ5QAzsthlu/dhBdcgYrEoJ9CqVhdtUQ0qboFC8vBi7UZeLQAtiKKzYDix9F0YAOXIkc5yJQWR4VcswPUa5WF+C0gNF/APZUZcol7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Vkpo3SdwqLXi1a/AULyg94tOtxT5voiFt7LqyxfWkPo=;
 b=cM/gRfAIzjtK70qLi1ikPhSP5cU+ViE9KX0zw89jLN2/SG6QLc7QIBijDKxvnB+qrCd+zNygDX9fgYq5aOEO+kt6sQEtYZQif8zbF0ePEXDT9SbqKkiZ21exXjS77WLvGemGm4t12skH7Vvf2eVAT6iLBgXT4wwMBPkGoFDfJkRsqsfHqJrq5JihYwX6ZrBPpx/YZqM31D9xawTkrqjZK2NL4aA7NnY9XUTdDLrJT4RnZGSPAmWpCEb1hE6UX1I0aPHxiMiqrLyDS6Ipb13G2jLwcAk2cy5OPzk1SnhYT3M0/P0KhNsZdhqALNo9bsWj6lk+A3cyCcs+NJ7lY86VtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkpo3SdwqLXi1a/AULyg94tOtxT5voiFt7LqyxfWkPo=;
 b=hQuV4yhBTLYJPK4dbeACc+N1hFoJNaMbHHJLhjYhI9s6kPoBvh0VWPPVHInDdhwncY+J6W5dKrhcl/Ap4zvWIZu4BgQtYYTcMKRsJHajHs/BDwbi2L6nzGxPum6UzUkekm/2qH6i9ZJZONiVD3EvUJeU63hCFaWB4dyhQ9gsog0epNY2Sj3Iarqgt0ZP2RgO/r7miEXaSyMcEJ7yStNpFDzqtf8/QiVLG0vXAQLaFf4enLfc8/9tGdlILcRuqZLv+h4fKlyK4GKL0gBPa/ZNAuXf0sYvk/mWeptxEAqajSD2jiM0Of22mm7PwWFt07q6MdPlxGV4dTaH+rpKpVSYOg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 19:22:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 19:22:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "mruijter@primelogic.nl" <mruijter@primelogic.nl>
CC: Israel Rukshin <israelr@nvidia.com>, Oren Duer <oren@nvidia.com>, Nitzan
 Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v1 0/2] update RDMA controllers queue depth
Thread-Topic: [PATCH v1 0/2] update RDMA controllers queue depth
Thread-Index: AQHXrxuWIHZ7HGcDlU6lp2ZsiQireKuu3e8A
Date: Tue, 21 Sep 2021 19:22:51 +0000
Message-ID: <0d80a3dc-fa1a-a048-46a2-edb1bcf76ba0@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
In-Reply-To: <20210921190445.6974-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
authentication-results: primelogic.nl; dkim=none (message not signed)
 header.d=none;primelogic.nl; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16e56613-b97f-45a6-7b40-08d97d3534a1
x-ms-traffictypediagnostic: MWHPR1201MB0158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB01585F3AA62D8F65372A3E2FA3A19@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gPWz2QjiT1A9E/Nm50dAu3e0/YucSmlKyQ3KfYwIo62nZ5lHpDe14SGgNr31ITQGX0E5m8divDPh6Du8WOTuDCV+EgNaslONYfREtQQKaKmDzlzQ20BpAnXSo+Fa5eSrm+62tyWRW+PIii5FL+BnD9gtJL3LEZ8WYvcdscgJt6VFAQXXPUWAz2p2TSNpUkG0rYCWXTUWp+7aT0JgjQo9XL4XCYXVCdul4EQQoYqmGmdt0O90I0SQqD8H8GmAyRWmwzNmc+26aSt9V7E23oUPplT8K6e3xFn5jH863gUtnVHPLAz7vMgW8MikHKq21rOfU+am/Kfm9d43To0NI+Grjt1iQN2KvHSdqwr3uovEF1EL6KB5i54khXyXD7hH7O++ZU7p3ZUmKT/vNqEqAlmFNhVmFMuIRdkuyy10G8G70vX+75HNqLkbFtO/QmA/wxqdB16PhytYRynA/GS9BigrD4FGZdNkuG+Tj2GFmlnBSgmihAVAHvpYfJ0HICtbm6bBh5OJJc7WggmMVBvZOlfYZOdW2Eu0ZxDlXT0+0i/xI+rAme+m/HpUc3uhjSqP6+5syUd/hF96WgIV+RMjHZfjdQKOkwhBhn1XOo09uX3vC7CFSFLXO2gQY749yhCvFe/FOUUxtfv///NhSdOKLELKhqFzBc8dJDDACYeUsEgUdcD4gMEsO4/rqss+ZI1eV/nq0LAxUDQ9XnAtTEJv0ZYGc2Xhfw0nbv5L6uPThXFC/s/W3XsWaDktSGJO/PpphxisxqlR6+APzWYK8wzSWKm/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8676002)(54906003)(36756003)(66946007)(31686004)(6486002)(122000001)(5660300002)(6506007)(53546011)(6916009)(38070700005)(186003)(6512007)(2906002)(8936002)(38100700002)(31696002)(83380400001)(2616005)(76116006)(66476007)(4326008)(66446008)(508600001)(66556008)(71200400001)(86362001)(91956017)(64756008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEplMFEzbnUvNnFBMnVXMWh1SlJ3VW9xaEc2TUYvYUZvUjJ5N25zQVZORU9k?=
 =?utf-8?B?Z004eUpXTTBIMU5FK2JtbVJKcG5zMjk0SHRYU2YwZmcvVENpS1g3YnhiNUpF?=
 =?utf-8?B?ZzQ3VHEya3JrMlRTUXlNaWhCVmUxVnNhS0Ird2pyci8zUDYra1FZeUpJNDUv?=
 =?utf-8?B?NlJhQmpSNlRoZ0pIdFAvdW96N1FDdEw4UFRyMWVKcjRwVDNBV1VVaHBOenNI?=
 =?utf-8?B?d3ZxRWlENm5tVU1od1BoWVlMeTBVenpPWHhEYTEvK1lOdmY3RE94bnlNcFRh?=
 =?utf-8?B?U0Y5aE9tUzFmZUhETUo4UE9BTHk5elVXK3Z1RmUxZFdqQzB1QkQ3M2s2ZjA4?=
 =?utf-8?B?UU9WN3BEMWlzdmxSSXA4U00yaGtDVkNPZU9lYU5CYnNpOWlpWks3UjgxR2J1?=
 =?utf-8?B?WTNOZ2h6c3MyYVhMM1ArbUNiYUdWRW5IM0kzbjRQRG1YWHRVSVlzTEUrY1BZ?=
 =?utf-8?B?em1SVlRGa2MrYW00alUzZ1ljSUpzcWxCT0ZtYVVrdVpDbjBmZWd3VkxpekJR?=
 =?utf-8?B?UEhzYWtQdEl6MnRPbG1yODMvdjJLNFpIbCtRYU9VaHZYKy9zdWU4WWxDd2pq?=
 =?utf-8?B?YS9MQTN2QUlXOUlqc202a2E1YVY0dlhLbisvSlJFdisxYVdPTUVUZ01FTXdQ?=
 =?utf-8?B?cG1ZUk0xTzlxeWtzVUlXcGhNQnRZK2dEWUVoQmFmcGJ1cndMNVpPMmNMMlpT?=
 =?utf-8?B?NGNKR1RudUs0UHBJOHdNaFJSKzd6ZzVwaHZSZHB4NWJSYnIxbitYY3EwZU5o?=
 =?utf-8?B?akt0b0liZEx6KzJJTVJsQVFXWStVRS9VMGFuajhadk9sdTBybEFuYnE2dmR4?=
 =?utf-8?B?Tk5YVDB0M2dlSmhnZEFRMFJZcGlTUTBmdVFQTUNZWHhkRzJTckYxZ2FvTTN2?=
 =?utf-8?B?VktHdDhVTTM1UjlENDhrM3EvOHJERXZMVm1uQ1pjcEhJUWZGSlNlZmlTR29n?=
 =?utf-8?B?b21iM09ZKzdxQUwrNzhxNC9FcVdvZUVwNnJ4MG5HMHZhWVNQL1h1V1c5WkpI?=
 =?utf-8?B?S3BDR3BhSmdmL3lTTjR2OEEwMFJvZndBblJBSDJhaVhlekwvTDhnODh2NTBB?=
 =?utf-8?B?bDQ3RWVjV3JLSXNQZkNMNEhMTXFUdHNRMy9Fa2p5RFBvdnBTMGhLMGdFK21H?=
 =?utf-8?B?Tk8vYXlkL2hEUXlrR0F4eUJHazB1ZkZNbGdNSFlySmVKWlBnNE1pTVZDbXpK?=
 =?utf-8?B?WjZRTGsrVUsyZ2hoWHpUNWU2SlE2akdmQzV2QzhmaWx6dEZsOGpvSFBYcjh0?=
 =?utf-8?B?djdRcW8wUkJ4WXZkNDZLZmVNcDhxdFRWa09OTmtnUUFnMWhHUW1tV3lSeG1u?=
 =?utf-8?B?cStteVJuZDk0SzdyZjhTV2VhQ1lIY0x5MjdXVkhXbHRwSmJWbkV5ZHQvRmJM?=
 =?utf-8?B?QWtyVFlrQ0QvSk14R1N5NW5ITUNtRWRQSUc1a2hhNmVrbU94cFR1YVgrakVL?=
 =?utf-8?B?QjRBYUNhMjlyUDh6OFJoT3R0WXRGeCtES3ljVG9aYmQ5eW9YZVc4am1nOGJj?=
 =?utf-8?B?ekdXNkdlSXlqT1NzY2cwczcvaUg1YWFVd0ZrS25tajVoOGdBQmV0UmcyemtX?=
 =?utf-8?B?RGhWR1ZNSXp0aG5CUE9EY3NyekczK3Y1Y000dGhWWFN0enNWbjhHdVBEQlFL?=
 =?utf-8?B?ekJtTEc5RVZuNlY1dDhEUXJITnZYSnQ4YlIzVHJSZ2MxLzkrRnNaS3ZXRFdU?=
 =?utf-8?B?NGlISjZiOUVoN0JqNzZNaXgvemVaV2I2aDczQW5DcXI0RVlwZjZJa3VoZFRJ?=
 =?utf-8?B?SWhQbkRYV09sbi9lYmlkWUpKTjVDM3Mxb3MrWWhjK1VCY3ExVWd3cTlTcTdP?=
 =?utf-8?B?SCs2aVRqWko3N3VBdTdZM3ZjanRoNldpckdtUVpsclVKck1kNEhUVFJKNjNW?=
 =?utf-8?Q?zz4jVLClM9zUf?=
Content-ID: <44ADE1933FBF6B458E55E096812088D3@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e56613-b97f-45a6-7b40-08d97d3534a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 19:22:51.7473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKT5PgPtanA7gtphdFoOHlBHC7gw9TRiVL2y3AuSPx8YmwIoSsgzb+SjYMMekMtElXkngQ+u/3whVd3QPL1avA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_122254_481009_A1D54618 
X-CRM114-Status: GOOD (  18.85  )
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

Mark,

On 9/21/2021 12:04 PM, Max Gurtovoy wrote:
> Hi all,
> This series is solving the issue that was introduced by Mark Ruijter
> while testing SPDK initiators on Vmware-7.x while connecting to Linux
> RDMA target running on NVIDIA's ConnectX-6 Mellanox Technologies
> adapter. During connection establishment, the NVMf target controller
> expose a 1024 queue depth capability but wasn't able to satisfy this
> depth in reality. The reason for that is that the NVMf driver didn't
> take the underlying HW capabilities into consideration. For now, limit
> the RDMA queue depth to a value of 128 (that is the default and works
> for all the RDMA controllers probably). For that, introduce a new
> controller operation to return the possible queue size for a given HW.
> Other transport will continue with thier old behaviour.
> 
> In the future, in order to increase this size, we'll need to create a
> special RDMA API to calculate a possible queue depth for ULPs. As we
> know, the RDMA IO operations sometimes are built from multiple WRs (such
> as memory registrations and invalidations) that the ULP driver should
> take this into consideration during device discovery and queue depth
> calculations.
> 
> Max Gurtovoy (2):
>    nvmet: add get_queue_size op for controllers
>    nvmet-rdma: implement get_queue_size controller op
> 
>   drivers/nvme/target/core.c  | 8 +++++---
>   drivers/nvme/target/nvmet.h | 1 +
>   drivers/nvme/target/rdma.c  | 8 ++++++++
>   3 files changed, 14 insertions(+), 3 deletions(-)
> 

It will be great if you can provide tested by tag.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
