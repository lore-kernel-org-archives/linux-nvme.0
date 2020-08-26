Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B67EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 01:04:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2538E2075E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 01:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cIqIVKgn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv96jh2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o7O1EqIaT4pRFvVqxhbBeyxZkCTMd9mPJ01cFIHCskU=; b=cIqIVKgns4xQfA7gh8yU7PcqB
	Q62D0LNxWaaL0K3kHRLIvhHI4D5VUVUTAXr6HZmtxblYPxIUBtirZFqce8NhOUyV49aIUgOycd+FR
	H78pYf73njLjbyWeaLvTAm/SaPrA4GVKU2x1LKWbx1UVUyPHD0DXVZ0DxFy9+kvSuwT9JWSwUglfL
	g1ruVXMqIS6P+ct58uHqlDP9tZHdg7J4AHWhJOcld/9HZRvF6ifAN3m8R9U8X6eT+3eRoh1NgHYGM
	t12Iiyod622TdEHN3m66iQ6aR3wYwEKK7kp1guIiavEI3qHjPjXTFU2P3fyxNPy25a3195nyMSW5n
	V8FlvrvgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAjr0-00071N-Kh; Wed, 26 Aug 2020 01:03:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAjqy-00070r-5z
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 01:03:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 827FC2075E;
 Wed, 26 Aug 2020 01:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598403830;
 bh=JnXhY4hEOorazZgAHnhfUY4sUB8GI7JhCUAAXo/sGSY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vv96jh2/JBC2n9qZ7Asewi3dGabExB7c0fE0Dip7rr4uCtsU5KqNnzDYZbxrR3y95
 iWmAiQNX7NAAWAULhFWB6lL3I7FjXCC7q1/Cm8Pe9jr9YHb6gjm9DpMVAsDGrUYJp5
 eif0zjBDKk1I9NAVkhFxDcntWdThyi6rrOjLjIrw=
Date: Tue, 25 Aug 2020 18:03:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chris Worley <worleys@gmail.com>
Subject: Re: "Connect rejected: status 28" from "nvme discover"
Message-ID: <20200826010348.GA2149583@dhcp-10-100-145-180.wdl.wdc.com>
References: <CANWz5fhgxK5QDJpKKnpDYQ9qfuOmru9M=oLdGEf8OkaW8bd8uA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANWz5fhgxK5QDJpKKnpDYQ9qfuOmru9M=oLdGEf8OkaW8bd8uA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_210352_334791_4824419B 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 25, 2020 at 11:59:28AM -1000, Chris Worley wrote:
> Running CentOS 8.2, using native drivers but following instructions at
> https://community.mellanox.com/s/article/howto-configure-nvme-over-fabrics
> (but not overriding the native drivers with MOFED).
> 
> Hardware is connectX-3 HCAs.
> 
> Target setup goes okay:
> 
> [root@localhost 1]# dmesg | grep nvmet_rdma
> [ 6366.612458] nvmet_rdma: enabling port 1 (10.4.0.6:4420)
> [ 6376.078826] nvmet_rdma: enabling port 2 (10.4.0.6:4421)
> [ 6385.662419] nvmet_rdma: enabling port 3 (10.4.0.6:4423)
> 
> But discover goes awry on client:
> 
> [root@localhost network-scripts]# nvme discover -t rdma -a 10.4.0.6 -s 4420
> Failed to write to /dev/nvme-fabrics: Connection reset by peer
> [root@localhost network-scripts]# dmesg | tail
> [ 1688.058291] nvme nvme4: Connect rejected: status 28 (consumer defined) nvme status 0 (unrecognized reason).
> [ 1688.058410] nvme nvme4: rdma connection establishment failed (-104)
> 
> Systems ping each other.
> 
> Hnts?

Does the target's dmesg mention anything after the failed connection?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
