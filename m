Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3208BC761AF
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvIExNpIc6oYJ4aSNMQ4oHJyqPAQC3EEu/lFHvSLVfg=; b=1T9JaCLVA7pFDv31tA8osHHe9I
	nWtUhriL/8Pnwyiaxuq3LzST98d9gFXPjgWsxlL2Bkqq5bCzXS//MC07+BhBthAabBaMzTYEJHP1U
	abnlXorcYUBMO0TF9lhYgADWzL2ixVky1S2jdwxe99PvY/RC9iDuNAzOcCRftz6QwpkPpvLrW3/Eu
	GGcL+YciGNy/6ZZDHMfqImLRJyr0Tk8n9nKld9+Vs6pkOaoV4tpsPhWg44+3ad//6Y67ab7DNJJOV
	kmsianjxN35AJg8ReQ6rLIBw0A7ybpuX4Mzr5g1MgbdEiz2mTzs8nQaJp4MyH32W+rzVOvC/tFBhk
	JJmyOyug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOwH-00GCtx-2E;
	Mon, 03 Apr 2023 18:29:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOwF-00GCt0-1F
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 18:29:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ECE08619C6;
	Mon,  3 Apr 2023 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B2DC433D2;
	Mon,  3 Apr 2023 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680546594;
	bh=aj7tqA5SlmHTRd4Ym5d9407t2OBYC+t6CFFC9FTCFWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GY8a8C/b9jrGZrLdf4XSdk49RgRSesgQ7hvM5mGec4mYFYvmv/K/OnA7QiNVK9vOb
	 AYwCVcxt+4dENqEQE3S4q9DmoWjYioYDgkr9O3wx90nJUIwT0YpFMwoqjQxL0LrLMX
	 o6hw1vJvrgGuLUYwImo5A6oO+/CXOLCPjw9S6BS1q+QFlLsO2s1obHN3uVjMayt65g
	 9ntaJzglJ+tEAPqDyjbtuzrnyEpZq3jiPbCj09ksbGFx5Gq2sbH9KIYisMMHiAhfyJ
	 4iOgmqo40Lb/7dWhATVSAV3XCij4XFeCg7C7G4T8uy1Xn25m0WoQOVq1MYIIbq9mHM
	 eBnixnjnZMd1w==
Date: Mon, 3 Apr 2023 12:29:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Laurence Oberman <loberman@redhat.com>
Cc: minlei@redhat.com, jmeneghi@redhat.com,
	"Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Issue with discard with NVME and Infinibox Storage
Message-ID: <ZCsbH+kipS2fbV2h@kbusch-mbp.dhcp.thefacebook.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
 <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
 <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_112955_461573_1AEBEB2A 
X-CRM114-Status: GOOD (  15.93  )
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

On Mon, Apr 03, 2023 at 02:18:21PM -0400, Laurence Oberman wrote:
> On Mon, 2023-04-03 at 12:00 -0600, Keith Busch wrote:
> > > 
> > > 
> > > Let me know your thoughts please. for both issues
> > 
> > The commit you found unconditionally sets the discard queue limit to
> > the
> > reported DMRSL, so it sounds like your target is reporting DMRSL as
> > '0'. Prior
> > to that commit, we'd use that value only if it was non-zero. I hope
> > that helps.
> > 
> 
> 
> 
> Hello Keith,
> Many Thanks as always
> I will inform Infinidat and have them figure this out.

If you have access to such a target and want to quickly verify, you could run:

  # nvme nvm-id-ctrl /dev/nvme0

and see what it reports for DMRSL.

