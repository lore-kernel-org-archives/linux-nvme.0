Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5269C4451B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tx+xtzfn+syx+ZGr6WobWKJoSkVcEBXRoEYJQngWURo=; b=Ex4lfcd6sL+W5/vM81Dk83rD9O
	X88Ttt1u0W4X6+TwgMF+psIv3c2LoQpQ3XwdtDNK58pAnENZgSEYCbtyVQwtvN1wQmx2N6OzzT0gq
	jknCZWYZqswz04fQ0e7t+K+21ASM7yuEDfHc09tQEMtut7fFmGMyJwSBp75uNhN79vNpxt8LMBm5F
	gT7HGYu1UiZ1FKLmBjyb9pdlRPVMn+iQIo8dbvzF6y/z+mjXVDRPquHyyGwsZhSRL2fczdKAqt0cA
	YUcyZ4rM2XgABwbKYVzaSToPV/E9ABGz/r2aiWnPgLXi7bO0s1n7FBnCKa3Qf8feqNCN4LQUijk8j
	IDlU9Upw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkm1H-00000002ofq-0vgH;
	Fri, 17 Jul 2026 17:06:39 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkm1E-00000002ocK-2qJz
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 17:06:38 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h1xCG4yjtzlfl6P;
	Fri, 17 Jul 2026 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784307989; x=1786899990; bh=tx+xtzfn+syx+ZGr6WobWKJo
	SkVcEBXRoEYJQngWURo=; b=2MNnncFV1dqKCmys+oNr6FokU7Zusgz65yivMbS+
	n2Pie4V/sMHevAxp/UqaY2vnmY2bXkHyZsogcyoC0ZVxoTdQNLB7EgBaTG41pUko
	WaL5PClBXyTZOJvBxj+AsYmSIQ4GqbvuhcAXKOWS4lbN61dQ4wJPKHuG6xVBEHuv
	xAyTSRVU/EY0E+Tkp+S6x5SkgIkbp3Nz6dDCf19/nrtdk88hZ6opzsacRs0mvPhE
	Gfu/qAm8I/cefsVY/p2414xQGfwfU6Sp/pesGf5svBrVwXOKj5/JcYsN6PpH2Yyg
	YpTnHHSR+L7Wr/boQSR/Dnq1+maJgDoGMh7CwuOVoLyHQA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u0TF5kVScKfW; Fri, 17 Jul 2026 17:06:29 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h1xC62b0wzlfpM6;
	Fri, 17 Jul 2026 17:06:26 +0000 (UTC)
Message-ID: <3c29b8cb-906c-4c48-89cf-59c676900616@acm.org>
Date: Fri, 17 Jul 2026 10:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] nvme-pci: adaptive interrupt coalescing
To: Jun Zeng <jun1.zeng@intel.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 andriy.shevchenko@intel.com, gang.cao@intel.com, jun.i.jin@intel.com,
 yong.hu@intel.com
References: <20260715075703.15578-1-jun1.zeng@intel.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260715075703.15578-1-jun1.zeng@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_100636_756610_B3D6947E 
X-CRM114-Status: UNSURE (   8.58  )
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

On 7/15/26 12:57 AM, Jun Zeng wrote:
> The IOPS for small IO can be significantly improved when enabling
> interrupt coalescing in this case. However, in some cases (e.g., big
> IO for bandwidth or latency-sensitive tests with small IO and small
> queue depth), interrupt coalescing has side effects.
> 
> Solution
> ========
> 
> Monitor the IOPS and average queue depth of inflight IO periodically
> on each NVMe drive and enable/disable interrupt coalescing
> automatically without user intervention. This feature is enabled by
> default and can be disabled/enabled through debugfs during runtime.

An algorithm like the above can be implemented more efficiently in NVMe
controller hardware than in software, isn't it?

Thanks,

Bart.

