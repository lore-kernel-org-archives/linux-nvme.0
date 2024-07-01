Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B160DC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8gIqUvIEyIvWrLcnvnN8RgcwBPeQB4VF3UFpzQZusY=; b=qOXpoWvdKxsyBSc81e9ybu8TDp
	PaPdMPE7iOxwk7DlGQ7VbS5TiWa/3yszaNYbXWQePlNZr0Rb22/CokdlPZlll2ojh/WrAiDPq0AI+
	fERDXGjafJoIC4o9eSR0T7q8UV6uW4JBGStq/eDd9Oi92Vpd+fcdtqdE67Svyv7ipL+ZnkRC7i3os
	0MM+ZABEtpaHuRJZ8EMikIgukCY4ltpz4KvZGt/y8dQTozZKsl6rhlw/qMytJKuHdLTvW6nkPRsYy
	YcvNKLb6tfpoJpcmqrG12uSnRCF6zaa0b+v/opSGxb/bCQZRmXdkmdbKuYVTfMaxepaeousdm7yYX
	DC+a372Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBi0-000000026Dg-3FAM;
	Mon, 01 Jul 2024 07:44:20 +0000
Received: from m16.mail.163.com ([117.135.210.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBhx-000000026CZ-0K50
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=x8gIqUvIEyIvWrLcnvnN8RgcwBPeQB4VF3UFpzQZusY=; b=VStLEhU1ASWq2
	aiANfD5IZ3x66VWPwssGK0z6W7kfR/Z5WoQG8BK/SI11dVEZ0Jc3HvbL0XH+cskW
	c2YxKiCrMv8/ScdHGZ6lfzF6Yv45TWuHq3p0SL/Te/FGBQw7X70FvPHN8Q08Donj
	ZjlB0X1bIS+yC26gz12FRr9MLT6JGs=
Received: from localhost.localdomain (unknown [223.104.212.168])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3v3UpXoJmVPDIAw--.64400S2;
	Mon, 01 Jul 2024 15:43:39 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Mon,  1 Jul 2024 15:42:44 +0800
Message-Id: <20240701074245.73348-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
References: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v3UpXoJmVPDIAw--.64400S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7JFWfWFWkWr45trykAFb_yoW8KF4xpF
	WfJrZIkrs7urWrAw4vvayIgFya93say3y5Jw1fJ3y8t3yYvry2vr40gFyrWFsrCrnY9r1q
	vFWDZ3Zru3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4a0dUUUUU=
X-Originating-IP: [223.104.212.168]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBYOKWXAmBtWegADsw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_004417_839747_99C6E90A 
X-CRM114-Status: GOOD (  13.91  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>Hey Ping Gan,
>
>
>On 26/06/2024 11:28, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use kworker to handle IO. But if there is other high workload
>> in the system(eg: on kubernetes), the competition between the
>> kworker and other workload is very radical. And since the kworker
>> is scheduled by OS randomly, it's difficult to control OS resource
>> and also tune the performance. If target support to use delicated
>> polling task to handle IO, it's useful to control OS resource and
>> gain good performance. So it makes sense to add polling task in
>> rdma-rdma and rdma-tcp modules.
>
>This is NOT the way to go here.
>
>Both rdma and tcp are driven from workqueue context, which are bound 
>workqueues.
>
>So there are two ways to go here:
>1. Add generic port cpuset and use that to direct traffic to the 
>appropriate set of cores
>(i.e. select an appropriate comp_vector for rdma and add an appropriate 
>steering rule
>for tcp).
>2. Add options to rdma/tcp to use UNBOUND workqueues, and allow users
>to 
>control
>these UNBOUND workqueues cpumask via sysfs.
>
>(2) will not control interrupts to steer to other workloads cpus, but 
>the handlers may
>run on a set of dedicated cpus.
>
>(1) is a better solution, but harder to implement.
>
>You also should look into nvmet-fc as well (and nvmet-loop for that
>matter).

hi Sagi Grimberg,
Thanks for your reply, actually we had tried the first advice you
suggested, but we found the performance was poor when using spdk 
as initiator. You know this patch is not only resolving OS resource
competition issue, but also the perf issue. We have analyzed if we
still use workqueue(kworker) as target when initiator is polling 
driver(eg: spdk), then workqueue/kworker target is the bottleneck 
since every nvmf request may have a wait latency from queuing on 
workqueue to begin processing, and the latency can be traced by wqlat 
of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py). 
We think the latency is a disaster for the polling driver data plane,
right? So we think adding a polling task mode on nvmet side to handle
IO does really make sense; what's your opinion about this? And you
mentioned we should also look into nvmet-fc, I agree with you.
However currently we have no nvmf-fc's testbed; if we get the testbed,
will do that. 


Thanks,
Ping




