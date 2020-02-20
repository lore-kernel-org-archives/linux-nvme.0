Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9697C11D0A
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 14:13:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E898206E2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 14:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OBOxNsGQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rP2y0oMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E898206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lh6xW67n69WNnwT2QLVSqyicDcs2iVwk7iaISqYoZp8=; b=OBOxNsGQWGzgN9wynzUMwcML9
	jEufOZvygJEmrEenRRC2jhdSnCxKsxMRuAULrY3SLarudF4VzF9bJ1F4yLLbvh53f3Xca1kc4TNon
	ITfmpRd+rqc578urXJfhbwySk5e5uTnmzuviD03x+Y0kiBbJ6Q28JET1s5ZJ6Ju+PgVoWOi8ZPRQz
	HmbOWuc322rW3j2jQywwZ3TPFrI7HEx7sU6D+4BEO00DNVtOZJVDvbXRpxpYRrEJKr1wGorn/aE5B
	5gPBe56aIwSMF3sbpT3gBnZzZB3CyyJGTXNrVtVB/j1e0qZYC4dYo1c/Kl/aLABuM3KUnh6OE3Oy3
	GlqcTbD/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4mZr-000156-22; Thu, 20 Feb 2020 14:13:19 +0000
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4mZo-00014S-QX
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 14:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKxgCAyeeI40v+ogpuQJMvvPXFInBkC/qYiXtby6p2NMBj7e6GTyoRc7C8VocQE7/TtjE0YmW2Go0Wpmmn7DcXj/XIpA1gYVV6W3HhJ3/fc6ad+zmw7gAiZKHlnXRU5Cy6ZAUa8nRKlkQfOfD561vsgGxgVwV+kC4GAJG8lYFkGVPmgitXRElkVreahUce2svoJHtoRDkwJoZZRg1x8wYeE9zSmrosS0fDvH6xutiVcqGX+ECd+etXNPnf0xxp/qhXoqIE1m1xgfYBsPpecV1J+KITm24jnvwvGAs3pwN2za7vrrT2fATwysMenzqFbkVF3FFyYVgh3iL17IT85lFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFqKJE6JX5OQZhQ8KACVKhp9wHCesqAoll21SZlLQa4=;
 b=FrFswrXiL1PkXjmjMWWDwEg+86GPiZXMABbcTiS/GOzhNk81DM1MBUW5qBd1SdfWEZSQ62ZVlEemZcpMos9elIY6HWVvLMVthSRPF08yPxp54E7dXD2TQoO0SFzMHbAQTTvjPuV+uDVT7MaN0f83wp3ffZ+i4hSZ5ey1PbS4q5eXw2MxbvwgVmw8blHLDuKfqJwAIEy7VOJoNZ8+7NB8ZpbXH4JSpM53jib25/o8AL9tWkFLfXzCvI51OlZbKMQ0o55Rsqifx2molPkF36p8fpmd/F+GLrPHk4s1OfRUAKi0rDL6KMnh0JApgm8HCexNdhcDeBeA7fjoQlij84FZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFqKJE6JX5OQZhQ8KACVKhp9wHCesqAoll21SZlLQa4=;
 b=rP2y0oMU6vhEJOldZ1QSE4TvR/kEo6zeuKooL3Fwc3w6BigqKtASgb8niDKuWz6Qliyrt6GIr/PyZ49iAcFZvh6qE4bPu/NMSjC2dxJNWWR7Gccn0tMiYzvCJdrr5Ykd8GWFlz6xrT184H2wVz+KQH8vzTzvnVsFDolO0pnVCKA=
Received: from HE1PR05CA0330.eurprd05.prod.outlook.com (2603:10a6:7:92::25) by
 VI1PR0502MB3760.eurprd05.prod.outlook.com (2603:10a6:803:11::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Thu, 20 Feb
 2020 14:13:09 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by HE1PR05CA0330.outlook.office365.com
 (2603:10a6:7:92::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Thu, 20 Feb 2020 14:13:09 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 14:13:09 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 20 Feb 2020 16:13:08
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 20 Feb 2020 16:13:08 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 20 Feb 2020 16:13:07
 +0200
Subject: Re: NVMe/IB support
To: Christoph Hellwig <hch@infradead.org>, Talker Alex <alextalker@yandex.ru>
References: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
 <20200219152053.GA13942@infradead.org>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e2f116a2-ee5a-ee53-32c2-1f1e8d998567@mellanox.com>
Date: Thu, 20 Feb 2020 16:13:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200219152053.GA13942@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(966005)(70206006)(16576012)(316002)(5660300002)(70586007)(53546011)(336012)(4326008)(86362001)(45080400002)(4744005)(2906002)(110136005)(36756003)(2616005)(31696002)(36906005)(3480700007)(478600001)(8676002)(81156014)(186003)(8936002)(26005)(16526019)(81166006)(31686004)(356004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0502MB3760; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e7168c-8890-4cd9-aeeb-08d7b60f0373
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3760:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB376003F11C7C1378AC132BC7B6130@VI1PR0502MB3760.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdpIVlEGywvCDExiuU+NghYOBybBKqfVAhsWF/cDUv2PB9xI0euGz5G8NP9F+uzZ5soteTeNdX4UPRS8zEeMpUMMnwrC6VMfsWokqUlv6PTLeUW/PveXKCMApsGVMk63qO3aLQVk7YLesuXyl0+vNZ/gS3G5OxkKrxOM+ZPoAAU4tLPFmq0EureOSrHsO9U2/fs5GeUwen7Ms15NSpQrwdbCqwqOAwIZwpd77iTp8HFPuXqSzP+trENwAZq9aY3EH8oLxfAy5AdBzrZEf39LVdT8FYBscOb5vv5zD7ue/XOK6Ny4nt2WwXhwtj7lKToSHZOXh15JQzZJVdko7sF0I4Dxab+zksKQdTeIANzsJXL4ggo9oeY8NUuiJTTJTs3hyrCXVxoTqj4PEX365H2ytdlhLH+kNLiDL4w1V8TEXCYvHY0WuLiizGhqe3hL15Ndtj4t7rYncZx4e5/ZZNPRbVDQVNUx7z3OkeVFJj7LbiRRoxp0RMqYyIdCclVk/nwGXEgAPLaQOTi5TRi7njm5JWKZuDBGUWVtbsijYkebMCtpkowUlkUlfLv4DNTUAftl
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 14:13:09.2830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e7168c-8890-4cd9-aeeb-08d7b60f0373
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3760
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_061316_939409_3F4DB5B5 
X-CRM114-Status: UNSURE (   7.85  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/19/2020 5:20 PM, Christoph Hellwig wrote:
> On Fri, Feb 07, 2020 at 03:43:22PM +0300, Talker Alex wrote:
>> Hi,
>>
>> is there really exist NVMe/IB solutions?
> All the original NVMeoF development was done on IB, just using the
> RDMA/CM IP based addressing.

I guess we can consider adding this code one day, for users that can't 
use RDMA/CM (SRP supports both options).

>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C6a85529d21224f373a3708d7b54f5253%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637177224606112903&amp;sdata=QpJWMIFVoKqlWZLdlNcbvEnRS2RlLGmTzIiVNoB4ueA%3D&amp;reserved=0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
