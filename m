Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2384AC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB33B20786
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R6qwETPZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnbMCj5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB33B20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ell1OW+Pz78hBjZSXg/8MPl/jXceE3oswLxY65dF5pQ=; b=R6qwETPZlhD7mC
	VT4XfC5zpEfTYDMhPG08PGttRobLvZQJgx7ZokIG98/EzzUtyqJKJNpdSEj1TwRU/WYlsVr4ukjfS
	s66lHAN9wLWV2ubswuRBa5nsehC6FiSyuMlIUACir7hAm60HjSbsNjxU/2anblVvWp94DQT1utl4g
	RYwhppLpPljVkl2IVSZdfgXf6BheJsiJpraS1PF+u/7JlIQ/eeNkVBt9QjUx5ewyJOAxrh6659lsz
	GFL2veAA+KGeg18RIe4dWyJJ8e8N7Pe2X/kiMu6i7y9XJvXUJOvTzYlCze3gZxmHqUpK10XxuR31S
	8/WvpiFL88KTe4yLV54A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJX2-0007hG-0G; Tue, 31 Mar 2020 16:14:28 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJX0-0007gJ-EM
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 16:14:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fUz6OAumwsnNN13FJN1nZm6qsC+5OL3CtJbJy+PsHps=; b=cnbMCj5zjBVjTa/Fu/a2IyomON
 0qjlyoikE0KYPf3afuYHkX+ZRty1qJvRDEDefiBIvYi0GMlQPGIE1xacCDF1QvmGNeUANKHprxpY9
 684Ohyuq7EztmEpAXi97cZNzuFG4z1jiVRBWSfp7eTCXJjVPPTECgUDd3sjXpJ4/VwykZM+8wJ1Xs
 Q3RZKd2eZIEW1YXOUHyl9DUHGCq49gp0fSw2zQHeFJmqQT0OtksBaHOWorQcX9KnrEexHull0xi/3
 vZw064ofsSkpbQl70D0iMtptSEQeYjryo40akGCpf318JoN7XPUhWAiFcBiwTtVw1ZVZPJYoiXOPO
 40Q0ebIA==;
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJHl1-0003b6-DU
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 14:20:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4FA3E68BFE; Tue, 31 Mar 2020 16:20:39 +0200 (CEST)
Date: Tue, 31 Mar 2020 16:20:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH] nvme-rdma: Replace comma with a semicolon
Message-ID: <20200331142039.GA18691@lst.de>
References: <1585658793-12070-1-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585658793-12070-1-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
