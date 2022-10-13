Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3FDC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 04:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcEXkjWoybPLeBXHX9gKXvPZ3Go2psX/obArzRdNKBE=; b=3l/QdIU4/hg4a87dND+jXL9/Qw
	+/XXdpLUGt7Ei2Z1dOGiBBWyHSLjLcwK+YbizYh5WzkagWSsvIeWY99VN+ocBfqLUUN6m+KDusNvc
	2NuvhQAjW4dV0I4vcWMvosfa35kxPIhKLLl2hBVQkD/4jWGeJ/6gVwk3tX3lmLaFoMZLJ9VctNIQK
	dlZMAlWRUULkGgpVxxDhLjLlhBrLe5xNoHlLQmfSnPmb94BV5WkNyW2jwpI9Zuo32ILEXRn5Ikwdx
	pBFh8pkbjc4Tj6oocQMzus46hcpSikAzuC1P6ryQ4gAkKk88KI9L2XkNleauhEq0LkBie174BbsbE
	HL45VrRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiqHj-00Adqd-GS; Thu, 13 Oct 2022 04:57:31 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiqHg-00AdnP-M4
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 04:57:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F1D60B81C22;
	Thu, 13 Oct 2022 04:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856ADC433D6;
	Thu, 13 Oct 2022 04:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665637045;
	bh=pQFlBaxwx6sPCBHdcFkptZFj//wZg07sQRW1SS/euuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATArW6nogv2IdgeZr81tOJ+dFCnVOK2S0rTaWZ3yY/lN9W+BEtCHBJNW6OQtKMHZp
	 l1+8xppAXd5FMjfR9hd7MSlZzgoUTdyqEOM2I1t37Cg7URejQoU87rtJkOKg8l0BD3
	 zTxBt4ty7UBe77ed1+n0WOXF3vORYER7goBeZonjz++O6zouU5VXKvXmmPWCNrpgJx
	 gnCtPbLruaXiqM5YU/eeb2ZN1BhXslP1LQCYaDCFy6h/qg3O9bDKXEKzQO/JxydRz5
	 34x77geHKUEuj/ToJkME+j7ZoFhA6Z+CFIJA1DogVu/favIl5kQ9ErOGitHCtMM/2l
	 NoOmqZyppOqCQ==
Date: Wed, 12 Oct 2022 23:57:24 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-tcp request timeouts
Message-ID: <Y0eatMZ6Yfkbiox6@do-x1extreme>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
 <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
 <Y0XUFGXHciDCXRTs@do-x1extreme>
 <f7b44962-09d3-c724-89bc-453c86f4c1eb@grimberg.me>
 <Y0bxdiqgNAGoxeY6@do-x1extreme>
 <12074b00-7c53-5867-c785-58b96247d682@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12074b00-7c53-5867-c785-58b96247d682@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_215729_061730_8EC1AC56 
X-CRM114-Status: GOOD (  17.53  )
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

On Wed, Oct 12, 2022 at 08:30:18PM +0300, Sagi Grimberg wrote:
> > o- / ......................................................................................................................... [...]
> >    o- hosts ................................................................................................................... [...]
> >    | o- hostnqn ............................................................................................................... [...]
> >    o- ports ................................................................................................................... [...]
> >    | o- 2 ................................................... [trtype=tcp, traddr=..., trsvcid=4420, inline_data_size=16384]
> >    |   o- ana_groups .......................................................................................................... [...]
> >    |   | o- 1 ..................................................................................................... [state=optimized]
> >    |   o- referrals ........................................................................................................... [...]
> >    |   o- subsystems .......................................................................................................... [...]
> >    |     o- testnqn ........................................................................................................... [...]
> >    o- subsystems .............................................................................................................. [...]
> >      o- testnqn ............................................................. [version=1.3, allow_any=1, serial=2c2e39e2a551f7febf33]
> >        o- allowed_hosts ....................................................................................................... [...]
> >        o- namespaces .......................................................................................................... [...]
> >          o- 1  [path=/dev/loop0, uuid=8a1561fb-82c3-4e9d-96b9-11c7b590d047, nguid=ef90689c-6c46-d44c-89c1-4067801309a8, grpid=1, enabled]
> 
> Ohh, I'd say that would be the culprit...
> the loop driver uses only a single queue to access the disk. This means that
> all your 100+ nvme-tcp queues are all serializing access on the single loop
> disk queue. This heavy back-pressure bubbles all the way
> back to the host and manifests in IO timeouts when large bursts hit...
> 
> I can say that loop is not the best way to benchmark performance, and
> I'd expect to see such phenomenons when attempting to drive high loads
> to a loop device...

The goal wasn't to benchmark performance with this setup, just to start
getting familiar.

> Maybe you can possibly use a tmpfs file directly instead (nvmet supports
> file backends as well).
> 
> Or maybe you can try to use null_blk with memory_backed=Y modparam (may need
> to define cache_size modparam as well, never tried it with memory
> backing...)? That would be more efficient.

I've got this set up now with an nvme drive as the backend for the
target, and as you predicted the timeouts went away. So it does seem the
problem was with using a loop device. Thanks for the help!

Seth

