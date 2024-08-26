Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85FC5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTEPxaJJZFDw/48Zsli3J3EGomp33lIG/dT8S5eUrAY=; b=NBjJil8BKWdZh1K74tTbnc12zh
	IrkJUQeJA7lLStqn5Rd1T8zkuI4/ogNaJKJdj5gvFQQi3iJVIF4/lSzceufZiL4ggu1B7+Z4lCowH
	TqWaTSOtSJthX/XfcWh6WcvgY5hMJPWAvtAYM3NsJjCMzwqAPXUrf9vkpg54E+a64tt0PlhPegx7i
	+tSr3ELGxf2T326LIVOMKKyPGsW+gSW2lUr271WuOo9+W8qlhIiacnThZAn+nxtq/szrwflmItzWF
	TSGpFQAdXQ+R7QMnXB8rHf8PRk4O6O7dDCJ4q/ASrDIqx6h/STKxD32xIUnfwLYWIsEim3csjMyYS
	wHGuRxbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWLe-00000006lRl-3j34;
	Mon, 26 Aug 2024 09:49:18 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWAI-00000006hhZ-1lNU
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 09:37:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 46E57A42014;
	Mon, 26 Aug 2024 09:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7576C567DC;
	Mon, 26 Aug 2024 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724664450;
	bh=hQekKLlWLxR/3+hCFoveKHq6YsrTTnNv1faJ2Qx0eBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7aLXbDeG2Qw/CpeWb0L0Db2JHRi/uMAJPJZBScQTygqdhSvZzw9bz2/LvB0zXkHw
	 qy/uU2A9U+1Xjxu1gr6YIt/awzDQK5SOcyVPq7oIJRhP/DsJXwNI1qqxRyrDGaXisv
	 sDsfZg6+IPLGqDLoBpkpELf5YI0F5ZJ2SUggagOlWTcsDS6l1iVlcrghWoe51gseNN
	 0kbqSe2HFUt5QkL022YuWFCRkJoc8BjT0HGC0qJl9CyxeGw0Hb6e04ByP0jBuc8pVJ
	 KFflQ+KjFlXeOBkrI7LqkeEpGsYVKtehJptx3e17Tn/MAmMn5cUJTA9PDDzfFVlJAo
	 +u8/9iEbZ3Nvg==
Date: Mon, 26 Aug 2024 11:27:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: kamaljit.singh1@wdc.com, dlemoal@kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private
 Data
Message-ID: <ZsxKfZCxfNfSXzGI@ryzen.lan>
References: <20240815201131.1439811-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815201131.1439811-2-cassel@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_023734_690469_CC6C9903 
X-CRM114-Status: GOOD (  18.30  )
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

On Thu, Aug 15, 2024 at 10:11:31PM +0200, Niklas Cassel wrote:
> When sending a RDMA_CM_REQUEST, the NVMe RDMA Transport Specification
> allows you to populate the cntlid field in the RDMA_CM_REQUEST Private
> Data.
> 
> The cntlid is returned by the target on completion of the first
> RDMA_CM_REQUEST command (which creates the admin queue).
> 
> The cntlid field can then be populated by the host when the I/O queues
> are created (using additional RDMA_CM_REQUEST commands), such that the
> target can perform extra validation for additional RDMA_CM_REQUEST
> commands.
> 
> This additional error code and error message is also added, such that
> nvme_rdma_cm_msg() will display the proper error message if the target
> fails the RDMA_CM_REQUEST command because of this extra validation.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/nvme/host/rdma.c  | 2 ++
>  include/linux/nvme-rdma.h | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Hello NVMe maintainers,

is there any chance of getting this picked up?

Have a nice day!

Kind regards,
Niklas

