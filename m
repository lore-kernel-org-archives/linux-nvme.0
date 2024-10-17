Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122DCD3C52B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cyglie1ub5+la/O+eAcm2N9w1Zclf5lTvBcqE58H2Ig=; b=v73D7JgpFQJ8tITKbNy4pzLDn/
	ZZc+TPefjHmNQQcldZbFOnnVPFvdImbfobVkKpviATdWPjFrAa/8D8GBCTSjyI8T80uhaxl5IwsvY
	wVDLV4HBuBf0m03crW3GBElIA8Z3GTo3UrJn6jozGMDVnYKPXQuu1ggGo6CVsu1i4nezoA+Fkk0Ud
	D0Xi/eshYkzCSU2Kcj7bMah2Bd4Aqa0vJAv2Mk+FQ3y+9uvwkDdX2LZIS3m+NPFMRR5nTnFJd39iQ
	pfKIiNebYvOiye+UFLHpsJcCmPOLJkiQ6VGBFXGzCsQZgYzsMfh8Gsm0EVm0t4eJ+30awAWELenFt
	L0qneo1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UvV-0000000FpB6-1Vn0;
	Thu, 17 Oct 2024 18:08:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UvT-0000000FpAK-0mW4
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 18:08:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3AB485C55A1;
	Thu, 17 Oct 2024 18:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00FFC4CEC3;
	Thu, 17 Oct 2024 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188522;
	bh=cyglie1ub5+la/O+eAcm2N9w1Zclf5lTvBcqE58H2Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMJY4/8nwj+/cgGGSPriypzIhWSeocM5wjPfUNKV37IV7titVQEs4dx9kvmnoly1E
	 xOZSwLWnKNO6ZteDCAev47j/wM7jZKH+YSDcun3cWAMebDG085K4rKdSrcsAdA4OTw
	 FcNDEj63LrTYh69Lz3Ue2K7hVfwuuglv6Ez2TAC+TcWtO4+Xu9TxoV6n3a7Lm6oU9/
	 JkheW9k8BXdczQhmHKY9X5TVr+PZdCLQyNPMhCQIpNyO/MFfJcSpXzeYc8vHRyR9Sr
	 mY+BGDASWVH1nz7EqFFQ/XNaX1FlkkjKonHaVuVm9BTsV4zLATBbFAmOUcOiVz/v47
	 oNKDzwXPfivZg==
Date: Thu, 17 Oct 2024 12:08:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: fix race condition between reset and
 nvme_dev_disable()
Message-ID: <ZxFSp1zDpi7UmLx7@kbusch-mbp.dhcp.thefacebook.com>
References: <20241015112100.824193-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015112100.824193-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_110843_287555_ACC26CBC 
X-CRM114-Status: UNSURE (   6.80  )
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

On Tue, Oct 15, 2024 at 01:21:00PM +0200, Maurizio Lombardi wrote:
> nvme_dev_disable() modifies the dev->online_queues field, therefore
> nvme_pci_update_nr_queues() should avoid racing against it, otherwise
> we could end up passing invalid values to blk_mq_update_nr_hw_queues().

Thanks, applied to nvme-6.12.

