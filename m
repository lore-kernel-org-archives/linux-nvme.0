Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0213C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 17:02:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B6161406
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 17:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B6161406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DPOQae+xQcjQsu3xmnXRHiC15SWJ1MbjlmCgy9tYwyg=; b=IWjv+XJQ14OG5w
	eHAmIRZp7ALUn7R8zMmdMjHX7vqrEJk2KX9bu/TCGSphA4IG3aNwH+6HHMlqlL3x0a0KPjDnR1ph/
	Rl5fYUFa/15LnkCjW8H6y+GEYMXll+++M4ThW6ik4GzHf9pWtijzMBcLyd58BWbgGRt7OFgnsEnMs
	6yjuIP65TNvJrlh/T4pASrjY7CEcuOIYP/PLWZHSvkkkmvjUxbsTqY1cjCPjXK0Es0DBRBDCjnQeZ
	35VPw6ZXQDryfcfjFEVDJ0EXCGBN2zboPpbW16DF3Y9TruwjokQwX4r/KNh8UaJ9fRW2I9j3J/Sfs
	bHbVXRs1ICLEYXOzYzhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llDxn-001CZO-2A; Mon, 24 May 2021 17:01:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll5BU-000kVu-EI
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 07:39:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8CE7E67373; Mon, 24 May 2021 09:39:30 +0200 (CEST)
Date: Mon, 24 May 2021 09:39:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 3/4] block: return errors from blk_execute_rq()
Message-ID: <20210524073930.GC24440@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_003932_646263_60F5CD6C 
X-CRM114-Status: GOOD (  11.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 21, 2021 at 01:21:44PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the blk_status_t
> result of the request.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
