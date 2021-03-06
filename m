Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16EC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 19:17:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A68650BC
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 19:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A68650BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PyWhZqJWbY0XSck0UvaYXjHNJs8Y1TpwGJdaDvbxeCg=; b=ffQ0MNLkV1pkdQCG8uIgUOF7U
	9z0O275QenqJxzodTE/NMJCqeuaJY3eA95tNtOM7pwec4IBb94ERBV/hBaQ2UJ2eOyMZQY3roS+74
	Ilk6sghvqYwYwHIkaM4+RQOkavbQW3z4qABy+gqVxXKoQufFQo0vENxS5j4g//2JYlt9nb9h8Mh69
	Bh12ZXRYVZ4j8tYaITgy+a2oDVCPABaqjOSvUSKRddkEtaN3+bVBuFpcGulVSde3visqJBFzSDXYN
	OjQoaSN3EwrxM0c6RK0tSGmPoV8Rzv/nIxTwUyl6/kit5mpFMz8NCOkNhO0Pjo2/POcaJ9rDnrzac
	TQH2sn3iw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIcQ7-004MZY-2a; Sat, 06 Mar 2021 19:16:59 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIcPu-004MY1-P6
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 19:16:49 +0000
Received: by mail-pg1-x535.google.com with SMTP id o38so3665080pgm.9
 for <linux-nvme@lists.infradead.org>; Sat, 06 Mar 2021 11:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LRDmzcJE6UpeNrV+D3gNm0pNZ4Z/UAamSeQSjO+WkoM=;
 b=fDc5u4YJhnme9/+e4SgH/lWrCJa2f7QGxsQeZCYO1ORCoobtWcHYSSEyfOpVKZP6lW
 WUwWrc3nEbL6hUUHZ+E5PX6R1AL8Mq5dFgoevauIJRlGrPYb7osVqww67Ztp0QNUEWOM
 MTVlSIUbB6z8yiAUhmUiLfDvJ4dIWiiVOHIlzhAIYSZ6HTwgsILtXtgw//smwcNlyYDo
 7iB7aGYQOPH7FEEVgQ/APzT9lVilGaukxL56pKBBlEA2V5ZI+sPBaAq5qFHP4sNO3bj+
 5eGvluoWQGQ6zhGD+rvL0iodotwtSSPv0P4+3CqYz+Psd04WWyl2ubBU/JbkTCHS4mZU
 cE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LRDmzcJE6UpeNrV+D3gNm0pNZ4Z/UAamSeQSjO+WkoM=;
 b=JObfTOTLnew/XYqGX71h1FJZ9nbVpw74tgHb2DX2nkZMLYU7SOzdlEGpMJvPlnVzEh
 e66PVf+Qtk/pXXDwWL9leHkRqRLt32jR7i4uaYf2skzyWIvgldxP9o3hIYN0XFpZ+Edj
 GSMnFA1edSbVyA8ClksgSUwPIRkhupYjr0gAdoHUBAn7jffnxkM5uGmFYtU2/aFZ8v5y
 akqvJqo4vAFCr1P5+bYAWLxz/KvczEWlW1OQbzyn/T9uHonK7NsrphoIP1AXrU2XeGdx
 QD2DFshaSoqZ9BXzoW4aTWUI9jamE5rfRc+Isopi/HAZlaq4vOYz7nd6xZMlHMvNjhZH
 LDLQ==
X-Gm-Message-State: AOAM530L7HmhPLjKC5ugWt/+2BR/n0DA3/rQqWqW20RcrpNi1ZIoZYO8
 mmL9ft/iGD7AqiUXfel9fIw=
X-Google-Smtp-Source: ABdhPJw3Xbq2LWz3C4oVnYwP2XSP6v+o7GehVtHiorN68xEtJsAwq4VMYVcz4fRKLv18I5I65TC/cA==
X-Received: by 2002:a05:6a00:1a0c:b029:1ee:6e00:eb42 with SMTP id
 g12-20020a056a001a0cb02901ee6e00eb42mr14819320pfv.31.1615058204074; 
 Sat, 06 Mar 2021 11:16:44 -0800 (PST)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id x67sm6382743pfx.144.2021.03.06.11.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Mar 2021 11:16:43 -0800 (PST)
Subject: Re: [PATCH 3/4] nvme-fc: set NVME_REQ_CANCELLED in
 nvme_fc_terminate_exchange()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-4-hare@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <ce3a065f-d791-5c37-2c6b-a0296dec6ef5@gmail.com>
Date: Sat, 6 Mar 2021 11:16:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-4-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_191647_532254_79E91877 
X-CRM114-Status: UNSURE (   9.65  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/25/2021 11:17 PM, Hannes Reinecke wrote:
> nvme_fc_terminate_exchange() is being called when exchanges are
> being deleted, and as such we should be setting the NVME_REQ_CANCELLED
> flag to have identical behaviour on all transports.
> 
> Cc: James Smart <james.smart@broadcom.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---

Reviewed-by: James Smart <jsmart2021@gmail.com>

Looks good.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
