Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF0C77B7D
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otw4X95PkUOPpeuL7KfgewrSyKMLFxlV5SEKS0gsNLM=; b=wfYVdH//c0pD7NplE1gP7yg9OS
	MIbI64s7ymZTZJS/2omcgiUjpSRnQXPfctKaaZcrufwml1dsPwa5ZR2PHjHaZBT4NdaWmVwe6STDP
	G8UdpcUyrQW9InErsHrY37tjC4EXMvjjGmE5b393LgvkDA/RNmgWhrA/JCg3RBF2XrUyonkkiRbs6
	OR9PBQYhk0EOKuGRng4Spj+umaeR+CI+P0f6/kM5SHIH55wrF4ZMJyQSUHWW3nuBLUiCPqIery4ew
	XKNpbHF3cWUYZMdTOtyVCm0166JB5gArlsmq+rtTG61wvtgpmHMvELjYcL2uQQhc1NkkZSp3c9z7I
	uGwfeUPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwoJV-006jAE-1p;
	Wed, 10 May 2023 18:13:21 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwoJT-006j98-0h
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 18:13:20 +0000
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6438d95f447so5306169b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 10 May 2023 11:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683742397; x=1686334397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otw4X95PkUOPpeuL7KfgewrSyKMLFxlV5SEKS0gsNLM=;
        b=SpWFCpm0RasMnEVxo4iE2xCklLXu10xj+w7JtEiUnzYDPEwRmiAKQnytSbgzeS9lvB
         sLIsiam/0S0vwPvi22ptylShf8wgdCjmq7Ekv/9pErzY7KCFgX4v/H/RQQTFfShqgVud
         PzJv/ksqtN0W2SzMCP/FUH9chxHWTziJble7eaNNjpa1nuNzndTJM4tNHZ7U3i3FlH7I
         3NiK0hGiIaPHFCI4yfvsshCLl0HQEjrM6oxe9USG5/9TjVMyid2fHstfruWL9qphR71F
         mM+qxy2PeF+5QJj1cABAmtqnxnl0+9sYnd19LaHFOX5AhYT94xphpVBfe+k6qB2UpsZ3
         9ZWw==
X-Gm-Message-State: AC+VfDwae858Y28Kh6pRSbydGv69ateACs7kQJkhZiIVnx8M0NXXgkdn
	xr59z2+RZO1mu28+D8UMWVU=
X-Google-Smtp-Source: ACHHUZ6B/TE+xkzCTGiDvLFKPusoAMt1lNruQDKiD1DgcpTbossp0yhHaEq0jNot9jy1YKFH/wPMYg==
X-Received: by 2002:a05:6a20:160c:b0:100:e1f3:9bd2 with SMTP id l12-20020a056a20160c00b00100e1f39bd2mr12306331pzj.40.1683742396573;
        Wed, 10 May 2023 11:13:16 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:683e:4887:89fd:3fd0? ([2001:4958:15a0:30:683e:4887:89fd:3fd0])
        by smtp.gmail.com with ESMTPSA id e18-20020a62ee12000000b0062e0c39977csm3799084pfi.139.2023.05.10.11.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 11:13:16 -0700 (PDT)
Message-ID: <47a6278b-e9d2-5e46-024f-fae53072e56b@acm.org>
Date: Wed, 10 May 2023 11:13:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Max Gurtovoy <maxg@mellanox.com>, Hannes Reinecke <hare@suse.de>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <ycdptic5i3aerzpzml7eitzb7wn7wj3vwk3bric2ogus6m3uaz@33zh62c3mmco>
 <a7458945-5187-ad13-e75c-bfa6966c5e44@acm.org>
 <8355cb08-08fc-d3c2-8fba-520d294ac38f@grimberg.me>
 <3mo7ptzamxuwbg67xogmqy2mey7evrcby57oiejiazds7h7xz6@7d6gvypprr5z>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3mo7ptzamxuwbg67xogmqy2mey7evrcby57oiejiazds7h7xz6@7d6gvypprr5z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_111319_253249_F5A5064E 
X-CRM114-Status: GOOD (  10.04  )
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

On 5/10/23 09:09, Shinichiro Kawasaki wrote:
> [   70.030101][    C2] general protection fault, probably for non-canonical address 0xdffffc0000000008:I
> [   70.054774][    C2] Call Trace:
> [   70.055795][    C2]  <IRQ>
> [   70.062128][    C2]  lock_acquire+0x1a7/0x4e0
> [   70.067127][    C2]  _raw_spin_lock_irqsave+0x47/0x70
> [   70.069135][    C2]  hrtimer_interrupt+0x100/0x810
> [   70.071129][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
> [   70.072201][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
> [   70.073246][    C2]  </IRQ>
> [   70.074097][    C2]  <TASK>

This may indicate a use-after-free of the lock class key by the
following code from kernel/workqueue.c:

	lock_map_release(&lockdep_map);

I will try to find a solution.

Bart.

