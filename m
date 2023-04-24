Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F994C7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 06:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Oc/dQm9V4QmVlQ+yHvyFuNUYsb0WYrwV7eVtNG2VHI=; b=aYS35mHRTVKwPxz8Org2nLJIQZ
	OlGjqSaQKCysKjyNgRokEi9jvpfmrw2lm2hSMFlW6qEx5vDqunYLQr7wRuz3PJrj26AZj5Ee83ypj
	fGyELODEM3F8WQOCSUdTGQ93hIfsgr4BNgiiePtYK1spypgpaFbsmjkWhT8CnaVMBpGsSlW2B+wL0
	WGdtrFjqPnsRn4QsvoBB15VY1YNwDmnRgVqYLpu4L3gGE8bx2orazqrBIN44jQ5KKHpoPino8e+OU
	GFWha9B6/6zO7HrOjUrnMHOrWaLNEDjgRESCkESf14HdaCyIzCFzRbQCnNkS18NbnZSyX3eJOv13F
	jwT3I5sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqpZC-00FT4T-0v;
	Mon, 24 Apr 2023 06:20:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqpZ8-00FT3z-2A
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 06:20:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D49968B05; Mon, 24 Apr 2023 08:20:41 +0200 (CEST)
Date: Mon, 24 Apr 2023 08:20:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
	israelr@nvidia.com
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Message-ID: <20230424062040.GA10281@lst.de>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com> <20230424051144.GA9288@lst.de> <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_232046_876573_D855C77E 
X-CRM114-Status: GOOD (  15.83  )
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

On Mon, Apr 24, 2023 at 08:10:59AM +0200, Hannes Reinecke wrote:
> Yeah, I'm slightly unhappy with this whole setup.
> If we were just doing DIF I guess the setup could work, but then we have to 
> disable DIX (as we cannot support integrity data on the non-PI path).
> But we would need an additional patch to disable DIX functionality in those 
> cases.

NVMeoF only supports inline integrity data, the remapping from out of
line integrity data is always done by the HCA for NVMe over RDMA,
and integrity data is not supported without that.

Because of that I can't see how we could sensibly support one path with
integrity offload and one without.  And yes, it might make sense to
offer a way to explicitly disable integrity support to allow forming such
a multipath setup.

