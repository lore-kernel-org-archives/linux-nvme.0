Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6E6ECAAD4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTD4vkKdl/8JE62fAvhqroKwZk3JK69BSlVKTdGE7uU=; b=MPOibxwFtFPQmUOd9dHjxjDw6m
	oShPOImFyTuG+yI6soH4HcYJZWG1McZ1aesaIzUr6NO9looGzQP/BgMs1zfx3YQMZr8vmz4PrLogN
	a78iNVMX62Xj7+s2VJQmSvk8ATNUfujZWXysMCpPEPgIiFbriJj+pdR4Bglbm8kxRumDRZYTBrRjn
	T8YjpYigTRII/8XM+HuEWXxa8WUS5veod7nh8k9KMoIwEinvFx7znpAi9X4Wfj+/+shyZVZj4POQn
	XKO1bEtMWt3hpiF+kKfHkMZqmcVKLex5rVodfKSBWSncJ9/3Y3axBLeIWr2SzDCUNDgYp4pclV7xs
	M4dbkOBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTXWQ-008fGN-DN; Wed, 31 Aug 2022 23:53:26 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTXWN-008fFn-5v
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 23:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=LTD4vkKdl/8JE62fAvhqroKwZk3JK69BSlVKTdGE7uU=; b=TwMHM0ixt8oG9zUIGNVqBosx/V
	11RMsBEDlRZk8wO/YA8ft3p3oyQ5BtMLXZsH6B+qhlXGjP9gqSCuUyKBfl8miaYnz7jNTC53lOSfL
	R1v/qHOzd0LweNYk+o1kzFDCQhQEn2H6F3psASXuxMwgC0AqcDph5UoDxEAIQpetk1NeczLI2V+b/
	hNTYFZbEjRfk0/Km3ag91r/4+hh8hW9Ad27e7wxknkcGjOZn+5frSe+fQR4yZCMJqqv4FhzI49rJb
	218F1rr8c18xejO47H+Ti+T/12EA5n2GJKoGx6NF6vOKc4JM8pGmMY/0339mv3hYTg/Q7c0SJLxU6
	1vw00s0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oTXWL-00Amej-9y;
	Wed, 31 Aug 2022 23:53:21 +0000
Date: Thu, 1 Sep 2022 00:53:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't map pages which can't come from
 HIGHMEM
Message-ID: <Yw/0cZFCQQpx3hhZ@ZenIV>
References: <20220830220533.17777-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830220533.17777-1-fmdefrancesco@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_165323_237456_E3C32250 
X-CRM114-Status: GOOD (  16.91  )
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

On Wed, Aug 31, 2022 at 12:05:33AM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().[1]
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> The pages which will be mapped are allocated in nvmet_tcp_map_data(),
> using the GFP_KERNEL flag. This assures that they cannot come from
> HIGHMEM. This imply that a straight page_address() can replace the kmap()
> of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
> also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
> after removing the kmap() calls, there would be no longer any need of it.
> 
> In addition, there is no reason to use a kvec for the command receive
> data buffers iovec, use a bio_vec instead and let iov_iter handle the
> buffer mapping and data copy.
> 
> Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.

Looks sane...

