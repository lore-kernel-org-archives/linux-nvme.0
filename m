Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9054EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8S6KpSx/8UCHrqKd2wB9qrGCuIDtz1tHvkaQqSRUOc=; b=E+7J5p0pO0AylPOEgFMzZbkcLe
	OU9GrQ56m6yKDLleOxcUVyzlZYvQVid7s6hXqy2OhOy7pa6D6yp4mLMiKQmYnhQXyWM1kEvLXPhWe
	46XNt7XjqaXiZnO6bFAYPVmjuJssUFpI3ZFOQGWy7DClGPamrY35xwIQK+fgyjtqiKNSdRaUNP4x6
	XnXysy2z9C8EfnYz9j4XqRYIEK9fwE64VC6s7W3yChdimLdzh+vr9erjEGG9mykL0JB51cQLN/cGk
	c63GqxYQOXgnzYrgMolOL9sZXwyR7wV2vUngWlHaZQ6pYi/rHivoaVPIuOzCeBLgVGL8pmr6+V0IW
	W/80XExA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntw62-00C9cG-QO; Wed, 25 May 2022 18:51:02 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntw5y-00C9at-Qa
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 18:51:01 +0000
Received: by mail-ej1-f46.google.com with SMTP id rs12so31702434ejb.13
        for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 11:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b8S6KpSx/8UCHrqKd2wB9qrGCuIDtz1tHvkaQqSRUOc=;
        b=KoFliYmnLAk0FJhgNatvJRhYIuYB6klw7wTA9uhxw+qCPqN8y7aFqKmN0ggkx3Q1Cp
         +YKM/x6tPfHZwyoiT4tMCFqoX80uxpL4V3zjEOya4YK4+rRtfIxbDcppprdvSnFqsTNh
         F5oTYWkm8dixtxcLh5+8aOmz3TdbyU9f44F6lAXvEtg/HH2leJr88ZhmgSFQKqQvv5w0
         WGONWr74AEvbw5rSG45c7zVn11BzHfEieuu4+1DzXHUs3GwLe+e9PLSHrJVtG94qubmE
         wFZMNEIpdI7bhWc0JuTNHMcnSdDBO+YacMHw6vVzH9WJWLyWU80ae0apGnsmSBQIm894
         i0jQ==
X-Gm-Message-State: AOAM533SXBNpSEI4yQpmx+ePx2sCRZ1V1Hr1Ydrhz8ns1wyz+6yn0/Zk
	H+X+1L9xphBDB4jDFCMLFNE=
X-Google-Smtp-Source: ABdhPJw7cmZQR3z2aQG987BTdUWi824dKt19/XjqgPfnr4e7WbcP46wlyBipPTdRYEUwkVFlY8AuSQ==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr30123374ejc.572.1653504654548;
        Wed, 25 May 2022 11:50:54 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b006ff0fe78cb7sm877215ejc.133.2022.05.25.11.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 11:50:53 -0700 (PDT)
Message-ID: <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
Date: Wed, 25 May 2022 20:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_115058_908522_B7B4ED1E 
X-CRM114-Status: GOOD (  12.72  )
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

On 5/25/22 13:01, Sagi Grimberg wrote:
> iirc this was reported before, based on my analysis lockdep is giving
> a false alarm here. The reason is that the id_priv->handler_mutex cannot
> be the same for both cm_id that is handling the connect and the cm_id
> that is handling the rdma_destroy_id because rdma_destroy_id call
> is always called on a already disconnected cm_id, so this deadlock
> lockdep is complaining about cannot happen.
> 
> I'm not sure how to settle this.

If the above is correct, using lockdep_register_key() for 
id_priv->handler_mutex instead of a static key should make the lockdep 
false positive disappear.

Thanks,

Bart.

