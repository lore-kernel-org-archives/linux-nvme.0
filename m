Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6898C0502C
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=o9xbSSV1yJqNUYgjriebzXjj0K
	yMCp7O3BxyJntfQQq5MQcaFtd56cmGcr0zshrbctnzCfuo50nAUvuJDaJkLuW+ZAvdHi3Ngxyg6aF
	BhB7AFn9ckH0DADITv28LFF0B0Qm9I0bVEQBFQC03exLWMxpSaggCDs53hADGD+CuPwVSzzQBspAC
	djn163n0ki6b9bem6Bjgl5rfK5vvdjnc7PST7rPgpgMkM+I00DjBnXUfQxfVLbB9Dj/0l5bzGyA+B
	eemtptIhZcizR4F1Jd2ZuPA0I9syeTdE52G82cxyeuUYhxkmPvrj9kk/nc1/yKaxG1bdtaqKWb/se
	5d4CBGhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvFy-00Ed9b-KS; Tue, 30 Aug 2022 07:01:54 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvFm-00Ed5e-8U
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:01:51 +0000
Received: by mail-wm1-f43.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso632930wmr.3
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 00:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=HRSQwEh02detsyT+I7YcC2RotandcbX9v77jG2UimKoMA575vC6x2MFROSQ/avDRsV
         qtk5dFOCDXTY8V4BfbHs5WjWutrV8V3chcOeOwIRSMWKT+vxXMUxo0TVHwV5tEJg0hz/
         q1ILNGm5zH96sv3S/Xzj6576pA1+8kDDk0mehQYYzXUNe3SPyIBFJaAMKJ4F6hpfnk9u
         nGcCegJDV0b2BNFsB3Aa6DVitBRN/cX3SynIhT78a/W4aY54595hAsjiqYn9J8BzrYDu
         e1CVXScXT100bDfUip9n6A0QPuyL6NWEnJXQy50tP+PRgAn7Z3xWylDBLLMfyKTqcDlD
         ZNAA==
X-Gm-Message-State: ACgBeo0RqBh34A5A1s9Gw0enKn/mqb2L3RJXh56LZqR6kMK2Xav8QOym
	whi+UV2pHy7CxnrNGQwNyms=
X-Google-Smtp-Source: AA6agR4t1kky7Iprsjwm5w/jPga1B2QMbPFQJHLkudIwWpwTeKD4exkBP7HXXQZtuk8ew12CZZ8nxQ==
X-Received: by 2002:a1c:f60f:0:b0:3a0:3e0c:1de1 with SMTP id w15-20020a1cf60f000000b003a03e0c1de1mr8814949wmc.56.1661842897822;
        Tue, 30 Aug 2022 00:01:37 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id f24-20020a1c6a18000000b003a541d893desm10957654wmc.38.2022.08.30.00.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:01:36 -0700 (PDT)
Message-ID: <5c591260-09ca-d8bf-7613-2c7e6efa250d@grimberg.me>
Date: Tue, 30 Aug 2022 10:01:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvmet-tcp: fix unhandled tcp states in
 nvmet_tcp_state_change()
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org
References: <20220829124030.1194759-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220829124030.1194759-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_000149_878111_DC18E943 
X-CRM114-Status: UNSURE (   6.61  )
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

