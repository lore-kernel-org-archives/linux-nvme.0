Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WB4NzJKodbI+y2bqKp/frCweq/iQZMvWuAwrRDVsICg=; b=pkbOn/PMfxecjdCJLMMALYfdts
	vLL7IDejeYOqkAu0wqANJaEvzuJEwHaLUce+i1cPpSFWjMwGQ1xWHBJ8GlYFxNJgBRdSJc8cows1G
	OhuolgOEI5EtUlV8SXmokvq1drn++eaE6zBtqAYWZnIxBBYuXF1DzpE0g4ncQlzpj7ZyQzDFMT0AQ
	9V1NaCeFGSl+betz8Pir9g/mf+a8F6xJo6m3Lg5CcsOiUfwZrI4m4tAmhE7TClKOy2DBfZeC5vwlw
	Acib/IDMtmhpLYxmIluHwHaErEjo8oDmLBVtXTdONv6dsKIQahfPzRKyvV9D75rDnIli9AfXLZAo9
	7jgxL/Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o98BK-00BS6n-HU; Wed, 06 Jul 2022 16:47:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o988q-00BQkl-Rw
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:44:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 657BC61DB0;
	Wed,  6 Jul 2022 16:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE8C3411C;
	Wed,  6 Jul 2022 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657125883;
	bh=ETQIfKZ04DBpBTgbtjCsfZym+4EgvwaHflYjwEazCCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a74zkiUKuyq/dPmCUK9FEAfat7L9V4nkJmMHDcG04XZv1OCevAd/TOWHcu3ScUEI9
	 XYjssuU+EkcGFRsV98+R6BRrlaHiUwLtxN8+i8GJdkKMlJl7AHrW5yNYfuW49ZPMab
	 JxykKrwdbqEvxh6sGkdxhxQbloeWyWWuLC+wSmiNPow54vY+7OuewxziiGpZF/HeiP
	 z40s1HJReRpWl/Gl+CCGp/TM+ARjySJIBk3jmt7uD3cHUQHql4JjddJLOMDkwppk5h
	 efEDqiRu/gdTbA58Q3mTWHAGTEwKsEI7DLCVlkuO3YxpoZ+TLln/a1iqMvtZPbKl26
	 QgKvg8NeXsWjg==
Date: Wed, 6 Jul 2022 10:44:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.garry@huawei.com>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <YsW7+Lsy0ENSA/il@kbusch-mbp.dhcp.thefacebook.com>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
 <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
 <20220706161825.GA1962@lst.de>
 <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
 <20220706163434.GA2222@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706163434.GA2222@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_094444_989220_5B0C96BC 
X-CRM114-Status: GOOD (  23.52  )
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

On Wed, Jul 06, 2022 at 06:34:34PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 06, 2022 at 10:26:09AM -0600, Keith Busch wrote:
> > On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
> > > On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
> > > > Did you test what the trace looks like afte this? We're losing valuable trace
> > > > data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
> > > > don't know why it cares that the address of the field being read is only 4
> > > > bytes; we want everything that comes after it too.
> > > 
> > > Because accesses should not spawn boundaries of members in structs unless
> > > copying the entire struct.  If we want to trace the various fields we
> > > need to individually assign them.
> > > 
> > > Anyway, I'm dropping this patch from nvme-5.19 for now to let the
> > > discussion conclude.
> > 
> > How about this instead?
> 
> Maybe a better option would be to use struct_group().

Good call, I'd never used that macro before. The result produces anonymous
unions like I just proposed, so yes, I like that option.

