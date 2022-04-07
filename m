Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA9C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08wLN4VAOICqRsw4rsmqh/bhBg/LsHrIkmiootAeF0Q=; b=T+4pPoYGa8r7QU7fZLgzrCOOFm
	4z2steM+ceZFLSfYQxN+h6by4434a/kZHUrGm40WHv4PLUBZ7PiHUcW7TOw70NQAaTr9KN/lmfub0
	E31zvzgz8P+8x3MS3tm665C7azlacgs4oygvVr0XkLeB0oECIzEnN1UQ4w9nWxJ1vI2EYJHu2OCSE
	hK3Hd2PioV7kePGH8R4T/AbPu75sGdiZUBmkTly17dgTYfkhi16/1HK0L6DgDSvZbzhK/wSqW0LP6
	kcplCjYWxCb4g+LGIj1i9r18rhKpEynAaQUSLvNV+tX/H2ogE6LFCnu5Y9MsVHIMLJar08sai4YPd
	dCKELw8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncOsX-00B3Qp-6a; Thu, 07 Apr 2022 09:56:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncOhx-00AywK-DH
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 09:45:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 37F1868AFE; Thu,  7 Apr 2022 11:45:38 +0200 (CEST)
Date: Thu, 7 Apr 2022 11:45:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: expose discovery subsystems
Message-ID: <20220407094537.GA23413@lst.de>
References: <20220406142210.71248-1-hare@suse.de>
 <20220406142210.71248-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406142210.71248-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_024541_671988_AC3B662F 
X-CRM114-Status: GOOD (  11.13  )
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

On Wed, Apr 06, 2022 at 04:22:09PM +0200, Hannes Reinecke wrote:
> Add a module parameter 'expose_discovery_subsys' to allow creation
> of discovery subsystems through configfs.
> If the option is enabled no default discovery subsystem is created
> per default, and the user is required to create one via configfs.

I'm not fan of module parameters.  Can we do this using configfs on a
per-port basis?

