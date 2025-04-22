Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03FC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MVLotyvervUmkseVH7ya9kdKw2
	aDu4hQvvuc//HQfLZW2TH7D1EuvZJ9x0DpohkqmDl8VJAgZJi/Cd7EXCJJUveEBCibP8u7KUY5zMx
	JrFOq2KXZV3cJI6P8T47nldmynXa4/1n6oSLkUjrgF00QWVnEnKBLsjzibhXh0HT5bPOZSE4aSebT
	HTf8NhQJeHwn0vwL3uy8NaxQONrxMVpV1MvNdCWSKNOSEF5ssVj/bszwPAn9hd9A61niLmmT7zIga
	SXTZ82z3JIQjgK9cSS5xwdWNgXeXEQt/3f1DT+vXrXNC4LD9p/JDZqGLAXVd2I1+QVlERSDbHj+p0
	g3V6cKYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7D6x-00000007C7R-1ARz;
	Tue, 22 Apr 2025 12:52:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7C3u-0000000708c-1Shp
	for linux-nvme@bombadil.infradead.org;
	Tue, 22 Apr 2025 11:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=LjcfCyhtrnrV+h4aeUibl0LAcx
	7p6SbjKI1KNrcJUaXZxkBGEtskEArvjIW/+o0z6iOtCwJrM0+1b4v0LtT3kTp8hsIFB7nHFqkxUG7
	3G+hlC+HJU0bUsQuRZFrOjQozU5aV+0vwCOJ/oGaUFmK+PbBs/cq8jRLBh4nlpuvM6AMdqBzZD+TM
	XxtcDegMvvwPe7omEeA8kn51w4NmSmyrvGw4udhVw+ufyCd1ENqEuhyk9e76qeUxuSX/5h0WtJyHU
	Ut93K9GoRWGmlOcGYFCiZ8/gTqM31TTRXlliPaQTteyXiiM8fSZtcVQsZpSYCsK3NvcBlWr7xCCFL
	EauecAfg==;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7C3q-0000000BCjt-33uo
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 11:45:12 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a064a3e143so236101f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 04:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322308; x=1745927108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LTMkUh/KWkMQt6JCAVnyGAkhgarcLqkp8LthS8qjoSTiGCgRbaO8l/kd1L3eDT2DC6
         uvMI1Q6IBwq5LnVMHZBn1MF0ShIfRiJxddvs7x4agxQPgz1mJdtkFNPgHms2hy7oYbq0
         h3cn0YaiGSnQKM8UauCZkKMhEmAMwOTyi8ZtVf1p0yut/sHBQco9rbrS/IYpS5eC2udJ
         YkfW7ofoCOYsJQA/0yQZITNg1ZpxaBpCwgiEW5JGt4iPCG26kYe+Dk2x3CdRcDS5fFyn
         l5RKv147Xfk6A4EJD8/klLp37XIQdlj8oN9tN3tCDc0n28epbNrt9jvLFqPXrpZa2ypc
         TIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu9XxJrPgHcvEEHUOqbMKyigkt919WOfdpdSY9+ruQr8HPu/QiXNf3HgPJv2Y+gxFlx6kWzALrwOvs@lists.infradead.org
X-Gm-Message-State: AOJu0YzWo34dp2sMdlDEs0jaosPRVfS+Ev+8QwVMXV6PWnp/eR3CqL4g
	OD2nmqGT+mERjsMU0zTKA1o6iDqzASSRBVDR51B4A0fhYqdxzU17
X-Gm-Gg: ASbGncvTt+SH6t6HeWzNQwIRSyloY6MI6BswLNdaxW6Lut7L4i1e+s+lOvDXZjmeSM3
	OTgQ2CRs87O5+V/+oo0dp0hmPdTN0eJo9/w6kVK/iNQlgp/v4cphEGeIQK8e9NtIKa0FnL02HLu
	ct1ps5wkI53Gpz5Pp7tVdabb34IfGWGNBlstv9frj73Q3erOM5FEZ7NBTJeA9719JHOW7Rtwkgm
	ECPC3IjRDljuZVLEgF3sDFx9SeG6R0I+kvsY0+ws3Zge8Wx9YoY4T/Pc7FHvqjL7s9UYpfm5f56
	ujMPo5swvAxaQ4/CrdNJePANtoEiE+4MCwwOeA3oZWJBegz2OmUDFGcMJNKH+axdweH3xw+FELX
	RwUu4D24bmRE+O+PB
X-Google-Smtp-Source: AGHT+IGJklG+oYWUNhV6aCUmeX7ELGO7ly0rpUv7KbZChA9Y/w+LBLStuVC4QgbdfmLnoKp93pzDJA==
X-Received: by 2002:a5d:59a2:0:b0:397:8f09:600 with SMTP id ffacd0b85a97d-39efba3cc22mr12376813f8f.13.1745322307762;
        Tue, 22 Apr 2025 04:45:07 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4206ecsm15228837f8f.17.2025.04.22.04.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:45:07 -0700 (PDT)
Message-ID: <0c5aa410-f3a0-4834-b90a-702ba09379e5@grimberg.me>
Date: Tue, 22 Apr 2025 14:45:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme/pci: factor out nvme_init_hctx() helper
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250421165525.1618434-1-csander@purestorage.com>
 <20250421165525.1618434-2-csander@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250421165525.1618434-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_124510_903550_D200860D 
X-CRM114-Status: UNSURE (   6.21  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

