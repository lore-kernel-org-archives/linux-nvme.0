Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5111E77183
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oG8poyLUj/+Gz+rurwOMgKHMDxS8pPP9Q2M9U/K9AMc=; b=y3h3mlOP6a2oiSkrjYLiRnptih
	tMOvt19kHuYj6d+yhW3ocWm6a6hZM6wWv/mFj1uLkaagx0FwJTL2h6JP9sf8hsR25KqKMWjd3Ymsz
	aITtZrIh+t06MBauMAbIKcrMtPAfUDcvF4QZVVzuiR4M19p62ROeM0N0cuEcbAMypsqJ5F64tXa6K
	BFbFHzXdzGIrGBN1b77KSgGCbV2HUzCRFm+twcNS3sHvLAeiEhcYYl+oY+Nm78z1RmZGfvgTG/gyS
	txI0KO6QCK7+4dvSu2iYlVt3CmqvhgmQUEDd8Ta1UXZPN6DNf0Fv1zSpAza+u65HrjZ7c6muYgKXV
	kVm2TlWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNoNj-0000000Fo1Y-0jkL;
	Wed, 18 Dec 2024 07:22:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNoMj-0000000Fnlw-2b6T
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 07:21:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A115A68AA6; Wed, 18 Dec 2024 08:21:00 +0100 (CET)
Date: Wed, 18 Dec 2024 08:21:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, willy@infradead.org,
	dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH 0/2] block size limit cleanups
Message-ID: <20241218072100.GB25990@lst.de>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_232105_796449_F31A16AC 
X-CRM114-Status: UNSURE (   8.41  )
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

(the CC list feels a little excessive, though)

