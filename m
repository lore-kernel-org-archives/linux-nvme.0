Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC66C7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zUpzD7Nb2EbOEHHrQBXFvHTpF1AkslwVVO604KfrbXg=; b=fzdIvNAoI+CMfWun8d/ECz3FxF
	dS8n9Bm1EuYLBwZki44cwhJimFHO/yrSwQQY7QPGvKzva9aPrdRbuL9vTTDq07ROS1LsfGLfsq1YE
	QLRRdc8FBlX8fgw8ECgbZ6QLBMj3CQgoDJC+v15T/I2qTQnPU81zofYCeF+kG6lKYagO2m51hMr1e
	44Fsj8Q4y7jkVS+9iN+F3IatRpH3zBxrosWWRyttYeN9z7txHtXXBOBsAp1MDLO9KeAt6wofYf74u
	vjeYQ0Qe5HABrPd22a6Rpvwi74pOoBNsX2jmw5V4lkJ+C15dLexO+IKLN9srv1WMF6mcZQP7IZjxQ
	y4t5EV1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwP1e-003fkx-0F;
	Tue, 09 May 2023 15:13:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwP1b-003fkJ-1H
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 15:13:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A65DA61ADD;
	Tue,  9 May 2023 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF49C433EF;
	Tue,  9 May 2023 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683645189;
	bh=bLtUC33HA1fZIzmEzu+kmDHKIWCIxdBOaOWEX3VsXN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IEvZqweO4GE5ERsu9bY7MAcpWfgbWZKqvqHxnCWwn6ZSTlJ5v7fIf8daobS+BOA1r
	 3XlQYcPppORQnL5ybjIxRlxw9PSzmGlpXE7HgZMZYrj0AvtTUG1/Ax5ksTf3vyxwIq
	 SGzHm3jL0NEC2UJnVa0C34YyVTxhtaZq92UF7eCczmBjHw1gtRcnBm5DhdaqDVV8/J
	 0ZFnP6FRNHy871n71n8LTDbIbpjiuuWu/NxnPgF3JILO8gGT85Bid4AhWtALVlgbaD
	 kJ0PW2/8AKzaEtNk3IRQ8o3NkD8RKiLuUr8mSAldMfK7p2BaSD6RKoARctNw3Zhgl+
	 2OJX4jaKCGxrw==
Date: Tue, 9 May 2023 08:13:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 07/17] net/tls: handle MSG_EOR for tls_sw TX flow
Message-ID: <20230509081308.4a531d4e@kernel.org>
In-Reply-To: <f3fe3fc4-b885-d981-9685-4b1a377db639@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
	<20230419065714.52076-8-hare@suse.de>
	<fb934ee3-879f-f33f-efeb-945ccc9dc9a3@nvidia.com>
	<f3fe3fc4-b885-d981-9685-4b1a377db639@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_081311_493566_B8719156 
X-CRM114-Status: GOOD (  15.98  )
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

On Tue, 9 May 2023 16:18:30 +0200 Hannes Reinecke wrote:
> > This seems like a nice optimization but seems not mandatory for the 
> > acceptance of TLS support in nvme/tcp.
> > 
> > I wonder if this can go to net/tls as a standalone patch ?
>
> Errm. Without this NVMe/TLS will not work as sendmsg/sendpage will
> bail out.
> So yes, surely it can be applied as a standalone patch, but that
> only makes sense if it will be applied _before_ the rest of the
> nvme/tls patches.
> 
> Not sure how best to coordinate this.

You should apply it on a branch based on -rc1 and then both us and
$appropriate-nvme-maintainer can pull it in.

