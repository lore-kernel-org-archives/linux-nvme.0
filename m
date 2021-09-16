Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96233C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 17:04:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BD860F4A
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 17:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64BD860F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7ja/rCQbnK0xYm46yYcOQR3jnouFo4jib64TOj2ink=; b=PEtbORTIHHOWd0
	pBzH+qq1R1g0iihz+8jHgGQanvwlMYOLS3Funhwi4Zzo7+4e2QPDzBLgnfBCSmBml7fM1g3Uo8Vfm
	RRidjglWKRiKSPEKi4iaPq6pG/q2pN/i18diCLyKkaiv7X+H4sMqfgCfZ3+NSlFVhXWqO2l7CpWi9
	KFLWjey5yW1UHrD02WTdnPd84oSRou8W9o6d+MURRYFTUzUoQHrhKUxXhzCPWVfC0TR5QX64gO1A7
	yfCU25yKB5HxXp5FQU5ZZnTUDZQizuHB7HQ+7b2aBGCUR1j1KbvL/gatVBMmlpVE5QRQJwOXR/Oyo
	TR39u/1f+Dyq+07P0DpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQuoN-00Bp2Z-Iw; Thu, 16 Sep 2021 17:04:35 +0000
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com
 ([40.107.236.59] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQuoJ-00Boz6-FM
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 17:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfIx6RiM1c2YuO7qnc0uBsHxs9VtypqtMgrEZLiTKq+nctZkXpFYTYUEgBAi6+H/tuf183IZtDIPUrh20fC+0C1s7XU12auRXDq8/Uj8oNtvNUevYOdEe/sIkDcnVg5tZ2YNAPCzc5HDDLkGjhRQUo5kde6SlEbxQhh/N0Ht1VLNkt6pPv3NczUSNT/KFp5Xo52fFSiEC3+D3KI+ju1J/wbOxIy/1y6JrA4p3p9bcpefFrv+cElwN2cbh5O2EH76O6dhoE8kifK5jEEJrh+XSzOSInBIQOR3Vt1iSKZzVsvdStweIaLGKHstHELDe03qd+4XtUFGT8ydjdRW/aU07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BfaFEneVx/97XC1laiuino4pL/uIZ0P2uv32oUL2sOQ=;
 b=A3APt4fHol7qybnkxQ0lhrc81rgeJ+HC8A52i4Hs4ts9mQPwtQY/xuNP3qTWSbNIT/HRjhWpt8Mb415GyxolOlt0lUtttFAOqkAaTotJrLBleLcfT9pFnZQdR6lSjaC04nDLcdQRWHLRWjr0gqHpSrZFhHbEZRzD1cMIknuutxTsqhXU2cBm7fT+TUwcNoC+KnmVFj33NrPWuA/Zh54XPBlS36qsqJOikom1lb9eYfI0ZImvzq+o9LAXn6bj67i3KhGqhuuNPgsf8kcXnTtaO99GI/5H13wL5cEkIWzbM8M+NbaEu4ds7/TPb4rCGrUkvT280NXnXFx/S9H2WK/l0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfaFEneVx/97XC1laiuino4pL/uIZ0P2uv32oUL2sOQ=;
 b=gMvPFchj7YVLUCFFTKSxVIprJlYWDIyDsERuzfIym83vBVV1cAqc1thniZskpkRqcuU9lN8qAHj/rM6OBAORaFRf5tzXPjdv6sVXaGxXd9YqkTuDGB1gAHiEGF3QH0oekqx28y+FEm+egOzOq8ECsVSZ36/WmPBhnWiimKs9d3JxgH1G6hNPydBFl1rje8xTKT9AJpUzBXX/emIch1pLnFCsYDnE2XEdeMdBXDErVY+nNyzh+Nj+R2THcAeS843y5btiCsCCtCFW7n2WGWWmfqBWpZxjCmrpTZwgsODBfYrl7v5A9r/C7Zu2N5ldg3nC9m/D5a7BcMcFkjPUOkVCBg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1822.namprd12.prod.outlook.com (2603:10b6:300:114::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 17:04:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 17:04:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 05/12] nvme: add definitions for NVMe In-Band
 authentication
Thread-Topic: [PATCH 05/12] nvme: add definitions for NVMe In-Band
 authentication
Thread-Index: AQHXpg/OaqZcuaUMVUCpsTxszGDmNaum7acA
Date: Thu, 16 Sep 2021 17:04:20 +0000
Message-ID: <01a48055-c292-5383-efff-6d1ef86d404f@nvidia.com>
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-6-hare@suse.de>
In-Reply-To: <20210910064322.67705-6-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e838a2b-6e82-4f26-d978-08d9793406d2
x-ms-traffictypediagnostic: MWHPR12MB1822:
x-microsoft-antispam-prvs: <MWHPR12MB18220EB71093CEF370D0282DA3DC9@MWHPR12MB1822.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HA0EgEC+zP6/MP9ar4hEUshH+JBoZWohtaxN0mrTb7wLxBlaXoO5jPVO3VwhZMgf0t+2yqivuS4dnmUUtVei3TLQ10E0K6vtEZgWBU7ovczgSpa/IWkggVc4IK12JxTGw1NQXZbFK6lKGb6EfQiMKWp+NxpzbDUthLVvwBHhMXCReUMSBF5UDFkuEtTxQjZkZlOpg+lnWzcuUmiiQOtbNWBQ6gLRjAjnARO6CHFVof/OZ4bByhctTwdwQuoCLQ+CSdOdwsaVSfZZQMuwi7y55xVJRYkUOvqjC/BMNoJFpyf34AriOk1gSMLJu5ytQlpUCYjHfIVXLRt2mxBARTyl5RWowUnV6u4M7HfpYmaDlOoHwE6dHPjM5ZiAK0qd6mmFIjfXMoay8Dd5ZMBf7IH2mKaHTnZRu9X7r098S2PWUU03i90F5CzRCsyhHv9YGoD1FZylYPgcdlF0fOvVdItZItxPdOF35+CWsT68u99/trYzYKQ0J5FOkG6bO9admhCexYkEDh2TAB5UAHlg8wZjvUC+8hTWSY2XwIJJgGu/YVk3d9LZWH27FPDUz2MnSYtNPuuMEa7Jctwv0XxaB1Yx/oODGWjOWTQzrSotvhyfNTMoTYLOMiv5NnmQDjRH48JlozAIUSvviHcUYGIPBRQvVF25zx2LgB9tm3c4bUg2+cHj7aasRs728zvSw/c4GZ7tPeVKBrYUOTIkpFO9yrOOTI3dmTl4g8Pjgha2v+2MN3G6aQE9eFn+Nd91hTdjvQMsOtulnZu2Q+6tg48qQAngA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(2906002)(54906003)(4326008)(110136005)(76116006)(4744005)(66446008)(66556008)(186003)(64756008)(31686004)(5660300002)(71200400001)(66476007)(31696002)(66946007)(86362001)(38100700002)(38070700005)(2616005)(6486002)(8936002)(53546011)(36756003)(8676002)(508600001)(6512007)(6506007)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tzh5Z05xUkJWQzQ1WTVpSDBxbXk1L0ZVZnRaRHdvNW9zU3hFZHQwQU1iTVVY?=
 =?utf-8?B?ekM2TFE3ZWJEZ1JkVmlKRFVuOHdGUHBsZWRCY0JyOHNTNmkyUFRDT2R3Q1dr?=
 =?utf-8?B?bE51VkgxUTBSMjVjWk4yWDlSVjUxZ1h3WVlOTVlMcjFTK2o0STFSSzhWeGpO?=
 =?utf-8?B?dEtBeHhuczF0UDhyTGJKd3hmeWY0ZjFvZWYzREtOZ0d1VG9HbEQxQTZOTjg2?=
 =?utf-8?B?TGZjK0c4Tjc4dXJZVE5DTWxFNXJGaldjc3h0dkZ4N05DYXNRTHErU0dBU04w?=
 =?utf-8?B?MFBZbitVNFkzTXZROVk3UWM5V2NkaWh6bms2Uk5mU3FvdlhERUNLbnhwampI?=
 =?utf-8?B?cnhVVU9PQ0tONGVSckdaak41OFRHMllSMjZOTVFTUysrTUlpMEc1cFhtc2hE?=
 =?utf-8?B?V3JkWGdWZ1ZKek1HNzlKQWUyaFpwaWx3bHZRU0VZaXphbDdQaUdNY2VKZjcv?=
 =?utf-8?B?K21SaFRwQjhoa3NHUG9MR0dBTmNzb2xMbnpaYmNPYlc3S0pIN1RYSk5ZS3VP?=
 =?utf-8?B?UnVZRXdqb0lRTnVyS2wzYnRoWGE3UXFxM2pLTXpvVFg3Ym5mWExGWEJacHRM?=
 =?utf-8?B?RHkyKzh6aTVGbFp2MFFRdDJCdnhYeGVUdmZUQXQxWWJFcUhnOVc4dDJHK3R5?=
 =?utf-8?B?cnNqMFpZcVE1STl0cDlKWEZiMUl4RzFFMVpabjcrMlhnTVNYazl5eFVISzdv?=
 =?utf-8?B?cjg0WWVsbktRZWtCWFY2VUtHZjl5TTlCWmFSMWM5QWV2dDhaK0JBUFBSN0ph?=
 =?utf-8?B?M2tlZ056ZkFqdC9wbFFXbk5qbStEbVJmRzVPWmVaT1NpbE04N2srNUEwTkN4?=
 =?utf-8?B?K3E5dUtDeHhVZ2gvdEllL3lvcURkTGpValh0QkxEemMvenBtL3A1bStveXV5?=
 =?utf-8?B?SlJuenBnWmJHUlI5M0tlZVd1QU1UTmg0Wm5WSHFPRE5HYTJTY0I2SDVWOFVw?=
 =?utf-8?B?RmdndzNXUGhoeHQ0V1FDUXdQRTBUT3RZVkNFSnJzQTBOZkM1K3FFV2t5dUx2?=
 =?utf-8?B?KzhoREgxZzJYL2tVRmpXRW9hNUpmMWcrVmNqSDlnUmVMQys1ZGgrV3Mra1VH?=
 =?utf-8?B?RnlQNUZhZ3F0RXRIYlV5RUxjMXJhUGE3YlRKKzRHNy85M2xNaEJ6N1ZLcSt3?=
 =?utf-8?B?L2FrUkpZd05hUFV0YWtxcXRRc2lsNGxIRHErNHNWc2ZwaVZpMjJpcjRxaXRE?=
 =?utf-8?B?cWxwY21wam5VNlJtY1hNTmdrWXVCL0ptN0xRS2VFRGl0UC9ZT0xUMmlWbEZU?=
 =?utf-8?B?VGMrV1dxWHlNcWZydmhZOTRCUXBkVnhRVm0zS2tRbWNLTW5PRThhWEgwdFUr?=
 =?utf-8?B?cnNiWitrWUhSZlhvWXdVUXc4aVdka2VQdGE1QkR6SmNmQUFTS05qNzFzYjUr?=
 =?utf-8?B?dlBXeUx6blVZUlRlcll0V3RjSS9GZzk2dThGMmNVVDNkdlQ2Z3pZZ3poSVVW?=
 =?utf-8?B?Zzc4bkJJeHV1Q3BJNzBXY0pyMHFVTzdGb0Y1b1ZXQWNrTkx1dlNpQ0lVeXFn?=
 =?utf-8?B?VzEzTTJEb0NWejlJU0ovWjdpRDl0OTZtQVUzbkdJK2M2K3JBNE1FUEY0S0JX?=
 =?utf-8?B?bkZQa2Y2dXVoWTVuYUladFZRdHB5bm9sWXNVcmloWFFPODJCWXFOazF4aE40?=
 =?utf-8?B?dXBnK1ppMVNFYlBYWjdQU0FCZ3p3bDVzVFFrdGJFeFAyMk9lMHJwN3BDZGlL?=
 =?utf-8?B?WVFtZXh4MU1YTlJzbDdQcXpnc1Z2bU5DbGhaM2Z0aUZ6WmRRNXRod2M1dHVN?=
 =?utf-8?B?ZVlzR3JpdUpJVmFUaXlFSUxsWURBN3pKM1lFVGZzRnFKcThMNzJpNThLZVBI?=
 =?utf-8?B?K2JzbTlSd0wvTHJDMS9nNHI1WktBSXVxS1lDTGIyYXVVTGwyRU9ReW9rWnU4?=
 =?utf-8?Q?SAnPywm26g7Ic?=
x-ms-exchange-transport-forked: True
Content-ID: <DA7335E235BE5D40B3342E541DD772B7@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e838a2b-6e82-4f26-d978-08d9793406d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 17:04:20.8438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQC5UrRPku5orevckQa6HLMRF+Tos8QrTo7hHykkJqEax/PbLB9pMfqtWp4aazjM4rGmG1adRkxS43xUE6DFgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_100431_572642_F973B5A8 
X-CRM114-Status: GOOD (  10.50  )
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

On 9/9/21 11:43 PM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   include/linux/nvme.h | 186 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 185 insertions(+), 1 deletion(-)
> 

Probably worth mentioning a TP name here so we can refer later,
instead of empty commit message ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
