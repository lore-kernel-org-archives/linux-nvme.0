Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F95FE6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 21:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yfAHYUYsKW1RCXntxUq/SXAZPg6Z4wX5vF/cROMkTSU=; b=PMsAoeFQT+RZA2D/h6+Ig7zLe7
	xJodU3vRqklxXZSvKfB854r+9oLAYtxX09PDB9vhcpqVUspwNmlAWZtSGU6mclkN9zk5hOb7ng3Y3
	KkiFxuU5R0lTfhjAhZ5wVtDCQsjY1hQ71YSCqqngE3CYGP713xEy/9cEToOcr7uTkJa5mbDBNUEEM
	XnDjH6bp55LhtZY6ZzcRnW5q1UkLaIeobIeuWJlyUWDKtwQin8cTAITmXKl0OXWmhh8RXoSOaI8WN
	16+SudAJKdxABDO6eBWDXX4TXzwXg3XO+hZsNZf++L5AydOPGpuzxITG+30dzF1hJkq4sIImvV/co
	QJIBwI5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snP51-0000000HSab-2XiS;
	Sun, 08 Sep 2024 21:04:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snP4z-0000000HSaF-1iJa
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Sep 2024 21:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yfAHYUYsKW1RCXntxUq/SXAZPg6Z4wX5vF/cROMkTSU=; b=W47mzVeVmta8hXTeK+liY3tkI5
	JiySyQPYGPIZCkLiCF9mX/odkBKbcmhTSXFeqQD1OYBpMb4AuTNc+jeWQbkHymNK48gqh4cdtnknN
	adT33tWec2QeiXhKJ61x+BYmBiE/SjEgKiKjnKkpvLQAit7ELC0GjlQilYUSKsKfV1dzwl4DS7t9v
	eeH/q1k0s7MC9TJrrL+0c1UKmsebUd1gDwyX6lxFCB0r99mJQWznjtaevHPj2YLZAKLUR6XCILTkV
	dh9UCtJf8hAvFtk35iwvdiEDyAs2ljodLj+LBXVtARRjYNkHfOxmw3VtjacY2xUnxINRNN84PJCxt
	EpSwdu8Q==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snP4w-00000000H4h-3u0w;
	Sun, 08 Sep 2024 21:04:15 +0000
Message-ID: <467e5b44-c2da-4483-9739-6fe58cb4c71b@grimberg.me>
Date: Mon, 9 Sep 2024 00:04:13 +0300
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

