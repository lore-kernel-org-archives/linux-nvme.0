Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E482C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 14:56:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B96E207DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j1j/dcLb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvnvQxhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B96E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2ZcsGYhmuheJDxkiEOWL8Gliort68lQcUUmx8wdUepk=; b=j1j/dcLbWlbZ511HZqaxNz58s
	q5Q+1WKWrGnw1HguQVzl8QWxjuONpLBFhyv3EtFZihF75Qw+kSjXfdktBmWzg3UXAlY/VUiqz0BZi
	4Ha3aXPpc5WPEAbiP+QUoZa8+txC7c4xsF4TFoHk19nz5JGA4E33ZtBje0a3HUDvNylASEQeUog/q
	r2RJT9EweUH9sTpG601xRdOfkSH/ClrtMaTctzWr3/SN0OjME1u80mgWQ5/GHLTC++V0gHWSgoLlx
	JEFPWgIvwVkPA/+ENA4cDxWmnBQAgBND13g9cjCJiBGz40ptUrfMmU6yom0cb55iX90OeZM6eqLFO
	rqBLLBJjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k59Dx-000237-Rc; Mon, 10 Aug 2020 14:56:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k59Du-00022a-K6
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 14:56:27 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE7552078D;
 Mon, 10 Aug 2020 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597071385;
 bh=0RHd8JAHdjQJ25noxFef5mq2U8oosC4wzRsZkZn/zLE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LvnvQxhAfs3sm33zr7XDVd0BNyMh2fO6b8hxs8uuaVvQaygk6vJjShIwvHntLChkA
 N45UdFGZtKR967sP7WXz7vnVTYmRoVwj3rSr6z9eQAhglDTgu/QGkAOwTN+8yCQ1ua
 5l9vM04jpaFKf8c/xQr7OtAWF2c/j7JuvyeSY7jU=
Date: Mon, 10 Aug 2020 07:56:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme: skip noiob for zoned devices
Message-ID: <20200810145622.GA4159317@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200807163235.4155607-1-kbusch@kernel.org>
 <20200810123313.GA20069@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810123313.GA20069@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_105626_766416_4C2AAD6F 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 02:33:13PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 07, 2020 at 09:32:35AM -0700, Keith Busch wrote:
> > Zoned block devices reuse the chunk_sectors queue limit to define zone
> > boundaries. If a such a device happens to also report an optimal
> > boundary, do not use that to define the chunk_sectors as that may
> > intermittently interfere with io splitting and zone size queries.
> 
> Instead of skipping shouldn't we use the max of noiob and the zone
> size, even if that is mostly theoretical?

No, I don't think so. If noiob is larger, we'll return the wrong value
for blk_queue_zone_sectors() and blkdev_nr_zones(), which will have
undesirable consequences.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
