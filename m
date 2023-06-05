Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A08EC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pi3sx9J+pkIqdqo8R9M+MUSHIX
	1xDxO0alLqUMFv67xPPJSDDFH0Js+/8Auz9KDvm+9yvteYCn+F0+PByKgjS+ZxsMOSfHSi6BGvwnL
	sQUYFgVuP5IlDLlXlew9nkm4J76DwmDsI7WJ/njVDbF/Q4Tqu/4IXCg0Rf572qS7F4O1SAYgOwl1Q
	KTisfmF9EYxFq4tyPDBXafDjkDqttKvSgjyLjRPX0IqocqF2hfdcn1y8+ayOkhNXD22BkBUJIpB39
	MlwRkcvmvjrjmLx46AxtqatKwiNHgvty7xQxWGfLV0wqUiQYGzcJwCuRDEsi1u72Dec3uGp4gfFf8
	dyrBgJmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6I7a-00GvDz-2r;
	Mon, 05 Jun 2023 21:52:14 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6I7Y-00GvDG-0W
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 21:52:13 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f61307827cso641620e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 14:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001930; x=1688593930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=GUmpl9Mp68Vx/NH9+nhtRQj8bV4iLTkp+I45/3YRtPhUC2M+s8nYJQpI+fnXcgumRz
         DNgJooBFkDuHEhuZgOPwqpvgUQPuavk4QkbvsoXlxBt21QRJx48LZlMVYCbSnXRQWC2a
         CyrnX7s73JTndGAO5AXTEH8dJm/taNQTJTPfTZwgvBV1xkcRd7xK1XigejrhurF5CNRc
         FSZWfUHWtZlFweMZUT3GXJtbipHbJPRRh/RFcxZUHWEqtrflFoNFgQiZjIl4j7piybk0
         YBfktrovT+p7fnc86LVYL7FuXOd85NVZmgXQliFBUl5vXuBC1OiZQwylWpIbCwVBCPwT
         NOmg==
X-Gm-Message-State: AC+VfDy/qySNN9W2/lKxJRPAU6SfiepZiCGn7w3bidrEIv7Lilo5s0hr
	9XtjUJZbCkbX2QEHcSjvMUg=
X-Google-Smtp-Source: ACHHUZ51K+jOx4t7UhxQUZMAPYySVWHi1vbdrGjYFLQTDH7o0ZHruCyF10fY0Y5lVPgV2qNQCnhQ4g==
X-Received: by 2002:ac2:5470:0:b0:4ef:ed0f:c604 with SMTP id e16-20020ac25470000000b004efed0fc604mr130701lfn.2.1686001930299;
        Mon, 05 Jun 2023 14:52:10 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id q18-20020ac246f2000000b004eff6c7bc08sm1243858lfo.75.2023.06.05.14.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:52:09 -0700 (PDT)
Message-ID: <0452e4e1-60c0-d7fa-ad9b-da6cca5158c5@grimberg.me>
Date: Tue, 6 Jun 2023 00:52:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230602064742.56298-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230602064742.56298-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_145212_196371_759F7E7B 
X-CRM114-Status: UNSURE (   6.43  )
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

