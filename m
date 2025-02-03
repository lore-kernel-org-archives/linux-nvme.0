Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034F6C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuh1Y2aj/w3XNQwubD+Q5fCshIpTUv/N/3WlT+4cPKM=; b=gn3nwz7pAwbjbMq5ToeXffpagu
	CZ3AVLOh6bphoB435eNuNa4TuWWswUU/J+cjNCinNjgWdx3o+itEvcOzbgNvMu4qbuxUOJnuzq5cA
	WWbibEMN4Ip4xfmqfjDQZi4qkcGoeEY7Ba7OGxlN6TzLaaekqSZWS70vikBmglKTseCtFfHxfeUQI
	ZWgeqIiZZgm2OYuJI5Yc4mnGilFTvhPkR4clWxb89Ex7Y2lvbeK4DiyxRBBm8rAhbBWTj+aEloW2o
	Ow6Yi0tNkBdmAtI9cICUdZI/Pu5CViaGn1z4fZi63I4YVVS48ERvtiqwawBDcQwMISf0iIUKW7RU0
	Fa3WLlbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tetG5-0000000F3vt-2WrR;
	Mon, 03 Feb 2025 10:00:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tesAq-0000000EuRf-3oAI
	for linux-nvme@bombadil.infradead.org;
	Mon, 03 Feb 2025 08:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yuh1Y2aj/w3XNQwubD+Q5fCshIpTUv/N/3WlT+4cPKM=; b=eiw4PyKDFetqw7GiOic9T3iXQP
	5aaoi37KV1sqDfX8IcZWp81Pji7+HVWZVXQzuseS70zO6BquQ0d2/RoK8Jw9l/6HLiQFO1oqGIidh
	B2AfvRQoeJkp3eynSW2v7ujI8tG5JESYSQXCfrIpYbcivSkupMXR3aCV6XJRDhs+bsIp4qYH0Dpc2
	Ch5MwIrJxlhxQ0iEDuOdpxDdKM+7Puk66h2gYRTUmgo3ujXpNikyW0vSlQx2rYOPF5QEawn3BjHpu
	EPpaEw7W+1atqHsTAU8EzZSq9hxKfZkLTwqJMlUtHOOwbNxGVSblQ4DNyH3mh9m+9j7IaCE7zpHH0
	OTNxNEvw==;
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tesAn-0000000G0v6-2oy1
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 08:51:19 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so2086684f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738572675; x=1739177475; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yuh1Y2aj/w3XNQwubD+Q5fCshIpTUv/N/3WlT+4cPKM=;
        b=SLlwUjUG+0B7rq0wMjmtS/7y1vdPZy+VdITHd2D2EDeLWnahWOmUPr1cLpQ0MUQSLo
         gwxtwYP9RORCmicnO/7a1tN3IuYMLze3zQwd6k2DaSvbV5DExoqOVBU1SvLSRe9ToDgI
         7bOf3J+0mqkiAsRzVTr27L0TVe9TExg4r+sSILnPmBSMHoGUJ7sbkv5y9DPOanLiVZd5
         KYEvS7LZMxbkBxZYSymII57NZ/gstmeFAtt0g5YjPqR3fdq5TJNi30KuIv17Y6i5LSKj
         ZyO8tI8LnKLn/UIhrdD/O1XDPuwzb29xQiGzoJnwLosMNV4xuPvtdxRNmIlJ5eJW0tAZ
         Affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738572675; x=1739177475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuh1Y2aj/w3XNQwubD+Q5fCshIpTUv/N/3WlT+4cPKM=;
        b=Hi9qtY0avWMfuMqP5fxhB4I691VroJBMYrXHalD4x16fKoVkhmaePu4S0sS5as4CDZ
         n1P8CbT7zZW0WwRJuFUT5JpX+R8vGkHyfzU4sgKwwiOGs53zXhgBxGj6Rh9VdAVFLLtK
         nWLHQDULeakMrQvd0yYh4kHoNRN2s4uUSgeSSNWx0+KMUisTTXJHTpmPMtiktbcS1iBA
         fNXUGbS0PzvAVMAQmfvb7zaNQRrUD6PBZU1HBCYPQsqNgzQz+AjRcN7mHC3leAZZcqMR
         myXi1TU8HoNXdnALIrDVWFU3wy5M+neAl1LZ6M729XdRy9tEESjEIY6oKvv5+N3fncHe
         sMrw==
X-Forwarded-Encrypted: i=1; AJvYcCWRbctTexSpOeoZZnwx6fK6w2y/X565P7wmGR8DgazxbIdm6SK7d0aTutT/bd8wSBUT9EOW8Lhh45ai@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4YEQzON5P8Xtf2mrCqkPZAL5lSEMcd3OOdqcIaEQK8jytus7F
	1Is36rb0ARbyIzRqcEkhzUvv7yMPx5BCQHiRvdOHBa/dOJCFNB2sExioyANUJpQ=
X-Gm-Gg: ASbGncv7yVIYGiHwFYsWBuWQzUBHYdzqW5h3E8koXDcbiI5nCbMlh0RuyCD2rNTekwn
	CaFd2zRNWm/yy961SEpPfr07Vy2cqxui4amgUOwagMCwcy526+SahZFe41gDOxBclfOLm2E6IWV
	4OIzzYjLD4Bpg227pFrmvwUqKt1osoVgB4WP05gY1Sr4kRud+pVcccD374wXZgz6wUfuIl/FL0e
	Obf+pyZLKxI3cmxcM14RM2h3v2t1uhYaO89N3P72YjwD7TPnFDQRGSrOjOuKO9/cyOrplr8K++F
	UYcTrjo4HHCIrhLXAEK4QKOAm6APBNi7y2tpfmksAUA=
X-Google-Smtp-Source: AGHT+IEWYQIsW4byeRku5mnmhA2UC6HmLVZIhKFc/Af14p4WumqMTRj11XeXCHIL2Pg9mxDA3GTgDg==
X-Received: by 2002:a05:6000:1562:b0:38c:1270:f964 with SMTP id ffacd0b85a97d-38c52097624mr16090182f8f.47.1738572674853;
        Mon, 03 Feb 2025 00:51:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d42a0sm8321604a91.25.2025.02.03.00.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:51:14 -0800 (PST)
Message-ID: <26a5ee76-3e5c-441d-b335-41ee4c879e0e@suse.com>
Date: Mon, 3 Feb 2025 19:21:08 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: "hch@infradead.org" <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org> <Z6B-luT-CzxyDGft@infradead.org>
 <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
 <Z6CA9sDUZ_nDj5LD@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <Z6CA9sDUZ_nDj5LD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_085117_972408_5F8BD5C2 
X-CRM114-Status: GOOD (  13.67  )
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



在 2025/2/3 19:10, hch@infradead.org 写道:
> On Mon, Feb 03, 2025 at 07:06:15PM +1030, Qu Wenruo wrote:
>> Thus my current plan to fix it is to make btrfs to skip csum for direct IO.
>> This will make btrfs to align with EXT4/XFS behavior, without the complex
>> AS_STABLE_FLAGS passing (and there is no way for user space to probe that
>> flag IIRC).
>>
>> But that will break the current per-inode level NODATASUM setting, and will
>> cause some incompatibility (a new incompat flag needed, extra handling if no
>> data csum found, extra fsck support etc).
> 
> I don't think simply removing the checksums when using direct I/O is
> a good idea as it unexpectedly reduces the protection envelope.  The
> best (or least bad) fix would be to simply not support actually direct
> I/O without NODATASUM and fall back to buffered I/O (preferably the new
> uncached variant from Jens) unless explicitly overridden.
> 

That always falling-back-to-buffered-IO sounds pretty good.
(For NODATASUM inodes, we do not need to fallback though).

The only concern is performance.
I guess even for the uncached write it still involves some extra folio 
copy, thus not completely the same performance level of direct IO?

And always falling back (for inodes with datacsum) may also sound a 
little overkilled.
If the program is properly coded, and no contents change halfway, we 
always pay the performance penalty but without really any extra benefit.

I guess it really depends on the performance of uncached writes.
(And I really hope it's not obviously slower than direct IO)

Thanks,
Qu

