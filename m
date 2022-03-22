Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B0FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6921As+cEZHo04ZibZrCXb39hYnvJlM15ct4+ebpNso=; b=CoOeUKgnKtrbyFD3ZFz9upqpFW
	XrjqtqLRTOFcyZVx3wnlUzbYRjtTRJYlV2a0EaMiMMc2yWJ/B4wWrgrjQyvOskf3DT2DBfyKs0phe
	y5mMIA47GApUAlgY9f08Nq3UXO9cG1OQsi+XMqa4Zy3ei3KndIXklKW8W85Fxj7l7yQf/2T6FdqJP
	b1qjxo8nNeFAbvNbgPm2x9p2+oZ8tLL2LJH0pomqO0EtqhaB79T8wn6UJ/f/ivoLOMBlIt9p6rHdl
	g/YRyb7JCZ2LNjv/YofRlQkGtWKwRz/H+A89YaqCr5jqxr+RDygFcHNJb/txL9bdA46WTpQeDZH7Z
	AwgF8IjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWcVd-00AnXi-0U; Tue, 22 Mar 2022 11:17:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWcVa-00AnXK-SQ
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 11:17:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 296A568AFE; Tue, 22 Mar 2022 12:17:00 +0100 (CET)
Date: Tue, 22 Mar 2022 12:16:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 lengchao@huawei.com, dwagner@suse.de, hare@suse.de,
 mlombard@redhat.com, jmeneghi@redhat.com
Subject: Re: kdump details (Re: nvme-multipath: round-robin infinite looping)
Message-ID: <20220322111659.GB29151@lst.de>
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-2-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321224304.955072-2-cleech@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_041703_087025_FE2143AE 
X-CRM114-Status: UNSURE (   8.28  )
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

What kernel version is this?  generic_make_request is long gone, so this
looks pretty old.

