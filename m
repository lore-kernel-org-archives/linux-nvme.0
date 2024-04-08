Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB693CD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkNlJ/Ze8MFhn/zTotCY479fLM4S2NHDtUACTBxlmzE=; b=jsJdTKev3bnMm5LbOz4JS8FHTa
	87gZF2wzUYg6SpM5OaB63JrIcCvulTaIC8YBamQDCLELEDWe3V8j0SosDd/GmyVbelFGEW1Q9kNs1
	XdY0Wlh+NXjf7UJKndRqw9JCY8opuJkms/4a4Xzxq+KtXBUH6/YvBW7+F0x3EpNdNk7xuQ7QMnI6z
	lShgpcAWq1Hx1lujl/Zeq+L3HiFKAPXQdvPbXb2JIbaGwSNHqlC4pGiw7k5yy2lU6fyk6yJFEwxIw
	wDNDiyroV6ilkjcvT7kmBusStvtokoA/sS6W4pmkY3qIEx+oOahXQz2T+eoxrk/bhMMPF+XzCKaiY
	y4pWd5kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtnFE-0000000FOkw-46Uf;
	Mon, 08 Apr 2024 11:33:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtnFC-0000000FOkL-0qr6
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 11:32:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E9393CE10CA;
	Mon,  8 Apr 2024 11:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA900C433C7;
	Mon,  8 Apr 2024 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712575974;
	bh=VmzuN/oIVgAfQmhDb7JLOrkVWqx+M5AEzMX8qMZn+jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5op16r0aIWq4YeJzab7IMtCXct1lZ6v5DKlVeBj/qvU5xAxltvw+KM2mqIbukp+l
	 FM15vzzw6TfFGyf3RVeiSWuPMfHx7ODgKk8yU3R+kXuCFKZEx0jYffL1AQn+mj18R2
	 bUoTaKcB1B/YCrGBuvkNWCIBHqT27+3+XcD7Knys=
Date: Mon, 8 Apr 2024 13:32:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org,
	"min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH for 5.15.y] nvme: fix miss command type check
Message-ID: <2024040844-papyrus-bronco-693b@gregkh>
References: <20240407091528.5025-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407091528.5025-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_043258_452055_490871EB 
X-CRM114-Status: GOOD (  15.01  )
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

On Sun, Apr 07, 2024 at 06:15:28PM +0900, Tokunori Ikegami wrote:
> From: "min15.li" <min15.li@samsung.com>
> 
> commit 31a5978243d24d77be4bacca56c78a0fbc43b00d upstream.
> 
> In the function nvme_passthru_end(), only the value of the command
> opcode is checked, without checking the command type (IO command or
> Admin command). When we send a Dataset Management command (The opcode
> of the Dataset Management command is the same as the Set Feature
> command), kernel thinks it is a set feature command, then sets the
> controller's keep alive interval, and calls nvme_keep_alive_work().
> 
> Signed-off-by: min15.li <min15.li@samsung.com>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> ---
>  drivers/nvme/host/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Both now queued up, thanks.

greg k-h

