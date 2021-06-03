Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643E2C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 23:55:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B396115B
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 23:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B396115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aSI/Ts4G74I+fG73szxKIJrcw0oYnzixVbTWHQimesc=; b=qI6bRTdcm4FBGhS/0ejZfUkbek
	UFcA/eUsWUaW5oWhYLQvY049onQRI0z8SZitpA+9Oioiap2EAEkOPFncuCVnA5o7+bU5rX4kswpry
	/F4IAOxDIxP2D2h8r6ZUIkXWhlwtPZmKhe4SptbxR1fcBLLpVWGLdFcOtgsq3O5Owv1BfHzztSq5C
	n7HZLEa3VxbVfIdNTnJyeGG/aZMgwAC/pwN1dtMj/2imgM8Hg2oqceADOaftYUHCxwwSB785U7vnr
	aRPXuZhNMLlXgRMPuZS/Vp7e0iFrflnLBWkXRcv9JU49udfRyeX1WpQkyeUyrfF2EvnHREQGoCrFm
	faQureWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loxB2-00Az6U-3r; Thu, 03 Jun 2021 23:55:04 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loxAz-00AygX-3e
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 23:55:02 +0000
Received: by mail-pg1-x536.google.com with SMTP id n12so6359595pgs.13
 for <linux-nvme@lists.infradead.org>; Thu, 03 Jun 2021 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=PIm8v50hzHnBF1AvSOPUEub/5zhv+cbSGM+UoITLHaA=;
 b=J9y9XYhmJ/Tz0KW4HTDJocihFjXWgTjSP2aWHWTaqEUOMWmnxBAdSZP7nMBEvdgwd4
 g88Rgq1xULaXcTEFAWK/TJwnKw8qzaTyPwr2J8eCYBxUaI7oR68ckZTW2zIlr90unRrD
 66tgfuDAv/pKwYDisP+4qOGfDdIheBSzyFWvW2RkwrNGCDCv6v/n56T3s2+yh+H3g8Zl
 Al6ySFOJ1D+sSDVyaKEovh47Qmrct0lJvsAUqJyrVdFa+AJ3jtYTGcujmD8Fgv0KZWhM
 f3IyWTWr5ZiQ40GS+LsGSvDK66XkOYjJQzH01AMu+maYA2LsI5HS1H0bm3KPC8wEbEyC
 12vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PIm8v50hzHnBF1AvSOPUEub/5zhv+cbSGM+UoITLHaA=;
 b=qjc6jXGspqNQf39joUWuIqkrpdxXHX9kb6Li2qKNJxjymy030FaCToDgavZTARl/CQ
 sXg3ujKFIg6bTJjhjoEzRGuW/R2ypULmKwuNiu1e6BNehZL+jEhAJTChX+Bb6dTJoR86
 qWt2IexQ+OEnyrMP6ifCPMxgXPiw6S+r0yajmsukCn4Tn1xRBe1bWemFP/Q8M77fVvGj
 OfGILj8LUr6qoZQlhZ32h7x3oIHWdMbcf1oXGzhslotE4nU+9mSIQ9Lph5W4RlURA50k
 uhhoZklgavsBR15cc9odkN7kIDN0EuuHdnsNt/+zQNHiy6wWbPOKgGKW7Xi9BrM9rT2O
 kP/g==
X-Gm-Message-State: AOAM530bO6u3WuwFIJ/pLiIP/1HD1+nB9yt3zFiH0A2V+4DbhD8qvVLv
 8eo2hpCLQjYa5VgR+cMpwdgDPED4opw=
X-Google-Smtp-Source: ABdhPJy4a/yEk0WJqHYqvxMKj4RKIX5rJsdKxV6+JkVI6d2GaHPA6Xmk6nxYCBmPduoiQY8uviXqyQ==
X-Received: by 2002:a62:8c0d:0:b029:2e9:e1f4:c433 with SMTP id
 m13-20020a628c0d0000b02902e9e1f4c433mr1790316pfd.24.1622764378587; 
 Thu, 03 Jun 2021 16:52:58 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id d13sm143379pfn.136.2021.06.03.16.52.57
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 16:52:58 -0700 (PDT)
Subject: Re: [PATCH] nvmet/fc: do not check for invalid target port in
 nvmet_fc_handle_fcp_rqst()
To: linux-nvme@lists.infradead.org
References: <20210525125414.68118-1-hare@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <9e76d0b2-fa41-03d0-2230-f7ecc2444485@gmail.com>
Date: Thu, 3 Jun 2021 16:52:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525125414.68118-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_165501_200490_B00C2571 
X-CRM114-Status: GOOD (  12.88  )
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

On 5/25/2021 5:54 AM, Hannes Reinecke wrote:
> When parsing a request in nvmet_fc_handle_fcp_rqst() we should not
> check for invalid target ports; if we do the command is aborted
> from the fcp layer, causing the host to assume a transport error.
> Rather we should still forward this request to the nvmet layer, which
> will then correctly fail the command with an appropriate error status.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Well, correct behavior either way as I to would think it is a transport 
error if the port hasn't been tied to any subsystem yet.  But, I guess 
it's fine to let nvmet_find_get_subsys() see the null port pointer and 
fail Connect with INVALID_PARAM|DNR as well.

so - ok

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
