Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B98E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5t3WINfmpl6qeP57QN3uRj4igdODIRNBNLbjh+/Wgnw=; b=0WqnIpGv3DJq9qop6d21Apm0Ab
	Jw2RMKOJBrEb5QFGPCY3/sn4eo+NxclnI37h1yW9DNWUNyBOd4jyXgZWkLylQPE/24jbX+he2Mnyg
	/ntTv2F0mUIhz3IsWmwgdLdbxjCe3bO08ddlg5ngvVTFYJoqQm//TgW1d3bYqsTVc/8UwZqAdqBnc
	vphQ5x7ILrp9Q0xyv+GaM+n0Xt4P1cqgvDQmsLDaj8dNGwCWs01BeekdQ3BAGLkEFJ9Q2FBeqjIoG
	j07mJGb/12FcR3bRVu4gwJ4qhqkAkBLk163aOSfgOAsagcPB4Re9ATj/9ocZ5h7zx/jBvBe+BrYE6
	snhQ6hEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYrF-00000006r0d-0lfz;
	Mon, 09 Dec 2024 08:11:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYkP-00000006pGT-2TOr
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:04:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E98C668D0A; Mon,  9 Dec 2024 09:04:02 +0100 (CET)
Date: Mon, 9 Dec 2024 09:04:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Hildenbrand <david@redhat.com>
Cc: Simon Polack <spolack@mailbox.org>, kbusch@kernel.org, hch@lst.de,
	linux-mm@kvack.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org, 'linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 6.13-rc1: Loading nvme module leads to
 mm/page_alloc.c:4727 __alloc_pages_noprof+0x321/0x330
Message-ID: <20241209080402.GA24898@lst.de>
References: <5fcdfd16-d598-4a86-962e-9d22b0524b12@mailbox.org> <81b0b8bf-632f-4f71-8357-41ebf7421919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b0b8bf-632f-4f71-8357-41ebf7421919@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_000405_763675_F7DE09B6 
X-CRM114-Status: UNSURE (   7.82  )
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

This should be fixed in -rc2.


