Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B36BC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gCK+no/tAMPQVav6y8tjdi7pfi0FJtlO3vSnBySXg5A=; b=j8FcchVxmrXWtXUc3f8adisFX+
	UOkieEOg0DeWTirjgmAKLoaSUwv/XDNXxc2j2tSsr0FO72Rf0F08xshR9mGOpDcsfwf7wFSKX5pKL
	DrUZsHFC4yWP15e4EAvGK1HR7ZKnIbGQLmDLgIu9c4z4w8nwfaxBhRcyhbF9C6SVbimq1sF5uuAlN
	4ypIWU+nv32eLnV9+kS34LB6yd7YoTAh1OQ5EQn9bLtxWw0WQClo2IHJZL0vf8JrkB++Fl0QirE6r
	UEhg6vNdC+24mrBOa7V/J5PFl7R6tyDaM8ZBRLBe1vN9SSzrwksZWzl5UqAbnFVsxUC40vpYSaTod
	NRVhgPcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1if5-00000005ZfC-0Uk4;
	Tue, 30 Apr 2024 08:16:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1if1-00000005ZdF-3gjm
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 08:16:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1816560686;
	Tue, 30 Apr 2024 08:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EF0C2BBFC;
	Tue, 30 Apr 2024 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714464982;
	bh=N3+9SsDfJ97HXEmOTnUUvanWDw1MLedwYXFVC/l0vrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Afji1/QeWkzhkveOO4iXvrJU9JzTQlRm2/eD2IqaYYky7r+BJsD2drIfzIVAQbfm9
	 7gFZw2TyJiKJ+mQhb4/hHkwSahsM9ZR6EGa53WxeGnvJxG6za5X9Nog6KUKuqB6NMs
	 eZskyodeKsyw+nRQEtqEzJ9ps5qw3VrcTnlPMp0pVaHc8laEXrWJkdDBh4F+E+QbDn
	 99srpg1SPq0BYE9eZo2hn1+IVAHNqBtMXs8egAZgLePsJwt3nU7fxzxjNpg5IMSXMF
	 X2X5zvr4iNWb6KBwfTcHjb7COEHf5qazKG8buB8BR7ppBuvVNva3VdoxiLPZOKY5tx
	 vt6TL+z/3Yfaw==
Date: Tue, 30 Apr 2024 09:16:18 +0100
From: Keith Busch <kbusch@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: change rq_integrity_vec to respect the iterator
Message-ID: <ZjCo0rRZOlM_Ielu@kbusch-mbp.dhcp.thefacebook.com>
References: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_011623_993768_97FECDBF 
X-CRM114-Status: GOOD (  10.00  )
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

On Mon, Apr 29, 2024 at 08:37:26PM +0200, Mikulas Patocka wrote:
> I am changing dm-crypt, so that it can store the autenticated encryption 
> tag directly into the NVMe metadata (without using dm-integrity). This 
> will improve performance significantly, because we can avoid journaling 
> done by dm-integrity. I've got it working, but I've found this bug, so I'm 
> sending a patch for it.

Patch looks fine, but Kanchan sent nearly the same one last week:

  https://lore.kernel.org/linux-block/20240425183943.6319-6-joshi.k@samsung.com/

