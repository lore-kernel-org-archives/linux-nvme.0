Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74857C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S8QL7MIPJrHTaBwGNzMPvfE6M8C7sgEQE0mjqhV74UE=; b=JGGc8HOVdlimEEf8+EWU0ARW2I
	XWXTI96zNT96t2PKdjJnJFSGhlAQIIUX3ndFigf/x+CS98oeQrqoRvETflj0+iW8U/T9/3f/SM86t
	cZfQU96VXiSLwxaFK15y27/cpkwFHCJQeVF0fj34+Odw42UUpjha5MZSWPQC2JH3q2X/8rRhWmu4j
	NgokKvsO2aN3/2z725h0zjzGHJG87GMIKjm1Uns71r4l/+nGk3Qh41ILL9wue8DGRQm18ALmzTbCi
	+BLriZVurxpdvHpqg3s73juwV5wwKJGwk9ZeWMisS8dImH/rRKAUYtGhOXfwfdnL3mF3ULxCbUTft
	bLoKxjFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCLj-0000000F0Ax-46sj;
	Wed, 17 Jul 2024 21:38:11 +0000
Received: from mail-lj1-f176.google.com ([209.85.208.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCLg-0000000F0A8-1Dr0
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:38:09 +0000
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee98a224b8so312601fa.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252286; x=1721857086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8QL7MIPJrHTaBwGNzMPvfE6M8C7sgEQE0mjqhV74UE=;
        b=p9phuSSTmFTjS/JT6vuJkiAHTd4/gwqC00AIVTU/3vi69GnEG0TGRIwye3GT2ZVBD3
         HC33UmbDPKVciHTgtuHp8BbzSJVRNggvPMwwl9i95s5i7uNofbNG6nFvxkxtf4sWtX0j
         JvfuHeSdkJSbaTTMWmK0rg9igERjL9o2NSMp5SC0OnDB4RTCGT8pVYCJu1UCGCC+ibTQ
         bVaymrII55+Z2A9SbdjzEUryz51JNTEhhGmsZ0DVT+hc/zkDklY3r2lWpVMRs3bofKkY
         O9CLScDPQlvVuGhmsYFogyshl/Tipq7CaBPdvGvXgabnI/P1m/tYrP/ubXkZcUoFX9zt
         F6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXin1/HYP9nYmyk3aA01GOFFudarhjRbtoigbF5PpI/IRtpLGQtIhOj9I4jF7xQ16iOgNEkgKA6H7VM@lists.infradead.org
X-Gm-Message-State: AOJu0YwwHdguYJx1OIekl50V46baxF+7rN7fDZOQ+7cbRDe1ypbm7fbT
	qG+kVXNABDqfANX+gAR6ANyMqZzYqX2m+rXUaYNturVMUMiFzia/urcV0w==
X-Google-Smtp-Source: AGHT+IGQZ0Dgtk0KDZUhtViu5q+54XjksWLejPEWap7qNn9xfi3kFj6/6W+AsGd8YQSMtM54Mu6kMg==
X-Received: by 2002:a05:6512:3d21:b0:52e:ccf5:7c3f with SMTP id 2adb3069b0e04-52ee54824e9mr1161901e87.8.1721252285885;
        Wed, 17 Jul 2024 14:38:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b030bsm10795175e9.17.2024.07.17.14.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:38:05 -0700 (PDT)
Message-ID: <58cea755-d1c1-483d-b6b8-008d22daba7f@grimberg.me>
Date: Thu, 18 Jul 2024 00:38:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 00/16] nvme: implement secure concatenation
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_143808_366465_B74CF04A 
X-CRM114-Status: GOOD (  19.87  )
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



On 17/07/2024 12:10, Hannes Reinecke wrote:
> Hi all,
>
> here's my attempt to implement secure concatenation for NVMe-of TCP
> as outlined in TP8018.
> Secure concatenation means that a TLS PSK is generated from the key
> material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
> is then used for a subsequent TLS connection.
> The difference between the original definition of secure concatenation
> and the method outlined in TP8018 is that with TP8018 the connection
> is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
> with the generated TLS PSK.
>
> To implement that Sagi came up with the idea to directly reset the
> admin queue once the DH-CHAP negotiation has completed; that way
> it will be transparent to the upper layers and we don't have to
> worry about exposing queues which should not be used.

I'm glad it worked out. Happy to see that this set is getting in shape!

>
> As usual, comments and reviews are welcome.
>
> Patchset can be found at
> git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
> branch secure-concat.v5
>
> Changes to v4:
> - Rework reset admin queue functionality based on an idea
>    from Sagi (thanks!)
> - kbuild robot fixes
> - Fixup dhchap negotiation with non-empty C2 value

Can we split fixes from this patch set? (unless they are only
relevant only to the code introduced here).

