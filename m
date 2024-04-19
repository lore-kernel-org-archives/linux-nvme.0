Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B258CC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Apr 2024 05:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9SvDbZKcV9xqpC3dgYD9xpPe1DfACI1dXG2VvZvDg1g=; b=zhb8sUqFGwMTWtB1q3u4n1s8n5
	zg8cdX56iO8BH6knXnZZs8q8q7/6QPSt6hxyhc5d51/QJPu1lZgON/LMzahrG9TFXDt4SsO3sbzJe
	HDsMXdZV+cTH3h5skniRhvZhBFwHVgHNPRqbdAuVL8p3iinhLNaIDqbA07wvAUF/WUOjIqmb1s2S+
	YTr0Ud17lWmVKughZ2WwOan5rX79xAUugsd2aCAw2KFMA7tOP/qwl3UtmbBrqf/GH/1it0bIgH9jQ
	XMqKUv0Z9yb6zKPVPIrfdZbPA06HgM/6WZwsRwgW/r3hwIO03o4JmrQMp0lLWkIPhR+Pl8SntPAqT
	UHqZXj/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxgaa-00000004RLe-3svX;
	Fri, 19 Apr 2024 05:15:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxgaW-00000004RKJ-3ePt
	for linux-nvme@lists.infradead.org;
	Fri, 19 Apr 2024 05:15:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3291E68CFE; Fri, 19 Apr 2024 07:14:52 +0200 (CEST)
Date: Fri, 19 Apr 2024 07:14:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Ewan Milne <emilne@redhat.com>, Tomas Bzatek <tbzatek@redhat.com>,
	"Farley, Douglas" <Douglas.Farley@dell.com>,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Frederick Knight <Frederick.Knight@kioxia.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH V2] fabrics: Always pass hostid and hostnqn
Message-ID: <20240419051452.GA11501@lst.de>
References: <1713450277-20323-1-git-send-email-israelr@nvidia.com> <04c77907-073a-4adf-8a6a-a2b3af28a853@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c77907-073a-4adf-8a6a-a2b3af28a853@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_221505_081224_2F95B35A 
X-CRM114-Status: GOOD (  16.58  )
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

On Thu, Apr 18, 2024 at 05:48:41PM -0400, John Meneghini wrote:
> The first is TP-4110 Align Fabrics and PCIe Host Identifier Setting.
>
> From TP-4110: this is requirement for the controller.

Only if you actually implement the TP.  I don't see any reason why
we should implement it.

> Basically, we want to allow all Fabric hosts to connect with HostID == 0. 

No, we don't.  Some people who pushed the agenda in the working group
did and we had to fight to not make it even worse than what got
released.  Doing so would be a retrograde step.

> There is also TP-4126 NVMe-oF Boot HostNQN and HostID. This is a requirement for the host.

No, it is not.  It is a way to be helpful if people implemet the braindead
pre-boot stuff.  There is no real need to do that.


