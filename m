Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E05CD128A
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Apr 2024 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+xvWi+eieOuhhFLjvid8GsEZ+XVjZugxUQaNWyFgfk=; b=XHkBe8swi+Oe5TlHtqmhoUOXeK
	MIcXEHBZF1llbntL7spuy7HouJrPtWL3Y6+dlpivCc0h5l918Zq3xzoeQAdd6B7JAIBFh1iJlqjVQ
	yawsW9XC4UgUWkltIUs1kObJS/kUEkOgpPNeMcSq3dnlh5L+Gj9oD+Gc3gR4S5M817TgurmwphXCA
	dJJLqk2y15IiuAjQxlAhNYE1B/3Ya780HShRQYWiEVWmGz6U7CEFvoSJhVT4Epr1QSaPgmlatGszM
	V5rON1Ir/ccBYPFhInhmgG9YLDbL1Wm1hnJ0GN1uFFTz3HEzEaDu2HE09IYTWWU14mnQbGPxE/2sm
	WKok56wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsyrX-00000009k4S-0Y8d;
	Sat, 06 Apr 2024 05:45:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsyrU-00000009k3J-1IwN
	for linux-nvme@lists.infradead.org;
	Sat, 06 Apr 2024 05:45:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CB90160202;
	Sat,  6 Apr 2024 05:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC42C433C7;
	Sat,  6 Apr 2024 05:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712382306;
	bh=AF9MjjeX9uWkxGvAF0vqJAZcyFS/QHg117A4xiMxDfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uT/CL5RuKn6xzqAdKV2CuJEMuQWRBfGj5vwrEw/WfXt3KFyQsPdekV+LkeEsXcquu
	 IVRMr9RC6ho+fCJCRiv43UTz7FnrQEsZDxoPVugzyPPinIrPvhNKqgrnycf2YJE0Qb
	 xazs1bBj+gRD2q4KvY+UCOpnqd7hr9011uHUzw1YPHlIAZJeh9y21o4cd22VmCqEFD
	 a39h3gVLSvivydyRCgyj1kDuJOLQ4VKPD4UPGNVXZMsEjpRaTVPnCEtlqlW2v6vRRq
	 EeSNfOK1AzTgaGE6XcdksLzmOS313QH/HdB+36DMXAWs8BIMTgC236iMS5O6mi/i35
	 Yr3j/cE6F0dag==
Date: Fri, 5 Apr 2024 22:45:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Message-ID: <20240405224504.4cb620de@kernel.org>
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_224508_475671_34F8EE5C 
X-CRM114-Status: GOOD (  10.45  )
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

Doesn't apply, again, unfortunately.

On Thu,  4 Apr 2024 12:36:57 +0000 Aurelien Aptel wrote:
> Testing
> =======
> This series was tested on ConnectX-7 HW using various configurations
> of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
> targets.

About testing, what do you have in terms of a testing setup?
As you said this is similar to the TLS offload:

> Note:
> These offloads are similar in nature to the packet-based NIC TLS offloads,
> which are already upstream (see net/tls/tls_device.c).
> You can read more about TLS offload here:
> https://www.kernel.org/doc/html/latest/networking/tls-offload.html

and our experience trying to maintain and extend the very much used SW
kernel TLS implementation in presence of the device offload is mixed :(
We can't test it, we break it, get CVEs for it :( In all fairness 
the inline offload is probably not as bad as the crypto accelerator
path, but still it breaks. So assuming that this gets all the necessary
acks can we expect you to plug some testing into the netdev CI so that
we see whether any incoming change is breaking this offload?

