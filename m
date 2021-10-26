Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD74E60F90
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD74E60F90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=iTra0SW0HwVU4Rw319jnQTnTxF
	sC6NPtQXEFkUShClbbmrgp+sZ2rjGJJGYZP0WpzBVkGcQUmjxUkrHOUQiJT9s6oURhBpZfJCLsSVR
	OGn16ERaJdqlDG3btiFVAL+ySsO8Vlj4VcWmsZGzp39MWevLUKSQTqRTM59Prj6uPy9hFgdaAi6Eb
	qG5fD2XxVehfE5KkKKrEmrNndC8UFBPAF3jAzFdwSRyp5ZP8LMpt4Tvu2Uy8C7fb7MVSpqwzaqUHE
	YU6qOWGsqRNN7BYhYoCrefgivFrPI3I1zUh0eucIP6ywx6wQYyiVC9QUn2S79uN0ySdzT6GLZzvCi
	gVHfYdGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfMRf-001slU-3U; Tue, 26 Oct 2021 13:24:51 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfMRX-001sji-RM
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 13:24:44 +0000
Received: by mail-wr1-f46.google.com with SMTP id d3so15086716wrh.8
 for <linux-nvme@lists.infradead.org>; Tue, 26 Oct 2021 06:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=rfZfwERpaLIYmz3u7iPZi3imyS9sKYDwImUFKYZnP7yYj1fsju6vCua97QQcYmS/n4
 OOrNSwyUl5ZWqG5WBu8QxBcxmDYo148qmBgHoAmyBRFGmy3BTFSvxw88PIPgOkhgWJ2Y
 81izvgdRgjALvOKcdzoNtqGm70mjQ8aAhiCqly8bw59Zici8fwg1uKVel06Dvwy2+7js
 nmkH5rg16tgDVesaLExLD9xDW24PFmXp8kKn9e7HZzKb3hjS13kjOj/t+zR3NkVl/zvN
 s8t4pmFK4ye4K131xsfToUHPVJF3ZkDaMo5sPQhL+iCwD5clHyEZYABVzpQ75+gInj2i
 4FAw==
X-Gm-Message-State: AOAM533xezeUAGpteTJ3BwxYRoud6NxsEtHRF3tlKACG9sv6kIlyOd/Y
 EiB2VFa4yh8e+Tzg3rCLtl2nWKnn6es=
X-Google-Smtp-Source: ABdhPJxR6F/smCWm3FeL48LeJsu6v8vWE509m0XaDCvKpNQyBD8FsYNSEnN7smUYKuEqh4wQntZDlA==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr31985269wra.211.1635254681437; 
 Tue, 26 Oct 2021 06:24:41 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m31sm605842wms.25.2021.10.26.06.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 06:24:41 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
To: Varun Prakash <varun@chelsio.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <61914a20-c08e-2d75-c00d-bb343660ee56@grimberg.me>
Date: Tue, 26 Oct 2021 16:24:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635182214-3958-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_062443_899043_A258AE4C 
X-CRM114-Status: UNSURE (   8.33  )
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

