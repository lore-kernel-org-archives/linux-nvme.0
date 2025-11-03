Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B72CCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UC87VmjlqhE8ixV0hmOfrgnisqW5ZkS1j7Z41QROyHU=; b=FK2TxXe2IBFRynef80pDaufKbe
	1oIiM110PKEmrxvgIXAQIFll4i5ZhTACbjxR30MZkHV4liI7Vmomj0/b7Qcl17Xvw4NW1LMBbj104
	bQfpx+Pkh3pR914m3o1eUvYgv4AV3dXdRIy8dQWI6UTvbrchnoOPLgRrrS1w20XCKHBzPMqEI5bbQ
	yHlLZVOq8RjeqBonssTlQFEhF4V1xRvtRTGwHn31AOjFsFO5kexPby7PAvbWnAYN4E3i8vNUqStMt
	anDwHsd9gzaSKFMpBeLmVHvvFSF9I/lHXvKcI0Cz26BHu9FdbWSD7BGJdGD/tJqtNqLWJ6901DqGa
	POsWbBAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG36j-0000000AiPG-3dSW;
	Mon, 03 Nov 2025 22:33:01 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG36h-0000000AiOm-30fd
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 22:33:00 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-475dae5d473so870855e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Nov 2025 14:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762209178; x=1762813978; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC87VmjlqhE8ixV0hmOfrgnisqW5ZkS1j7Z41QROyHU=;
        b=PagSX582auS6L5BtHeb0wMSVQXBGq9F3qTqSLiFasa6NQnv8VEnc8ntEKe4al4mFxp
         DyZWyNomJGUvperctol1rjCwVsCD9qs9OSXW4/672MR0RgoEx4YC5kwN7FMVEMy3dLwD
         1GsX1rvkzu3kUOaGt1oUNcfixl+gaIbW7HpEf7PtHHdiPt0XrGYHpxAtOS2NGTsen6oa
         +MgSdXgQ7WY2taqVD+Es+c6cDAGEwzvbbJN5RyV6PxzHZpqp3AQNDfcmvkB6jXmK6MNp
         +AUXf3rUaF26yca34wAKrbCDOB+5xtTCJzxFhRsUjhW3Vc1LhW1SIuCpXJrr5iCHI+Ak
         4mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762209178; x=1762813978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC87VmjlqhE8ixV0hmOfrgnisqW5ZkS1j7Z41QROyHU=;
        b=d5qSWo0AcBNZ734oroVIa8q8cKVwCKuC6y/yXAGxUfpD4OhPlHsfoDE0owHSQPWO3s
         lCvov+/UpRl/lsmG8Gc9iIDKJVYQlkgkL3bu/6ers2AdEfSDJArE6uwPkGOTP3uiU0i2
         kETAnadAmqmSuOawGCKnAkeawT+RVL3G838ByhnGKaF5IMLvhSemOBo+rixKMhpfIEbY
         vPpc3c/+S9qfI27i4CyEscr2l2zRmsEx8lJaJmJJXGxPCRqkp/I6WvX4gi+bgFuZhJqz
         L0FDHRTyQR8vJF1owsZepcnT9RYe/CqgAqxtCpqrNib2gP5uf60/JiVU6oHxsPEQAntY
         K25w==
X-Forwarded-Encrypted: i=1; AJvYcCX1aae0kbNvTXwIEWCu7DXAU99lwmkzH5ciqF1XpJx5mw4B9UliwWNiAXq43eG48XL9FJJnTZyKUiBY@lists.infradead.org
X-Gm-Message-State: AOJu0YyTsL0lPWKDaV0QaIeOs5xH0jcaYCn0lY2/0aepakc3tmON17NS
	6A6dndKpcsbSbQgn29ftda6ntoybtGUWSmK53Pm6WDO05wqXrIiCx1jB
X-Gm-Gg: ASbGncsRkgvOSjLpSrdB1hxk4LkODlDQBkb4oIrAryynmpiLkTo6MoeTkG7VoPWgxf9
	WJtKj6xlqbmkiuukyvsWpWN4msr0SjQBv5L19AuSLIos5NMKlir1blowEYY+1CoRuL3KjIaRPrV
	oktVcc1Pp7wFNYX+NlvA1jVQE02FrXGmkormnBjmccmxS06P35PpgFZ2ZHCCCu/g7QRLUAABAgG
	DuONpZGJwXsvFfjqNdf73/Xkd3WrvI1Q9cBwmYiHCD8loztiF0M8aCS+3t654zbv34f083SlMr3
	/Wg5H98/C5OfbWuyx8XXPKCpMmXltEe9L4sdKDKKezNN6CHC6iwLvIJkFz6gq5ocMJxo6MeCnUg
	4dPNVAVK8pbXlwbWkGUNXsaKqXQ04VQdD7zw2OoB6hwQ+xyRp4dAqm7tgn3vcaqNzskAuKx5EKj
	6VjJeZQRJFCXzfJMrdR+piYuuLAYP6Kr3NhLvfkR4XJg==
X-Google-Smtp-Source: AGHT+IFfkjzMjTqHnS48aZjcHtd5R1GU/wOXp/DRSahKGZnuUsfaydy8LykadRRj1SHbjISGDLOeSg==
X-Received: by 2002:a5d:5f95:0:b0:429:b7cd:47ff with SMTP id ffacd0b85a97d-429bd6a8e04mr12790816f8f.40.1762209177618;
        Mon, 03 Nov 2025 14:32:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1a8528sm1151043f8f.21.2025.11.03.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 14:32:57 -0800 (PST)
Date: Mon, 3 Nov 2025 22:32:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Andrew Morton <akpm@linux-foundation.org>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <20251103223255.3de9f9d7@pumpkin>
In-Reply-To: <aQkEbZrabOzPBClg@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
	<20251103132213.5feb4586@pumpkin>
	<aQi_JHjSi46uUcjB@smile.fi.intel.com>
	<aQjxjlJvLnx_zRx8@smile.fi.intel.com>
	<20251103192908.1d716a7b@pumpkin>
	<aQkEbZrabOzPBClg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_143259_799631_FA393CBA 
X-CRM114-Status: GOOD (  39.09  )
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

On Mon, 3 Nov 2025 21:37:17 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 03, 2025 at 07:29:08PM +0000, David Laight wrote:
> > On Mon, 3 Nov 2025 20:16:46 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Mon, Nov 03, 2025 at 04:41:41PM +0200, Andy Shevchenko wrote:  
> > > > On Mon, Nov 03, 2025 at 01:22:13PM +0000, David Laight wrote:    
> 
> ...
> 
> > > > Pragma will be hated.  
> > 
> > They have been used in a few other places.
> > and to disable more 'useful' warnings.  
> 
> You can go with pragma, but even though it just hides the potential issues.
> Not my choice.

In this case you really want the version that has '[ 0 .. 255 ] = -1,',
everything else is unreadable and difficult to easily verify.

> 
> > > > I believe there is a better way to do what you want. Let me cook a PoC.    
> > > 
> > > I tried locally several approaches and the best I can come up with is the pre-generated
> > > (via Python script) pieces of C code that we can copy'n'paste instead of that shortened
> > > form. So basically having a full 256 tables in the code is my suggestion to fix the build
> > > issue. Alternatively we can generate that at run-time (on the first run) in
> > > the similar way how prime_numbers.c does. The downside of such an approach is loosing
> > > the const specifier, which I consider kinda important.
> > > 
> > > Btw, in the future here might be also the side-channel attack concerns appear, which would
> > > require to reconsider the whole algo to get it constant-time execution.  
> > 
> > The array lookup version is 'reasonably' time constant.  
> 
> The array doesn't fit the cacheline.

Ignoring all the error characters it is 2 (64 byte) cache lines (if aligned
on a 32 byte boundary).
They'll both be resident for any sane input, I doubt an attacker can determine
when the second one is loaded.
In any case you can load both at the start just to make sure.

> 
> > One option is to offset all the array entries by 1 and subtract 1 after reading the entry.  
> 
> Yes, I was thinking of it, but found a bit weird.
> 
> > That means that the 'error' characters have zero in the array (not -1).
> > At least the compiler won't error that!
> > The extra 'subtract 1' is probably just measurable.  
> 
> > But I'd consider raising a bug on gcc :-)  
> 
> And clang? :-)

clang is probably easier to get fixed.
The warning can be disabled for 'old' compilers - only one build 'tool'
needs to detect errors.

One solution is to disable the warnings in the compilers, but get sparse
(which I think is easier to change?) to do a sane check that allows
the entire array to default to non-zero while still checking for
other errors.

> > One of the uses of ranged designated initialisers for arrays is to change the
> > default value - as been done here.
> > It shouldn't cause a warning.  
> 
> This is prone to mistakes when it's not the default rewrite. I fixed already
> twice such an issue in drivers/hid in the past few months.

I was thinking that if the first initialiser is [ low ... high ] = value
then it should be valid to change any value.
I'm not sure what you fixed, clearly [ 4 ] = 5, [ 4 ] = 6, is an error,
but it might be sane to allow any update of a 'range' initialiser.

	David


