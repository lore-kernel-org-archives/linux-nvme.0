Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2771C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD7420656
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wx9fb6IF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vYhfPqtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD7420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KqMdu/pYcfRW3dsH1CIbSg4GTD/gA3bYK/yIvw8k640=; b=wx9fb6IFD7F7mcwCNZdnMQIqh
	2lEGt9yA70JMd2AnvZC/gw0QfzXWWHU69abDPNS7kGOfQ0RBESDc/siDFUVwTD5Iih4IP9hhhl2WX
	Sh3xyGD7bH8nLaKq4RCOeAugjtjA6rWAjQkVg/i/sgBgtJWVBaW8NbExl2dbVaY9Zg/EcucQz0vR7
	fF/CDcKmMJOTMf2RssHJBEhA0B1ddZjvBvYz1yeM899QSSng74XrhKAQek94I0iLiNCdjV1D1OKUi
	h6OOLt8Kq6g7dASl3sQTyx8/ZEIz2LkSGhqlhNA0ovNArluYNlbWrQ4A3L9FlyVEVF5pCPEmMwXSZ
	FJQnHVIew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvO2N-0003se-7R; Tue, 14 Jul 2020 16:44:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvO2J-0003rx-Sg
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 16:44:08 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5B6720656;
 Tue, 14 Jul 2020 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594745047;
 bh=6kmndyzEcUa9q5MX7gsltuXTm02RzGywUq2G2kiagP4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vYhfPqtw0XAwWOB7yRT8+HEPbKigvy4ozMTzWGSPvzFuAyROvNiOJvJ+9VARz1TW1
 FzO8oPOcd/gI/u3ctUw7nzHa93hBuXwbxgVSvibguYleW2iRPbBr5NMlcxFf+kTVOH
 b0KzGl351aK41XQ3r2haI6AKjoPAzkWqNJM1pE0k=
Date: Tue, 14 Jul 2020 09:44:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Message-ID: <20200714164405.GB2771736@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
 <20200713074210.GB14676@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713074210.GB14676@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_124407_998443_BA1F28C4 
X-CRM114-Status: GOOD (  12.46  )
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

On Mon, Jul 13, 2020 at 09:42:10AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 09, 2020 at 04:40:24PM -0700, Chaitanya Kulkarni wrote:
> >  static int nvme_npages(unsigned size, struct nvme_dev *dev)
> >  {
> > -	unsigned nprps = DIV_ROUND_UP(size + dev->ctrl.page_size,
> > -				      dev->ctrl.page_size);
> > +	unsigned nprps = DIV_ROUND_UP(size + NVME_CTRL_PAGE_SIZE,
> > +						NVME_CTRL_PAGE_SIZE);
> >  	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
> 
> This looks like the existing code here is wrong, as DIV_ROUND_UP already
> adds the page size itself.  But that is better left for another patch..

The extra addition is for when the starting address has a page offset,
which may require an extra PRP than DIV_ROUND_UP would return without
the addition.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
