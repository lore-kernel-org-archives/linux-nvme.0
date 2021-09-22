Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046FFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:31:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5ECE61159
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5ECE61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PJQu3l7vOLqz8VWKIi0EZ6cLEBIX4VL1kHfUBDHkgLU=; b=Da6RU9WMqM0N8U
	I5ICg59mGanpxWxT60CAQcqx6HdQxvNwwpvwRQJ6LMkSo6yE0QxRV0WBD/Ve6K/C+NyKnz6P8GSf+
	I9cNaty23qK0yNquV/bnUR2/QMoEdcnT0GwmZuZogx3N4Laem9z3bVHPQnuwlYu//vWhFqDHK6ktp
	xaJHKtkqKievEPFvwDiYH4CROcmRCgWjF9MnYOSXdxy8kZ2TtOpvBzAZQ/pUlyQ8AwvojmbzNOO0A
	nHqptDoOxNBV91I9ahjHipMGDlhP6Gd+x3/oZmM+GtzLsZehgbxOMzOC8vWzmPnlyTN2Xh0AccUb0
	l5CqHP0jN/nV6WoLCugQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSr6M-006Vkp-N9; Wed, 22 Sep 2021 01:31:10 +0000
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com
 ([40.107.223.84] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSr6K-006Vjz-5l
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCSZ27kfLAdHx9LHOqWSmx5tZ1AwTWDvnwX3xQB4V9giu6ZWgnpoBpN73liEkb7X1301f+mgEHQ38dWLwazQfyFNzOaSK3vIAgdpbOis/Oi3GadlfnyKQ87fiN/nOxxVmDETiF2nlZuaeXP6xvpcG3pAcz/FPzc2DxKyZ9soXh6H3Dedy+SJlrp4MwafIfsCxMdtLVtj0r6T1WZfCg0eMMTVdrsFg0FOj+bt/buz9D1SDs//KR8cMFnegwSnhBlioz4aHY+gULMWkZtlZx/ob5FKhYw1MVxG2ICX0dIAly82kVA7nUctzHhNsjN3gHxieP71A9YkcrG5cZJM36uJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgwCDXyX1+awiP3V+1zyHDPwt4Tcu9paswrOCwYHn4Q=;
 b=METvWQPxlHIIpqD0gShUp0aojyk9w12eqfh3jfSic/Dy+Ww1vbwgAcbIqzbtUjWq7pLA45TWFEsjXAJyFFc/5Y/2wHBBzdDxKZrKBRVve9A9V6X+wn3sQnKuyNT4D1yChsr+81LTnRvmO5rACoWvItGBHJB6/F0ZHcrRqIloMJiGM8lY6n+nLMAFcn8F0dKyJTrGdv/RI1nHFwf8qxeEgEBeZSSMpUXO+BDZ4Hz+SJ1eie376xlvLk4Uilt6HrIrawPE5s0WZDQw/J2pzsNIA4INomAZ90bDMmc4QMS2mMrFiU+CZIvxSbPiNyOKee0KZTyyZzZm2ducrrVIPN0TVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgwCDXyX1+awiP3V+1zyHDPwt4Tcu9paswrOCwYHn4Q=;
 b=uDYcHHXNX4ZOiXrRbvgHnkllR7wNv32dkYe96K95F5I9nY5sW6JUAP+Hbbzl9cO3KMiHXk4oG5SBSvMGSxD2EaXdhXVDPn6m+pFfNl5YHFRg7nEmjT7eQDPXa6f+YuBEi7cI3/t026exWvtA07vCLq4TZfAyuKJHGKpwL9HsZmuuCZEsEDr/8UeL94T7Frm6t+w/xrSyTKZPOPxSYd4FelhCKyB2BBHSjGLMI72LfoXbB+pEaXF1tyBB+Sz8Mv7z6TfqTejhb08yIbthZ/MpwAybooeG47H3Oo6IexWEql8kYAXwjgrvr9FJAmel8V5uwGkWc8tE9QAmsQEdxX1VCg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:10::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Wed, 22 Sep
 2021 01:31:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:31:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 5/6] nvme: Add connect option 'discovery'
Thread-Topic: [PATCH 5/6] nvme: Add connect option 'discovery'
Thread-Index: AQHXrvxHvQtHW41c0kqYRb45Yhl10KuvRQsA
Date: Wed, 22 Sep 2021 01:31:04 +0000
Message-ID: <35518bec-6979-1a0f-5837-c99feda3677c@nvidia.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-6-hare@suse.de>
In-Reply-To: <20210921151529.29419-6-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc1f5af-9f27-4fc2-978e-08d97d68a505
x-ms-traffictypediagnostic: MW2PR12MB2571:
x-microsoft-antispam-prvs: <MW2PR12MB25711196D2DE9743C11A98D6A3A29@MW2PR12MB2571.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PxKSKrr0pFuKX6H2giFVAw8kVLfpwWN/WRG8V4VNBPrOCYG8RkN9pGpEHU2M6PJtLq0LT97/WnDkCr04M+/rnfvoOiQoqAKMDcvzPPiIlbfHzB/TJl474saoDTZdBGm5VThfjCGDrFOsTktsMzTXF3sEbId/35GQ2c9kWOqXThyzxfr+6UiVmzWv6XQXokGzBDCu7TZFJsV3jHXmMYMWytiO4xAg6PW0sXqMSzLd7ai5KAgYAyCyutZPC7ojld5ZXuUzzgRg5/4qSHyAsDtVziKT+Hyuv96QaeJ/4b+VBBd5jV6tTJws+FyAckAXJV58gcywdRaaPawTijsXGrXu2oZxb2fZKV0J4oByg69POpgMPa4hRexgPyVXRFZ3zjaEHrxF86INJQsFcon1xVNEu8cX5xM8V19qu4RWzJQkc2X0xme/jkdWd7kNqnkWR+uMPphXT5751+S+ZPqZRZn6IEnOMkCpWxFU4MrhlBsI44qYEiJrJr3KjoDqnxJUpLNd6sOF4XTi1ndhT/WSahYes3YL4jRcy+YumgdPQqw0ekRcmRZAKCvy67W5kfVlS2YDJcsZ1L6yrpoqC4Y8QOosvjQuAqgp9cvtAN9dHzJon/1wjLaR9nEyW4f2ZGt3KWxcEn7dp66Wd7esWY3wfSxfd3J4HZ1gjVq3rE09t/G4YwS4qvoI/2/41y5bYRccwYY4VPwdNKXNf2zPDhE8dFfEBhN8NKWjTcf2xZA6/L0LfaDEC8CCNK0GgUKCecIWbaa8Nyp/yjQFVrvtWEOuh9uaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66476007)(76116006)(71200400001)(66446008)(66556008)(5660300002)(2906002)(8676002)(54906003)(31696002)(26005)(186003)(91956017)(6486002)(4744005)(110136005)(8936002)(53546011)(316002)(122000001)(4326008)(66946007)(38100700002)(6512007)(86362001)(36756003)(2616005)(38070700005)(6506007)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFlUN2xKZjBIdnl5K2J0b0lleTdlck8zS2FDbWVsVytKcjZVVXhiZHZ5dytF?=
 =?utf-8?B?MWpSM0ovMm5OQ1JRR3NWQWhWY1FHTFlBY0FOYWRGangvV1FUSGtld3daYVVK?=
 =?utf-8?B?THBCUmNmbWEwN0VOMHpJdzhIbWNUVXNnNXhpblVGM2lpMXkwQ0p3WWNzcGhi?=
 =?utf-8?B?SW81ZkxDZ25GY0RWOElWSkE0YTRaakQvZjBZcVk0QzYxcUpKR3ZhSi96a2Ju?=
 =?utf-8?B?STVtUjltUnhsdUVBMEd6MGVxK1NPK2RNdk5HNW53Nm9ZTjZtMXhOOG9vVFZP?=
 =?utf-8?B?RHQ0R28ya05RY0t5d1hiekljSGJrQWo3ZWRpMXFwemFLdk1FSW44alR1OTJv?=
 =?utf-8?B?MlVFWktsRDYvck5RQjB3K0ZsVmJJeTE5U2dOaC9xSXFUcmFqMGxRR2hhVWNH?=
 =?utf-8?B?MG9LOVdhK1dzaldYL3ZWRWgxRjRzUThoby8wNWZGSmlFaHR5OXN4Um14L3c4?=
 =?utf-8?B?MHVOTTNkc2FCdFRWMFkzb2hYMUZEVmpCVXZpQzVTS3B3T0tOaXM0RURpWjJI?=
 =?utf-8?B?azVkbDVCa2FmTllpVnU1b3ZXWW03cXhJK3R3M1Q3RGlyeVU5SEI0bDZLbFZN?=
 =?utf-8?B?a1hpTEtFUEt3ekxkcXhsUHlObTJDUWdaNEVwcUZGck5BVGMyRWdrYWVsMFZJ?=
 =?utf-8?B?ZG1EVFZHQmVlckpEWWZEZWt5YXN2dGRPS0hRVDd3Mm02VnFCSFM5TEkrTU8y?=
 =?utf-8?B?S0VBamZvKzZMTEVtTjErYU1GOE0reWdMQXNUZ0lHcVNscFE0bGgvc3dKQUU0?=
 =?utf-8?B?RUZxcHVFOUJLUE16UmsyQWljM2xTNmkrVUFiRU44L3hLMkNRbkhGdkdBbFRB?=
 =?utf-8?B?RTlWR3NMWmNwMXVNOVMyQUpsV1hBWlQ0Q2sycWxjQ3lmMXYwQUc1bU04dEp0?=
 =?utf-8?B?SEhFS1F0akJOK2F6cTdVN2hFM00xSjVDZ0t4L3NHSXFGNXVaclhVeTMrTHJi?=
 =?utf-8?B?Rk1meHhNWVU3RGxvUEdOMG1iTVMyS1ErSjJTTDlvb2gybERteTVUSlE5R0Zt?=
 =?utf-8?B?TjZnYmZ4Y0NUejhHOG8vM1dDa3RTSDRRNXJ1MVpzYlp4elhVSkswcktKSUJE?=
 =?utf-8?B?ZnllNWk1MVgvQXFjdHl0M1ZyRVVqUElTSTJvYW1jTUIyVlh1ZFl3T1BUY2NU?=
 =?utf-8?B?NEY0NS9IcnJRUitONGg3MzA2dkhkODhLVlhreS9pcldJTENKRWx5eUlMOFl4?=
 =?utf-8?B?czdZalp1bEJ2eDkxQVM2VnJKcmRySmkyZExlSXdqTlVLMEh6SGlLSzdXVlFl?=
 =?utf-8?B?Ry8vTjhEbEMvK3pHMzhzWGdjK1dTNGJpWnArMHRndDYzcXBlbWxEdWJ3RElm?=
 =?utf-8?B?WWh4ZDdteTVhcnlDTE41Z0VLMkRMR2hIbGNna01ubEovSGs5YUUyZE5LbjNZ?=
 =?utf-8?B?K2dYSTZCdVI1Qy9ScUY2U2xrNllXb2VLNlY2MFhDYm92d0h1MzVEOGsrQ0pB?=
 =?utf-8?B?NCtsZ1NVZ2lrYWpIaHpsQVhnRDg3UHZnaG0weG5xSXhyc1NoRkU4NWlFdllF?=
 =?utf-8?B?bG5kS2I0Tzk2ZnJZQkJoRFdEMUh4Q1VRNzYrM2VvWjJWL3JVQlZJc2dnY2kw?=
 =?utf-8?B?YXIxQkY5YnZYSDZvQjBpa3YrYmNLMnl4eDd6TE82YktUTUw4YnRjeGEwYk5N?=
 =?utf-8?B?ZmJ3eWl4N1Mrc0ZqQVRmZm1VOGpYZGVnUkZ5Q0UzK09zdU1FV0o0bmFDcU92?=
 =?utf-8?B?RmFxalZQU1hhQlBERTR2MlVHVFl1YUt6VnlMK2djZEF1SzhDRWRTUEpJbW5C?=
 =?utf-8?Q?SV9NaAxq7BPt9oP4s4VEc0xFah4K1IfCfLGsa5y?=
x-ms-exchange-transport-forked: True
Content-ID: <9F72D8A1B2EDBF46A03335C56A19961D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc1f5af-9f27-4fc2-978e-08d97d68a505
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:31:04.7664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao9Qvgs4uVNk2vymNROBz/qmWeYmJz3bWjQkh4tHRMLD3EZSy4k5V7BatDTVViWofBPGWxfDskqBQr7sgWm33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_183108_261708_EAFA767D 
X-CRM114-Status: GOOD (  12.78  )
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

On 9/21/21 8:15 AM, Hannes Reinecke wrote:
> Add a connect option 'discovery' to specify that the connection
> should be made to a discovery controller, not a normal I/O controller.
> With discovery controllers supporting unique subsystem NQNs we
> cannot easily distinguish by the subsystem NQN if this should be
> a discovery connection, but we need this information to blank out
> options not supported by discovery controllers.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
