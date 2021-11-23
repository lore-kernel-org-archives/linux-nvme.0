Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8491BC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=L8AzPVkrr+ecGJsjcEwgkq/aBo
	7ey0i3Xej83wRYh1hlqSINXjIAYz1uFyZxRjBkTUITl5Z8jT8A22cN8xyBCE8vl8HY5SGG1t1tPzl
	eo836L5Cptxck4NsfzZ7/oTJU4efWX9wP3eKy5kRb9K44iefcG8qz0FHMcU1F7NfrbqtzxJ/sx638
	d2hAtri6oFtq7S0zFwucbR3ZefN0c712QUshJNSVZw3kos7dhTTcXHmKNeaG8hI58nFzhEUI2kSCW
	7HzsUnmpmxwa0ZABqM9AeKRzjbk7eIcUGrtkQ0jSperKmy2UlG6oOB6YJpdFzlBbMYev6L33k97wp
	ViKRHroA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYa3-002rL9-Bm; Tue, 23 Nov 2021 16:23:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYZy-002rJq-SC
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:23:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E64B68B05; Tue, 23 Nov 2021 17:23:32 +0100 (CET)
Date: Tue, 23 Nov 2021 17:23:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 hch@lst.de
Subject: Re: [PATCH] nvmet: use IOCB_NOWAIT only if the filesystem supports it.
Message-ID: <20211123162331.GD23957@lst.de>
References: <20211122100827.290117-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122100827.290117-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_082335_087192_172F16AE 
X-CRM114-Status: UNSURE (   8.19  )
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

Thanks,

applied to nvme-5.16.

