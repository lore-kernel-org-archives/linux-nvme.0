Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A3C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHkUC5sP2LvL+1U2WFSY7SrHAxZF/q3GgQcTVU8ixR8=; b=FXPXz/hWXLgAfRWoKJnGYM3EAt
	ZhW+TJCOVzpP8yxFu80Azufi+5CPkmP9BIX6CvHbGHvNK+Vxx47B+3E2CDTEAfJuTrQpwbjxFce7y
	OoXSTUhrcrZi34tj+1rpj+MOfAHVtuyALLrez9uPnk+FjNFuUfs620vofXUpCxGit5NSd1KtlrpLj
	ttrY84gCQTa7vS6eo69To5FCeBWeqrgmBiFvoTo1HaPdW6bGYRqv0D1VxQGnOlrcGHicEiJxu3Gh7
	0FrYFiieMHlYxJxRxQcFDb3/AZZ0q9ZCkXchBHjpNTRp/jHo+E3m3H8V1NITe2TaCngZ28EtYGUYb
	lGNr/n3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QCA-000000007IR-1pO0;
	Tue, 21 May 2024 14:10:26 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QC8-000000007Hz-0BKF
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 14:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 039EACE0F93;
	Tue, 21 May 2024 14:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC87C2BD11;
	Tue, 21 May 2024 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300621;
	bh=amWnjt4JjeCxkbq0DcmeXrYrb3QX2mJNLgyTI5kZlMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jt7rX7V87jSD6Pg/RJE+R+B+xHXjLuKsp7h91efnNLo9h9dCsX9mUCF9mvWRfzv7b
	 hRFiibRtI9BqRKbgP7fN12FIOa2sSx/qeC++FlkL9c6RVGAi5j9xsAoAgGFfF41tCN
	 hfNU2jjvFlwMSu2bNL3A9Yi7jmMGXdLLxZ5LgfsLXjMeivPKjy9vYJGYNQeOwdaNKp
	 PnXzASPuvJUcnjeHpQF6q4vqyNhrSjIVSkv8TJl8ZoNSeDEG2rwatv6b1r82UeXFDw
	 DXXjMzOz+vgS2wXujor3bQFJOuGK/bVZ50BFHvGKSPk+dbwAxIaxNJrCKK76u2rR1e
	 Nx0E71iXijzgg==
Date: Tue, 21 May 2024 08:10:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, hch@lst.de, sagi@grimberg.me,
	emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZkyrSqGQX6kQf7nG@kbusch-mbp.dhcp.thefacebook.com>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
 <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_071024_308887_17107114 
X-CRM114-Status: GOOD (  19.80  )
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

On Tue, May 21, 2024 at 09:58:31AM -0400, John Meneghini wrote:
> On 5/21/24 02:46, Hannes Reinecke wrote:
> > > +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > > +        atomic_set(&ctrl->nr_active, 0);
> > > +        nvme_mpath_clear_ctrl_paths(ctrl);
> > 
> > You always reset the variables here, even if specified iopolicy is
> > the same than the currently active one.
> > I'd rather check if the iopolicy is different before changing the settings.
> 
> Yes, Keith pointed this out too.  This is actually a feature not a bug.  In
> situations were we want to "reset" the nr_active counters on all controllers
> the user can simply set the queue-depth iopolicy a second time.  I don't
> expect users to do this very often... they shouldn't be changing IO policies
> back and forth too much... but the ability to "reset" the nr_active counters
> during testing has been very helpful and important to do.  So I'd like to
> keep this.  Moreover, this is NOT the performance path. I don't see the
> point in making performance optimizations in a code path that is run once a
> year.

I missed that you actually want to reset the counters on a live queue.
Wouldn't that just lead to an imbalance? If that is really a feature,
then I retract a previous comment: you do need the atomic_dec_not_zero
(or whatever it was called) since the active count is no longer tied to
the inc's.

