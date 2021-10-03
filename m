Return-Path: <SRS0=iTsx=OX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F4C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 08:52:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B5C6124B
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 08:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3B5C6124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ab1sljnfXowMqRLG5ZO1nHj8NZCI+GHZ4JhHJq8/xms=; b=LoZ3jN8YcR2J4pP4p1yfJN0Idn
	0uNyvyacd17myopWzFiUcY0rhYSe7RT/UL6AllWezjc9TRBZr4Bpmq6RkK/mtFZZtanS5uRupXmAE
	p7ukHaToNWjpocZNpwRC3Hvj/CuX268hkJ1lzpF4KgIph9ZB53CxcjZJZmAjimBgWa5fuMvR6Id+B
	iA68csbaWkzRt5VTjDnsyRjzG5pQI8cbRGhx/Fe/Yk7hMhuZPvJoBNiTQSh+w5jIXxdVnxDtqhvaP
	krhvFQK4P1SAUm0hyDC1CWprXFHKVTiTNSgrv6J6x3/sOMDmCcbg7WwAmx7eGUNxZHcMictKtyiOH
	7eALcQEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWxDj-003RMJ-P7; Sun, 03 Oct 2021 08:51:43 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWxDg-003RLZ-AY
 for linux-nvme@lists.infradead.org; Sun, 03 Oct 2021 08:51:41 +0000
Received: by mail-wr1-f52.google.com with SMTP id d26so24257348wrb.6
 for <linux-nvme@lists.infradead.org>; Sun, 03 Oct 2021 01:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AhCcOa+wwG5z6gDmVuyDVi4fZY32KmCU5eg8QVv5ZZs=;
 b=sBjJtLLnGhPYsd17labk7fctzvOfG+g4x1kW2mv8Q0RwleZDhDBGWmQ8XE153VLUQX
 LdEZ2tbq9bPoDxcmtdcSpoBiaOamyzl+BAWM4en/b3kNvvstPXEt3ZmJEjLM8wbVkOko
 98SvUKJZ+LkIlEyNbTcZXL5W+bEOWjmXhsVohFdKUDCUiD7ML1o9d44uJc8zB1EIvaSD
 y2mOfto2CTn4BbJEH5QhBfFrFG5TdP/1YQJl3Hg+2eNLrpUVZnSAU+LASLVBzHV2YzTN
 T6KJziYf2OqjJLLXfchjo9SMmiHzFkWyu/TKEcUQXFA4uVnefJmIluqX3GNhRjnkGGeg
 9ibw==
X-Gm-Message-State: AOAM531I2qrkG1Q53yZFcNtuB1grjGC7a+5f1/l4JQXygvwgqjmeiAVD
 WI4lnMs6o6/BOu/t67vZkUsABMC1q1w=
X-Google-Smtp-Source: ABdhPJzhbrUtbqjcSmUllid3VmHF/rpYOJHjA1fKTHImYcoWnAl217i5ou0zOkVZq02nDYMZ1Oa/CA==
X-Received: by 2002:adf:aad4:: with SMTP id i20mr132023wrc.402.1633251098848; 
 Sun, 03 Oct 2021 01:51:38 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j7sm12633555wrr.27.2021.10.03.01.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Oct 2021 01:51:38 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210928204052.GA390773@dhcp-10-100-145-180.wdc.com>
 <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
 <20210930201510.GA94540@C02WT3WMHTD6>
 <0dedfd62-d61b-cfe3-8b5f-13c213323b46@grimberg.me>
 <20211003020434.GB410131@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6eb7eb78-2ed1-1f17-384c-2d1d20e99d16@grimberg.me>
Date: Sun, 3 Oct 2021 11:51:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211003020434.GB410131@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211003_015140_406963_34A5E875 
X-CRM114-Status: GOOD (  21.66  )
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


>>> Unfortunately this was unsuccessful. The same issue is still occuring. Please
>>> let me know if you have another patch to try. I'll also keep looking for a
>>> solution as well.
>>
>> Really? That's unexpected, this patch should ensure that the request
>> is not advanced after the last payload send. The req->data_sent and
>> req->data_len are recorded before we actually perform the send so
>> the request should not be advanced if (e.g. last send):
>> 	(req_data_sent + ret == req_data_len)
>>
>> So I'm surprised that the same issue is still occurring.
> 
> Only thing I thought of so far is if req_data_len is not aligned with
> nvme_tcp_req_cur_length(). When this was working, the request would not
> advance based on the nvme_tcp_req_cur_length() value; now the criteria
> is based on 'req->data_len'.

That is exactly the bug fix that broke this. Before a multi-pdu request
would incorrectly avoid advancing the iterator.
nvme_tcp_req_cur_length() is the length we need to send based
on the pdu, not the full request. In that case, we shouldn't have
an issue advancing the request.

My recollection was that the original issue you guys reported was
on the request last payload send, where the controller sent a completion
and the request was re-executed as a new request before the send
context advanced the request, which led to a use-after-free. I suspected
that this specific issue would have been addressed by this patch.

Think of a 8K write where the target sends 0-4k r2t and then 4k-8k
r2t.

The host needs to send 0-4k, on the second r2t reception send 4k-8k but
due to the fact that a completion may arrive, avoid advancing the
request (like the original reported issue).

I think we can also solve this a different way with refcounting the
request, but if the suggested patch doesn't resolve the issue then
we might still be missing something I don't yet understand.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
