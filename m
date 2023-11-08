Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD9BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GytqGlIM9OK7idldRZDNZmS+D8lkXwfXcdcpBJ4hGw0=; b=GR/r4RryjO8QWMXriGQpvtU3OM
	cpJme1+txeHa/OdFaLUQJNtX3q+SKAquKVXTMqEk8uF+yErc3eerYwzP/iZzEFRUlMAGa+zFe7rFR
	a2ecgAzYGROeAnAzpAYGDDB3ZKXeKhYazayxZjFZBaM+TJiQYQUYAM6imPc/D+CSG3t+Jyrb2szpG
	aVSEFxBRVoRHYi66DAi2mJsmi/Wr3d5QvfgJWGoixCid/6kMKxMf3J6yBW0yuNUusZkXwjgM6qKBd
	ujegja5ZxoLgoXhlStcJ1r2qXy7qFMxhkPK82uJfZ2F9sBUbyLk0OYO3cIhTJGrtaZtHgAz2UqEv4
	m5eSuszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0de2-003Ffj-1C;
	Wed, 08 Nov 2023 08:10:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0de0-003FfD-1c;
	Wed, 08 Nov 2023 08:10:36 +0000
Date: Wed, 8 Nov 2023 00:10:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
Subject: Re: [PATCH 3/3] nvme: multipath: Invalidate current_path when
 changing iopolicy
Message-ID: <ZUtCfFcbT8IwcdF5@infradead.org>
References: <20231107212331.9413-1-emilne@redhat.com>
 <20231107212331.9413-3-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107212331.9413-3-emilne@redhat.com>
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

On Tue, Nov 07, 2023 at 04:23:31PM -0500, Ewan D. Milne wrote:
> When switching back to numa from round-robin, current_path may refer to
> a different path than the one numa would have selected, and it is desirable
> to have consistent behavior.

In general invalidating the current path when switching the I/O policy
seems like the right thing to do.  So independent of the rest of
the work we really should add this:

Reviewed-by: Christoph Hellwig <hch@lst.de>

