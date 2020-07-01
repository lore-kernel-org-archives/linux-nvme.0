Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB65C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 13:21:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6587207D0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 13:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TCt7ZC/u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8q8+tLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6587207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mzzInsq0r8Oy/OmcLVFLeBu7rExs/ih+Z+nI+7R1PRI=; b=TCt7ZC/uDHKLLD+ddui+33Y2v
	GZZ2PtfQz4E/zr0qsdVpHGc0buyblizsNP0z7l57n7e25zORHjtN6a0NDlG/bYHm90PS7VJmYY7aV
	/ZzEP4xjWe+XNiHkZq5iBTnmrA8gJuLG+jvkoYenQ5U2lx7tspwVQEkQs1yLAFqPROgnmtwwee9yw
	QcTibWeo7LI7VpVaGDYWwVl4ThdwK69yQQcQlGXUS49b3A1nHtU9pWohGl56eAokGf2roY4ynXxIp
	gWFTZDpE5MrEEr+k3XfTw9yF1TQj5NWVXgjGfE0k66zyMNkbalyxsGXzOPUj5kkXld/KmMr1KyAl2
	2tOtf4ipw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqcgJ-0006ns-Bx; Wed, 01 Jul 2020 13:21:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqcgG-0006nE-Sp
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 13:21:41 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 963C520702;
 Wed,  1 Jul 2020 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593609699;
 bh=bDytJjgjFGriMO4euecDO7CZ8UsgCcc2mr6P8UdRLxY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B8q8+tLlSP+3vO6buSNu57WbRF1+rjnAMayde82/ZtrjvhKBJOZJIBM+pD6d+YmJM
 fuhBQRJMgDvCg9va1v1yaQvl481Oqa/R8orRAaC2L0Q1UK55D1LMt0mZqZ7zpe4pUU
 kD9SuoE7RYv+xcxKTvYH89CeOhuGUSRzkgjR55jo=
Date: Wed, 1 Jul 2020 06:21:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Message-ID: <20200701132137.GA1988944@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701053609.GA28056@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701053609.GA28056@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_092141_016976_28A9902B 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 01, 2020 at 07:36:09AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 30, 2020 at 07:25:15PM -0700, Chaitanya Kulkarni wrote:
> > Hi,
> > 
> > This is a small patch-series which replaces ctrl->namespaces with
> > xarray for host-core and target-core. We can see following
> > performance improvement when running fio with 32 parallel jobs where
> > first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
> > detailed performance numbers. 
> 
> Why would that make any difference given that we don't look up namespaces
> in the I/O path?

Not in host side. Target does a lookup on each IO through:

  nvmet_req_init()
    nvmet_parse_io_cmrd()
      nvmet_find_namespaces()

And this detail should be mentioned in the test setup for the cover
letter, or in patch 2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
