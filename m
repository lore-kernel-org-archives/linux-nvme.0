Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BC2C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 05:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0E6pRW7H9SPboldCye3qFumFzEvC8iObmDDh7VMUr7c=; b=zij3VtHHUonXbr/2LBka7v+p5v
	zdbxNArD7mYaYuq8QjOOxi+4ePUX0I+II6i3XE7SDVJ42o4IVClGJYyQ600uVXpoPgjGZEjdgL0MM
	NKUbfRNPc7+jb66sldAJ/OshB/97T7fUZbDaOKT0rjuepO4aVtG9RjCS0GZSRnw1N+vS1wnb9yE36
	XmBrkwL19sV4EMQiQmmTNS73rszXGYhynoU6AAEi1YzPfCW9d2kRTKMWol0o99OS6NYIlT7ObD+y3
	kche7UgeOEbx/zJc3wdU715oT1tg1e6F3yl+HjpbsJXd6xB2GhSID1R5e8T3Rau0ls/Gibz97eSMG
	NorD5xlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwG4k-002LMj-0s;
	Tue, 09 May 2023 05:39:50 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwG4h-002LMN-34
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 05:39:49 +0000
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-643a1fed360so2781204b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 08 May 2023 22:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683610785; x=1686202785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0E6pRW7H9SPboldCye3qFumFzEvC8iObmDDh7VMUr7c=;
        b=BHIJx1/pUOtiQCPrQLcGh93k3uR7Q8gJzjlz1MJHjlpPQErCwv63tQ+8IiMor7Lfbf
         34aLOKgX4o63p/yg7Ugo+nM7pyuPmlg7PFctdSNwRbmpiSXXLdRVZwHDXyN8xZt7xYk0
         vhwFNDhXnLPDUshoKn/ZhekrpwK7DaMKBERbGYNBd5xFhRYQwQuophL3uQBLl9kYoL8x
         qz33rPtUSRo6sdu8rRJ7Rt/t1thbBYxWf94jFRoDfl1M5elpHouRKW1nsawrIwAdszYH
         2eXpq1hKi+jGZ1Vm3zvhy10GeuPwmfB8sRnoY81+lcfBZnLoxdh3R+iXcKNDM94sI75y
         iESA==
X-Gm-Message-State: AC+VfDwLjK08E8rccu6PIxs4VUSjCwCEdo1JQH4peDIBo8LoMFIip0+E
	n7a0jzl9pW+UXZMXl3WMM3g=
X-Google-Smtp-Source: ACHHUZ5vcFHUuPUlRJPyeyQTE2EFzgq5Xjgv644BiRn0nE71Vi6hFaoYIITHlK5mQrZIdgY2vfwK/A==
X-Received: by 2002:a05:6a00:198f:b0:63b:5ef5:d968 with SMTP id d15-20020a056a00198f00b0063b5ef5d968mr16211675pfl.9.1683610785429;
        Mon, 08 May 2023 22:39:45 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78d8a000000b0063b7af71b61sm822394pfr.212.2023.05.08.22.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 22:39:45 -0700 (PDT)
Message-ID: <5c0bb221-b9b1-f96c-6226-e7543d1611e9@acm.org>
Date: Mon, 8 May 2023 22:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a lockdep complaint
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230508233446.2021582-1-bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230508233446.2021582-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_223948_011725_874C3A1F 
X-CRM114-Status: GOOD (  11.74  )
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

On 5/8/23 16:34, Bart Van Assche wrote:
> Although the code that waits for controllers that are being teared down
> in nvmet_rdma_queue_connect() is fine, lockdep complains about that code.
> Lockdep complains because all release_work instances are assigned the
> same static lockdep key. Avoid that lockdep complains by using dynamic
> lockdep keys instead of static lockdep keys.

Please ignore this patch - I will post a new version tomorrow.

Bart.


