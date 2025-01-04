Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C74CE77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGk95VCEudAv4vDRoF2lx16EXGgTwg5PcB2eBxilmvA=; b=hOJDgkjxKH/dK+69UVMHxukQuh
	cnbkAjLTcAIbS1Uc4bcJ9kK7CELKKmhlGnUigtReW5egyiHX5DA56NztSnjL3gROWS+pXYYgA8SrC
	C3U8bAbiP0ZliZcm2bP4kMfheF3EXrwG6spMumF/vvNvX8XDTugDGZ20ypf9VaWXVYdto9DdgA3Hw
	BeJQg4mVh0XCAvXoP9RshLBohRXG6uJpzMbnxh0fs+f43ZKEqY3PB+ilnNsxQhchylA33SY2IReX2
	FpmP6CF/+d50Z5gH7ON3+rgp9mcmK5nsHqQWQYugMpWyFCyucV/FkFhHrRakUOcRJvVW/vNwu4ggZ
	1okUiV6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4un-0000000F5Us-1BdX;
	Sat, 04 Jan 2025 14:14:09 +0000
Received: from www262.sakura.ne.jp ([202.181.97.72])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4uk-0000000F5UZ-3r7c
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 14:14:08 +0000
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 504EDkh2004159;
	Sat, 4 Jan 2025 23:13:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 504EDkRL004156
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 4 Jan 2025 23:13:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <554a9279-4909-4fc5-a46b-cf2e20291555@I-love.SAKURA.ne.jp>
Date: Sat, 4 Jan 2025 23:13:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nvme?] KASAN: slab-out-of-bounds Read in
 nvmet_root_discovery_nqn_show
To: syzbot <syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com>, hch@lst.de,
        kch@nvidia.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        syzkaller-bugs@googlegroups.com
References: <67627b39.050a0220.29fcd0.0087.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <67627b39.050a0220.29fcd0.0087.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_061407_176565_E5D5CFA1 
X-CRM114-Status: UNSURE (   3.16  )
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

#syz dup: general protection fault in account_kernel_stack (3)


