Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D84C79FB7
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pZrI40HH1n4N/HcR7OgdkwT+wvdMgjaLG3YYi0LP1s=; b=1d+DgJA+hXq+vesjsUaz21UpO1
	06+oF6oVNxWlPWY8XLui1VHLgAbld0QvcB67H3o7EakTrsTqwEzLf6NCT1THWPwhnZSxh9d6e41Om
	rCE1j2irAQALQlE8a6y0oelPVx7aqMNiEuOQH3GhmetzpIuI+H/IfM8q8W0rNMlPNj0izQ85ySYhf
	fjp5XvJ+SSb+z2lIpcTRo7BnCzAPbsFUPU9JUbke9ajNc73uLe01sWm9LhTRYSpsM7ZWyB5JTTrkS
	LRC8bqxwM13b1qI0CVTygvlWaVVQtCoJI8WBjoIHLZDQqvrLxXfu3/NAYzEJo65E0vMiulRLlZxvA
	wUvC6c1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XRQ-0000000DSXH-24jL;
	Thu, 10 Sep 2026 05:35:20 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XRO-0000000DSWW-12Yx
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 05:35:19 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ceab75934dso64564845ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 22:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789018515; x=1789623315; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8pZrI40HH1n4N/HcR7OgdkwT+wvdMgjaLG3YYi0LP1s=;
        b=apkD4bKwlCum2A1pwrRuIcsCFa7yPMHiuOm7Q8L10DaCFO+AN7F/78BC2ZazmRhcIy
         afsIVAgtum/S23wqmJ9WxvWONk6grsFxb3wCbOIWrHAjS8f4EA4/IMqLMn9DORx9Sn4O
         tiXmgbsCHQVYilZ9OHWoAi28N6abRxIFVfMTllEwUlZGyTgW42zu+oE21coLkv3bIZW1
         D2N6/J+4SgNhGPbKJbpaAoDcwLUKAnkz/mUsY/b/eBZ5UjgphOLusgElFmQq8W05Gm0S
         S25hhyWFdGgNT74hYz+HqN3CDIxGSGqUpmjTg7oc23tNsaKpbCLk503IF9xtGyOSW79A
         3fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789018515; x=1789623315;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8pZrI40HH1n4N/HcR7OgdkwT+wvdMgjaLG3YYi0LP1s=;
        b=QlVDR8FVoC50hcD2ng2V6amNpSfREpAOcFZnrZeTfh79GEWtXRzs+Htqd05Quncu9J
         rHjcudlYQL/oDiL0W5QWZ0SUbSJnX6hiXl37tnUBRxw3CjnScPZKymBJ+eVcUxmIVIzi
         Bh6QSjGajOGoRxj0UBt8Ta/yOWg3ejIE8MtlhCgaZ83M61OMB4XM6ZpCjrTIQmFKNiBw
         V6W5Npe2aSKdGXHW65/nje/3z6drtbpgEQT2RBM+WdXB9PxPgMOA+9CF2O0o+/gl2ylP
         5WDNqd0U5BoCK93pU+1CMNejVGgfrXak/Lr8gi5BERvwM41QKfLL41YzDmWCWLvOztGf
         Qokg==
X-Gm-Message-State: AFuF++nRbQxzXyIpKdP0yK4B6P7/sTad/zZV0YxY7GQOsWc13rrs+UqB
	8v4p5UdFffKUdKAYlgXHr2HRfG/N6UO5LKbh0Mn985PHiGo9ix3iROamZCv+Hv8BmbC3Ms1eDvq
	iiZXJ2Ps=
X-Gm-Gg: AYBFou26+Dgs6erev6LcPaZ0JMCxvGSagYubKTtbDW6X+r0U/65hJfDPpTdp5A2ArWJ
	+KUaRvW2SwrCKyTGK499WF7V8pFYRe30OnjAHswrn2x9Y46ceDFvHZoeQA7tAHupgOeslx/feBd
	wxmVApJRooVqsekN9CQgnfrwSOS4rLmVsjbwTkbw2h+0hd3BF4SkHwzrldv1mI+Lhd9QfyR2szq
	QS/88rtGynQWfCl08BY13tnYs4PNJk3h4kL7vm/U4Aw9ncTuLPyzvPD7phNVLIiUJV8KJh/L0pL
	g+ZF/ZVLCJwDAWuo8mbouWYrJ3UxSfmra8Psyzaq61+M0h2YOoPEd9OYGlj5SkArm0B36qq13rA
	x1vZZ2Z9vDr41joRz6/dqLn29iGs5Idl3P1nIkiYewRHFETasrOo2WmO6KRTE9H+PhLDhpxiHyL
	spfiGoTyMEvPsTjU4r7kQydBXb+H7bFpiDGd+TnAuTlzZSxJ5aPt0vyTrmSWDkFds4M7Kte8QEe
	v0zIH+s33djrNr6KukXa4kmtqZWYoQ+PuSzDdKw018=
X-Received: by 2002:a17:903:2f0f:b0:2db:8406:db91 with SMTP id d9443c01a7336-2db8406dc06mr171753115ad.10.1789018514405;
        Wed, 09 Sep 2026 22:35:14 -0700 (PDT)
Received: from [100.81.12.150] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499f06fsm79929015ad.54.2026.09.09.22.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 22:35:13 -0700 (PDT)
Message-ID: <72eecee9-c103-4c6b-adc8-0fa1367313f3@bytedance.com>
Date: Thu, 10 Sep 2026 13:35:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: preserve device path on allocation failure.
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kch@nvidia.com,
 armenx.baloyan@intel.com, james.p.freyensee@intel.com,
 ming.l@ssi.samsung.com, Runyu Xiao <runyu.xiao@seu.edu.cn>
References: <20260908033519.2721210-1-sunjunchao@bytedance.com>
 <20260910052503.GB27133@lst.de>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260910052503.GB27133@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_223518_303613_99D29938 
X-CRM114-Status: UNSURE (   8.18  )
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

On 9/10/26 1:25 PM, Christoph Hellwig wrote:
> Can you coordinate this with the configfs path checking series
> from Runyu Xiao?  That one had a few resends, so I'd like to get it in
> first.

Sure, I'll rebase and resend once you've merged Runyu's patches.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

