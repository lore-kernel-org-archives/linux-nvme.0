Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F40C43461
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 15:30:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE37020BED
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JI4eFFHm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qeo2LZCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE37020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DuuW3sbXeExxBlRitkvsx6KZN8g6NaRAFXj2nSiHn/o=; b=JI4eFFHm6yOybBADomzGyz6sj
	tdf9LojRPXpJzi0t1MHvvbd3VTJS+KSV9oAfWpybHOEjIWPTCF2ZuVA6DjzQdEi9Bo2GaNdM+msUP
	M5OMLX1h+uPfqfGaum6lRG9ibpfFausScmiAqGyxhU+f6IjsKUyaGpGl2qJy7I99nFqitrthdP8B1
	C+SEbS3eXuGA88t9i/GlUCZuT9ZLw5BFPLwsXj85eaakzCkNBSyK0vkmZDUAHY3Qu3y8xftLDQjyM
	RZRPniEcGLeNFqTaMjfUiZt6KIXTHHd//uFnXOWQPXotmfWuE1iqNeU5bl5GDHRVUE+xuZgo3Q3v8
	6EhtWC3aA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDrBe-0006dm-Ix; Thu, 03 Sep 2020 15:30:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDrBb-0006cC-98
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 15:30:04 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD32F2072A;
 Thu,  3 Sep 2020 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599147002;
 bh=jXGxU/3K+/Gt9ZZGZkFra+/Zm+e22XYkqmgmcPRyi8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qeo2LZCDIygwi1t1ZeH3aaAFPl2N6NGKaGrWgCFN/zahbR9gVQrM9xizo9u8KdgMT
 cF8vz/dM8mS9By7ZlGXS4DpgW4cHaiOv9rp8rASuBnJff53pzlvMzB9tHm4lbgIRJ2
 GBxd636ToeV1J3qrm2Yn8tZDXYhsViu3n9b071Ww=
Date: Thu, 3 Sep 2020 08:29:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v3 0/3] nvme: cancel async events before freeing event
 struct
Message-ID: <20200903152959.GB2928425@dhcp-10-100-145-180.wdl.wdc.com>
References: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_113003_385036_6298D517 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: james.smart@broadcom.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 02, 2020 at 05:42:51PM -0500, David Milburn wrote:
> Cancel async event work in case async event has been queued
> up, and transport trys to submit event after it has been freed.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> David Milburn (3):
>   nvme-rdma: cancel async events before freeing event struct
>   nvme-tcp: cancel async events before freeing event struct
>   nvme-fc: cancel async events before freeing event struct
> 
>  drivers/nvme/host/fc.c   | 1 +
>  drivers/nvme/host/rdma.c | 1 +
>  drivers/nvme/host/tcp.c  | 1 +
>  3 files changed, 3 insertions(+)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
