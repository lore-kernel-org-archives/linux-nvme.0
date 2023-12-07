Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680BEC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=00TUk8R76ngHZK7mc1+vlsBb6aExfsmDnVvRh+WSDWU=; b=AHMvSxf9EHWY0R6j3+P+xrqHXP
	eONCC+KgIRvm5SJ4SIGDAMo0qwGLwYSgn0F/vhjzaGZiLoFV7xudCbHFbgYRecvMv3wjJrxmLfGUO
	NcydSdYTCl0/UH+KkvgC3vNsexTAlsYZuR16Rv475cKLIHf0vDp6BwdvaeUhNVi0dCXk2lx7/J1TI
	0oYPgHkxPFrbgPpCczswXI1CP0tXJuBjea8WBTZIQhP9c4Si2OU8apxPiA9133YfZMmNp890oA11M
	0n9f2xmmbSgRWbR62qSWjvuhTvyqxCG7jxuaOrJODJcMbLD/IMyNRV5G94zAsVPKkMzYESxeOscv0
	dwFH3IjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB2fL-00Bayy-2W;
	Thu, 07 Dec 2023 00:54:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB2fJ-00Baya-0C
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 00:54:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 63479B82401;
	Thu,  7 Dec 2023 00:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE5DC433C8;
	Thu,  7 Dec 2023 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701910494;
	bh=7NQaJczkVv5wrigtA1QaLdfOwqAzSDMCJYkOqBKS8no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOpGHcvP2acc+8l2aN2+Nrzd+A9ar1eqkWzpGllk3b4EM4LXWPb2W4PGAUL+lJwAM
	 bKM14QyBxYo4nECo1dITZVL7fzf6hAnMQ8UqF+PcHOlFn73bvspEHH0625NOEmrzhW
	 l0CD22MSCSgEhntr836Phts2sN4l0L8XqqwPA9IU=
Date: Wed, 6 Dec 2023 16:54:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Yi Zhang
 <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, Chengming Zhou
 <zhouchengming@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu
 hotplug lock in group_cpus_evenly
Message-Id: <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
In-Reply-To: <ZXEUyH/38KeATuF4@yury-ThinkPad>
References: <20231120083559.285174-1-ming.lei@redhat.com>
	<ZXEUyH/38KeATuF4@yury-ThinkPad>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_165457_249955_32CE3566 
X-CRM114-Status: GOOD (  11.50  )
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

On Wed, 6 Dec 2023 16:41:44 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> Although, it's not related to this patch directly. So, if you fix
> zalloc_cpumask_var(), the patch looks good to me.
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks.

I just moved this into mm.git's non-rebasing mm-hotfixes-stable branch,
so I'd prefer not to have to redo it at this stage.

Let's do these things (with which I agree) as a followup patch, please.
 

