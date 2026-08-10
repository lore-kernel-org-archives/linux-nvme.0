Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4C2C5AD4E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YL/jLQK5EmleaT7wV4cF3uBPd+WDKtpjUG1DaSzBkA=; b=e6EcHbjCactvKl2BKX8oV6eHO+
	7r7Yn98dE41VdtdD0LHoTiMVY8wyiDi8ijzaqwrc+vXHUkMjZJuQilbh27TP5S3lUhyx77mhEwHvC
	wSlz9ErCmeXocadeLaHtfEUhXQl+by+5Weh1J27kZjPbcOFcw5zLPmQVJTbKgM6Vpt8YhQX30f6WK
	hwGEQlwIxZEIwKtb8ukslBGkPUvPL8hC3vnRMpj4R4F1vzHM98aOOy6yUk/WJ55vA8OvcEruXXH1O
	Hks+7Dl6Ypc6hvAaguXK/L1MdZ51pG1bZHth2GxPq4a8chvLIhU0/Y7ppTqiWTAdHUQuPyhj1hXbk
	wfkIJqrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtMXV-0000000BQTS-2mJN;
	Mon, 10 Aug 2026 09:43:25 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtMXR-0000000BQSd-3XwV
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 09:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786354991; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0YL/jLQK5EmleaT7wV4cF3uBPd+WDKtpjUG1DaSzBkA=;
	b=N7ItGtFtWTi39yZ/Sjh8sMDJOXwfiRgjzSF5K9yB9B/R8sb3DsSVVCXUcaJETZI22mYbJ2JMndLFyfZ0w9mthOveGYwnocUoO1aDONhDd3dtcqn732y/+W38ZFpMWuCaI5vxmyEl/cpFrh9gRgf7Oy7ZdDVe3nquuztGYJYsjDk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8gfN9u_1786354989;
Received: from 30.178.84.107(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8gfN9u_1786354989 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 17:43:10 +0800
Message-ID: <677a31fa-129c-4dab-a8fb-5ad278b4f3a6@linux.alibaba.com>
Date: Mon, 10 Aug 2026 17:43:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] nvme-multipath: introduce latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 dwagner@suse.de, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_024322_381709_2D7C4091 
X-CRM114-Status: UNSURE (   2.16  )
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

Looks good to me.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

