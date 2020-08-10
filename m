Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F301C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:13:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3AD20734
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4oeg5yi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI74swsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3AD20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OqYwX74KrNp8hoj3voaYlKuHr4plYwXdehzXngr/z04=; b=i4oeg5yiW6x+M/8COmdkSGjwp
	O+jiqKjWhslC0IcNV09vZJNdPyxlufJjFpAJoVI0jEOepBIvvmdsFnvoLSGX1FMP3h1RJ8iO/MAHp
	qaxLGbBfuG5tfzkTS4CpuF0d+Hnq0LvtSr13jLRmonPp42FNuwdvxLpYg6kn6qTILd8bAYK1VCG/a
	CSu+PnzEXJmDQk0afwsli/VGjBpbdDbslDCRaNFyn0Pd/Ikwsmj3LN91x7RqxAfF2y558QbMNsg6k
	reVd0Nxsn5OYSl5bsVqcHVXJC5p4luAgtw5BZzg8kf4VCO5N6youc3Y/Y+qEXFcjMwzlncZR8G0v9
	PltltztUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GzH-0001xH-B6; Mon, 10 Aug 2020 23:13:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GzF-0001wh-Hp
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:13:50 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1475E20734;
 Mon, 10 Aug 2020 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597101228;
 bh=d1lNBEuHwL0Hlb4f24mkgET1xKs7I8f0lAXrFZOVzuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jI74swsCVMJ/6CCt/6kKA2whgrEX+AahQbE920FNvv6Zw3I6uOvFuMwyj1/u8j6FP
 SpsELICVh8uUAEyt9QYm8n0kbx8xgjr+Umd/FG8Oh4kVd3odzds/LjrobllC1TJldZ
 rWGGrlUV1zkfYIyxBpmx67SoTtwn1UWLkVqASO0Y=
Date: Mon, 10 Aug 2020 16:13:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 05/14] nvmet: get rid of the extra variable
Message-ID: <20200810231346.GD269401@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
 <f7dfd268-9b02-4711-85d4-eebd8614f8d8@deltatee.com>
 <BYAPR04MB496523DC21401582BE98753C86440@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496523DC21401582BE98753C86440@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_191349_709753_6FD11FDB 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 11:00:55PM +0000, Chaitanya Kulkarni wrote:
> On 8/10/20 14:58, Logan Gunthorpe wrote:
> > IMO, that's really ugly and not at all an improvement.
> > 
> > Logan
> 
> && operator is perfectly readable when use for short circuit two 
> conditions, more than 2 or newline is what ugly not this one.

The odd looking part is mixing "likely()" and "unlikely()" in the same
conditional.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
