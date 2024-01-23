Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668ACC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g3zLYH4xKxcPrHOD18z9YfpQcnk/GaJedfustWU5uGs=; b=mrG0tFSc6erUojBny6lskPo3aV
	WADGjZYYaZrOdaEJrGeYjIMEikSLqosmOckAWBREi1tWdJIyrqqpSRy6CYIG/Kpu8ywhBW+TCYxPH
	j1NymUxxnAdRslk1TWZGiwBmh/k25bS7PR95wjS6N2YloQSC7NNe8bN7KNpWGpnUawJonSNi/RJ6E
	lBkjwpyndszX76NchWr30Z16QgdzRYUDusqgCPu3vAzdP6Uc/TwQOpK+rZCgT8wLxzsNvFIhjjVFu
	Vb+E7utv00cRHlWCzgqCERhD/VVtb3v6PNo22MI0QmM11GJM6qFH/i//K3eerKSX1V2SDGs6EA9km
	0rzNIa/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSERt-00G2PE-2K;
	Tue, 23 Jan 2024 10:56:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSERs-00G2Oo-1h
	for linux-nvme@bombadil.infradead.org;
	Tue, 23 Jan 2024 10:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=g3zLYH4xKxcPrHOD18z9YfpQcnk/GaJedfustWU5uGs=; b=rH9S1IyFOrCNL5wyTRVEbQwZt9
	Xvx7v4b0XZocLcGdewGy/M4QS7nD1VUlgRSpGH5q+e242OkmpbPrHumS1KzD0Vq9dDAwvQGVuODFq
	FLPLSDvQm1g6JJlNbqDbovpnu3jSauSJAEBtOMR0l3e2aBlxjUp4fyKTdWR1ZwlcIu+SFUov+hKRI
	noE+bOrgz8NviphRAV+eKclF5VbLhelp/5guDmDN3EXJ5PGwmzVwTemyXqyPuRjnP5QvNUp4O3NPI
	zZjOwhxgFGa+tv4dimZO6R3nM3yU7crZqvTV3oOOBYwSF5pEJOqXFDmmpip0vfHGaLms/DG3Dpw8Y
	fr2TDrtQ==;
Received: from bzq-219-42-90.isdn.bezeqint.net ([62.219.42.90] helo=[192.168.64.172])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSERp-00000002yLl-1m1t
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 10:56:06 +0000
Message-ID: <d2f61e53-cb83-4310-8130-5c4ac4468cbf@grimberg.me>
Date: Tue, 23 Jan 2024 12:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Test2
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

test

