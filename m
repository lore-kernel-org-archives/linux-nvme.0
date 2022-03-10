Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D789C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+jfhhcwNzBjWBULyui82hDKEbdRGdVZ+VqcyMFQrGg=; b=0EHpzJep4hoM2SGBsxxkXRhD6l
	ii3RWeZq4EEMXRA9oRP+Gbz2dZ1CasweJvp6JV0JP5I5F/msiav3WVg1rPfBj2dWC4FntFGkvhtS2
	xhpcpvg8EJyl8NMqXsbOzKa4NQ/B8q6IOH3+Db3Mcs9ZSvyQlIbYVL3161cUSd2DzqS1ISH0ZHLWo
	835VAxEPcNGvwtKg9O+a4z/Yvvt9d46gqjWsgVKBDvACdpRQ1miP8htdFqcvSEA1M/vWZR1qgXglS
	CTItp/+IecHTelTJS12yHmeM/xDD3rhjrhWDxWfT/cSCmRmtSXCAKgDVbFopWnn0AaMN/Xy1EzkAA
	HutyxYbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSCRs-00BbzO-N9; Thu, 10 Mar 2022 06:38:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSCRn-00BbxQ-W8
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 06:38:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A4E0D68AFE; Thu, 10 Mar 2022 07:38:46 +0100 (CET)
Date: Thu, 10 Mar 2022 07:38:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niels Dossche <dossche.niels@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] nvmet: add missing locks around nvmet_ns_revalidate
Message-ID: <20220310063846.GA24359@lst.de>
References: <20220310012511.82536-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310012511.82536-1-dossche.niels@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_223852_231154_680DA026 
X-CRM114-Status: GOOD (  10.84  )
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

On Thu, Mar 10, 2022 at 02:25:11AM +0100, Niels Dossche wrote:
> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
> held. The only caller of nvmet_ns_changed which does not acquire that
> lock is nvmet_ns_revalidate.

So acquire it in nvmet_ns_revalidate only when we actually call
nvmet_ns_changed.  Otherwise we take a subsystem-wide lock for every
Identify Namespace all.

