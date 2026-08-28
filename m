Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34E0C61DCB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZ/IsdkrJt6Fp3crYp4kgh0854PP4AChkSSVrmJfysQ=; b=Oqi9tvhtNR6Tbiwvx10ATuTUD7
	hk+MopXbXxk/WNOLS898xdx9FhPH4Gdnn6R0+kjseO4Ttaj0Ur4rKWgZkwYBTg0ccxTN2VtNZB4ML
	5dbXFckjY5321Aa69V1kCnduYezAYtO68yCxbaCF0PbKZxju/J7n5gY2A+K38zTO/Br+zzupHto0y
	Vjk1AIbaVB0621xnK30HLh+WBLLHzNZmw5trzzHtk0RsAYVw4Luhr7tio8CTQPnzVpffrhzsxrfcz
	gKSAyhM3UjUu5Mc8dLNmx9FwJ656lJSRDLJSM6d2g7h6smEH5pdLMdgyRJ2El/ytfkW6rQvIbL3RS
	XvhR84Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzxxv-000000061Vf-3RBn;
	Fri, 28 Aug 2026 14:53:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzxxu-000000061VZ-0Nqb
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 14:53:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8109E43CD1;
	Fri, 28 Aug 2026 14:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFE81F000E9;
	Fri, 28 Aug 2026 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787928837;
	bh=LZ/IsdkrJt6Fp3crYp4kgh0854PP4AChkSSVrmJfysQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JYFI+7AHi/A5rcPzV9Sq+eksWPj71eEeCVbl0dyB/gtTzZ9MUfdRO0Mgu/cCe6ukT
	 uajvhT5NRnjrkeJAGDeXFTKkHoxfJ1G3ylJYgYq9/xJYJsIs7z6chm3DWAY4dAOIzv
	 M2tyOdPj3wR9AKbyJzNrFGxkW2maKjPs5/+9xWtl18H3p+6C4/epR6hwqcdg7JFLog
	 vfd5IWlQhsdiM624QdM7e2soTEe40vITgm2odKvY0oMY8o9tmIasAGgT1LP5Lc8dhf
	 z6pAP3MJD0FQ6wqb2zv5kpMJIJfRxlVPq1Td0DgX64GNzxp+QLJF4BtxQrFjxnxX2p
	 VATsVhKbd1nww==
Date: Fri, 28 Aug 2026 08:53:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix command effects log lifetime for multipath
 heads
Message-ID: <apGhA1nAgf4Qw_el@kbusch-mbp>
References: <ao3mNp35Hg_0MDlR@kbusch-mbp>
 <20260826075543.2654816-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826075543.2654816-1-sangyao@kylinos.cn>
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

On Wed, Aug 26, 2026 at 03:55:43PM +0800, Yao Sang wrote:
> Hi Keith,
> 
> Thanks for the review.
> 
> Do you mean the whole IOCS entry should be shared, including CSUPP?
> 
> The Commands Supported and Effects log is controller scoped (NVMe Base
> Specification 2.3, Figure 206), and CSUPP reports command support for that
> controller (Figure 214). Zone Append, for example, is optional per I/O
> controller (ZNS 1.4, Figure 9). That seems to allow different paths to the
> same shared namespace to report different CSUPP values.

I don't think we (Linux) can work with a multipath setup where the IO
commands supported are path specific. The path selection criteria is not
based on the opcode.

