Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E25DC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:27:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D259E2067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IluUQgZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D259E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YTftGS0brQ9faWE1047UjkadCpJcff8h8zrJ/3htkag=; b=IluUQgZ4Fh3rUj2CFdQ71DtWA
	IFJPBjAlGeEn8XoYGx7LUiMU4vrh2l6P4bHAIcEQtG+EukfzopTAEwdYMIiJRamlB1c213rK2pMXi
	QdiLeqHP6Hw22H8OU+zjN8MVWTZmUzqRREG6LP8wmqE4La0l4JEpdS+3HiJ02atkrfb35nq498JRz
	w9uRAqsxoJWi11+uZMWr8JyuFCn3ggp1Xn+0EtO2jCNvPeIk3p0MfwzsyDP1Ni8iun14Ca2VgOXbF
	xg4uDr2+mh267OjI/DTI7vTJZ7g/5g1WDmEHh1Em8zA/X+O7bJzF7MgkHwATGkUy9igdEsy/zf+h0
	+84qH8NbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k84SW-0004yk-Pe; Tue, 18 Aug 2020 16:27:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k84ST-0004xW-LX
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 16:27:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8DA3068B02; Tue, 18 Aug 2020 18:27:31 +0200 (CEST)
Date: Tue, 18 Aug 2020 18:27:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: amit.engel@dell.com
Subject: Re: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Message-ID: <20200818162731.GC27196@lst.de>
References: <20200818065114.57532-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818065114.57532-1-amit.engel@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_122733_853210_A3F888AD 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 09:51:14AM +0300, amit.engel@dell.com wrote:
> From: Amit Engel <amit.engel@dell.com>
> 
> We want to avoid starting the keep-alive timer with a zero timeout value

So looking at the spec:

"This field specifies the timeout value for the Keep Alive feature in
milliseconds. The controller rounds up the value specified to the granularity
indicated in the KAS
field in the Identify Controller data structure. If cleared to 0h, then the
Keep Alive Timer is disabled."

we should not just set a random high timeout but just disable the
keep alive entirely.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
