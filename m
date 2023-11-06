Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD816C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ztGsjL2F1fQeDbLDLlTkxQ3sP5uePwO5xGuFQg7wqtQ=; b=zaObE3jWWg3MZ6m3e0JuMIVEmK
	xXSKPT4bOg1gUxdYYoLDHQ657JW0mgKJeYzMqkOdq9/+guGYBys3J/TRX5/h+4C4cHhJbnqu0hfhl
	nmu63QKILaMMGvUzZwiysBLxnXOIKMoVnH/m0FRqBnaXfAMGQMOUXCOFZx5L656FdDbhx4cY7RWVV
	ELAyh+qaEMx9Z2+DX6CdTosj7qGC2agvdQ87tXa97EZCxoZkyPntjmpR2li6ItqrZLJdBvRa5zy7E
	k3A/OWasGKXvSlHwZYcjdgFBvOOIODKwYgcZQ7/c0P1dS0smV+ESv6WOzpZAztS3cZEgwTabfsmEm
	7OHRe+Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0183-00GwVK-2F;
	Mon, 06 Nov 2023 15:03:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0181-00GwTx-35
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 15:03:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 02D98CE09AE;
	Mon,  6 Nov 2023 15:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A33C433C8;
	Mon,  6 Nov 2023 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699282978;
	bh=mdnasKN++L7iH5e6EPZzJn9sOH6/oy4ZkzaDKp72Z4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IU6+zLStHSVytMX6tJg1kzHdIVLIwVf+659Kn3Bsd27AgQ6bgN0FVk0a/m6EtZgir
	 Z7eL6fs21SfS2wj7A6a6altos0BNWVgUgcCZRa8aHcVTQYF4Bbq4iRjOJc6bFj2ihW
	 FuVegkxQSDOLaFhZA/IBYcLnobbcGy8CjPxGJTS6MNlWRxjWVivIfhba1bw+WSLktq
	 46O/PPGqCzA8gipo5PV7570BE8sGSGWdSScplcVIt5UJ8TkH0eNJkNSebLVuMw9AoO
	 fi5tsJpjgTHOqo9oowhWEnX6SwKhDD0VaFzkpj/Ye4ZzvwI6KgnRihNVPEb1+49Ngo
	 APyeIf7R+RqZg==
Date: Mon, 6 Nov 2023 08:02:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZUkAH258Ts0caQ5W@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <CGME20231027182010epcas5p36bcf271f93f821055206b2e04b3019a6@epcas5p3.samsung.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <40ac82f5-ce1b-6f49-3609-1aff496ae241@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ac82f5-ce1b-6f49-3609-1aff496ae241@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_070302_170487_F54B9D36 
X-CRM114-Status: GOOD (  11.94  )
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

On Mon, Nov 06, 2023 at 11:18:03AM +0530, Kanchan Joshi wrote:
> On 10/27/2023 11:49 PM, Keith Busch wrote:
> > +	for (i = 0; i < nr_vecs; i = j) {
> > +		size_t size = min_t(size_t, bytes, PAGE_SIZE - offs);
> > +		struct folio *folio = page_folio(pages[i]);
> > +
> > +		bytes -= size;
> > +		for (j = i + 1; j < nr_vecs; j++) {
> > +			size_t next = min_t(size_t, PAGE_SIZE, bytes);
> > +
> > +			if (page_folio(pages[j]) != folio ||
> > +			    pages[j] != pages[j - 1] + 1)
> > +				break;
> > +			unpin_user_page(pages[j]);
> 
> Is this unpin correct here?

Should be. The pages are bound to the folio, so this doesn't really
unpin the user page. It just drops a reference, and the folio holds the
final reference to the contiguous pages, which is released on
completion. You can find the same idea in io_uring/rscs.c,
io_sqe_buffer_register().

