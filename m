Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C31AC35FFF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Emf1WuAUrZ46ch/rp0NDD/4Sb1YnvJZc/PHuIXpw9ww=; b=1u4QT4EMCLWwOPTUYi0Wn752oq
	+hSBdIBOp7qodk7k1hGvnDuGh2aLjh1bVc0WXNT/Rd8A950t/mvsssKf+hz6NqXXV2fibZb0KydW4
	+vmRDtPcjkKnBQrqkkSNO0vUt4XAhSmonhLkzRk2xyOox0a+ilZh/dPyvyc6FyXdW+nC0hDhJ2agJ
	w6T9MP2at2cPOuSs9OTAlvyLTxJY0jh8EmymYtWO6rM/IHgkzZZ81ZZKrBi0swlGFDrtWk4yJ7VBI
	dNdLTSP4U1lynbUwyKvRt0vBR6gucwvzSasTPgvQKilfcCEKxpta7W7qGV+nE6grz0+X17zmBlSnn
	TKKmmGHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVfp-0000000Dy87-1gsl;
	Fri, 21 Mar 2025 06:16:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVfc-0000000Dy55-3fAO
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:15:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98AC068AA6; Fri, 21 Mar 2025 07:15:49 +0100 (CET)
Date: Fri, 21 Mar 2025 07:15:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/18] nvmet-fc: update tgtport ref per assoc
Message-ID: <20250321061549.GE3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-13-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-13-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231553_049980_A2671D44 
X-CRM114-Status: GOOD (  12.29  )
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

On Tue, Mar 18, 2025 at 11:40:07AM +0100, Daniel Wagner wrote:
> We need to take for each unique association a reference.
> nvmet_fc_alloc_hostport for each newly created association.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


