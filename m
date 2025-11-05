Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633EBCCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rghigQNrQHI7E7TzGVlsRwlqhQKCJbpFbfVlOsmAwas=; b=IDnAQBPKhdgV9i5+OnBOD7qPZr
	5GGzbQ5IcW0mLRYtf0C2RnXHV7FzdVbip6gFvguinGjA2qKcDmO32ziqTCrP4DtX6yC5OTs4IcSe6
	gIsNb6oKxYENspE4XAYDR1Qj3GRT7K24cLLC/JoavCVR4/fyo9ceGxUIljvO/D57JRVmXCn8IeJCS
	SaU9Enf1XwEToHq5DFjM1ZyyJR6U1QPbQTI7Eh8GKogb9jyzBA6lVYBuKWTPnGFqTzFwlUrxZg0e7
	dy0zMraN4t1ISFHI+3q0XlATjiE6ys0HHLGseNSCrMnfceJUwq7H5wJlHLyFRefhYyQzTYG8Ry95K
	Nwbg9F1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdLH-0000000Dk9K-1bsk;
	Wed, 05 Nov 2025 13:14:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdLE-0000000Dk8I-1s0d
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 13:14:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5676227AAA; Wed,  5 Nov 2025 14:14:14 +0100 (CET)
Date: Wed, 5 Nov 2025 14:14:14 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Message-ID: <20251105131414.GA19044@lst.de>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com> <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de> <0c299f77-e93d-4c96-af71-9e1ea387c9d9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c299f77-e93d-4c96-af71-9e1ea387c9d9@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_051424_624129_C4D251D0 
X-CRM114-Status: UNSURE (   8.10  )
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

But what is the use that requires removing all that overhead / indirection?

I think you need to describe that very clearly to make a case.  And
maybe drop a lot of the marketing sounding overly dramatatic language
that really does not help the case.

