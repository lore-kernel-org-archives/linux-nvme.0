Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C981C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWGDf7TcJzKDmyqOebxGkoxhuMybSAnvxFIixNLjBgc=; b=acrO3UsEWhfOu+TCBKySYaKcyI
	BukLUwqawImEK9lQphJ5XXkSnC3Dya/vpRHpL8OGV9dtsYXRi1jWMBU5ph3za1N/sNDHHvI6N0kqA
	jaL6G/K7UymUjbAp+vi9gMTKw/jyo3POilxr3+C4+rG9QjzFeOyVO/63IBvuwN7qFnrGk+D4Of8va
	H8DWKh4+voiojoqXePOJU3keBCKM7jQWnM9asoD/r49UTFwdJKLcxHdivTSfYV3jdIETZ+i5zxmZQ
	cgUx7GNOta5wb0mr+dEun1oCN6NhiKIa4O7/tnlfq2qsayG5s/3J1AHweO3XGolSAhBzzBkuz4uUN
	3UIOYAdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5CI-00000009eVB-3fbR;
	Tue, 11 Jun 2024 17:22:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5CF-00000009eRP-2dbf
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 17:22:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A7312CE1128;
	Tue, 11 Jun 2024 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B9C2BD10;
	Tue, 11 Jun 2024 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126527;
	bh=OYSPTY6E56yAcssiecMZz3By0s5MpBDcS+5AMxOh6so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRDHzjL7D3xE8PUkuGQA4bPQdrvsSMfpEOB+dpCGgk3/h8g7NdmokAEBLs1z06cQV
	 fQoKmLGCEWEs0sKn2J3bAAF0H1+7GWUivdJszHGodzwa0hJf0qu906pWNEBfLjP0VX
	 mQNA7Kd8Ng4FBeJ+j+Kl+nwKBk9PRW1T2T2KvRgqLZxpDnOMJ+JBptXGUu8gmzKtRR
	 k2GBZKj7/6/sxWtTFfPn/EuRQM5xOb3kpef5TEClhRlJpc6pqR5cFeakkvPlTfdvSB
	 OfeAdTyQ/3we+RfM4NwKTSBnThxF8hzBtgjfdK/U20wYszFTlLlsXhLc5A1/F3EyuH
	 q3GWqjilTFP0Q==
Date: Tue, 11 Jun 2024 11:22:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611163955.GA12787@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_102212_052248_6559432A 
X-CRM114-Status: GOOD (  17.88  )
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

On Tue, Jun 11, 2024 at 06:39:55PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
> >  	mutex_lock(&ctrl->namespaces_lock);
> >  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > -		if (ns->head->ns_id > nsid)
> > -			list_splice_init_rcu(&ns->list, &rm_list,
> > -					     synchronize_rcu);
> > +		if (ns->head->ns_id > nsid) {
> > +			list_del_rcu(&ns->list);
> > +			list_add_tail_rcu(&ns->list, &rm_list);
> > +		}
> 
> Is this actually valid for a (S)RCU protected list?  If the entry gets
> added to the new list before the grace period has completed, we could
> trick a concurrent traversal into following the new list unless I'm
> mistaken (although chances I'm mistaken on RCU corner cases aren't that
> low..).

Good call, you are absolutely right that a sync should happen between
the del and the add for readers to consistently iterate this list.

I might be able to weasel out of this though: our namespace list is
sorted, and this function wants to append everything from this element
all the way to the end to the "rm_list": a reader should get the same
result either way, whether if it was torn at this element or the move
happened without the reader seeing it.

Now if there was a way to rcu split the list so we don't have to do it
element by element...

