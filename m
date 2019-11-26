Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87254C432C3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 17:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5422073F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RQ6cuzeY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpK2le2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5422073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zabxVaFk73Sxj4xGAyTpk1CNRAEka3Hc9l3WoWR6Bl8=; b=RQ6cuzeYcWAvjs
	Fnu1nJCg8a+Ce6FWkALJbQ+yqZ62SfF4v9fA/LgYzmitzaIrVWluC4rQePLB6cUgWow5tySuegbEH
	4VoxaO4b9F1gnN60XWmLob9LOOKR19Wqx8NhiiULwQAUbpN8XbS5mxWN77esY4Jc/qtoX1L4HDKnI
	0aaNpk2MYZsJkZTOLwzWN3UswEk5/bGE6fAxLK5fan/PevLffRsPT/AzG0SHfhtvVXiuYaJQr02Bu
	4eq/kNoBuNggVFmpPy7IHcdUtYIAMdofmF/vxE6S9Whj3PXHDKl9sDD7HLwTZ1WSbXbo5Oqg5ypjD
	OBBS8/+t2OEfPQNEqObA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZenL-00071K-A1; Tue, 26 Nov 2019 17:38:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZenJ-00070g-8K
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 17:38:34 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AED8D2073F;
 Tue, 26 Nov 2019 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574789911;
 bh=k5vseHPFcPNtfZolSAZ48U3bYdwd6sjrLwHHme7ig8I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tpK2le2SZMzBjg7XE5ex7rab9eIJXStNfSXJ1Y+yCzW9eMu/IN6+rcZhE+ggckpad
 mxC97XBlo//NMF4GjGD3br5vAep6oSz/0ZvOTOuB/tbb7Z0G+T26Vmf58npAymRF7V
 VeosbgV52SGQyCukKEPAk1Q0P+0qAOFelP3a1+7I=
Date: Wed, 27 Nov 2019 02:38:26 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme: else following return is not needed
Message-ID: <20191126173826.GC2906@redsun51.ssa.fujisawa.hgst.com>
References: <20191125160612.3542-1-edmund.nadolski@intel.com>
 <20191125160612.3542-3-edmund.nadolski@intel.com>
 <20191126164803.GB10487@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191126164803.GB10487@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_093833_320657_2CEEF93A 
X-CRM114-Status: UNSURE (   6.30  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme/for-5.5

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
