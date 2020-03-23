Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B4CC10F26
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 07:34:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA442070A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 07:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i8AHFiWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA442070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EZgNoVB41Sr+9tfu7oROaSPgpdkzZpoi9WJVgmCdA7A=; b=i8AHFiWurk/CYL
	qf3muEYs3+cn9vnUdFWELHphz6JBoOQaSFGjz8JXV4CKUKfx/84eosuXkn1S+E98PduGRIX25yViS
	g+a0zM66wJQ+TzYKbjTTFktSH2AHWj/jcp5yoBKjASP+9EJob+l1NYxM/MvdPeUwid7JGjmT1ciKn
	xFK2f3+UVblT+c4T6zgKE+6Ap4rXK3HUkiZJVzLnjdNy8kcTmRloEB5qWZA6qHCPreAU08zkX0Qpl
	4tl5EJpWRhD6QloEqi8Ht2Ikpa+/BMM61fhDCXYb/Sn3ZWdAxSdNDGzalGdQgH2uEXgGAb3e9cVr4
	wubd/TWkPDW3d+auK5Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGHbM-000392-UR; Mon, 23 Mar 2020 07:34:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGHbK-00038Q-98
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 07:34:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F1C9B68BEB; Mon, 23 Mar 2020 08:34:19 +0100 (CET)
Date: Mon, 23 Mar 2020 08:34:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 4/6] nvme: Fix controller creation races with teardown flow
Message-ID: <20200323073419.GC30302@lst.de>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
 <1584899989-14623-5-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1584899989-14623-5-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_003422_477543_DE54C19D 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Mar 22, 2020 at 07:59:47PM +0200, Israel Rukshin wrote:
> Calling nvme_sysfs_delete() when the controller is in the middle of
> creation may cause several bugs. If the controller is in NEW state we
> remove delete_controller file and don't delete the controller. The user
> will not be able to use nvme disconnect command on that controller again,
> although the controller may be active. Other bugs may happen if the
> controller is in the middle of create_ctrl callback and
> nvme_do_delete_ctrl() starts. For example, freeing I/O tagset at
> nvme_do_delete_ctrl() before it was allocated at create_ctrl callback.
> 
> To fix all those races don't allow the user to delete the controller
> before it was fully created.

Looks sensible.  My gut feeling is that this should be done through
the controller state machine, but I can't really see a way how that
could work:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
