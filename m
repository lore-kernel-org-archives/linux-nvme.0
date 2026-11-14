Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF83606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fLwwG4lm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9I1FMkf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=voIO8VlTvL+eYASbCl/rFeZp/+p5C7oqqVud5Dtqaes=; b=fLwwG4lmI2F5Z6
	HAznU2pvEKNgLEKQmHcwqSZZbuJqDtG0hlSoyM7AJHDO+zleKP6gnaau1VC+mbZJBrNxjPvR/+RRe
	pO3yJuh1sYkWenOlh6hYdiHT8uUBSnXFWIbbWW+HtqxvGEeF05b8TQnFCw5h7WJOUCtCMu4wLY1PS
	mHIcKleHiLRdWqEZF/JrrePJLRCJA1OmNVn5VVPXPXuQyBMhieE9DGVlbOgC8+iaDa+5+yVW3yKqd
	kjPZOmTwfzykcgyE8KzV7apZO5i5cH2pae8CKNHE4r5OxgWzHZLVkoO7P23Xm6S/xFm0dJiQ9lm12
	fBKuGdXVjjpo08kMJQ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDPX-0000000G3CW-3iGW;
	Sat, 14 Nov 2026 13:03:15 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDPU-0000000G3C8-0p6y
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:03:13 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6b565211890so340121a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794661389; x=1795266189; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=voIO8VlTvL+eYASbCl/rFeZp/+p5C7oqqVud5Dtqaes=;
        b=A9I1FMkfIG22wXK4gppsa95vKuEgf9AxsXfCljThhFBJZ7mUkJdzf6IY1OAeDlCK8V
         2SrphRPIDFuwc8Gn/OrqlMCaKSTJRdWvJWbXVaoxtJftPUa2eHq0G4b3sVOVeMG7FsvZ
         5Beili/ACHUHT1B4rmoQsGKA2aBSJSbSPAqoO8lS+nw/21pEcdhX+wIlFfxBTmwFliXJ
         cRSHs1R21oVbmDxHKyAP8ENJKSrhv5V4B0XafoUEnkrVbyMo2ajOHuzTGDBQ+ybW92HN
         wj9LcKRxVBkjwm/5ocZ+MYMF1qjRtT3oLRAvPGRDPrKTt3rkSgtirniSmgWiuenDop6X
         2XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794661389; x=1795266189;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voIO8VlTvL+eYASbCl/rFeZp/+p5C7oqqVud5Dtqaes=;
        b=vu2/dHXz60IPESGK4jGAwIo10gwGcOSez8lCPlAjExdgX0j0aGwPYL1djlZhGQr0A7
         v4N1Heu5kX0C326auOroGnV60BHoRCSBUQ1nTYQAHcjeb7NbT2rJqrhKCWS9CF6jZ0fD
         jTOI7oIbWSeo1HlJMcof7RaADXSiRKIFUxlQk32WwXRUoKVZp+cv2zNCSz3Ps6xnYQlb
         vkeLWgKxDcwEuWBfKYaCL2YlU1mWxexv7AJetg60O6dDHWizDJZUkWqZU8WOtdSBZXlM
         4cYQRPBfs0mWqxH91I5zwGC+/L3o9NlCGR8waXHNSnNAMsNRn+gWN573z1OzU6vJEkLc
         uxDw==
X-Forwarded-Encrypted: i=1; AL+hErG9n93Qw3Rz0xSDDFv6uUyhFYEuk4Rtjz74d80dvBDj69qtCZ/hLs/jIuLrg0GSQ8wIjAbG8cgs0AeT@lists.infradead.org
X-Gm-Message-State: APuU4Z+fSUU7i3YlsPtgMViXOQKywczvnZTwYXz6v0UQKe3V0hqGqqRc
	WshwBxZONkZzmKiuc87kNJHQx4VpNsQpLwMHXK2QdDrAgyR6Vhvbgho=
X-Gm-Gg: AYBFou1JwNIfuROcrdLacPhKf+W6URQqFMlfKzEIXsmg6GPJsubB6OidPWDO2OZPJ0l
	4Q2YxfBPlydNXEwP5FKqOJD8iy/jqJjSHduwtxw22jKZ6qRdMheRfFlG8siCb1T3Z9G4agrpK1i
	6OgvrAg0ERh1howmFyBZCNyeMp6xJHE/L7Dtlv905S5zLKdYIpjNSMlaWk6BPGBMoWYEF9tAwlG
	AXncUqblmQz7s99c51qJKpPKIeaPA4FVw+L0nnv2wc1cE5bou3J8osFB+6E3hym+mnENzeVoGY7
	BSi7OqYrw2LE2lLhhnkz0Wl2iOrm/q8FoZV4q3WT5agp4yyzVq3H6tgv7W1GvsVO9sA7OuId7Ys
	gTKVN2EMDAFNoSkWxGogOk64+sf4Bld3Xh3oqUUB2lihC4/oBBze2pz1gvEAsY9T8nF5+cPBN4x
	Q9n0KV1kiDuwplmpPPiCBzdxiDwXMWwENiqcjpbEDMIsbTl7oVrNcqqVrRecja78t3RM4464aPa
	eTsZ+lXSv4Ab9pdMCW+ww9Wz4z6AaYnn87pHAUNI0xWCn5h6BE0oD5hUXkYUZChyqc/QPUyHPuL
	Fqj1wl2A55kzC7/MOV3OlfMN4UpbKCHrqQMGQTqrm0wo2z+oi2Pf/pdOxees1MENtA==
X-Received: by 2002:a05:6402:a152:b0:6b7:c8fb:53cc with SMTP id 4fb4d7f45d1cf-6b7c8fb58e4mr3242227a12.1.1794661388747;
        Sat, 14 Nov 2026 05:03:08 -0800 (PST)
Received: from localhost (69.red-80-39-28.staticip.rima-tde.net. [80.39.28.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d7150529dsm5866714f8f.51.2026.11.14.05.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 05:03:07 -0800 (PST)
Message-ID: <00e03246-95dc-46dd-a2f9-89ad88f177d1@gmail.com>
Date: Sat, 14 Nov 2026 14:03:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 00/29] Native SCSI Multipath support
To: John Garry <john.garry@linux.dev>, Laurence Oberman <loberman@redhat.com>
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com,
 dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 mkp@kernel.org, Benjamin Marzinski <bmarzins@redhat.com>,
 Martin Wilck <mwilck@suse.com>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
 <3332329d-b922-45a4-8333-e8353e983885@linux.dev>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <3332329d-b922-45a4-8333-e8353e983885@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_050312_266025_0043100F 
X-CRM114-Status: GOOD (  12.30  )
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 10:05 AM, John Garry wrote:

> On 11/9/26 20:19, Laurence Oberman wrote:
>> 3. Smaller points
>>
>> - numa with equal NUMA distance uses one path per LUN, so with two AO
>>    paths through two HBAs, half the optimized bandwidth is idle (sdl:2
>>    above under numa). That matches NVMe, but users coming from
>>    dm-multipath service-time will notice. Would round-robin or
>>    queue-depth be a better default for SCSI?
> 
> Maybe, but round-robin may not be always ideal considering only a bio mode of operation is supported and no merging like dm-mpath RQ mode.

iopolicy can easily be customized per array/device via udev rules.
Just like it's done for NVMe:
https://github.com/linux-nvme/nvme-cli/blob/master/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in

Additionally, "service-time" and "latency" I/O policies are currently under
development:
https://lore.kernel.org/linux-nvme/20261026111019.3724465-1-kanie@linux.alibaba.com/T/
https://lore.kernel.org/linux-nvme/20260815173502.1185929-1-nilay@linux.ibm.com/T/

>> - There is no userspace tool yet to show heads, paths and ALUA state
>>    (the equivalent of multipath -ll or nvme list-subsys). I used a
>>    small sysfs script for this testing. Ben, is native SCSI multipath
>>    support in multipath-tools planned?
> 
> Well, the whole point is that we don't need userspace tools. However, I appreciate that there is no general SCSI tooling which could help here. I know that Himanshu M did work on a SCSI version of 
> nvme-cli tool previously. Martin may know the status of that.

Agreed that userspace tools are not strictly needed for configuration, but
observability is key.
A standard utility to visualize the device topology, path health and ALUA
states at a glance, similar to what multipath-tools provides, would save a
lot of friction for sysadmins migrating away from dm-multipath.
Relying solely on ad-hoc scripts or manual sysfs parsing can become quite
tedious in production environments.

