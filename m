Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D811C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD4E611AC
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD4E611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z0FPHsSy/ncur0JWs97A1DsNkH+hrKNV0qfGF8i/NtI=; b=AnNmUmu/FOQWVN
	h3wGxsW7SKHEb6GdoCBxIaqw+OjbGu0weYKAyjpPc9Wq1GospB4ZwRx7DKE7Gkf8R+MuGzT48eWnr
	eV88VO8kJj8Ey4dkGsW6y/j4sg8z8DWk30KugdTsqj7RL3ME6GWTUuZzfpCwT5Rgq/WLTjAGimdrG
	azwlYRXmzGSGrCIPP8BK6aDX51Ep2VqquuiWpq4XK2Y/U/R8t8ylel0zjhYtwudvjVIxZcb/sBpqi
	Unjd1lu1JMqNWAXZ+FmAtIM4z50cKoMhAGzAZtaUjI+Y22ZX7wS6eNspdZ3Lr4+Xk2MdCbarYNArD
	L0j7WPskSq8Q/y7KZGKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lu67B-00CZg4-CY; Fri, 18 Jun 2021 04:28:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lu678-00CZfF-Eg
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 04:28:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 57EBF68D13; Fri, 18 Jun 2021 06:28:14 +0200 (CEST)
Date: Fri, 18 Jun 2021 06:28:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, dwagner@suse.de
Subject: Re: [PATCH 2/3] nvmet: prevent creating ctrl with no namespace
Message-ID: <20210618042814.GA18021@lst.de>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
 <20210613200252.9167-3-chaitanya.kulkarni@wdc.com>
 <b6b62366-fff4-81e8-5b3b-c3062211389b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6b62366-fff4-81e8-5b3b-c3062211389b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_212818_679442_F7C1B578 
X-CRM114-Status: GOOD (  10.36  )
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

On Thu, Jun 17, 2021 at 12:06:11PM -0700, Sagi Grimberg wrote:
> Why not just set both nn and mnan to NVMET_MAX_NAMESPACES and be done
> with it?

Yes, I'm pretty sure I suggested that before somewhere..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
