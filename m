Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994FCC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=i//TmeUneT28RWruZBvJjuoFP0
	LGIZ11t1qytWwRNZYRp1BLXpePR/BkOHkhF/hzvHTuxx4592l1Iuyg5Yel/WQ9vQkfr0xCRkaA7Tf
	TLlJyWqikgPvyFNvT2V9uS9TQSv1XHmE4RJPqoRk8VQr+ZrBapra35djo98/iKys2wf3UtHCG8sSc
	bah3+W+2GGvcKFRy3EjSHk2RwoSC91QLFPDkycoRc8QUN0lc6HO2jZJPhBUX3F/qFenbfn3Cur7cd
	jp9vr3tFRPAq7F0Qb9Whpq1lMijoR6+U7JSextyaIvkFPFvluXJv8BkpbQfnOdbR47iX99tgArmjx
	qtguFzfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWwEK-00D5A4-WC; Wed, 23 Mar 2022 08:20:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWwEH-00D59I-LP
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 08:20:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ED9F268B05; Wed, 23 Mar 2022 09:20:26 +0100 (CET)
Date: Wed, 23 Mar 2022 09:20:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 James Smart <james.smart@broadcom.com>, Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Message-ID: <20220323082026.GC26611@lst.de>
References: <20220321115727.774650-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321115727.774650-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_012029_856328_A68FC594 
X-CRM114-Status: GOOD (  10.48  )
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

Thanks,

applied to nvme-5.18.

