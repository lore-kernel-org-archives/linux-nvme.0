Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC0F3C982
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GmEygh2vf2AWekNQzsNWxPa6fg
	SecJioB3tcve0poxUbigHjqqFNIsksvVGP+QlsHXqXEtydPY91cGBkdBFS4gsQuQiD+32T0QIObq0
	3+1IoONw92QofnoS8s/9/naBXohGm6+Fj5ELwxiC7O90d5qHpAJG/ZLrotcpTqz56yvL0DFdlHhBF
	WNsEJW3aZPjeFqE0yH1VQZk7Z/Pmh4AniCC/poksNHvbSz58ob1K1KkDaPZyxpT0q5a2KGbkD8ScK
	lag+SBwG9wPeHz/YVtM7ia+vjlFNS93MGgTv/pjYp1TACdrxEa9J7cuooC36nt5Kie9+Ci0YU+omQ
	9obmFoMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutW2-00000002EiI-0Lvf;
	Tue, 24 Feb 2026 14:35:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutW0-00000002Ehh-0mQq
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 14:35:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D61B768C7B; Tue, 24 Feb 2026 15:35:53 +0100 (CET)
Date: Tue, 24 Feb 2026 15:35:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
	bvanassche@acm.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V2 1/3] lib: Introduce completion chain helper
Message-ID: <20260224143553.GA12308@lst.de>
References: <20260224122505.52401-1-mlombard@redhat.com> <20260224122505.52401-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122505.52401-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_063556_359915_39FFECC4 
X-CRM114-Status: UNSURE (   8.40  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


