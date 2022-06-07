Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C95C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QA8i6O8eC4oOKbqfFz87C9/p1kJZ16ndnu/DSOwEcLI=; b=OfNU4jhVGpx/yg4YrxOzDCFaaG
	eER8lEMlNltF10JYxNxgHkEKmP2+ctgfOyi7BdN7ps7O3EgT0A+Uyam51871Zum66l70uDVhqETNg
	3dfR0szlFv5pqCoFJa8niEChlDHWqEPrq8FB5zBlRl7dk/CbAYvMS/RwZCS9kEx6yX7eovFws7sD6
	ehcpHPuM4Lxj3BGKERJUEqqT+1SLE2bD7Jxt3aOY9hK6YR/Uiyx/7uku39ERusrk8EI1oNDU58nXv
	vZs0WwJyu5FqfiRyX0j5z0k+/Zn83hDvv2Er+5zlyK1QzbdzGoF7zWXzLd5ymaz3D7iENFlSTWFLT
	nvy/gF1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWlL-006oMF-94; Tue, 07 Jun 2022 10:48:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWj4-006n1Z-2v
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:46:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A8DA67373; Tue,  7 Jun 2022 12:46:15 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:46:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <20220607104614.GB25515@lst.de>
References: <20220518112234.24264-1-hare@suse.de> <20220518112234.24264-10-hare@suse.de> <e13a0c12-362d-e4b6-c558-03367815264b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13a0c12-362d-e4b6-c558-03367815264b@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_034618_317313_21ACA09A 
X-CRM114-Status: UNSURE (   9.68  )
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

On Sun, May 22, 2022 at 02:44:23PM +0300, Max Gurtovoy wrote:
>> +#include "nvmet.h"
>> +#include "../host/auth.h"
>
> maybe we can put the common stuff to include/linux/nvme-auth.h instead of 
> doing ../host/auth.h ?

Agreed.

