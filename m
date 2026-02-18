Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C70E9A03E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qV122xeRA8ORVd49r6sP+klEaOhurM7yPuWmxhD8R8M=; b=lhbfI4Bbo9W77QSxe2Q8PwF7TR
	13Ry2oa0yzu8ZYDnOtHkkJ4uyITexY4ITDjIS9V3ZAVkoXP5taRbLCUe2w6LPhatcy2zJG+bOHEhm
	6X5GpIUfv9tbM0/fP1i0khLcjjB2HurR1jpkH7nqeAMdLqSL7igUaXfiLyMfkEBahrBkqB/inQZdT
	vhm3h1G+pr8wOJkFhvxay53P6+5yNbpAySfPFcCTdD3kzJhQiLkzzdBZ9QFT75lOPGOnDe9P0pGOV
	6vuEgUEipe5rx+dKbgr8rcDTy9ckvjcbjMvz+J1wXi4xYMy9fuDLoPAeUxjbYs+S5IMFI+tS+aavK
	re6p/8xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vseIe-00000009bWN-3Riw;
	Wed, 18 Feb 2026 09:56:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vseIc-00000009bVp-0sQD
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 09:56:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1687D416D5;
	Wed, 18 Feb 2026 09:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62380C19421;
	Wed, 18 Feb 2026 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771408608;
	bh=2M/oHwf738t/3QfICnitZIlKcPZTFwrhHKLEPVnncmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgQ128kWu65YDpWegMGfZb53YMJOn37hIRSVFfGx+pX+XzlqcyAlnYaoU4+6+1DmR
	 RORpysuoN+2jc/iElKEHzTyrk0kzgPds9IeF8VxQJ+oNH9GOwItJ1Z3Oxdd7tUBcVN
	 gc5Nrt9uyY/DSO/rlnEeiwkHWl3ev1N5AM2HgxyK3ZUZYnYyxqmq25m1NcF14MNeOg
	 cCpyzWOtZJzVvtGzG8/VOLvy1VOmg3CHRMe8f06ebQMRHR55fCCvgN/TodM6lois0T
	 F2PEVMj7VwCi7XlgOy78HPknik2Fxg643Q0kw2U9PSjATb6snf0OTVTdqf2Er++Lkg
	 qhpQKFaFxakhg==
Date: Wed, 18 Feb 2026 10:56:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260218-haben-protokollieren-d4b5d2a1f8c9@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
 <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
 <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_015650_269364_4A989214 
X-CRM114-Status: GOOD (  13.60  )
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

On Tue, Feb 17, 2026 at 11:37:19AM +0100, Haris Iqbal wrote:
> On Mon, Feb 16, 2026 at 3:28 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > > (1) Fill out the following Google form to request attendance and
> > > > >     suggest any topics for discussion:
> > > > >
> > > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > > >
> > > > >     If advance notice is required for visa applications, please point
> > > > >     that out in your proposal or request to attend, and submit the topic
> > > > >     as soon as possible.
> >
> > This is (likely) the final reminder to put in your invitation request!
> > The invitation request form closes this Friday, 20th February.
> 
> Hello,
> 
> What is the announcement date for accepted topics and invitations?

We will very likely aim to get the initial batch of invitations out the
middle or end of February.

