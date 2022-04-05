Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAF2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4mAm8Fn8DwZnenpNyNYnJKnVpE8gpAEDOV3+rQoUZw=; b=wEZ1m02kvkOTuxf4X5s/ijIewW
	FtStNeDPLzjt48+6MsMNLK7X8aaYebUBFMSGUQSXmalCySdc84q/WrrbBlq2IY52pLzOsHzyhO8wd
	MHC0gahOPzAk/i71X3eSkAxfI5f8TPYfRq7qreo/wfsuiXR2RpNx3NxcLC8Ut5e24EjysRghtR2dO
	KJAfV0UTYAX+u9jJarf6yZ7h4HMRtZn9dD6HY+/uBx9h8RvL9YMowsLctxR4uiL4JJiDyhFEsgSiZ
	f6IUJhwTUlfbh7PkKWABuxVbBvg1PRxdiiYRuuHkoh25kqP8zz1KXVN0tc1nq6CVIjgZ+1H5GeHD4
	2dKmDINg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbc3X-00HCjg-2h; Tue, 05 Apr 2022 05:48:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc3T-00HChr-Mn
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:48:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F0A6568AFE; Tue,  5 Apr 2022 07:48:36 +0200 (CEST)
Date: Tue, 5 Apr 2022 07:48:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] nvme: add namespace paths links
Message-ID: <20220405054836.GA23647@lst.de>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224839_909836_7D64786A 
X-CRM114-Status: GOOD (  19.67  )
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

On Tue, Apr 05, 2022 at 07:46:40AM +0200, Hannes Reinecke wrote:
> On 4/5/22 07:42, Christoph Hellwig wrote:
>> On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
>>> It is really annoying to always have to loop through the entire
>>> /sys/block directory just to find the namespace path links for
>>> a single namespace in libnvme/nvme-cli.
>>> So provide links to the namespace paths for efficient lookup.
>>
>> I think having some form of links would be useful.  Quite a while ago
>> Thadeu looked into adding some form of relationship for lsblk and
>> friends.  Maybe it would be good to sync up and make sure whatever
>> links we are adding would be useful for all users?
>>
> Care to elaborate?
> Using the block device name is the most straightforward way here; we don't 
> have a good enumeration to leverage as the paths are essentially just a 
> linked list.
>
> We sure can have a subdirectory 'paths', and stick the links in there.
> If that helps with lsblk ...

I personally don't care.  But I've added Thadeu and the util-linux list
to get everyone on board.

