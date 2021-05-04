Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF23C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:01:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C28A611AC
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C28A611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=rhLsLhfDk/4XoYV6R17Jtbo4l
	CxXkgtcW5Lo3cT/rLtF1slh4733fm0f+u3quxXFGdL7sgGRWwIU/Tb3BsHM10mAZ+3XfPcXMNr/GP
	ckEttihnD4umQDS407QO2EoPYLsB0xOJPQiJzecHPgSeEuiR6fQzKeWfdNMd4HtzegcUhvTV/MMAO
	PLWlUS+zeuM/pO/cdevmYFRDOfAlTILI1ByWBpjWtjeIZw//AOPzpSooxY1LBb84P2PgPufVnnaAo
	0VcuMflnb4OS0hHiPVLBlFIn9kWqI05A5bAHq0FBGePrVePxn/IwB0AS06O2mtEMBTMVN4daZD9yv
	7ZDwnG1Qg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le1E9-00GyOU-4C; Tue, 04 May 2021 20:01:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1DW-00GyL8-V5
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 20:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ejarkrwkX1zjOZfbj+0+I7sR1h
 /VxvqrCsUuaD5gyNTO7IbJFh8DrNNf2DvMsjWT9kfVBUdYfGGjgPh7i/GpjCnbqA/LMkgZ/a5j7iH
 akriCVuOVAjMwIDZz4O0vYu7TJUff2dS06Nx6w8Cn4qaGe5LYb89BrcCKsmwtr4XV1mfIqRjEy8aY
 CFReAl9GoRDpQVQzZH042E9BRFXRbRuK2/YEuX41eCXSWvc0aAbQ7hu+dV3WBsPr6YEXhQRNU3uky
 ndBUzRrbrE0HnV4G5QEA85kKBONoPYERDzSkUi08N/1O8A/7ab6uEGD5pBy18uEaEUJghRmK9oEEt
 /tvzD39A==;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1DU-004Eeu-LJ
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 20:00:25 +0000
Received: by mail-pg1-f169.google.com with SMTP id d10so8606190pgf.12
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 13:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=dEqZY0BjwoDq8flBihYHObST7RNhXe2z73og4QLO9rMrC1ZNZD2o92Luh+2l2qqgbI
 8tozs4TD2He7+6UuCHwBUzjdQaQtgavhGsVFIAG2DIOznmseqOLMw91YVziXvJoYr01H
 XUAiIlfXnqAlO/gT5K0aagTBYhKkWIMESfHzaEJl57i6KJip9Q/41J98zqT5RCGLBwbs
 cFTE5sCW3TQ7fSLYKG9cTpnoK66LwhtylZxHHxbL7wx0SX6tCx0Rqj8EEVbIm1FUYfKD
 tzY02NBaew4V1jALtr7BH751zPKD+CBQMRAPPyA29yF3rvAvI9QuEx0gPHYFYXQOOOjt
 +3Aw==
X-Gm-Message-State: AOAM533wgrpMv1E7YriItfMkTgTT/YTS9J7Nq+e3qncZ6XxZDnM409WA
 1Dq6Kq1AdhMxgVcSeFpuFOU=
X-Google-Smtp-Source: ABdhPJzPxjxDwoIgaUvCdZwmIGhuSlYf0S4ILeYS5fWaTtfm9yUzk/PmMLSEV0/PEtKmtQSuKarotQ==
X-Received: by 2002:a17:90a:1954:: with SMTP id
 20mr30256027pjh.192.1620158423611; 
 Tue, 04 May 2021 13:00:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dee:5152:2348:42c1?
 ([2601:647:4802:9070:dee:5152:2348:42c1])
 by smtp.gmail.com with ESMTPSA id b13sm15461491pjl.38.2021.05.04.13.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 13:00:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: check sg_cnt for inline bio for passthru
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
 <20210429184357.9185-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <41bbd194-3870-5194-7d36-748dcb3d0a50@grimberg.me>
Date: Tue, 4 May 2021 13:00:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429184357.9185-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_130024_711667_3F06C392 
X-CRM114-Status: UNSURE (   8.39  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
