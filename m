Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2E2EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2b4XwpmRWEfXyPSwxAS8aRl5Jb
	1joTbR55kMjRfbWjela3eHHm9pWJ/s4PnewFgDtZtuEwBeLT0kLS/jwCqLKfRFviU2m21sh2509il
	cNv2npPyovNpQY6KRnj2mDIkb5Bo7xtROx/kaqyZ7e1/tUiRNrIeLVDKi3sbQ58njCSEWcM/BDzTp
	yQJIcmIYuDfgVOd1ZtBvev58NQcxq3AczFREncPv8wF2Gim3yJkPAG2K7fcOqqnwLX+ctjpBWOYtC
	vhKaK/MTTuGHBFdGSh14c7xGWgmSePsnUy4WzeVOABONVzjZTbiASTCdZYAFXl7cUN4Afd3+Yr6TF
	iGvCW4ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgQK-004XKS-2l;
	Wed, 09 Aug 2023 10:28:16 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgQI-004XJc-0n
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:28:15 +0000
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5216095a698so1836312a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 03:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576891; x=1692181691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=f/PVDlKtQtcPiRHbckFhWqNI7BF4JfU0zIEF7FBuPlSNXRv+CNoaV8pVnTaqRq0cKK
         3SfoZCEbvuDTb3rAT9JJR7iMEkqYOVjOnLarbPLCZ5ey2SwtGTv5n6Rf36+dLOai03wE
         y18HRcSOUKVgAGzOwooIHz4yvrkxTSM7UyBAUBzd1krCePapW4JRAZWRR5cRbm9GN5Kq
         K44Ggw1WTBCVZhyK71ZtZE/u7fUpyClYgKjQ5ThAZEQSyiOvDubBA9on4iHD8d+okoSd
         xLaeGoAMKQxSh9E/MIAMcWd3BiQnVVYwAf0TLEpioaAI3LO0c7rdaYRzSnywLoEhF/nb
         +cLA==
X-Gm-Message-State: AOJu0Yzw7HnACpdsx52OdxNd2Kubp1GM6fGZNahVtvPzVhTNanV8n+8m
	nEmP7HWXo1HqB7VR4fJES4U=
X-Google-Smtp-Source: AGHT+IEgK9lai13rdqb6UG0i1RLZd3SCaaB4IBXQh5wPbow8NXo0Gd12/aPPESDfKyyR/IzW7zfdeg==
X-Received: by 2002:a05:6402:34c9:b0:523:2e64:122b with SMTP id w9-20020a05640234c900b005232e64122bmr1901113edc.3.1691576891506;
        Wed, 09 Aug 2023 03:28:11 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d6d8000000b0052341df84d0sm2368048edr.33.2023.08.09.03.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:28:10 -0700 (PDT)
Message-ID: <51605f1c-dc1c-7d3d-3fcf-3dd7bb1068b4@grimberg.me>
Date: Wed, 9 Aug 2023 13:28:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/16] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-14-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808165354.123499-14-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_032814_279735_572EC798 
X-CRM114-Status: UNSURE (   6.94  )
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

