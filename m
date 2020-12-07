Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E2C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:47:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EAC23731
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EAC23731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kvUKS0kMJCQtlgVFFqbW0H/5RxAvOc7nAScCnb6tK0o=; b=wmAsXaEkTkrCYMRzpYEzWPjYx
	Gs3QoqMoxUXkkvf3cS4KsEwUpRRXpXGyveztNGmaOiB4o4KndtG2a3JYFXtjLdTzqjBg4Jr0VapnW
	n1RAVkqaRoJdpAaLv/bTfgYB74MMthvj+FzYD1NMbVBp+j74c4LG/yJoKMqFSwLBbTv1gTCAygaDv
	HWhvC7hp4D2NhUMxT8JO560cCk17nGaunckMNPTe5SYGtck4SO1R8/bzh69jAwF9MyrUE7V8lfctX
	yas++/E78LkDT84GOl/ke2NwrX3p88gbNtlKSsHiFy/xUz0etDudlJtufJZg4fbj/LN49EPxSQL4I
	0Sc8jdjSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmIj2-0002eU-0u; Mon, 07 Dec 2020 15:46:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmIiz-0002dY-Ov
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 15:46:54 +0000
Date: Mon, 7 Dec 2020 07:46:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607356012;
 bh=vFl+7np9qKSpbf0v/1Q7c977xvRRSCjYt63RSQx6+3E=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=TEOf2pHg6ZTh7IuqRVOloJ67eRbcs5KmdDE7JaZnbQS1roYeZdCYAypRhumfGtyTX
 koKi+nRLRd4B3aaPl02HfPkdVUBjVr+KnB56I8Aj3I8+DmDmr055RGzXMfFo9TioGk
 7HHvdppwgduD1PMQftuS1HRfn7viIWgRb2iNxV301V6fejQh+QMw5xEO5WzHMpP9OM
 iUZnhtzBu1tQMCQXsOejnZJUMNM11HxxT+CaLi9OfmQo4CVyB+tdSFO3aKTRhzjpC2
 tyf+IVPgA6MnhsOVbBwDKnZ3oO2cVHQm3hjCx0wDU7zcy0sK/WbA9/V9HEJC4b1LR8
 Gzsvi2+Ne0HOA==
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
Message-ID: <20201207154650.GB3679937@dhcp-10-100-145-180.wdc.com>
References: <20201205152901.56665-1-hare@suse.de>
 <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
 <20201207153443.GA6236@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207153443.GA6236@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_104653_891884_3CE55224 
X-CRM114-Status: GOOD (  16.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 07, 2020 at 04:34:43PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 07, 2020 at 07:31:21AM -0800, Keith Busch wrote:
> > On Sat, Dec 05, 2020 at 04:29:01PM +0100, Hannes Reinecke wrote:
> > > If ANA is enabled but no ANA group descriptor is found when creating
> > > a new namespace the ANA log is most likely out of date, so trigger
> > > a re-read. The namespace will be tagged with the NS_ANA_PENDING flag
> > > to exclude it from path selection until the ANA log has been re-read.
> > > 
> > > Reported-by: Martin George <marting@netapp.com>
> > > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > 
> > This looks good to me.
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> But as I just outlined it just papers over buggy controllers.  I really
> don't think we should just silently do that.

Okay, that's fine with me too. I agree with you on what the correct
event sequence should be, but I just thought this looks like a fairly
harmless work-around.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
