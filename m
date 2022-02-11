Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77994C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 06:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mIhB8UNxdTZinwWJSzuc3lzOHI2eL3UpSdF4CpL6P00=; b=zpGcHVrtExCFDepeLwHtxHfQII
	P8zl8slTvt79TVF69WA+C0lJ3ySAOsMazZX209t1NvN8HaQ7zgHn8MQZOpzudvXljJkZ/aukyjgPw
	bf6rcTuig9/B/3U6iWgdYwDeUIXhYdPJT1YENiqY+YxxYmLEqTXB2nqfi3XIDKfrCf6Fic3j1R5UP
	MQQpYBHe2vVHvhSvFKzBtbAPn/dOt2+QUaZyKq9JGy0hpfaTw2XcZifbabC5Q8wfA8QDWW0iGOD87
	Psnv3F3RcfGoAHOpFBgJkZP0L1UfkwVFZ7Nv+0XW5c0wpeQHa7uZNRN+8PBpZSgy8TqlkssQ343gY
	+1wBRwVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIPKN-005yhR-O2; Fri, 11 Feb 2022 06:22:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nIPKN-005yhB-49; Fri, 11 Feb 2022 06:22:43 +0000
Date: Thu, 10 Feb 2022 22:22:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <YgYAs7R/1G2Y2kpz@infradead.org>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
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

On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power
> to nvme device is removed during suspend-resume process. This
> is done to avoid the failure dring resume.

You need to sort this out in the PCI and PM layers.  The broken platform
will also affect all other PCIe drivers and not just nvme.

