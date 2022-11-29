Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E26C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1n1otUJ71QBvuaqT7wcEAGP0tF5OVncVjP1tMZ9oOQ=; b=lLdcBTW0ItP8na7Zqh9HLoWAdq
	klq9BghtAjtA++UX1nrSrcv6Y79XQ4LOB5RbiV6OR3SqSKPNzxjkkyUSTgxT9RGSSlLwZbIsSsJMK
	0PIeCsj4BAaKhW8Bsj5w6GfbFb1l9LgNffuny5p3UOK4GRrN57Y7VAXEbi+BPnfMKCcJdb6b4DjIc
	rmNyWS6HFC2nCq6HcUImiSRFqwM5JWQvA5If1c665Q8FmyjBsPtTTusoOYtu1aMB9F8L7sZeqqk6q
	zF0AGAS7kva6bEVnM5jpQFQBqeHtYUjlhNdayzvhXwaKDCp18X4tBstswjKb3IsT8oOX+noKA8yYo
	VHUKo4CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwBj-007SSf-SE; Tue, 29 Nov 2022 08:41:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwBh-007SQJ-07
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 08:41:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4412468AFE; Tue, 29 Nov 2022 09:41:52 +0100 (CET)
Date: Tue, 29 Nov 2022 09:41:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lei Rao <lei.rao@intel.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Message-ID: <20221129084151.GA25609@lst.de>
References: <20221129014711.91305-1-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221129014711.91305-1-lei.rao@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_004157_208789_E4A7D600 
X-CRM114-Status: GOOD (  13.82  )
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

On Tue, Nov 29, 2022 at 09:47:11AM +0800, Lei Rao wrote:
> If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
> field is garbage data. According to nvme spec, the prp2 is reserved if
> the data transfer does not cross a memory page boundary. Writing a
> reserved coded value into a controller property field produces undefined
> results, so it needs to be cleared in nvme_setup_rw().

But this is not the right place to clear it, that needs to be done
in the place that sets up the PRPs, і.e. nvme_setup_prp_simple.

