Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ADBC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k43md0H01WVrqeA+GwQxsoYOeq0ym5dA7fYphwjxvDg=; b=F9Q35wng/WyJPMJhnjPVD8LnlK
	8HaKPILuwJs8LQvPqVwiwBh+H2ffyCcwTMd+83FfxplbdFSEi4VmJzPkeyCSuZOeOVz7doil3GQp1
	36Wv1VQWOSpXd66Sa9Kdkjx8q4MYAB936iUTxG8H07UN1vA3+1C2G/OsATHg0Bt3h5bPoEdeZZdU6
	2b4Ud2ETSrn83Hky93r1S2O5Cn1dUPRkn7i7gC/pK+3tUkElEnm5NvDwCdpt9ZiBFUt18RxtnggUb
	ZZPyeBYDZWm8Hk29wnacsg+mA8oAKa2evfgzU8LXXTEopfZHspeUWH3rkQxB1AcFxEugnXROuyf6L
	vMO8ieaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH8Qx-00DDjQ-Us; Thu, 28 Jul 2022 18:40:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH8Qv-00DDiF-GQ
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 18:40:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A4D267373; Thu, 28 Jul 2022 20:40:23 +0200 (CEST)
Date: Thu, 28 Jul 2022 20:40:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kbusch@kernel.org
Subject: Re: [PATCH] nvme: add ctrl state machine pdf creator
Message-ID: <20220728184022.GB22439@lst.de>
References: <20220727215424.5252-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727215424.5252-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_114029_716316_24EF644C 
X-CRM114-Status: GOOD (  13.91  )
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

On Wed, Jul 27, 2022 at 02:54:24PM -0700, Chaitanya Kulkarni wrote:
> It is not always easy to read the NVMe Host controller state machine
> quickly written in C when debugging the code for various transports.
> 
> This adds a simple dot based state machine for the host controller that
> creates pdf. The resulting pdf is easier to understand and process.

So, the graph looks pretty, but I'm a little worried that having a
separate copy of the transitions somewhere out in Documentation/
just means it will become out of date very quickly.  Can we instead
come up with macros that allow to both generate the code and the
visualization?

e.g.

	switch (new_state) {
	FROM_STATE(NVME_CTRL_LIVE);
		TO_STATE(NVME_CTRL_NEW);
		TO_STATE(NVME_CTRL_RESETTING);
		TO_STATE(NVME_CTRL_CONNECTING);
		END_STATE();
	..


