Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B371C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JlG/knGHbHphBQWquJvL3y0FLE
	irbvj46/FBhCKuyKUfuDJVXxFcAQUIH2td/tO0ycnqxxC7roby4mnCeOrvVXciwaW7YhRPoqMEgvB
	WYrZBgV9lbn2JZngI3Q6lTIgLk4lF8VSb8z0uz0JmG6AQyLvAM6ygUCnBoJWvJ3hKiqam1wfL+K4q
	eg562yNMIvBUVLglLdpgwTh3UTAlPipjrP8d3psGMAqiH7Xj4/eHUy6oX/pltwoDKoTheUPqJasMN
	C0Nf7BlkYwvWKB1CMUv1NxUzpzVAVSs1HMqSxJxQsiWIz5sJFECxqhA69mvZsvCXDNRISeT61n6o+
	gL9IlS7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeWh-00Cmi5-Fs; Thu, 21 Jul 2022 22:20:11 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeWe-00Cmfr-St
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:20:10 +0000
Received: by mail-wr1-f48.google.com with SMTP id u5so4191382wrm.4
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=L9pS+4J5c43dKD4+5IWlRdIZJXucXwFntVn17/bgr7f4e4U7HuMftGNprHnyAeKGqM
         cNP7ZJZIb67j0Jlp9MC9FIU54CKx5YdiN9wCN2XlLiyC+4BC9ERAjXBqk67NGU0/N6gP
         uY7dqwMHTMY1EMWuBTaGAq4EUdi29eeOuURnbwUibs+ylziYRKNUGe9ctzajJYpV7fBf
         HG2E2x8ObHRiuUbYlj3R+8JIPGe300Qe5NYQCGUcg9Zrakobu/oXYeRb+LDDnL/UtmUC
         5VJf92e19OZjScsvW1+IBxQgjRoZbrwSfREPUFdHkIjLVfvxnz/3u9noRCY0COFenEtp
         fDbw==
X-Gm-Message-State: AJIora9sioh1YIde3XqBOJVIsGupWIHcFMC8Mv40okn3aCR9rC25lSS/
	ksSIPFEMtE2eLpWDiJokHX0=
X-Google-Smtp-Source: AGRyM1vKnp+RJXz0RgneKwC1KKaxzxxjgqonT7JZ85a1eCQcNJLwGnFZgT9qJWjCURL0xB2xYYCoyw==
X-Received: by 2002:a5d:5444:0:b0:21d:6497:3210 with SMTP id w4-20020a5d5444000000b0021d64973210mr320116wrv.587.1658442007693;
        Thu, 21 Jul 2022 15:20:07 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c28c800b003a02f957245sm6826512wmd.26.2022.07.21.15.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:20:07 -0700 (PDT)
Message-ID: <e3b46e62-7b4b-dfff-049e-cca8cc68d2eb@grimberg.me>
Date: Fri, 22 Jul 2022 01:20:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: don't check for NULL pointer before kfree in
 nvmet_host_release
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kernel test robot <lkp@intel.com>
References: <20220718050141.226774-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220718050141.226774-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_152008_989471_75743C5C 
X-CRM114-Status: UNSURE (   6.09  )
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

