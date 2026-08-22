Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E347C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQsSKY4RFDWiAl51ZPA2gsNgt+U60A4Xp/sjmbBBAKE=; b=Zk5A74EtsjMIYWfBeq1YH3cjRO
	QJeeHfNxXLrf1g3Gmam2hLCG1UJ9SdQ08lSfyPuDXA0PVh+YVZCSNoob00THIee3TQr2fL+7OKiS9
	wAIiONq87GsT1z4sniKFT4cagluUa1wrvpnI1EC7reIa5XpSJFnetMCxI43E5LX4cgBaPQIlMT7mZ
	Gjc7PH8UhaDoveNmR9Bo1QZdNcDKjdJCscS/wWF/ISokDl8WH7jxI9AnX07FpqL1NWOTEXqak2HBs
	REXk4hXvthFM5/CSmpP4gl8Fbhra2Ukg3t6faKJmpzjrX8WhGRUZkdIFjKSVdglY2ctjD8OB2VmgW
	bbykcyvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxudv-0000000EsWr-3rsu;
	Sat, 22 Aug 2026 22:56:51 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxudt-0000000EsWV-3Rm2
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:56:50 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15e592da74so316526466b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439408; x=1788044208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQsSKY4RFDWiAl51ZPA2gsNgt+U60A4Xp/sjmbBBAKE=;
        b=L2ugvxN+vGWrQZw0C26eovAzPMTGXMTt8qhrZOsg5FsBkMS7fpTnIiiC3jplK5BBLW
         CVMjbVakC2GNzs8gjcpEbIPY9IMdHX2dO4LAZozzI3EEdK7QrYIeGLltXzQ2msV5EtZO
         xuLZSuQ/tAY+EFPUqGYqTElG0wA32koO0riyxUx54+Gb7V+LNZY6YNJRBGGqyN78oScA
         +zDBx6rLz5Jt9WGLe+pzI9+YR2O3byVhSvaMm2frFgLrqydWww67+JBSyNt//+OAqND0
         ImteTzqiAeNgcpkhfd74C9C+knmUy6rB1L4V3HLLQSuKSJVeBEA0IY/XIlsKdBmLys9+
         tDQg==
X-Forwarded-Encrypted: i=1; AHgh+RoejckIBbdn7YRKvpWIcdd9T2eE5/6rtOS4Y7832sEIF+5BCVLYey0ff5SYag9q+6OaWg6Me5fikaRY@lists.infradead.org
X-Gm-Message-State: AFuF++mEPUpdGDbHr75a7UzAOp+ZHoWIjEs3PzR2AgXrefCSL5avoNUh
	sNTkaHdOqaDH9SVyMNsvGER6d4it8kigBi8bhg3/ysSjQNCO5F/gQR5j
X-Gm-Gg: AR+sD12SqU9qPfHPwd86p4pKg91/D3BH0oT9BoqJpo3qnV896YGC6rjBo8PV7EzUqun
	Cj4fRKIVlU2dwIN/TXHyu9f1yRkycarsgqLzrhGdl8PKkjEadoXykNAsE3OQ2j4oXrFSFwcw19V
	u4H9AnM//P1gadqo1pzjLoaZMBo0LMjSB9DtarQAH+p6YzlORpDNxQqnd1azZ4Lr4/O6rHbuYC1
	GR8A7j1VWUiSiDCU00NCB/henIHf8grTltR7M7bBdcepMewWl7wst3NXEmuxXu4XG7x5/11IxJm
	e4DF054kLxi/WuV3GMTOAim8p9Hi78ECqYJ3BWq84CceiSAZJnLnKBr8CVABNK19SpSTlbQf2Rb
	phKCKjbUoWc0shN2B87EFexIKK82AYWR+vdaDjZL6vAzZWnvxXqcmOh5YuncgCVTUDL1VyV71gk
	Uh/Df2oC3uKHbw7ezpCZiMHylzfPIwxcicOA5REZQp3+NYE7bV++BR9u8sRz1oz0ZSJO4y2qKdp
	zgxbb5fHmlgIR+ZDK5ct38=
X-Received: by 2002:a17:906:730e:b0:c24:7cb5:d617 with SMTP id a640c23a62f3a-c249238c369mr947885566b.1.1787439407495;
        Sat, 22 Aug 2026 15:56:47 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1abfa0sm66898a12.20.2026.08.22.15.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:56:46 -0700 (PDT)
Message-ID: <f6ac3bea-c224-423c-a85f-3501da5ce21a@grimberg.me>
Date: Sun, 23 Aug 2026 01:56:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: verify the hostid when looking up a controller
To: Chuyf26 <Chuyf26@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <4hPZnl4QzqzC89J7@eforward.registrar-servers.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4hPZnl4QzqzC89J7@eforward.registrar-servers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_155649_874059_A02C8B38 
X-CRM114-Status: GOOD (  15.67  )
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



On 18/08/2026 19:26, Chuyf26 wrote:
> nvmet_ctrl_find_get() matches controllers by cntlid and hostnqn only.
> The hostnqn is not a secret: any host that can reach the subsystem can
> put an arbitrary NQN into its connect data.  A malicious host knowing
> or guessing the NQN and controller ID of another host (controller IDs
> are allocated sequentially) can therefore attach its queues to that
> host's controller, issue commands on its behalf, or disturb its I/O by
> tearing down the shared controller state.

The hostid is not a secret either.

>
> The path is: an unauthenticated host sends a fabrics CONNECT command,
> nvmet_execute_fabrics_connect() parses the connect data capsule and
> hands subsysnqn, hostnqn and cntlid to nvmet_ctrl_find_get(), which
> returns the first matching controller.  The connect data also carries
> the host's hostid, but it is never compared.
>
> Also require the hostid from the connect data to match the controller's
> hostid.  The hostid identifies the host installation and is generated
> locally, so it cannot be chosen by an attacker to impersonate another
> host.  Controllers that were created without a hostid keep the old
> behaviour.

I don't have a problem with the change, but I don't think that this
should be positioned as a security fix, its more a correctness fix. So I 
would
suggest to change the commit msg body.

