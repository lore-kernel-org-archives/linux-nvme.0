Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7375C3ABC3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 May 2025 00:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4B2PhSgyE9Wbq0XXzziMjz6lqwI7FUVKn7gWMtYXiM=; b=QjOVeqK/A/oGjguvlrfVXu1dry
	GlX7Vn2l66uBiQ8r06aGvjqBHOEu5YVgdGAXyw03uJQigJDmG4c7oew0U1BvnX7oKNyS/OdKctuO3
	Kz0dsesT2xgUikU7FErhrYAr4BT7cIMnxdxj4A2Bh5AxMEQ5D3dJwv+wA7y6D5PaS5dHPuZKBZ37C
	AHmnaynPdnG9Zncst9IID0kjTymDQ4o0JTwxC7kWN8s2XmHo0fsEAA72vVqytHVtSU+YlqpTtJhfC
	wl5qwX8FqhV4kC4JfS0hXZj1zh9o13t49yltKTZtBarypek9EBfj0ZeiKKAwuFevVdImNusmqVKal
	r9fx2iaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDYMZ-00000005DjS-2Led;
	Sat, 10 May 2025 00:46:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDXJr-000000058r6-2Fex
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 23:39:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F2C40629F5;
	Fri,  9 May 2025 23:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E4FC4CEED;
	Fri,  9 May 2025 23:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746833994;
	bh=p4B2PhSgyE9Wbq0XXzziMjz6lqwI7FUVKn7gWMtYXiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPxlPuoBkPCkxfOB+4h5DD0yDAls/IunU5xdQviJQffdGT98xb8L+3+KbWNy6qN+y
	 tJTaBGg2j35xmGOXywqM1sLVEErVZjdYN/qPilFA9Lr8VDOqZkuaQf5WdQFo3kFB1s
	 YEGTZpJUEww0zwF6gsxII0cWa05/7h718/kBQjkzP3HyB9TC7bdsot7M9hXoH1uQ+L
	 vXuDdkuKVCKikH5jXrU9FmRPu00RETn52DIS9XxIeBlcCEnn7OdvC9Il5mpCdG/tAx
	 pGUGKIru+oaFX2nbwAKe9+c83FNYpTAE49ncl14qdqoiDF9KGxkctL1eCB0QxpkMq0
	 WjA5MWL3G5gzQ==
Date: Fri, 9 May 2025 17:39:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: 'nvme list' shows 100% usage on empty drives
Message-ID: <aB6SR-zVZ25M52qp@kbusch-mbp>
References: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <aB5I2UjeRiudiQnu@kbusch-mbp>
 <SJ0PR03MB650108CF09FC9A51D35AE3D9FA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB650108CF09FC9A51D35AE3D9FA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
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

On Fri, May 09, 2025 at 10:05:58PM +0000, Eric Robinson wrote:
> Yours is the first coherent explanation we've heard. Thank you. The
> only thing that concerns me is that we had this problem once before,
> about two years ago, and I cannot find my notes about how I fixed it.
> I remember that I ran a command (maybe wipefs, fdisk, sedutil, or
> something similar) and it corrected the problem. After running the
> command, I ran 'nvme list' multiple times, and each time the "Used"
> amount kept going down, until it eventually stabilized at 4k. If the
> issue is with the controller, any idea what would account for that
> behavior?

I think you are mistaken. Your list output says it's a Dell P4610, a
rebranded Intel Cliffdale. As far as I know, these always hard-wired
NUSE to NCAP and NSZE. If you think otherwise, this is definitely
something to take back to your vendor, Dell.

