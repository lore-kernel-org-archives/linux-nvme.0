Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 11:26:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7B264F67
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 11:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7B264F67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yEruRtUy1mDnrww+lXN/cRgtWZ7H3lhTYaQEwFQAttE=; b=VGr3nbg2RmGwkO5spbkYe6CqI
	yv5oxeZ7Capq1vxtWMPSEpma5CpfYoyzr6tpfGD9yjOD6asE24CjdFeAAaNEuvwYkAmvZzLQgeGrx
	k7Ix8VvhcrsqeFa/jkgkQOCSXq1TzIL0NUqXqiNuAYBq7cjdPGg0WLPvQIDU9/IPBG4Pcm44KB9D6
	p1La+ZbVk6KG2k6JItBgVfLvHDz5jj60QweHvorBxMnP5nHaEYO/BlMkcr/uEDHy8WALfQe3v+xzE
	/SDmEJSsw+8dNnizg/rOZ1dH+aFDCVdxxRKVu3c40iq1L1sXPmqzAHsPp/YRgTNqLxby7ljY0QZ6F
	OuAzhfv3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7GJ9-000269-SF; Wed, 03 Feb 2021 11:26:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7GJ7-00025H-NJ
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 11:26:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0361B67357; Wed,  3 Feb 2021 12:26:46 +0100 (CET)
Date: Wed, 3 Feb 2021 12:26:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203112645.GA11942@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
 <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
 <20210203111548.GA11075@lst.de>
 <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_062649_882692_D1242227 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: sagi@grimberg.me, serebrin@amazon.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 12:22:31PM +0100, Filippo Sironi wrote:
> To avoid issues, it is easier to apply the quirk to all Amazon NVMe 
> controllers for now till the new lines of controllers with the fix comes 
> out.  At that point, we'll be able to restrict the application to the known 
> bad controllers.

No, that is simply not acceptable.  For one we've had enough cases where
knowlege about old devices was lost after a decade or so.  And secondly
shipping more of these broken devices should be as painful as possible
for you so that it preferably does not happen at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
