Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A919C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kj85alwb5zDXe1fiI+1A2OxqUoivM85da0UNpV7wuUU=; b=AZTBJnOEzPocoXbx9SmrBSAaqS
	yoDo76iz6cZ9eGdCVmZNuUeYcBpLgTLSQ8vFago143nK0Puxu8+tpo1c/sCCr2XWHSBUsdYuGhATZ
	vprg5bLQ9w5eAUlERtT8v3c4AMUkFxOoT1KIIhOwf2I7u6zv2HLEKqL6xH8km0cXOhGsrdJ+b81Fy
	q8AcQtCwiwQnKNkg6DjIEsn7tXEdfftsxEyKK12yynpAS1xZeTj9HiXHHNStknFWln5lkHA64wxgX
	xPDuHK+NXgNFr64TpECG4ejwXeGLO4if5yhq5wjRP7xtk90hVKHXn4qHfzSC7/DT0jRNURpgKNNLQ
	1oOTubqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR97P-00000004OYm-2k9Q;
	Mon, 16 Jun 2025 12:39:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR88e-00000004DpG-2Q7M
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 11:36:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CC4467373; Mon, 16 Jun 2025 13:36:29 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:36:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
Message-ID: <20250616113629.GA22229@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <20250611055432.2401372-3-hch@lst.de> <f88d67d4-8484-45ba-9705-95ced325c65a@oracle.com> <20250616053158.GE1148@lst.de> <58c27e85-c47f-4c88-ad74-9a7d9943cace@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c27e85-c47f-4c88-ad74-9a7d9943cace@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_043632_754830_05B0B3D9 
X-CRM114-Status: GOOD (  14.93  )
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

On Mon, Jun 16, 2025 at 08:42:41AM +0100, John Garry wrote:
> On 16/06/2025 06:31, Christoph Hellwig wrote:
>> On Fri, Jun 13, 2025 at 09:03:07AM +0100, John Garry wrote:
>>> I suppose that many comments in 1/2 aren't relevant any more from this
>>> change.
>> What do you mean with comments in 1/2?
>
> I really mean my nitpicking, like:

> That dev_err_ratelimited message changes/disappears in this patch.

Yeah, this gets removed here, and IIRC it was a mostly blind move of
the existing code.  So I'm not sure touching it is worth the effort.



