Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB6C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mC8K2ZziLUa7YxGEcyRjWBswuh
	7alPwWxmpLt/JctsSa/RP3ZZM4tN7S8nGqPEIPpw7VAcjf9AXIwVD4asu/l3SDpu2wWZ80LL3F5al
	QanOyI+IjKBYg5g0Ft4LmazZW5La7xI3R65EGdjiMjoa9DoCEq1Ku/woyxz/fNUcNRDJPBZ8ewvYg
	JPx/3cxc5K10THqHgxEtkwqoUKIvvDQzlHtiJY9I63lueAJyNeXZ0Z5Zf6I+BgRSaFKIh9B+vhtMx
	vGjxY9M2dj4riJ9ONsAbifPtwWayixr5x1r7NV+aIfN08IXl+5mhISPEx0vJgdyxyCMaXiPw3FxZr
	d7nDiN/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1TY3-00Aa2X-2L;
	Tue, 23 May 2023 15:03:39 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q1Kz2-0091FK-2G;
	Tue, 23 May 2023 05:54:56 +0000
Date: Mon, 22 May 2023 22:54:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Don Brace <don.brace@microchip.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Guo Xuenan <guoxuenan@huawei.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	kernel test robot <lkp@intel.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-xfs@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Tales Aparecida <tales.aparecida@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Add struct_size_t() helper
Message-ID: <ZGxVMAa/3QOd3cRf@infradead.org>
References: <20230522211810.never.421-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522211810.never.421-kees@kernel.org>
X-Mailman-Approved-At: Tue, 23 May 2023 08:03:36 -0700
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

