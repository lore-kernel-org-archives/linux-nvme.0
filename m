Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE30C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08CB20757
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CbLlXvTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08CB20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yaI47jdhE4u6QLRNx43Ca9A7o4wr1lFyo9jjBRrLOQs=; b=CbLlXvTaYauyzF
	mx7dvtCY/LWoQ7HLJOsEDrym0H9aK2dDybxjTlTfUWrHlcxzpMzwHtOMPAVGowi6Ww2o7l5pkITpH
	7BJaeYAvVtpw80LiqPp2VGytF8+qYJMa3//ceYp1eg8oneCvPzC/wBeQm1fsqtw5424bn/XyL4F36
	3LkIpSbOilZz2MnqXCrzk3IQiNy3SG4dRyq9DXp+4/gSE7m1SHHWk5PdnUEqF8uJS1kuNYV2xnEn6
	lLBzcJEbcXVSh51ikcmeWDgKeeNOQx02t1XxaK21z7NeWD5rL50nz8ryuhTHGh5vPU0jSt7LueHpm
	Ddr0ro6hXpgiF8329yuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKGDG-00008i-QO; Fri, 03 Apr 2020 06:53:58 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jKGDE-00008Y-A3; Fri, 03 Apr 2020 06:53:56 +0000
Date: Thu, 2 Apr 2020 23:53:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: nvmet and stable API
Message-ID: <20200403065356.GA22670@infradead.org>
References: <d4060208-ec69-3211-277c-d151be302555@redhat.com>
 <c89ef694-b447-5e2e-429c-bc449b3c57b4@grimberg.me>
 <cae7b76c-06a4-d870-22d5-ec09cd57354d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cae7b76c-06a4-d870-22d5-ec09cd57354d@redhat.com>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 01, 2020 at 11:34:34AM -0500, Tony Asleson wrote:
> On 3/25/20 1:58 AM, Sagi Grimberg wrote:
> 
> > We don't have an API for python. I sort of assumed that this will
> > be contributed by the people that want/need it.
> 
> Maybe, I'm interpreting this statement incorrectly, if so please
> clarify.  I'm reading this as write what you need for whatever language
> to configfs.  This works and it's not difficult to do, but what to do
> for persistence?
> 
> Try to write compatible JSON output across code bases and supported
> kernel features?  Have everyone fork & exec "nvmetcli save"?  Write out
> your own file and document not to use incompatible stacks?
> 
> Additionally, none of this addresses a potential race condition between
> two or more processes with different implementations making concurrent
> changes to configfs and getting the configuration saved with no lost
> changes.
> 
> Suggestions?

What would be your preference?  You seems to be the main interested
party that wants another interface than nvmetcli for production usage
(all other uses is just tests), so maybe you an propose something
that works for you?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
