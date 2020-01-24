Return-Path: <SRS0=TgIa=3N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EBC2D0DB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 17:28:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C8C2071A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FhDrhdBz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zRe2haba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C8C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3mSvPit/qWbOQ3kH6ML3xM1NLvgJTLwe5xdfHskXkZw=; b=FhDrhdBz+/TOGt
	oLdJbx1MhXBADj7JsZVbhNlExES9AwvFR6wCn83R0aLEe8aYlk5e6YzqmBUPiHc7CUF/8LldE37ty
	CQBnxsVd0gG+V0OPCgZMdlnT5Rj0kGtVyU257vYe0y9u6dpULCbv5kxEr+/rmABu/ODKFiuenyaOp
	tnXh23/FS0H22TKnCA5dddk+zldQQjTS9AeXCAhPNK6Qv32+WZu839h3U8WTzHE67mmOkChW40OVV
	hUE1khL8Kde/6PS8EbxIQdzmJKQPUSPuAlRse6Cyen520ZMeTIeMIwiPfvq+jfW6ElwnmwPIM6ahF
	O0DmoavIUNJV6AREW4ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iv2kf-0000sJ-Oe; Fri, 24 Jan 2020 17:28:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iv2kd-0000qV-4P
 for linux-nvme@lists.infradead.org; Fri, 24 Jan 2020 17:28:12 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48D6A2081E;
 Fri, 24 Jan 2020 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579886887;
 bh=xKeYSTzuiPLpfoVHzYLcCkTA5xYucgBlImpWHbcWV68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zRe2habaFvk9T+b2yK7elYh+xguEe1nojGQ77ceriPknPrR2alzAVIxo6UFvRXJj5
 AasbxKpQdE+Eu0RhYNa7kSIeP1dWDdspxGl2v8TW+7sSbvPmH/NbK8/N7pkyu/lzhN
 hXL+RPzQUA6+/vxRHTFJSOG8TF70g9NzgXkaVcN4=
Date: Sat, 25 Jan 2020 02:28:03 +0900
From: Keith Busch <kbusch@kernel.org>
To: Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH v3] drivers: nvme: target: core: Pass lockdep expression
 to RCU lists
Message-ID: <20200124172803.GA18688@redsun51.ssa.fujisawa.hgst.com>
References: <20200111073815.7659-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200111073815.7659-1-frextrite@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200124_092811_193446_60C30CAB 
X-CRM114-Status: UNSURE (   8.97  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Joel Fernandes <joel@joelfernandes.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Christoph Hellwig <hch@lst.de>,
 Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
 kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Jan 11, 2020 at 01:08:16PM +0530, Amol Grover wrote:
> ctrl->subsys->namespaces and subsys->namespaces are traversed with
> list_for_each_entry_rcu outside an RCU read-side critical section
> but under the protection of ctrl->subsys->lock and subsys->lock
> respectively.
> 
> Hence, add the corresponding lockdep expression to the list traversal
> primitive to silence false-positive lockdep warnings, and
> harden RCU lists.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Thanks, added for-5.6.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
