Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209FCAC587
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Sep 2025 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NOD2tP/vP2x3pAfsfoPV8AWujNxWo1YU4mET3dIG8zk=; b=YliD3JqLSYMtdgBKkcUFTi+HsT
	opvqJ9cPEWSWYB6bsq4q9Ea38WwhPdiBMUO5LQxe2d9YNMVw2sal/ZjjNZMPqu2TkI/oSW6ySRn5M
	b6vgztOZ8YbHzm3uuf2Y8o95gOhASOqTtaedpBgi7VfYhBPIzBjF24WnUd/Ovk0Dh2L7QOOuetpDm
	hPHSZi4hNy2ke6ZDZGihY3cHxEquPgz/rUGgz0MaEW/16Acvli92xOkErlqxoP4goLe5KvN4m4e5t
	gOUte7M72xaw+faETag99lhbnJ+Q/4l/mH9+4dveTgfpLfWrgdMHy1oKiguffK0Ht7YW/uHCXYNzP
	xFt1IIYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxt5d-000000027aI-3z3D;
	Sun, 14 Sep 2025 20:12:49 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxt5b-000000027Zn-1hwS
	for linux-nvme@lists.infradead.org;
	Sun, 14 Sep 2025 20:12:48 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso27187465e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 14 Sep 2025 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757880765; x=1758485565; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOD2tP/vP2x3pAfsfoPV8AWujNxWo1YU4mET3dIG8zk=;
        b=O7D3ciXLlkBEvQqmHDOZqtj55JhqG1/41T2kY3I/5t59CFT0/Ij3k9kJUhtbL2twEU
         gWgvphIi5NQ1CaoI4zIPZLw3Vd1ejM6Z+dHK7UubnD+pQygP9awm6LS2cDwzRKfjWATy
         Drgd0K2BwekCULLYI0sh+6UrL2dTX1j3ltdu6aS8HBzQNHSRMr59eeOh2Rm9sbO/qwjC
         DLb7sP7ED3TYW4IWBkQuV6tVN3LO2SYmPBOhDe4RvtmjYwb+VXvbRaTrmiCRQszGb9sy
         6m8UaSgZVvbnEvPVuPsgTWMG0q/QUThqz3pfZV+2VaaJXz6PpILjfXceSDViwge0VzdE
         xz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757880765; x=1758485565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOD2tP/vP2x3pAfsfoPV8AWujNxWo1YU4mET3dIG8zk=;
        b=Q2+cSEI4S/e3c6Sdbuk4ZRrWxdUFpaqbfyUT+Yf73BbGCsM2TIqzBRnjxtPJnPbX50
         5LBGK8wxXQ00BG9PUaH7jSaep4J61Hke8ZqzPouhNGdMzLd/HFxG/Wnwo7jQizR8+EgB
         BAlBAYTcZO9jWZRaCdn/FihsaomYJo8LOfhAp0RiBAhiW+SaUa4+pCYild1J4ouzOWgI
         UtcVsiFDblVdD1AhqhBDBVuPdItmtD1ZLZjY2+qMKaDilEc+LnKyMpFpiBE7hemNeJpH
         hYtyFMCRFGS1CbQVZzIDOGBnN7uB93n9Fel5ysbpvfQ52MAzDpsc0UjUgp84jlz9ULZ/
         DMdg==
X-Forwarded-Encrypted: i=1; AJvYcCVWhBnYdLRM8coiTnx272+EvieZai64SDzB9i7EjNkY9peHdxdvTr4h5VnUIAoDjxrHHNRRZfEEi3G1@lists.infradead.org
X-Gm-Message-State: AOJu0Yyl468NqNoxOgUDFFA6wiIMbarYMG/po1/p3+wsUrISHEjpJu2U
	RgB1eY4DZ/ZvscAMxqdo6tUlvsZ3tLj8Vch/WMoxvtdpu7olnOg8rlvL
X-Gm-Gg: ASbGncsu5XN5m1myNIgshTelMR9PtytMhOESy8d/Uy99uDFk0FjqMBBoVA9mCQXG7lI
	RP1qtuQ/Fmhi+KNj/SwfuUekNNJbL6dZyxC32A88epF5Hj2+aIMJwYmHGNKt40tgQfMGH1QiUx3
	7HjCD8C0X/P40gUX+86IPVXYAdNIY4jQpRYNplp5AzS+w3R8JYVAvhMVCflt2+gN2O73hT5azzo
	4jco8ZkRrh9y4CN8TMclHuiDqh1Cxqw9ExRYcFY3Y9Ep0Dr6uYUpAWfgkdgbzTG6xDIm13ffG/R
	HnzRaXN/N8X9PyekTrNRw5LFHMOB/kceX8L8CTLGkCMS78JfJ1sHRB+KwEw+RYQCT4j69dOxCd2
	+YoiMc3AgVUGd3i+kFT1WkiJTXz1LZgGAhqq6nqF+K5pbhVdS0/YJq3ya5fvsvnM6T4i//7Y=
X-Google-Smtp-Source: AGHT+IF07rnJES394otwTHwQbpN7fZiWm34So3i+hi8c629sbgG+ujHq7Z2rRTWlSTbUV7JHiRGVaQ==
X-Received: by 2002:a7b:ce91:0:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45f211cb910mr79757535e9.5.1757880764849;
        Sun, 14 Sep 2025 13:12:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea9abd7234sm1688593f8f.59.2025.09.14.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 13:12:44 -0700 (PDT)
Date: Sun, 14 Sep 2025 21:12:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250914211243.74bdee2a@pumpkin>
In-Reply-To: <aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
	<20250911073204.574742-1-409411716@gms.tku.edu.tw>
	<CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
	<aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
	<aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_131247_483865_C6E6F996 
X-CRM114-Status: GOOD (  13.04  )
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

On Fri, 12 Sep 2025 00:38:20 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

... 
> Or I just realized that since different base64 tables only differ in the
> last two characters, we could allocate a 256 entry reverse table inside
> the base64 function and set the mapping for those two characters. That
> way, users wouldn't need to pass in a reverse table. The downside is that
> this would significantly increase the function's stack size.

How many different variants are there?
IIRC there are only are two common ones.
(and it might not matter is the decoder accepted both sets since I'm
pretty sure the issue is that '/' can't be used because it has already
been treated as a separator.)

Since the code only has to handle in-kernel users - which presumably
use a fixed table for each call site, they only need to pass in
an identifier for the table.
That would mean they can use the same identifier for encode and decode,
and the tables themselves wouldn't be replicated and would be part of
the implementation.

	David

