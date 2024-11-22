Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E22E69185
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VS5hXNx/gLCpuNbXdnx0oKoiAkpf0HOa7p3lJsYi5Ew=; b=GpCa9N54nrEwpQsB3u7WEvLKzI
	nGcHkWe3w7B9p8AEBTteRgquvAzJ8ONwFnW97UImpBBgxCCAArqxliivojo84rfeB54pnpCEtmaB7
	IwQkzSNDEUZ80wPF5tWIZhTc1VZPQ0dzch/jr1g4SVOe8D2HK+ryR67iCD1Rp/TclOfcsh1tsl3Yj
	plS8+LD3Sp6f7aJxpqRJETf1wKwsS3FeQYeQ998OUP/wyeLsjSYblU/qj/EMWDm3+J2Z47Q3oUXJh
	MH9A8wdMCWjOFGndbGu7W6Cuw/0hTx43Gs4IXqJgrXw9HxoRommj9D38H0FptUW1H74n96E+LdNM7
	oxIQeL/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYDl-000000035q9-3ShC;
	Fri, 22 Nov 2024 18:17:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYCp-000000035er-1PZ6
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 18:16:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 159445C5A85;
	Fri, 22 Nov 2024 18:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B125AC4CECE;
	Fri, 22 Nov 2024 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732299394;
	bh=J6AjMBq4stUpxA1GLehzZ6jucYdaDMN+nmMzN/kGObE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABQM0Zy+hC+CzT2lz+t5Ov19yrZrilxlU+5hGcXh146NneOi2dORZxBpWZGgFK/9o
	 +f3I8XPFY/zKO5oTVo2scs/ywAX3p/hzaPN9MSiZAD72PWi+QKzV+w8pS3lx4pyaC9
	 9zfnV7RkcSytOuZ87K7gqoaGmkSto3cRgJGiTFiCjy0SuKDz5mZ/mauUPEytlyn/ww
	 qy2Jb57iaHgPMAYvq5QVMiAiO9dDren8Aeuz628ckSyWb7MRghiRz1h8fN/35er5AW
	 2eraQz2eQBJxiBXZVUjpSDTtt1mvjcXams244vhX8bhDfe4QK5K93kQ9QXgFKEtrnc
	 Cyl+ls1Kku5lA==
Date: Fri, 22 Nov 2024 11:16:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Bryan Gurney <bgurney@redhat.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au,
	naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name,
	bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <Z0DKf0fd5xCmcp5j@kbusch-mbp.dhcp.thefacebook.com>
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
 <4bd8f843-6dfa-4c66-9e42-cf4245166844@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd8f843-6dfa-4c66-9e42-cf4245166844@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_101635_415470_25D7D30C 
X-CRM114-Status: UNSURE (   9.60  )
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

On Fri, Nov 22, 2024 at 12:52:51PM -0500, John Meneghini wrote:
> On 11/22/24 10:39, Keith Busch wrote:
> > Anyway, we only use the one physical function, so they're certainly not
> > multipath devices here. We disable the CONFIG option because while the
> > nvme multipath IO overhead is low, it's not zero.
> 
> Do we know what the performance impact is?  Has anybody measured the difference?

It doesn't benefit single path devices, so any cost for it is too high.
It's clearly not free.

