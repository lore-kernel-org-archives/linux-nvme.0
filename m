Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4FBC04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilZDQ3gO3WRFbyjKsCdBHSNTW+HmM2JZ+ueALYHIBAU=; b=e2XnZuwnlP730z4JoInDgL3HQa
	8I3JAj/m4zCTPEZYUxIPE+LeW79fz0mres/TP3HlAoasuu+ik6A2/QsrMjekcbFyOZw4a7UWJD1Zc
	wwHyN++Pp2s3FVDZ6Hn2Pg86aXoSuJwVXmWqsFmZ6JmijQtNXmBjT0dmPDN/okYETos2aWlj6JHnt
	SrIVi56BxP7EdxdF2noEWMPj20tcdS8O15Fl642ljpyhnGx8na7e4yfOq5FXZpGrV1AwFizj94IWT
	Oo70IWa8s2mT7YGjixQglgH4GkXJrRxStRl+bNASec4XkCattenYpS+WSwwk+l0EWvzDtAAzOoIAP
	qbIcc69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wAy-00000008vGf-0tOL;
	Sat, 11 May 2024 23:30:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wAw-00000008vGT-0bZz
	for linux-nvme@bombadil.infradead.org;
	Sat, 11 May 2024 23:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ilZDQ3gO3WRFbyjKsCdBHSNTW+HmM2JZ+ueALYHIBAU=; b=UeBYxAt85ahfW84k6/DSwS3fhx
	ZKOHNs4OHgXn5M4I2diIK3lICP6CzGJlFilBcJbXMZox1gCYv8x/uqKu24Dx5Z0mMqnVe6y2Mtb5F
	b0guprS/GMEMMitfkz2St6Xd9wnTIAbOJ5imkAvslr7kKP/uWXnuuSMhFvm8qremgWjEoqlpGUEqI
	+AmvqToV+72d8MzMePtKP53HbdZ28vHUVINfYg/tkOnspti6R8TwTRHm8U/1+r9gu9tsz2boqbPh+
	vqJ9UDGY1nIUK/FBIEbVtDkOiuBGa/i1tt5hnz3L43u4Qzae5uTupGvVrlaw9Kh1PttD8YglEQGcm
	kFejKWCw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wAq-00000006Bq9-3FLh;
	Sat, 11 May 2024 23:30:41 +0000
Date: Sun, 12 May 2024 00:30:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj__oIGiY8xzrwnb@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
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

On Sat, May 11, 2024 at 04:09:48PM -0700, Luis Chamberlain wrote:
> We can't just do this, we need to consider the actual nvme cap (test it,
> and if it crashes and below what the page cache supports, then we have
> to go below) and so to make the enablment easier. So we could just move
> this to helper [0]. Then when the bdev cache patch goes through the
> check for CONFIG_BUFFER_HEAD can be removed, if this goes first.
> 
> We crash if we go above 1 MiB today, we should be able to go up to 2
> MiB but that requires some review to see what stupid thing is getting
> in the way.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53

This is overengineered garbage.  What's the crash?

