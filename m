Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6198ACAC58E
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 07:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcMYUn+TNptTLlFhWnaY6U4bXh0X9SnLYkpEfFnsdG4=; b=Mo0/lG40NQDWUvx22t4qs2X/ny
	Hyi9N4X/R3vinNR3SfhZMZhb/uwTw4F+nNXIcu5eJTaYGgFY2cwVFaNhOMk9h4PApbkm00EiVQU8k
	Z/uCPR4nC/Z1vd1ZlptcnpEYi+mOXP2vrEalvYI+INHWpLxRyWWJeF5ZFW54MnY24cjHpYARecPsc
	fivtzEvAUMtMcJEyyfEfWsRoRbSKzzvJlyA1qiz4RsX+iIuzsbuMT4nOVB9+ja6TQgtBKU/s3KSps
	ebszCiv27KA8VgZf8j0ng9qBugFLQ8Z9V+2vGg0ydcyqM39UmfJNFdfD0Hw5ajjTKW0zjM6Sopj6v
	zMwY1dAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3yn-000000036zb-2Xz5;
	Mon, 15 Sep 2025 07:50:29 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3yi-000000036zC-0F0l
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 07:50:25 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso1889521b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Sep 2025 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757922623; x=1758527423; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcMYUn+TNptTLlFhWnaY6U4bXh0X9SnLYkpEfFnsdG4=;
        b=d0nAdWxkah0SidxfLU/I1R5rtHqQWp8nNBPLBwPWscAyZvQsNQyKiHQM3MfW0EAvOo
         TQGWrlWIzuHWI/5ahT3uX801r042+TrA/7UWTI+LQDYrK5+q2Dkk/VFu5lQILdwnY2Hd
         D1gKPRNRuALgrH74yh1r5hd1I2uEgdnfegaSSgr4b8Hgg3VC16XvGOdrHYPQhYcIVX8i
         r80fMPMAQ6oDmhKgt4lHWTzYm7tOQ8yzvaHJDncoZ8r0evFXmJU1t0oVXtj6K6bUSwML
         8PKXvws1TF3fajdF6E6chC6kuMzCvA2o/Mlmvxd35pr0q98TR9240N7Fr6QbPkpnT5wx
         jXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922623; x=1758527423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcMYUn+TNptTLlFhWnaY6U4bXh0X9SnLYkpEfFnsdG4=;
        b=J1SL2Q+NFLXa0KhrEBeiHQvU/Q6e8WcPxjYz4FOq4KSwl/ymUaiOmy2PntYtjASo+A
         O+2OtmvsPsLi35UdB+UrxXSgwG4VNOWM+XWFeoCRFhef5DRN6w6cfvWvgC9LFjGTTbQV
         HaFt4JFzoj7BmLUFNKSBr41laQD5njaCdUJZBoAu7QHpKtjUKZVob5Urzxr+4yqRwv8v
         tSgV4koRd7qLW31c8L3WeWs7JsJ9C+UY9SlIc7X3PT1h3/LNpRHDL7HsaqWAxH2Xfu+l
         P4vL6tsbQGotilVvExWY4sf/1eDaEy6Ob0zeg/FcEorCiQxWEXE0jMfwYrIRF2XaiOW8
         pw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGbVDYP4lB8Go9q3d62SIImAcekHAtigdwBtq5FMyXgwb3QLZPgU2H70VRXb3uE81q72uTSTqv3mEH@lists.infradead.org
X-Gm-Message-State: AOJu0YyY3vNVF6ZzcaCVUrMn21172nX1UZlDHJjUGAEMKi8dl1iu2vKx
	NT8dho0+9sKMuhtT+j4OqizWpvS7zX2oxkrV2zxFGZ2Nfqtx3vrcgliG
X-Gm-Gg: ASbGncu/TC3R8+dCr1yqbACEe5VHKU5bJbG/Ac4+i02MpYOiEjkRJfFKgwBlSsAVBHE
	FNp0sqSKooP9+zRNga63EsSBV4CJGrpOeKX1esfv+GnOZx8RD1ZATmvn1GDn1NESoBk0QxO3f9q
	rj41fWBj4XbLROnoWhnR6LBxHXZYIA+QbVwvvQpnSa+CZQY/aZ0+Ra0VaLmpHq42ZZQjn1mb68V
	mzRG1QtpTXN0SHRpZg9lnAEnd3G+emPnkpQk7BMYhrgk9NGDv0cNdbgtVHj/B1E13NkrIkPhS4J
	f77Nhvqi/xE0sUfBN1qFAUyoJKmA/PKV8GbypvXpgQ+LNg1WHNSma8MP7RiY/Y6iYl4c+A5tF+V
	SXvH9CxO8EShzzju8AFmy3yiG3ei/rwpn4XDoSXjE/yPDi3A3H6dln0tUaXjR2DFCQdnXJ78=
X-Google-Smtp-Source: AGHT+IHTVtvEPQ/WLcfDtdAFIsV0pStIbm5dUP0xXRfmxVxAtPMNXCVUzOVfpPLSg5MbeMeLt+S6Fw==
X-Received: by 2002:a05:6a00:21cb:b0:771:fbc3:f151 with SMTP id d2e1a72fcca58-77612163666mr14541329b3a.15.1757922622731;
        Mon, 15 Sep 2025 00:50:22 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c471dcsm12492926b3a.96.2025.09.15.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:50:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:50:18 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <aMfFOoQIIdMkVdYl@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
 <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
 <aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
 <20250914211243.74bdee2a@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914211243.74bdee2a@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_005024_106047_341396DD 
X-CRM114-Status: GOOD (  24.32  )
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

On Sun, Sep 14, 2025 at 09:12:43PM +0100, David Laight wrote:
> On Fri, 12 Sep 2025 00:38:20 +0800
> Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> ... 
> > Or I just realized that since different base64 tables only differ in the
> > last two characters, we could allocate a 256 entry reverse table inside
> > the base64 function and set the mapping for those two characters. That
> > way, users wouldn't need to pass in a reverse table. The downside is that
> > this would significantly increase the function's stack size.
> 
> How many different variants are there?

Currently there are 3 variants:
RFC 4648 (standard), RFC 4648 (base64url), and RFC 3501.
They use "+/", "-_", and "+," respectively for the last two characters.

> IIRC there are only are two common ones.
> (and it might not matter is the decoder accepted both sets since I'm
> pretty sure the issue is that '/' can't be used because it has already
> been treated as a separator.)
> 
> Since the code only has to handle in-kernel users - which presumably
> use a fixed table for each call site, they only need to pass in
> an identifier for the table.
> That would mean they can use the same identifier for encode and decode,
> and the tables themselves wouldn't be replicated and would be part of
> the implementation.
> 
So maybe we can define an enum in the header like this:

enum base64_variant {
    BASE64_STD,       /* RFC 4648 (standard) */ 
    BASE64_URLSAFE,   /* RFC 4648 (base64url) */ 
    BASE64_IMAP,      /* RFC 3501 */ 
};

Then the enum value can be passed as a parameter to base64_encode/decode,
and in base64.c we can define the tables and reverse tables like this:

static const char base64_tables[][64] = {
    [BASE64_STD] = "ABC...+/",
    [BASE64_URLSAFE] = "ABC...-_",
    [BASE64_IMAP] = "ABC...+,",
};

What do you think about this approach?

Regards,
Kuan-Wei


