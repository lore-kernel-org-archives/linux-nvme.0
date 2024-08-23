Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F19C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xet+aDXcxhCJo1zJfnECj885UXwiik8EZ+iR72SJUrA=; b=RzQRnAUXwB9dbKWDn+XvWfiHdK
	5t+k3swMMf1PYCmfPSqMqvEpATpiBMShCy0FwZ12j+hhcie2nRfGop/8+YyVkK/Zav7rH0ac9sVTF
	ODEtxbuyrd1v0YS2WbvKmIrg88RSA06GfWvUZlIwOpSLiR5N/TqWq4tE6TCyW3XfLZ+xWIdecPwMd
	ZB2pF269gmZaRI8ObAznX1M7kMRjzTd6//oK9YpQ7d1dDcsK8qmhaH1rWbTLugr3hQsS/gQxePFOk
	ZEQgbOZyX1SjXQGVI5vlCWgDGOfAs8uuXnhTEd88jr6VmJX1TBSw125tJpCB+jm3zjdUQ3WwlFbtA
	eZPkRgtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shXZY-000000002gI-1y9A;
	Fri, 23 Aug 2024 16:55:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shXYm-000000002QF-3eVl
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 16:54:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 28B89608C0;
	Fri, 23 Aug 2024 16:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B2C32786;
	Fri, 23 Aug 2024 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432087;
	bh=n9VpSAGA9V2fepelu0lGtZ5GVNOMysEMYA/hBvgL38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+LNrFFbwczkVfRHdxugB8DCFkfd9B659qcuK1wIsWFU+I0k5T5Ie0a0fV75AoDsK
	 LAxP0YCkusRhpzsJhmNYVtUbidgN10CU2OINePEovvujwnZ4W8aPxF8Sz2S0eLsR5L
	 7T3OjWaYPnrzNkmoBYOiTHcozyNb/wxRI32ruae0fIPoH3gBvgBZvAcYJrD9c1z1CP
	 imUmwR3yK/QPJqfFf/vBkDX2Dc0KC8eal7UhKhIqr3c2CcenUxgFrTNlV69meWN8oA
	 dTr0HISaqhSW71TvKCvzhCNSXxxslH2rWf7dcxXVqJT3rxj/edxVBkyRW3xK6ECsGu
	 iym5EX0YVG8kA==
Date: Fri, 23 Aug 2024 10:54:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 0/4] shut down devices asynchronously
Message-ID: <Zsi-1H1w5VY5I4Ea@kbusch-mbp.dhcp.thefacebook.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_095449_026230_90E13D80 
X-CRM114-Status: GOOD (  11.65  )
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

On Thu, Aug 22, 2024 at 03:28:01PM -0500, Stuart Hayes wrote:
> This adds the ability for the kernel to shutdown devices asynchronously.
> 
> Only devices with drivers that enable it are shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

Still looks good. For the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by: Keith Busch <kbusch@kernel.org>

