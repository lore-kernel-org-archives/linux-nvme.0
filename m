Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E5FC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmZ8Cf7hx1BCGY2wCKipgjd/j42Viv5BD8p05M2Lupk=; b=pEhjJ1ycJFJWqb/fuQnIWPLitk
	rvgr5q1kHRnA8QNJdzXSfHCvUXDrx4N/2K25xdlYlQdCtppC1qOL+VjpZ6ol4m5JeF22S0dFBzTQ5
	fn2IYBnj+6fyLMjDnLACNYpCaqdTZlVo7rhWricEgzlYOXh5tW7JafBV6UvxlYt593FVQSfb0MX0/
	CoSzzxxVCvgPNYhx3xvDqsjlyqn3dFbLPk+Nat8AvL6rzUh9dP/8H1SH5BbDs3mzF+7QETlRkGGR9
	zcJqaEs1En7+Gnj6T2ZYv6EI7T3tyX9eAKUARa+pAOr2NXq4myJZEDOt/m79m1jNvA3H4+sCoT16E
	V1e88yYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td1EF-00000006OBA-3Kpj;
	Wed, 29 Jan 2025 06:07:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td1ED-00000006OAU-1AJE
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 06:07:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B51D68D13; Wed, 29 Jan 2025 07:07:05 +0100 (CET)
Date: Wed, 29 Jan 2025 07:07:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait
 completed check
Message-ID: <20250129060704.GC29266@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_220709_459168_0F393699 
X-CRM114-Status: GOOD (  16.52  )
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

On Tue, Jan 28, 2025 at 05:34:48PM +0100, Daniel Wagner wrote:
> blk_mq_tagset_count_completed_reqs returns the number of completed
> requests. The only user of this function is
> blk_mq_tagset_wait_completed_request which wants to know how many
> request are not yet completed. Thus return the number of in flight
> requests and terminate the wait loop when there is no inflight request.

This looks sensible, but you should probably send it directly to
Jens instead of tagging it onto a nvme series.

The code could also really use a comment on what we're counting and why.


