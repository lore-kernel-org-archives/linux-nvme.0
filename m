Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332A7C36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0AeMPZArfFODa+OczEoOG0QDU0yFfpKy/AkVeVYQ1Sc=; b=uDPXwqGNxi9TpXUO/fhT33gGy1
	jKAv+7f+WAXBRlEP5fjp+SstZDBAsPQMtZgr/F5oqeP/ssjDGxGUePLCh4M38SpD1ACvDqmJi28wQ
	RqajxMSnSGr4fBTuQfEBfBQXL7GFp2DGSW17hKLMCF1ujVvQ10QGoyyqtJ+f0yOIm4BAFYIKjqlA/
	lv2IBO/DSzXxD3/B/R9LVpQSUEVtg3zNOcKBpL793wqOFqe3z6FW+IkDlKaIcOwqGsA0BbrCsWUV7
	fzYB27vtI0rsmSHqUg0dPBbBpN97KPFtWjmc+Z4LufgN0wJt/PvxJ7IVRRuXAYYUebiBIto9mhLiN
	nGDA38lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cR5-0000000B92T-09Rk;
	Fri, 04 Apr 2025 08:29:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cR2-0000000B90n-0WVr
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 08:29:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 863FA68B05; Fri,  4 Apr 2025 10:29:50 +0200 (CEST)
Date: Fri, 4 Apr 2025 10:29:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yaxiong Tian <iambestgod@qq.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>, alexey.bogoslavsky@wdc.com
Subject: Re: [PATCH v3 0/3] nvme: Add sysfs interface for APST
 configuration management
Message-ID: <20250404082950.GA8928@lst.de>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com> <20250403042504.GB22360@lst.de> <tencent_D00C9DD2BF00258063B042172328396DB608@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D00C9DD2BF00258063B042172328396DB608@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_012956_305156_F3DE1014 
X-CRM114-Status: GOOD (  11.33  )
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

On Thu, Apr 03, 2025 at 03:05:37PM +0800, Yaxiong Tian wrote:
> These two patches don't fundamentally change the APST configuration policy, 
> but rather enable users to configure various APST parameters in real-time 
> across different devices. As mentioned in commit <ebd8a93aa4f5> ("nvme: 
> extend and modify the APST configuration algorithm"):

And who are those users?  What tools do they use.  What settings do they
set and why?


