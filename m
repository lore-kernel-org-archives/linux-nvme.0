Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A611C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8t/px/iYF1UTrlzuJVPSp6pbb7fjo4rnXnHt8soXe8=; b=G66SmfwLpET+hzH41OiRQY9j2C
	V2Nhwr5A2fq8CNmjGWtb26bLQ6CntcOFjYjV9JKL8kFmt+7vUKq8MtXiQ/zoV5aNUgbv0leyVp8vS
	4ROFC14yQMPrU2eZz/HaG5YwyAmWhUePYGz9asgjskAK1O/Jibt72149chPgJrTN9gnT3WFXwtZKc
	nZ2Sp5cd92MPQc2ENJrBqT0DsWsUdgg5QMOQHJpM+V/XR3NTDM6cTQgKtgu47nWWUcZEQwpxoIjAa
	RPSuz8YEEGhfPxKokLjvrS8dq5XgV/V+3QXl6fs7MR79cqGAJWw/5e5CK6obPdtmw0xBpPSYJCAKl
	+/rEp1bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtVG-0000000EouL-2qew;
	Sat, 22 Aug 2026 21:43:50 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtVE-0000000Eoti-0sF6
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:43:49 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1600d040e4so335586466b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787435026; x=1788039826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8t/px/iYF1UTrlzuJVPSp6pbb7fjo4rnXnHt8soXe8=;
        b=pXF7vr9SCjwF7XMngn0cQIwX4UC+QopMX4TOHZvl+bixSpjB40VMvwbUusPasT3moV
         SJ8pAMxcTQ8xLfH8cfH08mUXrnMr81dOn3J24bsA5ygeUfaOUharqXeges0VjewJU3U8
         HGDWynLfrSVZRJz/+etlELxFM4ViyoRvxHIMUas/gTz8MX2w5iwnXn2ozC3vilD5IN0L
         AnavRGel43KKyfbPzjPzwi3ekO3cuKGwSy0mvmWRDV/cxnSHvCg80+wRmwCkTz609H4X
         vVqGvyYas95FRRQ1TbRO+LwIWzTRii2ehg2SfZI+s0fRPEEwkfogDQTqfMnzAnC7D7UJ
         zp1g==
X-Forwarded-Encrypted: i=1; AHgh+RpeoYFShqoZOxHifhU+hBQjw7KV6B9PZcVm82AJqmoy5hk25Lj9STN/ElFv/iH221ULDuY8iQSLvKB/@lists.infradead.org
X-Gm-Message-State: AFuF++lGh1av4/h32ivw5YjukY1DSpSpPrLg0623h57z00Nw84XNGzK7
	jZDWY7m8k9LEct8kPeqhjxVgjBJKoRIojVEmvqLfkc31Ysiwcf1KZEk2yNrz6w==
X-Gm-Gg: AR+sD12LqhJjzHP5QX6WmeH2TqSers7k145T5JbBXRIo94IbGf9bSKRhGRv4CLkHGSU
	8lUTP31ybvyYFQtsL1RwpP3HoSH0D1fN8Ha5PrIHik3tZxQsdzvBxUqRQ2x38tcm28/RPRF0/EZ
	8PS9Oo/tsGImMelQobKYXZTYvaL7gBewJQwGrcxGTIusXT4Fs3V9Dv1XPqAM+CHTyQOy8NLeBle
	yu3COUEG9u16pQSZ+9aRBJWBVWn91zQPFYw70rLHdzzCK4ag7lmqCtSPzvcYdWeb0fS3hM5fcVX
	bONFOjgUhCFn8YIV6UUpKGfn4e9GamBaEXglTx7LyGZtJXPLp5zMFoyn9VDEXEH7poa3iuiM690
	P+j7dsXOxvE0vfvdfGmHrXVk1537yRZVGOP6qDnmVqKaGbCm5ySJjhlPr4qW4UEkDX+wFDla3NS
	H6DS3bqEDvzvEVW7gwE85S//ycEf/QRRHveXRAxDWjSCuEFQOGmES6Osux+AybIcW2Z6yAyEahW
	oNP7l7+wvlExrvx+V8ubmA=
X-Received: by 2002:a17:907:8d8e:b0:c20:61e0:e3ab with SMTP id a640c23a62f3a-c244d45a6b4mr2130732266b.3.1787435026182;
        Sat, 22 Aug 2026 14:43:46 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f58dfsm467900066b.38.2026.08.22.14.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:43:45 -0700 (PDT)
Message-ID: <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
Date: Sun, 23 Aug 2026 00:43:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
 gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260821144329.3620389-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_144348_256811_852E8BA2 
X-CRM114-Status: GOOD (  13.64  )
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



On 21/08/2026 17:43, Nilay Shroff wrote:
> Hi,
>
> This series is a rework of the earlier patchset[1]. The main
> difference is that --nr-io-queues is now calculated in nvme-cli
> instead of in the kernel when establishing an NVMe/TCP connection.
>
> This rework is based on the feedback received[2] from the netdev
> maintainers.
>
> The original patchset determined the number of NVMe/TCP I/O queues
> based on the number of online CPUs and the number of hardware queues
> available on the NIC in kernel driver. This series moves that logic
> to nvme-cli.
>
> When --nr-io-queues is not explicitly specified, nvme-cli determines
> the egress netdev for the NVMe/TCP connection, retrieves its current
> hardware queue count, and calculates the default as:
>
> 	min(nr_hw_queues, num_online_cpus)

This looks reasonable Nilay.

I am wandering tho if we want to place some lower limit here.
For example, my laptop has a virtio device with 4 cpu cores and
a single combined ring:
--
$ lscpu | grep NUMA
NUMA node(s):                            1
NUMA node0 CPU(s):                       0-3
$ ethtool -l enp7s0
Channel parameters for enp7s0:
Pre-set maximums:
RX:        n/a
TX:        n/a
Other:        n/a
Combined:    1
Current hardware settings:
RX:        n/a
TX:        n/a
Other:        n/a
Combined:    1
--

It would be kinda annoying for me to now explicitly pass the nr-io-queues...
I am wandering if some sort of threshold make sense as what you are 
aiming for
is reducing the amount of queues for large cpu counts...

