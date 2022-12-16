Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CA5C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Dec 2022 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1IVi4UhXuPaZzlaZc7yMhgIAqDjU/gHg+hIXQBXKnMs=; b=gwD0dG/M+sm5h+MHJyjYc6f6/3
	A2p6ORp37DQ0+8ybI9niKVvs0Qh9JmjGaXbpUzas10hUZPRB2hv2p4KVwIrq4hWeFodYGeBohd/av
	0pUhypd19PFOmkcg7RFkNr/fHN+M9h4oUK7XMtZnuTJEpkELZcdZ7boIqYvIdxXcsl5DfBsMbB5Kz
	38DVWfM0Lo2KByggiHYbWK0je8eyLnjMKF7idMV77k8iW5XVquUOj1E8QTJDRu2tCrN5bYgTPkGBh
	CEHXtuAPk9pgz8grVmfuvaE/k8xmARsvwS3LdP3suk+7VMIy4u9OLgxIXFW6d7y2QPyeRhYEkD3Zg
	305fCWIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p64za-00DLmk-EY; Fri, 16 Dec 2022 07:18:50 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p64zY-00DLma-Km; Fri, 16 Dec 2022 07:18:48 +0000
Date: Thu, 15 Dec 2022 23:18:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nick Neumann <nick@pcpartpicker.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Consumer SSD listing namespace as nvme0c0n1 instead of nvme0n1
 in /sys/class/ ?
Message-ID: <Y5wb2Og6UMr8hRcu@infradead.org>
References: <CADqNVTrUOw1VSZLctBeeJpKYe2b1wsLOLvitqejfDDv=Q7rHbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVTrUOw1VSZLctBeeJpKYe2b1wsLOLvitqejfDDv=Q7rHbQ@mail.gmail.com>
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

On Thu, Dec 15, 2022 at 03:27:59PM -0600, Nick Neumann wrote:
> Is the way this device is presenting itself
> incorrect, or is it just an uncommon way of doing things?

Not really incorrect, but unusual and probably suboptimal.  The
multi-pathing is enabled if the device sets the bits that it might
have multiple controllers (i.e.g multiple PCIe ports) and that the
namespace is a shared namespace that could be accessed by multiple
controllers.  If this is a m.2 device and doesn't support SR-IOV
none of the above can practically happen.  But there's nothin in
the spec prohibiting it from setting these bits.  And once the bits
are set Linux uses the multi-pathing code to be prepared for the other
controller (path) to show up.

The only downside for you is that there is a bit more overhead in the
I/O path.  The overhead is not a lot and should not practically matter
for a flash based device.

