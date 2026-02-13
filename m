Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC94EDF17E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qw+nmt5g75eVQsyFf1dwpb9Qb8LZe3oktqm/rz+BDGk=; b=Wo2ubHadMEx70/dZk102DgMI6V
	gIY+KmNhyTGcAGgrWuoWRKoceLfdAyGEOcdcxhM1DCWio9wD3xvDy93WReVy6mCKa2IR4SYEhHk8S
	RsptEI1RSat+2uqUyFekTGEBilDJrt7XcU55k3b7bxzTc48hmYfxUVr2v8njGPRDAQ8JXvVMJr6QC
	jL0j0lVokqSn+LsZGLlboU7qujn+bbDzCAnNT3Y36QSoY305Q6wyEv8uOFZ8bbeZvjPFYbb7xKnii
	JW7+ADv9oqw6KuMB/tXIL1nJuSbxJkOLFKKrFb5792c+dty2Y3EbQ9cpHb+s5NOM96wwMFQrzhFNF
	ugJbhDjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqwzu-00000003kL1-0II5;
	Fri, 13 Feb 2026 17:30:30 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqwzr-00000003kKf-077y
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 17:30:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fCK1r4kwWzlgyGl;
	Fri, 13 Feb 2026 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771003820; x=1773595821; bh=Qw+nmt5g75eVQsyFf1dwpb9Q
	b8LZe3oktqm/rz+BDGk=; b=D2zogm7MPVwmOtG/PhzIQMBy8uvt5tPBfMvt+iEk
	LIu0VxyinTQdodPz6m6pf35HxWc+KWL+7PjRktkwTnO8+3tAKi5vLKifa3Xkl4U0
	ntdqbGsOqxeCUytdTmtn1vAmQQEJHWCD7di2yqm5OUjR7FMMlBEyB0eRoO4Y0YtT
	DH2wqgbeuMd2fBweuV6JsoKLtYtgjZi7lKp0QlGKPU4yxMyw643IWGWwcrm8iJly
	0kSSVviJZ+1jVmUwRD6Ib2impNwGZh8WHD5IxgWlDrfPu/EHO38JYnOpNDU+JPZS
	eXZeSIrClLFN4mdkCkhA98mjgIo2j4tj4yJpy0HWnfB2+w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ys93-gQyVswD; Fri, 13 Feb 2026 17:30:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fCK1d43XCzlfgPv;
	Fri, 13 Feb 2026 17:30:13 +0000 (UTC)
Message-ID: <678a951d-7da1-4089-a3d8-f9d9cb48aa35@acm.org>
Date: Fri, 13 Feb 2026 09:30:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "tytso@mit.edu" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
 <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <24634187-a4fd-4fbd-9053-03484eadf16f@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <24634187-a4fd-4fbd-9053-03484eadf16f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_093027_120136_203EF119 
X-CRM114-Status: UNSURE (   8.16  )
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

On 2/11/26 11:57 PM, Johannes Thumshirn wrote:
> One thing that comes to my mind (and that I always wanted to do for
> fstests but didn't for $REASONS) is adding per-test code coverage
> information.

Code coverage information is useful but it's important to keep in mind
that 100% code coverage (which is very hard to achieve) does not
guarantee code correctness. There are many state machines in the block
layer and also in block drivers. Code coverage information does not
reveal what percentage of the states of state machines has been
triggered.

Bart.


