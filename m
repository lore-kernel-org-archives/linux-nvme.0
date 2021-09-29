Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7C5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 01:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F11613A9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 01:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8F11613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=POz/zP0D2PljP4wozLKC0rOOB6eXRtnWIQN80oojYnI=; b=Pibc8RVuQT2Z+D
	33+hEpLUtFxburqYk1cHJmZd/T32RerNFmkR80Tqon7yxE8QMNwr9jij5kwcXOdHipXu6EzXzwLiD
	+/Imgt0oeCZ/9Jscy+/TBvdIDgcrCruPR4+Afqevm/LYKsv9mlAwx4Is2ZfxSrMAwLIeOPZ85pG9v
	8SKXZgRJgxpy7oWmxaATmjY1a+FpBOSeeAYIN9DCf6VkvY1guKrpv1txMT3TPJCU0BKpLbBZ75qwb
	1Z0tCFJh0UtmTJL1OJ4vaKuvCIBX0GgA8/gsfeCXH2950WP7kS7VFRAw1va4sj/gfU1S48kovtgY1
	dWWEYMcf3hzM/5hiljJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVOVs-009YlG-M0; Wed, 29 Sep 2021 01:36:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVOVq-009Ykn-5T
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 01:35:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B99613C8;
 Wed, 29 Sep 2021 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632879357;
 bh=xSMiKh7QybnDR2qbX+96VqnNYtclBvGgdVuMnAe6HPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=snEgIBY9KwHbHJZMaGeeE3aPZ4kMKYkw5to0k3mYm6bOmfNaZU6It3CRXmtghMB47
 YatMOyOxPwD7RF0L+57kTPJz0kCtXi9ZGR8TZrE/RigfnOpKX143V9kOVtwsW7CZ/H
 NYPRLCe0LUI9OUwuOWdOsQmAnZOTRGwWSZ0BV78bbQyUKk/RYDYHfT84wjiiBThpTT
 7v5sCROQb/6ARL0vDStXZyFNqaPslXEvDqBVtp9iedJlbY89AU0AfPyjW5nzWFb0f5
 p1HtfGN8PiJ1tWsmbXi3M1gA3gRkXyLle92oFVx17W/xF5SthfApsqciD2Eb8d3YRK
 1t1OYfPpxz2uA==
Date: Tue, 28 Sep 2021 18:35:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Nikitin, Andrey" <nikitina@amazon.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Buches, Dave" <davebuch@amazon.com>
Subject: Re: [RFC PATCH 0/3] nvme sq associations
Message-ID: <20210929013554.GA405465@dhcp-10-100-145-180.wdc.com>
References: <79563B18-671F-4654-AE74-7FD9AB5417EF@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79563B18-671F-4654-AE74-7FD9AB5417EF@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_183558_249129_B5174B3A 
X-CRM114-Status: GOOD (  14.02  )
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

On Wed, Sep 29, 2021 at 12:48:49AM +0000, Nikitin, Andrey wrote:
> On 9/25/21, 01:38, "Christoph Hellwig" <hch@infradead.org> wrote:
> >
> > Honestly I'd rather not merge this whole patchset at all.  It is a
> > completly frinde feature for a totally misdesigned part of the NVMe
> > spec.  Until actual controller in the hands of prosumers support
> > anything like that I'm very reluctant to bloat the driver fast path for
> > it.
> 
> Thank you for the feedback.
> While I agree with your remarks regarding feature design in NVMe spec
> the minimal implementation proposed in this patchset would help resolving
> the problems outlined int the original post (undesired queue sharing and
> noisy neighbor).

You still get noisy neighbor with this approach, though: completions
from one set can stall the driver from reaping another set's completions
that were posted earlier.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
