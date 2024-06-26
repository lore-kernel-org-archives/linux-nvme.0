Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5EFC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PETgsEUtR11PaAAGC8zQFX5i0w
	P1TGNcKIeCNiyyCWcwn0HNA83Nt526b6FSlm4/2zPzZcILxQmp9bvVycEQjY8o1GU/1+lDzo+dQdg
	o52bt8nlx4FOsXhtrFEmFzx/NZmkkvnHo5JHQBtuNc1XfpdcJxiPfu4MGNGIHWlt/ZwdXgpewxdbq
	86HNOWPO2n9LFd95ok/QJwuBwn7JJPSPEJcu7ggbmfcsn47Xrim94EXnHkSPb48dcdtTnH+hqnoc3
	NmpolbatAZnC/CvgqmMdbw9u/5LVI0968vBDKrmE6wZMyisSp6YvMasAB0T4+7SqJyipgR2iip0NH
	FYCY1y/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKrb-00000005OzS-2B13;
	Wed, 26 Jun 2024 05:06:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKrW-00000005Owz-2xFm
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 05:06:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4257268BEB; Wed, 26 Jun 2024 07:06:27 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:06:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240626050627.GB21922@lst.de>
References: <20240625122605.857462-1-jmeneghi@redhat.com> <20240625122605.857462-3-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625122605.857462-3-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_220630_924729_361D7690 
X-CRM114-Status: UNSURE (   8.42  )
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

