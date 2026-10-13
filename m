Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61900CC6B0F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TXBxasBBK+RNKDIEk6gjqBwcm3
	EnrxQelwdFkd/Pjg2DhZLsAAukStTIjMRccgCX7JTn6PMcqYrtMA1PRGSLkDz1aRMu30eJrwdUyYd
	16lxsjL36SQjfZ9rVLD3u8izpSeRbOqBRXrRJK7defGSfCAmWaF1ps0MBqVcs4wCD4MqKr4C2jO6D
	v2CPfZquTeRXvUeSWnzDtYgr4yAkhrF+BH673P2cMVbyBBRsu3McK60UYJJOgajHMYrjvtljtYqpy
	JVVlUmbzJuWj4KuhCYco/ZWboUDtqXcC+SczD7TD1aagY9+OKZNKMhXYyBmjTzq+t2/Wc7Z3r2eIH
	4QOjrmDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdVf-0000000D6LU-0P0y;
	Tue, 13 Oct 2026 14:29:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdVb-0000000D6KS-3ucq
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:29:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 994EB227A88; Tue, 13 Oct 2026 16:29:36 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:29:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com, hare@suse.de, saravanand@crusoe.ai,
	sjpark@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-multipath: add fail_on_ctrl_loss sysfs
 attribute
Message-ID: <20261013142936.GB15192@lst.de>
References: <20261008141407.22992-1-kiyer@crusoe.ai> <20261008141407.22992-3-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008141407.22992-3-kiyer@crusoe.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072940_115326_4F502DDE 
X-CRM114-Status: UNSURE (   8.39  )
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


