Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE17C36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ApHbLXIIKxB+53kGYX3eeBTgz/dl4rDGXdiQ9dtS7dE=; b=cwEPLQ3miDdl3uKLqA/uMPl6vc
	njoZrJso/885ZzVj2/jyBJwKDyNEJEkKtdj7H8b4opPsDeWFQRXHvzEyOzNGAdsLnmnoDgSDiApCA
	Ed+ejFWInXWWW1jyXfTE/F4QslWEhF/X+D+sdPkpxx+EcCIDIOR/cTn5X4VmqynTcOCQSaNQAuCeQ
	3NgdXF9V8DMKUzprtST4jelKGVc05Fjo7eAx6uP8/q3FatQ5Cz+22X0KvncC7iVHMYjVS9Bv9634B
	4siPChouKgkXwBOJdGR2lKp2rrYiHCRFxiqvN1z2cNj9t7KapffsuHaP4bkgl4XA/eUgO2UEp3hWo
	77jFhV6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CVk-0000000EaBo-2qIb;
	Sat, 05 Apr 2025 23:01:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CVi-0000000EaB3-0gIu
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 23:01:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E82EBA482D3;
	Sat,  5 Apr 2025 22:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF598C4CEE4;
	Sat,  5 Apr 2025 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743894068;
	bh=hs98QGJAptPq+t6mE1GmKXfXZkVlz2dab5/E9BrP8yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSqXUvJ4uCYaPUkt0CYQzTX1OOaJdTLr5NlyJAKToQgCe1REscLB/DBC6XihyOoLx
	 myBWhEQgdXlQ96KFcwGA85ctiJLVTWZ/H03K2+l7Y8sFpSDBB2lyKUrdt7zhEHBX3K
	 /vRYOfxZq4SuvkIPN9XVKmFCxUooP5elq82+yy2/C4Z3qk0Daqr8OlhfqUUsnog6DG
	 v1/NZP9ItkR/8i+QfllsDAqQxM4PfqgtsvjU8WAFjQwxx0mm+jzGW/9SJQ9fJ8OGDa
	 4CF0NlWd0L3Yx9XtERVE8z9sKli3fOnw/hQbG5tAOqYr/CUO+yoXUTm7ieT4ygah1O
	 UamJptQD2k8Wg==
Date: Sat, 5 Apr 2025 17:01:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: requeue namespace scan on missed AENs
Message-ID: <Z_G2MXovUVjme0NY@kbusch-mbp>
References: <20250403071930.52154-1-hare@kernel.org>
 <20250403071930.52154-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403071930.52154-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_160110_263226_D0221706 
X-CRM114-Status: UNSURE (   9.48  )
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

On Thu, Apr 03, 2025 at 09:19:29AM +0200, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@kernel.org
> 
> Scanning for namespaces can take some time, so if the target is
> reconfigured while the scan is running we will miss the AEN.
> So check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan is
> finished, and requeue scanning to pick up any missed changes.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

