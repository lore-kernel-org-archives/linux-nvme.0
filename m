Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783A1C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zewDFwWKEbHocfzWejQlR8dUnRitTRtf0d/JGGE6FY8=; b=j8Je4/ZlE2wXGCxSeShaiDOXIT
	AAttewPtWkh8//CZP0iaCeao9nVRDuyxZv0bdtSxxBAiXrMLiGOxt2+bhCM7Bp8dk+DZKN2lgfKNt
	y/czJs8oE6vUryLql1BtFLeybTdWlSCKc5rmcDaLiHHoK6orjejYlWEdwrh6xw3mPfNtxTAE20xMn
	SxAfARK/q+09JTe7xpNmYHJy5/q5D30Z0okYBd2fPN+nHmFilsuoxFaHs8AzIsqfxE+ruZ+yRl9TM
	nbnbrxjJkx93c1VJqoKKNQa9KQLz8g7rFjAgEvRhZjl4cSQgyu2Fwa9zP25Ngk/RxhjyBGtVnnJ6C
	wUYhUeZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSJmY-00HIwA-1M;
	Tue, 23 Jan 2024 16:37:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSJmV-00HIvA-1O
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 16:37:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 34F6361E42;
	Tue, 23 Jan 2024 16:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F03C433F1;
	Tue, 23 Jan 2024 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027864;
	bh=HM1JWMsVS3aO+e6s9uXhxDnTkudCCSPnQhcGMX1cGFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb5AWblJDawhMPckj0n/uhVr4rgOADnQgZ5UPGOfnTJxxxVd2xfpVFVLsbMfrv+Gb
	 eTr9gVzTpkK3i+Z75/2P1PpszLQMH1CeiC4GqBp4v+XkGmQFpyL9ctc9GwBvkJFSP1
	 TYWXdPDqm4W8uZeG7HmQO9k8bJJfK9U2+EZ5buu+RAe3iKg3zHH6doBdeoBfsdRJzM
	 i8OZpYmAYUtlZ+wORa4kHZT/mYBKReidwKyMJsq/+wLORfV0I7NEovC/IpCnCAX2Sz
	 XSb0haeMEHYYKqdlFYb7DQmT0K2A9Vc/+h1Lka80zrcJieBAJkywf7EM4b95r7/kRx
	 U5Yrp0g9yMAAg==
Date: Tue, 23 Jan 2024 09:37:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Message-ID: <Za_rVS-0MEr2U731@kbusch-mbp.dhcp.thefacebook.com>
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_083747_510021_D7D81469 
X-CRM114-Status: GOOD (  15.52  )
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

On Mon, Jan 22, 2024 at 11:13:15AM +0200, Sagi Grimberg wrote:
> On 1/18/24 23:03, Stuart Hayes wrote:
> > @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
> >   			goto free;
> >   		}
> > +		/*
> > +		 * scan list starting at list offset 0
> > +		 */
> > +		atomic_set(&scan_state.count, 0);
> >   		for (i = 0; i < nr_entries; i++) {
> >   			u32 nsid = le32_to_cpu(ns_list[i]);
> >   			if (!nsid)	/* end of the list? */
> >   				goto out;
> > -			nvme_scan_ns(ctrl, nsid);
> > +			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
> >   			while (++prev < nsid)
> >   				nvme_ns_remove_by_nsid(ctrl, prev);
> >   		}
> > +		async_synchronize_full_domain(&domain);

You mentioned async scanning was an improvement if you have 1000
namespaces, but wouldn't this be worse if you have very few namespaces?
IOW, the decision to use the async schedule should be based on
nr_entries, right?

