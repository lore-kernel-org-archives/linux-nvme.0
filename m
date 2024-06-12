Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE69C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xJiwLEO6A9rXC/Tw4pBSqTyYDPQuShRMUBvTF2XPys=; b=Dy2ZU3zeX1dwTfF0zxvfMD/tfh
	/Qba8PnaBEQTftcxO6H66N5dSdaJTbApux6vbICYQp+fOTVhz3XGYcXk/p1Tu5XamHc1r7WCPGIO8
	nW0ovgGPFsTjLcWGCQt/apeIoNLVZgitb90q8x+x5B8MYGVlVgVxJ5DioNbaI6GZJrvG53yTbrpmn
	qI2foUPj4oSwWoIES6l4fE7UWl7HSq8vY4BI2ajtjz2uNNxwfXuLF8XIOdMiVTOgx+u251crV4xWL
	1E1wIqp2ltSdym1oMl3mh7l5+HlIMYxx5JO2rBBbCNMImghlDmChXF8fXZLWZ7dXB7aA63UijIKx1
	JD1i4QWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHRht-0000000DYJr-05oq;
	Wed, 12 Jun 2024 17:24:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHRhp-0000000DYH8-2bAJ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 17:24:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 561D4CE21FD;
	Wed, 12 Jun 2024 17:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A2C116B1;
	Wed, 12 Jun 2024 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718213054;
	bh=VEP6/pbsoq4tingsui+FiHXJGFOhZC3JaHgSPFWU6mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0Q06Ogck67T3YyvvwKZ6YCLKjIXPGwvgIyl5znav4NfousuzZYo71KBpvEwS1p56
	 A6rxMMP4xTnaag8d66Mh3iNk41YULjPod4ac3blokxLKvroAnWen2tfzXHEb96o5dR
	 nEhK1WQev1bKH8ndeUmfwYukd9xDZqQd9fB5HscNC8ng3f70y5Ddq4EXh4AN8ZjwCG
	 kOpaNMEcNPmV3FPABKbu1UvbhzKXgAmxdoqtaV2jSopaSZ8tIxBbzSuaHAbxcoQBlM
	 ABr6jorhzTPCnmqTiq6wWIXg67BaS5sNP7QiQ1p0JVq2dXAotCldXBan3v4dNyhWfz
	 xGnF+AOXKWkuw==
Date: Wed, 12 Jun 2024 11:24:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"davidgow@google.com" <davidgow@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] nvme: fix namespace removal list
Message-ID: <ZmnZu-QceHYbYf0S@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <20240612155135.3060667-2-kbusch@meta.com>
 <5cb2c809-bfa3-4389-8f60-ea0edf742724@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb2c809-bfa3-4389-8f60-ea0edf742724@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_102417_965345_87B2EC81 
X-CRM114-Status: GOOD (  13.65  )
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

On Wed, Jun 12, 2024 at 05:20:48PM +0000, Chaitanya Kulkarni wrote:
> On 6/12/24 08:51, Keith Busch wrote:
> > From: Keith Busch<kbusch@kernel.org>
> >
> > This function wants to move a subset of a list from an element to the
> > end to another list, so do that with the new list_cut helper instead of
> > using the wrong list splice.
> >
> > Fixes: be647e2c76b27f4 ("nvme: use srcu for iterating namespace list")
> > Reported-by: Venkat Rao Bagalkote<venkat88@linux.vnet.ibm.com>
> > Tested-by: Venkat Rao Bagalkote<venkat88@linux.vnet.ibm.com>
> > Signed-off-by: Keith Busch<kbusch@kernel.org>
> 
> not a blocker, but it'd be really useful if we can get a blktests for this,
> I've asked OP to provide steps at least ...

Recreate the original report: detach the highest namespace id from your
controller. Let's say it's nsid 10, and let's assume your ctrlid is 0:

  # nvme detach-ns /dev/nvme0 -c 0 -n 10

blktests supposedly has something that detaches namespaces through the
nvmet module, but it doesn't seem to be catching anything.

