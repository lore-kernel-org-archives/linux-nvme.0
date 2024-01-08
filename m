Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE816C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=x4XBCGPXrbTJc0sVWgjLiZfibB
	Dma41SMO9skZctw+AVrVfeKxq4/KIQNmWMcQSU3q+pXoHhT/J+XiSxdcsks9+D/M23vjzX0O66arZ
	NbS6Fczjjxc1u8y3iwNILS1XFwQcKjyaOn9G94b8FxEic9u/CSXbb6tQb1Ir4xySXOlWTHrzNDW+o
	tudJJCysVjrI6Gzxq5olGGiIAprvxoAdLQaM62MLOWmf/BwPd2zZ178D6UFWPVZNpun5Hrzx5HCCv
	nzR+A25E4zMuzfrx+w4uxO8NWLd+FLckK58WPtWFKwI4DfB2pk/8L8TkqGdbCagoOyIwGv7xqANZf
	7f/kcHKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtOG-005kJe-2k;
	Mon, 08 Jan 2024 17:26:20 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtOE-005kHs-0u
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 17:26:19 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33751fdc2a5so186583f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jan 2024 09:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734775; x=1705339575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wrFaIE6c7coSQ17HcV34tcb5uTnx8fjc9YSlXVWFVuZ0nhDtSf1zQegUoDVJBxwgJ9
         0NbgxZ+y3HXrRpBbnTHKckvpFcrlw+QViYGFbJ2gdUln5CnKL/eKm/LIZG5rCd1f6lSh
         fH1r9COHCRumkkLq5AlJoBlvXXo5jsUoQMoShvABn/h39qVnXzbqBiucqGRssT/4bWNX
         emkGv7hHFIQpliK2ql1jEmadfU+S50DOv/tF3mcBH8ybZvhr286gpEnjxv6udqTUdSWG
         /J5WxSFO5msmhViIKk3TMtX5l9L5ob5JhOIyL1WQd+aoVsqWN1aoedOZNzOjW9Lp9Rfs
         CyvQ==
X-Gm-Message-State: AOJu0YwKIbOwT2Hjuf+wZh3gERd+40WwpHVgmff4kcd98sJir4FsHsil
	8bRy6Q3ktEswxyW6yRoKh9U=
X-Google-Smtp-Source: AGHT+IGwy0G7rMgVqwPIJw9JkGxfNpXPEULOSQeaIWGztn9ziYfSvrDk5RQnGt7HVQR3N7ZZOUG7CQ==
X-Received: by 2002:a05:6000:1885:b0:337:6803:3b00 with SMTP id a5-20020a056000188500b0033768033b00mr3318024wri.6.1704734774803;
        Mon, 08 Jan 2024 09:26:14 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id q10-20020adffeca000000b003367eae8e18sm179223wrs.57.2024.01.08.09.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:26:14 -0800 (PST)
Message-ID: <7550d168-3879-4596-aeb4-bb5c3a4f9c33@grimberg.me>
Date: Mon, 8 Jan 2024 19:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmet-tcp: Fix the H2C expected PDU len calculation
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20240105081444.172961-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240105081444.172961-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_092618_317802_39CE3B8A 
X-CRM114-Status: UNSURE (   4.85  )
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

