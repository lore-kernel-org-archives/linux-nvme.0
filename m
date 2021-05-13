Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7825C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:59:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79510613CD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79510613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Hj1q8x/NYETYCK2alQgQgdFCTph3LmTL9a0oU09SUE0=; b=pEdG7NlGoJrHtr0Tfoj79q5ny
	MceOl7/LYeJ3dS/xAEo1X99P7K2QYbt4Fyi6oR1E/dauNQbDl0wITawATgdbmszH9Lo0yfF238ksT
	EqAYJHvvAOcDVwPzOeh+717NSBmmJVTAUBq45tmoJubaaJ4qLM6cPJYLm6dkPgRy8wIzUFxeOA5VL
	5eoH7W4ttThQOXInCP/LnHN5eZbvDpeRRVy0HPPSw+iTNv7tZOK2B5Ba1a6vLkzszJyN9J5/9OzgH
	K7EPxwhyX8HbM02Wqkdc3kC2NeiBciUGH6J5KePPu4cCCednVCp6ask0dXwfM7mReItShuIanJ8TM
	V3pjeOc7g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhHUV-006LAc-TH; Thu, 13 May 2021 19:59:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhHUQ-006L95-EI
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 19:59:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6JuaE072ma7gtlH/E3dycnKuy6xr1SU9PAm53OPO8Sg=; b=VQkB1d3MjJUymrsuoJbhMIKVuK
 +SdN6zoTpadVS550C/3uhERZTkRR7EgJhCGvxyc9RLwc7QbhlrojMuhSphvmMSe4gEfTHdx6v5k8b
 B0QtS4sr1qMOu/5fuHSHAKNLGPl5Ndlxs44Ytq6xaCL9r/PEwMQMbfCVgBZxc4sHixzGMMoB+CyRY
 VZKBktcoDB2DBEYjtBKUv+R4P5HZnnb3hS6TLS7ZHEI62vQiLYPT4MxNFHvrItrSK3hGY1lAXu1ce
 /j0aJuy3ci6Fl4f0ZAvCMHUZH3ugy+n1B5eS8yeAogcogAnDTenLXl13IosMGK35suqm5+2eG6LaE
 GCiPRtnw==;
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhHUM-00BUjS-F3
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 19:59:21 +0000
Received: by mail-pg1-f175.google.com with SMTP id s22so22408998pgk.6
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 12:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6JuaE072ma7gtlH/E3dycnKuy6xr1SU9PAm53OPO8Sg=;
 b=VsxoitEYUL9J/tDosz5+SussmA0IXYvdtgJK2ugm5A9TUoCG7a0F6WCZs00V8VaV5x
 LCLt1i7GooE4Mzbf4+AJDJkW8Fu0Ks11D4QP9w3zQBKIlfQsV2V4w1g2qf7iD1Yr/YdP
 q4OenQe8HQF2E2HTLCdr8SQx74Am0Rq6dZ4gKfD0eQPBgXGsb5CprsIA5Flol3scaKUk
 HmSkoXPJvsPUxyHJ2pbecwpvSQl9eHvAPD0i+LjgScyj37zPuQ/uJVN6MZs16CKm4+8a
 Bbdsdnp4qL7wrJeVKy/7aqwz0dMqbBSHJkqGmzeiUvEFcCWhOZ0fZt0SoPdjBU42WXct
 1d8Q==
X-Gm-Message-State: AOAM530sPDtEF6yJHbS2pKulQl1+JsN15YVkMfZW0p98yEnYP6xBuBYg
 J57tDagEfhKVrvu8GR6xFX4=
X-Google-Smtp-Source: ABdhPJxlJGtD+a1LrTrDH7uF+fkDI/O/UtMLWcIdaICpPGRUJalnwUDxzW5LMSAd2Xj+gcfn7xG2gw==
X-Received: by 2002:a63:ff25:: with SMTP id k37mr43193144pgi.360.1620935956750; 
 Thu, 13 May 2021 12:59:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fbea:aad3:995d:b40e?
 ([2601:647:4802:9070:fbea:aad3:995d:b40e])
 by smtp.gmail.com with ESMTPSA id h19sm2824776pgm.40.2021.05.13.12.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 12:59:16 -0700 (PDT)
Subject: Re: [PATCH] nvme-fc: clear q_live at beginning of association teardown
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20210511045635.12494-1-jsmart2021@gmail.com>
 <601fa5a1-e52b-edf1-f32e-b1c454e23758@grimberg.me>
 <f26aad29-aef7-6fd9-979b-a0bfc4f46a06@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <361251b9-60da-d7b8-9352-a09e80a845a4@grimberg.me>
Date: Thu, 13 May 2021 12:59:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f26aad29-aef7-6fd9-979b-a0bfc4f46a06@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_125918_539080_F8676379 
X-CRM114-Status: GOOD (  12.50  )
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


>>> The __nvmf_check_ready() routine used to bounce all filesystem io if
>>> the controller state isn't LIVE. However, a later patch changed the
>>> logic so that it rejection ends up being based on the Q live check.
>>> The fc transport has a slightly different sequence from rdma and tcp
>>> for shutting down queues/marking them non-live. FC marks its queue
>>> non-live after aborting all ios and waiting for their termination,
>>> leaving a rather large window for filesystem io to continue to hit the
>>> transport. Unfortunately this resulted in filesystem io or applications
>>> seeing I/O errors.
>>>
>>> Change the fc transport to mark the queues non-live at the first
>>> sign of teardown for the association (when i/o is initially terminated).
>>
>> Sounds like the correct behavior to me, what is the motivation for doing
>> that only after all I/O was aborted?
>>
>> And,
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> source evolution over time (rdma/tcp changed how they worked) and the 
> need didn't show up earlier based on the earlier checks.

Makes sense...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
