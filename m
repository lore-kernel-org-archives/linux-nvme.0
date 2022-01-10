Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56696C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jan 2022 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbrWyyjcFZGaPvOfQ2r4eVOLMJhccGMf62BcF938xzE=; b=J3PNDRlcvd4KNOpwCA3SnPQFHA
	BjLXw2MC5ZNyBDNRXvKKUuoYXg+MWaN9lzenxilkVZqHV5lH1otmoNFCUnOHcreUeG6eGMJ3X2Xoj
	mVa3vxBEGLOvlHlM0Ugfi/dgEz8PYdJuCaFd2z8t3EZAttVdS6PZp9vZ4Im3tfBaMH3I4f4NEGDB8
	N5zK/hzMXubP4DpAkK+N3PA0nsoet0t8Kk3DH4HGMsTa7gRtvshNGjldaziw33vEMFPAO1oy3YOHG
	3vIF4ZkU72iX3VYI+3SQ+qytPHAJLWrPy0stJYFSY0D/W8dqJhB6rsZAg/C9V5tAQRw0/zjl+iSXc
	0FaQylPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n6x9F-00CGnR-Fo; Mon, 10 Jan 2022 16:03:53 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n6x8c-00CGPM-8j
 for linux-nvme@lists.infradead.org; Mon, 10 Jan 2022 16:03:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 808F5B811EC;
 Mon, 10 Jan 2022 16:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143F4C36AE5;
 Mon, 10 Jan 2022 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641830591;
 bh=q4CqZUNV9IKwTLk7aGn0W64+w3W0XnG5Jwte68uIpNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hkjca8bVpyS2GmeFwf4FvrVA9/gzvCtjmDVsmvqj0B5ECeWvaZMeA/FlfXQgRkV2o
 4E+3PdlPIR7DoCeCrwqWfH1G9tYpLg3UJiAt+7CeWXxl60+wvbQ2PaqFUqZioqRkAc
 +hpZRHAVwKNN8T6JnFQfn0H+PaSv8v2yOtF01rM239KmYZX64WadkAwv9BA1gAuSb+
 vNvI5Pm00/fjoumEYhVUVNgQMtFmMmWTnIofK7XOdWd5v7MRd6vRh5W6RAfn4UXwFQ
 +N4J03TObtp7Is07m+42sJT0ZCbRr/2ej5wpG9rgyquOC4X50JUY9TLmNwoIEyXwvL
 dHClkMdo0fBoA==
Date: Mon, 10 Jan 2022 08:03:09 -0800
From: Keith Busch <kbusch@kernel.org>
To: Zheng Wu <wu.zheng@intel.com>
Cc: linux-nvme@lists.infradead.org, Ye Jinhe <jinhe.ye@intel.com>
Subject: Re: [PATCH] nvme: fix possible initialization failure for
 P4500/P4600 SSDs
Message-ID: <20220110160309.GA3226660@dhcp-10-100-145-180.wdc.com>
References: <1624316821-21154-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624316821-21154-1-git-send-email-wu.zheng@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220110_080314_483109_E93A7FB5 
X-CRM114-Status: GOOD (  13.71  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 21, 2021 at 07:07:01PM -0400, Zheng Wu wrote:
> From: Wu Zheng <wu.zheng@intel.com>
> 
> Subnqn isn't supported in P4500/P4600 SSDs.
> It's a fixed unavailable value in each P4500/P4600 SSD.
> 
> Multiple SSDs need to return the different subnqn when SSDs are initialization.
> To P4500/P4600 SSDs, in nvme_init_subnqn, id->subnqn is not null and
> it's from P4500/P4600. However, multiple P4500/P4600 SSDs return the same subnqn.
> It causes the possible initialization failure.
> 
> To fix this, the flag of NVME_QUIRK_IGNORE_DEV_SUBNQN need to be added to
> driver_data of P4500/P4600 for nvme_id_table.
> 
> Signed-off-by: Zheng Wu <wu.zheng@intel.com>
> Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>

Looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>

