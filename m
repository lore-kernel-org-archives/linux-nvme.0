Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52326D43FE1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxbO1mdMxBjhppaWcfMY3p35ppTnnQgFtPtLtaLnDDw=; b=14QMxk/sWn4EdFAdnUhuhvCfWL
	q6/BbM+/XX5EjWHZTGY1UIVJKiIoVF0b2PMUFZbFfBEutJdPfNk4Z991uDUfk/Pj7NQs1JLB/8A6O
	wvQb62vvt7u37UNFkXxd+MY4wBjJTBzmKd4m7CmCeJbF8ja3CizIHql3ya0IVCPjNUou6SKrWrZ0n
	gYMQhUgyXcp4KUg9ZwnUO4k9Ob9n7w4L8kTqKaYANAR1dzIiNpkSW5bebdssW2VtaBrkmmSlkByYE
	PAoGG1nBoa/pRQfc+cHRkc4Jxn1bUogQoGebzqeDIpGnDDRaco6an5dlkEcm4pvfubxI4Cwp6v7rI
	9LOERZ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvmo-00000008bFM-1670;
	Mon, 18 Nov 2024 07:03:02 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvmm-00000008bF5-0YqJ;
	Mon, 18 Nov 2024 07:03:00 +0000
Date: Sun, 17 Nov 2024 23:03:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
Message-ID: <ZzrmpG2DdGCo1XoP@infradead.org>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
 <72a94818-cbca-4c0d-a37d-59fba15e4dbc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a94818-cbca-4c0d-a37d-59fba15e4dbc@linux.alibaba.com>
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

On Fri, Nov 15, 2024 at 09:40:47AM +0800, Guixin Liu wrote:
> If the user want use dm-multipath instead of nvme-multipath, but the
> kernel's CONFIG_NVME_MULTIPATH is y, they can set this parameter to disable
> nvme-multipath.

.. which has never been supported to start with.


