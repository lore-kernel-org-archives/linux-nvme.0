Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F49C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 05:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6QaeK9CalGX0Z/fuYTTUmTZng5b5eCG969k/prRwdRE=; b=RzYKELhlJMC966GnliLHgUBAZF
	ReOA4A6DBIc9Pn5t4wdNm5j5dw+LFICwsH9yqsCEli2RkL/70BdzkoFSndcn34Jd6nTz3Igy/OfPB
	LLhcx4ryp+hyx63hNNOd9267Xjjio9T+C6A/JpkTtCB3muhSECtGl9aT4HkYQRAsdT+lwABEoDAbK
	7DKiWpvZJM+Q7dOFWRT+UCb5YNMCKhSdzNdM4G/+egwpGch3FjztWkjPF7JCgQq6Rv/jJhpFxs7Xg
	cf5IZnyfZ5UUng5WiEeKQaqu9lvhw15/xPHEPSJP/gm2fwKgWSkOkpSrQO4YTQGwi3hVsXeIT4f1i
	s6GfLT4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nch1t-00F6SQ-2W; Fri, 08 Apr 2022 05:19:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nch1n-00F6Oo-2y
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 05:19:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E866A68AFE; Fri,  8 Apr 2022 07:19:15 +0200 (CEST)
Date: Fri, 8 Apr 2022 07:19:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: me@kingtous.cn
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220408051915.GA31955@lst.de>
References: <20220408025704.6352-1-me@kingtous.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408025704.6352-1-me@kingtous.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_221923_335426_BB61CBFD 
X-CRM114-Status: UNSURE (   8.79  )
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

On Fri, Apr 08, 2022 at 10:57:04AM +0800, me@kingtous.cn wrote:
> When nvme namespaced ids are not equal, we should also try to update namespace info, not just skip it.

This is, umm, od.  Can you do a:

	nvme id-ns /dev/nvme0n1

before and after a suspend to see what changed there?

(assuming you only have one controller with one namespace, else repeat
for each /dev/nvme*n* device)

