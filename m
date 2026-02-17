Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9F8E9A031
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4bYYczNcYGm6Sri1HPrON3WM1fljoTB8513tgTbjpU=; b=nQE3rQAD51mVELtMzrpMXZFjbF
	1lTqRCaeW8IIj+0IpMxMQUfWvTEtSh1iG7l6WOoYTacakMzlKTHPDVOisOu6VXlUDCiOTj/VebgWb
	UgSHvzB7LdiHFDs262Ny3e0w9HqAH+c1TO48xpPKDbafjC4JKWljkz8kfe9KrIU3gKe4sqUM5rYaS
	CVKlWSpBsngsYSuMeOllq0Lwn500n91SMMqtN6p7mdcFUcoC19cRWaAkQPDPGO+EpHC/FXFOv+oyN
	1Y7pUmu01bljnxOXLQQCyqF7USQuGyg1MCeonO4JXixq2FHVfB0FoUrr6+6ZATeP87JgroSpD9iKh
	+i+Ki8vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsQp1-00000008oKJ-0fib;
	Tue, 17 Feb 2026 19:33:23 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsQow-00000008oJw-0dhE
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 19:33:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fFqYm4mjgzlfftt;
	Tue, 17 Feb 2026 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771356795; x=1773948796; bh=T4bYYczNcYGm6Sri1HPrON3W
	M1fljoTB8513tgTbjpU=; b=2U3ts7V9suosHzmy4Op6FK+h8TusScpiHd2Rk1jD
	oVnCcmSnQmhmcZGASIkaYgXvIpNtitXKP27VHuvSL36nTSXgo6NL4O6yc+SMBiiJ
	rhAOCKUK1uLqgefLDP2hOU1orvaji4RdUAwvXAOFSA4VLKt8g8uAnZ9cZaD55cjm
	RDrV1uGSx+mj4WG/q7nScODxhGWC+gW38BZgvwRIF/vlYF4kvLLS23w+a+mnLEx0
	ssyNOMyaYtdak449gD/e8zSHjti03+Q5XaHAAWLe0Bo7ttFwE2lqcv8zzcNQXe4S
	MyGOVTQLRB9QcPOUbXBJunbL2/wXkuv7kmxxUHK0Cr/UeQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lpWsix-s36xa; Tue, 17 Feb 2026 19:33:15 +0000 (UTC)
Received: from [10.237.57.149] (173-255-98-114.utilitytelephone.net [173.255.98.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fFqYj5VCFzlfdfX;
	Tue, 17 Feb 2026 19:33:13 +0000 (UTC)
Message-ID: <049a177d-85d6-4c9d-9a9a-f07391046101@acm.org>
Date: Tue, 17 Feb 2026 11:33:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_113318_211334_D5DFF593 
X-CRM114-Status: GOOD (  11.55  )
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

On 2/13/26 6:19 AM, John Garry wrote:
> At ALPSS 25 I presented a proposal for Native SCSI multipath support. 
> Let's discuss this topic at LSFMM.
> 
> The idea for this is that SCSI could natively support multipath, like 
> how NVMe host driver does today. It is intended as an alternative to dm- 
> multipath support.
> 
> I have been working on the implementation and I plan to post patches in 
> the next cycle. I am looking at a 3-stage approach:
> a. create a driver-agnostic multipath library, very heavily based on 
> NVMe host multipath support.
> The library would support features such as path management, path 
> selection/iopolicy, failover recovery, PR, delayed removal, gendisk 
> management etc.
> b. switch NVMe over to use this library
> c. add native SCSI multipath support based on this common library

A minor comment: maybe "in-kernel" makes more clear what this proposal
is about than "native"?

More important: what will the performance impact be on SCSI devices that
do not need multipath support? UFS devices don't need multipath support
and soon (later this year) will support more than one million IOPS per
device. Further performance improvements are on the roadmap.

Thanks,

Bart.

