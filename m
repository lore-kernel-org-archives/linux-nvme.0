Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C3DC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=khW7gN9J3Q0JDkEInjvWsuFVY8aw/pFVS1JLPlhgsPU=; b=x+5Z3uLHgBYIN20xgC3dcB1NQL
	ljgfdR2oQdV9GYVgddJ4BmpIJn1LyqyYxp7yHn4tuI3u46Zvh5h5WcHcqSWgSlkrMgvSGFqhyd07b
	X3uuQpDrEos2wpcAFbNTfGRZRN4RyI22LVjMF3JtkUwQqRp3v7mXKrpLvoCdlgquxVN8Ng89iUv+4
	wZP6bwcucipMpONaBseJj4eQ4pdE7p/IKyceMrDiPcMg+3q7N1eP2Y4BhNsenf8dNmy750s+xcYrP
	7wHRHpCzcqGVBfi6mLLeloPYBUceqyUkYSVjlHoXW0k2vUQxx1sjoKpj39Rv1oc8CToy0EExTGffx
	qQHnxobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzXgh-00655c-CJ; Fri, 10 Jun 2022 06:00:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzXge-00653x-TQ
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 06:00:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65F8A67373; Fri, 10 Jun 2022 07:59:57 +0200 (CEST)
Date: Fri, 10 Jun 2022 07:59:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vitaly Mayatskikh <vitaly@enfabrica.net>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-multipath: allocate MQ disk
Message-ID: <20220610055957.GA24331@lst.de>
References: <20220609173734.381654-1-vitaly@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609173734.381654-1-vitaly@enfabrica.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_230001_135550_6E841D3F 
X-CRM114-Status: GOOD (  10.23  )
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

On Thu, Jun 09, 2022 at 01:37:34PM -0400, Vitaly Mayatskikh wrote:
> nvme_mpath_alloc_disk() allocates gendisk with blk_alloc_disk(), which
> results in no MQ support even if the head device has it.

This can't work.  Can you explain hw you came up with this idea and
why you decided to send it out without any testing at all?

