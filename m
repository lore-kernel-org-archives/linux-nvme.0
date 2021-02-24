Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB91C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:35:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB2564E24
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB2564E24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/6iDZntfaFBlIljwB6/B/wECr7hnOqFH/XlQGje9zPI=; b=XccskLqbukzYy2rTTfqzu5pYO
	Qh8r2qqE+cUAntrH+NgB980GATJOvmzTRowonEKmCYk7o3E9UGIPPvjSB5ZBlH1ZE72/LZOLcyU17
	oz0bzC3jMRaOqN6H/0w7J1lcpE3BVjFpASYi+Fcfq6EbsEwW2aNEXFAoZX5nGokMH7LLZfWx8fYLd
	MBBOwM/oQzNUgfwiHO9B4MbRNak6KZl7oCGjXeGVvsvZ/Br9D0FSuWEoNiuZmfoBGCLHRR3AOR/zH
	Hy97V7LvRE5rWZz33I5j57r5J7WYEVLuQwz4XcxepdRdz5ExNUjTM4J5ZXad2lAuaOGdHrQhqlGeM
	YMGpzfD7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEx83-0004Tx-Qt; Wed, 24 Feb 2021 16:35:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEx81-0004TQ-Cq
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 16:35:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6063F67357; Wed, 24 Feb 2021 17:35:06 +0100 (CET)
Date: Wed, 24 Feb 2021 17:35:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 01/14] nvme-core: remove duplicate kfree in init identify
Message-ID: <20210224163505.GD10673@lst.de>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
 <20210217001032.25741-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217001032.25741-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_113509_557407_DFF5C6AF 
X-CRM114-Status: GOOD (  12.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 16, 2021 at 04:10:19PM -0800, Chaitanya Kulkarni wrote:
> In nvme_init_identify() once we initialize nvme_mpath_init() we free
> the id with kfree(). This is needed since we just return from all the
> following calls to nvme_mpath_init(), that also makes kfree() call
> duplicate.
> 
> Instead of returning after nvme_mpath_init() jump to the lable
> out_free and remove the duplicate call to the kfree() since out_free
> label already has one..

Hmm.  I'd rather split nvme_init_identify.  Rename the publically
called function to something like nvme_init_ctrl_finish, and
the split out a nvme_init_identify for just the section that deals
with the id_ns data.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
