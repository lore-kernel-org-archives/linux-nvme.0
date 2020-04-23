Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E200CC54FD0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 20:30:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F5620776
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 20:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qIrZhjcp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuM9SqEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F5620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bPOXlR0Q5SxvYjhvyfcDex44f75uGPzSCekpEg4eXi4=; b=qIrZhjcps68s/M
	8b16WYZeqvD32RAF27twlvQGBA6ipfU52GAXYkgo8BHpEGCRIq7yR1ePGuMsleNxa3ujbndN0cdY7
	R5EiC3w7t99GVi6QVLYRgxPHHYroGa/VO1MeSK8KX5VxI+571wcFqKw3xaFXSv8R8LomXBLpLGW+f
	IXr701xyYre6m19vkv6eETQeR+rALrPELUAt+A7UV6e+B7PzbfNs5/NUGPY5phsJnZjqqKCTy1oJt
	NDjfkW5pdE1XBUh1NqkmDqMcoMjRYcnv6cKbnQSxWOIUMGNW/gsmYXLbtdYeEQXTPJFy5IKezGH9Q
	ORJ9sGLgtFIJTIV9OyMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRiUI-0001Nf-4y; Thu, 23 Apr 2020 20:30:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRiUG-0001MA-4h
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 20:30:21 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A733520728;
 Thu, 23 Apr 2020 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587673819;
 bh=lg92oqONrwlQh84o7sbwliXtwsTG0cLl5NpJS5cOKhI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fuM9SqEuC0RdRDEBMuh7f7ZpWswk/25EKncS6G3l0noLNQFo8j2LP+cXGows7NMBB
 EsAImCvSpAWgtN77REi9n5lxFJwS6zEgvmpScsJOn8JQxHRkSwVlQHSC+dLdjsCj5Q
 ZrfwUaUYZERX7RWTJl9k8JWKTZ4sQg+EtJCGDgkY=
Date: Fri, 24 Apr 2020 05:30:12 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/2] fabrics: allow traddr to be host name for ip
 based transports
Message-ID: <20200423203012.GA19657@redsun51.ssa.fujisawa.hgst.com>
References: <20200401215344.2519-1-sagi@grimberg.me>
 <20200401215344.2519-2-sagi@grimberg.me>
 <fd09956c-2b96-4b26-bb38-ebf00bf48156@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd09956c-2b96-4b26-bb38-ebf00bf48156@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_133020_205342_ED10873A 
X-CRM114-Status: UNSURE (   7.26  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 23, 2020 at 01:22:23AM -0700, Sagi Grimberg wrote:
> Any objections with this spin? Keith? Others?

No objections, looks good and applied.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
