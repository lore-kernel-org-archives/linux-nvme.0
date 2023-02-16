Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6528BC64ED8
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EPih0a5XBFEgM0pCTJPtB6Dvgz6BcE1I7U484LU9e8I=; b=N9slY4SkL7NfjWNxe5cKPeHoJh
	jwZKjvx8u8juxoGJotU33/ttIKoVS+M8h32eniKVxmyNTrt1M9FUbc98mGdTxIu1UYiY9J9otka8d
	KMXtL6E9p6Kx8+0HjzjT9GDDaVXXH5ymgjdfK1A4psL3ue/mYln5/evg7LS80/NSOD1P7zV/Qf8I8
	R5WwjvMjKXT8PRZZaTNK0SCsdXcnGF+O0u3rOzecE3ky29yqkR/eemoKguqctRg9O1eT2V7IKf+UN
	niF9nckyPYOMrV4Q/LxB+DqWQIT9VJ2d3oeRxVaoGhgn3hgn6ZJ2bjUcdzRNxN/hsOKhVXvlIj4PB
	TIcrwzAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSg2d-00AqE5-V7; Thu, 16 Feb 2023 15:19:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSg2b-00AqD8-6u
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 15:19:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C1188618CC;
	Thu, 16 Feb 2023 15:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0519BC433D2;
	Thu, 16 Feb 2023 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676560760;
	bh=aUBobFomaZu++V/z3TN862RlF8Gpj5REZIykBITcL58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqBVA10AXCjsux3YIwa2fodrNJHeOuFYmSuNljY3SNd0nn7UPAMH7WXZmWN8rPgyh
	 JKMBhblQLDcgQczf8qSepkGW7aAmEdyUDfCwLLAgYAbnaVF6eklPJgf/cZNK+StFJ+
	 lcJZ8owTQC8FANEBXHMRE2A8Zv0hIX9+ACdTnoCzQNQ+N4KQ9DjYHOg1ZPOynkkDKV
	 A0OBs0D3vaPCiU2iZCarZtMrdCKZ4/sdbGousJ+tbZfxfySpDh9Xo5v+o1Q3fq7cIL
	 y1oMZBxYj7qSfDjSTAg9ICD7wWN9DzyUqg9Nnq1/6NaXysAVbjWYfDQCA0Ot8u8Cv8
	 IW1C31J5vXr1g==
Date: Thu, 16 Feb 2023 08:19:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, michallinuxstuff@gmail.com
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
Message-ID: <Y+5JdR02tlzD/TFS@kbusch-mbp>
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_071921_305719_02E23208 
X-CRM114-Status: GOOD (  13.42  )
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

On Thu, Feb 16, 2023 at 10:28:55AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217037 :
> 
> >  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> > 
> > For the CMB-capable nvme ctrls, kernel was exposing couple of related attributes under the sysfs. E.g.
> > 
> > 
> > # grep . /sys/class/nvme/nvme0/cmb*
> > /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> > /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> > /sys/class/nvme/nvme0/cmbloc:98
> > /sys/class/nvme/nvme0/cmbsz:524829

The breakage is that the attributes are decided before we've setup the cmb
regions. I'll send a fix shortly.

