Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD5BE6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g74d3gLE0alBfg/PW7fSwjhSxysDpLiBB/zaTw1g+c4=; b=AsPiDntBHVusxEDbTaKh3xTAjm
	yNPsJ8mVJrwx/mLBzpRT1bOd6/EDvHwYikV0dn7gFeMpyLph98A/hgbSmnd4XG7RkHfu5xjkx6Gdm
	SqAEMaMHmKbep+8jPlFZaV4uR1zvkThlEyLRYuArV+v41kf0ehkm1iovejSgBFj4j+rrHpxjse3XB
	0eHdaWSJnoasPnBwClnjeI71Als1Vtm5TJ3tN5FICdvLSPdJH2LP+6SAmXGVcHTFfV/MIeuSdoQ8h
	DSbTDIq4iu++3RKU1oCkkIx+l9A/k7hLEmzXmZ1HbDxSmohFdwtxBhTbZnDT8F4zyf351oAEqyBy2
	uoD9vcdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snObi-0000000HQZX-1n6D;
	Sun, 08 Sep 2024 20:34:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snObe-0000000HQYf-11vU
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Sep 2024 20:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=g74d3gLE0alBfg/PW7fSwjhSxysDpLiBB/zaTw1g+c4=; b=pdHFo9rprrSttTTGd2EcowmBoY
	r1n0B8vvyaKp/eJK7Ag3lucYslxevT2aJ3MCqhA2mb1CkmXNK5LKEttUaIJPn8oEC2kr8NKbo0MnJ
	yDg+/zuxFIoMNtTyyUHjaiKJOJzGIzYkPycwES8+a9TaPA+kdFaZgv6FUPFWJ4UM2I9Lo/BAjNfF3
	CJamt27lZt6TpLQMbVY/gWhJ/ALVYEpvYeNqp/pg957Yb3j1UGPK6gyNj0Iokdn0n33kQGXpmAqre
	9ooDKmHpgVaXL++cv7q2dJSTKQCHVNr/39qdBWypYY++U9WvRehb/udkdQXFdFeWpHdxmp0qYOf3a
	BhvE1wOw==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snObb-00000000Gwp-2cyo;
	Sun, 08 Sep 2024 20:33:56 +0000
Message-ID: <7af8f591-f0a7-4c2d-8040-2c904cb9a298@grimberg.me>
Date: Sun, 8 Sep 2024 23:33:54 +0300
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

please ignore... (sorry for the spam)...

