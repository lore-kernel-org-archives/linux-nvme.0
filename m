Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03391ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 04:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xydQeSta9swgFZAv+UQnKTxYs2Kj3R7Em9XI19fweg=; b=FuChyFZgAzo+NMflL2VT9JNWXL
	4DnGlc0YzxaLBECNRFQGtrtO+cRL+9GYFs58O1dFSSGGlb3y74sDN5QYlNK4sl0QkIceskoy+ZJIs
	ICrpmCgQ8yrvEY5R8pCQhji9o/dSbBH+z9B8RA7KT1BdgRx+o50o6Nox8fbt5ykcQcSzDYogodPSI
	he5E27Tc3I1nFXz2+SPECZrGg+TN+XMt9SQQn/ss7r7trBclBiMdp2qa5Z4/ENvXe89BEQ2i5kX+U
	rI8ZeBp9cb86BaDSwXDJ+CTXIfazwH2Uz5w9g/hDYq/fBb6u1DAziK/R2KdJJslT+iCK3ovXs7MbW
	oiFuuwZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQX3-008E7N-MH; Tue, 06 Sep 2022 04:49:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQX1-008Dn6-Cv
	for linux-nvme@bombadil.infradead.org; Tue, 06 Sep 2022 04:49:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3xydQeSta9swgFZAv+UQnKTxYs2Kj3R7Em9XI19fweg=; b=L/34aRVViYMG9IzIG4EBftOFDm
	gbSuM/YmDHYGSb8lVcfRbYacukeYee+VCOmsflKzDdhzHPkZ7M+cf0lL2FVBMbCNw01qlrqfiebat
	LDkpZV+Vfeid8VhI8HlRFfKlnw/74kgJTOzBRogiDbpplWdjNaWHdN+w9BFAQVgdN5RxZ2GRFO0g9
	qHCoI+D37e7+g6dVTcHtGMjVSAOiYoyjpsvp681ohUP5IuzEzaBxDnRuNceQXqHyjBLR32oq8p6nY
	3xNrTrXFnN8htAM0wBV7RiNfGViaYDThGyhUtDWwZTW8A7eUTrxoX0qhFHhXBRRXH0M7Eae5Cw42h
	cbocBQnQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQWw-00A4ym-KJ
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 04:49:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46E5268AA6; Tue,  6 Sep 2022 06:49:13 +0200 (CEST)
Date: Tue, 6 Sep 2022 06:49:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
Message-ID: <20220906044913.GA32525@lst.de>
References: <20220821084754.340585-1-ming.lei@redhat.com> <20220821084754.340585-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821084754.340585-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_054947_000952_F9667419 
X-CRM114-Status: GOOD (  13.17  )
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

On Sun, Aug 21, 2022 at 04:47:54PM +0800, Ming Lei wrote:
> First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
> If tagset isn't allocated, there can't be any inflight IOs; otherwise
> blk_mq_update_nr_hw_queues can freeze & wait queues.
> 
> Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> while requests are in progress"), it is fine to unfreeze queue without
> draining inflight IOs.

The apple, RDMA, and TCP drivers seem to follow the same wait_free
pattern, so I think we'll need patches for them as well.

