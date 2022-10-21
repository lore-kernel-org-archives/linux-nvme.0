Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAF7C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGX5EfDaqzQGC357K/rqqnHlN5b60wVA5lCcrIjB3dE=; b=LzEm9lMJZhPKjmKYCPuVoVMnL+
	eRsUalX7HGtPyBsGzLLeh2qUnfiz3nAUqEvzyWbmqOLS8AXZv8vNVfFpC7W3cwPQCFrVWT3SIbbQT
	xOE+vLE8+5S6zscQObBJ2Nm4ztaTOpakgkpcIh1l4GChgT/Ud4+zDnrBPt0TRxKe6Hk1Yhf9pXC+T
	qfXmf1MNUPRy6rmKEKR0ybxgindQN8Mk9v0mMU2K+3I6PADolPRenxvix5FGm/AAlqo+D8JxroLaj
	GUPUdEuEmJ/NuhrrjqSt3hBlRx2b+05KBAIl6fr+b4J263Qmk0/9GYlShCj89zS00oItOvHB4RuHq
	2A6evLvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ols4U-007xc4-0E; Fri, 21 Oct 2022 13:28:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ols4R-007xad-IN
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 13:28:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADA2D68B05; Fri, 21 Oct 2022 15:28:15 +0200 (CEST)
Date: Fri, 21 Oct 2022 15:28:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Message-ID: <20221021132815.GE22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-7-hch@lst.de> <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_062819_807477_F8D72A34 
X-CRM114-Status: GOOD (  18.39  )
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

On Thu, Oct 20, 2022 at 04:30:21PM +0300, Sagi Grimberg wrote:
>> -
>> +	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
>> +		list_for_each_entry(ns, &ctrl->namespaces, list)
>> +			nvme_set_queue_dying(ns);
>> +	}
>
> Looking at it now, I'm not sure I understand the need for this flag. It
> seems to make nvme_kill_queues reentrant safe, but the admin queue
> unquiesce can still end up unbalanced under reentrance?
>
> How is this not broken today (or ever since quiesce/unquiesce started
> accounting)? Maybe I lost some context on the exact subtlety of how
> nvme-pci uses this interface...

Yes, this also looks weird and I had a TODO list entry for myself
to look into what is going on here.  The whole interaction
with nvme_remove_namespaces is pretty weird to start with, and then
the code in PCIe is even more weird.  But to feel confident to
touch this I'd need real hot removal testing, for which I don't
have a good rig right now.

