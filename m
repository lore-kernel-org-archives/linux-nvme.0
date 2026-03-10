Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689DEB105B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdjY8IeXCBwpArfJcVzX3Mv+qoOF6ifaXzIScE4Op/o=; b=ZGlT3XTAg7arYE7Zlkwcqog0Td
	o15fa6/onWWcePqAMFptfFXo17/45glI6VPfngz/6MUMQlgloidPGozMMFXnHFWg3a/nS7meAwuIR
	6cY6iqDDKiYVDNhnCO/vaRJEBa3uC2xIyXvaZUJsBPmJK6VkgwCI9vgTTwtBNpfrcztcbJfIy0L9F
	Ox1szt752wo3+Q6frsIMHSIHbo8bvQOrmieXfIkZ03gB0U4GatvkUGJ6sKOZ64p8ULdADn/DJxk4h
	/z47PmLRBTmeVp99uHmH28+ClY/rJnPFP5aDE2g9rsI4teO1QYywkzn8qOeBqJzBXkg/iTvsBX/YU
	4Io1YlmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzy3k-00000009hRe-3281;
	Tue, 10 Mar 2026 14:27:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzy3j-00000009hRY-1sBy
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 14:27:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DCF88600B0;
	Tue, 10 Mar 2026 14:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FE7C19423;
	Tue, 10 Mar 2026 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773152862;
	bh=qdjY8IeXCBwpArfJcVzX3Mv+qoOF6ifaXzIScE4Op/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Avccy1c6PxXp3fk8Yy3VqXWxnPSSQMgdt6RrOJ6MoNu81cnq3r83juSa23nuoy7HA
	 hEfP/hXqGT8Mvq308DOnv1yl6Rq+dVrHz0Tr9IjY/IdHUIBTDK+hXa8yXopf4M2jRO
	 d+wGDnX/KK/ea/y+e+SvvAfZmIqmTUp608iubl4h0FI8r4T2OTHxiFpkGa3V09+BC6
	 I2a3gZ5QCEy6QiBV3VOH3qkvcnn6tTvSLzj4MR+FyNAr27WfazHkNxzdcDdO/wlpUX
	 b+cR6Y+FeubvfFXe7RROcI10YnSv5tSiEbGoQ0AYkXGF0Prl8WLKo0vhR4tssoJahs
	 IrS2/OfD9jNRA==
Date: Tue, 10 Mar 2026 08:27:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu
Subject: Re: [PATCH] nvme-core: do not pass empty queue_limits to
 blk_mq_alloc_queue()
Message-ID: <abAqXNoE_d8GU6C0@kbusch-mbp>
References: <20260220133016.524192-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220133016.524192-1-mlombard@redhat.com>
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

On Fri, Feb 20, 2026 at 02:30:16PM +0100, Maurizio Lombardi wrote:
> In nvme_alloc_admin_tag_set(), an empty queue_limits struct is
> currently allocated on the stack and passed by reference to
> blk_mq_alloc_queue().

Thanks, applied.

