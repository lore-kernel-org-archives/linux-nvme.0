Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1500C636C9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 23:36:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B26613DA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 23:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B26613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZzYX8K0nRrs6CSAzRvLSxwA3jPM7A27X1p7F8sYl2M=; b=Tc+1wM70QCbscXDLJsanEYfWqZ
	6ybLYZVKqbN44Mn1rPHCZ69Zl1Qi9YN5iLxbUyMQYdyEP3QnquBHgFN/zI/PsijcyNy4kMl4lo8Pz
	eGQbZ9hWAbumcYZ+ZTFATLkhLgxw4GNX+DvUknlmzwFMG4FcPMiMvmHoUuWBqJPFvx4RFeDAX0NPk
	kmbQnEsQH9a2mP6uYoGyPyE+bnxLzFHECSITx62FTjtg5eUKcjvZN2HcLhO3eLtqxGby5v+1AE4la
	PbcbcDdXGpSkBnl1C/Vgzy4taMmxuMjaj6hAusOWfHvSQnh/IkkDx8zczyRoiMScxxi2Zsnr5u/HC
	UuEqMU5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4Atd-002g54-JQ; Thu, 15 Jul 2021 23:36:01 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4AtZ-002g46-P9
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 23:35:59 +0000
Received: by mail-pj1-x102b.google.com with SMTP id bt15so5294239pjb.2
 for <linux-nvme@lists.infradead.org>; Thu, 15 Jul 2021 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=8n2hGsB8+kXHityBfLwEeXC2lYPLde2misubyUhtMxo=;
 b=S8HEMSDxg6Eadk6sLHSkTAqp3VjQpTQl1BP5N0DRrNiQlg8lTHrER7cLpxcF/0wJFY
 9EHnVvbV2cPv/TK3rrxd1Ud7OC0dwklZnJDCbv563I/iaez/3FO6qRtIIzfNkIqBZydF
 5ThLxx9/2D9Ao1rWZRBtRMqYCnaMP1TP9NSoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=8n2hGsB8+kXHityBfLwEeXC2lYPLde2misubyUhtMxo=;
 b=AOEc6n1kxeqsPLJIZ402b4oNil/t32iEA8ENd8io3HBbjMk//Rp2pOR2I0sEAO2t4Y
 799DQV0dC9hXWiSha126QDFizJBriiu7NQdmGcB7FUF1xjpfjLMLruLgG/X26m6i9k6r
 +OZFKVxvBEaT1NnFG5C0sgRMXUHLA/s7JiNncW7ZN1idmwPpaikCksIpg8jteWGpEpKH
 yNr/Bxr1KWJiZVd7Xc+AU4dKFiRkixZfe2gPSdt79fYej+aTbOYeDmL0IRrstlXxS9C/
 OwhXundoZORN33Mxb9ydzZ8Fd0Ey0o+6xuc/RxxPdD0tJ+ggzZ7elPx+OzCpR18NUE+J
 zGLQ==
X-Gm-Message-State: AOAM530UKfOPIUCfOxsHI7B1tfJznepvv8M2vqtLnT3FrJbPau0d4cTV
 OFh/E8utrEIYB8H/geTdv8pngg==
X-Google-Smtp-Source: ABdhPJxNcndJcDGL7ZANlHt7E68HcR5ot9yvH8ZG28oK+ZA5e5YMN0g1SPWWdChoCSYYkS5pXnNg/g==
X-Received: by 2002:a17:90a:3009:: with SMTP id
 g9mr12237594pjb.82.1626392156214; 
 Thu, 15 Jul 2021 16:35:56 -0700 (PDT)
Received: from [10.231.221.33] ([192.30.189.3])
 by smtp.gmail.com with ESMTPSA id 144sm8736171pgg.4.2021.07.15.16.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 16:35:55 -0700 (PDT)
Subject: Re: [PATCHv2 0/2] rr: nvme-pci: fix races and UAF
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
References: <20210707211432.29536-1-cachen@purestorage.com>
 <20210708194452.GA289335@dhcp-10-100-145-180.wdc.com>
From: Casey Chen <cachen@purestorage.com>
Message-ID: <3357a87f-c807-be2b-cca9-8f5e35fdb3c1@purestorage.com>
Date: Thu, 15 Jul 2021 16:35:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708194452.GA289335@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_163557_993682_0128E62A 
X-CRM114-Status: GOOD (  11.50  )
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

Any other folks have comments on this patch series ? If not, could we 
merge them ? Thanks!

On 7/8/21 12:44 PM, Keith Busch wrote:
> I have reviewed the series and it look good to me.
>
> Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
