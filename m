Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCB7EB64DC
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jun 2023 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PuOPIpNAunf6VnjTmBWDIe2Yn8YrqJzx0O5lJJEm4wE=; b=VH3tQYviJNG2xGTTHrkzYYV0K/
	ZPHo5A+LzGD8uQ5DQKRtBelBTZLE1LbhXW2oIw53WsHmm8XFe27w6jZQmCgiq7XMk3K9KDxFnNJB1
	Vs5kPpnw0LZixZh5gotuOl/GdQCrOTHMN5dNNaT0y1ox+nFo9vs71B4VPJ6kDxm70zKLStFjQd9Ej
	CvAWgyJ3GBnJnUyencbg7n6yPWqsXmlpSLDTRzUsc+twaCJRf52zdJiWIqVg/e0YqgNvT2zjDymrq
	tjXMhgBJQ22TYg0ACCVgYr2jyGIw7zashGjhBoeYF6xb/UyKXJpfRUQ/tVQyCiWTp0HtxZy1yeRQO
	5PyOA1dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCOJU-001MWW-1G;
	Thu, 22 Jun 2023 17:41:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCOJQ-001MVZ-2G
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jun 2023 17:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687455695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PuOPIpNAunf6VnjTmBWDIe2Yn8YrqJzx0O5lJJEm4wE=;
	b=OEuNkTbdIj4Nch8wDa164sd4pMxvNtMul3ge+OvXxSHBAdvQJCDVxoOqWFv15PJygusL0o
	mnVfXAPUTdVvKFiqWYArbl2llEihxFbrOtjFFvCIlDrGnzH6wXqC6efGI5L3o1hHhoZAt3
	Grs0d6AMQTIpMYIpGrlqBPWEHnVP1Y0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-bIGkBMEQPU-2nUoAcQWdwQ-1; Thu, 22 Jun 2023 13:41:33 -0400
X-MC-Unique: bIGkBMEQPU-2nUoAcQWdwQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EE9A1C05142;
	Thu, 22 Jun 2023 17:41:31 +0000 (UTC)
Received: from [10.22.18.42] (unknown [10.22.18.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D995492B01;
	Thu, 22 Jun 2023 17:41:30 +0000 (UTC)
Message-ID: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
Date: Thu, 22 Jun 2023 13:41:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Cc: "smith, erik" <Erik.Smith@dell.com>, "Rose, Charles"
 <Charles.Rose@dell.com>, "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
 Daniel Wagner <dwagner@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Subject: What's the upstream disposition with nvme-stas?
Organization: RHEL Core Storge Team
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_104140_831415_B438D32A 
X-CRM114-Status: GOOD (  30.51  )
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

Christoph, Sagi, Keith, et al,

There has been an ongoing series of 3-way private conversations about the status of nvme-stas and I am sending this email to put 
these conversations into the public.

Background:

If my memory serves me correctly: after several failed attempts to add an "NVMe/TCP auto-discovery" feature to Linux by 
leveraging an avahi based mDNS/SD mechanism (one by Sagi, circa 2018, and one by Martin Wilck, circa 2021) TP-8009/8010 was 
created at NVMexpress.org. At that time Martin Belanger asked Keith Busch for a repository in the linux-nvme domain on Github 
and nvme-stas was born. My understanding was that the goal of the nvme-stas repository was to stage the nvme-cli code changes 
that would be needed to eventually support TP-8009/8010. While some of that work has been done and nvme-cli now supports TP-8010 
compliant discovery controllers (e.g. with the addition of the nvme dim - Send Discovery Information Management - command) there 
is still much functionality in nvme-stas that has not been merged into nvme-cli, including the mDNS/SD based functionality 
needed to support TP-8009. This remaining nvme-stas functionality, and the status of any effort to merge it into nvme-cli, is 
the source of all the private conversations and debates.

Current Status:

At LSFMM this year I spoke with privately with Keith Bush and others about the status of nvme-stas. When Keith and I spoke he 
told me that Dell had talked with him privately about nvme-stas and asked if the nvme-stas functionality can be merged into 
nvme-cli or otherwise accepted upstream.  Keith said that he told Dell, after looking at the nvme-stas implementation (again), 
the answer was no.

When I spoke with Hannes about nvme-stas he agreed with me that the utility is, at best, a stop-gap solution and that we need to 
continue to look for a better solution to the "NVMe/TCP auto-discovery" problem. We brain stormed about implementing an nvme-tcp 
discovery listener socket in Linux that leverages the Kickstart Discovery Request (KDReq) PDU from TP-8010.  We also 
brainstormed about this topic at the 2022 ALPSS conference last October. I think people in the upstream community are aware that 
some improvements with NVMe/TCP discovery are needed, but nobody, that I am aware of, see's nvme-stas as a solution to the 
problem. Nobody really cares about nvme-stas... but then that's the purpose of this email. I want to stop talking about what 
other people think.  They can speak for themselves. And if we are going to talk about the short comings and problems with 
nvme-stats, let's do that publicly, not privately.  I am tired of the hear-say game that happens with private conversations.

So what's the debate?

I work for Red Hat and Dell has asked Red Hat to support nvme-stas as a Red Hat product. Red Hat is not inclined to do this 
because we currently support discovering and managing all nvme and nvme-of devices with the nvme-cli utility and we don't want 
to support two different utilities to do this. Our general policy at Red Hat is: upstream first.  We don't want to support any 
package or feature that is not first supported upstream. So the push back from Red Hat to Dell, privately, has been: please get 
your nvme-stas functionality merged into the nvme-cli utility upstream. This is the source of all the three way private 
conversations with Dell and everyone else. Anyways, at this point it looks like a complete merge of nvme-stas with nvme-cli is 
not going to happen, so if there is any conversation about why or how or what needs to be done to change that, let's have that 
conversation here.

So what does "supported by" mean any way?

I believe the goal of the upstream linux-nvme project is to support one general purpose Linux utility used for discovering and 
managing nvme and nvme-of devices. This is the nvme-cli utility. This is what's "supported upstream" and I'd like to end any 
debate about whether or not the upstream community supports nvme-stas. Nvme-stas is supported by the upstream community to the 
extent that it uses the kernel and libnvme APIs to access nvme devices; just as any other third party user space application 
that exploits these kernel and user space APIs is supported. Other than this, nvme-stas is not "supported upstream".

Notwithstanding the fact that Dell's CDC is compliant the NVMe specification, nvme-stas is arguably little more than a Dell 
specific utility which is designed to optimize nvme-of discovery with Dell's products. There are no upstream or open source CDC 
implementations available (that I am aware of), and there are no commercial CDC implementations available other than Dell's 
(that I am aware of). So, at this point, nvme-stas's primary purpose is to optimize and enable the special nvme-of discovery 
features of Dell's CDC product. With this being the case, shouldn't nvme-stas be supported by Dell?  It was written and designed 
by Dell to support their products. Until this changes I really don't see why any entity other than Dell should be called upon to 
"support nvme-stas".

In summary:

- The linux-nvme project supports the kernel and library APIs implemented in libnvme in support of the nvme-cli utility.
- The linux-nvme project supports the nvme-cli utility for the general purpose of managing nvme and nvme-of devices.
- Anyone is free to contribute to libnvme and nvme-cli to the extent that their contributions support this goal with nvme-cli
- Projects like nvme-stas are free to use libnvme and nvme-cli to support their specific use case,
   but this does not mean their use case is supported by the upstream linux-nvme project
- It has been agreed that the remaining features and functions of nvme-stas cannot be merged into or subsumed by nvme-cli
- The upstream linux-nvme project neither approves of or disapproves of nvme-stas and the URL of the nvme-stas project
   on Github in the linux-nvme domain should not be seen as an endorsement by the linux-nvme project.
- The linux-nvme upstream community is aware of the problems with NVMe/TCP discovery and we are searching for a solution.
   We are also not sure we want to support mDNS/SD as a solution - TP-8009 notwithstanding.

Finally, whether or not any utility like nvme-stats or is supported by any Linux distribution is an independant business 
decision. These business decisions and support statements stand apart from any support statement made by the upstream linux-nvme 
project, and each Linux distribution has their own separate policies and standards for distributing and supporting Linux 
upstream packages, utilities, functions and features. We can't assume support by one distribution == support upstream == support 
by another distribution.

Thanks for your attention.

-- 
John Meneghini
RHEL SST - Platform Storage Group
jmeneghi@redhat.com


