Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC3AC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5ro75AxUd8RHALazDERlpn5k7/hQGJie7Wk4eS1dkI=; b=amVbamMPoDuBkrvSBsOmQUydPY
	rQjlf6joVTKla4sXpe4OlCwQKQIPRun+LycN0+c6hvORwHlaZjjO3GAc3i4o5x5G7j+KcopDRc914
	hFKbfMKdrPcVAmwO0k0W+k9UjtuUQDj1TLOxlYTIwyqcFSLr7fIiWO948RPxfmWPLmoQZ7hGdSPKa
	eG6/WfcN72+sSCsYCCXtSymmkqAErHbb0u0/NB1BsDVpn00LX0TwjVq0N/jW/goCQqfClwIUyrlMF
	e6WMvAzS4y5+eOMdnDmfV20t3RKGyBhudkuaDqgRY3g33v+Fl8tHFHo7HmfgUDMU8OdokaiYRECUn
	3AOZ3ykw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odadt-00HIXj-O1; Wed, 28 Sep 2022 17:14:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odacJ-00HHgG-Mo
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:13:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B979668BEB; Wed, 28 Sep 2022 19:12:44 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:12:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Message-ID: <20220928171244.GA16907@lst.de>
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com> <20220927173610.7794-1-joshi.k@samsung.com> <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_101303_941026_DBE9FCBF 
X-CRM114-Status: UNSURE (   9.81  )
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

On Wed, Sep 28, 2022 at 08:28:02AM -0600, Jens Axboe wrote:
> Christoph, are you happy with the changes at this point?

I'll look at it now.  Too much on my plate for less than 24 hour turn
around times..

