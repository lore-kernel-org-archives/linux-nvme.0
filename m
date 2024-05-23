Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B452C25B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kz+bmvZYp+nig6Ilbu+e76YH2V52ERF60QMmelVFsAU=; b=2gr0kHG+vql8wOHjMsR5UFhL3g
	wwIBHcWRYGR8pIkxykggshtZ4YJb1Ea2BMd/Q+7WqWmnxBeh1pb5QmmX6DUGYXrJzfpIs+lrIT851
	vFqIKv1mJtbaSufiFaGAPFLyMn/+9f0//oWh3PM4sMVRN1RdPHlhoRS88MPKt02muJBrULVd8eQ1X
	k7qzPpJkDn57dG5X07SwvQBVdQOUeFtkuFajgUVtg+0hUYU9laoNlnTrc/fEuSHZcUP8TsgUiaeNO
	V/Otvbp1Yp/dChLKKj1jN+Vb7oseeAuU6CwoSj1xKSzo5PmMUeUF077QWfNONRT/6jKOimVE6dNHx
	2H/Q48Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAnj-00000006iqE-169v;
	Thu, 23 May 2024 15:56:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAng-00000006ipd-3mVV
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:56:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6727762829;
	Thu, 23 May 2024 15:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0F4C32782;
	Thu, 23 May 2024 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716479776;
	bh=i7Tw0ka2Azlqbu89fYZKEbsu4QyMAXfiYj37ZuKugPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7Wzpk5AmmtRPHaKPz92DnriJQv5L+1r412h+7e9S8JeA7pTvn8WCSqEAJgvQaNGn
	 RAIHoI9GuY97T+8SGeuRaxPab9w0kUZbC0WUkaRkpVJwO4FaO/YRc1oM1WJwDvb/Qb
	 mYwCZZIqC5u6YWRfTGyknhnJn2O1G9scrksGWe6Dlx0rh0BjZED744bCF7cQJzGuwC
	 vArjFlGGEbxq53ULw7E+LhNT00wQHmAAMba3+OOPJLglAWFVV4nQINJNHnhHslEH2q
	 KwLmMSiBhb8BkFTYNWKwD3Il+twaLSdWqSBu8AseJhYA9iu4lgIeNN2G0Ju75/9ZSQ
	 l8Lq2sMTbtcPA==
Date: Thu, 23 May 2024 09:56:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk9nHgk6e4Yb8rOV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
 <20240523064525.GA28524@lst.de>
 <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_085617_006247_599DFC81 
X-CRM114-Status: GOOD (  11.71  )
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

On Thu, May 23, 2024 at 09:12:21AM -0400, John Meneghini wrote:
> On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
> > > Christoph, Sagi, 6.10 merge window is still open and this has been
> > > iterating long before that. Any objection?
> > 
> > No, it's not.  The window for development closes with the release for
> > 6.9.  New features must be in before that.
> 
> So what's the next window for new features?  6.11?

The nvme 6.11 branch will be created after block creates a block-6.11
branch, which usually happens after a few -rc's are released in the
current cycle. So at least a few more weeks.

