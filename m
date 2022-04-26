Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AFBC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=TRijLLWA8/F23Raq5Lmfbqt90M
	/WOgB5QPvROUpN+k168WehDgVCRCkM9MkuSBif3x5K86xZ6ZOk/NA94z9Qymxk0bUjJ0AfQDejdbD
	VdKlEUdUeNSxGVjLY/tSMnrDAkHJlF/C7tBPcSjzIuxxymuPD2sl2wPtRqzded2zczEzwoAXi8WdI
	dZOXrM9f9zO7wTsAPCpjoNQ4N6aLFFJnpf6nJPKDsV1SG9DgOJQXq6bDCE3ZV20XomMw1Lz39bDdn
	XjdqST+TPD3EwzDfO/LVQB3LDHjiHueuJg690++umKuMysdHNlAEZzPDI+T8/1ClQpUlpxWBwomXv
	Emqg+HfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njLuP-00EtjU-D3; Tue, 26 Apr 2022 14:11:17 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njLs6-00Esbf-DY
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 14:08:55 +0000
Received: by mail-wr1-f52.google.com with SMTP id v12so18837351wrv.10
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 07:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ENnD0ncWXRh8Q5/xplNLexOEOoxQ8NRYytH5O4/Kc1djk3CZg/73oHVuxkA85STG/c
 EFTGT31a7nHY82L/Wuii+/vi/LLg5vHmEeW9zulkZ3k7k4khEDXd0BVxcmP1Btoy+MQX
 M5/wBACtkHXl9mPCwL1bNpEKZYK6XFeVjtTIpFSGqtgHXHqiFmV2xWw2yq7MwGkn1HvD
 bn8T4ET7iSsXXIsS99QfntrS07CwCaI5ZVxb6XNf1CT7kk9mpg+m7+ozU+WD7ggpfbkF
 UbDJceqFhOmU5IVIQWNHrVaxEXHxJpBT5vdWMxF5Xfezp+1UiJ7WjzWjnl6bWIsNTBR1
 M7Ag==
X-Gm-Message-State: AOAM530Mtqtu9lfdNuNILHpn/Df/aFV7/AW5HwcptmSomplXu6LsOoCo
 i6Ph8IODamrjqY+BP8NZi1k=
X-Google-Smtp-Source: ABdhPJwmVsOTgKCUw4Lw8IRwgvnNw/UFGSY8egJB8Q7NVTRiDtcaMEOb/uZy2ej1C5SXmbHUJK5gWQ==
X-Received: by 2002:a5d:6c61:0:b0:20a:a261:876a with SMTP id
 r1-20020a5d6c61000000b0020aa261876amr18974468wrz.251.1650982125135; 
 Tue, 26 Apr 2022 07:08:45 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 b6-20020adfd1c6000000b0020aac8a9946sm13689768wrd.47.2022.04.26.07.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 07:08:43 -0700 (PDT)
Message-ID: <40f4e899-8576-d4d8-6c28-db0a2df66e2a@grimberg.me>
Date: Tue, 26 Apr 2022 17:08:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: fix interpretation of dmrsl
Content-Language: en-US
To: Tom Yan <tom.ty89@gmail.com>, linux-nvme@lists.infradead.org
References: <20220413112056.126198-1-tom.ty89@gmail.com>
 <20220414060219.361433-1-tom.ty89@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220414060219.361433-1-tom.ty89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_070854_547951_39DF46D1 
X-CRM114-Status: UNSURE (   6.05  )
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

