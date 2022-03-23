Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FFCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 08:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=L8olo867jSmwjWu7katbf2Fh0O
	8HGq87yln7K+fcsWmUlcmWPhE1BbHludnDjPDOHhjcLy38qXYP8twLV3mfhgWs65bO9kwkYbibVUw
	fd7QfVw3+EquWIF7TiVjmJrOknM659cMr03ArRWf+S6lL3LHiwv/wMa8YjKLyTTebD0J904IZuF6+
	Wiuwixksd/bWpzQScdnjNDDQt+YtAAm/NF0zPPkm1ZrWGX5OkxlQ7nNS8BPPSmTs7kFU1q1v6hO5+
	0R0vXJnChfRyQWhlsre3REBfkw4Y9es21IhfbzKYqxsejYj5RL1FbOPtgY9GXVitwQ8MSidTCNTgT
	Pg+Ha4sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWwE1-00D54w-9Q; Wed, 23 Mar 2022 08:20:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWwDy-00D54R-Bd
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 08:20:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 79EF568B05; Wed, 23 Mar 2022 09:20:05 +0100 (CET)
Date: Wed, 23 Mar 2022 09:20:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: monish.kumar.r@intel.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 abhijeet.rao@intel.com
Subject: Re: [PATCH] nvme-pci: Add quirk changes for Samsung X5 SSDs
Message-ID: <20220323082005.GA26611@lst.de>
References: <20220316075449.18906-1-monish.kumar.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316075449.18906-1-monish.kumar.r@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_012010_588035_8A4E3D15 
X-CRM114-Status: UNSURE (   8.61  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-5.18.

