Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D899FCCF9EE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAZ36+9w9FpIzSZYZyXMblPidg6jHrXqZX3DwaRivZY=; b=iUWttBzPIVOlQja/PvzEWWW0px
	m4EJYuF4N328nOJNcviSkjGs5ur5uTsJi/6fymFp7qeVjC0mW+8/+c9QWHDWyHwqrbGI8dXwkNsQj
	IUVYPlgpZ1/bnygYzYUx9SUEANEyfF0aFap4Sd9lMll9R6U2vQOatcWI3jXM0JvuKvAxo8pVqAXNp
	e9uESAd7fV02jLnH4h/ppnLvhpiMTxEayVxBMXio3Rm7RwFggtYZk2wS5aVQP1dRxZRWgaypTF8Cb
	AMNrdJzRizv1x46d/cotBciNKpDpw1PIiqffMGuna/02MEVDUTD0+B59Cw1LZ9FaVcx++AxNoUIw5
	W1SzjX0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1uP-00000000NQN-0qxz;
	Wed, 29 Oct 2025 08:51:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1uM-00000000NP8-30M6
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 08:51:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D802227A88; Wed, 29 Oct 2025 09:51:50 +0100 (CET)
Date: Wed, 29 Oct 2025 09:51:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nvme-fc: check all request and response have been
 processed
Message-ID: <20251029085149.GB32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_015154_893209_D41720A4 
X-CRM114-Status: GOOD (  14.49  )
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

On Tue, Oct 28, 2025 at 04:26:21PM +0100, Daniel Wagner wrote:
> When the rport is removed there shouldn't be any in flight request or
> responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


