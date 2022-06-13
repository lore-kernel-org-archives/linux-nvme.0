Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ECEC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VlwOLb3y/JIt9uQBSqqSKh01kF4eigg7U400w1zEGQo=; b=44RF3QunJxE/pkES0ZzM6h1UhX
	30HdCBtX4VetQ6W+EKOHWLtYIhd/EgRJ65rqShxAg94GWUeEenshvdmZD3qQz7QJ0zFuF+PJnUhms
	d2U8fqFAra/M1cFeZtJSoz6NuccD7xqmDWR52LiKtNGJqUdXqr5HT0iyO1ix46R8ZlfDu3YLHXKSg
	WWks22bDj9/BJhlCYWJg7QpvPSItK84xhltsnHssZabBRL6RvOEGcSeU48UWdEXFbmCMNG+TE1/Ex
	LH2xkywpYHwT9s4BtjGLwOdyoGCTut84jf6DyFLSMbMNyH/XIDSKL3Gi/yJFQpVugy3T1O3wQpvqy
	EZHFsHsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oY8-0057JN-B4; Mon, 13 Jun 2022 18:12:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oY5-0057Im-K7
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 18:12:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5237068AA6; Mon, 13 Jun 2022 20:12:22 +0200 (CEST)
Date: Mon, 13 Jun 2022 20:12:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Message-ID: <20220613181222.GA16146@lst.de>
References: <20220608144518.67607-1-hare@suse.de> <20220608144518.67607-7-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144518.67607-7-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_111225_854038_4FCBC8C7 
X-CRM114-Status: GOOD (  14.17  )
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

On Wed, Jun 08, 2022 at 04:45:13PM +0200, Hannes Reinecke wrote:
> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
> This patch adds two new fabric options 'dhchap_secret' to specify the
> pre-shared key (in ASCII respresentation according to NVMe 2.0 section
> 8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
> the pre-shared controller key for bi-directional authentication of both
> the host and the controller.
> Re-authentication can be triggered by writing the PSK into the new
> controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.

The Kconfig doesn't apply due to the new nvme-apple driver.

Also when I fix it up manually Kconfig and sparse are both not
happy:

WARNING: unmet direct dependencies detected for CRYPTO_DH_RFC7919_GROUPS
  Depends on [n]: CRYPTO [=y] && CRYPTO_DH [=n]
  Selected by [y]:
  - NVME_AUTH [=y] && NVME_CORE [=y]

i.e. when you select something you also need to select its dependencies

sparse also isn't exactly happy with the series:

rivers/nvme/host/core.c:3667:1: warning: symbol 'dev_attr_dhchap_secret' was not declared. Should it be static?
drivers/nvme/host/core.c:3717:1: warning: symbol 'dev_attr_dhchap_ctrl_secret' was not declared. Should it be static?

drivers/nvme/target/fabrics-cmd-auth.c:33:30: warning: invalid assignment: |=
drivers/nvme/target/fabrics-cmd-auth.c:33:30:    left side has type restricted __le32
drivers/nvme/target/fabrics-cmd-auth.c:33:30:    right side has type int
drivers/nvme/target/fabrics-cmd-auth.c:118:22: warning: cast to restricted __le32
drivers/nvme/target/fabrics-cmd-auth.c:118:22: warning: cast from restricted __le16
drivers/nvme/target/fabrics-cmd-auth.c:389:30: warning: incorrect type in assignment (different base types)
drivers/nvme/target/fabrics-cmd-auth.c:389:30:    expected restricted __le16 [usertype] dhvlen
drivers/nvme/target/fabrics-cmd-auth.c:389:30:    got restricted __le32 [usertype]

