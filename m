Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA52FA373D
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baAU/58TQugL95CK7P5NNTi9SjuXaF1/NRFFgUMRNIM=; b=dEOdCdAWlwxrmw98KP5XE9d8Bf
	DK0uTHS4XQpa+l2oKkMKi7g1pOvZzv2pKuNegx8YRyvW5nRCnXFJPL9EsnEe3UWVjO7Al1NQNSbgX
	/VxJwrh97WsOKCiS92YVPuPKgiCxTCzQdHqxJMJLUFz7JLg+zsLV3m564Lf5SPLTiuGPBAGlCJTsL
	DLUNfcYvuFlfbhL15l2LbRST/kQwS+hPd1CmhkgoevdMQoglby7/ui6A7WBwhRDXYYIgxI0SRk71V
	7gHsWm7aWBWwX+jTIZ8se+9sMTTqXJ0Dq6ehgKm+v+FUBfd3ROZGI5iYseSMoxxGrs6kCXBq96W9T
	amfqemrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4c3-00Ep6j-Vt; Sun, 30 Oct 2022 09:28:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4c1-00Ep2O-OR
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 09:28:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FFEF68AA6; Sun, 30 Oct 2022 10:28:09 +0100 (CET)
Date: Sun, 30 Oct 2022 10:28:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 07/17] nvme: remove the NVME_NS_DEAD check in
 nvme_validate_ns
Message-ID: <20221030092808.GD5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-8-hch@lst.de> <acc757b0-2d4d-6f1a-504e-73eadef59d35@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc757b0-2d4d-6f1a-504e-73eadef59d35@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_022813_980051_828B047F 
X-CRM114-Status: GOOD (  13.58  )
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

On Wed, Oct 26, 2022 at 03:52:25PM +0300, Sagi Grimberg wrote:
>
>> We never rescan namespaces after marking them dead, so this check is dead
>> now.
>
> scan_work can still run, I'd keep this one.

At this time the controller already has a non-live state, so the
command won't make it anywhere and thus except for a tiny race we
won't even get to this call.

That being said if we flush the scan_work earlier this will all become
moot anyway.

