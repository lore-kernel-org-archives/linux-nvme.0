Return-Path: <SRS0=uo1w=AI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE0C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2020 06:52:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B035C20857
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2020 06:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sg6f2isr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpRd1Lqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B035C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5wFYyv3/FR05fIbA4JYXL0JYPPliatwz/bvR7Zzrzko=; b=sg6f2isrfG0vXM10ryxpeFpK6
	QsQsCKd2GF31y8N+8WahvblT3htU/nr1LYjqciV5bRXgwuIMwQcpfOGzmGW+saXuG3L/dEe2U1koY
	0HhTmfCePMW9ee9pwDjJ4Hyt25sovzcS7vlw51o5TiepodwJOYAb8NQFBqr/M1RGAxeecq08QaY3E
	0FGsTvGw2ZaCTbSTyrWd1MCChu745tt964jlBjWOLwDRUL6kKEt3dArn3ije8IMGih2rjWjxKH3kZ
	OKniJw3tfxg/mH8/L7SCqWLGUlw8hFJ9K3H5cZdiWQXMOQUsf6Fm9JNh/Om0P1NaVzhSQpLGY/yf2
	a4l2mPzhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jp4hJ-0006g8-6X; Sat, 27 Jun 2020 06:52:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jp4hH-0006fz-B5
 for linux-nvme@merlin.infradead.org; Sat, 27 Jun 2020 06:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=OLtu7ANhBiJnYoq5E3o6Tu2T061iZ8kZq0TbYKm2NJs=; b=SpRd1LqtSD6q2I6R408rgPMgmC
 nEQg5iQTF4jNEgTFc9nVdSFfZzpB7g+dOrPFtSpDdgu6UvzZrDYPsIm3jqdDrHN/OkuqQvCuU75KX
 ID/HdOozih+4XZiVmoxJossAVzi8SxVuDOpirFCakgf6Q2eXdoyxBP1Rdorve7BmuX3Ze75D0qsPI
 uT1MSzG3cJYodcGhqfuhFkBv23Ux3x6RZThQy8iUb266AKC9uwLp4q0O4yA+AlYzJ3CKl3qOHBDGF
 09aZgZoD8sOFgVzI2f8gcW66JcRbyDvW2zqrW8q/VGkALCAcocs3UvlRpxG6N6YLVfQM+6MZb6BVo
 bz1bMHkg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jp4hD-0005Kg-1v; Sat, 27 Jun 2020 06:52:15 +0000
Date: Sat, 27 Jun 2020 07:52:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: blktests nvme/004 failed on linux-stable 5.7.y
Message-ID: <20200627065215.GB20157@infradead.org>
References: <1517012281.32343351.1593228195746.JavaMail.zimbra@redhat.com>
 <1528690896.32343478.1593229315244.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1528690896.32343478.1593229315244.JavaMail.zimbra@redhat.com>
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
Cc: hch@infradead.org, dmilburn@redhat.com, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 26, 2020 at 11:41:55PM -0400, Yi Zhang wrote:
> Hello
> 
> commit [1] introduced regression that will lead blktest nvme/004 failed, and commits [2] fixed this issue on latest linux tree.
> linux-stable 5.7.y has [1] but still not pick up[2], does anyone know how to start the process to include [2] to linux-stable tree, thanks. 
> 
> 
> [1]
> 64f5e9cdd711 nvmet: fix memory leak when removing namespaces and controllers concurrently
> 
> [2]
> 819f7b88b48f nvmet: fail outstanding host posted AEN req
> 1cdf9f7670a7 nvmet: cleanups the loop in nvmet_async_events_process

You can always send backpors to the stable maintainer..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
