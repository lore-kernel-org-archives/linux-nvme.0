Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB351C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHtImXE842GFSGlUdAEcDfxvRkQO3qNxiC6T6KrWecE=; b=a21EcZIilzrqD3He7lRBQ7MTKf
	rZle4IYP4FU2u4HAAMLYwp2qfdnDu6KyiFT3F7vxo0EiBX8+zT3ri/E4/cQYSQARyu48OFVd54lVk
	UOB1xizS5YT41/klAbBOPEKsj24BnpNCZK5+UGSiD2k9l/W5XGhZcbdl9S3q3P34BoxD7kuhq3R63
	cJ+jYtZ+BzWoCoi9Hw1Hca/5pu5NmqE3lO/bUDSwKIB1Tpkul4CKcFwZ0d+Cn4I60wwvMfbbZGvmP
	XU4OcaVQHYDgzqPnJxnNoQCcSPW5mgLoQRLcE7dSxyWcS5BOK4Bk6KdbQRs/+yxbalRNUW/aS6XJ/
	IZGn46bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXhJ-004Qgp-6V; Mon, 30 Jan 2023 17:12:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXbi-004NlE-7J; Mon, 30 Jan 2023 17:06:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E41068B05; Mon, 30 Jan 2023 13:18:21 +0100 (CET)
Date: Mon, 30 Jan 2023 13:18:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
Message-ID: <20230130121820.GA18981@lst.de>
References: <20230130103343.GA11663@lst.de> <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de> <3347459.1675074683@warthog.procyon.org.uk> <3351918.1675077855@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3351918.1675077855@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_090614_434584_A13C1C22 
X-CRM114-Status: GOOD (  15.95  )
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

On Mon, Jan 30, 2023 at 11:24:15AM +0000, David Howells wrote:
> Seems to be something people want to do quite a lot and don't know about.

Hmm.  Right now there is one case where it would be used, and there's
about three that are and should be using bio_add_page.

> I've seen places where someone allocates a buffer and clears it just to use as
> a source of zeros.  There's at least one place in cifs, for example.  I know
> about it from wrangling arch code, but most people working on Linux haven't
> done that.

But we don't really need a helper for every possible page use for that.
People just need to learn about ZERO_PAGE.

