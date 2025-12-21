Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4DFE66886
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 23:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iyLpVsiA8ORSOe0sQppKrZn+L7O20ZMfPMTxTtlpZKI=; b=nuzB6UIm3atNk5ag/YS8yII+qY
	qys3iIaLuG2UoQvUP7yO5uDR5tNBM9pO2JG5uOK6kbSnw911rDenwuz8uyKjpVkNephc4mRxgzXVe
	MznIpZTbjh1MqACEVvkYSChgowmlr4Hr7DZKjjY4uz+KQnMOu7Rc+L5NsTveIxPtfuJJavqMStlMi
	nQsGt0KQ7AVIiE/KaN9LGhsGEBiAiyWkXSD+XpMUdNcxYERmsnnEzjp2enm/U0UdivGRlaqiX4A8g
	IW4nCnnKqH4NhllSvfUtIwYgTbzyLwD0L1pEo32rtyEuOvgsNwwN++FCGsixu8pIwr9jLSpKE7qBs
	SealeDKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXSg1-0000000CrC6-3Hjr;
	Sun, 21 Dec 2025 23:17:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXSfz-0000000CrBx-43zP
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 23:17:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 772E8600C3;
	Sun, 21 Dec 2025 23:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8794DC4CEFB;
	Sun, 21 Dec 2025 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766359041;
	bh=iyLpVsiA8ORSOe0sQppKrZn+L7O20ZMfPMTxTtlpZKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1gvv86ktTBvn942fUjwHDB3KbNVedHydJlz6r+8aCGit7JP20j2FnCmEw6DpohFH
	 iMqrURAKlPP/A+QeD+k4P/UsSVr4onBr9SvYNC9nkkB6x3nssfDQiOo3w1uPhC5dag
	 2jNnZyMRnXQ6Dq4c7Xl4FAmLSgQwJ9v/Np/OHPWrB26c/xauGiW4uZu+5bXxFd4DYv
	 JxPsgWq7yXh/jlr88o2FW3Vgsl4fdHHYKYf+oAy1h17XpTYMftUTjz/yIqCHEnCNzF
	 SI/v6pb929TSk9CeTSZFRVb/nvXJ5b2ZUsUZnc2YwIzilAMp9adVdJ9AxslibaTXOX
	 RR+fwMQEKEARA==
Date: Mon, 22 Dec 2025 07:17:15 +0800
From: Keith Busch <kbusch@kernel.org>
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
Message-ID: <aUh_--eKRKYOHzLz@kbusch-mbp>
References: <20251221132402.27293-1-vitalifster@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221132402.27293-1-vitalifster@gmail.com>
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

On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> It contradicts NVMe specification where alignment is only required when atomic
> write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes

Commit header is missing the "fs:" prefix, and the commit log should
wrap at 72 characters.

On the techincal side, this is a generic function used by multiple
protocols, so you can't just appeal to NVMe to justify removing the
checks.

NVMe still has atomic boundaries where straddling it fails to be an
atomic operation. Instead of removing the checks, you'd have to replace
it with a more costly operation if you really want to support more
arbitrary write lengths and offsets. And if you do manage to remove the
power of two requirement, then the queue limit for nvme's
atomic_write_hw_unit_max isn't correct anymore.

