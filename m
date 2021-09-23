Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B588C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 17:20:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001BE60F70
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 17:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 001BE60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=thdxgKPHucx8p14VAdHTh/s2k1y0QKleqk1LbqmD0Io=; b=4vlhH3Z1w+EVau
	frvZQ4r+RltlDSOxwclgEdv3vF+mVKC/NzkNVujIMHBEX6EMiFb8zPHuH2ITof1nsQY517HkNzuJb
	HmHeaU/rcKSZgGRBGGdMyxMOg/6QW+fA4CpM/s+N4QZkjQgLCBMryf3KJky1JvBSAfcWdWsiQHH45
	Nz1holhz027Nx8EIyBlioLM0OMayMle4YUL0JGoQt6lATLsRYSnSXdPi4Ji1m7OmGXvKYm65pjzUQ
	VBQM2QrSZGWz5xg5/IZ1BR+blWYXuxjhsTygRXpJLxbe3jdAoEourm7w/eKXGqVnfsFVh32CGaDLx
	dL2zPBpcLhFAvgLgWHtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTSOc-00CGop-PE; Thu, 23 Sep 2021 17:20:30 +0000
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com
 ([40.107.237.44] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTSOa-00CGo6-1Z
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 17:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqPsjSO9Iq6PjrR8qpBakVHb3fP4DOKAO5PYQX75dbRJUcPMlwxOoCB5X5oh0FNqoI0N7A+ogdHDj2JKaDw5PFujjUqWEVy1F2FqSloUNIwKCcP5h4a1F/wscUE8a0+mWsk5DtWixZH20n4ppgQo2gfS0ywEKM0fXbgjU/E13Vd74jSS0hy5HDmamWiaIqdtpWcLqnlNYa/VPuEQUpyeJhd2xVbsY7tU1R1XfqZ46W1vtKyjGxeY4GzbLZQ+EqNuBB/asABh1slmd+JqZnIl8Hmqlt/D+ioHzqptf6V2W5RR71zPqtWtzMjPDJQFEbO6eTJD9X8ssfISo2ENkGNOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=K8BALJsOmcVX9MGW1ukmiuPyQItk+7U3Y+qyjw3ESzw=;
 b=W5JZXs7lS4EBm3p5SoePtj/XvoWpche5L01CrnfnGqaompB2ZF7fFU4UzNyaR4DDhJr7qzd714NSwRXy/JZ0t9z2/dE+1LlcYVyDycmDLBnvnsr6g27EjdcSpFLUySWeOGIQH/bWPi9ArJGgDl1BqkXgEsodOez+pvHTgjD5+NTzr87HYe3yp7r/+ZJlRpMUr8CDbzT5d0elYYrCn5fKLbUKuM0CCUh0I4pb0tmF8mlnuaLzz7K7bieBG2Uc/zj4lcpsS1xh1rXIRc44BtULOPws9SXdR3QIX/FWqz1Ow8CK7nsElnxc2tuBSciZrbODHbLeQ92+0KM59hcE0Vzdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8BALJsOmcVX9MGW1ukmiuPyQItk+7U3Y+qyjw3ESzw=;
 b=qmc5XoGRK7/Qr+k8rf+lj3ex+MUfhSQ9N/g9B1YHuv3HOxpqEmqkCKApKMQEq7Uf0jEtW1pXpTN4L96xPT5i/ThCdeNU0jubPd6nU5yXvfHYnjrBQkeOkVNDrtl/ACjEGNmQCNjGoGt+mVnSYc+n+2nfQNkdLLAvqSsCeqWwVRemR0thMvKel3uU0+KU/jXexc48MmT7xMpleFD7mnGSHD1UEVfCmoRp63IiQRAsLL9/TdVU/VhFkFlbPJKWu7gLZKb0dUSQsxX8YnXPmJ6dsD2YjryjjImm7Av2xEHvPc7CzSqzyiqGaxfyo6sgS++UY5tC1yv7fsysTXiinlWXYw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:20:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:20:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Thread-Topic: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Thread-Index: AQHXsGRFz0+97tHOfU+EfUYbUNHLmqux3ckA
Date: Thu, 23 Sep 2021 17:20:21 +0000
Message-ID: <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
 <20210923101744.4204-2-mgurtovoy@nvidia.com>
In-Reply-To: <20210923101744.4204-2-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a127559b-eace-46a3-c993-08d97eb66c2c
x-ms-traffictypediagnostic: MWHPR12MB1326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1326B7B769C27F7971F26719A3A39@MWHPR12MB1326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oz1HeE47B7fcyX0xFdholdzTh3pa4X1eT7MMOItIH4In94h0nsg+J4kExThDiSbO88umSNNPvOVajPLeIiHKcdPrHcu5cibfTwUFxd5Hxxg5cDdYz3TYdCra/3kqQjDKd2p/mlPkkq+A9gPoOkxReWIP/W85zEXvW7rPzzs5US+4UIsH1zKx3onUfmuxfwasXUhiq6hQFm8vyN0yFRpdILwgM/zR1B6cdX2c96MYd5RtO8ewpZPNY34sJ2GF8lqXsiZGs6RK9Hk3x+B7fHnMREb/1nGfJQBRxMF39PxOwK5v8o+KsIgu/P6feOr9L6advqjr3t9iOGchHbIjCJcMkmLTOaU32rAygYQwTpG1PnU1kXtqGWt/c/pw8dmkosrr6cbT3UoMCp3Gxd+FVe056qAicgGwdgh8kGiR24dAuALbNcVvtDS+C0m1K8qAJpGbny/gkr/4/QENs90YPKXZiuKBOqYLAw2a3msF19iPcGHWjlyOXUnHI4AeyiPL2w+vTPKXbcmYKRsfxISQ5bkVq7n+h3YvYx0fG54xCJPjlT330CGN4llgLlQBFH5rmKQm/oheUncccL6XvEe6L/22CPcVGmhSBGs3oNqpkTYABqns2JfCFw4S5bUsEBFWBBMs/AS6uyMgqxqpnCPvNVzMvPu7HC5sq1OOYi30ARu6YMz/shEZg4l+ny3p0yIgWgfmYpa2+TdHtbmUD9gTpDauoKGxUSXOz7fbfu22T+uA9vVLRUqpEwG25xsmEh293Sv2DxDXQBwgwGR0usXZ5uAxrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(86362001)(66556008)(64756008)(38070700005)(31686004)(38100700002)(36756003)(316002)(83380400001)(91956017)(122000001)(66446008)(66476007)(66946007)(6486002)(6506007)(110136005)(76116006)(186003)(6512007)(71200400001)(2906002)(53546011)(5660300002)(2616005)(8936002)(8676002)(508600001)(4744005)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGlKZ0VZU05RbEdlRU81Sk9OTW9KNGNhc0oxUFJUaGNoL05vV01zRFkvRGlt?=
 =?utf-8?B?VHJsUXhDNXBCQVJwVHU1VFpMTmpyaXlHOFJOQ2ZoS25iQjJSLzNBc3MzbkFX?=
 =?utf-8?B?Vkg3Z0Y5WFVlVnh4SUF2WHpFSkRXai9iRDlDaFNYM1dsNDJWVnNrcXFMYkFN?=
 =?utf-8?B?VmYrbTRONVNrUjQrY3VJUDM1RXJkS2NZa2ord2VER3M4amZ2ZWEzbzBRQ1Zp?=
 =?utf-8?B?am9YT0QvYVpVeWpXZEpaaVJBcUtKeTBPMC9vZzdlZURyOUV2N3pCcHM5bmVN?=
 =?utf-8?B?aE9zZmQyaittbXdRWk1lZE56S04zOUJBVDRwZWwweUh2bTNmeUxheUoyUGxE?=
 =?utf-8?B?RE9LU0JSNzNJWEswcTlkeGxRT2Q3K2NjQ0FaWGdHTVNDRUlzR3lFZys3VlBa?=
 =?utf-8?B?dDRrdk40dVErUUwvZWtOK2xpZ1hkTGYxOHdtdjZaOUZYc29FK1hrdTF0TTdi?=
 =?utf-8?B?U1k5N3lLNnhqckRSbEdKc21VaEU1NjRCNWY3MHR1Z09XQU5OZnk0b3VLT2ti?=
 =?utf-8?B?U1d5MGFaQ0V0QkVvd3ZTcHVWbjVJTjhuSmtQekxDa0hPbzZxS29DNDlRVCtW?=
 =?utf-8?B?OGNYTlFMa1RWZ0t2U3cvbDViNjNvc0tXcnhjVDdwcFBnazY4WmZ1N01RR2FC?=
 =?utf-8?B?b1BIeUNDdWUwOTVWbVRTd0VCNk5DQU0zZUNiSnBDR0Uzb3hSSFgrUjVaUTNQ?=
 =?utf-8?B?S01KRW5xYTBuazNEdm1BTUtWTlBZaHFlSEltWXhWM2dCR0kyUXRxKzZsa296?=
 =?utf-8?B?RU5nWWhBUzB6Wkk1blgzUVhvbFVLUDU1bDFpS2JTZ1ZEMzUvWmZlWFNTT29v?=
 =?utf-8?B?N21rNWYvTGRUcytyL0pDWTVicm9rTUhGOXNycXNTWnZLVXAzY2xaYzM3TjFS?=
 =?utf-8?B?b2JXSmFmRlFjUUowQzhTakg0TmJZYUZzSCtzQ2pPbzhCYmZOVmdlNzM3aUZ2?=
 =?utf-8?B?VkRrenQ0d3JmWnFFRDg1cmt3enhpNzloU0pvc1VJM1VLdG41Uk4xd1V0L3JH?=
 =?utf-8?B?aTNXcE0xaENlRmo4UkZzaTN0bmZGQkdQb2cwTWEzYm4weUVZc25KT0ZHWFVE?=
 =?utf-8?B?R01kTG5yNlFEb2dZcDhlSXhuVjhETU5lSlhXVzBzdFRXbEkyeE1TLzdwZnRM?=
 =?utf-8?B?Z3BaNEZXSDZaYys5ak52SVh4Mk1MV013SWc5N1Z2aHR6OFZLVitHZXo2clUw?=
 =?utf-8?B?MVNDNG55TDgwNVJueXpscDZMakVRbXNxZzNnVWJhWnA0OVM0eWQxbTkvZWpQ?=
 =?utf-8?B?ZGorM0djemdYWWZvVm1mNW9ZeVc2Vm85TFVRZnRqc2c3elNDODhMRVBRWHJV?=
 =?utf-8?B?bDhpeTlKdExsTkdYZTI4UEJJMnlraVJPd2szdFI5dG9aeldyYUw0blBMRTFh?=
 =?utf-8?B?aTdxTWkrc3JNY2VNSFZiQ1p2QWZ1MWxJNlVQdDRKQWFRS2tScmtreGk4YU51?=
 =?utf-8?B?T1htVUJiNldRcXFKYjd2akwxWVp3czNjNGRpaEhiSWVON09abFkyc0xwMVo3?=
 =?utf-8?B?bStjd05BQTZrQVR4bzRWU1krMzNPQlE3QVJ5a1pQdVEvSG5lUHcwalpuSnFx?=
 =?utf-8?B?WWljVkE5bWNOaFk1VHhnMldPemdxa0ZjdGYyU3p0NXV0RTRMbkxJT25ubkVw?=
 =?utf-8?B?akIyMWpMK04zdktmTENjbUV6T1J6TmlVVEhOVld4bytLaFdUMnkxMDRDQi9V?=
 =?utf-8?B?OUp0amNSWHppUmQ2aFlYWDlJeU1hYlVWNCsxaTdkTk5BdFl6MmZiMEZtbzUx?=
 =?utf-8?Q?ZHma1Tg/xDV5ekXSSzMnSyVnQt12fy7GEddpbNW?=
Content-ID: <C04A6D7AFFAF68438C895FC939FD7913@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a127559b-eace-46a3-c993-08d97eb66c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 17:20:21.2268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaTF4MvtcqHk9wb+Y/Cv08wvIXjJ09XxdKTjFFZxpDpAVsoGy4MAqVqfSSTdyWnMnTfdCDbKDPwAoR3PspfL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_102028_342622_C6782E00 
X-CRM114-Status: GOOD (  18.50  )
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

On 9/23/21 3:17 AM, Max Gurtovoy wrote:
> This makes the code more readable.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 3 ++-
>   include/linux/nvme.h            | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 4ee9fe134697..92d81dc5906b 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -380,7 +380,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	 */
>   
>   	/* we support multiple ports, multiples hosts and ANA: */
> -	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
> +	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
> +		NVME_CTRL_CMIC_ANA;
>   
>   	

So we actually had this discussion before to keep it open coded.

If I remember Keith had already sent out patch for this one...


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
