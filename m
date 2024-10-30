Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63235D5CCB6
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TcLMgJLbqvOSfHGThREfZnNbXvQVO2LcvPlc9fGCaS4=; b=FdHTp+6uftJvGKciJx9uV/P7Q7
	cI10/k45I2csg9pyOG+dTOE6/WSrs7mKrO61HQ4CCi6rOotK2xsTIVmTO6rjPNqU7EeV6c/CCuA5P
	DG84kTyy9TrdcevYngPzPUih6ZmhVxoxrhIurikAjRLY5qhZ1JU+hmhMhO/3GNQU2zOkcP3k82ls0
	4wcSzt/mccm8O1kUtnfJnpBQlWGCiWhOkQlHkCjple7bKEVWqDE/UrS0G/bdnRdeu+5aye5YvWub1
	nx4PmfLLxEHG1urbDp/j1BImFXdzazZgZi3Swd2G+tN6+4HG71STqv/8Bx1ZE72ytca2g2EihXoHr
	Q0frFSFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ABr-00000000l7H-0v1S;
	Wed, 30 Oct 2024 15:00:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t695Z-00000000Xpi-3rPP
	for linux-nvme@bombadil.infradead.org;
	Wed, 30 Oct 2024 13:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TcLMgJLbqvOSfHGThREfZnNbXvQVO2LcvPlc9fGCaS4=; b=m2yejOoRIDIBzzRAa3o5FF6Gzk
	fsMKkWcWhN6rNwWSx5djZUgkfmyVCNuarM+uz9EzKDAFZ6dNv1gT0YrHTlcEVntalh2rZIQWR3d4X
	StTBvnOidG/pbRRr6UfpL61Gso7wLCmSBBUXGWLRYqJ3G6+ES3fUvMAv/FarP8ovId5ExN2dJs585
	upnklS5uB+jqx+VQv71xDRxeeThv0xz/xVzQ/LWkfCjCXsZodePDf8EBey/7fitPkI+K2f61/8T0C
	jCKfl4NNvnurfcR2bDIfZVdcT7Vxudpzdbfwc8R6C25FsEWm2cXescMllCxmnEZXMROcknk+pvmp1
	/r7RJXrA==;
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t695V-0000000AFlP-1x9E
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 13:50:20 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-83aff992087so254550839f.3
        for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730296214; x=1730901014; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcLMgJLbqvOSfHGThREfZnNbXvQVO2LcvPlc9fGCaS4=;
        b=qMOVex3ZXosqxWl6vI1XQ/kqOPWDRgM2nAGMCpz4j34/1gMPRkdM1Wf2lArruzHY6n
         8DXIlJ1MNbpFf9lbJ6oYgQExcsXZEhueYcoCxoHdV30E5/8ZjX2l9gTRSB3nAy7SXC4M
         JsqG5Dd0oVCkitT+cH1T/TdYmDE5Dy7hBgADqePAvabjepgmUsiruo0kAqNdGEzSMjRu
         oMvh6DOQqtAbtAWphMv4v1sTfOKmTj5M53TVeLcxpDjZFN4K8QR8F9XGK64heBvJat2F
         GwXTa/hIRtbKkQJdy4BJNEEGJBzziMW9SBeDM9vZ6WRHqVzYw9mqq+H6tknNJ4hsducS
         ZLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296214; x=1730901014;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcLMgJLbqvOSfHGThREfZnNbXvQVO2LcvPlc9fGCaS4=;
        b=aksnObYr/qyYAVA6LYELnNG7vC8GBXq5Idszq2CL22zhOXtj/mSf6L/4QjL/cSMtlL
         Z7x4Q6agoDvaKk20C0gywfrbqy3OfMxsmQK+pAjMVhQ1PwMAgdQ3KtEW5FWHBRbAEtsX
         DLgeGFsnmoNsqmMIDIl+rUb9jKAkItCeZnk914E1n6KOiX8s+aRqZQotkJo+ISYZvVrY
         UXc0pHA4nCr5hj4cXxPbt3A1q3sWto6nvXxVgpAgFkZEAavcrC4f931snzssBBbf0MAV
         PnazypsMC0gHtenXPjr3j450tDxBZ6xgVARidTDUlRZ4p2xWVio8wD0qqJzbWwScM0wP
         kwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZDYZ2COIc8fumDu+/61CruxRRu/X6KafwRuh/aw4OAjwRQXobcUX4iPXMVEVL6Sk7/FuMTnqQSZB@lists.infradead.org
X-Gm-Message-State: AOJu0Yzy2JzQCclSeVsNN4/VsvHTAHqh+jFRLOCTrRLoJz8aMV2c1fq1
	eLvb4vdaIl0pVgB2Nf3ieObuEedA5pKZPuCqqBFmefOOfcTEI137XlUgBAVuMUE=
X-Google-Smtp-Source: AGHT+IFv8nLJb1rfbeFNnAcRwDciARx886dwuGgEoPRb3VHS1G5E9Sb7txw7Pj8IXgcazvLW80HH+A==
X-Received: by 2002:a05:6602:340a:b0:82a:a8af:626f with SMTP id ca18e2360f4ac-83b1c3b88e3mr1355346639f.2.1730296214052;
        Wed, 30 Oct 2024 06:50:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72781d02sm2831576173.135.2024.10.30.06.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:50:13 -0700 (PDT)
Message-ID: <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
Date: Wed, 30 Oct 2024 07:50:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
 hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
 <20241016201309.1090320-1-kbusch@meta.com>
 <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
 <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
Content-Language: en-US
In-Reply-To: <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_135017_716758_D7899E0A 
X-CRM114-Status: UNSURE (   8.58  )
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

On 10/30/24 7:47 AM, Jens Axboe wrote:
> On 10/30/24 7:38 AM, Kanchan Joshi wrote:
>> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
>>
>> Jens,
>> Please see if this can be picked.
>> Helps to reduce a dependency for io_uring metadata series.
> 
> Keith, is this queued in the nvme tree?

Doesn't look like it is, picked it up.

-- 
Jens Axboe


