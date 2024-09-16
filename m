Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13490C3ABB2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qxoFC+SMcrFuBSCc4SzSgRjqpFbBI6rBOLP6HA8WcQ=; b=rtW+teMKB8kJ50RG0mlEICwLyN
	W8gvah89oCX8eVI63DT0RtUlKlsHM0bPeq7pmmIza7bh+RxPlunifcrREPSQ9HD9JlKIYq6i7/9Iy
	6te8eZtHs6E4B2WxqCZLlcznTuhNLod0A24xTbpVCuymGk9mGSZ+0mkGJQU/yS50cMnKEEPGlEMet
	vQvj8k7TFvE3/Ra0uUXg5hoH4lFPNLELiJF1xughYyXkTWuf/z+CGmAVps9/L9YT9YT9UbUl0poCK
	zLrj4T84P7FZ3XvqsiAwGWjdEsubt6Wzk3w/jlfrBOLeKSZ8lnQMjZX5LHM5c4XvH8gT8JrhAmn6f
	kdjBF6hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq7I7-00000003S1r-2Jor;
	Mon, 16 Sep 2024 08:41:03 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq7I4-00000003Ryo-1YZx
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 08:41:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E3932A41A87;
	Mon, 16 Sep 2024 08:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A2BC4CECC;
	Mon, 16 Sep 2024 08:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726476056;
	bh=XQXfmHXYm8nPbHnm4cGGcfowXPNvc5CPB4QSkYiTM00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9rBmWllFZJJ90mP9ftq7DHqmtMJIZX+gbnDVKqeSthnuBm+yXKJeEnb4uFVb48Gj
	 IyZ7HnudXGA3uFdWbUjs9IfktXE1cwNee799w4lYvybnrMIQpK6HfPriESACBylkVk
	 BOfTa3O6BaZLX2SL4qXdqJNpCUhfpzKk4P9BJSWvRCsUxuTaIfTmKdt37x5EPk8wmE
	 I33QGpTfZTffHxtBZocGHRGqCikE5I59B+sxrGl6MrciDcMvwnVCr//KWmuLQjGOjz
	 3ZWKDQI7VplHMHExM6H7hCuappaKMALOup7N32F3Io2436ps1QXqUgRHfdfjTqqswS
	 1cH32ywDDGbBQ==
Date: Mon, 16 Sep 2024 10:40:50 +0200
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv5 4/9] blk-integrity: consider entire bio list for merging
Message-ID: <ZufvEhr-UO_BGm6_@kbusch-mbp>
References: <20240913182854.2445457-1-kbusch@meta.com>
 <20240913182854.2445457-5-kbusch@meta.com>
 <20240914073011.GA30261@lst.de>
 <ZuW-_hu1-98SEjll@kbusch-mbp>
 <20240916064412.GA15929@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916064412.GA15929@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_014100_497731_4F85CF58 
X-CRM114-Status: UNSURE (   9.78  )
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

On Mon, Sep 16, 2024 at 08:44:13AM +0200, Christoph Hellwig wrote:
> The wrong thing primarily is the above commit log.  The code change
> itself is correct, but we'd be better off killing the iteration over
> the bio chain as well to make the code less confusing.

Okay, gotcha. I mentioned the existing code is a no op in "most cases"
but it should just be "always". Maybe a sanity check with a WARN here is
appropriate too.

BTW, sorry for mislabeling the tags. The patch numbers changed a few
times in this series, and I pasted reviews from the a different message.

