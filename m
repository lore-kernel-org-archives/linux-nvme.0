Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1AC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:37:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4756A6509B
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4756A6509B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=TsCgGSXQd5xRWNiCRfMCGbfbE
	gLPA/X0TdnsXToPiHoBzEp0QFYd2omd9hxrGw4BCYt9jlmVi4WXaHTMx0bmwfduUQ5ao2Cjc/qD03
	52lCdg5O4oYScYQpPckL9So/Mmjum2Fiuzx+YeRx+tkTw1ykAgheiDzWlskYsf8LN0XS8uLlhxD4w
	sJX8FZuQvzucnVeG5SQXhCcrLr2N3TFuFJeLrc8bsPA6NtT/2wPOl0+rMEMZjDb21c0VUAZ0e9Gbd
	6Y/0V3gzJmVZUPD+HEQjw9jAT1xh5ZFKAM3V8LGrDTKfFVk3yga8gz+/mrVbp08QAgRAlQrTysovj
	OF9Jdrrxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ4e-00Gs2Q-SQ; Fri, 05 Mar 2021 22:37:32 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ4Y-00Gs01-OZ
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:37:28 +0000
Received: by mail-ot1-f43.google.com with SMTP id a17so3366980oto.5
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=QN3OyQiMjYcsIbeOG0bNP1EUVrh+RBgPOp1OJ1ElLgA8YzTQfFWQEqsUVzOZzkArA5
 gNsfl9bXSUZuMeuEU1rp3E+6RVXEKwa0gK7KFsLKTmoQQD+CoK2HQ3a7OZPL31d3omsg
 2JUXuC8lAV/3Pq5ELjtAxwqZRlOE2l8KON2FUZXjnXEhfF/T/8oNouQBdkbC3VOKmFLD
 zCJSf+YTb8nC1/PdcOab9g2/CIM3dQ+27iIa8RsRR1ldVEBHNnYCwOCa3BQKP+7G6qhQ
 F8ZiJ2TrmlcQbqmQGbuX798bGsJC4AOOIOu824UgYuxuZ0pwMCusUmcYdH5Yx4uEysnG
 gRpQ==
X-Gm-Message-State: AOAM531CfqVWt18IZSCGve5BcJEtC6OYdHUExSbFBzApJAuwl5hw1/SG
 32u3Gh73NBVd0YBqcMslFfY=
X-Google-Smtp-Source: ABdhPJzf4qzVUL1c4iEMCRnOjySZLo8ToKuHMTxEQaA4QYhNtgOt2j7pCFYZ/6hiXGW+Og3gB2reHA==
X-Received: by 2002:a9d:3422:: with SMTP id v31mr5504260otb.260.1614983845817; 
 Fri, 05 Mar 2021 14:37:25 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id t145sm836943oie.10.2021.03.05.14.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:37:25 -0800 (PST)
Subject: Re: [PATCH V2 2/6] nvmet: update error log page in nvmet_alloc_ctrl()
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9ecfa45b-53b2-fbd5-6849-f670c68eed35@grimberg.me>
Date: Fri, 5 Mar 2021 14:37:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225015642.29288-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_223726_944432_11708E14 
X-CRM114-Status: UNSURE (   8.37  )
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
