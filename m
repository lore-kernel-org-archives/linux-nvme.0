Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A4C02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 22:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q5xAV9fitT92C+lFysFScC50QvwNXIQ5wMPuKIOKP8E=; b=pMOP+bX/z8Hv2megmvZnY5O4PT
	/GLu64jxLZ1PaEzu1JLePkac4z9u0NbxNJ5GzfYFIPjoWIZqValgvLkLjVrsEyiLqFOXE6qSZL5Zi
	8kA3bzRaKo16I8Txcklwl57EqIPHLO8uOUZLeYjSAOpYJ3q70Aj21o3+VvsRfBcUTMBdhFNkZ/dr5
	kpAY1d4nKhCvjfbu6e/IKdmvVQzAesRRz/xoYWDtR1DyBsJJRk7LXDZKN2r4kuL6cnGuE5sbDMIpE
	XMn8AiS0G9kR/2vYjpzVdI4nhA9gy6sBWSEmryGQAU98ZRMnYMZ6OrgafNvJx/Tfsb/+mUKTXlsOb
	yDTJ9XHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5J7-0000000DN5i-26fl;
	Thu, 23 Jan 2025 22:04:13 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5J4-0000000DN4N-3JiX
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 22:04:12 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so14710625e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 14:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669849; x=1738274649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5xAV9fitT92C+lFysFScC50QvwNXIQ5wMPuKIOKP8E=;
        b=ANQVgcvn9YcM5QeAAqlXlHP17XYAIeTkGTKQ1mau+yO9vj2zTZz6bRGFCmCGOa1xJp
         Um3bDmnozQuy9mMbgoLH3Cwzg2eK6jqasGcyca4Kh7R0tZTiL6W8L7cTWTZN7T3GvMRe
         YMZpjbbnHfqO0VXH8qBvntDsDziTVyMwDYtyjBH3CfKCzEj201eOGDuRQ/8whnQYJKYs
         Riv4gXb209T/LPdy1ZF1CK9CIw/7TNhmhTBzIoEaHaMlLpL+0Fq8qU7/O87BhbJsKI19
         4R8hEb4f5lS34Im8aXRRhkmCGUEClJz4RY11lrfJFLavCCjQqdtH+PcAsVi71P+PKtGl
         8Y6g==
X-Gm-Message-State: AOJu0YxeeIf2zvQj6RjmVUVe4vM5/qxQqfqtgkNlO7sOFW8wuwUCN/38
	VdVdrfCQpCxiIzNc+RYRNxwpst/4cfwD4Sx3fJFKw+jHjNALXbju
X-Gm-Gg: ASbGncueVYZR2EqQ5S1BSdkeAWW0T/P/WL2zA2hw2KSi2tSE6lLWy5RbFQ8YMX368pF
	9IU7Nf9AtZD+abkpInjZT6IGb0/4H1BrFLIQqhLspZYXoCzCdpzXNtBnHjpFo3Krsf7u/c82Lnf
	pJzNZa65xtCciFMI/3eHAr0pQe+hDQZ2tfBbpi4ztHbdZZszIc1NL8S/hfsa1SI6JBgCbxN63iz
	lGGHzsIl6UyDTdFFPAv9iGbUhIklA3W3LrQE3ObzsBduiv+c4QEVoLsVQ9Y2DYHZTWgCwjhxhij
	KNqdcvp+hIhlveKPp7CGbXp8YXzSl9iHatW1bWPa
X-Google-Smtp-Source: AGHT+IF2k6JSdC0vJlDs9HGm7BeOsvNGFct+BwnXU9w4q0VGHDPVkD21Bg5hPa+Ns8oTg+GIg0oGsw==
X-Received: by 2002:a05:600c:4511:b0:435:9ed3:5698 with SMTP id 5b1f17b1804b1-4389143753bmr239891855e9.24.1737669848307;
        Thu, 23 Jan 2025 14:04:08 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4b9977sm4984415e9.25.2025.01.23.14.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 14:04:07 -0800 (PST)
Message-ID: <7fe8282a-8fc4-47e7-b7bf-b1686d78e9ef@grimberg.me>
Date: Fri, 24 Jan 2025 00:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: check that full ICResp is received
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250123174905.1252949-1-csander@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250123174905.1252949-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_140410_830055_CF110250 
X-CRM114-Status: GOOD (  12.57  )
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




On 23/01/2025 19:48, Caleb Sander Mateos wrote:
> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> checks that the return value from recvmsg() is non-negative. If the
> sender closes the TCP connection or sends fewer than 128 bytes, this
> check will pass even though the full PDU wasn't received.
>
> Ensure the full ICResp PDU is received by checking that recvmsg()
> returns the expected 128 bytes.
>
> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
> recvmsg() could return prematurely with only part of the PDU.

Thanks Caleb, this looks good.

I think we want to adjust the title to express that this is a bug fix, 
as well
as adding a fixes tag - so it can be picked up by stable kernels as back as
possible.

The title can perhaps be:
nvme-tcp: Fix possible connection establishment failure when receiving 
partial ICResp PDUs

