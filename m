Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421BAC4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 07:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zsy3cmPBH3VLSgOyPAKxN1ia+RcNWLHT3KEeqjoNdlg=; b=uYXbEhkUzK6L/FIDvb0kyEDar/
	ZY6OaCIjXdVQlTMWdIYBVuLfvoyimPqwdzVtcJq7xDFJJoR5XVrWKpIPLZMkV1FrjDyXT/meeP20q
	D/vhF1zdNW0ElSPVGgrHtcrVfk/zQd82ficHMi2YmiW+Ge5Eo/RKDx0P5CY0FEOa3esA1V7cOuGjc
	5HEK3aH/S1XaIXKlLUpeqabVVTXCIHeMitq3YZjCy6hLNEt3c0KCTzGroj7nXRQw5TdSR5n/LVnDX
	lR311gWE43EAjS1CMBbml1rm6VvTrFGKkgU+lV4hjtdtAR2T1PhlBP1z+vQ85jaL6IIi/GI/Xad7A
	gUf5I8eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c6Y-0000000F0wn-3jaS;
	Sat, 27 Apr 2024 07:04:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c6W-0000000F0w1-09HW
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 07:04:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A355227AA8; Sat, 27 Apr 2024 09:04:08 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:04:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 03/10] block: copy result back to user meta buffer
 correctly in case of split
Message-ID: <20240427070408.GC3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184656epcas5p42228cdef753cf20a266d12de5bc130f0@epcas5p4.samsung.com> <20240425183943.6319-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_000412_261555_E0EEC30F 
X-CRM114-Status: UNSURE (   9.98  )
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

On Fri, Apr 26, 2024 at 12:09:36AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> In case of split, the len and offset of bvec gets updated in the iter.
> Use it to fetch the right bvec, and copy it back to user meta buffer.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Looks good, but needs a fixes tag.


