Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F08C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7dO4+855NDGBLOtYg+g5EbkrB6jsqmlhFGAdJvf5Qo=; b=r0I60oAJ8REF8y746EQqW7is8K
	KYPRhEjVdeZecJcbC6QdAFysq6i+LiNodqjjULH3jTRmPa68gvvInn+g0/V5ChvxoVf3gLghMcp4v
	00dYZORU/vC3ZcNWi0GSWC4wmhk5ngU5NMgs4I4Sf4bUFsg5QaQvx3XgvWDJ3kjSHISzPaCUmiwRW
	4/K+g9XHX2v2503Tgz8zsg1nrkvH0VbjpaC7zSmfnEgHJUmStxLTjCtSDIH7oq8Z/6Ex7t6bPGIyE
	spT9pEh6ad43baDdA1TKUmVyVU6zVcxD2ONW8QcD73Nevuhcc0rdO4MmgwVpjh52/YSVV4Kbt7mFd
	K5yfjmoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNqU-0000000AQ4O-050n;
	Mon, 13 Jul 2026 21:05:46 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNqR-0000000AQ3x-089e
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 21:05:44 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cca0c5799eso3116465ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2026 14:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783976742; x=1784581542;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7dO4+855NDGBLOtYg+g5EbkrB6jsqmlhFGAdJvf5Qo=;
        b=lCF57nUNGfA3lfHyAC+WnrY+1hZCb9xDoMT4gBxLk4gvxHcpCK/ExYQtzXWTTRZs/N
         6r/EuRm8tslOPnGNkVftvoH5JGDOLFGi0vKVNLHnKFOnvtiva1yP29V4wua5yeLnth45
         E/hmuZ3MZHoTVrGX8jnJolUFLz7Wgj5ppaJPXhfdFs/1Hq03F1ufnJmjOlaJZWDN3eDm
         i61PbTFMqQUMpw5GNAk4ObiXVo7LayOJ+ppoOxzMOH6Ojs76yjcBkESU0tN9muaf/E+7
         LI47sagfwnLR58QbBn7rYAnY/2/hJ6pBVSnLZ0IDqmekjtqz2bu+0LU34ge339xhHdN0
         T4tg==
X-Forwarded-Encrypted: i=1; AHgh+RqQcx5DDyXewRWttL42YJBQcYbWOkAEOq4Qeg0c8UC7Z34j79pkuST4ihBdr7TLlvooebzxrlsadjGf@lists.infradead.org
X-Gm-Message-State: AOJu0YzK1JZGLZekMhO/lrWjN/gV7wqKiP/jBKIekdzkjdJj7nV7Hub0
	nmPqi7rD9uSKBDgDgRitLAV7us+6weMEaovPbB7+h/UDb8M71u7mLhoZ
X-Gm-Gg: AfdE7clwX/66yVJTiOW2hkbJBHHI5uXbqalMfqp9j9NDLQMd8LAlOBojouEuo0O9bFH
	ASmYaLrmDHaMQHnvY0+dmpLFvfDkr9mvJIUHLVnffCCT/CH9qoqD1giMe+ur0epjFESnBRoMI7L
	72RpPRz1crNdtdd1CSrzTnyeU80TZR6/Zrsagma10C/gLf0aCt7G+Fh8/Fdbk1VDgFK5BdT4xYi
	J65hfZS0xIMUHLeIC9ijoreeW9S8ymaduRFvXLHyRxCSrtRssQVDTNg5gj8RlcWUQlnovaqUHQM
	yhz8O7zjKYNGlcW8yn2Jt7XFfDwUnXI3TPd0vqT1+pDFF3pcsNznC3aTCiAIujnBxcU7U+gxLza
	8BXkeWaeZmJISzxDRZPOR8+kdsMJoyJ28p0K2wsT4AueGgltO0+oAkpUhfvR1bYgJylO02KjOjP
	Pa7sUEgw9che/sXzVorM9ooYW1I27UMU3IT/LjBh+4Yk2txo8vOvYGuB4KoIhz9JRqbDRcQ5SYj
	RYBrmvrwRBcxN+nC7r5PdA2fRNhIA==
X-Received: by 2002:a05:6a21:6b18:b0:3b2:a8cd:ef4a with SMTP id adf61e73a8af0-3c110768b5dmr10277166637.30.1783976741679;
        Mon, 13 Jul 2026 14:05:41 -0700 (PDT)
Received: from dancol.org (dancol.org. [2600:3c01:e000:3d8::1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8deb2a21sm24822220c88.3.2026.07.13.14.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
	s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From;
	bh=c7dO4+855NDGBLOtYg+g5EbkrB6jsqmlhFGAdJvf5Qo=; b=XUk+YmJv363B5aLMU+rUknUvyJ
	DaskylG5cYuDTzqw/u+bfm8iSOBAde4w81NZ9qfq8p5wdAgTnO+oYUHFn/1/vJgK71vZWPLaC2IsA
	hVv+SeKHyKA5P1Rmw5RD/qK64HkMaE0CAk3bUmlu61rmMvvtKT7ih2wDej+5+orgSHucuYV7oscAt
	2HMoesra/LoJMZmz8I3wYxNTg78w6hPGzuGR2TcsHJs8cCrbUaQJA8eEazKoEUtifRDBiq7Pf3J0J
	rKjRpgR50YWGiHzdpMvq/bBY/AFusTUsMMELvmR/Z838+jpyqHFQ1NAV4A+xlHqSVe7Xr8foxzzgJ
	35XXVO+g==;
Received: from 2603-900b-c400-2854-78e1-05dc-8eec-2d4e.inf6.spectrum.com ([2603:900b:c400:2854:78e1:5dc:8eec:2d4e]:55276 helo=localhost)
	by dancol.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <dancol@dancol.org>)
	id 1wjNqN-00000000VeY-30g9;
	Mon, 13 Jul 2026 17:05:40 -0400
From: Daniel Colascione <dancol@dancol.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Sagi
 Grimberg <sagi@grimberg.me>,  linux-nvme@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make sending wall-clock time to NVMe opt-in
In-Reply-To: <alVQCljd3a0dRRPw@kbusch-mbp>
References: <20260713203443.322748-1-dancol@dancol.org>
	<alVQCljd3a0dRRPw@kbusch-mbp>
User-Agent: mu4e 1.14.1; emacs 31.0.50
Date: Mon, 13 Jul 2026 17:05:38 -0400
Message-ID: <87qzl6k3bx.fsf@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_140543_107663_98F4AB16 
X-CRM114-Status: GOOD (  22.51  )
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

Keith Busch <kbusch@kernel.org> writes:

> On Mon, Jul 13, 2026 at 04:34:43PM -0400, Daniel Colascione wrote:
>> Some NVMe devices maintain a persistent log, the PEL, of events like
>> power-on and thermal excursions. The NVMe Set Features (Timestamp)
>> command allows an operating system to inform the NVMe of the current
>> wall-clock time. Wall-clock timestamp updates are logged to the PEL
>> alongside other events. By correlating PEL records, an attacker can
>> infer a user's usage patterns and even guess at time zone changes.
>
> How does an attacker come to acquire PEL records if the system isn't
> already compromised?

The PEL can be read without any authentication whatsoever, so even an
otherwise completely measured secure-boot system with FDE could leak the
log to an evil maid. A sophisticated evil maid could execute some kind
of adaptive attack, but the PEL is right there and easy to read even for
an unsophisticated one-shot adversary.

Another thing to emphasize is that the log persists *through*
cryptographic sanitize, so you can "wipe" a drive using the strongest
available NVMe command, hand it to someone else, and still unwittingly
leak real-world usage patterns. It's a side channel I'd rather not have,
especially if I'm not getting any value from the timestamp.

>> The nvme_core.timestamps_enabled_default module parameter supplies the
>> default value of the per-controller flag. Default it to false as the
>> privacy-preserving choice. Users who want to provide controllers with
>> real-world time can set the module parameter to true or enable
>> the per-controller sysfs flag, perhaps via udev.
>> 
>> As an alternative, we could also get the timestamp updates out of the
>> kernel entirely and have interested users run nvme(1) to
>> update timestamps.
>
> The use cases for the timestamp feature are outside the specification.
> But I know of at least one implementation that uses it to determine how
> long it has been powered off so it can better apply correction to media
> drift. Yeah yeah, depending on the host for something so critical is
> pretty fragile, but it apparently worked out well enough. This proposal
> would break them.

We could make the timestamp-updating opt-out instead of opt-in or
require users of this hardware to change the module parameter. Also,
IIUC, nothing in the spec requires a host to use this command.

I mostly care about having *some* knob to turn this off. Right now, it's
unconditional. I'm happy with either opt-in or opt-out, although I have
a weak preference for the former.

