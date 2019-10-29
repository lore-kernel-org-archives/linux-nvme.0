Return-Path: <SRS0=i+iK=YW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4818CA9EAE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 17:14:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B89204FD
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 17:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rhx+eQvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B89204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Rhx+eQvn8YS5W8yMhd+5qoowm
	zA6CYfZ25gbGVHRBJIm2Z6VZCEdgkBArCuDCG0qG6rei3Bs968SHCSvUHP2VmZGkpfzddKmoa7ay4
	lqdXr0S4id1Psa0cOAnUNHNvqACWtSKG9gI5OMJV+TsC1USso/UCxZyRgG/BaAz89AOdQtwjku4x/
	Aw8Tt6qe7MaqFVvAfKpM2K+RrowV47lRYb+h8HMTec9uuqi9ykKjioqO4PqG6aue/jxvF/TsTKkmL
	m9eBRo247q443iMJyg0H0M7kH+Z5+FTyAjiEUu7aQeVw77AV4qRUETzqUJBEaOEK2Y9XdecJQD+tk
	msULMkYbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPV4N-0006xF-IR; Tue, 29 Oct 2019 17:14:11 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPV4K-0006wV-0N
 for linux-nvme@lists.infradead.org; Tue, 29 Oct 2019 17:14:09 +0000
Received: by mail-wr1-f66.google.com with SMTP id o28so14524139wro.7
 for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2019 10:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UKLiJlONnvZ/q60FPFy6FJsjpaoySfov5BZT62uXl989O+SqDU7fBdELbySmSS4NAz
 3wFwaTXBZDpFekimSsxeZ7EU0nKIVH9ATHbjEYClujM9DXfYlXZMsZBSzOotWhl4Da8B
 lfGXWqM4iVfDXagArfHxhtyrhO0Qm9PmsJx/XuSqkHO59T8bDmdrAjprtvB0lMM/CxiV
 vTetLMHPM90oKPUHMj2jagp5LQMWdmcXOLDxC2+q/iD/RfYG/xcs+OvRbn+weEa7/Sdj
 2R7ffZwMNuKaH+v1VC0JEINuqCYB+7iYU23iaDCOPYVN3Hl+p4kj4F8xmT22rKaSYHU1
 5Ozg==
X-Gm-Message-State: APjAAAWH+52TLBmzF/OK58D14On42T3NQcUvjDXLve+tTSAHtuZIp3ob
 V8Pz8KBsDVhPklU3Z7dxqk4=
X-Google-Smtp-Source: APXvYqwE7VI35Ddqh1hPLABwbMiqYwFjh3mu47PyRGAQUyHfUHRR1ak+wXAj/b2BsV5Xg0V0p2Oa8Q==
X-Received: by 2002:adf:b6a6:: with SMTP id j38mr20322111wre.275.1572369245776; 
 Tue, 29 Oct 2019 10:14:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 189sm3251636wmc.7.2019.10.29.10.14.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Oct 2019 10:14:05 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme-rdma: fix a segmentation fault during module
 unload
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <20191029144227.108450-1-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <badcd22c-54ef-a4ab-2080-55f697b184e8@grimberg.me>
Date: Tue, 29 Oct 2019 10:14:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029144227.108450-1-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_101408_050076_B0B6B4C6 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: shlomin@mellanox.com, israelr@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
