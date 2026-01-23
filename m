Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED75DD72367
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jan 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p3EPlpUGJunQoUGaaZM9trGxfnzW3diVZbJ43F4q9L0=; b=g0f/kV0bOh0r1NeUpBYyte9Rvv
	Aftvl/NFpvdcXlSVEiOAqwFtVyd4hugBKytppcawFjlL8p5MHtmBdeEBLZhpHrpMSIdj3+ItekOkS
	cA/lDo+FFq8I0Lola5arbdZvMmmqrTqfjDC1H0aQmn0T59NTr5VXz527Uu1jywqm46O+N8B3T0Urd
	Tzf/RWYvZbjEvuN4BF9WcFHyKutS7fZW0EGstb3SAtylmZUQignNj9pNYdtKd/9SW1r8aFQmlFfAP
	/8GzwSpXch1rl/YWCBR1ldl4SM/sFzy7gEGpyhr0vDAs/HQz5o3IZTGgj0PKGurXLRV1D1RT25LJD
	B8hVkRWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjEDN-00000008hmm-2H2F;
	Fri, 23 Jan 2026 10:16:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjEDI-00000008hmH-06Na
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jan 2026 10:16:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D49260136;
	Fri, 23 Jan 2026 10:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B969C116D0;
	Fri, 23 Jan 2026 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163382;
	bh=dV7OD68w4lvCtztzozVMpLB/2SClOxfAXtVQLTQ5gXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pirA/R+/2zZgeVASEHCvXJwdGfbcUhC/QEgvd4O6omiCCGSmej7CWGKARHZz93p0o
	 Hu+pwhUc+Q7HNGRU9x/u4IeyvNf7yyVpI/p1pvrANlSj0EkVexzyJoV5tNraPP+yYW
	 KDOesYJYyjdieoPLbcUbeS35UyO8A6mOYhMn/3qO7IP/NNL204fSii3deyrSaSieEa
	 Fk4XdbvOwBo/R4SFPulWYmVwaxbCZDE5DYeoTstZCsJplKcwrnRVJmnfrbThOkHu3l
	 Vlq2addVfCkNUBzg5NoLy85a04sbN5Mx4IOpJLQ27wyxWaMBJF5rNQzAqqkQuQQwLj
	 XgkVIHS/LzbgA==
Date: Fri, 23 Jan 2026 11:16:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260123-tapir-perspektive-e6466483739a@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260122032209.GE3183987@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122032209.GE3183987@ZenIV>
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

On Thu, Jan 22, 2026 at 03:22:09AM +0000, Al Viro wrote:
> On Sat, Jan 10, 2026 at 02:24:17PM +0100, Christian Brauner wrote:
> > The annual Linux Storage, Filesystem, Memory Management, and BPF
> > (LSF/MM/BPF) Summit for 2026 will be held May 4–6, 2026 in Zagreb,
> > Croatia.
> > 
> > LSF/MM/BPF is an invitation-only technical workshop to map out
> > improvements to the Linux storage, filesystem, BPF, and memory
> > management subsystems that will make their way into the mainline
> > kernel within the coming years.
> > 
> > LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
> > subsystem-specific tracks, cross-track discussions, as well as BoF and
> > hacking sessions.
> 
> Will there be an option for remote participation this year?

I did already have you in mind as a remote attendee and we will have a
solution for such cases. But we do not provide a general first-class
"virtual experience" as some tracks do not even want any remote
attendeeds.

TL;DR you're good.

