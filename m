Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844CBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:02:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3203164DD4
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3203164DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=m7liXuyNgaKRMIem+gARI2GFN
	qh7lys0CSIoi5g/TjeKgXmWYCd/Zzwb4TMiy1AKRd7N7YA5eux8t6mA3Pqu0ralGvvWmlmxfyQoS0
	Nt1f93pOzW1Zv/PgKdDqGBwckua1dqfi4msmsHLS03HcGZiIXWQzPv+zRsS2VbQkjNHEsyObf5d1A
	lE5KYrr2vrN6T5Rt274inrrcEI+u3LEaQct+71sgK/Fxm0jdKrxjYK3mCM+x9ZlmDhRvV5DY8zA1r
	IblF20NKlP0Z/lsslGCTTjc2BtiSbYOVKWNGglxCXV+ecvNSW5luNDVGg4xGzJaIVcXEEkqZNcZqL
	LV6myJxrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7EzA-0008Gi-QT; Wed, 03 Feb 2021 10:02:08 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Ez8-0008GC-NB
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 10:02:07 +0000
Received: by mail-wr1-f52.google.com with SMTP id c4so20732805wru.9
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 02:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=QCki0tAeZEDalIU1mG38/oGVnneUuEJN6Sfpispz5olkP9Qgh/deRoyWXfVMXceFvA
 3w9/W87QZrevdYGbe23ZpCbrv0AoKG/tELA3SoiDPkZgyKyKmkkMhHuKPvueX0rA9q7P
 iT3jDGgGGj0W5uj+apZ3rqGWrIeRo902WlL6iQ9YZq5tdoCa81dahQ7BMLwJFNvXdsGT
 /YXcXJvPlzmuXKzp+ztEbyigXi12MZyhgEszb4GF/ioMyTCo1oXeUHzwaicTTgRoCdm5
 3ZTLkhLYU9FMy0MOqafwpOKDy+9t+lhHAx5B3DYv/syajgpuDrbBCYpsOwT1DVGE2Ivd
 VBqA==
X-Gm-Message-State: AOAM5322tbqi/qVn0JyXCgdurx4qLjPOlUIx3gVOgjgYtRqI7qI6Y2gO
 bWxLdAlz877Tp6UAG+k+CTI=
X-Google-Smtp-Source: ABdhPJzy9r1w3blcXPLWHRhagtL7Ocpb7GYxYvUSX713YucHGT8ggE6NO8BAbyxHElUba6AOB4xIOg==
X-Received: by 2002:a5d:4ec3:: with SMTP id s3mr2452835wrv.79.1612346525900;
 Wed, 03 Feb 2021 02:02:05 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id i6sm2910515wrv.21.2021.02.03.02.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 02:02:05 -0800 (PST)
Subject: Re: [PATCH] nvme: convert sysfs sprintf/snprintf family to sysfs_emit
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, kbusch@kernel.org
References: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3bc03849-b8ef-3596-5f9d-ff172d74f4e4@grimberg.me>
Date: Wed, 3 Feb 2021 02:02:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_050206_779493_52BFAC95 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
