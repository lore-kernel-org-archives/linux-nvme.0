Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8357CF5389
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYwRzLzRzcZrl/Llh8TesXQUm64MJYtsDo95APBgzT8=; b=eba1whSI5nyr2c4Bi0RQAQGkha
	/x7+hLPmcBzkJVfQn1qEG53mR+ucapb035NxMtHr/0uf0HUPRFAtgjudbBAoRinpO/D2XS4MLcrX3
	Qzyw7xZGhxIzfy4vuwpOkneGLTvaa0KzVO0rEbJ3jDrtmUBUmZYZ2BYrOKR8aDdd7aWh5yk1e1BuC
	NLXTxwXaxRHWdygBh02AtthNkjFgtxMA4L9IhkTWtR1QFDElLxDEoP20iDAVxwsKUjY8Otr+sIK8E
	0Lw+44Hc1jBzMtZhIS7/Nv4/XtHeWa255RPq1MaEw9r78d+iiGuYGynqc2Clmxh4NULRLUZQe5Jhr
	+Thr0kcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bJr-0000000EWfE-1tg7;
	Wed, 23 Oct 2024 13:22:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bIZ-0000000EWOE-3pBW
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 13:21:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C59865C2DF4;
	Wed, 23 Oct 2024 13:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A2BC4CEC6;
	Wed, 23 Oct 2024 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729689675;
	bh=oPMF5eJnTUpco72F1qb3rFruMDG7TsU4AKy0tlD756w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Clz+55dGkMvAxNflcKvLWW5igkOzGRi150WG66rLJqnWZIVngqq1qnFO+wPtu2GXd
	 Mjj8FCAvUZCosSh7dnR+f0q6vbEzl8I+NJbR8NNY0GmjgxfXeZre1YACzjuSc56Uxd
	 eRAhd59U3rdBRlr/YNP4cbrAkdYz2pn3OGGYMK4qzFivrmpbGXnaygXzr5u+R2i66w
	 t0PExkNI73PUoVV4YpSkkRIbdZOuFLn8/0wmrvv1GyBQzwswpzkjuelViqQFIRAtoD
	 9fam2K90vxuPAru82lgtR6WW+XSQT/xTK7bLi1lRP6g0hiYJjUvM3D+n4W8mStPlTP
	 eINWp7FUug/bA==
Date: Wed, 23 Oct 2024 07:21:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
Message-ID: <Zxj4SDRxSJfca_Wa@kbusch-mbp>
References: <20241023100915.11263-1-ikegami.t@gmail.com>
 <ZxjwAsny4yOUHvUD@infradead.org>
 <Zxj2rPzTGILnrUup@kbusch-mbp>
 <Zxj3xwDyP1j8Y1Ms@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxj3xwDyP1j8Y1Ms@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_062116_038876_818FFFE3 
X-CRM114-Status: GOOD (  12.26  )
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

On Wed, Oct 23, 2024 at 06:19:03AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 23, 2024 at 07:14:20AM -0600, Keith Busch wrote:
> > You can't just have a patch declare that PRACT works this way. The spec
> > says it only works if ms == PI tuple size, otherwise it doesn't do
> > anything.
> 
> Well, that means the patch as-is is broken, isn't it?

That's what I've been saying since v1. For some reason that feedback
isn't getting through...

