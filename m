Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:30:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1895D64E31
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1895D64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VIFKH6QKaJnwqOEhaTlLE6e/CVqA8mydSvwX5ABZIs4=; b=pDBG7qeQe6Md1edL5ZEje7gdu
	5qG7mm2OyooCyLZs2YwdNhGn4ySLUHe1hYHot+yeHNuLXNaQsW3PkVIKP+oEwayfHH9X5hMYJ5eUd
	JAqHza8XTGTIuT5nKaeuC+ZYBspmHrpnI6SJZyqiBTMBIc5dD2bD+yjU1nO6Q1LMzrWVMe/8eiUhP
	wj7a5B3jvm/A1N7VBrE2bNtEqkAjA1A+eVWPYDa7y2gtnbmZdBUMJCcEPY3KGgjYNYZFgzlVh0bmQ
	9uPbhH0OmpRwtxSAJkspfICR8YoxfMvYUsZPNHS63BCsIVWq2bQeh9Cw3aLR4N2fw85du8cOxTDSV
	t8Ecyxlhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEGuH-0001cc-4G; Mon, 22 Feb 2021 19:30:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEGuF-0001c6-Bl
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 19:30:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D31764E12;
 Mon, 22 Feb 2021 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614022205;
 bh=KJ9uctTGhxr8OX1F4YPK/lOw2Xb+NiXz66tV6gvfsu8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HrEvdlPO9suuRnimdiSzk5aQYEsi2dnXwsbnQqkd8GNgoyNBwA5AzRmmAkfojnYkd
 xbuLgW97yM6F1kYGFjZpMdkKnJNsPGh20/7SWg5ak/rsB8Pi8D6gXvXMo9+D60vkaX
 BuyZ4yIfZ6WHPAMpV1Cixv/LAUN3MYCqGp+fjIt7hyPGbF/Rf6qhfIpkC8HKY03msG
 Z/fBCyBtGOj03PqMZnthKT3KhTHlDLZjKc4hcmPmB/ccWtm9lYu2kr4W9mlwWjPcUg
 aADYy8l8dHUbszRp9DXX5UB+WLp8KINdzrEPm+4G9sigTlwz+5773B+gEbBfbM0Hun
 GfQZX3qfsSfUQ==
Date: Tue, 23 Feb 2021 04:29:59 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] nvme-core: Switch to using the new API kobj_to_dev()
Message-ID: <20210222192959.GA16253@redsun51.ssa.fujisawa.hgst.com>
References: <1613812218-17601-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1613812218-17601-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_143007_496500_6BB93B1B 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Feb 20, 2021 at 05:10:18PM +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./drivers/nvme/host/core.c:3440:60-61: WARNING opportunity for
> kobj_to_dev()
> ./drivers/nvme/host/core.c:3679:60-61: WARNING opportunity for
> kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This was rejected the last time it posted 6 months ago:

http://lists.infradead.org/pipermail/linux-nvme/2020-September/019463.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
