Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE89D3B7E3
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=seZyflu5YWqQdBqtU0nZgLLeQ5E46QJFp+G2G/mZaqQ=; b=30zKr8tU8u3n3MDvFwaH+otvWR
	h7IemUzYy1VJw5tGisftBeh/+BR41LAcNqLX1tbLy7e7m9KBSoOep2qGr4pIfaV9XGtKoq2UJRjDo
	V+TYMliivPLO31flfAkwLJ2hP+nhB5HFZ/RDCksUoJRkt5KqoWhfsZGHZyWUESJo4gwB2Oq/JMWTk
	GyiMU7Jsvp2RBqRofCXY0Pp8LZt8r0dbIi/5RnQOfDeF+WguPh57DIdNKd93DyXZ7vAj3ECA1iICV
	vOs2hzN/XkZpzCOiqeI+K8kgY3ZbtszWsBBwa5QZ+GDLzW/G2ACm8+M7UDmtDtNMKgE7+5GshIiX3
	H5/3YYuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTPC-00000007EKh-4ByR;
	Mon, 25 Nov 2024 07:21:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTP9-00000007EKG-0Ofv
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:21:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A379D68D09; Mon, 25 Nov 2024 08:21:02 +0100 (CET)
Date: Mon, 25 Nov 2024 08:21:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
Message-ID: <20241125072102.GA15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_232107_271141_6C995E78 
X-CRM114-Status: GOOD (  12.91  )
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

On Sat, Nov 23, 2024 at 09:37:37PM +0800, brookxu.cn wrote:
> This due to we have quiesced admi_q before cancel requests, but forgot
> to unquiesce before destroy it, as a result we fail to drain the
> pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
> try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
> simplify the code.

Looks good, and matches what the TCP driver is doing:

Reviewed-by: Christoph Hellwig <hch@lst.de>


