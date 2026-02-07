Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB89EE0AE0
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yx0tfB/K10ahy83jkxJMESvRCa6D0xeY/H3IO7UMAuI=; b=RDJTZkqnciLa+PjAxMXRgxBoYJ
	HWxFMLxHifX/Vh4EpphsJnLlgL/Ldxv9mCRnvuzIiIbZcAz31woB/zC9LmuFe6oaflaK9YmSaZQF+
	jaqPP5aqjWPICy07GsWofFEPbfL53uBvsLimffioSLaTw7RRIEenglaE91ERmMJiBh2HOpFy6sAX2
	eIUS33OwzgLhPt7fgksUq3Rgetohsrpgu/e3qduok2Pf6NmmHLO9e0+l8h3G+HORenpkqjga5CGM6
	XVKwJv4gwwvTy2EF3iVRVyUpimB98RloG5qByoDwsLUofoeYauAq2DnCbEB7cQ28uGEotA9d7JX19
	yN2cfr5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiOr-0000000CU6B-4539;
	Sat, 07 Feb 2026 13:31:01 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiOp-0000000CU5q-2mwa
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:31:00 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso26988855e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770471058; x=1771075858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx0tfB/K10ahy83jkxJMESvRCa6D0xeY/H3IO7UMAuI=;
        b=ZMChkrOEdeX5/TDM4jRC4GSqinNH9nuxQVjZOY/+3UrbZ41MUgWWoauLCUkK92AK+D
         Y+op+XkQuPbLRr2uEKywAtiuRmlLQe6wsnAbegi6eiEqaS66KtGL/VSnxRHQMyNliNG4
         1rLZ9sHhSOwo8vITAHjgangXaUwgaYENs0cE+MvM+yC43x+5LOwnZoy5oANOvcYfi81e
         80o+UyinTNv0hzl1PFs1r7HCRphLJPf2tIi9r8PrOZo36df/ioV20NmRfl6sJ61VnemZ
         sQYUgi+F/ZRsISdQEKnzwaIMfDOr/e2ud2dWgBngkPuJ07b7fnf50enVwKmdJE5QbXul
         kIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnVyxST01vfYu1n7k/9fvHKvI4fNwrMNpu6p6xJMvmSwwCUldIHIN9SRda8VX+SeJjGd7d0JxmuPDd@lists.infradead.org
X-Gm-Message-State: AOJu0YwuDrl5E+d/KKqxxC3ugSbxnFdvYZjWRnuo8bDgEUng+r0VoPL0
	3k/GwKI340fzwTMgpuTgdTJw8o+69uByUDEpgOhxRPKV4zwIK7aSqArB
X-Gm-Gg: AZuq6aK7IHPz4wh53e2wYsS72vidkkFwoTylrIon4DIVxLEbahW4ttTNygRLfBm3SUN
	vCdBa6OysW8Wsl0/mNd3tlfguqCYhVfRpVINz+fBTJQFyMtjT0q24LaEpfbHe72MKtNCfbFo5Mn
	q/MuIxoeKvm7Le+05KQLnLbVS2kTD7EVnpIuQ9/5Z/nx8/CPrwFwmiiNALoFDoLw2EXaAyyM/tJ
	y2D3ToEh47gpvrMkwzvGo3scbDq5wRhvksqqHl6uoBMJtYZWIAwKRYo23Eadf5pwGHGsONi/jLJ
	Iy71u3RtSEahiFaBxclSbIHu8gEd97bwXUQaT9PuqwnSdxU3QT5knnTBIrHurckYqFzUU/+zVjb
	9Q6aAyRJx5/Q6bnE90WPhTy+wBfIr77f0yzipYP59N74j5vOIsDPxAeWy/OONjwkzXx6RArlCmf
	pqwB/L/5FBTRm0lCNKHLI0rK0rho0uvh4UOMhYaC78rnU=
X-Received: by 2002:a05:600c:3509:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4832021604amr73171885e9.22.1770471057916;
        Sat, 07 Feb 2026 05:30:57 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206b8d9asm96697135e9.2.2026.02.07.05.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:30:57 -0800 (PST)
Message-ID: <743dcbad-ec42-4702-8b5f-c98126ed79a1@grimberg.me>
Date: Sat, 7 Feb 2026 15:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/7] nvme: export multipath failover count via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
 dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260205124810.682559-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_053059_747091_AD1E3D8A 
X-CRM114-Status: UNSURE (   9.82  )
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



On 05/02/2026 14:48, Nilay Shroff wrote:
> When an NVMe command completes with a path-specific error, the NVMe
> driver may retry the command on an alternate controller or path if one
> is available. These failover events indicate that I/O was redirected
> away from the original path.
>
> Currently, the number of times requests are failed over to another
> available path is not visible to userspace. Exposing this information
> can be useful for diagnosing path health and stability.
>
> Export the multipath failover count through sysfs to provide visibility
> into path failover behavior. This statistic can be consumed by
> monitoring tools such as nvme-top to help identify paths that
> consistently trigger failovers under load.

Same comment. Other than that, patch looks fine.

