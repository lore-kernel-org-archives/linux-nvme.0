Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3AAC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 19:39:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE2A23444
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 19:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE2A23444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=14C+JiopqGxujNK+im9Yub25T04ZiBjzfIHk//tV/uc=; b=NKMVHDLM62Pp5ZqOJpEgXjgj6
	7gNYOTGWR8YJKs5qbf8I6CxPJi4N8w9s2BPr4Mck1cLlxDNoXt+8vHyWD9It54rbWf2SGaobCXfWf
	ToS2Gz1qU95Vm2Ir9zEYzxzFIX/5Y3Uew2kk36km4QJBJOYNuUw4Zme9F+kDmt8IGAOMpcB2a+kO1
	bPp9EK20jU470r9dzvAsSLdrit2EwEp3rYu15azGYhvQsLk1YElhZ5OykpGo2vgSdKBzUwJDIrj4+
	Q/T+jZ3HBKMOtXzVWnEgsQMhuNuVSytlzHBKC85pH0XYhom/XMlkj9LsmmmmR2B/YIB1m2lOTf2zK
	f/IDwrrMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxb7Z-0002iY-SF; Thu, 07 Jan 2021 19:38:57 +0000
Received: from nat-hk.nvidia.com ([203.18.50.4])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxb7U-0002he-UK
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 19:38:55 +0000
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff763430000>; Fri, 08 Jan 2021 03:38:43 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 19:38:43 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 19:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X34YTlMgxcC9ejn5lH/D7Dsz4HlLE85UmoR+p9msOaQ8JA5I7JEkJsSA4TBNBTNCUfQUoztJs6BGj7J6dF1Vp1odMm+/h8j0Gw67kCvGsxNyKghMbKkepj/0HLtG8WeL17kmVhe3Zv0VpHLExZ4Z92ZOHkTfHzAQFZGaG/p0H8Vs/Ja/5OcCLspDvqHfEICvfP+0o2iHeuBqkBT5xl88QC7DFZ8kqc+9mQPcPOMFUDNbkOYzdp35d1Ph3APEy6nuWNv0fHVcw2km/IX1BVMFw/bO7FH0C7nQ3+eJFrlZ9Dl4tVaAcHrnePQZpLgETsLlqfCIWkmyircNs0jSFxWlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d19fFuf1Whs+B6ehzCnOa+YJgXMJPQ73bI+xC5dodVY=;
 b=hxCIEvwijkvxCkTKgAN7xH3Z2UHssvAc0y/AgVTleqrQWJ05mJI3RZJdn7MKiQHWaeCTTeFXV/U6o3tTLgLQP/Aw7I9B1yQE2yKZj3/ITPwo8fDNPWH6mILI/KMxcfC05DEzRih0DAS/vu10N3QFzyUCcYPRar+P6oDjRov0GI7Hv7dgRxgkdTo0Ke1p9yWLrFk5gLxuIZ+Du61qS0rIjtBIANpVCe83eAlt6hVkemtX4ijDOZQGwKM2Gr5B0S4DvvvmHRl2jgyPyd1XCCRLZiY3Akt0oWR9xGrYR7Gjn7ZHXMWlKvJ7j2dFN0o5X6a3iH5Kw4qzpjiKSp7wns16LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 7 Jan
 2021 19:38:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 19:38:40 +0000
Date: Thu, 7 Jan 2021 15:38:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH v3] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20210107193838.GA921419@nvidia.com>
References: <20201216110000.611-1-bmt@zurich.ibm.com>
Content-Disposition: inline
In-Reply-To: <20201216110000.611-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BLAPR03CA0080.namprd03.prod.outlook.com (2603:10b6:208:329::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 19:38:40 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kxb7G-003ris-UQ; Thu, 07 Jan 2021 15:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610048323; bh=d19fFuf1Whs+B6ehzCnOa+YJgXMJPQ73bI+xC5dodVY=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=l0mXKImGvTQn2GJMlLiQO7Wn9anV9L89MoYNGKBzZOIE1uF8voe5PKtbpCbpVEs4X
 GJlynBtnbMfLNWsVEnohcYXIo0ZLQz/MSk3TETRhihfKSkzD7nrxxCeFrB1Ag0jJjK
 RxMxRCJlaNLUdc7ONYwHUTUK2nW6wiTDxwhDXHndUej/0LRh4qtpUBg7PzVb6xaWr5
 SIDOFLPGL8QV2Kb2TAQH2DoNpISwzmBHaq0YuXCsA5RaLGhT2H0iUna/cYSJf7H3az
 dWXeqbRsV3CjKjyOudjoQFdSKB3nFLVmmNt6zlp0vNbeVvH6CaOb4dv2C8EHo9r7Y4
 eQURz7+WwSqLA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_143853_208441_3E7A046F 
X-CRM114-Status: UNSURE (   8.50  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, kernel test robot <lkp@intel.com>,
 leon@kernel.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Kamal Heib <kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 16, 2020 at 12:00:00PM +0100, Bernard Metzler wrote:
> @@ -933,6 +937,7 @@ int siw_activate_tx(struct siw_qp *qp)
>  
>  		goto out;
>  	}
> +no_irq:
>  	sqe = sq_get_next(qp);
>  	if (sqe) {

Can you please arrange this without the spaghetti goto's? goto is ok
for error unwind at the tail of the function, but should not be used
willy nilly. Move some of this into functions, use normal if
statements, etc.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
