Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F034CCA47E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9R8dqWvBCQRNocOL7Xj5Ga03EJUJsOKPYJNpjIVOC8=; b=piZ9nVHZQOlRjN8nawf50rt1Jx
	d4K4776iAuJBYYXsXvBdLsO+43fFpdMGB4JueCQl5lkBXbKPpNfzrz6hUSJ5Aq5Z/zBYgYg8mK43u
	U3Gd+vGk/aeWJ0m7AxmC29Rt0qwz4sIDHx2EtO8vxqf43/uoDuguyKUfFNUOSL2B8u316RVSWZoU9
	e/63r+UlgLIgBJMFBxmWGUX0FHlsnWiqy+vKEGRhvlunpTJk0NWTwG0xK7bF8yERVzMtBjjFv5vOe
	7AuzCozpLDyBULxjHfQcFBsSsDXnfpZvRWBLaSCKx2xChIpHxDjnkOHiKMgAUYz+rtwkW74AXy3Pa
	cr4vH2uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGInY-00Fu6H-Ha; Tue, 26 Jul 2022 11:32:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGInV-00FtyP-Mn
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 11:32:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB07068AA6; Tue, 26 Jul 2022 13:32:17 +0200 (CEST)
Date: Tue, 26 Jul 2022 13:32:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] drivers/nvme: fix pr_warn format string
Message-ID: <20220726113217.GA2725@lst.de>
References: <20220725191751.960838-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725191751.960838-1-jcmvbkbc@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_043221_903777_3A004BF6 
X-CRM114-Status: UNSURE (   9.23  )
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

This was already fixed by:

commit d6f7cd209b089553ce0217eb0091f5f5fdc654ba
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jul 18 07:02:29 2022 +0200

    nvmet: fix a format specifier in nvmet_auth_ctrl_exponential


