Return-Path: <SRS0=Rcur=6R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4BC28CBC
	for <linux-nvme@archiver.kernel.org>; Sun,  3 May 2020 12:44:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E55620721
	for <linux-nvme@archiver.kernel.org>; Sun,  3 May 2020 12:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZROsCQqh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EVMcxO1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E55620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y4YFoVqdvMTK0Pq2whN8iJE8Z5swenNJTsVYaMIQm54=; b=ZROsCQqhL38cIh4H9GW3yKlJg
	XmTYvZTnVj6vscB+Zuy5vsaxZtsStpDtktaApV73bvbex6fxUL5JELrlQZd5EgrHk954YNgJPJn45
	SxLHrJBhve8vEwj3EK89WeUZf7ue0oplkzKed2ggTpseMcmt1+S/yi+E5R0KUJ9lPusp3TvzJt8lO
	HIkjAD30THoracONKy7BQj5CKikDrAerMp6kDOCwsSAe6XRwcyzoHpy8WGLUzhVrVQgVSWNneywpr
	l1FsPgNhGRnRHWJckvdMPFgNTeB2JLM/PttUMMSJ50p/JmIRAJBQt2hZ49hGKmwqYV2dHwEjgZIFu
	OuzA6SgVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVDyd-0004Fe-2W; Sun, 03 May 2020 12:44:11 +0000
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVDyX-0004DL-Uz
 for linux-nvme@lists.infradead.org; Sun, 03 May 2020 12:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ3eiaU/BgSoJ0QbhhbODNBD8v/obvTW1JjIJRGpwwFsf+m2jT5+YUWz1u/XSMNErS+YcexnT9pENiQLfYP/X4EeTjbUAAU2kAsz8uMFHaK01LalwHHW8UJmAJrmZOEQf4f/QNPR5tC3oiUQCnkwbFRXa5wLAeKuL3ZnLpKQElJxx96AqpFUx7VNZZiYk8W7Jk9SZj8cWc1JV2unznZULIXdV1NPOqO7J/sDyNA1oBXdpsT3/zGw2fFPmurqyGGtQECqtP75UzDskAloZJ4bCGWE4L1XsnO8Q41JIakglsh2sGmikEFdxq4yLk4+axvVOpAQrPhoy2/Yw9LH6zfAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0As4/mhYce+DXUFI0snzxgQUmiVs2UzcirZ4HG4QaNo=;
 b=BSAU9RXHdW4GsOE482ecI8XWS54YHrEXbbp0NaZFtrLUhiUg7c7xbIjDh+WnR43ibXNrcMyI6C/1tvY2xKKIh5UTgBfajvurgJViBMX1gxznpJY4MwR0lvBKUREdHLYapHJRQO/J75M447MfJCd5LP/oCVBVRRfLHbEcpJ5+AwRW5719eHs2nheXZn0KsgQ3cOEdDvKMYDtO4SMTjDDA/g03xECDOwiD9Fzs2MrYVYp56qn08sPCoVkPbLLuCBiFnuHI32OZHYhobGw/8wJIebLZ5PxjBEsIPd6Ui0Tg70bs4qh/Q71t1Tg9J2mABsxC7TYYXPghBCgzTAV1aBOFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0As4/mhYce+DXUFI0snzxgQUmiVs2UzcirZ4HG4QaNo=;
 b=EVMcxO1Abr33jf94nrTqWM1mk2e+CBBX3wj3FUgWk9x4rFMtb/imTULaWiVP1lS7njQK0smSUCmCL/YtH4D9fqaKD2e1dh0CpT2FV9DHrjl5vsxAnMPUtkJdRGv2a3wXmAnbgNonKtJtKxcRQZ6x9+rA4Jey8ZHYwX9PPNQZN+w=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sun, 3 May
 2020 12:43:58 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2958.027; Sun, 3 May 2020
 12:43:57 +0000
Subject: Re: [PATCH 12/15] nvme: add Metadata Capabilities enumerations
To: Christoph Hellwig <hch@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-13-maxg@mellanox.com> <20200501155347.GB17680@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e22d56dc-a2d4-0a17-bc4d-6b8f1a1d8ad4@mellanox.com>
Date: Sun, 3 May 2020 15:43:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200501155347.GB17680@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:207:3::23) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM3PR05CA0145.eurprd05.prod.outlook.com (2603:10a6:207:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Sun, 3 May 2020 12:43:56 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49cb9c66-b1e0-468e-c7c7-08d7ef5fa5a0
X-MS-TrafficTypeDiagnostic: AM0PR05MB5873:|AM0PR05MB5873:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5873C0C65D2981D3A852E108B6A90@AM0PR05MB5873.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0392679D18
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR2GmLN0kN3IJatY195FvFpnqcg7CC+NwQ5D22IUjFe5HQgXo0+xUO+jPDMn06dusWXLFx3OyC3OMyc2SQPUH0x9NwCZVH44OX3k4Epvsw6N0AIl4Va2j9FYZaGF6TCjSNbt9fEaWlBjD2RiRwnA1IH1RhThWNtjGZiD1tTzeZScbEZ2IAI1APuUY8yla0GK1xYgJTO5pUEkAmZHGmh6kukjMoKYYz6+mNcC5PhA88ceYEralcn4fUfDbqBJ3DKIzlgFDFPepqlMYx8Rgc53lnIBT0uXb2xJzt/eCxIo3Kp6TRRc6lX2Wu3dxPFjcXWHkxfQQXtCcnJ5aAjm1PEkVzdPFWKVNjjoffLFhkRKnXeBIm8ukTZeB7+7dRwCma6XYeyhbSGSDY//1XCkcWZi4CXeojkVJEtwKP4dQsD9btsh9nFV6FI+s+iRsi3PkJn7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(2906002)(6916009)(53546011)(52116002)(107886003)(4326008)(4744005)(956004)(6486002)(66476007)(66556008)(2616005)(6666004)(16526019)(16576012)(186003)(316002)(26005)(36756003)(5660300002)(8676002)(478600001)(31686004)(86362001)(31696002)(8936002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4bPty8s7/wX8UDtvrolyyQUWM3hAg8X+Zw08l28NdMSZ3d1IG4BX0gXaYG3YatDy9GCqsJ0wgzQHEoIMMr6alkO6TjHsRcA9nUG8/+4Y5KFDOZGuWW8kihY6dRzEPxehvZAAcEw0djnd++uaMYDzomRbAsktWFs+4QgrAGmuAMa+byjNsxN2RFwOYtr4XmhI6PwlK4+jENmTg17Q6x+MircJ150bEWCpzx0f/HWHIlURTJ5WOfA9RRowSpVsqU2kgGKL5xo05cKOp0ESp8Ct63pAEIqBJvm0nslP1Gju5gqwvQ5tZ+K1tCtuFk06uoNx8r2SeqhyTdymqwJB6QYtZ9AL6eBkMC+ANiXXf5ZZ9qDhRYwIDORwSyv3Ih3dtmEVbRoNvrwJXQwqmG9SJ33GOOWnCZE8OyNjXeh/R2qrirXPFKabHTJAl03ppA+M4Inoz29WgxTzopsYSx24AFSgyc8LgOnkLu3nf/eu0E7PywcVlQu2sDBsDU+jj47ymWrojd5bEQQd03UyxNwyE92M4Z+lSMxtDJnLauR1oI58k+KCz85t+/IHv8shJJXBywCd4Y9/xeUVcNVP43I3GiwDwcOA+OGsoqvmpAJ1H09YLUh6NfdtagGRw74GyHJA0/Qu9GU83X3UTGltygG9TBNenzgIn9779H0rarXVsdmMVnUn/nKk8+FiDx6b5KNS8sAbXFC+bB7wR0awqU4mWMB3vvIPWLgGyHdvdWcWXsoZ17mbqV0oA5Ak/Y+yLxkysbJiGSl9wSgo9O2Gei+susKdKZrSm8RtwbX/hWmK6fwCO54=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cb9c66-b1e0-468e-c7c7-08d7ef5fa5a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 12:43:57.8322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/PDT8/TtV+9PIKzeYzey90vnAd25JXaXa+tBpL6ggH5uxPnlG2k7cWQabYF616XULhYfnm4pOe7OGtfK3ciKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5873
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200503_054406_080961_AAC56023 
X-CRM114-Status: GOOD (  12.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 5/1/2020 6:53 PM, Christoph Hellwig wrote:
> On Tue, Apr 28, 2020 at 04:11:32PM +0300, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> The enumerations will be used to expose the namespace metadata format by
>> the target.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> And while reviewing this I really wonder why NVMe has Bit 4
> of FLBAS and the MC field, as I can't see what MC buys us over the
> FLBAS bit.  But of course we'll need to set this on the target side,
> so..

Right, this Bit 4 seems redundant to me as well.

But we set both FLBAS and MC to be compatible to spec and other SW 
implementations that might check both fields.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
