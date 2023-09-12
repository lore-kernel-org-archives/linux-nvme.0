Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA0CCA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=LqjGczggMbVUx496M7SN4J8IlZ
	dhRmMAtFm2shqVRyvp3s+zW6BN/d6it8H+nOHYTlwrmuUou5W971nBdzC4AZozev965XRLhyzgyIC
	oG7HQFMksrskKTiS0sJ8SXibTQj6NphdHgJYmtIoOG6D1yQbHqtjSzwO3OYc2yZYNm2Hj2cJQXMuW
	EEZ9hWSGyXERofREvpzSLsOvdWiRAWIYHpbcYPc8v9czgWGhlowNMel48JrBxIISGQ4JoE0+t4f1s
	U1d7/bi66U2XpqiT5qOi6a12vWswJgGxaaFN80sB19eB0Y9nw5HrfeP2mFtJkNpAY9VY5SlXiD1nm
	aqUdKyYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1rb-003FTv-1Q;
	Tue, 12 Sep 2023 11:47:27 +0000
Received: from mail-lf1-f43.google.com ([209.85.167.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1rY-003FTA-1T
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:47:25 +0000
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50294a827e9so1140019e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519243; x=1695124043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wOnWcWXpaebP/3fpLvpyW/zVyNP8c6JtM4vs91fDOZ9na5HxVs6bCN1Tr4n8K/2LR8
         uAQf0QNRVRVvkVqew61G/XJXbqHgcCHqA5/X9AG+QR1U8lz7w0QIzhMZ+/C4sDpfF4Uv
         guc1RJQ8d/f4q2ipT0jfR0rd/US1LmDYQjQtg5eD0WCSIQimQbreKag/lUootxkskU32
         aZbuZPiLl0fSDSWIbi7E6e0QGYot1NEjw1nZHdR/mqL8p0cBUms8LjpEX/6sEE8K8Aym
         wD2ljOl2xXIpSeZ6wrHufYdCJfCqMBSID7NSzY+nMfb4zCK7KP8hjjVtACxG2A6TmCHP
         TGoQ==
X-Gm-Message-State: AOJu0Ywu8p0sx0TKKKeSwndsBxdYPNBLA37bpG5nsOkI6OxmmGpuBor/
	crHrmhZ3Y3t+ffQCbDlmrhI=
X-Google-Smtp-Source: AGHT+IGkqHI3tppRprE0Hu727lOLphjhSTj2GkypOjek9NjpFkXm4jRYamjYQExCgVQ7dIRIU5CLQA==
X-Received: by 2002:a05:651c:1987:b0:2b9:7034:9bbe with SMTP id bx7-20020a05651c198700b002b970349bbemr11427383ljb.4.1694519242566;
        Tue, 12 Sep 2023 04:47:22 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b009929ab17be0sm6686402ejb.162.2023.09.12.04.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:47:20 -0700 (PDT)
Message-ID: <8cf084f2-6567-3b2a-429c-2b654ecfa4ff@grimberg.me>
Date: Tue, 12 Sep 2023 14:47:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nvme-auth: use chap->s2 to indicate bidirectional
 authentication
Content-Language: en-US
To: mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>, "George, Martin"
 <Martin.George@netapp.com>, "Kumar, Arun" <Arun.C@netapp.com>
References: <20230904152638.28311-1-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230904152638.28311-1-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_044724_489485_31C33B53 
X-CRM114-Status: UNSURE (   7.04  )
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

