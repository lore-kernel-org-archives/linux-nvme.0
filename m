Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AF4C76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89ejim99vJCRh8lEUYs4fYdoMNLFynX5avZZ+Re6/M0=; b=wA7/yDxtQsema8GSdooK0KdKVd
	6P4kpk/7I78esyXN42DKQVa9ufEyROQaEAd6QKM9wp4aF9SABnqC7RYh8j1yTKqjXnS746PXYRdLp
	6L+HwkOl9Iv3oh4jIXiIQDMJmpSwrsr+BNYfPt95CH0o9bKefHSjI9qtmvlrF/eUQ9rWnhQB60dAG
	/APi6tccVfqiPNrpyaifMbQwIQuRfTlpqLBVcrfc9hNwfupaucU8iB0s6jC58xNv47hrFyBpYmX5g
	ulhIGmCggtdpwvyVYs6iq3/wr+Bt2m2vjJUlHC9C19OcLWenEj3n8G2XEOyvei/PtwjrElvaNhDCm
	p9KyM3DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjLey-00FiOE-1S;
	Mon, 03 Apr 2023 14:59:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjLev-00FiNV-2I
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 14:59:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 97C8461A35;
	Mon,  3 Apr 2023 14:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885FBC433EF;
	Mon,  3 Apr 2023 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680533988;
	bh=iHxQ6TDni0DnO0ZD0cAtbe8dQJZb9kwWdQ0/MxSR+0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fSr1Cq8zdGVk3tXS9FlFWGl6+w7/vu1+ZS71orOg2F5IaV8brAss157RL1duL94Po
	 EtdZfuofj/suPv1Do/vje1jWFKrZ+T2aNHt12ohA71s5DBC1iC8W/ZDUQcSO7FZGEl
	 E4QVesBinTNggRF4yYvmDjR15itjhvKmMYI1NMfTEBo3PCFJx64yIv97EtarU9P/Vj
	 gmWk9hTwBH8npUeeebFBZCpvhDaRdjcci3N8JXCTREK+uwcneTUSkX+7I4+8HdnXZy
	 3y0/3nHR7vinrU5dx+si+5wgy9XWniygtDmHwqv6C27c5x4Znr8Ge9VPDkyHCzcJYL
	 M94T7nzr4WijA==
Date: Mon, 3 Apr 2023 07:59:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Boris
 Pismenny <borisp@nvidia.com>, john.fastabend@gmail.com, Paolo Abeni
 <pabeni@redhat.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Message-ID: <20230403075946.26ad71ee@kernel.org>
In-Reply-To: <44fe87ba-e873-fa05-d294-d29d5e6dd4b5@grimberg.me>
References: <20230329135938.46905-1-hare@suse.de>
	<20230329135938.46905-11-hare@suse.de>
	<634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
	<20230330224920.3a47fec9@kernel.org>
	<7f057726-8777-2fd3-a207-b3cd96076cb9@suse.de>
	<44fe87ba-e873-fa05-d294-d29d5e6dd4b5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_075949_805701_0D038746 
X-CRM114-Status: GOOD (  16.42  )
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

On Mon, 3 Apr 2023 15:20:13 +0300 Sagi Grimberg wrote:
> >> Some of the flags are call specific, others may be internal to the
> >> networking stack (e.g. the DECRYPTED flag). Old protocols didn't do
> >> any validation because people coded more haphazardly in the 90s.
> >> This lack of validation is a major source of technical debt :(  
> > 
> > A-ha. So what is the plan?
> > Should the stack validate flags?
> > And should the rules for validating be the same for all protocols?  
> 
> MSG_SENDPAGE_NOTLAST is not an internal flag, I thought it was
> essentially similar semantics to MSG_MORE but for sendpage. It'd
> be great if this can be allowed in tls (again, at the very least
> don't fail but continue as if it wasn't passed).

.. but.. MSG_SENDPAGE_NOTLAST is supported in TLS, isn't it?
Why are we talking about it?

