Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06720C2D0E5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA2F20719
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dAoW+c17";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqKJLHrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA2F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Si9tXG9TsYc0tc+YUJ6hFieMNNXRQeyNEPKzUJNTbBY=; b=dAoW+c17Z9XWQU
	UlMy3SEaLRNoboGk9Q8Q4CfnC8aW4ibgOjACfbNmSFFREg5KnwHDmNwepxsceH9/EzXtkYs0TXO9v
	7yHPGeX0A/f1OUOM9vQXEW6bUJAazfIeoE4OkVJs+/Ux9GGaLnqSuKXzqt+NxrxKzKLIRbKqniLBj
	DKDkUqFmDxrMx7ZjKvf0Ezb0/jJtCN+7VwVbKuB7rzadIRfiQaxuU8LI+3LD4+mC2slW42F0l7Vn6
	Mx6I0+GJUIAsp+XZgq3dhcKrkMh2xiCwov+7yaEl791/imTT3JREwLvH99FVXkvGXLNkeybYcNhkh
	dl8D21zL0Opcaq1iD2RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHCsS-00022V-5J; Wed, 25 Mar 2020 20:43:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHCsQ-00021v-2V
 for linux-nvme@lists.infradead.org; Wed, 25 Mar 2020 20:43:51 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E20E420719;
 Wed, 25 Mar 2020 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585169028;
 bh=T6327siDwkSjwKtOzgPrqLAlLzoOEv2d9CmcijfXG+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aqKJLHrdgND8zJ7x0P6RqLnlP29rB29a2aTwVY9TjVgg91wWiXqM6DOYSN4EpXBWt
 3NgAfNYb20cmTVrchfsW2lwKVzIR5xdVQpLTPkBYvtQZHkthbNTRXk8BapOg3ktUjh
 6KyHnpUjxlcA3ecrCjtV8bYAXZgl6JN1cLhxQaxI=
Date: Thu, 26 Mar 2020 05:43:43 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
Message-ID: <20200325204343.GB4960@redsun51.ssa.fujisawa.hgst.com>
References: <20200325002847.2140-1-nbowler@draconx.ca>
 <20200325191103.GA6495@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200325191103.GA6495@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200325_134350_141143_00AB7BFB 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 25, 2020 at 12:11:03PM -0700, Christoph Hellwig wrote:
> A couple of comments:
> 
> No need for the "." the end of the subject line.
> 
> I also think you should just talk of the nvme_user_cmd function,
> as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
> is a nvme_user_cmd64 variant that needs the same fix, can you also
> include that?

Yes, this patch should get those cases too.

I unstaged this patch for now, could you send a v2 with the suggestions?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
