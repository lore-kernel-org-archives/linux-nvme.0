Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF9CC6FA8E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 04:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dhd6767pQ9B4fmJY8pvrA4c98sBJmkeXewyhhMbkQ4s=; b=bMoL1VNuQvzivi0vzdYkh83tyF
	pRr0S+FALKTIt8jdi45VZae2MPLh9SGUCt9kuxoMk0IiZHEoGHl3vHyMaXHW5wSxUjKEeNgyYiUOc
	XsE9+7JmktsLlu2Z+jaKH9keZps0h1Gt85QmY2oD/O55Rf5uUSkSFgCb04ROWppV+FXTCCoibbohJ
	x4fcS2Jd8KFeiz/V8h9UfcMHiSv+58JFjHIf6hyJbxm+EETCz103xsqUPnFzB2IXvkwIb4sYEdQnk
	jnqRvRLKyq3h1ULSw2RsB6Ymk6Ze8QykqhVr4Ti1Y/CjyRjoiEKq1ZoRSmlzA/wCMjyr/hIFE7fxZ
	AJFZdy9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXaAi-000kf7-AS; Thu, 02 Mar 2023 04:04:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXaAg-000key-Co
	for linux-nvme@bombadil.infradead.org; Thu, 02 Mar 2023 04:03:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Dhd6767pQ9B4fmJY8pvrA4c98sBJmkeXewyhhMbkQ4s=; b=DArjITYvSyRA8hwykvEP9WXJRS
	FSstE4CI5Ao7wGT9SJo36E6PhD6WNQa49UM1tm092RTfZu2MHxwIMgDPo27mGW738B4WIWUIUjMge
	coMcxOzsZWBKfu7QrsLzkcuvoVM63BWJacq/jlGmEofbGS9RbxbB6/h4DG102NaW+7JlxE7zi84VL
	bAK0QmzKkH0mpxWMLdyN4FTQ+dV2YVs+NKbpzPqPBjMm3IcC04Ykiw6k9NhYTwR+6Hkia+tBU7g5L
	jIVux/M9owfywhctB/45gHDCIc4rM23sLyHKd9EGRhR9moE45oN82DBoyyKRoRMRygPLH4l8rRBjy
	0iZtDAYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXaAb-002A0I-Vi; Thu, 02 Mar 2023 04:03:54 +0000
Date: Thu, 2 Mar 2023 04:03:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZAAgKTWpwCE1fruV@casper.infradead.org>
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org>
 <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
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

On Wed, Mar 01, 2023 at 10:50:24PM -0500, Pasha Tatashin wrote:
> On Tue, Feb 21, 2023 at 2:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> > My goal for 2023 is to get to a point where we (a) have struct page
> > reduced to:
> >
> > struct page {
> >         unsigned long flags;
> >         struct list_head lru;
> >         struct address_space *mapping;
> >         pgoff_t index;
> >         unsigned long private;
> >         atomic_t _mapcount;
> >         atomic_t _refcount;
> >         unsigned long memcg_data;
> > #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >         int _last_cpupid;
> > #endif
> > };
> 
> This looks clean, but it is still 64-bytes. I wonder if we could
> potentially reduce it down to 56 bytes by removing memcg_data.

We need struct page to be 16-byte aligned to make slab work.  We also need
it to divide PAGE_SIZE evenly to make CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
work.  I don't think it's worth nibbling around the edges like this
anyway; convert everything from page to folio and then we can do the
big bang conversion where struct page shrinks from 64 bytes to 8.

