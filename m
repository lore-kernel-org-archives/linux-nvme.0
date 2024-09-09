Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8BCECE579
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=Ilp488gnuNVxDxPvORWJ2+84Py
	3WbYr5/xu5w00n1oOkgwdPHMZRlU392oICzZ/XcndTIlSjNvUNKNAvDQIBwLfMhnqSvagZHeh+P3N
	P2FpqsEhqG6jNt0oe62I21pg34sqn/v0i4R85REwGyhhIMoX2U47RT0V/zBmwU/IlKkPcqZnM8uCI
	EBrWYjNQ54qAjDgcOP6Lpw+uozxFi2ihcEIma7XqwLg771FM//iOW7pwHH/QCQCmcPcv4zhNe9Y0o
	1yL8Eh7ytcdpeqWRphnkas7tj+jaDNQEyXAs2nynBc/UuxYgtI9L5VdKaeMlG7Ge5Hi+7aVig1BnJ
	j4PtBo+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snfBc-00000002EnJ-2WYu;
	Mon, 09 Sep 2024 14:16:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snfA0-00000002EJX-0Yxs
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Sep 2024 14:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=YY/jWHGw8FrZPkxqiinbC/nUJS
	Fasq44e2VmtOG6f82sqwjhFLrBIEDz8qU0X6RM6xp15fJ9bqIpgegLxE6OHHcCC00P4RpinaZ4azD
	FPTdojokFiVwS7drp4MN/ygyMC5ARhD8QRjBZRHGXbcUHBb9u216QKKs0s1Q9GpGsjDmqo9t/35sp
	Hk8ZinokNHVwBYueLCcaBPC1AhduX1PKzobqrG9lbmuubuC6FDebC4xYXriaVaT1adcCSoMD8L/Hz
	A3497L8nVHpyw1um+Cld9h1RqdgAzk6rx6c/6G3CM1m4lZ9OPZLaowCXBvZaSeBwMuy684aWChLq2
	m2urRgew==;
Received: from bzq-84-110-32-226.static-ip.bezeqint.net ([84.110.32.226] helo=[10.50.4.202])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snf9w-0000000DdzG-3tOL;
	Mon, 09 Sep 2024 14:14:30 +0000
Message-ID: <fd9fbcf3-7335-4c65-a27e-5e43902aa5b1@grimberg.me>
Date: Mon, 9 Sep 2024 17:14:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: test [IGNORE ME]
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



