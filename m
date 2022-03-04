Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3619FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=; b=4juG8T8mm66MYSoFlE8jSfTxZp
	0Qe50uyLIQABAgAOeYd94n9+VLqMtJTVzDPZ+Gmk8n0XzX6RdLSFVVtQGJn8b4Zc9N0gGP61/yNFZ
	UmWbR59ZwRq2FfC7AKsdIjBvbZd82oPhPc+7Rv8PzMbdi1nuGYuWzRsinTcheOfLiwPRMoSQ66HCu
	sFfFPEHQIbVkfE+02NJSgjRNpyXuiaI0rEy7E53WWBElMJncwkTlG+lYp2l9oOkzcXBVP5dzXitm6
	HQs8mXl5bQ1jOVPuXlFJsBPW7oFLxbvPfIBB6c4Bd5W4eeEZn0rzJdr3WOHARLHur+ijaTbabFjg1
	Tfr9WgUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQDXT-00BjYy-9K; Fri, 04 Mar 2022 19:24:31 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQDXQ-00BjYT-3h
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 19:24:29 +0000
Received: by mail-pj1-x1036.google.com with SMTP id
 mr24-20020a17090b239800b001bf0a375440so6028145pjb.4
 for <linux-nvme@lists.infradead.org>; Fri, 04 Mar 2022 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=;
 b=yzTBVOHnh2/lw1WEi4Ftyjn9MmKcO9GR999iIl8QDIZ8f473bfhyN+JaqsqzCf6i8+
 KfnqV8aXwP3PhTehm3xjxJL0WmXoo80zbuwPhuaD00i9czLxTl8fFoQmI6ceYGlJB3JU
 uuI51gvQCE0Q916NvdJ4VvdTe8ukIxYdkEG2gUrn7dr94mWE+WPc6+k6Xiz64DyxZFyQ
 20ui0jlVJi8XEJpnblrxChpqSRsV9XHvbxv8F7PpND2WsXtGXeL4CJtb4oszPVY8TSaR
 4nJdXt7Q1nL3y0Iy+yZTxfMtychsLFmirQVMdDLaNAuJMadAednHVU0vTGCUWqK2H2BX
 NMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=;
 b=V6PY/vkUJSpMpW/1KYBak2p9ljAaJmOYLatqYNXTryks5LuxBHErt75mE8bxKOP6QT
 yVt13B2MN+1urnLPV6FaXz5XOPDlIlAWDxIRWD+HS1NH6Dq9L6e0sNSWtfeZkgA8KBVD
 pklvROyfhb5aIKYF4D7nIeus2kNuxvWs/pRJGQMLU/oJbtAXGMg13FJavTWocssj7vgE
 uOr3oAlS7sf/S/5tlnlhdrN27r1kI3psWJT/g3PQ/YkTOD99UciHG8loXtFi3rBqaF0J
 JE7ytsUCFvKK6/Sr+Juo9MiLIUU0fBEv0J2kOaQL0s7gmGTP0F5klCZxbIWRGqgxFYlV
 pC6Q==
X-Gm-Message-State: AOAM531DBfjEKx+V+wzh7aw11sK4ntCx8nlG7NFfDeYq4YOgFxiKRFb0
 VcRO3yfQv//2E/ERjPcPCWTM6bnsnNiu3g==
X-Google-Smtp-Source: ABdhPJxaPNpPdHGtkzBqxR/AbybSNjglxB1qWnG9jsxe0tCA2gjxU9n2s98hohxcBA0drNnu+IBOcw==
X-Received: by 2002:a17:90b:3802:b0:1be:f687:7875 with SMTP id
 mq2-20020a17090b380200b001bef6877875mr161792pjb.109.1646421866217; 
 Fri, 04 Mar 2022 11:24:26 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a056a00088900b004e03b051040sm6813168pfj.112.2022.03.04.11.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Mar 2022 11:24:25 -0800 (PST)
Message-ID: <62cc1a9e-6259-d409-1bcb-11c760b0c691@kernel.dk>
Date: Fri, 4 Mar 2022 12:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220304175556.407719-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_112428_249504_EA70E3D1 
X-CRM114-Status: UNSURE (   9.77  )
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

On 3/4/22 10:55 AM, Christoph Hellwig wrote:
> With the NVMe support for this gone, there are no consumers of these hints
> left, so remove them.

Looks good to me, didn't find any missed spots.

-- 
Jens Axboe


