Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DD8C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 21:09:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4D864F90
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 21:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4D864F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tDevxcD+09AcDig46ondQl3SmuzCdQqSKEHJg8T2nE0=; b=AudIZTtyiqjFtuNVI72xPqGoa
	CRXt5jNgFpUrpFlnhjlu6X1fYHEht+eKb8AzuOSiR16O7PZj/1HOw2sKjVPD+AUFW4X5JxRsfzgDX
	QV3oBgFdEYCgzg/XCDKiGpZYAkFn1IblYeAbruD5X/Ykwudt3Z2UK6H7VEkmYcrDNRIykjQYuXeC9
	CPJDevMzf/bQkKdbhJ+O+XlE7Jyi8v0XViZuHGae4lyiTnfeFbNd5x3w5DczhgGT/H+gOHgJlbph9
	iQxWu86yJ7x1nflY2aOUBlInvcz2fzSi7XqBjtTRDnXYGPGtZym4TnfrpHkFspcYNX4EkZouUC/EO
	n1aYVY6kA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMGw6-001s8x-6x; Tue, 16 Mar 2021 21:09:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMGw1-001s7y-2M
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 21:09:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1845D64F96;
 Tue, 16 Mar 2021 21:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615928938;
 bh=8nsu1dZXDbuAz+AZFzrA0j7Lr/rUq5irdOFWu7bc7W8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qmoe6HRPtoDCLdLPtJAb/aujsFliGQBoOPjveA0jiltOX+YUmQNAHEcY/FVeSKMdI
 8GA780NaNBwn8Uror/inqwXv95aSBaqgcSd/W05Uk3y0/dtoYzNpzznW10aP3rld/B
 SgQCCV9igu1bl2LEOJEyFBFyjY2Lsb8xSlhY4iSAJycaNC6bYLYY6CyLnsEJyeU8mO
 IvCs22YcSmsAVqhZmVcAs//iIX5nCE6W40S+SMLUl04F+0wNztkcRBX0KppD1DGQAq
 YiBl5DqGf9NEwCnsbCIEa52FV4ENoBNNfKsKHwV9Dw0jV65GjbJ3bjrgEv07GNC40P
 iSzS4yqFEswSQ==
Date: Wed, 17 Mar 2021 06:08:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zheng Wu <wu.zheng@intel.com>, linux-nvme@lists.infradead.org,
 Ye Jinhe <jinhe.ye@intel.com>
Subject: Re: [PATCH] nvme-pci: add another device ID with stripe quirk
Message-ID: <20210316210852.GB23332@redsun51.ssa.fujisawa.hgst.com>
References: <1615864938-6757-1-git-send-email-wu.zheng@intel.com>
 <20210316073042.GA376417@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316073042.GA376417@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_210901_899918_F8184E71 
X-CRM114-Status: GOOD (  13.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 16, 2021 at 07:30:42AM +0000, Christoph Hellwig wrote:
> On Mon, Mar 15, 2021 at 11:22:18PM -0400, Zheng Wu wrote:
> > From: Wu Zheng <wu.zheng@intel.com>
> > 
> > Adds the Intel controller of P5510 which has the "stripe" quirk.
> > 
> > Signed-off-by: Zheng Wu <wu.zheng@intel.com>
> > Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>
> 
> I'm pretty sure we said we're not going add more of these years after
> there has been a standard way to communicate this performance preference
> using the noiob field.

P5510 was a Q4'20 release and NOIOB is 4 years older than that!

Jinhe, is it possible to reiterate to the development side how painful
this non-standard behavior is to the nvme ecosystem? The spec compliant
method is a simple and harmless f/w change that will make all your Linux
customers better off.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
