Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D3C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 10:41:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF53820782
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 10:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jQFzUBu6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i7JYjRGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF53820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NEkpBeeYk4BbV7ubjQMfwK5y6gDyXu6yAuFxQ+zZFKU=; b=jQFzUBu6Vq7Y6MxcC2e1LnZQt
	rx+D9dr1lhztieB2DhVYqZa9N2YW6p7svk4BPm58QEkEY/5Y15gZ3QIlsHkdQXovKQbxUEaBP7y6a
	SZ4y3gr7VUglBknL/GVx1699U5uQpzoSAifsSdtXFEOKR/J/HEvdgI/+lfLMpbpN+9yCaVWFG83Sy
	zAcT0OOu1vFtXLgv19e23ubs97gmtEMzP76r9pEFZL5dPhxRDNmkRJi0m6JLGACgiTow7bwPjzCGh
	FRNH3lUZFuj8wTBu3IiV1k+ujETpv6NxbKUP++IjhwwhOOUUy8OetrOQF9pzyRjJawnY2vW/483Cq
	gUm3h+bHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khVlE-0002Le-Bv; Tue, 24 Nov 2020 10:41:24 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khVlB-0002L4-FZ
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 10:41:22 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fbce3540001>; Tue, 24 Nov 2020 02:41:24 -0800
Received: from [172.27.0.9] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 10:41:10 +0000
Subject: Re: [PATCH 0/7] RFC patch series - NVMeTCP Offload ULP
To: Shai Malin <smalin@marvell.com>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>,
 <liuw@vmware.com>
References: <20201119142107.17429-1-smalin@marvell.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <3c90ea97-4628-8587-288c-dda04ec92953@nvidia.com>
Date: Tue, 24 Nov 2020 12:41:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201119142107.17429-1-smalin@marvell.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606214484; bh=EeIw/EXYDrZ2ITse5Tsnl2wK5cg3Po7HyUV806GRoQk=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=i7JYjRGy/HNA9ho2FvOmPlZvcgbagbs+lv73iuUfgBf5JMqusNEby4YY9qb7dm/a3
 RXmI/iwlhHy2vYk6r5MI/0upPzyOCuDbGJLwSb9FtuTOxmzNJWiWelCnC1C7VyEy1I
 R1HhYcmqciTuKdUjrTlV0R1dsCp7HWcvOttUwY3zkmBnRk7LEWx6zUIk739io5gjz/
 DU4JRtavp8cvnidctldL4tW2HWKVHk2oHEle96WLLythbpwOP6qYvernNAlCTShg6J
 YM5AhhmFbeqBzNUlJhtpkTCWX9Kng0ZgEaI6pPgTAcQvMytb2sUoc5XhwGYG7G3Ay5
 M2ElHQH2U+SAg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_054121_662636_4D8522DD 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: aelior@marvell.com, agershberg@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, dbalandin@marvell.com, malin1024@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/19/2020 4:21 PM, Shai Malin wrote:
> This patch series introduces the nvme-tcp-offload ULP host layer, which will be a new transport type called "tcp-offload" and will serve as an abstraction layer to work with vendor specific nvme-tcp offload drivers.
>
> The nvme-tcp-offload transport can co-exist with the existing tcp and other transports. The tcp offload was designed so that stack changes are kept to a bare minimum: only registering new transports. All other APIs, ops etc. are identical to the regular tcp transport.
> Representing the TCP offload as a new transport allows clear and manageable differentiation between the connections which should use the offload path and those that are not offloaded (even on the same device).

why can't we extend the current NVMe-TCP driver and register vendor ops 
to it, instead of duplicating the entire driver ?

AFAIU, only the IO path logic is vendor specific but all the rest is the 
same.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
