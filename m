Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFE8C282C5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 19:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRiyrt8fVejqBJOeerAkOhbzZ3qu4Psgf4opFC293kE=; b=4rfW6DWGXVVnw9h0+RTibOhYWr
	ZZBS8chidDGNzGTxx54z4hZ3wSMYADq9Tyeh5nKVTHHGToPH7PI85+rRAdxeqKiHA10cTU51cxvlN
	BO6ezA/wwq6YZNme8RjEwL6IIPQF1SzDZMGgq5xfl8cT0Px/+hkLMicxNUJBPtHLZF2Rylr1rNohD
	fH5dEMP3chgJK4Aph3fEgZVk6d+S63FOCOVoFgvzI0XfJOk0oZxBo1RA28fYaGjr7hqebPWogLIdx
	P5K6RF1Z66NcGgPGTKnepYlYl8xFVeDCWW/ucIRisBShdmNivunyaG0HXG1joCk2ctkZ4as4RoDxy
	vKcCo/VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjj6-00000008XUP-0w3u;
	Thu, 27 Feb 2025 19:39:20 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tngNV-00000007zzR-0gfb
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 16:04:51 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-855923e7f53so76077539f.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740672288; x=1741277088; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRiyrt8fVejqBJOeerAkOhbzZ3qu4Psgf4opFC293kE=;
        b=NQZhSv/jqdhMeZ4DOcOe+MjN7egVEyCpnNbH51anJRcHURAtKs6zdk96dD9PYiPiUu
         38oh+BltWBgQOWp4aWFJ0RRq3x/DfEuwuJ14xfv526Z95NLWKI8kXSGtjo+idYP2EvPb
         fPiTXSvseX3SEhay2MiZMcWMJo2pWLL1DLP6qci7g9xVd2CEplBfcdpc3GxMWsCQcgdF
         Kq+uYqBJmn6fB9ImWDR7hkvHtJN3suXR9YJtb8BDLcJ/M4nLfXsHu708fTx13ErwDsUm
         un6Etdy9iqVvNgAA2/wzZwxPMgTQXLyQgR9IVWByCJZIhx1YvFXOs+TLs+mviPkjbDRy
         N62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672288; x=1741277088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRiyrt8fVejqBJOeerAkOhbzZ3qu4Psgf4opFC293kE=;
        b=H9LfsEndztkp/u+WwHH8ujQr24cCaJaCKKVsQK9QAL7kH1VOMarumy+94Z1jTck4e8
         VWbw2ebOT0K65NzxHHoEywUGgWRrurvqixqwlc0LVVKTxH+ARBv0ofj3sIUjm03XlvdU
         qTaugaHwzCOH4WzpBPDSkV1U4p1V9bzonKin3CsNUa3LOd8tLNyGS+ZwaSEvoWCg4r1U
         Tcq0i04l76+zj4ur5cqjk3+AUY3Tn27ENV++k+jNPuWvE0KNtvXMzLU6xFDDkqzCyjSw
         HAlfZjg6zFicsUPlwj5LFag+2AeHGRJ36nXWH06RfY9OtX6mNVzkEz3vhaRN0ZhFYXr5
         ilrg==
X-Forwarded-Encrypted: i=1; AJvYcCUq7WCbESET0euU0nVbCY/6mzdn6jcECEdQxYRufh9NhvwtMBRFv4rK09quR8XOxQsIqQ78jyg3hNbB@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/BORIEskIXeS/q/+mQaheIQXG3EA9T0E71tiUyCjJlgHWXim1
	KpCJdRGP7OSzhB1bX0gfSqkYRD/O0A1w+/vHVhNkN4leJRUh52bPqr8ClOGhwMM=
X-Gm-Gg: ASbGncuA6cDSxiaF8VlEWIX2RhaiwD4C5mA+CRH0iBzlA9Ke6XVf9sgtR+XlaOXjZBh
	Mvg61PSwnI4+/Iv0lLH2jtsd0zRj4v9w+XCAuZV4KZVBuW0upWTOpOzM1LtMwMA6av0wq2J5NNn
	68PkHvprGuh4EwjHd4vP+iEZd3ZMSRD35ytd6Fe0iOpneKYgBqwC27BrCFFlSHn7AOjYaTf2QS9
	R3abo/an9qTyUbtYLq33rgYWG6evdRVKnbN4+vPDutFpel+Z5kKH7f/JlxPs+fBUe4ixzzweuCn
	fLIR6qXb1Mw6IaFljT6dDA==
X-Google-Smtp-Source: AGHT+IGo6x2FH+vlfBxEZ8Tq3JIml3qv+EqIvWjt1EPR7qM5okR5+KJCsrTuyzBX355V5+1VbV5kNQ==
X-Received: by 2002:a05:6602:3cd:b0:855:c32e:7451 with SMTP id ca18e2360f4ac-856203d291bmr1454580939f.14.1740672288224;
        Thu, 27 Feb 2025 08:04:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-858753cc685sm35937239f.38.2025.02.27.08.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:04:47 -0800 (PST)
Message-ID: <01ed898e-eb6c-4ffd-8d32-f536a9f6e1bb@kernel.dk>
Date: Thu, 27 Feb 2025 09:04:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@meta.com>,
 ming.lei@redhat.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
 <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_080449_453054_5EE1EA44 
X-CRM114-Status: GOOD (  10.30  )
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

On 2/27/25 8:54 AM, Pavel Begunkov wrote:
> On 2/26/25 18:20, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Provide an interface for the kernel to leverage the existing
>> pre-registered buffers that io_uring provides. User space can reference
>> these later to achieve zero-copy IO.
>>
>> User space must register an empty fixed buffer table with io_uring in
>> order for the kernel to make use of it.
> 
> Can you also fail rw.c:loop_rw_iter()? Something like:
> 
> loop_rw_iter() {
>     if ((req->flags & REQ_F_BUF_NODE) &&
>         req->buf_node->buf->release)
>         return -EFAULT;
> }

Good point...


-- 
Jens Axboe


