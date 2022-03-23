Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000C2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=JfFtk7fJ0ITeeYpur9oNanJhx3
	60p7ItdcpV+bP1IvQp0M4ErjyZethOGquDq7plyC1ysJx8+ndsCaOWywpfVxHGJBLF2tjr6oh/0fF
	S/iCZblIdOpytgsIWRYdZ1DquqbN9dQhS8RhdXV6aAZsn9cYqXuiKuQ+E7Mmvrmnu6PoCdHS5oqmL
	TuGajugpeWTYSMtK5ojJx+Tvdssvx3Ocj3wHY4+P1zrQ606WlADlHHTrc8JvdZxGkCif0pxi0993k
	NjZZWfjV6x6MBhrn5tpFBeNf79EjC6Dkl2FIxi7cjTstkk3vsAVc4Fs3oT5lPhE0KpQYp/cQfgKLt
	5BQzJVgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWwEY-00D5Ei-7f; Wed, 23 Mar 2022 08:20:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWwEU-00D5Cd-TR
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 08:20:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4472868B05; Wed, 23 Mar 2022 09:20:39 +0100 (CET)
Date: Wed, 23 Mar 2022 09:20:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: make use_threaded_interrupts mod-param read-only
Message-ID: <20220323082039.GD26611@lst.de>
References: <20220322023512.98644-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322023512.98644-1-xhao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_012043_180169_E5B23CC0 
X-CRM114-Status: UNSURE (   8.15  )
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

Thanks,

applied to nvme-5.18.

