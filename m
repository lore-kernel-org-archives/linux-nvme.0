Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C80CC52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HG2JovbqecW+wcQpjOsXPidYoAm8vpdRf63iIEyOkVc=; b=46KlsPW4O74LZbfPuvkhftk5gV
	MUYQQ4gml96EPOueV0mrrALmPztrzqQn1rx0QmqlzCkToLfNwLvW5veCx73zc8csYCoyRAmJIaJGG
	fxvG9CeYUNvogEOgj6VvGZMF4vnXC5Ql8hjku3yRuWb+ikar/OUULQD4mWa5ib1IoBoJyzRYDeDqK
	cMZumlli47Jb4oeugwLG+Y7Y0BEDF5bHyCywdEEaUixZC1OJVs97rDwsOsBsy5LHCskrB6QaqnNND
	5GyYqh6o4M/cXqzqb2Lefskq3Srubh5m22nXgVUyOP91vBpchgzpxTSuZDfi5jHobnOTWlrB1u5O+
	cuNdswzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWkf-00000000hfG-2kVK;
	Mon, 12 Aug 2024 15:14:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWkR-00000000hbq-0wLK
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 15:14:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A38560C5E;
	Mon, 12 Aug 2024 15:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7361AC32782;
	Mon, 12 Aug 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475654;
	bh=Jo9rXAbmeRMYwtyH5F7XvYj1cBCamhL+Uo7Wd1Ia4a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtdCempPg33SX3OmtnM8Fa7xAck8t33lt3VG5lCwKCegt61GCGtl10eJpPa4J1ult
	 +VG4XO3icx5PRxI9tgPLMlRVzbFV23TW/2Fy/Cn5jV3H469NICZVT+ue7NuchkCppG
	 EHWGhrShNBRL8c/s3ex3Z725TMJesg9dSj4kLlHEWBegE06NjW9hqxJLin6/y0UfYB
	 /WrEaWGKn7EuBlIRZlch+o4I8uONXAoJZZ7kHa5EH/pB3/Sq+G6ZGH0AxBEYHr7FQp
	 DwP91Z6Cvj9HDBOTAh/eLf3MIw8hRAl2yBR4oZHMegc/+haLV1+DvId2NjzW+mKKzH
	 teEsnAmDv9zNw==
Date: Mon, 12 Aug 2024 09:14:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Mark O'Donovan <shiftee@posteo.net>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Message-ID: <Zromvtmi3p4WjPgD@kbusch-mbp>
References: <20240809135427.378953-1-ming.lei@redhat.com>
 <17cbd822-daae-4954-b184-974432ca2fe1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17cbd822-daae-4954-b184-974432ca2fe1@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_081415_333967_708CC3F7 
X-CRM114-Status: GOOD (  10.98  )
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

On Mon, Aug 12, 2024 at 01:56:01PM +0200, Hannes Reinecke wrote:
> On 8/9/24 15:54, Ming Lei wrote:
> > @@ -4612,7 +4612,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   {
> >   	nvme_mpath_stop(ctrl);
> >   	nvme_auth_stop(ctrl);
> > -	nvme_stop_keep_alive(ctrl);
> >   	nvme_stop_failfast_work(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	cancel_work_sync(&ctrl->fw_act_work);
> 
> Huh? What happened here?
> Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> has _exactly_ the same hunk.
> Someone else must've changed it afterwards, so please update the 'fixes'
> tag to refer to the correct commit.

Yes, someone did change it :)

  commit 3af755a46881c32fecaecfdeaf3a8f0a869deca5
  Author: Hannes Reinecke <hare@suse.de>
  Date:   Tue Nov 21 09:01:03 2023 +0100

      nvme: move nvme_stop_keep_alive() back to original position

So 4733b65d82bd moved it to the wrong place and Ming's patch is the
correct one?

