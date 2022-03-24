Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E790AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pltCZbKnihlOyCMttCpOKdTH1UNxNk/MCAs880Z33xQ=; b=aXGdNNe5hamVvAevPjhBKPsLqp
	QDm+DHJeE1+fr3B1LYhPQsyscr6onKJAvxnt8W3Awdcsc5L1wSSrWXThl0oePtCBGXCVoTTPHn0a8
	2/ZQNAng9NdbfAack/rxkdObUigmMf4BCcNhey9GudxxNrhBqNnxn4f23RgOz1eNHHeDp7Xz+kIDH
	F2X2sg9liTZjYdr9QzlmeXmJ4YdbAOs3nLL9C2V3MtinLM2+ZkHLCAh0ApiNjWC6rRmDYXNk37I23
	/7RkOJJV+bO1bjeIIocCEsbOYWefHg4PKVIoSSr0+uMtRt7K2DrNg0TA12bN9+47LqQmNPw3LXuAC
	I4WDAgSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGF4-00FfSv-JU; Thu, 24 Mar 2022 05:42:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nXGF2-00FfSX-QN; Thu, 24 Mar 2022 05:42:36 +0000
Date: Wed, 23 Mar 2022 22:42:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] dispersed namespaces revisited
Message-ID: <YjwEzJrIOprc6cfc@infradead.org>
References: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
 <YjtKYETOnoI6/x4E@infradead.org>
 <da128051-4d15-1566-2876-5167a0c1d033@suse.de>
 <4e1aaadb-0044-6367-e4a6-e3f159fa007c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1aaadb-0044-6367-e4a6-e3f159fa007c@redhat.com>
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

On Wed, Mar 23, 2022 at 09:17:58PM -0400, John Meneghini wrote:
> I agree with Christoph that the current conception of dispersed namespaces fundamentally breaks the NVMe storage object model.
> 
> However, there have been several ideas proffered at FMDS to fix this and I
> think people are willing to make changes to TP-4034 to redress this problem.
> 
> I think this is a topic that needs to be discussed at LSF/MM or ALPSS.

NVMeoF has been designed to support more than one "virtual" subsystem
behind a single port, and thus use the subsystem as a lean per-tenant
container including the ability to scale and migrate it over multiple
pieces hardware.  And ANA and Domains have made that even easier.

So really what we need here is a clear explanation of why this does
not work for the people that scream loud, and why brekaing fundamental
NVMe abstractions is the way to go.  This is the specific question I've
asked since the TPAR was proposed but it has simply been ignored.  And
no, dumb implementation with a lot of legacy baggage do not count.

The array vendors need to do their homework first.

