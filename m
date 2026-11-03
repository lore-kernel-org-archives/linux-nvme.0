Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7B606A337
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fjq/mNY7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kETAuEbn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yCIVDU95bsgdkbTt99AMpbnlnJFmTgXw72B81ZuUDoo=; b=fjq/mNY78uVKFmpgVydBCZH2Kz
	SQHfS8wJe4Jd3suPlxnrOx/+y9A8JTLqQP/Kn2LWOzFPQEK+mXJ6AKFvGYpaVaqxfASdjGW6TNZC9
	xn7k8cMKmcb6MSFkkD0NBkTDwjlC1OvE71xloe6kjelSHZOIOx8sOtPDIU32WkbKFWr5ugYvOgnTU
	xS0Ouj/E1er9fx4oSB75w2QHNgU7pGzJE1rWT2ZrGQR7wUMjdCe9O50p4FLWk+OSn4ULfk99NYTXK
	d6kgiPWBXsLqZahvbpgVpLmVHl1xpaX1t8PfTz0EuxYyU7k/x++XqBv5tkyVh2Hjji2IgMhHdm/sj
	68NC7zEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGYL-00000002zBV-05Mr;
	Tue, 03 Nov 2026 15:36:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGYK-00000002zBL-0MYU
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:36:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 75DA1403E2;
	Tue,  3 Nov 2026 15:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8601F000C1;
	Tue,  3 Nov 2026 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720159;
	bh=yCIVDU95bsgdkbTt99AMpbnlnJFmTgXw72B81ZuUDoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kETAuEbnZ/BruujLHSuvhDmanYeoe0fWnDbfCPoQ594J1hK6YTs0gPBie3Cb8K3gS
	 91P0clCFW7kOsrgLQKJys1s7NkWR8w0PHhWTDnfsLbsqQ7FfzM6ncr/CD6UvepSmUU
	 uKyyUaLEBBI9If/2GxDIXZhK9A4/fHWp2yh6nGIcyi9ySPl28dg668s1HlmQzSX1ZF
	 72LkUFMCxLhsEFIfQLPBf3fSSUZazMlh7P5R7B+zgrDwHZiZuWVXXAJXQvw/bNBxdN
	 pu1W0EJS2tA4Lje2354jAQkJsEoEkpay4UoSVDf3SFnP2QvGcgBVL2CTTEjVAvjag4
	 Pef/LBN4J2yxg==
Date: Tue, 3 Nov 2026 08:35:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: James Fantin-Hardesty <james.fantin-hardesty@seagate.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix arbitration burst field mask
Message-ID: <aun_XQSOMjlbweKD@kbusch-mbp>
References: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 01:18:53PM -0600, James Fantin-Hardesty wrote:
> The Arbitration Burst (AB) field of the Arbitration feature is
> CDW11 bits 2:0 (NVMe Base Specification 2.1, Feature 01h), but
> nvmet incorrectly masks it with 0x3. Use 0x7 for both set and get.

Thanks, applied to nvme-7.4.

