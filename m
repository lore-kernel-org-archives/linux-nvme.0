Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E42D2F7FD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcKVoh+gS4jTs1j/l4oE2tS25y2sVhESsFLmIua8Fz0=; b=LMLnj369h2mSD5/EQRMQY7c4jX
	DfHh1awj5JcBcxqsWfb0LTspGyYUTfjSAeJIyw9nNFAFVeeZ5r3w76TZIEz5LfyA43wltrzKPgAs5
	9DPpE/DzXJUZ/dPBbtj//XDkJEpyM1dAkEb7p28eAF4Rw2RQlJPMQq9nn8PY4YDKEgl0U4p8Yw+/p
	z0kjoH+r5/+yJH7ukL+Nhdtp0sju275F4jmHomPmGlB14MTIOuQ460OQ9lyaw7U6LAGxCuYLYP9xP
	GjXaZ8wbT2SMznr+jvmLzuqHAjCsTTCOJK16dsNuTF0wSo6QYubW7O+ws3mniTz//GxEvzI+joktj
	97aX5GQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lfk-0000000E893-3WAd;
	Thu, 17 Oct 2024 08:15:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Le8-0000000E7UJ-11CI
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:14:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 660A4227A8E; Thu, 17 Oct 2024 10:14:08 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:14:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 10/11] nvme: add support for passing on the
 application tag
Message-ID: <20241017081408.GC27241@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113755epcas5p2d563b183a9f4e19f5c02d73255282342@epcas5p2.samsung.com> <20241016112912.63542-11-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-11-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011412_444405_7821D2FB 
X-CRM114-Status: UNSURE (   9.72  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I think this should be moved to before the user of this is added.


