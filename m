Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6340606A321
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wgc7FRI9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHDRkzyt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NSdHvJ1c4zpPbn3GmTZcrFFhDVtyN2FOhraiFJ68E5o=; b=wgc7FRI9h+t/jL
	ng0VU8UrTzOPOsdbK9HvcxJf0al4ZTwA5KbmKCgKqjML2NSfpFHturerC/FzHh1ViVMi1qqtOm7Ft
	4WRfVgB7MLDQ6NXQuasNb+PV9oBlZLqM8PeuazA/LQKsjKD0N88PhqlvWOm0Hj3BWyzXnOwWJW/70
	pS2e4tIVXwbjho5K5wpQ2x5FIEwmc4vyTJaF5TsoVL4xw/zQZF7+5bmhxprLWsmt/n0ZmUNf9fmov
	wG+tB1uwZzej6E1xgEUBm7XdmZE1BpHUtPpkCBwBVBmcdq2ftpoqtQb0FXAvHZE2ehKuG2+GgP0Dn
	9hJsZgo8l6W4tRZZ2Diw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRpvN-0000000CbYV-2KiE;
	Fri, 13 Nov 2026 11:58:33 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRpvI-0000000CbXJ-2q3Z
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 11:58:32 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so6226965e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571107; x=1795175907; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSdHvJ1c4zpPbn3GmTZcrFFhDVtyN2FOhraiFJ68E5o=;
        b=LHDRkzytG1fqWOgL4WpEf45/SuVz/xVdx4pnUKm3VlxhRP5s2UCaH+ycvh+Ux7B490
         1i020p/FxMnGuaSsWgE/V3yYcFobZmlYV/uweeZSfUsUGNOajrSAD6WN77FCrjp++RYc
         34H9Fs0LgsnGdJyuEKHIq4RvmHtYve0kG6tOYgYe5zMcMCAq3LqjbDVYnXFL6B9EWpFk
         I1hWgJICBWbMjDh5zxxIWX1dg7snNWFXJfg+A6IzNmiUB208L9F32H46VIsZVrDNzk7O
         7xMOYX3jjrc8n1s25g1AdlBkGZtgbTCxQSkEqL7lQl/4tlQihIAzMU7Uk0z3HDPYFDbK
         vEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571107; x=1795175907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSdHvJ1c4zpPbn3GmTZcrFFhDVtyN2FOhraiFJ68E5o=;
        b=Zas//uMuAMcb191jolB0DV7t3M4QyMRJG9ET28kxi3KXV3KiPgNxn3gQbgZwNYZvLM
         tkN5LhD3oQMULYwil4tcsMD1iYGIr+CMbUogBqh7rr2DhORrIcwQar9lBRN5fwGLIm7W
         QQFO5fUUVOV+Z7Wst+qZVSEXsfJuV3VwsLXwMFPqLqPEGaiHfErKahlWHaRkLmmVyMKN
         fefyFk7XMRh8gcrk99dyC+7pO4tFP+PUA7CkAqn9va3748ApN3wqro/RnUC3SeCV/ies
         pKXb0YPej4/Q9VluHglUIoHU1sUd0SFTLZLlVaepm2J8o9fmGjLqZpqCw4GRsSlsyOma
         I0lg==
X-Forwarded-Encrypted: i=1; AL+hErF7aeFZqlkbDuRBLfU5ZRdUsz4QPMNPxxHyi4B5+zfzxbAYns0o5vLoOOt7lQyCXOatHZBo/u3TkmHr@lists.infradead.org
X-Gm-Message-State: APuU4Z+WdKxJB+ihnXKiet5Nj8uSN9V2lI/y6pF3CJ+VCq6pAZXErWEI
	6sB6cD1EawSbZCrRuCYKRqNSVGdr3gC4Q4uRJjJRIPKiXxql/nXzorMR
X-Gm-Gg: AYBFou0NSQHGW+66m5TRlxfF9sg+G0r3xhDvmJVhuxs+3wmzDAeJ2xdiBQg9DWaWtUP
	KOxaBAotjfJhk0FuzjIkHuv1gq8MVisRhtt0WNYqjphCjL3r/rgZ4ZI21OFfkupqp136KFl9eJU
	ENchwImnToQADhfOYvtHz/Ba4sWiPY4Vzvo5wWKrbo8yJ3BBrsrVJkM2rOvl4sUR/LU0I6ksDfY
	Dw7ZXS/WEWrD0PaUjBnKx4YzR883EsAEA7YF0cP0Y+Pgc+xsKvv87W5JnGsQY3It/V24yTwAHvp
	fWwyGNN6E/moQUoF42KEm17OCu9G0DpP58NjJcLsv5VyeeY17UxCdkFqoqAC7N3mH6ha8iyAKxl
	MQTZCztlDKlcFI2ntRTZQz7u0aUx18MlYbo6t0N7AGxkNDKbGGAs6QfFPBqrysjIMavqynBGdB8
	fQgGUXfexyxr9OWSrX1B9qqjaxEy5daH8leMPSOqaL+OMIUGQ3NZoB+l3TnWAl4Gg5Xzwu7V7mH
	7YBG0BoTPR3b3uMaDtCoePyl6q4avhWpWbv6GPMutpyIAlWigfr4sy6cGXyPDKZpVD1I5+050BZ
	QEPIrICkiu1Vx6B8iLE0SOxs2g59OWZnoGTqmCkHfy1TVTikYvMUXuO/1IDb6p0UIt8=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr44030125e9.33.1794571106573;
        Fri, 13 Nov 2026 03:58:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm252917195e9.1.2026.11.13.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:58:26 -0800 (PST)
Date: Fri, 13 Nov 2026 11:58:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
 <hare@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Martin Belanger <martin.belanger@dell.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS
 record type
Message-ID: <20261113115824.2f96b66b@pumpkin>
In-Reply-To: <bc96a186-5a19-4896-8465-ccd1df5a33bf@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
	<20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
	<20261112223707.3bf1e1a6@pumpkin>
	<bc96a186-5a19-4896-8465-ccd1df5a33bf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_035828_738655_625C5538 
X-CRM114-Status: GOOD (  21.39  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 06:34:06 -0500
Martin Belanger <martin.nvme.dev@gmail.com> wrote:

> On 11/12/26 17:37, David Laight wrote:
> > Is that right?
> > You are changing something that was CMSG_LEN(1) to one of CMSG_SPACE(1).
> >
> > I've a feeling it would be right if it was a struct, not a union.  
> 
> I think the union is right. buf[] covers the whole control message:
> the header, the data and the padding. CMSG_SPACE(1) already includes
> sizeof(struct cmsghdr). The cmsghdr member only gives the buffer its
> alignment. With a struct, the header would be counted twice.
> 
> On x86_64, CMSG_LEN(1) is 17 and CMSG_SPACE(1) is 24. The union is 24
> bytes with 8-byte alignment. put_cmsg() writes CMSG_LEN(1) bytes and
> sets cmsg_len to 17, as before. It then advances msg_control by
> min(CMSG_SPACE(1), msg_controllen), so CMSG_SPACE() is the size it
> expects.

Ok, you are changing the size - which is what I noticed.
In this case it makes the on-stack buffer 4 bytes bigger - which
probably doesn't matter.

I'm sort of surprised it is 8 byte aligned.
Historically it would have been 4 byte aligned, and the kernel still
has to handle requests from 32 bit apps where I'm pretty sure the buffer
will only be 4 byte aligned.
But I've not checked and it isn't really relevant here.

David


