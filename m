Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4EC4320A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 15:25:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CA060E08
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4CA060E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FKjN5ktyiopwb6Ip2k2SeYu3zkU/C8jRwxoqEsEZt50=; b=JFAW9aRmJwL+QT
	9EnOuP5f2D6R/HWYxNPZII52NlmRjURFnNGAl+EvjSmRnjIvDMfkZFXCMhmoQIByUWI538dTHcD3C
	yYvKZooYOy2udtZ7C1cyuqHl/pq074LGJeY0HKUGz6O5m2EBudVA0UWW+jaNbMDW1d+8bAXLKr+T4
	FUFKKENzMsuCQ4iUTAa+s/4NlhaF26elXGl0kyUocTfTs55TrwnpbjDzm1VAZwPlbg0WwTIXcSxAV
	EVRsX7aC6pmAQZAe/hNhgiObzTe/xou1vakyjmGWY2bkricbJSbOVhmNFPUfEnffW2Mbgh9JVyMsV
	dkIzGePHGh4Sqv9ayZpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m82TA-00BlEM-Dq; Mon, 26 Jul 2021 15:24:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m82T7-00BlDV-S2
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 15:24:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5547460E08;
 Mon, 26 Jul 2021 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627313077;
 bh=99cfRI4n8mXdOBrLYIVKS49f+F3CgtE4szaa0DvKQbg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JeXcRRS+acxAoiHCFMk9zlVvkxSQS0EdN2TgTI6IaK6mdzkmELykQStO9GwoRPznr
 VC0gwk//GfhyewE6FrWJkO4neA257W9oVkovk4t9eQgJC6p3KZJxTn5b7zhRl27t8p
 XvWjZz8jb6P5EPGSDpvHZEpvEVOY7b6iSX2qIo6wVd2l8/QFkftcBHkqybVzvEIHJN
 EVXpuMU4ceNLJ0DTz6ZYH0owwQ3HFt8UYiWAqWH+FLRyKglJDYzP/6zidz4TWJLa1c
 7qgQxuVVLOtdoRHiw3ipuJxv47krvflZo5abR9Nw5PdWPuuV42/aMpkWRU28bmlJxQ
 aJLbBfkpfjHJQ==
Date: Mon, 26 Jul 2021 08:24:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: shiva.linuxworks@gmail.com
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v2 0/2] Abrupt Shutdown for NVMe SSD
Message-ID: <20210726152434.GA2024939@dhcp-10-100-145-180.wdc.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210726132223.1661-1-sshivamurthy@micron.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_082437_962659_C781E646 
X-CRM114-Status: GOOD (  10.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 26, 2021 at 01:22:21PM +0000, shiva.linuxworks@gmail.com wrote:
> In the platform with a limited backup power supply, devices like NVMe
> SSD does unsafe shutdown.
> 
> These two patches address this issue by adding a power loss imminent
> flag. The platform will enable the power loss imminent flag if the
> platform's power is running on the limited backup power supply. During
> the shutdown, the driver checks this information and pwerforms the
> abrupt shutdown.

I think the pm framework and nvme usage are ok, but you need a platform
specific caller to set the new power loss flag before this should be
considered, otherwise this is just unreachable code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
