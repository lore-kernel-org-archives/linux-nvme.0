Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9282EC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+biVbwp4JHc9fYXHC5tsOubj2HwnqnIFKSPfKFQj9FM=; b=n6T/zZHg43u+U7u6x9eXs1SDWg
	WbMliajM1g3M0JSxiAQPTyDih5P9SG1YP6qC03BOr7qxlqPHB+k8Xzrya4UrLzmXACpdfbfGvHN6g
	S3NbWam+psamtnI6kuNwkjtMRV9cLj1uw/yI3mJ9JvnuUCJigXAIuiMLRLGJ9fkABVo+V3Vqyuw2J
	ZJ4RTBNWGMtaM9esd78ZI/xnxhwup4Nm8R7ILIcmBlW+IF+gsilorcZPLBtz9lwV9TbpU6yszyDjg
	pK2ZgDDyl0RtIo8Gcsy8getxB1KADu/iF1A2vSmha3hsJrQAx/7ziFinKh+rzhdW44UFdwh8Ggppc
	RRnEktXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa0m-0000000Ei84-0BMZ;
	Wed, 07 May 2025 08:20:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ9Y-0000000EWBU-159j
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:25:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB37C68B05; Wed,  7 May 2025 09:25:12 +0200 (CEST)
Date: Wed, 7 May 2025 09:25:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 04/12] nvme-auth: do not cache the transformed secret
Message-ID: <20250507072512.GB2347@lst.de>
References: <20250425094927.102656-1-hare@kernel.org> <20250425094927.102656-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425094927.102656-5-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002516_434917_471905B8 
X-CRM114-Status: GOOD (  10.39  )
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

On Fri, Apr 25, 2025 at 11:49:19AM +0200, Hannes Reinecke wrote:
> Only saving so much, and doesn't bring much benefit.

Sabing what?  Please spell out the rationale a bit better, the above
leaves me more confused than before.


