Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D52D3B7E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 06:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=h7Hb7ZI5KRtP7j2gAqnyBwConS
	jA95Zz9HRmSGhx31cskq8p7bUxL2uADABjTOe7d2qytpa5HJysthn9Iz8eOt7tXeR17NtF+kEbsES
	py/NsTLXezy/MiCZDwRKw50YtETUcFPFeIQZWw5SBSszpKzRgyp3ycIr8Fb8ncHHIWt2tRxTxKOsX
	YTHVjz/t+4JdlOkaeDZS/PcXNJ9o2zzlMESt54aJTVeJcu9QAomrH+eZrId/6cPd7TancPF3wTvii
	zd3JZDkEAjYOH7vm9TZER468xyBf0oxLDsVLEykKqHtU3mj/5NnXSEGNsGqYdrmBdO2MfKUbnH1Rw
	2e9N9Kug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSsp-00000007BPO-2988;
	Mon, 25 Nov 2024 06:47:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSsn-00000007BOm-2d4N
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 06:47:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AA2D68D34; Mon, 25 Nov 2024 07:47:37 +0100 (CET)
Date: Mon, 25 Nov 2024 07:47:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	chaitanyak@nvidia.com, yi.zhang@redhat.com,
	shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <20241125064737.GB14937@lst.de>
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_224741_796223_EED3406D 
X-CRM114-Status: UNSURE (   9.40  )
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


