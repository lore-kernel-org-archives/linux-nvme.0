Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92216FD376A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJ804UQQ83e2Rnv1VzpHVArw1fg05t5j1rsobVSyUnM=; b=kbw3bWDtGMSQZkJ172TkLGPxR7
	TbFnE/hABVfmX+oNjoL3pi7aeMuJQljjhURa76rmp7plmTk8pz9g0hrLfXIALRaq1GDqrbVAJYZEB
	jEPgDXTRcf8poUsfo76aDHowsDAF8s+3F3oqQAoxZn2ylbHcPUpHX3T2yu4Xw0467eKHua7iSnrIr
	TCfGMv1Lg3u4kQ7LMyRWzoMVahpgTnz/ce79en82Z1fqUeYkx+Yh7lg4SQZJ1nrK6UJd+4TmRufkc
	/yzDaLLSg+5PCd80HZL7oscChmcCaj/jkmTxRiuh5CRl9ejQeTRWfYNo8XXoJP8E7cMyHGSIKLxMJ
	Lb+UgEVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHmC-00000004WWY-2XNF;
	Wed, 25 Feb 2026 16:30:16 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHmA-00000004WW2-3LqK
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 16:30:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fLg6r5kwPzlh1W5;
	Wed, 25 Feb 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772037008; x=1774629009; bh=vJ804UQQ83e2Rnv1VzpHVArw
	1fg05t5j1rsobVSyUnM=; b=oKDqJRh0D6vrq2hrDuQAWCr7+ZHvJBmruObJB2yC
	0iJ5hP0MKKYub9DnzowIBVtpaYR/t1o/q2lsH/q+ZGip59k5WZlnRwcRJ3hibvzk
	XX1zZWi9SYyGvIhXtbI6y2DMxwCBZd7nE2u12PNF2f480MWUS/V3sUnc8j/kIImp
	ApjjQ5WxkD+DnWPSO6JWfzOa6/FVB48s1+C5FiIxzJlBcnnjWF7zR9ZYrEnlBk+M
	cAwRLs79KryJ2bd69dnH9kQoBbzxFZrTTxSVnwppuYjtyNVMQsiF+bcuY0xQw1be
	Tba3TOYq0lPendvfe3Rydfg39DaTa8uZl1TFSzqSCOMxhA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WG1e1sKu4RAY; Wed, 25 Feb 2026 16:30:08 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fLg6Y0fk6zlgr48;
	Wed, 25 Feb 2026 16:29:56 +0000 (UTC)
Message-ID: <4bc30e61-e83d-4368-98bd-78f7d22c3f2e@acm.org>
Date: Wed, 25 Feb 2026 08:29:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "tytso@mit.edu" <tytso@mit.edu>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
 <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
 <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
 <CAJpMwygzTcBnKVp=bJWZpW9X5JdcP9Lj4H1BRBu2bNV_kGyDQQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJpMwygzTcBnKVp=bJWZpW9X5JdcP9Lj4H1BRBu2bNV_kGyDQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_083014_884595_1355DF9C 
X-CRM114-Status: GOOD (  10.83  )
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

On 2/25/26 2:07 AM, Haris Iqbal wrote:
> Regarding data modification, if the tests do not involve any crash or
> reboot, then the VMs can be started in "snapshot" mode.
I'm not sure that proposal makes sense. If e.g. an NVMe device is
specified in the blktests config file, it probably is the intention of
the person who runs the test to test the NVMe driver and/or the NVMe
device. Using any method to create a "snapshot" of the device and to
run blktests against that snapshot changes the kernel driver and also
the physical device that are tested. Not modifying the kernel driver
or physical device that are tested implies using PCIe passthrough. And
the PCIe passthrough mechanism can only be used by one VM at a time as
far as I know.

Bart.

