Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A517C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 14:02:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D336461019
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 14:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D336461019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=nX0eQX29/HYg6yTKwTfR4ClGHE
	O5xmRq3vzgbXhouPPC7KE91IlfxTHMgYn7sxrBjqdgnvwt9XBdIDC/xhNgwQeMaErSEIMptVSdV5p
	WAn9UhX+RowoJw8XH9T1587DkV3S/5ySDyBPv0s5+rD0w1dsUYkoCROsWYUxbIzEeY1mvjXLU7s9w
	fM5jMmXOIphJOUzzlRFVtuXNw0z5oULfcGrOAIv0myotguutW6xEsSQwyV4fIpcKK0LPX2CnPAdOa
	aBBM9cSh+VLpgkqgxC0OAN5q1l8sxL9SFS4FTspD2ZS+9taW0Y4jZ5Ops/rBPywMiI8SJDwiSjmrs
	pn2YlCdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRxO0-00HODl-3Y; Sun, 19 Sep 2021 14:01:40 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRxNx-00HOD4-0y
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 14:01:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id i23so23904518wrb.2
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 07:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qYp4DLGGuoAcfcZEmdaT3LTenkRPO+mNBokv0MNb0HWFH/rxVUMkvcdigtTl9hiYyP
 P3qygN2NiD9SYb9zmm/DqOpx+zM3YPEvu85p0JIfZL4CmzqwEv+qx7j8RFsHfm4uiK10
 8ja22CgPiXTAaqSb+D6pm3uURxkD65ILeSWNm4nek2TdMSLIGb0zYsFDL7w/VEIEuvYw
 SkBDsOwK4TmPbR5zHgmlQV25rLHSHekWf0Lcmct4lPdleu1dCpwlSkOiuTyYdum+cvc6
 OqaeksIC/28XVFH0/WjPR268LPDwqqXsySMfFlJu3lc7CCiofCb6lwGnPAc2BkdGrn63
 Gwqw==
X-Gm-Message-State: AOAM533WsJQAPznrx4NfrWWojehbc2ts0iaOPFXSfQv0Yc/vrs8CJrjf
 5WDHZunt10CEMEyVzSoHvIk=
X-Google-Smtp-Source: ABdhPJzyVVJ1ZNecpJWVF8P5OfIWPV3PsPPlN90BubQwaPCIqGXjHS25Qm+4OhTXG/PjmVZvDRXy3g==
X-Received: by 2002:adf:fe0b:: with SMTP id n11mr23378134wrr.371.1632060090591; 
 Sun, 19 Sep 2021 07:01:30 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id c14sm7063935wrd.50.2021.09.19.07.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 07:01:30 -0700 (PDT)
Subject: Re: [PATCH V2] fabrics: fix return value of hostnqn_read_file()
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20210916230312.84776-1-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9aad23dc-7000-7e6b-aad1-6e4bead982d2@grimberg.me>
Date: Sun, 19 Sep 2021 17:01:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916230312.84776-1-chaitanyak@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_070137_112524_C52100F8 
X-CRM114-Status: UNSURE (   9.08  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
