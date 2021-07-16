Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B85C636C8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 01:21:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9351F613C9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 01:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9351F613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyhFYp9W0bbSnfWwfOjLP5+5VAQeLq/6OETX/YKPT0A=; b=Ob0qvRr6OkJRlH//sFF6WNLRB+
	KrTvO/5DVfcqMPpAOaMm8TQs1G0d3SQHlgzbHuGtsbzS9iEPgijqtwBXsgUGMr1jhRP2NBB/jXv6v
	jyda9vyLuv+GGNY5Ubn/RfqF2WyXlwu3bSyNXGIssYilNYdzXsG/b1g+6ioi8JM0MWHcovSvD3ZAJ
	2thnKtsNtKA65k1bLAfpKAEOwYjRX4pVrSzLCJUMYglhtMnuOPeINOjtKYAw+iV7fgDZI9ZYUjqb6
	yOUqNY7rBCx4UopbQLavXfh2OHYxfo5RiGt4oTgbK2hviQ/O/xb6U/+qNxdSmpwTC7YzA6oIGgn6k
	0PnoqyYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4CXl-002onM-Ow; Fri, 16 Jul 2021 01:21:33 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4CXb-002omx-7K
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 01:21:24 +0000
Received: by mail-pl1-x634.google.com with SMTP id h1so4468690plf.6
 for <linux-nvme@lists.infradead.org>; Thu, 15 Jul 2021 18:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RzVD0hBbwhi3h4pLy4y+uuFLqDLGItwpXqVZUwfHj5Y=;
 b=ktduSKV3WTOurbrGWzZWx41LoiIG/auahnzcjF2Qiiqz8ViIIJc81ULuKpZbGHCCnR
 25a7lNAionkAHWsRCUhN1Lk9YUvse0r3uh9A0Dle19hb2QCGQ+/TGdcfZKvDhxuHaDL8
 8KVOmwqwjk5uX6xDHIBqr0Fn/sdCvnjEJmCPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RzVD0hBbwhi3h4pLy4y+uuFLqDLGItwpXqVZUwfHj5Y=;
 b=GM41Kw0JDW8/vmOHukYJh7VA/JMGgFB33crciZYHjogw6kitAXsn3+sA48PffFQgPH
 IoqRiDYFdwz1LWiUIFj8N9VHEVb1tzdOfjDwjAagABvlCsePlIGZEm1qlWf1b25OvF3B
 yIp/OIMlvoKgkkoearyS10LuZIqmWIk7Oh9WO8skLwSERZYI8L0RfuNs0VUHF50OzFNn
 eyDpyiohspgB3CUHsWEYZOjzqZc6l8SJ9RHtb9cTgkfveZInDeeWE0ozuAD3SCpmQ24o
 vaxnx+dTAY6GLdkct+c5sCNhnV5xKOyG31/PPwTm2B+6dSaaAi5OLvPdXHIHNkUMedbn
 eUjA==
X-Gm-Message-State: AOAM531Q/+5O4vXojjJrNtN+5aIf2iQeVhHfEfk/sjqiHDsYsjAluZe/
 cky5ZgghCo8EuBBVNfzTfnHIZA==
X-Google-Smtp-Source: ABdhPJydZF9Syxf/YqsQY1D/88P5rP0ItNVpXANP9laAG7CQDzl+3l9L2Vm0yKIpDNwiNvhIPwJDlw==
X-Received: by 2002:a17:90a:1941:: with SMTP id
 1mr12981121pjh.217.1626398482364; 
 Thu, 15 Jul 2021 18:21:22 -0700 (PDT)
Received: from [10.231.221.154] ([192.30.189.3])
 by smtp.gmail.com with ESMTPSA id ft7sm10147532pjb.32.2021.07.15.18.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 18:21:21 -0700 (PDT)
Subject: Re: [PATCHv2 0/2] rr: nvme-pci: fix races and UAF
To: Keith Busch <keith.busch@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, yzhong@purestorage.com,
 ashishk@purestorage.com
References: <20210707211432.29536-1-cachen@purestorage.com>
 <20210708194452.GA289335@dhcp-10-100-145-180.wdc.com>
 <3357a87f-c807-be2b-cca9-8f5e35fdb3c1@purestorage.com>
 <CAOSXXT5TM_OXgMZMnprH2rzgw7vX4wNK=4O5S_2_pgKcbt0Gew@mail.gmail.com>
From: Casey Chen <cachen@purestorage.com>
Message-ID: <4b53b72b-4e29-2613-efd3-f222b17725fb@purestorage.com>
Date: Thu, 15 Jul 2021 18:21:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOSXXT5TM_OXgMZMnprH2rzgw7vX4wNK=4O5S_2_pgKcbt0Gew@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_182123_398052_B6D916D9 
X-CRM114-Status: GOOD (  15.00  )
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

Just found them on tag nvme-5.14-2021-07-15. The applied version looks 
good to me. Thanks.

On 7/15/21 5:12 PM, Keith Busch wrote:
> Your series is already applied to both nvme and the block tree.
>
> On Thu, Jul 15, 2021, 5:35 PM Casey Chen <cachen@purestorage.com 
> <mailto:cachen@purestorage.com>> wrote:
>
>     Any other folks have comments on this patch series ? If not, could we
>     merge them ? Thanks!
>
>     On 7/8/21 12:44 PM, Keith Busch wrote:
>     > I have reviewed the series and it look good to me.
>     >
>     > Reviewed-by: Keith Busch <kbusch@kernel.org
>     <mailto:kbusch@kernel.org>>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
