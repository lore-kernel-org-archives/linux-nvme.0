Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF5CD2FECD
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PaYS45mgcByiPEFKsFUr7GpvQrXjsdkBjJYrXKyAauc=; b=fvQQQ+lxS5GBCPaj+trA+COzpt
	vETYCxs6l7TVc8MQU7vGgYdqA+wsLUCGhXFPYXSgwI1H9PCp0MPpsqRI+zKRy/HPU1DfsbAhjKioL
	EtuFaTpVHBBnL4GbxABJHL/xgDyqzHfju+dTvC4kDm23hj/PGmMjFmx3UKl6N+Z0Y0nO1LGylrWZn
	hVMlTBQbQMuaFN7W5+3B8EbwTkhRhOkPmrytqKtJ2hUTzYX3ZKQLO12HxP1vowXa07ISqhp8oNR2/
	RuNm1PLS4cjWde3hT6PImgYqgKzGgTJka5+tMXIUfDXHr/dtyaoE6HoizSTz/j9ydPUlxo6aKLUvL
	qRxVZzUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknPz-0000000Em0Q-00Rh;
	Tue, 27 Jan 2026 18:03:59 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknPw-0000000Em04-0sZg
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 18:03:57 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-7945838691aso1358367b3.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jan 2026 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1769537034; x=1770141834; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PaYS45mgcByiPEFKsFUr7GpvQrXjsdkBjJYrXKyAauc=;
        b=Fq62OBWNYVNmi23/zLgQqadq8GdWogFqno1HK67yqOOxpdOphrZ2Y6zVt+spYoCfv7
         auSEVZBO+bFaPQU37HcsO5IThErvdZEBAciem4ym4hAA4t5M8QNLvBcl0g2QwQn0msze
         jieCustjTRkUtsjmVd14P8hz6pPf5VZampFnvkRpLmO8pkKxDdJpQh2Ixq2rfOjKNcjH
         FbNsIzhWvaj2J6cfsuy/SkD8TfntNzhqUD8ZwqaPSkawaI1/nQS3Ah4VJ5dqgUGjMPcx
         bvD3bBDrAS4XvdGeMymfQnQDj1glXu7dPYmmwyKy9I4r5XAdiGaVwULei015wnY0e13R
         0TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537034; x=1770141834;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaYS45mgcByiPEFKsFUr7GpvQrXjsdkBjJYrXKyAauc=;
        b=sF0eY13TCNu3fISqwrjkq2ftpqtTEKx/0FjLZIf04+ejCNO+Tf4mmc6xBEOt4a0lru
         zx6lAwx8Cxplf2D+jbZPq2WhXHYhemE9isKeMNg2pzd+L6wb7NMzlf1LZg7QrgD+2LCn
         Xmk8WSFQ8jjyq4uWC63xx2Qom0oS6fpw8Hpzr5QbV2717l8MhovvdHF0yCJccXcVAkJw
         MERmwmYt2xXE9dT51bko9CJFQDUlLZY9NBydR3GBWlYbZp2swMFlJGezyMMXKVCDaILB
         DJsdM3X85A2o1mITYcZmLkYwQeujThugde09ykljFJor1c/in4jd44Ek7JEiwHIsSzx3
         i8lw==
X-Forwarded-Encrypted: i=1; AJvYcCXpHE7YWL+bSjPb0V7RzuLFJxKVXwUZA1/YoBh83A7UmwB2zBXu6Bn3NiBA8SEhN0EF0nTb58GFNYX4@lists.infradead.org
X-Gm-Message-State: AOJu0YzHCbO3EiStWCcscvDjXlF76fx8uI1t/64oK8Qvh5VRnIMZpBUe
	ZRt2sQlorJe8DPdR+Ho7e1R9HCleyW6WqtjvuaQFhvS94OFU28/msTZURo5K2Yj0N8U=
X-Gm-Gg: AZuq6aKucJTGABgKf0X4sFCgwhGnEKTUpd3YulPx55uTAt5oXtdFoyyf0UWdUWfvakx
	ubpyBcIfH1DAXzNIBbS/suTnZI6Edj9arlKWEaROfBw3RDd7M/GPv0x/nNCVnMXB1MraVWDOo82
	ISdsM33E0leCvcmBrXBVlnevcZC1klf3LneR+KspRjiKrNwIo7rO1kDtp835sLDB56qP0grj9PZ
	KeXbwsvAntAAHhawiN6ku1WJIhw9kOIwjPCZ8qml7O5f5QvOhPtboPsT9oeEQymfVoPv8iLTvUN
	zk/itbKR0B8QiXnBg3Azo9nUE+BT1uB60JWgd3GpTJWZ/U5I1jpecTO1Ainko2vKGXkKWUB1l0Y
	echSLyZRny/wodHosAeipFPg3q4ZOpxEK6m+lWgBi4gk1W6OS6aYoLzckzSZvbd8uKyD9azDTxz
	9A7Dt6YRU0XeqtxjeYzNTmRtAAvdibS7Mip6NyEeuQc2YucByW/LwBI21vvyJm1N02xEuu1/Reh
	WS8yHYCO/yAOcm1qLKCN3ixmYWnKA==
X-Received: by 2002:a05:690e:d08:b0:649:5789:ded with SMTP id 956f58d0204a3-6498fb06c9fmr1668118d50.29.1769537034520;
        Tue, 27 Jan 2026 10:03:54 -0800 (PST)
Received: from unknown207bd2cf251a.attlocal.net ([2600:1700:6476:1430:99d0:666f:c9ab:3bf0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482762dfdsm473777b3.9.2026.01.27.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:03:53 -0800 (PST)
Message-ID: <fcd8fae5950ea5888eab5279fa3ebcad1d27bfa4.camel@dubeyko.com>
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 27 Jan 2026 10:03:52 -0800
In-Reply-To: <5273400e-5cf8-4d70-a85d-accfb2977d8e@acm.org>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
	 <eab078c99e17e45632c6b35e2fe1145e9459ff2f.camel@dubeyko.com>
	 <5273400e-5cf8-4d70-a85d-accfb2977d8e@acm.org>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_100356_577685_1EB0B373 
X-CRM114-Status: GOOD (  21.20  )
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

On Mon, 2026-01-26 at 11:12 -0800, Bart Van Assche wrote:
> On 1/26/26 10:18 AM, Viacheslav Dubeyko wrote:
> > I am not completely sure that copy offloading to the storage device
> > can
> > reduce energy consumption. The storage device needs to spend energy
> > for
> > executing this operation, anyway. Do you have any numbers that can
> > prove your point?
>=20
> Yes, we have measurements that prove this point but unfortunately the
> vendor that collected this data does not allow us to publish that
> data.

I see.

>=20
> Reducing energy consumption matters for mobile devices. There are
> other
> applications for copy offloading, e.g. in data centers and in
> enterprise
> applications. I don't think that these other users care as much about
> reducing energy consumption as we do.
>=20
> > Which file system have you considered as working model of your
> > approach?
> Every LFS for zoned storage has to perform garbage collection, isn't
> it?
> I think that we can discuss copy offloading without having to discuss
> filesystem implementation details.
>=20
>=20

It is not exactly correct. :) Unfortunately, we have to discuss the
file system implementation details.

First of all, not every LFS file system needs GC. Because, SSDFS uses
migration scheme instead of classical GC. And migration scheme is not
GC based technique because the regular file system operations moves
valid blocks from exhausted erase block (segment) into clean one.

Even if GC must to be used, then (1) valid blocks needs to be taken
from the logs of exhausted segment (victim segment in GC terminology),
(2) log needs to be prepared and (3) stored into clean or current
segment. And log starts from metadata header and describes location of
other metadata structures in the log, and user data portions. For
example, NILFS2 contains b-tree + other metadata + user data in the
log. SSDFS's log starts from header that describes locations in the log
of block bitmap, offsets translation table. Finally, offsets
translation table contains offsets to compressed portions of logical
blocks with user data or other metadata (like inodes b-tree, etc).

And even if we are talking about F2FS, then offloaded copy operations
needs to be accounted in metadata portion of the file system.

So, frankly speaking, currently, I don't see the generic technique that
can work for all LFS file systems. But, maybe, I simply don't see your
point. :) And this is why I am asking explanation of details how this
suggested technique can work for LFS file systems. Because, GC is
integrated subsystem of any LFS file system.

Thanks,
Slava.

