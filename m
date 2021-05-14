Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB60C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 20:04:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379F2613C8
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 20:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379F2613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References:In-Reply-To:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J6gPnWmHO3Uzw4xc14lpHpYLrzAdr22a5wX45/rRyfQ=; b=dyVFweY7vUfQfgpUsPHHMjKbf
	GCulifytB+I8fS1Aa4X9uFGHlxgkVzTIu1egNBOChp/WzzYQGueafByCWbSHGQlQW0J3zC9AybCKR
	oqMDL1dmDcQ6BUi+DkFnL26zJM8Uw65uJLZtt+s+8mUdVGZyLOjzx6IaT3kG0UqmqzkD4Estaf2vq
	PqAGccva25BN2pQZfn72f2+LvCDwfRdkA77uTkwj8ruqczx5B0rL5B7J45BW9lBhU+vIfrijXAn/Q
	mYoBQW/SELj24ZeeasKq/63PxsUxlFz0GUEiwfVic4/hzotWj0vgdMMHdio/wHPyqh64O7+ezuZMg
	4zJ9lOuKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhe2m-008trq-Mh; Fri, 14 May 2021 20:04:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhe2k-008tri-Dy
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 20:04:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=E9YNoc2u4aHJVAwRc8IfbePnnshaE6hk3km7pg3eMWE=; b=E2apzwRxbm9fU0QSCWSe6KQ4bw
 i6KUMiWkEFINfjqFat6i8difIEc7tD6SNWI/jcvMtbEXq3g61WgmDs6bFMXDQATcKE7Z2QzD+eT15
 pKkGlMlA3EEqmyWMSdUBr/K6lAgUQgStUFw0lQHA6ecJd3gLk66VFrBLlClQ3ZXzo4EfyMyoBpl6k
 WZURXxNhB3DgERsMg2C8DrkvXrrRtgTKIWimsEykb1/QJkENTVx0/AgaB7IXVtBXRTz2OcBrqq3sv
 78cGmJUWMcWkyJYFUYcZ3hOoMPjg0oNV0kXgwumPR2SsNzqNrJ2vu34K3Et/GbGe28zc9gHgUhIGv
 SzqfWMqg==;
Received: from galois.linutronix.de ([193.142.43.55])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhe2h-00CDvw-Pz
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 20:04:17 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1621022652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9YNoc2u4aHJVAwRc8IfbePnnshaE6hk3km7pg3eMWE=;
 b=pSoyUe5BgY9RPZs4kiNns56WDgqEeJKV43FsAYITJ0CFP27R8C5r+YwXsPjRed42XP0xWT
 13agdBDWMo/274PxHWpJOkhWFN8qVXaFRlpBzIpvhKId8vb/wX3h6ll5niVzL6rdpUJJlm
 1rH7UC83Dythl5B9j85Ah6FF+Gp4rZw1x1yCkEpxCmUbI+r8PyB6sHPeTNkbcYLxdng+Q6
 U4x4B0dzVEHU7ttzztNkqa/mvQ6YXILf2sYBbbiazXiyyJcdvgs9h6ndsuDmQVXpLLHGU4
 p27LSbVZUxW7X8K8nnpRmvbbH92cex7XN2scBjN8nLi750ih7HtIHRsAIwVeTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1621022652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9YNoc2u4aHJVAwRc8IfbePnnshaE6hk3km7pg3eMWE=;
 b=V3zHiKzMoWd1KNGnMRPJRdgO4tIZV26Y7W+thUxrvHwdUwTNI1l73bKhyvY807licquTcl
 bq0U2uSNwuzqTBDw==
To: Yiyuan guo <yguoaz@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: A possible divide by zero bug in alloc_nodes_vectors
In-Reply-To: <CAM7=BFpye1oOmF_ddVxDLGZebQRgpRORxN3J4sWcSgkq_nnYyg@mail.gmail.com>
References: <CAM7=BFpye1oOmF_ddVxDLGZebQRgpRORxN3J4sWcSgkq_nnYyg@mail.gmail.com>
Date: Fri, 14 May 2021 22:04:12 +0200
Message-ID: <87zgwx2ibn.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_130416_007167_66E1463A 
X-CRM114-Status: GOOD (  10.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 14 2021 at 19:31, Yiyuan guo wrote:

> In kernel/irq/affinity.c, the function alloc_nodes_vectors has the
> following code:
>
> static void alloc_nodes_vectors(unsigned int numvecs,
>                 cpumask_var_t *node_to_cpumask,
>                 const struct cpumask *cpu_mask,
>                 const nodemask_t nodemsk,
>                 struct cpumask *nmsk,
>                 struct node_vectors *node_vectors) {
>     unsigned n, remaining_ncpus = 0;
>     ...
>     for_each_node_mask(n, nodemsk) {
>         ...
>         ncpus = cpumask_weight(nmsk);
>
>         if (!ncpus)
>             continue;
>         remaining_ncpus += ncpus;
>         ...
>     }
>
>     numvecs = min_t(unsigned, remaining_ncpus, numvecs);
>     ...
>     for (n = 0; n < nr_node_ids; n++) {
>         ...
>         WARN_ON_ONCE(numvecs == 0);
>         ...
>         nvectors = max_t(unsigned, 1,
>                        numvecs * ncpus / remaining_ncpus);
>     }
> }
>
> The variable remaining_ncpus may remain 0 if cpumask_weight(nmsk)
> keeps returning 0 in the for loop. However, remaining_ncpus is used as
> a divisor, leading to a potential divide by zero problem.

How so? It's guaranteed that there is at least ONE node which is not
empty. So remaining_ncpus cannot be 0.

Thanks,

        tglx




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
