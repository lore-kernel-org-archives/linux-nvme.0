Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6E8C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Aug 2022 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Im/I+MVfu61C+yaWvV0A5EmJg39tF5lKNW8OPvQBPGY=; b=d27Mzz+CFm5zVcV1RRPTsKjNvU
	sYFgqDzgdWd5rMIhtJpe3WSJntYXW15wM8JrsFOt7AS+1LQPJ/rj3idlqQq8GP3fWaJGhpKzzT4ul
	nvxENCn4toklVbNVZ7ka2aqQVj7+2L0RTNWffkNWriYtb6BTBFy07cj9uE4zgB6pZWkmZ2qrMkmtp
	g9zQ4Am2KYQWd4+9vwRgR9igp8riXG1rdNhtJOUGDAd9inzvoUyL6llT2qRhIy4SZ0Ah/CrUQg2B7
	3Z2zKsFwHr5pa6dvSKk2q1YH8eh69iKvnRbLKvt8mea+xHJbNbQXEEzJV/Tv/XlX6YT/K86TFIKEf
	JdB2jjRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQr2G-00DVYG-Bt; Wed, 24 Aug 2022 14:07:12 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQr2D-00DVUq-Iz
	for linux-nvme@lists.infradead.org; Wed, 24 Aug 2022 14:07:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 59A5DB823B5;
	Wed, 24 Aug 2022 14:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C177C433D6;
	Wed, 24 Aug 2022 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661350026;
	bh=pkb5ev6dNm5ODa+mUlf+kqbiAoKtKNX6wNKZWLWlFGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDEa6mSzPuRDrH2rlo6ZW854gIMeDl2VUpUJ8Ne4QRsZxsTCiH3sw+GDfgTxvn4jS
	 /ZiCLdMJ0XJA48VvE4IpNAfucE5ulwhcjJPZe1a335BiUMNw1PLsX2zuyFoijX9Au3
	 EJYHbiSSSX1Jbk9YeSrTcTKOxG3ynSNV2F39Tkyd+CHo/sQkU1s8qNYnZo4bu/3GrG
	 XqwIDNFdn0qyKkY/6Ku873uHiPOu3muMo+UpbdAbPJG2nteAGFfJbgHzUUEOx6hkXb
	 vkRt33y2yiI85RzeUGDllMb7TWZARB4MwNdKRE41ta8u8wZa9+PRCutHDJaak4uKL5
	 9IzWhfdS14u3g==
Date: Wed, 24 Aug 2022 08:07:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Message-ID: <YwYwh5/zidDplnGD@kbusch-mbp.dhcp.thefacebook.com>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <a2f9fd7c-7562-a79c-0ee2-76dcb7dd387b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f9fd7c-7562-a79c-0ee2-76dcb7dd387b@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_070709_816193_989E4DDB 
X-CRM114-Status: GOOD (  12.51  )
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

On Wed, Aug 24, 2022 at 01:15:28PM +0200, Hannes Reinecke wrote:
> On 8/21/22 10:47, Ming Lei wrote:
> > @@ -5065,8 +5073,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
> >   	struct nvme_ns *ns;
> >   	down_read(&ctrl->namespaces_rwsem);
> > -	list_for_each_entry(ns, &ctrl->namespaces, list)
> > +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> > +		set_bit(NVME_NS_FREEZE, &ns->flags);
> 
> Why not test_and_set_bit()?
> Which would have the nice effect of adding a memory barrier ...

Sure, I think you can even make a new WARN if the test fails. It should never
fail in this path, otherwise we could mess up the freeze depth.

