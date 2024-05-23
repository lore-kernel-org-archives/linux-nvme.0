Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C52C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfCV81rb7WTdqHm/gaOwGofV19310B36K8Hz5UQdw9Q=; b=kJXGqv08cyQ1AhQqou3cGg07zu
	QDgXem4R82CLOkFzBv7a5eh2lqoowDMpvERA6r9iLeQfEBNKzM1Yn65xVDVtF322wecKGFJxfpPJw
	F0BEqYS8cd1pmKDqF2uQoqrMrlFKiNBPL8s+my+YIuJp2kK3+eQYjJ3O+tHiSFYKhD/ti0MfOZdfK
	onCdC0cC23ilTksSucvfWBK3t0bgaQ5QhMLKG5qB/vm5TtiTyuTVck/CWlxRRwtyB7xvCOGwTii8k
	6LlY84cGjSAJF3zk0scim539Lb6q37B+fOcvd1zjVOeykHjr/CuaW+gOFu4R584sRdxgEg+pqD0ft
	oA6VlM2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA3bC-00000005U3F-0VBj;
	Thu, 23 May 2024 08:14:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA3b7-00000005U2d-455x
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 08:14:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2896868BFE; Thu, 23 May 2024 10:14:44 +0200 (CEST)
Date: Thu, 23 May 2024 10:14:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523081443.GD1086@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_011450_254187_84A3F12A 
X-CRM114-Status: GOOD (  13.66  )
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

Oh, and there is really something of with the patch format.

First the subject line is completely wrong, this should be:

nvme-multipath: implement "queue-depth" iopolicy.

On Wed, May 22, 2024 at 12:54:06PM -0400, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>

> Signed-off-by: Thomas Song <tsong@purestorage.com>
> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>       and compilation warnings, updated MODULE_PARM description, and
>       fixed potential issue with ->current_path[] being used]
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>

Second the patch author needs to be the first signoff.  I'm not entirely
sure who is supposed to be the author, but either it should be Thomas,
or if the patch has changed so much that it's someone else the original
signoff should turn into a Co-Developed-by.


