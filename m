Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338DFCA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 23:57:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED535206E0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 23:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5A4FLMX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF609j8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED535206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GojQBiL5eD+npYxaNTMVdDhtZMlwiwqIM3tnGr1tnYY=; b=T5A4FLMX2e4W+U
	4cp19++gWpAf3F2Zi9dk8lB3mSp1PQSRj2O1OkGlPxxClPIymp+CS0V/9cImVg0VgVwc/Z+FpivC2
	gpczl6oHjW/HTRCfEPyUZ9NR6EWQhAUtBT+AuamheMksne9ztogrFHqmxpgBTpKDx1oBQ9Bo3rZEj
	zc3aW42ljWL01gMP12Al1itdVj/a5/5cmnWEi9SMGdA2E5lYuv+MS8dFWxmbGeggUNCYSNHF7AWWY
	57JU63KmdX0BvDa9oxCv8iPq+vFZsFSJziGnCHwAmm44XSD+2wdPatRArdZmO7rkY5dJrcS92Nc4D
	bjebNMgpSy+2piShlE7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO9SX-0002uY-Kw; Fri, 25 Oct 2019 23:57:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO9SU-0002u1-JJ
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 23:57:31 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 657DD206E0;
 Fri, 25 Oct 2019 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572047849;
 bh=2CXHE3lfOwlO+teDk8DBrklXvC+rcABGR7IR0elYJpA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RF609j8IzcRqEFCtyQfCizyb72apqF22SsOxepOwRWvrv5qVUsAEHgZ7CYbPkYaQ4
 GBZjc5l8Bi5ShKXGopiH0NSAfByU6WYzuft4JrJZZn/u7gkFuR6wK6uqXF5v/hhSUI
 Rvmtds+xutO0wOWe3nMIEeC2w3ecUp0PUWagYHCs=
Date: Sat, 26 Oct 2019 08:57:24 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: clean up command parsing a bit
Message-ID: <20191025235724.GA23826@redsun51.ssa.fujisawa.hgst.com>
References: <20191025133858.21505-1-hch@lst.de>
 <e9af07e4-fd81-fd13-9e95-141f8adfce73@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9af07e4-fd81-fd13-9e95-141f8adfce73@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_165730_660546_7A255E62 
X-CRM114-Status: UNSURE (   6.82  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.5, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
