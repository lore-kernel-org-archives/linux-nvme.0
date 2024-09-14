Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA95C021A8
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Sep 2024 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jEb/ijWd3qoEkpmMA3rsWD2rYDkEJ8WooW+jRGh20uk=; b=KprWQe5GrgPbbpyM3d0YVZ8zvk
	blNv2zQgriUFt0woi9N/DwcGUkWksj0SA2OYucolavmc/5A55jC6EgW6EMdX1aD/543VLKCpRGtKD
	4tcGujZqZNRVJoJ5OMrPAcwKqiTK8HBWFIndotuUXkUySAPcleZamPjalBvTL64utum2/kZ0n0mBt
	eCU43Q3hg7ZyHhnr5W9TKZVeNdxK02zBOd9T2MxhIYrCj6CQic+5+ST6LjMviLnXoq4FLxLQFqZv3
	JGLsJLsuv8xGFDMcu2+Djfp3iRsk/VpwxtRx/ZSVzlnEzj0MNOyr57ExV4FQ/vGRefFkjcs8/4rDF
	rauyfMJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spVzR-00000000yCl-2Az7;
	Sat, 14 Sep 2024 16:51:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spVzO-00000000yCL-3TIV
	for linux-nvme@lists.infradead.org;
	Sat, 14 Sep 2024 16:51:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4E2C3A40148;
	Sat, 14 Sep 2024 16:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BE7C4CEC0;
	Sat, 14 Sep 2024 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726332672;
	bh=Z71g/E3I7Jij2MRKNDH6gqkcbdpZ8+UYJCRd77hL9Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpitQDL1e/aY6KvLGIo3aTY3pIfqMYtDBf/BdOBMaHPqPxyIaTTlz+oxsjp624wPj
	 1ycwpdjSWg2IDC2kr4/Ba4VYLORvBVAAhfft4TRUYE2HNAmRWVzeRobn6+CeApttgM
	 C8lncDQfs1jBvv5L4x00VQiRfY45Z6QUUPoIDCDuZomSG5epIQGke+lGVnuD4gVzN8
	 xLfC9FVU9/GqVut7P/3reZrKSOrPfp/rWC72L92MWK9HmdlhEeqEhuK9D3gwvfbUsM
	 GgbJekkvTd1hhO1RG9VxorZ4QlhI8d9c5s/RKPSclGKbqyCm+GqOaH2VUi/mZW8QnI
	 rmsjCpeTmVKKw==
Date: Sat, 14 Sep 2024 10:51:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv5 4/9] blk-integrity: consider entire bio list for merging
Message-ID: <ZuW-_hu1-98SEjll@kbusch-mbp>
References: <20240913182854.2445457-1-kbusch@meta.com>
 <20240913182854.2445457-5-kbusch@meta.com>
 <20240914073011.GA30261@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914073011.GA30261@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_095114_955695_8FAF674B 
X-CRM114-Status: GOOD (  15.81  )
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

On Sat, Sep 14, 2024 at 09:30:12AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 13, 2024 at 11:28:49AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > If a bio is merged to a request, the entire bio list is merged, so don't
> > temporarily detach it from its list when counting segments. In most
> > cases, bi_next will already be NULL, so detaching is usually a no-op.
> > But if the bio does have a list, the current code is miscounting the
> > segments for the resulting merge.
> 
> As I explained in detail last round this is still wrong.  There is
> no bio list here ever.

Could you explain "wrong"? If we assume there is never bio list here,
then the current code is performing a useless no-op, and this patch
removes it. That's a good thing, no?

