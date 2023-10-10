Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD1DCD8CA6
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2JoMUeBo9R3uEVeldRRKiIvENq4+4jmJ+hJWK4efVQQ=; b=dWOz/cwagHREeP2WROUEVAZF1I
	dSltOBonWcHJzcJU8tNorzJE0UiWP9NdNpbq3rK00eVgkfVC/nOdBLIGxuAEfayEEhkddXuH5Rhbl
	XPygG7feheTL0143AIkhgrtoFheSjFEZiwqp+3jkOBGqu307zKGzcFhVnn2Vt0wqNvs1OOkRt7JHa
	IebvbHnkOuradZUn/ELlP1fsifpSrwyWsuGGV9JLbIejy+38652TBhckSXu73CaRInuscgqL8pseU
	ft9EFb8n8gYJoywqAZ1oEtPp6tgAqhbFvbNA3nXDCPLZy2ufdL4RPqYdtM9yxOK/W9cTqVxsfXQqU
	U9Vw5Gxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqEHC-00DdnP-1c;
	Tue, 10 Oct 2023 15:04:02 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqEH8-00DdmO-0R
	for linux-nvme@lists.infradead.org;
	Tue, 10 Oct 2023 15:04:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 2123AB81C3D;
	Tue, 10 Oct 2023 15:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DE3C433C7;
	Tue, 10 Oct 2023 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696950235;
	bh=2JoMUeBo9R3uEVeldRRKiIvENq4+4jmJ+hJWK4efVQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbqmvT5HIElu6ix+1mlaoOoyVtE3XyuaBWrXj3gd4axTgNxKF5NnpDWO/y4nGC/Ae
	 r0Qgci4GdD+9xWrD/q5oF3MRfBJZhyO+RMCWl5rQHyMkgpGqtvx8WdEVHEAEphNimT
	 RhHP9Y6uBHp0PPg+nlyOhD4+ZCWNlBTsZeLY3UvEvGvPJdcTSAOvuLUCL0uZlnHwja
	 Xu0swG24soI3AebdmqHjGUsI6j5D6PTqdmBdFD7abu0eSCNsNB1e9GTriT4Itvw3W6
	 UjqjK7R0/Qd99VguTO+xIksP8FbL674TJJ+yhNNF8RpnnILQYtx5Zx9vYq9ud2xTCE
	 rJRiVSPAJuhHQ==
Date: Tue, 10 Oct 2023 09:03:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: mwilck@suse.com, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"George, Martin" <Martin.George@netapp.com>,
	"Kumar, Arun" <Arun.C@netapp.com>
Subject: Re: [PATCH] nvme-auth: use chap->s2 to indicate bidirectional
 authentication
Message-ID: <ZSVn2PD5ltWaSK7F@kbusch-mbp.dhcp.thefacebook.com>
References: <20230904152638.28311-1-mwilck@suse.com>
 <fklwtncxj2gmcbz6tfrltgop6opkgj6duzagbgelx4ivznk3vm@ygxf3ljbrjdn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fklwtncxj2gmcbz6tfrltgop6opkgj6duzagbgelx4ivznk3vm@ygxf3ljbrjdn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_080358_329514_62D7EE50 
X-CRM114-Status: UNSURE (   7.64  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 10, 2023 at 02:19:12PM +0200, Daniel Wagner wrote:
> Any chance to get this applied?

Applied for nvme-6.6 now, thank you for the ping!

