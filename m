Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D4C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UXAM2iYzNumTTUAVkjaaCIl/Zw
	KwPXATIqGZ9c6QxbpEY+0IPbeZ1KJHZTeapGCbBC6OpLoWdw2w2sYYJKsySqlKvnqFZRQKdkOPXIC
	X7XdanHIdk1542ozyuK4nrF0lES8HeP4cEcJflkF8hXKrDTv8PpmUhz7W4D8pSksDT895NDbwN8OI
	CuBCpEFb3bD9yGdOUZkJOoVrkdI+u5bzb1I+9Jxq1sTWlHXyaLLT35zaozoju/D8CCcmmUCaJIuTB
	gWUgTm/FcgW0pTzDgdnSOKXW+c6FQXNFJQj68B6CWzQKhOvMKLQWZGXU+6W88M70+QX0zpyRhnVn9
	eMilfpMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbKX-00AACF-2n; Wed, 09 Nov 2022 03:00:45 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbK9-00A9WE-3k; Wed, 09 Nov 2022 03:00:22 +0000
Received: by mail-pj1-f51.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso661759pjc.2;
        Tue, 08 Nov 2022 19:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fQdmaHa0s7cKyUuRVq5BHlEqLwF8DM6Ix6GNCJ8HO8ouJDB+7NWWCeu0nrgoCpjHzu
         XBWoepAr5jjZlcbCSdvaHFUctzwCPv7B+bvSICMmsC26c4DXQeAEKuoMrxgAclNUJkfN
         Il6BjDjipK4mrqgrj1V+rjWY2fSlkghRLMQxsDhzYFyIwlBWo36aZhNolvDCgwam0F0e
         F/qF0p8khbIeeZizELmZ9A+lnvRiXP47sttet05MTmJlEfEJCGrt8B797tOMerSgdMGq
         Rh8Rai/d24XDXjdf8ROd9WZe//F/YXpdqD3CFE4Pblp1NVuM+kdrIdMSr5z8JGJ1v7C8
         /DCw==
X-Gm-Message-State: ACrzQf3+ED8l/mXMf3pXOJYLAZVAHZU+9TH9fqYeCRHL3w/SoU1Vr+w4
	tYvPoCq5twBxAq0Cc3iChiE=
X-Google-Smtp-Source: AMsMyM4ee/mRlXt+Uwt+fwMqgPDYxoO/bkWtF32UcRS6ftK7eaQ0kAvdAJOBurb5MxTkzqAit8ncrA==
X-Received: by 2002:a17:902:db02:b0:187:4736:f783 with SMTP id m2-20020a170902db0200b001874736f783mr38362682plx.155.1667962817677;
        Tue, 08 Nov 2022 19:00:17 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902e88500b001885dbe31dfsm7671429plg.178.2022.11.08.19.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:00:17 -0800 (PST)
Message-ID: <d4d5317f-8ef9-cec9-9c9e-b05e44232ad5@grimberg.me>
Date: Wed, 9 Nov 2022 05:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 05/12] nvme-pci: move more teardown work to nvme_remove
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_190021_178060_B4C8DAA7 
X-CRM114-Status: UNSURE (   6.54  )
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

