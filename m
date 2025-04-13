Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2B4C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrDzEXce9aLZa5Ve7bsa+uUNmFSI5MpOEtvMoNtqIuI=; b=ZHzNEz3Go3E0BTenzRt4jBI2cF
	qLVpOkgBFtAUGaMdT8h/GqLlbD5UIvsUfpHg2qVhP2RMkN/Czc/RyrMmP1urCbB3kuUElVv7KSLC9
	36/NQzt/2LyKwC6qBnJbhOSJ2vx1hlxt5e4m1bMeBU4yNtoe94LcT/qcJgaratDsSJmYYvQah4caV
	Q6R0hID7l9FTb/UVQAgbYJi1M9775/9DAGBFTQ0nM5EYwksciOF2nA2K8jCVMNHQNOfG9RVfVfFFW
	e6WdTu31ByflM9+cJgS1HZgho+64bGMMKQoim14wwzjgd8W+Hflby/JNVJAMNH7p9iLaKaBfnEZke
	TQJRcf4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45pk-00000000FQg-0lUP;
	Sun, 13 Apr 2025 22:29:48 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45ph-00000000FQG-0Kci
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:29:46 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so4632756a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744583383; x=1745188183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrDzEXce9aLZa5Ve7bsa+uUNmFSI5MpOEtvMoNtqIuI=;
        b=MOx1+xsBa3+ED3OsiTY2Eiz09Ws6UzYaGJCe/oZtyvG0uNp+c/Q/mav8VfgJXQhuBR
         gZZ/ToQ5IYLpLqHtsyb37406ClK0kJrW9WgcE77rRY9J27Eu82BeTxqBMrpMqhhRO3BY
         +4jlIa3ZI3S86VngYlhTWVDPPyNBDL4jwcGamb3fD+wKlQyGsiv5JprRpmhSEZ/2btYq
         sdmVotXKN8h24Ej6uN+44M8Na2GKPMH57vA1yQsepokXANneJdf4flzvUa6jJULf9nVQ
         8ON9XvJl7g1K2op9C2zjg8KB6+8lYMFpqokAkNN/JDWPLIUhnb8C1NjtHal+YrGOlfZF
         bHSw==
X-Forwarded-Encrypted: i=1; AJvYcCUGdxCGmCGs6K2zjX0sd8NSLnzVImPFmRcVC5JVxPxbsFdi8wttyN5qR9vmAhVX+aj1P6KnD8yn6qnL@lists.infradead.org
X-Gm-Message-State: AOJu0YyDaYTSa77u0sF14p7HHWL1MLrcsZosQKiLWj5ySeoKOt4ZrNfv
	17K3uCPfX3LMndLu9q0SzEVjXXHwvgzGh3bKB5iVkARUVO4ELpTANxOV3g==
X-Gm-Gg: ASbGnct2ImE4mVxd1KoEPgSTq+FB0Z56Jpg4/Mq1CtYxDdwGzVkQOoQ+aACuQPMI06B
	40se5Uzy1WL9zpLDsoj/g32Fb6HFwSxDJ6iJLLfhR3WLe0PNb57d6LqfEDZC/cPLPzhIzFoiEmN
	OY23mFL5cqZw4/e+QmEdiDuFpGsTTBIyj5n43AwsAIxdgAJ5EV5ll+b33/GLCRvRRMovu1GR7qo
	tdXe/L10TovLedp4blG7EhE5+0G27vr2moLYL7dL9Bb2Pyewc5M8P1YJ2pmcPMqtbl/tdFVerg4
	1sVVoQ5qPBpa0OripzT73CTCHWTKUaUS6jFf+f55u6hLwU5gEioScVizBK9RUA5/89Dn8J+l
X-Google-Smtp-Source: AGHT+IE1YZL+KX0A2PAqYel/da0dxbY7hXi6fX6t/FYz4KEvs+uXqjbsYKxXfurEIRE166/UpqetCg==
X-Received: by 2002:a17:906:f585:b0:ac7:3912:5ea8 with SMTP id a640c23a62f3a-acad371af0amr893942466b.61.1744583383067;
        Sun, 13 Apr 2025 15:29:43 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb424fsm788707666b.120.2025.04.13.15.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:29:42 -0700 (PDT)
Message-ID: <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
Date: Mon, 14 Apr 2025 01:29:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli connect regression
To: Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_152945_422267_C77272AB 
X-CRM114-Status: UNSURE (   4.23  )
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

Was this resolved?

Couldn't follow where the issue was - kernel/userspace?

