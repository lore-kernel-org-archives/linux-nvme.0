Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063F9C3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxy69Vkbak9zsjGVTjGLdoPayVPvBj27QHGHH4yqIAU=; b=hk1Do0tLwzBJwsj/mP53n2E705
	7qi236h9zxZ62+RvHhmwOHCW1rje5eY+yawsoQ1kxW4gIBzYFu4/A2BwNxLbBs8ilFvHaOYfNVgwI
	vlh9Ei5/ikAUl2gSkMENBsfUuxVQlqsMs1YeR2A++F/im0Juz+Ai3WlbXrSTm1RbwDTxdZ+mvTlWP
	TRx/kZzJGWsUdrciXtocNzmfvT14daImNFQpUXW743Ile1KPu9dJUlX14l28aWP7AjIi+rdWapBsz
	LNp+bxcB8idZ8ycgDqWcvfW40JJ1oIUmo8dQKCvu2CrrTxWB6MXw1h2/QkS8wHNALOjv9FenOQLCG
	8ApdEooA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUihR-000000021Ha-3Wz8;
	Fri, 19 Jul 2024 08:10:45 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUifK-000000020Hp-3gSQ
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dxy69
	Vkbak9zsjGVTjGLdoPayVPvBj27QHGHH4yqIAU=; b=m75v15wAYR27WLxFk3//Y
	C5Nyp24WEXnXsO33g4Xz+7hvN2GgWGxWobt2mAhQUu6kSmucKZk3rccjTh6nHGo3
	z4yB1ZSIbUCK3DWx2liPJVbGicnysFcji1yaufpOcwgdvCfxBp4hb0sveMkE4rz4
	6axFSx326AEIg+SejvoSwk=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3PyDvHppmvJLJCQ--.60815S2;
	Fri, 19 Jul 2024 16:08:16 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP 
Date: Fri, 19 Jul 2024 16:07:22 +0800
Message-Id: <20240719080723.125046-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
References: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3PyDvHppmvJLJCQ--.60815S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8Ww1rZr4furW5Jw4DCFg_yoW8Xr47pr
	WfAa18Krs7JrW8A3sxCw47Jr4rCw1IvF93W3WkXr12yw45uF9xZw18Ka4YkFWfGF92qw4j
	yF98X34DCan0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuc_hUUUUU=
X-Originating-IP: [223.166.237.249]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBMhKWXAmWEXHAAAsF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_010835_452471_9D5B4293 
X-CRM114-Status: GOOD (  14.44  )
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

> On 7/19/24 07:31, Christoph Hellwig wrote:
>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use bounded workqueue to handle IO, but when there is other high
>>> workload on the system(eg: kubernetes), the competition between the
>>> bounded kworker and other workload is very radical. To decrease the
>>> resource race of OS among them, this patchset will enable unbounded
>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>> get some performance improvement. And this patchset bases on
>>> previous
>>> discussion from below session.
>> 
>> So why aren't we using unbound workqueues by default?  Who makea the
>> policy decision and how does anyone know which one to chose?
>> 
> I'd be happy to switch to unbound workqueues per default.
> It actually might be a left over from the various workqueue changes;
> at one point 'unbound' meant that effectively only one CPU was used
> for the workqueue, and you had to remove the 'unbound' parameter to
> have the workqueue run on all CPUs. That has since changed, so I guess
> switching to unbound per default is the better option here.

I don't fully understand what you said 'by default'. Did you mean we 
should just remove 'unbounded' parameter and create workqueue by 
WQ_UNBOUND flag or besides that, we should also add other parameter 
to switch 'unbounded' workqueue  to 'bounded' workqueue?

Thanks,
Ping



