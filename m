Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3389DC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5L2XLcaOaNS9j8FXIQm08bzTygnbxe+iXT7ihnuCW+Y=; b=KG5ygEunXI7UcbRTCeA3rK053s
	tsK/FBZ0ABjrVPUQBrDDbq+naQgaAxqYbVVRCagrszPg3LDfx/NqXUu1jmhi1wTRNHHeIlDQ1XEzh
	wGjkVPz6arrHo+2+JWc83hT+DwD7GWNQK7amqkwOyGbRBy2R2gf2WzD/7RVYXLAZQ1QAJsQQcwAF6
	N9UKrDEs48dnpadmwxE99FCdBjJ97f+NovKeV5PKlbuAZD+FO5+gci0VC80m4NZOkQ0Lgco4u+HHx
	s8CyH7jYC3wNWL43zje2h6/n9vx2pIJEdiyL9sHNR5GRs2cyCcep7pwUCXutwxXB7rXt9+93Yf6EH
	Ia9E9K/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMWIt-00000007jwl-37qW;
	Wed, 26 Jun 2024 17:19:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMWIr-00000007jwJ-02My
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 17:19:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 14F4961A2D;
	Wed, 26 Jun 2024 17:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB5FC116B1;
	Wed, 26 Jun 2024 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719422367;
	bh=5L2XLcaOaNS9j8FXIQm08bzTygnbxe+iXT7ihnuCW+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQZdRhK5VmyWJ4PxyO3UC796RprehCtodGm+ubsb0pU4pzwMADIxaki4x1BdyWSkw
	 lSP4sVEi90FtBcSO3TWjgi3c/YpsAo6kQIXDYYl3A7VRqvl/zzoUASF0PQ/ch4Uykx
	 swDlKJ7UInDd0a14EAtRkaykEkscy6CfYzCYtbF2uX/xgGivJUGSA9/Ay0UDMTfGPx
	 IEj+XHuUNOVP+51DwhvLKKLvnmdSvyUDd97AHQndG0+07csWmXCCVdkt3sNiAwda9M
	 pfdGuvGJ4dSpFvBGY9KfiW8dtQfCvSaSJH7tWK3PW8QBPwfKd5ODkUZCsZaq8hDELl
	 RaF9a5YxYOyYg==
Date: Wed, 26 Jun 2024 11:19:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Remove __counted_by from
 nvmet_fc_tgt_queue.fod[]
Message-ID: <ZnxNnFxTQCcPWhQM@kbusch-mbp.dhcp.thefacebook.com>
References: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
 <20240626170605.GA66745@fedora-macbook-air-m2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626170605.GA66745@fedora-macbook-air-m2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_101929_144237_85777B33 
X-CRM114-Status: UNSURE (   9.64  )
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

On Wed, Jun 26, 2024 at 10:06:05AM -0700, Nathan Chancellor wrote:
> Ping? This is still relevant and I don't think this is a compiler bug
> that would justify withholding this change.

Sorry, I misunderstood the discussion to "wait" on this. Queued up in
nvme-6.10 now.

