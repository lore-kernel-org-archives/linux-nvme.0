Return-Path: <SRS0=vsJd=PF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA89C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 09:26:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E575E60F70
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 09:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E575E60F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=y2vJn0VQpGA/YlHBg/w5SDOeiB
	Onlu6/vhe7iFahquygImdUSGjDATJjVLU7LxvoouVVTGmN9iDmzVFeqNozw5nyw8te6oodMixEJAA
	mrZJhyu8OdsGu40ZppG8gpukxxzBDPsBBOmdtvxvWDcYHyEAWsONM71WaCf16TUR6LDKU5s+GbOaf
	G8PxOWdDmrDr6pRGdeOHy28SbjIKTRZLZ6Pq0sWKNwbHczSRfJn1MyylkHPCsv7ENTUnIX/HVo/LA
	elb1b59q/U5b0+3IY0StB0HfQNHxOXcZ+pAvnrVHvggqvu5X4KtBrn2dJeJ6qFWCUreZbSoKX9D6S
	O+jC/xew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mc2Qf-00C0R0-K5; Sun, 17 Oct 2021 09:26:05 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc2Qc-00C0Qc-SO
 for linux-nvme@lists.infradead.org; Sun, 17 Oct 2021 09:26:04 +0000
Received: by mail-ed1-f52.google.com with SMTP id 5so27483351edw.7
 for <linux-nvme@lists.infradead.org>; Sun, 17 Oct 2021 02:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=C5DXTpT9bj4T6jIYMLQNLmwDWFstQU+6AKwQlrkXr9IATHXpvRbQJ4z+l67ZJjno4P
 zdf0JcYXAOubXikQ1J3Mu6SHXICQvgxUf21pYIIFa6txlAPvsU3v8clz5Ku8EgA9UqAZ
 TzyZ0a1vozvX6O+pwPwA2XpC5VljuVj+63PPtvWLJWaT0TG1zrVkVmktClbV47RWnEom
 kK4YJC3AuKxDzDAFyfjEFonbUOnNJo0n6q7AG17T0VtgHvVrlBh2auLl+Q5PAbtR4d/S
 qNo2qqNjISpcM1O6Z3kL6v1C/bHQ1vOK7ot2dGtFaV8G2J1oItx1VmVJBgGTQa3/qO0x
 nMoQ==
X-Gm-Message-State: AOAM533P1Oo9GqT2nHAeInfAEslmDGSPC9J9S9zn0rQOqBx/cY9Xu4Uu
 bxPYvK85lS5/DaMD4VbPs+w=
X-Google-Smtp-Source: ABdhPJwL0GTVsFDf93Qcl9hdVUTmtjfKvvAeZ0X0U7cJYJJJch8db+yGlCxTLX7LUOaO0IKeVsYizA==
X-Received: by 2002:a50:bf08:: with SMTP id f8mr32769580edk.400.1634462760027; 
 Sun, 17 Oct 2021 02:26:00 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id h10sm7926884edf.85.2021.10.17.02.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Oct 2021 02:25:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme-rdma: fix error code in nvme_rdma_setup_ctrl
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com
References: <20211017085816.4940-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <39c13ff1-ff94-d51d-aa2b-d0adcec1d491@grimberg.me>
Date: Sun, 17 Oct 2021 12:25:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211017085816.4940-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_022602_974636_5EE957BD 
X-CRM114-Status: UNSURE (   8.23  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

