Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42078C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZL+E3RNHbpFWOEVEZ+vdGqOh3AavrEOxiuPbcP0VN0=; b=du6l81xdZLcJEPfN4JFR82sLGB
	2ykBYR9XVsm0XCNUt0fNtlF9zvTOtWBkTFdtMUTGjqELeP8U3TeJXLdHVdfdziAHkvI+/wl3qJyFP
	Tz+9Y3uaIbz1tq8RtlancyoYwMJfRrAOC/PCyuWbJhuNjVFa3bqq8rFOUBITdq0+fAtJIr2gVoiDg
	PkawJoC6HFMxmZV9CkNldyo7tPMryqM8fSJimGO2SecSs3ykGJP1+zjZ7VU30bI+r3cGkUx1tlS4X
	2mOzdUjfDJJwQQzrdOHlX6tNsj3A8cD9aduCpPVN9dfimmPzz5KuSMRTEPeHmPYI6/0pasnciqTTo
	8lmunwlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z3L-0000000EaDe-3zpr;
	Thu, 24 Apr 2025 16:03:55 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vH0-0000000Dx00-2CZp
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:01:47 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso9165886d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745496105; x=1746100905; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZL+E3RNHbpFWOEVEZ+vdGqOh3AavrEOxiuPbcP0VN0=;
        b=R9pb96cysG40byYjk3HxMTh9xAGQqS8mv6w9+QvHOMOdl0Ua8+fR93zJSN6foR8VKN
         eaUqNdtZyYS6fcHq0UaIho/hEnA9Kvk4r6oJtZ9EAOqLnmFjPlP9RqkoxdiesoipidUp
         +c2U/CDrTiOnD9r6yYnPLgIAEtl9hB39f2jkyC2so09TB+SHavSMji/74uzLpCMm16vW
         f3A3g/87CZz9MzAkmeJgnVptGv+3TPaXXwlBkpcSl/BXBtkx6r0V1P8xf33EDfzwz/m8
         B8I3gevRAQODZ+BINPg1yOpX11IVQBkxxDCqfl6vC3Owxvz/Hs3bex07m2UdwUUJISiJ
         E1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496105; x=1746100905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZL+E3RNHbpFWOEVEZ+vdGqOh3AavrEOxiuPbcP0VN0=;
        b=Qs23fgXCGnELDjRhJ+noiq85kh9s4HBgvzxiqlivBIhD9eqmpi3R+bDD5C6v0SAfxy
         PezVKrotMlmrn2MMsVFj4YQU++TVyGg34323pap8aAU2wdZHQQW6urmc/dP5wUgKDE2t
         Mxcx4AZwW9HOeG0S5rxWrJhEX4/Gg60c9fZGVuOz4gsQOB5XBIhkLCQ2Iu6UAy1eV8Be
         QxotNQkHiQFKdTZD4JLoAY3tJpByKsODC2eMcwvYZjv093TcIQCIvgpjqOF4nheX+jIf
         R0Gt3OUjC5+5UeFpVkem0KNiFmkGnMpFRvzyzkBX5037XBDGujewWwMS1cbYUcFOgU2N
         G3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVmEzqftY961qk0dkBhAcnE3J/2xipenqcVjY2LoXV/AWoyNJproIOpbnCCqHxvaL9EQLncMWr8OP58@lists.infradead.org
X-Gm-Message-State: AOJu0Yxg4eaQoof3QhWJyJGcuj2YD4wph5cBcFKSOVjn75JZk1YK7IUO
	VzN7YCcm4AH/ssPcs+YWkdFERf1UZlm4ZJFSG90Vwp54R3kd6/n2QHOk5AbkjOQ=
X-Gm-Gg: ASbGncuSsLWP5i5SYb5P08nm/UR3qUT2lNQ21Z8o0+glK83OTjJ8DWLBM7YJqJCHhjy
	+LriPGW156KMs6RbBg9lXB8Wkc8chy/djkrv5JTQgOVacR2bm7VnBJ6rrxDOIMULXi41Q3h0EZL
	17gMSv9bnqjHa19Dhwoo6wZkUZrU0TufVa8QsJdWhEl/YhxEyTBm/LQHUtGYpD0RZ6XyW7vmR7Z
	i8hDwJU3LbWQ4OZpwvW3iqNcZ+tHzwTCtUpkAw0xcl3a6n9f+9Kdvzol3rswdzes4HlnxuZnoEp
	Gd+1e7yAlZLwdK39H96h3hnEeGgnGBVZxOfkSmgDpV/T9E1KWSZXjad17+bpPqXoGMBPZznRAtr
	ed2NC7WIjF+K9eUO/9uU=
X-Google-Smtp-Source: AGHT+IExjEYw2YciNBoIdkd9/pqHrN50d+y5G+B8wJfJbAXK4p9NBvT5uybfEubjkC+mcuj7maAkHA==
X-Received: by 2002:a05:6214:d02:b0:6f2:d260:b2f4 with SMTP id 6a1803df08f44-6f4bfc95a23mr43959916d6.37.1745496104857;
        Thu, 24 Apr 2025 05:01:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c093870bsm8528646d6.45.2025.04.24.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:01:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7vGx-00000007T99-2aD0;
	Thu, 24 Apr 2025 09:01:43 -0300
Date: Thu, 24 Apr 2025 09:01:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250424120143.GX1213339@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_050146_671079_FA4BAB92 
X-CRM114-Status: GOOD (  18.68  )
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

On Wed, Apr 23, 2025 at 10:35:06PM -0700, jane.chu@oracle.com wrote:
> 
> On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
> > > The flow of a single test run:
> > >    1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
> > > and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
> > >    2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
> > > reserved virtual address space sequentially to form a continual VA
> > > space
> > Like is there any chance that each of these 61440 VMA's is a single
> > 2MB folio from device-dax, or could it be?
> > 
> > IIRC device-dax does could not use folios until 6.15 so I'm assuming
> > it is not folios even if it is a pmd mapping?
> 
> I just ran the mr registration stress test in 6.15-rc3, much better!
> 
> What's changed?  is it folio for device-dax?  none of the code in
> ib_umem_get() has changed though, it still loops through 'npages' doing

I don't know, it is kind of strange that it changed. If device-dax is
now using folios then it does change the access pattern to the struct
page array somewhat, especially it moves all the writes to the head
page of the 2MB section which maybe impacts the the caching?

Jason

