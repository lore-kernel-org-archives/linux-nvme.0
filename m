Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB8DC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 18:33:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FE522527
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 18:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sc4zPp3I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6GkFEpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FE522527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OiqBRse46az8/BVQGhFHT2yHNCz1/PwdDvRxktxq5Ik=; b=sc4zPp3IWDdeeq
	wMIpPAK8D1wd19MBny35dbleA7mOCCNr8iLBdNskRR0/pGvqFfTsZWmoKLwFD6L+QVvawZvlfFWkI
	6JAoYiolvn6b/IqMtYSYBu9cvk2t9MrxZPkOjaGZawHD0jXOYCWG3zJdIV+OSAJNNUnVEDqgfEh22
	HSXgPT1SXrdpq+zGTAip52Iy57TJefKHoiy02x+AjtKPEqeuwPVxsFGoYGnIl5tgLC5mu5PvSiPdX
	60WGU5TzmLrWBSm6VX6E5SZPmB4HTW+8ztKW5H0ZemQbEiz6QtgpX4+zceBBeGViqxNltfBJ37mhv
	8DCFSVcgyGq0Fbu3JJAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if6nx-0007NL-2c; Wed, 11 Dec 2019 18:33:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if6nu-0007N1-GK
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 18:33:43 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AA6020836;
 Wed, 11 Dec 2019 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576089222;
 bh=geCPNnHlvTAPkg1jPd3NplLkeVVLFJc4GxXn2pD4Nuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q6GkFEpYTujJd+HLMhZoFmMEYFFXR+BSsi7MnEQwTY/13Gaaak3YGAjFzi1WN2U2g
 OE2puDDuCk6aaCrsaK7AwVtqXzNgdaZcCqmfXLyIpevzR52ISF9qmiJ1zxmWNMQ2tJ
 pAwcUzIHEmtUJhRMzHdEzTcaREb7tlil+rIvYmaw=
Date: Thu, 12 Dec 2019 03:33:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v2 7/8] nvme: hwmon: switch to use <linux/temperature.h>
 helpers
Message-ID: <20191211183335.GA26280@redsun51.ssa.fujisawa.hgst.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
 <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_103342_567766_E57B9165 
X-CRM114-Status: UNSURE (   7.79  )
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
Cc: linux-hwmon@vger.kernel.org, Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 11:54:38PM +0900, Akinobu Mita wrote:
> This switches the nvme driver to use kelvin_to_millicelsius() and
> millicelsius_to_kelvin() in <linux/temperature.h>.

nvme change looks fine to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
