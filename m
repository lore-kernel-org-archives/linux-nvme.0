Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F0FF8867
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GrP3bcnVIZ5USE+Hukhuu7rdCVDTEiHj5erCB+ONoc=; b=cD0UTj7dBWWLk4bYOiTLsoVOk2
	BmQzBFvuryibMZEDYDC1cqe2y9W63sp+A4a4RoIcUjqaF1VXZKYBJPaYgeq35thLMN+0uiWBLcCL8
	1YHrYUwUfX3kAL+lHvixrCtPX57b3emRPjsYiq9fvDFv6/gY2eNi7FpxKSQvbwNwd+uXQJsohZ8qn
	wzxtoxx3dWEGRM3sJWWkf4v5W+qpRQvpnQ4d20kRi7K3YWXI2/8UneNVYucHH/WwE6UOw8Aq+UNqu
	CLaw1UEtdXk/TTDjYAt9xhzx5ZZGVP+mGl0T3qYUzG8w21URRBTQ4ZEr+Q8Y+aMF+Tys/p9YcT+tO
	pXCKMPww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHy6g-00000002zd8-1IzY;
	Wed, 29 Apr 2026 06:09:10 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHy6Z-00000002zcj-3AxZ
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 06:09:04 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3591cc98871so5652878a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2026 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777442942; x=1778047742; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GrP3bcnVIZ5USE+Hukhuu7rdCVDTEiHj5erCB+ONoc=;
        b=OyHulmQ1iycUPHBy8UFe6i595H+ts008IOU4ABWJ0oN81hzPk34Pjm3SU8ZnzXzbID
         9UyKYi3JwZGS+juVyRxGw4BX5PZ8TpNWezdPGyoQ95N1bkCipcwf6x7nTCGYXAGSDfCc
         EDfqwW/fJhOFeqTHpDFMiUILo3e8sbYpDY88GVbp4dhj0x/d0bqjuBYqCZRAhlRjLZt3
         0io7LOL7VK5LtoGQKK2lNMuKyMAxk46rGKl5/aAgRWlEhizkCDXVHfkyKGm2bTmj5Bn8
         W3MYXlee0Ad8xbB7G4N/kXkOqaziBghpBqrVCfU23cJ8mxsJV9d+YGcbMK0l1Q1AIlf1
         uZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777442942; x=1778047742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GrP3bcnVIZ5USE+Hukhuu7rdCVDTEiHj5erCB+ONoc=;
        b=N/p3iLzItDLg5IZdH9ia9U9ZKUv03/O1XMzkbN2vIReJ7zjx7yKmyUxZecRAJcKdfb
         qxgwvTBRkrZ6iaEReaY67NLwzb5ffnMp2bGnG4Sh768RF04HEdfbV+WkxYURV5oOSIZR
         Y3kv/3f/iC3D0YZLd7J5kx7V0QpnYmKXfT7w51W9K6FN63jhyDf1znnis7fqOGy8AKcJ
         pHURWqHonJ+ACoPgSZ71tRIYJ1PG2KTBUGP0ZUqwZKlcBaG0yyRfAdY4B+8az9AyJmys
         PDQIfya4461ONzY27j5h6Lwl5JZ2jEwsmIw63krRf7yZRk60yNI8KgpEZpiNEgXuA8o4
         07GA==
X-Forwarded-Encrypted: i=1; AFNElJ/qbToWA+21eJgpL2dWECN5whA1axZKCe9Ca3lNQn88h1tyqtPG2ohrKobD5fqWG3fyGiQpcN3brcdu@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7iqRlxofs3FsE2QkQ7U0D6awmeYNMIibgCMGn0CiNPve6NNn/
	SIBxzV1DZGInNFYFxpLU/chKq0f2F8H4yVLGBImDIBUHB1dwckuBNgSr
X-Gm-Gg: AeBDieuHD0Ea8y2Tugx6MtNU0mXyoO2rtzAsBdqNQaQCSOBUyWsJ4MbSaN6rLKmvilS
	njde6CEOdMA7yb18U0FCJklz1Nq64bcbZTaLD9/nEm5rqHiSgKOnb1t8FMT2uK1pBf9/anVuq3/
	GESe0o62MCPhNZZIyxbvGKlTZ/d6WoIkiLvC20n3cMnem5b5JxJ21tBN66LzzGc6JFa4heQkcF/
	Igap5lVu7zmu8ThZr9VlXV3bq4DZvnn+1p4PEdk4ed/zh/QuMzKnQVvkOKVJm+zTNR54fhohf/c
	oPrOuoJlXNuxo8X0SlLWn0Ml6pN5/F2lBAeZbQZt2uMpZ+Gw43w6LDBlcq4PteI6eONPSIaghOl
	qQjAQzDZkZfYKbO333d4D/n6iZ9XIdFSng2tyLQgmgwngqDiVcTgpLV/UjD3r7YYTAn/Uid3NWj
	s8S9vcrVm0JZSs3I+LuJEFQASiFIIuv042W5w+gbJCLlc/n0JDDlspZIKUfVPJ3qyHsuSviL11k
	JeL
X-Received: by 2002:a17:90b:1b4d:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-36491fa7624mr6476391a91.2.1777442942049;
        Tue, 28 Apr 2026 23:09:02 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:6e39:de07:63f3:18c? ([240b:10:2720:5500:6e39:de07:63f3:18c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd651467csm815654a12.29.2026.04.28.23.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 23:09:01 -0700 (PDT)
Message-ID: <56500e42-51c6-4be9-aff1-f11b45c47b13@gmail.com>
Date: Wed, 29 Apr 2026 15:08:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
References: <20260425130426.10061-1-ikegami.t@gmail.com>
 <20260425130426.10061-3-ikegami.t@gmail.com>
 <afBY-0abdJwOfwxs@kbusch-mbp.client.m3-hotspots.de>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <afBY-0abdJwOfwxs@kbusch-mbp.client.m3-hotspots.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_230903_833621_F8A01425 
X-CRM114-Status: GOOD (  13.62  )
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

On 2026/04/28 15:51, Keith Busch wrote:
> I suppose that's why the "known_effects" exists, but it'd be
> dissappointing if we really need this. The other opcodes in there
> existed before the Command Effects Log was created, so understandable
> that controllers may not implement it. But NS management/attach were
> introduced after the log, and there is also the AEN that the driver
> could rescan on receipt, so it's doubly bad if a controller
> implementation really needs this.

Just rechecked the specification again then the log page identifier: 
commands supported and effects mentioned is optional for NVM express 
revision 1.4 and earlier then for the older controller the changes not 
bad I think.
By the way about the scan_work executions for the command effects log 
and AEN I thought it is better to be handled only once but I do not have 
an actual idea for the exclusive control.
Thank you.


