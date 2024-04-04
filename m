Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6358FCD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GQkSAbKYkASvrxuuH6uPoqVFdJEyi4OjEVx0JJOZTk=; b=MHgkLcChhzPngHxfWJ0c6LBnXu
	XFAd+kKRgdUpYEJGdDSVMdP06CZtQFqCtuSbxVSy1Yq+dv0uU2U0/hxDM0PsWa/mqsaJmDtaRrDAh
	Twg+LrWerXF3S7lNPB31er7cdThb4Zjvv+JwJBwhtCMacTu18BYnECo0LNnS4T0WPvbbEeL791HCy
	0MUVJnsVHLlXGA4qfKVbXzd5Ew1USG9VCOEpe6I19+AU/e4L86hzS4iACOjocLU3fyimUIdB1jPN8
	bw4q3Mwk2fcDLFiWBPD53C7DzDaSA79ORhecFCySBzt7gxwBB+Ho7JRBoj56VO2CGThhqQK3lAauQ
	KLOR5AwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPT0-00000003Lt1-3XKS;
	Thu, 04 Apr 2024 15:57:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPSx-00000003LsK-40Fn
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 15:57:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 19C6261644;
	Thu,  4 Apr 2024 15:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B39CC433F1;
	Thu,  4 Apr 2024 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246246;
	bh=iW9MM1LvgGJibefScguGSjJ52qiSh4BE7XUHOu3GLig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA16JkkMHVhzKcoED7ovfb7RxL1kCK9GfwNtR9kiE6zzbN/T67Wzo0r/tuvresa52
	 D/kFtgkvjjunnEo85FTMb+2C+eOnLea0eZFQV6I1Hv2AFRpc9WNHVBh44a3tRUt2dm
	 xPjvTCXwUdtgq7abT1+/oYjU5mA0Omg+TpwqSz7hNUJZyXquP6teL1/7ClHQSGt7nj
	 A0EQZ5snWwja3Fl/u4eO0H3WnsiVY9l/mL4s4hqCS/XujtYxoBZRJNzs9xxEvFvzoh
	 YCa/58FDKUckrltBUTi9rOUj/zrYzTAMZVYYEIhDnGBLAzGGfGAvMUn1S8ZYggNYeO
	 UMe2rrIYsmEcg==
Date: Thu, 4 Apr 2024 09:57:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme(t)-fc: couple of fixes/cleanups
Message-ID: <Zg7N43asYRbIwLxb@kbusch-mbp.dhcp.thefacebook.com>
References: <20240404144131.17988-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404144131.17988-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_085728_058544_782B7D7C 
X-CRM114-Status: GOOD (  10.33  )
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

On Thu, Apr 04, 2024 at 04:41:29PM +0200, Daniel Wagner wrote:
> Both patches are just a rebased to the current nvme-6.9 head.
> 
> Daniel Wagner (2):
>   nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
>   nvme-fc: rename free_ctrl callback to match name pattern

Thanks, applied to nvme-6.9.

