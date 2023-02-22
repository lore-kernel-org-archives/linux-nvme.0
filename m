Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB34FC677F1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5y6qX3Fuo65wRTj3zzf610RVcAucqpu/CW9/Ffo/iQ=; b=ONs7CIjx+jD4kYNGOiBpir7Yna
	SMf69TayUzp00FJokUcTe5u45d0HdyeUOMhXEU+Qg7htMCVuZ3qc0ZKvIbnclBqNm7HpxxKT7BYCj
	fArY//3PRny7swmKdZiRVkPyueS+mQqjIK8piVujvt3C/ercLpfpBLjoQgLTec48lmri9i39Zt58N
	uzVPPVA444x9JvSUrO3i90mxWVgJRFLQs4oQJ1BUL9+ZIS9mkdWh0V41HQjlqxD3h67KtSrKCcJoi
	OHqC2Hodf6F6cVB0+o6bQrQvE6uxe5dKreE+1OrLmjka1c+aXYkKifdUdbLul38kh9XcxF4vyWVJ9
	EpfYOA+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUqV7-00Cl0U-D4; Wed, 22 Feb 2023 14:53:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUqV4-00Ckzd-Mg
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 14:53:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EE1E361474;
	Wed, 22 Feb 2023 14:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43F9C433D2;
	Wed, 22 Feb 2023 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677077621;
	bh=FHrTWbOnw2MWBxJqKEWmRBZVxIbkKnOkOTPhwQA/g70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAst0/gO0iYNRNUBjg+NzD5Ko8CuOcrKGeN5HAuz6HocXg1iEstvPZIY+YtNuJN8k
	 TrtyJYjNefnjhnlA9RSG6R+9FvcL582sTkiSJBeag/+b56WNqlXcY/TvCvLmb9tAW3
	 vN1ueckIqqAhRYvAfPrxFQAl2jVOr3cx8rf311p+zn/rd+NE9lYsllSRKHS3vksA25
	 AWFlipx/5yyuymKJ99oEjCJDfC1Rxnrnv1wbBXACXz6qS4LCguzz8+SvgMxTXUbaT9
	 Mds/YKXZigL0yAO0UoXvjUtiF3HQghCC1JmMa2R4rLQOzuuAUPDGx/GryZ4NASWubm
	 ar+lUXQu0LXmA==
Date: Wed, 22 Feb 2023 07:53:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: dgilbert@interlog.com, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	lsf-pc@lists.linuxfoundation.org
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Message-ID: <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230222_065342_795133_7AC15DDC 
X-CRM114-Status: GOOD (  19.88  )
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

On Wed, Feb 22, 2023 at 04:37:51PM +0200, Sagi Grimberg wrote:
> 
> > > I did not understand what is the relationship between aborts and CDL.
> > > Sounds to me that this would tie in to something like Time Limited Error
> > > Recovery (TLER) and LR bit set based on ioprio?
> > > 
> > > I am unclear where do aborts come into play here.
> > 
> > CDL: Command Duration Limits
> > 
> > One use case is reading from storage for audio visual output.
> > An application only wants to wait so long (e.g. one or two frames
> > on the video output) before it wants to forget about the current
> > read (i.e. "abort" it) and move onto the next read. An alert viewer
> > might notice a momentary freeze frame.
> > 
> > The SCSI CDL mechanism uses the DL0, DL1 and DL2 bits in the READ(16,32)
> > commands. CDL also depends on the CDLP and RWCDLP fields in the
> > REPORT SUPPORTED OPERATION CODES command and one of the CDL
> > mode pages. So there may be some additional "wiring" needed in the
> > SCSI subsystem.
> 
> I still don't understand where issuing aborts from userspace come into
> play here...

The only connection is that aborts are obsolete and unnecessary if
you have a working CDL implementation.

