Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFA9C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Mar 2022 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=075g20k4DHefJxD6reM7eLorGBY2V+lTaMr5/Yfuikk=; b=bw7ui4BRMNDxefqYkVlAtu8w4m
	lpU51Dmp2h3Q9MhhhFUfQzEJkEN0vYlXAHDyzq4foJIHLCNBzdLcKKBBCbSPRCxY4ShRLHA4HWvm7
	J25dsHaahKkOh6O4qIR/9/XXnras3kboCGwA9RV4YNxzj0DG4VihYKj1lpxcn1XjkTQWFKsBCo3sS
	n/IZrxtIA5+Gu0XpTimGy6BseqwSuY5qBlBPPSaDt5+NAgYMJk4z329j6bflAJb+SlbthH2I7rc8p
	wNuCQQEsV2Y2L2u9O4eVDnpShv+6abU1vAICXUYLSRUpHaMtuN0NIIHzLNDMaW7lD2IQyPiXAD5lR
	GeAes1vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRJNM-001PVE-SE; Mon, 07 Mar 2022 19:50:36 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRJNJ-001PTt-QD
 for linux-nvme@lists.infradead.org; Mon, 07 Mar 2022 19:50:35 +0000
Received: by mail-io1-xd2d.google.com with SMTP id x4so2393433iom.12
 for <linux-nvme@lists.infradead.org>; Mon, 07 Mar 2022 11:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=075g20k4DHefJxD6reM7eLorGBY2V+lTaMr5/Yfuikk=;
 b=b6gizO6iwcc+5TmuZFQ+HaG1IufNjOIurkziuVpMjRnJkz0C7OfK1K50nDahz+v7Ll
 UHwGuQaLB00rzfRu4UkOpJ6wWJb1nP1ftxPZ5xpdPKXaIPBbfVNygA4ILoYup/9NuSAN
 bXqiod4vVT+LgnaOXLEeCU5i4s6TWyPRv5hnEHmxN730zF+CaiTefhnkDCVzATTIPDiQ
 54Fy1Un6SCWLdyr4UFngqVDJUAk90q5bi7qKp7BOVNrLrGgVdW+4Z5Q+ghqdMfirjnlp
 eLLeruOIQLu08sWXcpYj6ZIdMgWcWZ2OhLeuvm9LfhJdecKBcNy4CYO2tHNBqR9z5FZo
 yF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=075g20k4DHefJxD6reM7eLorGBY2V+lTaMr5/Yfuikk=;
 b=Oz5kjy0ghgPrvFZdwxEQY9SlbZBQLp657Oyb0c0e041HftRjmdRs66uCI3GXZWEWTQ
 kgO6U5egelfPYU/3cIn3wBMj7eg11lkqqmaXKlvBvKUSc21zeXBIwv8ofPmtQT5/KaUY
 JrMmwbH9YkaSVQoZkHUwFjuywnLmsIT63uzFX+9gGhp7bxwX8yLufLjX0KmwDvRYb1Xs
 W6jmXETVzCGoO5j77zsr5rk2bLPUJpWpZBgc9jXk9evRMVMVa5oLHTxo7K400hFltJhj
 RQaF5C6X0rzR4vLL7np+VOgHoHy+poqKXBTWcoClNzMoK5LkHjQh9Kn5zFusBCz5bgXW
 a5cQ==
X-Gm-Message-State: AOAM5337rx+QwTJF2CvnYXVmVHK28yEWGywOMsHCHBee3S0RQCknbSw4
 HcFuXjOZcrY8CJpOaCfD+TsffA==
X-Google-Smtp-Source: ABdhPJz3EJTLTGdE09CoWJ3Zw3rYFrvaaiC7ejcGBa1FivbI69Gj/+t2treGBX0dGrzg2icD+cfxnw==
X-Received: by 2002:a05:6638:1693:b0:317:aa11:16b with SMTP id
 f19-20020a056638169300b00317aa11016bmr10953735jat.125.1646682632627; 
 Mon, 07 Mar 2022 11:50:32 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 h28-20020a056e021d9c00b002c64c557eaasm1187521ila.12.2022.03.07.11.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 11:50:32 -0800 (PST)
Message-ID: <f059aa4c-5af0-c3ee-12f9-1b19b2b380aa@kernel.dk>
Date: Mon, 7 Mar 2022 12:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv4 0/8] 64-bit data integrity field support
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hch@lst.de, martin.petersen@oracle.com
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220307193448.GC3260574@dhcp-10-100-145-180.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220307193448.GC3260574@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220307_115033_911863_36D5E030 
X-CRM114-Status: GOOD (  12.02  )
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

On 3/7/22 12:34 PM, Keith Busch wrote:
> Hi Jens,
> 
> I believe this is looking ready at this point. Would it be too ambitious
> to see this applied ahead of 5.18? The block layer provides the focal
> point for new capabilities in this series, so I feel it should go
> through that tree if you're okay with this.

Layered it on top of the write-streams changes to avoid a silly
conflict.

-- 
Jens Axboe


