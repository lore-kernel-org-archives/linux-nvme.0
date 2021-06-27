Return-Path: <SRS0=1ZDZ=LV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282EC48BC2
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Jun 2021 13:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B181B61A2D
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Jun 2021 13:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B181B61A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n3T7WtxMCgJom91iMVJQGfpafAt8dbH/E0F4X59Pjyg=; b=JHSM+9o9ivuyxwPMQARorrs4MV
	cthTi+BpNSWsf6OP42qYvAstAzku9m9vIrhGhok4/eWeKVpvQELNA4g9xC5rlRo7zaO8G997YK2nF
	sg7AYxV+UCYsLhy1dzqYXlYajF8o3pVc8mbeNgiT/mXt7I5cbu6VB69B0NIwe9JRDiy4MtwWgpqsG
	VYs30j6u4V3W2H+zARh+JRja0SwIJHbBqv0gLhFFCqy5ekXgCJMEUzShi3ucuoWIYl67FH2ZbnDNB
	FjAUfP89R66lBEoOVAwv8Yrp7OTagH5ooWTAFkG47ZUxPDV01mx2vjeDvlvZV2U6QejpEVLYTA8p7
	A3BN/OxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxV8G-005dJt-DM; Sun, 27 Jun 2021 13:47:32 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxV8D-005dJF-VX
 for linux-nvme@lists.infradead.org; Sun, 27 Jun 2021 13:47:31 +0000
Received: by mail-pj1-x1032.google.com with SMTP id g4so8372532pjk.0
 for <linux-nvme@lists.infradead.org>; Sun, 27 Jun 2021 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fJSoA46EGJPMh4KCGh0AvMNTym/VRIZfvgO78Nh3WHY=;
 b=XFUj04S1IvtMBMrNxSHUrQdfjMsTK6ceV/VmG9GdcBQK5aWjQ5+rf3Bk8ABUqyq23x
 /cPSijpfIZl2ccuqgsz+Ik5g/4Q2qB2I6k60ILhUViJmUOZoJs3lCPwNxugWrCLe9ufg
 +G9rfB+d84i69spQRtCf+7paphH+5I4seXk9WyYmjaPyllIDKEFKBemcokIRTCMr+cbn
 4tUaBMm65rRMBNxmAHiqs2p4YM++/Td1PM1Tb92KktIpC+6kIIfMBCYu3hSofxuL9++o
 DVxmsHWThe9fA6Y3rQTzepjOwb2HoMXdimzpgiLR9VZrcWLjllVbNL0RsnQlXcEiQAF/
 vLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fJSoA46EGJPMh4KCGh0AvMNTym/VRIZfvgO78Nh3WHY=;
 b=t/JSg2MCb7OLrlYRjFmwiWocjs6kRf1o7bVcY8/N/WekG5wCNTBLMQYaewzJQR2Fwh
 bYSUg6Di/syFXwBcC3caZmBe3D6JUflqToYugCYrMd7in/U3GC+K+QmYWjV75N6AYRDJ
 2+OYbvPOSy+LsD3UbNFB1YpbM3/hw0FjmBTjREW3VCYd4iIfc2CKYC5E7o84B5cU9Lpa
 ty6Z1pnE0ohJ1I4VpOKDnyIMKoGFk3pnxLKX+MNT/Y6niFtVRl8sQpYuX3dZmsFmkcoK
 q9kyLiCJCW/uzH4+oA/m5D06COYM+G5ea7joxyS20dUud0OXR4rAntTf6msYHEAiZ5EK
 dx3w==
X-Gm-Message-State: AOAM533nFaWGUr2WWkbPAJHvnNHlE8mNffqz/Cdxr+l2IrFzX+bo9zMc
 n7ZnxxpWyWXjPH9JWJJGoNo=
X-Google-Smtp-Source: ABdhPJy7Va7MAOwfFxr4qQ1sx90Yqi7htESGJULb092qSsZzQo6foZOwzrp2UiAU39FKgAsVYAr2fQ==
X-Received: by 2002:a17:90b:1d06:: with SMTP id
 on6mr21356378pjb.149.1624801644619; 
 Sun, 27 Jun 2021 06:47:24 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id s20sm7628116pji.19.2021.06.27.06.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jun 2021 06:47:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-fc: Update hardware queues before using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-2-dwagner@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <f5c53785-077e-0e2a-ae3d-178b3e73b80b@gmail.com>
Date: Sun, 27 Jun 2021 06:47:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-2-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_064730_099260_3221159E 
X-CRM114-Status: GOOD (  16.83  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/25/2021 3:16 AM, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8a3c4814d21b..a9645cd89eca 100644

Makes sense.  Thanks.   Although it does bring up that perhaps, if the 
hw queue count changes, thus it no longer matches what was set on the 
target, the new value should be set on the target to release resources 
on the target.

Note: the same behavior exists in the other transports as we all started 
from the same lineage. So those should be updated as well.  Granted 
you'll need to break out the queue count set and checking which was done 
on fc but not on the other transports.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
