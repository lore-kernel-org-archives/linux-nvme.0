Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA4FDEE2F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TzR4rFsuZAoVGXCEKiTQREViNPygV4e8Rh5x+EecV1Y=; b=T/KEecsdlO3CmA94KCmy0eNHUy
	7dFkpaNjpG+lhFkvP0XB4kNGvsqSZmxAAQ40P1Elp8YCm318O67NJdYzwF/aAF9r3Ci2bqIl4tBVS
	HYpMrTOMyWYS8ZPSZs+N2PHdEoAfoj+OePp8NAwiwuKnRIH1xAFbeQv4QUHmmUO9SY+dgrq34jHAF
	IoX0lEu/omIuNq5LVmeM48ha6gG9JQidTYrCBuqhQz3eAg7q1ys5jYfLxFLvqq9neZwh0TR7VkSKU
	dWXC8guXn1/m1HVXe4FN5swfaAnPH4/IV2+Nj+n0gbIgEmjIRFgXiZOBf7X1EqY6NpW6kMZX1/kPj
	QwRBCMSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyDW-0000000C5C2-1umr;
	Thu, 23 Apr 2026 17:51:58 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyDQ-0000000C5BJ-0h5t
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 17:51:53 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so3678554b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Apr 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966711; x=1777571511; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzR4rFsuZAoVGXCEKiTQREViNPygV4e8Rh5x+EecV1Y=;
        b=aWZZ1trr2RoCtZJ5+d8HGqpWs9mp+JGYNkPYbH6sb2S6CSEg5t3OHmBu+Q6SYbQId2
         UtXZX4j7JKFRLzgJFg5z6Q/MsJ/PFLBgd0kL07ZPcm1UqaOebocVEAd0kyJHSVY/v2fp
         36lrXij5Ab/XBVS17WyLwK2wmp6ES8CkoO75I33n0dqu5yN1QO04YZRt2mhUkJmRluwW
         qT4C+tXXc2Ykrm+j+n3LSLDwAK3gD22B7/KJ1ixvuuyCZ/N8NQFDjwiBdmKxX3R50Dbv
         Q0bCpyxM1bpn8IBx1v7nVLo8HQNixwj1th/cJPiLwmdlZPLhjzpXpTQ6KhWMatL4PAeV
         BERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966711; x=1777571511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzR4rFsuZAoVGXCEKiTQREViNPygV4e8Rh5x+EecV1Y=;
        b=SxXH3Dpik5VJt3iKXOYUKHfy29Mzs2C+vSHfCZFr88SjT7P4TL2BMMmCzleXeGJdVW
         euhjLpusWXQiV5NaZI8VbJAH6+UoDgK6lQ1PZLN7Cp77BFYiagrJ/QZ7/Ngp2xA0j5QJ
         dge/U21VKfpFqOkIKpV1zecTbY7yc6Ub73hD/iOzMMSRbWCq6ionmpZ5v0MD3fEHR/jQ
         YV1buVe6N8Mfr/qDHDqRQrft9DRmv4Vnoh3DxcvlPE099j2l/nIHj9CwMxOOnlZ0Tx8e
         rhwjF/YE00dZtSOpz8PGy+glanED0XH4tpFP+Yu0acwtndvZleGw267e0ahjdYBcHohF
         5a1Q==
X-Gm-Message-State: AOJu0Yzm6dwYQ+7LHl20fAVAQQUCFoDctWYB4sM6D25T/oIcEYTg4JdN
	8pTot+1dqMYGz08VBFRPLXu8R2awY2MWgpH95C9ipvv+cRX6H9OK9jDyfptF3w==
X-Gm-Gg: AeBDiesavIOj48PZAAMG5O91hNHthMP7QjQ50NsDBQ2qll3l2zSVVbWbR3DF1cqB77D
	M1pOFe7eRuL9M/EendIFx3bE1RbJP00xzqCUgoKVLB1D78rJXr/7KVgjHlHG40HfwNB/Ovw4luE
	rqx144P8XtG/g6FmSnHkumC8nZ6wXkcwgC9/sDDEm+qqdYq3X4Is13ZyIKUclKac4AbRqCZ3mZ5
	RcEYZrhizTHBDtfo3d/Eyb9jiImojMGaTEWK8NPZCQjmga8bTgUoUC3NzKHE2jAJsNukGBgn8VR
	xFPDkeGCOYpPxNMCKQo7w/ZilX/liHJOX6iI1vjk5o2+J2yYQS6RacTuFRXK2K3Z9+lzivHNCrg
	3Gh6cwuQcgyTEdfZgoEeaL9GP+BF8krHqB0gcc0g0HE4H5HAinOCcjVw6eW6ibKkjBQDncZgCQr
	KOpJ2nM1IrT96wnqJoZdAxXAu3JSCqQDJmDK38t08QJb3zvW1FVqSp0VCZmfDIOZ+wQh3ZvszOb
	W6C
X-Received: by 2002:a05:6a00:994:b0:82f:193f:807c with SMTP id d2e1a72fcca58-82f8c7deca2mr30294984b3a.2.1776966710579;
        Thu, 23 Apr 2026 10:51:50 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:288:a197:7cfc:5ec5? ([240b:10:2720:5500:288:a197:7cfc:5ec5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2f9asm22185694b3a.19.2026.04.23.10.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 10:51:50 -0700 (PDT)
Message-ID: <7af729f6-25e7-483a-9a5e-770d6c6e6805@gmail.com>
Date: Fri, 24 Apr 2026 02:51:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20260422141159.10881-1-ikegami.t@gmail.com>
 <20260422141159.10881-3-ikegami.t@gmail.com> <aem0x5CsghH7HoWd@infradead.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <aem0x5CsghH7HoWd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_105152_201374_8173D452 
X-CRM114-Status: GOOD (  14.25  )
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

On 2026/04/23 14:57, Christoph Hellwig wrote:
> Can you explain the rational a little better here?  Do you have a
> device that does not have these entries?  And what problems does that
> cause for you for which workload?

The change is just an idea to improvement the scan_work to make sure as 
always do scan for the ns_mgmt and ns_attach commands.
Actually I do not have the device as I have only a drive these entries 
as NCC for ns_mgmt and NIC for ns_attach.
(Another drive I have but does not support both ns_attach and ns_mgmt 
then does not have these entries. Also third drive broken then I can not 
confirm it for now.)
All drives supporting ns_mgmt and ns_attach should have the entries but 
I do not think the driver side not needed to be depended on it as always 
do scan.
I tried to fix the issue below with the changes at first but the issue 
was caused by the test script then currently resolved already.
   <https://github.com/linux-nvme/nvme-cli/issues/3251>
So no need this change for now for the issue but in future still I think 
we can reduce related issue or its investigation by the change.


