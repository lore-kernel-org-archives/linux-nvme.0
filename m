Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C2CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 03:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VnM3oPGfNLmqDx/ooErb/jp6wOxGXgzqkHhgjj9Q/5E=; b=nXYpXJPeFBGW2MavwfWa4kAynH
	LLhSjeTeUfTe/oRzptQbHsOIwd+xJCFxNLRqs3Up8yRrEyj4r4SoKisPWbHNYU1EyZXfmQBOw47pI
	x5HF8be8DFeaCscm6S4B0kY4DCNx8ZC6ZuhqwSOUksQ1boYirsP4fqFj4OibNAml8WZJO0qtJAPWM
	RDwNxNxUWZFJK+5NCBsT1ti9kcEPdhck+2Xl1E8YGF2bLNIP7RbTqvsdRw/0v7jpHV4D1EASc3rqV
	0vqX/V4vj0smLA53IOdsG5xpBxSxaEo61VFn8BlohJmbtsrkkZTxBggAqeRNrPH3w7Ae16evMc+CC
	NDYNmBEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJovq-00072H-3f; Tue, 15 Feb 2022 03:55:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJovn-00071W-6i
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 03:55:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 125DD60EEB;
 Tue, 15 Feb 2022 03:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37CBC340EC;
 Tue, 15 Feb 2022 03:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644897309;
 bh=BvxNL/RFVc1uJpXylwAbdhKDQPT/RCenbb87HvmLBmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ssu1nFuwAUbwi6N5yX3DvmCSE0r4PGCXtzxdwRRvbiHRiDyCoRPh9np8ZSvqeZQLB
 y/Ape3MErHrvX+nLd++MVT7V+rYfaph5uAthilu1KLw8YzJLWp6wTVw0RSPmoovh0w
 bf3TUn+YCpiB7y5abjyiSwcl7iIUeTiM4dTscsjK2xmJfdMumFGC/WN+kAVV+MAMtC
 oZtHRdVCOrWXNfvyeYeXO3w6+EZRYL51bf+Mrmp6Gx0YEMJ7zdZwotIDim6dsNaYIn
 gz6+aO7khOPw4UAQQieYPzwq5iIc1BaSWO055zyPLnaTkWNktsEJt4Wm5ytP3NPE8X
 7xIYiPH/ZA4Qw==
Date: Mon, 14 Feb 2022 19:55:06 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20220215035506.GA1663897@dhcp-10-100-145-180.wdc.com>
References: <20220215033632.104124-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215033632.104124-1-jiapeng.chong@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_195511_329334_BE9FFD16 
X-CRM114-Status: GOOD (  12.27  )
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

On Tue, Feb 15, 2022 at 11:36:32AM +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/nvme/host/core.c:780 nvme_configure_directives() warn: missing
> error code 'ret'.

Nak, the code is correct as-is, just like it was the previous time you
posted this patch:

  http://lists.infradead.org/pipermail/linux-nvme/2021-September/027339.html

