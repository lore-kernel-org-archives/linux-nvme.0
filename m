Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB799C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d27zCYs42S9n+9n/v63L4FKmE9Cnhxp8WX7B9YHj7CA=; b=Ehkwmp6cu+PkcakjDd5rDjYxkq
	jXAi7LBVzHusVK2Du+SUlVQwv0chwSTvCsvKpaa1Sm4kyUFflmLu9d5F2VHkdcFENPciytvNCfO+q
	0rA3gjE4/fgfn/9/52RpBFEo+vxs+2NWOEQpkrk/jzKayTX0bqf4LAlHEY4+DU0OVs8JZMElN5Rjs
	VzGHkZFtwBWqVootoZGY1BE3QpE8PWujDaH+/51x2CahraVHBC7nn6Nrbg1R1qjT0Grhtl5QrnIV0
	PtifkMjj7xKmHDREDjsJeoVeg4TpNeiRXnp3nAMQrexKGXKG4Gs/qB8SdAgEQH3ujXRFV7v6UBeqL
	RsinMZkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqfqH-00BTjH-Je; Fri, 26 Nov 2021 18:21:01 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqfqE-00BTiu-IC
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 18:20:59 +0000
Received: from xps-7390 (ip98-184-250-31.oc.oc.cox.net [98.184.250.31])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J132w3TH8z3k8m;
 Fri, 26 Nov 2021 13:20:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1637950857; bh=phl1aWAH9l464LCaH+K1OWwZCZbZwpyH3ognl/7nR6U=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=XJJqoaoYmR2L5pVp9YujIXI7lgkDXr8gKqHwPJSUrFsL8d75JBt9u35SRV05z2mDK
 kpOQC35tkxKw8cOKSao2VFFFryM1KaNh7dusAsknfNwa98NfUZLJ7A9FZmxcFyJ9Qh
 dYtApZdDqjfK7bQn7B02GNFLAjz/Cia8LXf6Z+pA=
Date: Fri, 26 Nov 2021 10:20:55 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
Message-ID: <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
 <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_102058_690471_EE8044AC 
X-CRM114-Status: UNSURE (   7.22  )
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
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Fri, 26 Nov 2021, Jens Axboe wrote:

> I'd just do what you usually do, that's usually the best way to gain
> confidence in the fix.
...
> That said, I'm pretty confident in the fix,

OK, then I'll just continue my normal workflow.

... but am I the first report of this you've seen? (I sometimes wonder how many
people use the master branch as a daily driver; an -rc went out a couple of
weeks ago that had a commit that broke suspend that manifested right away.)

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

