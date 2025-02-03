Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFE3C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M20UpxnCCjF4g6dYJIAZ+fZHXwpgnatL1DQuqP4O2ps=; b=RPDWqA7QMZlrNpuFLn649QDHq6
	OE7Sxm57eW9s3aoMVn5s8JGpsK88KNm9DutNxEkNAFMns39ETtVBuRAsgr+vrp8ZHz6AH0fu8dfTE
	HqzsXrABa2IB156jaf8Ta/KYT1R6ALDIncbKtjjpKrmlXf+mzAQ4N/c3FoJNFhib3ks3YI8oI8IWW
	HqfMhOpDPIQD9en6rWFPpc6kHjhPgumxAiyMNOPuV+1ummM/o38gVtfWoXlyynxZS/bDHDd/a3OuM
	0ZHx4Csqp0H+74VE3vuedcm9s7T/i4JgagSxizBZFcm3cn4sx/golmkhq5LL9V/nfzTXSTh18A+ED
	pnJPRxSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf5h6-0000000Grlq-1XWG;
	Mon, 03 Feb 2025 23:17:32 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf5h3-0000000Grkk-1l7V
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 23:17:30 +0000
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-43622267b2eso50022025e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738624648; x=1739229448; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M20UpxnCCjF4g6dYJIAZ+fZHXwpgnatL1DQuqP4O2ps=;
        b=UqdZrwa4I37GF0oMGEVfZA8x7Yv+yhoTqMrRmzk584ThCXfIsDGbH91B7VmKPuk53P
         T8FVQgBHp6I6TTMhY095cjGi7LXgwVNX2YbMczKfJgWLhdC2089EnyTfpEGKrdujlouN
         b1nn2OMzgHTwmePkS6XOLS7CJ8jbOBnjtTfXTRxb0EUFTHfDW6d/Vmq/4OgSmrsMLmO1
         7VGIe2whMaJPea887s0awcG7ik6Rdam0p9KFPmGUkI6tT9CCabVRbac4GlbMaj9trs8y
         GDZUmO/Xm7w6bAMRBrvF6B+gBwzRcIQPYy2BD4yp590Cd/TuqAEg+lajckwHArpMCg7z
         8zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738624648; x=1739229448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M20UpxnCCjF4g6dYJIAZ+fZHXwpgnatL1DQuqP4O2ps=;
        b=NXpdvhnSUUpHAULzfQ9H5q6JWNT+G+ZH8i0SFm5wynAkDYtK7Fkyi8Ij6+975aC5bO
         9a7Lvv5qVcKsHP48rWB6A5Fo83lBCDOLmIBWxzhIepAgqjFYiB5VXHNMfj2JEzyWZ8iI
         qE0m4tzB+0RtZ2tlUPc6f2lbKZnTyaU1zv9pa+rbm8k8Ps/bEsFlR51chBaesdO1PHuu
         G+Qv+fHzNrnc7lKUrWAQtFPkAt4bRczAJ71AhiL1XKVAC6QaLxlCXa8AmnS14NEIoee7
         diVDo6wN9XbFui+4QjuSdk9+OZ4DSgzLKB1rljsMVc0IjMvGUJrvZTwkiaY4lVJRJtbm
         Mw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/tdpHdkJGEU+4icswYzewe2wJzwXAPZcDoH/3FhOvUq0gElIlV3TQ+ITtFx815ArHgzbjvSkyMoZu@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1Wm9QZEtTEPEhqTkjLnkd1n4cYMSVAMyHPdzQnB3DLbK+okN4
	PkuJEJIf8J20XmDlE9e5/V3mz3ZJP6k8ItuWQWOUxYEGbeaGznCLrd0Cp5MyDWg=
X-Gm-Gg: ASbGncvIMLms2obWKi7hWucz/C/B/6RFzE9+pUQiCZFfT+eDQB2aHhjoQntRY/0erKk
	SttU9Kupo4WBnNKBOS/8QQHwdHOGWXvJ775AxQ/IXukcBUIIdBk6jAqWubBaqvgxKFVTMYNTkgA
	jpbwpJRLP+M5ENabUWP/V8yUFWlu+wZe6CF9xcVjOD585oV2EQ+nGhFeKmnpDyYjGE+QGkpldrH
	zl9QigQ/A5dPxeoMQvxBJe1Sk6Ub1wgPydiulzz2FwfvkveHzBisP5plVXyxXY/LLl8iGUBN1Y9
	lbnBuOsMMabQpp8W5x3bAmDsjSO6Ny859wRwEyUCG70=
X-Google-Smtp-Source: AGHT+IHKDskR6a298u6J7mhd/9DgYRSdntqz5BbexE9oUnoXAFWMJ9T+mniIRnDNpv7LfLg/ZQDLWg==
X-Received: by 2002:a5d:588d:0:b0:38a:68f4:66a2 with SMTP id ffacd0b85a97d-38c51b600f7mr18788353f8f.31.1738624647383;
        Mon, 03 Feb 2025 15:17:27 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0a666ddsm7087129a12.73.2025.02.03.15.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 15:17:26 -0800 (PST)
Message-ID: <df9c2b85-612d-4ca3-ad3f-5c2e2467b83f@suse.com>
Date: Tue, 4 Feb 2025 09:47:20 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
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
In-Reply-To: <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_151729_457906_0C0D642B 
X-CRM114-Status: GOOD (  11.72  )
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



在 2025/2/3 23:57, Kanchan Joshi 写道:
> On 2/3/2025 1:46 PM, Qu Wenruo wrote:
>>> ell for the WAF part, it'll save us 32 Bytes per FS sector (typically
>>> 4k) in the btrfs case, that's ~0.8% of the space.
>>
>> You forgot the csum tree COW part.
>>
>> Updating csum tree is pretty COW heavy and that's going to cause quite
>> some wearing.
>>
>> Thus although I do not think the RFC patch makes much sense compared to
>> just existing NODATASUM mount option, I'm interesting in the hardware
>> csum handling.
> 
> But, patches do exactly that i.e., hardware cusm support. And posted
> numbers [*] are also when hardware is checksumming the data blocks.
> 
> NODATASUM forgoes the data cums at Btrfs level, but its scope of
> control/influence ends there, as it knows nothing about what happens
> underneath.
> Proposed option (DATASUM_OFFLOAD) ensures that the [only] hardware
> checksums the data blocks.

My understanding is, if the hardware supports the extra payload, it's 
better to let the user to configure it.

Btrfs already has the way to disable its data checksum. It's the end 
users' choice to determine if they want to trust the hardware.

The only thing that btrfs may want to interact with this hardware csum 
is metadata.
Doing the double checksum may waste extra writes, thus disabling either 
the metadata csum or the hardware one looks more reasonable.

Otherwise we're pushing for a policy (btrfs' automatic csum behavior 
change), not a mechanism (the existing btrfs nodatacsum mount 
option/per-inode flag).

And inside kernels, we always provides a mechanism, not a policy.

Thanks,
Qu
> 
> [*]
> https://lore.kernel.org/linux-block/20250129140207.22718-1-joshi.k@samsung.com/


