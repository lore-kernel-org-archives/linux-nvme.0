Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403F5CC6B03
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDEZnZFYpuffzPq3yVbIulrNbfblS4pwlFeEeefac3s=; b=aTfs069b5YeYTEgOwpXDHnNjNP
	4Od/LzbmA27kPV1I8RYmJQ1EjvpsXCNpWhLVj4CX8NH/4UVnhMU8Z+h9LWMqlpcg9UwGzIz5dBnOH
	ueV123LWKNpnwxVaOZdQivMN38F2yUixccbSyRzcjLU+eSmOmyKc1WjY0R8l7GMgc8toFpk9L6KwQ
	YRLQgClkaIWZKsNOr6FFCUsTp/ZcXcTTXZD+Ypj9UiIXsSEse7mqZ0N7avRI2qI53sUxIIBrSjvjF
	aT/glPVr0EdqpL9sOR2P3QpO2RdjtUeWLvGynsPUEHOfR4BBPIgqaSAnU8xcSGvjIwVr/I2T3WciO
	kP/o4Ydw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGc7d-0000000CtVi-1cpi;
	Tue, 13 Oct 2026 13:00:49 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGc7X-0000000CtTb-3Ofy
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 13:00:48 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261013130034epoutp044658b1bb88250a66a2cf9504616bc8e3~eGFBG6pO72288822888epoutp04K
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261013130034epoutp044658b1bb88250a66a2cf9504616bc8e3~eGFBG6pO72288822888epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791896434;
	bh=CDEZnZFYpuffzPq3yVbIulrNbfblS4pwlFeEeefac3s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FrnXINfpsmzFR60SEEZ+Ifmg51zWVer0rh+6K11bq9DZ89iJWBt1p+jVQ+Wivj/iK
	 hWNftO2X9lrBfGeDB1mXucnzR5DQiaAMmiRczjJWr33juaHgjoGcT3Hxukme03jeDc
	 9DfGapZIT1y6d0dMEnAgDCQIxfBrBZNCNk5JFYVg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261013130034epcas5p21afebfcd95e6f4718230475486d5b6e3~eGFApo0__1130811308epcas5p2X;
	Tue, 13 Oct 2026 13:00:34 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4j3vZn2G3sz6B9m9; Tue, 13 Oct
	2026 13:00:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261013130032epcas5p4f27978a49d4f5f169affa17d28ce8049~eGE-W2lUN0272202722epcas5p4K;
	Tue, 13 Oct 2026 13:00:32 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261013130031epsmtip13f0de6001ef3f2850768a03770582e27~eGE96Cykg1973519735epsmtip18;
	Tue, 13 Oct 2026 13:00:31 +0000 (GMT)
Message-ID: <8102549a-d440-4d37-8b0f-531a001e230e@samsung.com>
Date: Tue, 13 Oct 2026 18:30:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received
 buffer
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013130032epcas5p4f27978a49d4f5f169affa17d28ce8049
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261013102825epcas5p38d2293e8e6c86a9142f6d24ba9fd371e
References: <CGME20261013102825epcas5p38d2293e8e6c86a9142f6d24ba9fd371e@epcas5p3.samsung.com>
	<20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_060046_431677_628C4892 
X-CRM114-Status: UNSURE (   8.82  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/13/2026 3:58 PM, Yehyeong Lee wrote:
> A malicious or buggy controller triggers this during namespace scan with a
> short FDP Configurations log:

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

