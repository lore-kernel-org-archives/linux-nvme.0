Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BDCA9ECF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 08:13:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A6921744
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 08:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WvL0CZw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A6921744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymNtVqA5gHHJsfjjZJr/GHl9g9VoS065U5tmh0UiD0M=; b=WvL0CZw1qkISp0
	RVTSUInETQK/Yaj/bHApP6MGGsVkQxpuQZ3YYJ2Stq1hNg9wtlFcKY1QtcEInxby5YNMFknHheSpa
	Zx3VOj2H+lfX4WEN3NJIddcii+5yHa147ssBC30pBzIh4BFji+nzuULAk8CsHa54nhPFNbVjfEK1T
	rkvLu2IH9kgKSNgBK4daYjL8NOVlM8Twv5l4a7AP8JfZsqppo9vu8bcqtyo4k82gzdpkNcs+RwAi/
	D426BwLLXSSHnDEcbKbQ0TG6GhPwZFqFCtsv6azd4FmG6j1BZpL6ax2l21UajTuRMA/RTsjptBCZ3
	9+r7VJ0tPE/fzkK7DgeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRXUf-0003td-9I; Mon, 04 Nov 2019 08:13:45 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRXUc-0003sy-Eo
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 08:13:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 89886B45A;
 Mon,  4 Nov 2019 08:13:39 +0000 (UTC)
Date: Mon, 4 Nov 2019 09:13:38 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Message-ID: <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_001342_642087_DA61DE5C 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 jthumshirn@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya,

On Sun, Nov 03, 2019 at 12:13:10PM -0800, Chaitanya Kulkarni wrote:
> I've added the code to loop over and clear out outstanding requests
> present in the ctrl->async_event_cmds[] for which aen is not generated.
> Also updated the patch description.
> 
> I did the basic testing create/delete ctrl and enable/disable ns that
> did not produced any hands or errors.

Thanks for addressing Christoph's comment. I'll get this patch into
our customer's test setup.

> Following is the test log if anyone wants to take a look:-
> 
> nvmet: adding nsid 1 to subsystem fs
> nvmet: creating controller 1 for subsystem fs for NQN \
> nqn.2014-08.org.nvmexpress:uuid:a0b58ccb-6b6a-4045-8ee1-641816bf548d.
> nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> nvme nvme1: creating 12 I/O queues.
> nvme nvme1: new ctrl: "fs"
> # nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
> /dev/nvme1n1 c71f2d6a3f577a29 Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
> # cat /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
> 1
> # nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
> /dev/nvme1n1 c71f2d6a3f577a29 Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
> # echo 0 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
> # nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
> # echo 1 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
> # nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
> /dev/nvme1n1 c71f2d6a3f577a29 Linux 1 524.29 MB / 524.29 MB 1 B + 9 B 5.4.0-rc
> # echo 0 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable 
> # nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
> # echo 1 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable

BTW, I got feedback how to produce the oops on our custerms setup:

Test Steps:
1. Create two targets on node n1 as target side (tgt1 and tgt2)
2. Run perf to write data to tgt2:
   sudo ./perf -q 1 -w read -o 4096 -t 60 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'
3. Deleted tgt2 node n1 configuration during perf execution
   and reboot the node n1 automatically.

I hope I got the steps summerized correctly.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
