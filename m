Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069AE611C7
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 069AE611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PPJn7Hm6DAT8HlSWDwtqbk2Qa9ya5aRY15CS+F2JegA=; b=K7T2unehAq3q3g
	IJtYCAGMhwnNE7LRlwOSBUJEEOcmX+3FoMsJGdWf+jNf8qTBiQwvGL5ohSWYDtJAnZD52B0egmBtF
	0ybKVv1nLPWO6tSZ0HCO+YV+cEKr/uQ9w8B6hVfLv8e1q0XnyvZaumzzJ48sOMAxElNiSMk2/Q4tX
	AQ9oPd6aWhmAAmibePscR/hfu187JwcexuOMlcuCTc2V52zE3XVwylsRPHkWU7F28c/ANWxTqdb4Q
	MX1jmZG//Lk3uAy4AMDDYStGgUu+ddgrhQz6MrTUK2P1J6mgrhnLl995dfxjMtufttsw9XePeb8ex
	Q2s05L+yeFJ9GillrCVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOMnA-00AL0A-AA; Thu, 09 Sep 2021 16:20:48 +0000
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com
 ([40.107.237.48] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOMn7-00AKz7-RC
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 16:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1aaPWZRFuL2/ND1od3P3Nor/cSxQsXbbhavWiNIxay1UUEHl/3PDQU2fqlZnYO2HWjz03xNnT1A8KOJbH4Q+hl7HbQq2xPc+K3Vp9AsmL8pvNaAm2NUY5PcVGMP61m//IBRUb15DdRQPZtEtTzRLW3kieWkgLfz7AVI00nNL2KqF3Jq1aGTyfUWhPpxNkO89LgF2thvIWxjUdiYSuZeGoCjC4SzkbMDtG+9Gcp4bHWfMm1EJ/77zBgacUosDaBla+j6SpDWBDFIwT052kgH7hiGPVQ+mkHZRIQYwOL3ZjsCQrC48dIVwuhE5plMXSA3reFZscgjaBEVSBcfkJn3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+OSIc+GdeFHd/KgtY4u4a6Bbo1zBrHqt4F3TfvabA1c=;
 b=hu2ueBc+BgIbJ8YLS0WOaI+YvmdOO+7SMEZXaml5rvLiTjT7eL3uwHoHedvmICO3Eb+NIQ+2tA8reGkBdoZOGPx6ahRU4/yN4xEy/9goH1a2wQXpkce1Z7SlnqQl4dVAEc2yG40dJxHLnw0+BiyrCe160xmWs021K8yfKBKKmL25FeeqHhP3CuBTFtYuyFtT3AmAs8VJ1WO5qtESlzF22pgMvZTS4JqIu5zImN5TY4wg7+lRKtKrKzpDTLUiwK7zMWoXVZjXQNDWI3FZyK2gSwPXYJvr20Q0VxSMNm8sW+VT7ZNe94zpAxLGYHd4ra8f/ln+lxppiu27D60YxXP+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OSIc+GdeFHd/KgtY4u4a6Bbo1zBrHqt4F3TfvabA1c=;
 b=FvVnNqWTo9AzQ6q6K7fy8ayJv5Im4+C89nVV1Eu4H/S2KYW5uKt+ScuZISMcSzafMPKICFG/GKJTd2Uhs0bBE3LkQE5RK3wvBVMOLTFi34t1B1nOL6TIjxZopSqjCs12h3m+V0f0wNdayyCGoFp64FLwBSrhV8j2QS+kfreMmQpIog03qpjdTw2yiIeLKns6DJGWr6YIttMEmfrZSu2fjlSTuOn0zKMG1m93ZnWa+yutsRf2pG15xm+DKtquGjVb12MlLkIxy2CdCREACNluLY3KsGs2vFCsERAs7k2zXvE7RhHov5phglMU+VIHwj6XKdkzd7g63gAB27KMraD0Mw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2378.namprd12.prod.outlook.com (2603:10b6:907:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Thu, 9 Sep
 2021 16:20:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:20:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Thread-Topic: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Thread-Index: AQHXpWBtEI9mBZbqwE6oYo/8r/sBM6ub4oKA
Date: Thu, 9 Sep 2021 16:20:42 +0000
Message-ID: <d07f0dbd-968c-df42-ca1f-1def57bdd2ef@nvidia.com>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af4daac8-65f0-45c0-bc2a-08d973adc4f6
x-ms-traffictypediagnostic: MW2PR12MB2378:
x-microsoft-antispam-prvs: <MW2PR12MB2378F920BC4CC73243E82F03A3D59@MW2PR12MB2378.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iFKRxgzpHN8UvLzg59d3KXQsSgBdLUlDzScyyYK7SUkA9EIE5Q3HBUGwGxlFTMUABph7hNieS1F7rGrTZ4IbKCYl5bOkWvfxHrj3lhHjjEgmnUw8HQD3vFFvmksTjZIYw/V3Y76x/d6JzhhR/EFNKqwBJ2XGg7cKZ0cEzKTyjZlKMPnyYfYdr53AS1a++cdDc2Xtut9E9H4FNyKDUhYBIN65NhHOoYBFW06/JkUj05d45S8b2DmMpbDZ3bi4gQkUY51JStefSB+ANHJvNe/mSkvcfI3laDdJdvXu4mjQ5vJhH81uXONnmI7ZSSHNGXtwV2QBorr77nqnjx9Z+adQcET+fDtdZY/cChnFNk9Vl3DULINTN6Jn/+xF6pfJCp+V4Az+YDH2s+Cc2qfQD+uCkP+egoOvC+utUr0PlDjXsD+UziNOBi3JGE6Y5aBDgcYiF+Vo0CCqdi0qbixnVaayMEvWcAx7m1fZgCqwbYKi+8wp11GdJyy/4d3bta+nltT0Fyxtx7sN7lYxdn2vpmBLoX4ZkB0ExpY1ONfpgvGT2IqtB1s2ohR4WTedJubXrR4n2e9BpND8qL2yqSfQzGunybDj6PEZX1hADN9lsWg28DVrRNVVn46SAe5FLgwNHjEkggfGx88B4aIItzqBofMXTtXcMSamDul0RKIZm3fPTocy3SacFomtkDxzb+qqJsUhWpINOQHH7gAOpQpsSRsDBcIdPxgOfQFhbzH1Sq3uErhdBvqLWcFB7qJCoDh2VLgEymzq2faZt+VKWlBhAb+JA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(31686004)(36756003)(71200400001)(316002)(6486002)(186003)(86362001)(31696002)(64756008)(6916009)(53546011)(6512007)(6506007)(38100700002)(91956017)(66556008)(66946007)(66476007)(66446008)(8936002)(76116006)(2616005)(38070700005)(122000001)(5660300002)(478600001)(83380400001)(8676002)(2906002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWduYlltcktlZHYxa0R0anVwb3dEY3ZLSFlQcXR0SVh4NDdUUE1FNkUrbTBu?=
 =?utf-8?B?V3JXanpudmNNWnhXcG0vUkpoOEh4WVB0dlRLT29wdCt4Y0w2RFVtMlViLzh4?=
 =?utf-8?B?L2NTM05ZTFE3ZFpZTEF5U1BKbC9mK21RRFFtWkRORGdTWk1EVjR2Q3c2SU1h?=
 =?utf-8?B?ajRNSFlSU0U2SkNadDFTb001NTF2TFJEd3FGems4YlQ1TEdaNFVlZ0NkaXpj?=
 =?utf-8?B?cVRleEVHeHV5NUI0Tmw4djVYUG4yNEl3R3lyVlRDeHpSaG9JSk5PTE1yK0Jr?=
 =?utf-8?B?d3kwdlk0allacEhndFRGRjdzNjdkdzhGUnY3VTVPb2dXTkJSNzlzVEEreFFT?=
 =?utf-8?B?N0NHUVNIc0QrUkIvNDYyOEFBNEV0S3dsdmtBQlliYUdHQ081UkVZV3dDWkh2?=
 =?utf-8?B?R3FqMVZjV2VhRTVab3VDaXNTTktmcldrdXBZZklKZHEzU0ErWndqZVJxQXNy?=
 =?utf-8?B?TzEvV1J5MXZaaDloUE9OaUJ3UUZlWkRhNHBXNGlGNVA2bk81YWEvQ00ySENm?=
 =?utf-8?B?ZUdSeW83Zi8xcnlKbG03M1dab3RCYm1YNktUd3RPVEhXa1VtVGxIdmlkdWcv?=
 =?utf-8?B?YkJoeUJGS2ZsdXFGMzZrVTRoN3ErRmdILzE5ZmZNak41aUc1dnFpY1Z0djdk?=
 =?utf-8?B?b2dWb1BTeERXNnlISkY4a2hIWlFTL3EvcWhINWJYYTB0REZrZ3NzMGRYUllm?=
 =?utf-8?B?RSt2K3R5VE1qeUVtRWs4ejU4QlkwN3NkVVhLVEtoWmR0Z3dzVFNUNnJRcFpm?=
 =?utf-8?B?Z0JkRDh6LzArNHQydHlVSDdMWEMzRldvekNrYkpOTE5xUHdiVTdaTk4xdFov?=
 =?utf-8?B?ZFZkMlN6NFV1WGhqUkxHdEZEekRkdXZKT2ZpcXUrWWw4MjZOcUkrRUYySmZ4?=
 =?utf-8?B?Q1A3RXlvaWdGT080WmdGOXJOSHcrcENvNnk5UEVpdkFZWld4Q3JyazhWQlQ5?=
 =?utf-8?B?UUt2d0xaNW1wWkdVWHdpRzRNREl3R2o4S056ZWVGbVg5MHVnR2hwZUNrcnd4?=
 =?utf-8?B?dWl6R3RESFdHWVM5VzhLQnh0SG43ejFXWjhyYzBGK2VDOFh6NHZ5WUFqcEs3?=
 =?utf-8?B?YWdrbGNWM3U4K3J3S28yVWRLajIrUUhyOHhxUTQxdzI2a0diaktaVzV3WWlO?=
 =?utf-8?B?SkhTL0taR0pIdHVlSXFHR0lBazE2emFqb2tJcnRja25Iak9lZE5lTXFYQU5M?=
 =?utf-8?B?ZW9wNERSMkRWY3BLRUVPem5oZlZVNkNlZ25jQ1gxOHNrR2w5SkQzWFMrSm1I?=
 =?utf-8?B?TmRwS1BmU1R6dEo4QytLSjFkSlVjWDhXdzdZeDVVK3hheEZON2JSYWlQcEdG?=
 =?utf-8?B?Z0pQNlZaNTFCVENZR3dTUXpqQTNpbEFlYmhpSG8yNmZxdStqMWpGUGRTa3BH?=
 =?utf-8?B?T21BREhkSm8vTERaOGtoK2tua1BKSE1kbEE3NThKWkdZWS92T1o2WnA1ZmU5?=
 =?utf-8?B?SnZpamlVK0lHZzloRW5CYU5DRjlFa2lnYXM3V1BsR1dVMHBCQ21zWjNsTVVk?=
 =?utf-8?B?NndpVVVUcEt1ZEdJbXhXZmFtckN1b05FeDN3NzRQdGZPeTdEZmNld3NiMVRh?=
 =?utf-8?B?ZzBqQnFUUWxtZDJQVlhjbSt5QzVibXhRYU5LOTdLRWliZjl5bTFyY3M4MkNo?=
 =?utf-8?B?SjRSMHEwZE01VnYybG8rVUZjcThOV1BLNTI4dTFYd2U4M0tzWnJlNzEzWERl?=
 =?utf-8?B?S2FLNXdaMnRYRC9PKzhUSlNhajNWSWNIQjBNb0k0WXUxbFF2OEI3bzRBZ1ZD?=
 =?utf-8?B?K0NnZ0doMjdaMnpPVExOdzU4WU5KUFAwanBmR0oxbHBlZmVwNnh1TjdUN053?=
 =?utf-8?Q?5NwJkW7gQxkzY/XFh7j+GETsz4rS81WSkMn7M=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <825A160A933F5F41BDAA6D1BA94499F4@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4daac8-65f0-45c0-bc2a-08d973adc4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 16:20:42.0256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3s2MYyEmWG2QsExLBOJerHD0vG4Rl+Tj/WYdyCUloOMYb8e6UeI0WSFkqlrRLLdZmzsiCjkw5t2pDyZCihFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_092045_920480_43EC48AC 
X-CRM114-Status: GOOD (  13.18  )
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

On 9/9/21 2:50 AM, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
> error code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: f5d118406247 ("nvme: add support for streams and directives")
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
