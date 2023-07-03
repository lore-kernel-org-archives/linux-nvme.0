Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1843EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIR8G9dzW/AHDz3A+/3A/KLqgX8fR2nJsyJYwvgO7jI=; b=yggDgv0S0xXeFAdAQO8QUM1iWT
	MPmc9pAA7anRBfpsRaf3p7NiFPVI2n85XbF/uHVU7X/Fo3g+tzki5QcezceBrCanRfZ07pml+rCWH
	0u9pWRNrUMYjmpB7c1x9zRFof04VfLJW3qKp4ejgUpkKJGgv6wDJ729KnWKn1pAiYbmkxdTtr+uPk
	qMrwqF/+JtnOXY2NcRzKYgsokq0GDlS1PLxMvvClwmciOvxbk6gGBYHKLgaMmMjdQHWy8rXOFBNUG
	i6851cZPeqaRcMDSS0GeBhFYEjqX/BDrNdME1nJPYeTGU0QRxLRUcMObt/lAU/jljSuuDdfOL5kVB
	nQGqXw1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGUM-00A3mZ-0q;
	Mon, 03 Jul 2023 10:08:58 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGUJ-00A3lW-1a
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 10:08:56 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb91513b1bso1035662e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 03:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378932; x=1690970932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIR8G9dzW/AHDz3A+/3A/KLqgX8fR2nJsyJYwvgO7jI=;
        b=LbGqDLMxQU/w8wqC2+vvuvGSeMLmIIxQnlkyFt8iPVlnqmGQU+6uhRPbyKWk89Qlzm
         Wg7tDm/V5shRmRaAs9jtlFkm2Mj07kQ0Rqyz+ZaCoajqzmTEbmpTSNpRLMMwTmVhk0oX
         twJoE8AcAJIm422LNdK+cKC3+szrW7JZ66nRhk+E+DZOXw+Ryy6rQWMZxKlkxJ67ZEaM
         CfYzabAqtCdPLlqDmwZF5ykg3I9UGxO9/kiSjl39/K3N3Yrae0qHmtwESGNR3N30p5F8
         FzUFkGL3GNvUgy87WV6Qhus2zuI7eISZY+VPqXD+0dN6L1GDevcBwiu1gPIoxRtPxrFs
         UJtg==
X-Gm-Message-State: ABy/qLaFc925vF6uqO9rK7fnGx60G0eqf1TtYT1s9NuYuQj8sBO+3kIX
	ZqKvzc44oO088cxAD+q9NEs=
X-Google-Smtp-Source: APBJJlHK1xgbTuhYhj3/thCZfGiGdkoW0Qx43BOTsuwy7eDxRkdpEkSLp2kCh/wynItpDfIM9b96bg==
X-Received: by 2002:a19:7601:0:b0:4fb:9477:f713 with SMTP id c1-20020a197601000000b004fb9477f713mr3833933lff.6.1688378932063;
        Mon, 03 Jul 2023 03:08:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c024500b003fbb00599e4sm14651466wmj.2.2023.07.03.03.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:08:51 -0700 (PDT)
Message-ID: <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
Date: Mon, 3 Jul 2023 13:08:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230703090444.38734-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_030855_526784_659D4E49 
X-CRM114-Status: GOOD (  12.29  )
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



On 7/3/23 12:04, Hannes Reinecke wrote:
> Hi all,
> 
> here are some small fixes to get NVMe-over-TLS up and running.
> The first three are just minor modifications to have MSG_EOR handled
> for TLS (and adding a test for it), but the last two implement the
> ->read_sock() callback for tls_sw and that, I guess, could do with
> some reviews.
> It does work with my NVMe-TLS test harness, but what do I know :-)

Hannes, have you tested nvme/tls with the MSG_SPLICE_PAGES series from
david?

