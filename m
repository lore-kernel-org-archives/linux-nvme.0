Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505B1D3C533
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 22:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+mw4EAmgbxRff1MICbmhx606Y0hdnGoOtoskp9RHouA=; b=FxEyZ16fIkt5r2m9v+Ml1+Fmkr
	tbR8y+yWfnYLCGsWkIyE98KS8knUqwbxOfKZ6YGlD3EIrLlqJlFi25qoU7E6hw+5677GcUm8V7qvn
	qblTMVjhy1rJKDZifN4W7KU80DL5YFiP0k2LcL0zw/6eG4Lh8SMI45ut/vbYEzTINZiA8DCV5P3Cs
	gvIM8dr/fnZ1oB++R2R20STZXwnm0zAB7za1SDAzNnx8YqT9A6cRi/wgxQ6gSIcQvCWaBFHy7xMdy
	oCeDq9EpHn5dmB4+ae0tYEMOyNyfHWPVj73AUgEyXA7VUHoyRZtDoVjcVcu7Ejf2gvpJFBAbZ0ls/
	Sa8HkmvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ZL5-0000000GNAv-1RQ4;
	Thu, 17 Oct 2024 22:51:27 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ZL2-0000000GNAS-12e3
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 22:51:25 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-71e580256c2so1118498b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729205483; x=1729810283; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mw4EAmgbxRff1MICbmhx606Y0hdnGoOtoskp9RHouA=;
        b=CvodxTdZhQCi5971duIKFe1ujq8eagJhls84L6/Li1i50r0e+ZcJUm0GTNs+thJi8f
         WCcR25Uoz15SeKoqMB38nfb55Kwo4Pxt7iamRqCTaeJF4BVi1RcAV7hXeBbwYPvtjpzA
         N7Jkc/3v1UieDegbNybc5y2pLaZauCeZ3K+9OloKPSY1WUOQVUNFo7AJzkdgfspyeeDK
         rwsJcmsSytHZ0daX7N2zz1wBRqlAkg/YCGvluydbxry5hLjyWSbOwPX3IRruXVqZ+GIG
         2a20AfC7gA6Pp+DfS+fHwHSh3iyPkEKfyKP5OK3r8XdQKaC+mklKUrfOjHgCKEgzQBOZ
         SG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205483; x=1729810283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mw4EAmgbxRff1MICbmhx606Y0hdnGoOtoskp9RHouA=;
        b=xDWlP0aWoWZpcwb6UNagbBDhHyyctzLfCPulgE3J/CXtaebHJ7j2W/yW5vem1/kOnV
         k5AkDvG6mKDjm/3Oi+kBOi64ihXX6HhaqTkFsRluAZGZsnb7+O/pLyIAiFk/vVA2pfnB
         LF842YshAfNAExuA57dmrBc8Q1KgpkXKJ40wNwJDwyXvYDFJK/YVL8SqUD/powmNiqPY
         LHMAqCGXjbfi/1hT1pgufBTjty0xYEjFdjDgMW7NFpItZ4Apqss4punSuvMJTHtI1k83
         eqPOxDS/Ko09AuCt3vgCb9wWTmx3imQCNZ6bBz3RIypEdLiF6fo5joIoeYgE4X5XvhzP
         8zag==
X-Forwarded-Encrypted: i=1; AJvYcCXoVSRby2lsLjznjlipuq4lGnJXhE0BIt720OIBa8CexsFppw85ftuWlHWCP9XMXC/eHKgNWvuKWbpA@lists.infradead.org
X-Gm-Message-State: AOJu0YwT0qyddt0x6lQUEMvPAaMKbgUlepo9A4hjZaCAYvOZyOV5rAhg
	RzqV0xBFHJqX/HG3kW+fiV3N0KR6wBq9G5i4nCCPlSTQx65kzU2qKITJIZHnKPg=
X-Google-Smtp-Source: AGHT+IElS3afcGyUGmbCSqMvboNjMAF5io0kozg4OeEcMlWoHPb2GAlJ9GXegxQOyjitJa1uX8Kthw==
X-Received: by 2002:a05:6a00:22c4:b0:71e:8046:2728 with SMTP id d2e1a72fcca58-71ea330863bmr671978b3a.17.1729205483507;
        Thu, 17 Oct 2024 15:51:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333efcdsm183159b3a.76.2024.10.17.15.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 15:51:22 -0700 (PDT)
Message-ID: <86072e08-bac5-4a4f-9c76-8b1eb53ea8a2@kernel.dk>
Date: Thu, 17 Oct 2024 16:51:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] io_uring/rw: add support to send meta along with
 read/write
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>
Cc: kbusch@kernel.org, martin.petersen@oracle.com, asml.silence@gmail.com,
 anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 Kanchan Joshi <joshi.k@samsung.com>
References: <20241016112912.63542-1-anuj20.g@samsung.com>
 <CGME20241016113747epcas5p4e276eb0da2695ba032ce1d2a3b83fff4@epcas5p4.samsung.com>
 <20241016112912.63542-8-anuj20.g@samsung.com> <20241017081057.GA27241@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241017081057.GA27241@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_155124_519441_CF3B2ACD 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/17/24 2:10 AM, Christoph Hellwig wrote:
> s/meta/metadata/ in the subject.
> 
>> +	const struct io_uring_meta *md = (struct io_uring_meta *)sqe->big_sqe_cmd;
> 
> Overly long line.

That's fine in io_uring, I prefer slightly longer lines rather than needlessly
breaking them up.

-- 
Jens Axboe


