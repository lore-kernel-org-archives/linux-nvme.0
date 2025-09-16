Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D95CAC598
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 07:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Spk+L+URf4FDnPrwupmkOtAzkHXeSWum03yPbQAWrZA=; b=3Rqs5IsqCSepCez3N5FTGOy+/H
	5FbY71iicz9LXbQrYFSk/32N/H8rkIBHTo4h3eGFKtaunpIa//SkgbgvozXM2g2uvGXwwLZfRf18F
	mItWXZgNnmzVRqlEHptj6UbL7/NTSXRqU1pSsIaBVr2+SutwM2LwX2jQnJ0NVnQ7V40fB8lQXfkje
	WWxX7YJgKngP6BPsMK3rsOQxjL5ECNXNTSNLdX2GCdDmeytt9eN0tpv5lsUFueU6leSC2mgBPAuOC
	3Ms94rp7e43y49JEthP0rBWxuqedcTvG4b+DFV2ZV586QNbaXN1GJ7aSfyKIbdnfKHd21PyIWoVbF
	Y/XgtuAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyQ1h-0000000702x-0MI0;
	Tue, 16 Sep 2025 07:22:57 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyQ1e-00000007026-0DEa
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 07:22:55 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b5241e51764so3805758a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 Sep 2025 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758007373; x=1758612173; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Spk+L+URf4FDnPrwupmkOtAzkHXeSWum03yPbQAWrZA=;
        b=BQdasFmIMGKCj2V4Yx6gyVDeH1XJ6zZCL9yp4lgpNEAfU+riSLQUDEGp8eMFnCJXNF
         aBIH8IyLNnDdUK+Te+RRekmyzAcQPxREHLN6GsAawlJBOIz3VJjkEI10CBDMammnsx7s
         9bG+UULkot36b51cWFI4arHbzVd1ypmHJnaLJyy6ad3Ml8dc4XAVuVQg+Zt/QI8qL5KJ
         6LfjqiSf9OGU15DTN86jaeQUQDE9usmStzEctsfHCUuaMqAIbfeDp1RKgG2Orvk1qX+V
         8wzIeTQBsxyUyGjV+vKx9T5nIptsGufU1Q821WTJ2vK1s/+u+erZfY5Xa0PRZkCpztF9
         wmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007373; x=1758612173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Spk+L+URf4FDnPrwupmkOtAzkHXeSWum03yPbQAWrZA=;
        b=gvHnyPaSoDAh353gZI8L2AfNgv8syWHgIA7+WvlaM6LydbvA9K8Kz25xJBkqbwegjW
         n2Iw05L/f6+noSetmDfjrRSvRN1i3K6nabIrtywvSRt0lGC2QPFMecQ125cim1WbRaGy
         mQMz9exGeXt4iCGYtqA9pJGzXK5p0Okt/fLw76Z2zydR8L+ax0NxJ4+dGdQdWpqJE3Vj
         ZvKYktgSHWYGg/L0DfwS+4T2BkmVB+aoEdIO5ie6tYpeAOBHhhML4M+0mAK6llqKIjtR
         hhZspJeOcFGg0LffdF9ar7wmfBgJ+n9gr9nPWQAIYxJnytdX7WJkYc8lglbrQBqPQuLZ
         eEYg==
X-Forwarded-Encrypted: i=1; AJvYcCVT40vZhilHP1CIXSq3Iud2oRzywlUJ616RQfsFMOaovg/eXyjD8aVDZoimTG1TMqkv3E9k26rk0S1W@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0pAjOHj06dmXzjlP/r7VmXVpJn6nDVGYexi2SFnB9C58CiDzt
	+x5VB9SqGFi4yS2nrHPwmShJbDM11/6V2pc8WQZ4zLenVKB8GavUgnXN
X-Gm-Gg: ASbGnctTWYVrBO+gYtJ3wQwYzPugxMpYyWhlT1yGqz/gSYgNC7/rL6v9d7USaP0NFXQ
	NK61jqVU592yWLP8vVgMxq8JtjXAQdRF9NADkX7MTtEgF2NZzFsM7pX8QDFUYlyKjINAUkFFyO6
	j6SHejeQhzapzqL4AWQASIojxA6IJDTRh06jte322tpH7EKoBCUKUL6H7EmZrWo6MAsqrEW4Rp/
	MYXlOs0BCsnNJGdFRYrzNnMkUoQ1sS77tjLfNSc5V+pcpXvzNs0jhZhpjxSDGPe2zUj0/yajYgK
	wXPIhF5KmG+fcdvmLLhWDVlFTshYBNLysGX6alYjNwgx0XSSdh04vxui7wOn10lzCmqBGMZa3tT
	dIaeJy6ASedrxkzjH8cGqeXhSNwvNmwHhu1okJ62fTcZeDwMg0gLfV+Z/7CqD
X-Google-Smtp-Source: AGHT+IE+ovHzdEZ0Rb3pICHfqDJkMW30WK0/jUJIjArPYj7OENVv548+kflQE35w1soKYEhXuKbDjQ==
X-Received: by 2002:a17:902:f606:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-2648a8da599mr101953445ad.59.1758007373082;
        Tue, 16 Sep 2025 00:22:53 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265e18ea009sm55155295ad.74.2025.09.16.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:22:52 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:22:48 +0800
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
Message-ID: <aMkQSIw4eHoDAED/@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
 <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
 <aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
 <20250914211243.74bdee2a@pumpkin>
 <aMfFOoQIIdMkVdYl@visitorckw-System-Product-Name>
 <20250915120220.6bab7941@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915120220.6bab7941@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_002254_436730_771EF95F 
X-CRM114-Status: GOOD (  39.34  )
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

On Mon, Sep 15, 2025 at 12:02:20PM +0100, David Laight wrote:
> On Mon, 15 Sep 2025 15:50:18 +0800
> Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > On Sun, Sep 14, 2025 at 09:12:43PM +0100, David Laight wrote:
> > > On Fri, 12 Sep 2025 00:38:20 +0800
> > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > > 
> > > ...   
> > > > Or I just realized that since different base64 tables only differ in the
> > > > last two characters, we could allocate a 256 entry reverse table inside
> > > > the base64 function and set the mapping for those two characters. That
> > > > way, users wouldn't need to pass in a reverse table. The downside is that
> > > > this would significantly increase the function's stack size.  
> > > 
> > > How many different variants are there?  
> > 
> > Currently there are 3 variants:
> > RFC 4648 (standard), RFC 4648 (base64url), and RFC 3501.
> > They use "+/", "-_", and "+," respectively for the last two characters.
> 
> So always decoding "+-" to 62 and "/_," to 63 would just miss a few error
> cases - which may not matter.
> 
> > 
> > > IIRC there are only are two common ones.
> > > (and it might not matter is the decoder accepted both sets since I'm
> > > pretty sure the issue is that '/' can't be used because it has already
> > > been treated as a separator.)
> > > 
> > > Since the code only has to handle in-kernel users - which presumably
> > > use a fixed table for each call site, they only need to pass in
> > > an identifier for the table.
> > > That would mean they can use the same identifier for encode and decode,
> > > and the tables themselves wouldn't be replicated and would be part of
> > > the implementation.
> > >   
> > So maybe we can define an enum in the header like this:
> > 
> > enum base64_variant {
> >     BASE64_STD,       /* RFC 4648 (standard) */ 
> >     BASE64_URLSAFE,   /* RFC 4648 (base64url) */ 
> >     BASE64_IMAP,      /* RFC 3501 */ 
> > };
> > 
> > Then the enum value can be passed as a parameter to base64_encode/decode,
> > and in base64.c we can define the tables and reverse tables like this:
> > 
> > static const char base64_tables[][64] = {
> >     [BASE64_STD] = "ABC...+/",
> >     [BASE64_URLSAFE] = "ABC...-_",
> >     [BASE64_IMAP] = "ABC...+,",
> > };
> > 
> > What do you think about this approach?
> 
> That is the sort of thing I was thinking about.
> 
> It even lets you change the implementation without changing the callers.
> For instance BASE64_STD could actually be a pointer to an incomplete
> struct that contains the lookup tables.
> 
> Initialising the decode table is going to be a PITA.
> You probably want 'signed char' with -1 for the invalid characters.
> Then if any of the four characters for a 24bit output are invalid
> the 24bit value will be negative.
> 
Thanks for the feedback.
so for the next version of the patch, I plan to use a 3×64 encode
table and a 3×256 reverse table.
Does this approach sound good to everyone?

Regards,
Kuan-Wei


