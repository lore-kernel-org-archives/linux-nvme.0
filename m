Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5984CCF9E3
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2yCuAw/ZwN04njjgiJMxe6gSfnTfu8oqu2do18znpXo=; b=yfGW64GV04QDEyz9uAXDlySe5a
	Ixs6PkgR64crRuFE00Vgv2Jg6GfgZSwaADKwkFgLNQWlNbbA/CH0GFqs3z3iM2fjWAohKx16Pi05T
	/+dNmg6pK8ukdiYAB0ZQGUidD0fHrBLuPjJyeR/HbCDn58rNYtoKxS2xAyI+mIbVRtlKwKA+XpcGe
	Q7yJQQQM57yDYqhYMsA2D4+9JbmLJOB/uvgiio1vcRWkPRGkmNi6plenjjlVsLPPK+zprSFWZ8u4r
	jb0vKvZ/HWejlCmNTfvYlbH3Ig2TtVxmh33DlnZ0YneS2lm3BFh+sftgmXmJHTr4WNwrT2z4cFJJt
	M2c2P7pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEaRT-00000004ww3-1lDw;
	Thu, 30 Oct 2025 21:44:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEaRP-00000004wvi-1Yrk
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 21:44:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 839BE60306;
	Thu, 30 Oct 2025 21:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49DAC4CEF1;
	Thu, 30 Oct 2025 21:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761860658;
	bh=XSGGtCutJQgfXLVeOpND5f2BW8ou/h+v9Q9XCI+psPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5GZizP3k2xcfbCN0f3PXGjxbVjtF9alIG9R3YfXS08AkVls74hJ4NJzlWNyux+w/
	 AzW0dyNDN8Errr2YkFsl/1bTQBSabZL/DSMUIKBZQfEMGDeEdJA4lRynF/D7iLhVVw
	 PP4LeX2zb/BNaT/GyrPjb5agnq5hN40gqVanli6aXOkZHNZ2C1n4WzYJiy5OHomWcl
	 dVWN3h1hmoEokD13Cqo7op8ldeG6rFndCyid3Q8a8n3zUFvcZwHKM3Fi19/6oOnTf2
	 721wZDsAKWo181AlwCnXQnUjDic52MpY+FgDik8aqpA3qWdR8Uy+uUswP7M3k+o20I
	 aNn5GgfX/5Blg==
Date: Thu, 30 Oct 2025 15:44:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nvme-fc: misc small improvents
Message-ID: <aQPcMGH4FtqzWlhw@kbusch-mbp>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
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

On Thu, Oct 30, 2025 at 11:05:44AM +0100, Daniel Wagner wrote:
> Updated the first patch to use the safe iterator variant as suggested by Justin.
> 
> orig cover text:
> 
> I've collected a bunch of patches from the last debugging session. I think it's
> worth documenting which conditions are expected in the cleanup path by adding a
> bunch of WARNs.
> 
> Also found a deadlock in the nvme-fc code, so this one should definitly go in.

Thanks applied to nvme-6.19.

