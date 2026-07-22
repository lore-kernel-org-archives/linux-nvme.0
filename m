Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E34AC44539
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ty8yEybo7pQyG04LQVyQGWhFMWc6bkERN8xp8o7rfUM=; b=M+8NL+94LtkrdBux5lJnqUIe0I
	2U7lZWYL6gDJK/EKlMVQLEyDclaYAoS3TGuYlrrr95WxcMd/giObnvpMPaswlXDy+SDhwHs1Q55al
	JDWtl/K5GtN9J+eWtdtbt9RfP8uqED+AjFuqQWzsjvNR/subJogPjSkhDGZh82KtNjHR4vKuLc2aY
	bG+xfSIQ+cxgXSHWAnSXr54jrH9m/Plw6YYZXVNZHn1GJ7eUdTVlSMbSxUU+vBUkDsICu4LMWfRbf
	Sanxix5VswTNXnWwYAb1gxOorPS8J9g1DfzS7C8T0ejDFwjODLAUSarKXQrP80AN766JfcX/UiJxM
	LibT279A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVwN-0000000BkUS-0IAm;
	Wed, 22 Jul 2026 12:20:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVwL-0000000BkSV-1WZS
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 12:20:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C03EC68D1F; Wed, 22 Jul 2026 14:20:42 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:20:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 18/20] nvme: add context annotations in tcp.c
Message-ID: <20260722122042.GK12774@lst.de>
References: <20260713115444.465704-1-nilay@linux.ibm.com> <20260713115444.465704-19-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713115444.465704-19-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_052045_548544_A5C7B5E8 
X-CRM114-Status: UNSURE (   8.83  )
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

Looks good module the ususual list init rant:

Reviewed-by: Christoph Hellwig <hch@lst.de>


