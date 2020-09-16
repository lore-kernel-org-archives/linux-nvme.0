Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089CBC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 08:44:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B177920872
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="whGo4QBs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OYxoKanS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B177920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CbiizWoT9cCg7Wj/Hp4lms3Q/8g89PieoK9xkwR/p6I=; b=whGo4QBs8aKQBjIQVT2Fm2/g2
	f0MKp9CNKH/EqUELIs5OqF8ZMEZTy1DfRJhi4KfOkOwK5bp8R8xfa4oOFSg1kYBJxIMCru8ye6JZR
	MJ9wa8AxwHhCoWQayQMY+wY9mw0U57cm8AIGdUlxb8zk2eC/rxZ9r8974+8vCHMW7J/xo+5gsE+0b
	GAvRo4a+f4zOylzVA0Ub5yAgn7TQ5dOhNso1ohr5BNWMb5sKQ7tZ2JU0ScK2KmgacHKTkNMlpBkWJ
	9tKCGBOQ3vL9XlrqvnhimL0Z6F0pKEOui2Kt/7UufAiUBBVN0r8Bw2h0BX0mSAeZtsBNZpZejt1N/
	37lbR06pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIT33-0003ei-3b; Wed, 16 Sep 2020 08:44:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIT31-0003eZ-Sz
 for linux-nvme@merlin.infradead.org; Wed, 16 Sep 2020 08:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nfrFA0foo8zWdiu2alosZ7SVP9E9CkN7ptxWQdkhm+E=; b=OYxoKanSZ4g7I2+f6RWnhSwrDe
 cmsLcuC+IIXkZtLBYMvugbRR4g1HHbpAdlfcXZZOs4aR2wYf1mbeO5W/xT1igHjFGNAeSjYsFKI6s
 ab3cnONOG2WhuWwZ1Z8tb/ZpDQo5wOJAlTMBwpMIo7NXXxln2yE7wpmS68zAKOfPtUNm3JyNA175R
 rinckuaAToJXt3Ddgfz82n0/hwvs2Yq1HWgAqgUSxTS8CP/xHdOQC9nsAHGIxRl/Fd+asK+iIUG07
 1anBIf0Gj2xLPtJTlw/oTOyn9rulp0ZJZp432O0RSP38ERgyC3YJm3KE7jUl4PhRQGj9nyFPYJyJn
 AqIsJX8A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kIT30-00080r-Bc; Wed, 16 Sep 2020 08:44:14 +0000
Date: Wed, 16 Sep 2020 09:44:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: Dual controller sysfs Question
Message-ID: <20200916084414.GA30297@infradead.org>
References: <BYAPR04MB5656A018DD122D37806A8EE2EA240@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656A018DD122D37806A8EE2EA240@BYAPR04MB5656.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Prathiksha Nayak <Prathiksha@wdc.com>,
 Yuvaraj Hosanthe <Yuvaraj.SH@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Akhilesh Rn <Akhilesh.RN@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 11, 2020 at 02:40:05PM +0000, Jeffrey Lien wrote:
> We need some information on how a dual controller drive should show up in the /sys/block directories with respect to latest 5.4 kernel.
> 
> Below is our observation :
> When tried  a drive in a dual port mode with namespaces attached to it using Ubuntu - 5.4.0-45-generic kernel version, we could see all the block devices getting listed under 'sys/block'  path but when we check for the block device uevent path of the attached namespaces  ( i.e /sys/block/nvme0c0n1/uevent) we do not see the DEVNAME details in that path but we could see the DEVNAME details for other block devices under sys/block. 

Those are the hidden devices, you should only see events for the
public facing multi path device, e.g. /sys/block/nvme0n1 in this case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
