Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A17C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I8nS/2fnHlbHqCMVIOjhAl0urRFal/HrtRGYfTY0mnE=; b=GbTbJ5ZM5d9O153iDaIihRbfNo
	mCBZ6ZHa1x9/VUpVVgjq0gY5tp42jSdvcJ6Ph78kbtTtORS+k0/sWi0EFPkMVxPmdTpe19KVapS6j
	B5NHPL9ap3OXo/Z8wiQTI8h8rmKhYV9x5dMiyP4w0+TbnQdzOzcPe7MpSFAA0r2gCTEUYSXYSjKat
	8o4G6yoLywkjTtrb8JlwoS9wmyDWpE4u6QH1z2zagRKSdgE+OCFEhK/fPti6O/IQW6XweSWJQzwdK
	+9o8PT0l5u6+lNvbVsTa541qkN9ciAy5yVY8Bnll+ss8RqqDat903wgQ58FJIQfbKwc3zBaW7lm+0
	bact3CHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLhm-007OlZ-IL; Wed, 16 Feb 2022 14:54:54 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nKLhm-007OlR-1v
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 14:54:54 +0000
Date: Wed, 16 Feb 2022 06:54:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: linux-nvme@lists.infradead.org
Subject: NVMe K/V value devices
Message-ID: <Yg0QPv8nH+TusRe9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Does anyone on this list have access to NVMe Key Value command set
devices?  Those would be a good test bed to check support for the
I/O Command Set Independent Identify Namespace data structure which
would allow us to support the passthrough device nodes for arbitrary
command sets.

