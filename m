Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AD4E6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yfAHYUYsKW1RCXntxUq/SXAZPg6Z4wX5vF/cROMkTSU=; b=xnYlP7meSfKtAD0W93GHYKhXsy
	1z1NUpHMBncegpAlk8YPEbBEbsCZtIul7JoZ/3mStKGV4WkghmPoxYll279CoViXinYZS+sT4tplc
	KQhGjNqREt/yHfxotUCCOAmMJBAWGMnYXi6LCgW88mKQZfjuF9cSaglKMez2hdyEs6VWWxwCFved+
	uWXLg1/aNI5iEWxCvtjYlhMkMg9RKtyKhMt7m7pgK7VF63t7brRS9fPcnADMc+RQf3Va83GZNRMfe
	6KdaqyqH7j83DWso/oM0Q+To2HgSBVh2iRORi9fnq9brslpH+y4LUJxAAZ3y0uWF181tpoM4BCIAG
	kDwhYk/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snO5p-0000000HNXN-0hkO;
	Sun, 08 Sep 2024 20:01:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snO5m-0000000HNWr-48V3
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Sep 2024 20:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yfAHYUYsKW1RCXntxUq/SXAZPg6Z4wX5vF/cROMkTSU=; b=KzfaDexRKtK/4OfA00P85R13DH
	Zw4o847jLuep6EKSqe85HFWeO1+iF2O/Sa1n/gecQ0GlUg7rnilEdTq0BNNZsPUAABA8kuLiYcWNV
	SbtkoXpzMvWFI/tOAS0hjEyyyiDcuczJwbZ9oCirmOEkYXTaWPRB16w+3nWhWhy5a4I706ZqfKJCB
	HJc2zLy7OL7dD9DiYJJnNmTrdV+SZAr3rOmHwz638m3wouE3DMTnW8A2KjvrqDGice2XUwRDWRYJm
	tvNV7XZGh+QGvd3QVaq/ElauVDaPh2FaGgqcB06ke+iS3u/KE637m3YvuHlCwekbFI6MngFv/41xG
	pQGzy1dQ==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snO5j-000000029i8-2xSg;
	Sun, 08 Sep 2024 20:01:01 +0000
Message-ID: <d76447db-34e9-4f6d-acb6-3c982111b6d3@grimberg.me>
Date: Sun, 8 Sep 2024 23:00:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: test
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

please ignore...

