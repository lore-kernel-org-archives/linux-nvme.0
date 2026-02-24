Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB070F3C982
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jL4i3CX/dinKLDgbqfJS1rcog+
	0GDHzs9YNioXG6xajjkxddOzQM/d2DbOCMpFjQ/ZDnqnuhA6Kt0haimEIL+D8QgS9tynLms/7Aely
	DhGcOFJEt4wl5/+ol9ID8PhSRrCxZgQxMfZtVvQyweO2AgokBa9MbKs2RRisSy/eP6U+O7NxDFQQi
	+hBceqek17zRz7tGltajwt8MbQwMuPg72kHYfy4CC2QRGzB1NQ7jZsHr8idheM+EAbuSYjGWui36w
	mx+sUI0r73HrB73oCp2UJhCgzW1bu6j8Nz271f0FTjDfjpv4GIl0FgbnhkK5nsGKusNsWw06jm6Qa
	ydTw0QQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutXq-00000002F04-3F1p;
	Tue, 24 Feb 2026 14:37:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutXo-00000002Ezj-3l7O
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 14:37:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 853DD68D05; Tue, 24 Feb 2026 15:37:45 +0100 (CET)
Date: Tue, 24 Feb 2026 15:37:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
	bvanassche@acm.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V2 2/3] nvme-core: register namespaces in order during
 async scan
Message-ID: <20260224143745.GB12308@lst.de>
References: <20260224122505.52401-1-mlombard@redhat.com> <20260224122505.52401-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122505.52401-3-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_063749_067872_7E4D5016 
X-CRM114-Status: UNSURE (   8.38  )
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

