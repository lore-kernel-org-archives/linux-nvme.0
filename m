Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D057C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A41B64FF0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A41B64FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ht4f0jGowkqm6h/8p9W8lanBM
	gTKFaUkw21YmuGA4V4USBHFjRmCYiwX3WQ0SIP5WbO9i9E8Ur50cdGkdnIZEXX6CZKoJ5sxOBy6a3
	H7Qlw8EvTRDhAq2EbGH0rXe3zN820Ht85P+sLZfad1ouJcgtRKHmQjq41YIt0ok9Cz96pjww66qdR
	wT3P58/S7dH8TRxmsMnD+4udr9ldbmzM32uKFCQHaFNSOjXRPQT9nYMLOusQZYJCVDYDtp2MFXDjs
	phKPuX5ZG8DeL3vaQIZ43wfUIf0XI6eQwVSvWluVkfqoDKCPf+FyhmDWyahkSd7qgPNwIsJ/7hHbj
	PvO3paKyg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIIUO-00GiJd-7m; Fri, 05 Mar 2021 22:00:04 +0000
Received: from mail-ot1-f53.google.com ([209.85.210.53])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIIUB-00GiGp-75
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 21:59:58 +0000
Received: by mail-ot1-f53.google.com with SMTP id r19so3291867otk.2
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 13:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=lg+sGHuAYpVREtBRmmJJoiQEyVFvC/7kRhgB1U81GbX9zlQQBAcnXUAij6X8sQDQPx
 xTIgKAZFnx8m0OsNFMcmGgZ3opQvet/U36gGFOU6o1nJDsigWlXddaJmdP8sVT/DXlGO
 YUcPcOJVp29FE/saKDsLsx6uzZ2gR/oomT9xNhj5uyRj+kKSAqQzgEZJ7MytOLvPjrKa
 5+jMKU2EpkUkNeAbQFcObgJAfrvDKa1Akw9ZfqwmfJouwOLBTj+ISgU+WE1no2eYaJVJ
 mbE24GfiR9KciBHqRZ0y4GY04FvrHen7T0RCxVBjkdsLKYxfmOPsLhfHqu6D10rvpgno
 yWKg==
X-Gm-Message-State: AOAM5317T0NJmS6BmowlWZiwdA9vVNfwXhtW3TKN0KO/2GxsT39KAxce
 VTJCFbm7oOkPXSuvJjS5mlY=
X-Google-Smtp-Source: ABdhPJxEQLn6eg1J3cb6ClD43FfuBWWTBbtXzQobMBIKGPO6yIM3MqosU51sa+mR13rn7wmEAX3iqQ==
X-Received: by 2002:a05:6830:15cf:: with SMTP id
 j15mr9855024otr.268.1614981590166; 
 Fri, 05 Mar 2021 13:59:50 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id q4sm881438otf.67.2021.03.05.13.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 13:59:49 -0800 (PST)
Subject: Re: [PATCH 3/4] nvme-fc: set NVME_REQ_CANCELLED in
 nvme_fc_terminate_exchange()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e2c72207-4e38-9c56-510e-e4d4342032bc@grimberg.me>
Date: Fri, 5 Mar 2021 13:59:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-4-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_215956_464831_89213018 
X-CRM114-Status: UNSURE (   9.31  )
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
