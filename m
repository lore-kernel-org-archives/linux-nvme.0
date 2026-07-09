Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67716C44501
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sfro0yC1S7Zc0NejOh3+G8d5lG
	kgz/LmvTK6UF/coy6Z50++pSgaDMkv8qF/NcjfvLhtmPwohPmJVa4y6uprTrlKPP7YBh8VXvhhqZd
	yYjtPuyA1pZbt6mdWVGUagmf32znBDa2+8qfZSItvsyzlliu7D/PT3KQA/L0Z0Nutbj7hOsNl4L9I
	EIhfgbo29PHX9kDsesx89X0lMlNvqBjPM5l9qdv69Ky3xzHp8kUpe5Q2xfVo1UKpuB6BZ98BwJ5cZ
	ROxsMUMaCm/l9nzw3WTNxWnJT+90d7CMvhM58P1/cVUWQz0Y18o/dmxqhzHey+tXWc07kUa8C+yaD
	9Fpk2RxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiIC-00000001Akx-0IMF;
	Thu, 09 Jul 2026 06:31:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiI8-00000001Ajc-2ltR
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:31:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E68DE68BFE; Thu,  9 Jul 2026 08:31:21 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:31:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 11/18] nvme: add context annotations in fabric.c
Message-ID: <20260709063121.GE18056@lst.de>
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-12-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-12-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_233124_848719_5F9CF441 
X-CRM114-Status: UNSURE (   8.71  )
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


