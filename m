Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708BCC25B48
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G99EpgNPwk3ZKtsKXFSuDuK5XAwD0sKO/GOP5GTC8us=; b=NZI1yZq4AX9vVZvcyNLaCKxmuf
	0TFElg6FqTabO8PfI/LNtAFPaWjXlcroaGEzSCKrxSB906VkDFFd63xw6Y19vjV6UQpk4dXkTtK5F
	u2PSGZ8Zv3jaeUrAVMcqs3Q0wHR9fyc6EtNdCm3ENCQ07sZNwtYirUlh51Pvgq/BJ1WN0ZHwaY7VM
	gykDsxQlGyYyqMdAwcyE7kBE0uhOX7mPWq8IV0J1xC03V889eexJjGX87hrs8P1NKykDewAQtewV6
	JrZPN7lSshfAYkXv6irDGvVY3g7924ygD06wMwBJzjN1s5S4UtZDjnMsGlBVxTHlUG2qjdZehicfy
	A947Bmrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvJFE-00AK9V-0l;
	Tue, 24 Oct 2023 15:23:00 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvJEj-00AJgV-02
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 15:22:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 6A5FCB826A5;
	Tue, 24 Oct 2023 15:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1EEC433AB;
	Tue, 24 Oct 2023 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698160946;
	bh=yP/m5o/N2xjmFltBU342MA71mpnmokk3pCJv5uGnXGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBysLWeDFStlnjEQdvf9qACHZxYBYU3Xu/6xqUFCu6Ju1a3WZKBvjxtFbJsq5Vmgn
	 xqDcyOxjS0loDAGl8TaGTgRizdvsc5P7ntlxJraiRoah1MqXWgjzH24sIt0hlSI3Uo
	 fShS2I4QG2TU+qXEn5+bzlch00CmvKT/PgyHhE/fFE5eTi5uvfBOeXcB2gERwB2XNG
	 jOvmAyzd37nYMoxQtyLt+7uH45luxJVr71LKB1F6GHlxPnn+cTZJIEOQHnnTIS9/DG
	 q3o9ZAVyYumqwGkS4g4HDC/2DGjLSk12BJ47pcvpYzI+yJLVReLFrIK/Hrs0fXGZHv
	 fzi+QtOt50LBw==
Date: Tue, 24 Oct 2023 09:22:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <ZTfhLxXIMzdptS8E@kbusch-mbp>
References: <20231013163420.3097-1-dwagner@suse.de>
 <9c9ee261-6d44-4193-917d-a513865e7181@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9ee261-6d44-4193-917d-a513865e7181@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_082229_259845_9C044BB4 
X-CRM114-Status: GOOD (  10.62  )
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

On Tue, Oct 24, 2023 at 06:21:45AM +0000, Chaitanya Kulkarni wrote:
> On 10/13/23 09:34, Daniel Wagner wrote:
> > The firmware version sysfs entry needs to be updated after a successfully
> > firmware activation.
> >
> > nvme-cli stopped issuing an Identify Controller command to list the
> > current firmware information and relies on sysfs showing the current
> > firmware version.
> >
> >
> 
> why did nvme-cli stopped using id-ctrl ?

We have exported attributes. We should be able to use them so that we're
not interrupting the device to provide info that the driver already
caches. The driver just needs to make sure the contents are reliable.

