Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB2C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SJS0uk7AmpovIJF3iZheHcjszX+pL+m3ZxyUsJ1xSY=; b=vuHLlrYwfDgGN6wGzQXCvPW7Qk
	2/w6mBM33BWrLsWlM2oqzPt9Zqxk+ivs6QA2lbZbRQMBHHJOGaxeOjFeHjvB6f/b5JYF5ulLhkrgL
	b7SuQw7JJTJIfcJuXjNzFsu4kRvjQRGhQ8bNvNgB24Dpo9Y7nt8Dx31gfzyT6EAxdIw4MdG9PkU6D
	BmXyo1MTiqNaiXfjYYtvyMibA/mc6nolwbPhhkEFVNmEbcccCG7Z7m/aLyBmzbPuadIazSuW+17My
	Zq4ThZZgxYytb7tZ95ZJeKMdvnSomNcaeHopSPs5eXwjyA7UjAZNWU3oIolf7GMM4no0FWn7Pa/UE
	EHBg559w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOWU-0000000DJ5L-3siJ;
	Tue, 06 May 2025 20:04:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKdZ-0000000CZF2-2Hyx
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 15:55:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 54C90A4D635;
	Tue,  6 May 2025 15:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED659C4CEE4;
	Tue,  6 May 2025 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546916;
	bh=KokwTcsPEjcIZ/f64cPMglQ909nlpDnMzhPyZGYvzxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA/lDEym02kXPHJYYAshEh37VVEPXYr6h6uUOT3HR5v3gjEgKBOj1grHVWAuVgdtJ
	 8reM6KCZV5esAd60c4cIkLJo1L6p4kV6Roxnos9n5MjPW7xW/XLfQYonwyhmXvLFoM
	 9EI3HKKa7GNlohfqkWY+hAhP3v46T18EJBGhmMXzu49uqvTibHpMsanT7iWqsoHoqh
	 ecDC9NIr1t/MsHrIYhKdR/msNFEoAQHS1f8sa9oQR7tXwFKusOM38K7A7cjMzKOwEs
	 nQCLhZaGH+jh7whmh0N7cGYW2y2NP4M7dC3JhGvHmT9xJhTbyH5ljZTmmslu47n5Ia
	 hP7QgfInSFQWQ==
Date: Tue, 6 May 2025 08:55:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, dhowells@redhat.com,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506155515.GL1035866@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
 <20250505142945.GJ1035866@frogsfrogsfrogs>
 <20250506050239.GA27687@lst.de>
 <20250506053654.GA25700@frogsfrogsfrogs>
 <20250506054722.GA28781@lst.de>
 <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
 <20250506121012.GA21705@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506121012.GA21705@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_085517_649708_0748B4A1 
X-CRM114-Status: GOOD (  11.89  )
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

On Tue, May 06, 2025 at 02:10:12PM +0200, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 07:25:06PM +0800, Zhang Yi wrote:
> > +       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
> > +           bdev_write_zeroes_unmap(bdev))
> > +               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;
> 
> That would be my expectation.  But then again this area seems to
> confuse me a lot, so maybe we'll get Christian or Dave to chim in.

Um... does STATX_WRITE_ZEROES_UNMAP protect a field somewhere?
It might be nice to expose the request alignment granularity/max
size/etc.  Or does this flag exist solely to support discovering that
FALLOC_FL_WRITE_ZEROES is supported?  In which case, why not discover
its existence by calling fallocate(fd, WRITE_ZEROES, 0, 0) like the
other modes?

--D

