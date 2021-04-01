Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2341BC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 22:22:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B0C61103
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 22:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0C61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e4HlRkC8F3sUlZA0wxv4D8TC46zMINmxpgHw4khV1yM=; b=n5BJzV0F6WJpkZkxsuyvGqVp+
	mlNgkLXLoQyLo6Ujh2hbK3Yt0wMHDk/eUGIfGltMw+6+6HCVULaqlhFvMMdXL+BKZUMwP7P+68x6I
	KqKJCrbygYNA1A9TJy2SrSPExTT2qX4peTZm0s9LwJhtVOu4fivlZ/JtAjeDQbmF4QqVNs2I7QvTQ
	tFJAQiYQqVQ9PVBToiPzwuH19geSpnyJXZN3uB/P1/UgExpH7NmB8/kBW3Pnq/B4aMGp1nElEFhWR
	8B3bvJnG1pEsfzB8ZmC//JkKLswGkBchSk+r0eBli2iIWMNRTYK2yv7JO+7k35zo1hXR2v/0t4PYM
	q6Mda3nDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS5hO-00BBz9-9t; Thu, 01 Apr 2021 22:21:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS5h7-00BBy7-Rk
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 22:21:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD5061103;
 Thu,  1 Apr 2021 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617315699;
 bh=qSQz+D+FmDiQ6HTp4T1YGa7MrJKXtrZAFCONPQvYGno=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=agj6R0hc/4PuhaxPy9/oyLjUQ/mZYc6E+AnNfJCvITj0zoSC5DIRfZu49/dztA0fN
 MkOEGL46U0UGg9KDXhOemZG0ZjjtD8EJ5TIN8Mmk5UHp9nkvgQBogYvTWi+pkaffH5
 9ZQNGRVQ2EAQr6PhMNo1kyLhoqLkn0bwb/2NyCL2D06iEGuNZN4cw2cBj8eDjC9YKs
 DVF96JMnudHsCbmOHkNHVW2ttUVJdLIC4BAxWigHZ3sP/yk0cMiw+iE61m0zloLCZa
 CcgocoFh430iL6dwf8hYyt//r4QyNSzeIp95NFAYxSEHgLeNem9t4fEjCVEPnxFAaH
 9uLcjFg+uO8Mg==
Date: Fri, 2 Apr 2021 07:21:32 +0900
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 chaitanya.kulkarni@wdc.com, oren@nvidia.com, erezsc@nvidia.com,
 israelr@nvidia.com, nitzanc@nvidia.com
Subject: Re: [nvmecli: PATCH 1/1] nvme: add NVIDIA plugin for NVMe SNAP
 controllers
Message-ID: <20210401222132.GC31698@redsun51.ssa.fujisawa.hgst.com>
References: <20210401083849.322571-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210401083849.322571-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_232142_136101_BB66D686 
X-CRM114-Status: UNSURE (   4.72  )
X-CRM114-Notice: Please train this message.
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

Thank you, added with a minor edit in the #include's (json.h no longer
necessary).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
