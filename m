Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9BDD0BB56
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mcVmpVxXaPlfof+xihcCDoYFOuyjht0sgCO0aqzuxk=; b=mhfW5V08BsMwkLTyVVUb2yuYe7
	p/peBTK1KDuaOmpXJFn5R6jmCXA3tGhkDQLpVbiKqNHtD6zzUbgEYz/g+ex2z1Erytgi1NBXF9Tk3
	iKnuPd0peVJVSDDZ8gygoaqtkJluaKmnHWAWgz/HZk0ZwgyFGkMmo9CDdll4sFFlXrfLyao+JVfob
	jlhwcm4JEMuHPsADL704EW4cLPY01KGRC8UjczAibN98p+d3bT8hhDJgo1VAF2/0BYWJua18hTKOK
	RLmFEuAJ11GUUKtSLHvyk0WnKqF8lnXC+dWxCGOnPbA3Kb59nASRz50J6Cct12Au8AVUIjjWEf+Oz
	Ek16/EeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lyp-00000004Abr-0tyb;
	Fri, 25 Oct 2024 15:11:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lf6-000000045W4-16yq
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:51:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 48DBAA42FEC;
	Fri, 25 Oct 2024 14:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BD4C4CEC3;
	Fri, 25 Oct 2024 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867894;
	bh=9mcVmpVxXaPlfof+xihcCDoYFOuyjht0sgCO0aqzuxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSEByDXvYMyRq7DhEVO3naYht5rUMqxj7hPL8CSMQ85jR8NfpXTd/n/FNN24b8opw
	 VPhn1V8fhysYiY8jwv5w7W6YdDXQ1wWq8rQdUck+IQZDIO3PY1s84wlYCVMrI6PuVF
	 ZG4n69+cX2VVooGF+Uwpfh5ID/W4pq6lD9MjNlBUcRTKEGPcCVXkZxc/gsrYnCO8rK
	 vgW28SlpKS/MNZHztdLJwQ+hMj2TDwyQh93wGjrB5AXWbVIkbTlB01rsz8oA81JXS+
	 tNf5pCZ8J6wJ1Mn3B2HcuRsI0yEcRaU1SAZeqld4wX9yG2ZWeaZvpN8qccf6HD39FI
	 gu6XKsZm1OKcg==
Date: Fri, 25 Oct 2024 08:51:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Message-ID: <Zxuwc_OtTdA7MGOV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240917061226.GA3839@lst.de>
 <20241025-00843e9e2d8919dff345b0da-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-00843e9e2d8919dff345b0da-pchelkin@ispras.ru>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_075136_407615_5917A23C 
X-CRM114-Status: UNSURE (   9.42  )
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

On Fri, Oct 25, 2024 at 04:01:18PM +0300, Fedor Pchelkin wrote:
> I suspect the patch has been lost - it's still missing on nvme-6.12 or
> nvme-6.13 at git.infradead.org/nvme.git.

Thanks for the ping. Patch applied to nvme-6.12.

