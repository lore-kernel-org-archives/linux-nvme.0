Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC90CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=E7rcl4Za7jiprM8yAo5h2IX7ex
	1q+1ox5rEM1v/cV0IzXFeu4peunHz1j7/qKw3G1d0nrhDL/ikETI7IwPU43UCdhYPeek/sqQ1lDA/
	NxCbyxN6xJbuqXvnaf8qBa6EnHo1HunxmAeRQUwJVqvZ3H2npjKRcsaxOS9vhVDPv93a2JQGeHE9a
	wo9BNVd5FgO4LCzmpFRFv3sdgyGYrAEb+Ib0rynFeOpCSNi8aJOJK6LxWCANKb/F7vFt1ptNNe+PO
	jS0cXG23TphDxtsL5P8Acj9y92FgI+DwVzUk+QAbMycOCZnV891uOIh+t7Sy6+fW5AyS5b8bYIMTb
	/y4qCJog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKFJO-005zzl-DZ; Wed, 16 Feb 2022 08:05:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKFJK-005zyQ-0m
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 08:05:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3C55F68B05; Wed, 16 Feb 2022 09:05:10 +0100 (CET)
Date: Wed, 16 Feb 2022 09:05:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] nvme: explicitly set non-error for directives
Message-ID: <20220216080509.GA10694@lst.de>
References: <20220215150308.1902842-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215150308.1902842-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_000514_217333_11E186D0 
X-CRM114-Status: UNSURE (   7.75  )
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

