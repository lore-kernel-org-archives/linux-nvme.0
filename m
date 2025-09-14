Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED701CAC582
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Sep 2025 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lCpF5zxS8ig34a3uFAe9yvJyfKLOIR0AC+2KaeO3sI4=; b=VXmrKTGuIQfLMDmrHl4oXEnpE0
	PSuSOvVnGjKwAX/Bs/CvTzPEAC1sq/Q1bHKU3A3apREJflLtRBIy2lRERXQz8AdGBovgo9syrLm/H
	YCar2kLT9BqPfzxFvBIzsA3vKI0cguKAKTiQ39Bcvci9yYwnNIiF/CptH+Q3k4CXZXYW9+ojY7Nh4
	Jgk065w78TpgOMnZYucGs4qSx/o6kqcLKX/JVoiCBZPKuEY9u/8A/tJmZX+kliAjJYTgm1MhD9XY3
	JZNdQp7RGafw0AbzxiLWiJGXnEiYSNlZpOJLjZf1UjhxVyEKZVghvj5oOgXy3Pg8q6xaF/M4oypiL
	TlCFDwvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxm72-00000001CP1-3ahK;
	Sun, 14 Sep 2025 12:45:48 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxm70-00000001COH-48ZR
	for linux-nvme@lists.infradead.org;
	Sun, 14 Sep 2025 12:45:48 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-40a8f56e59eso9902355ab.2
        for <linux-nvme@lists.infradead.org>; Sun, 14 Sep 2025 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757853946; x=1758458746; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCpF5zxS8ig34a3uFAe9yvJyfKLOIR0AC+2KaeO3sI4=;
        b=Pxn8zMSSMHW0gfpO/S9qtJlvTCoUP3/tBgYNL+9DZp2rEYLYfHtujnUmPXi2z+Fqbq
         jMFo0iEhQ9OShX/BKZXEezLcrk0xQy4F403BMSrc9NaNjXflB6YGYwfwxUAltlMhfER9
         jrRlKu1KJ6wCJdHehw/T6EQk+d0KrWin5HR9VlwBHi6VuqQX/fSXkHP5EYT/+jqF4NKg
         eg16Wx9sKx0rAylUFxuG0xKjQcCShQgb8oP45NuXcB5b7VDhuGXpA5rnmThvk/nM6zFs
         E5K5nPsQOcfJ3qWWRc2Pu56hLQnvXG2nfboIA5+2CZpWvjrOwUFcH1tOsjXtgptt840h
         lU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853946; x=1758458746;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCpF5zxS8ig34a3uFAe9yvJyfKLOIR0AC+2KaeO3sI4=;
        b=YQAVbwfdyVn4RpsVwA1OtWX/MLnLrk4R38S/4BFbThCWhD0lMDyr5/lBSweGXJRwGa
         jzGlU3eBH1De1n6hTUX5Yfw6HE5LErC585i0jO4tSIWupsheiKw8vZ6fTEiG6AH5tzw3
         bYG0t6yE/1XVcNNOZHgm1d64lyeILRC+vBQW7nmZW/mWqe97aSYD6z+fC7pndU541NHF
         XUXoANAAXxAVxJfUTzlewyshsqRFjfVYhTCPLSan5M63OuI+yJVHOklpGhRwR9e9alNv
         orSOsRQqCDSdearQy2xEKkxsLuzxLq4WE2sGOiEbcxw29IAxjxG/bsRQrMBNV72WQJsw
         3iSQ==
X-Gm-Message-State: AOJu0YzKtMtSKKx4DWpWdZXWxGT4JXVsop6i5LQnjeitsaVx1UqypznS
	KKcrPoFKBddePEm34MDES3OFp6XXYUS99YpDm3kXbSNHecVtGqQKSJ421ADcozlR9w4gPN10Rgf
	6fy1+NVfjRLckJPFwaRhlFp+ycmQ+K24EogaZlSE=
X-Gm-Gg: ASbGncv3LjyyjOP35NYJplDrwRkJFiQDtYuJ++TMfiqBQtIHTWga4Ge3PfnS7MXiIXY
	Dl4Kp/sdjyIHtAxBhaTPUAB7wNRPi16TiYqup822fVsDg7GY60eDhDPECIK4SKDgdg+elq4u1PB
	ZPb03DK0xLTXSWafqzDm0xsoY8KNRkvUfPtg7JJrcpQh8i7J9FVZJzofscs9R1lFMoESg/TDpF1
	/YqCG7crZJ53zNhff0=
X-Google-Smtp-Source: AGHT+IHnLaYx/ACNgRbs5sgVHAkOtiCRbnf8c04T6ZyhfEqurNNBd0o8wHS0fIr5FUtQesZRxU4g7FnvhP5NFloB4hQ=
X-Received: by 2002:a05:6e02:1988:b0:40e:9e8c:b48c with SMTP id
 e9e14a558f8ab-420a311fe64mr104377195ab.15.1757853945931; Sun, 14 Sep 2025
 05:45:45 -0700 (PDT)
MIME-Version: 1.0
From: Apachez <apachez@gmail.com>
Date: Sun, 14 Sep 2025 14:45:35 +0200
X-Gm-Features: Ac12FXxl3VqkyhI0pKLJ2SLQOCVWOloda4_HcivodHMF7VJsfNjOHmQUHl_bZvs
Message-ID: <CALbmT6fF+1n+W1r+JNyr8+yY8Ub7PB6yYT2gpS12MBLbuHk9hQ@mail.gmail.com>
Subject: Increase maxsize of io_queue_depth for nvme driver?
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_054547_027026_B68E8275 
X-CRM114-Status: GOOD (  11.30  )
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

Hi,

According to current version of the nvme driver in Linux Kernel
6.17-rc5 the boundaries for io_queue_depth are set to >= 2 and <=
4095:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v6.17-rc5#n93

However according to
https://nvmexpress.org/wp-content/uploads/NVMe-NVM-Express-2.0a-2021.07.26-Ratified.pdf
the Maximum Queue Entries Supported (MQES) is a 15 bit value (so 32767
should be the largest possible) while other "internet sources" often
referers max queue of a NVMe to be up to 64k (65535).

Using nvme-cli on a Micron 7450 NVMe SSD 800GB I get this result:

# nvme show-regs -H /dev/nvme0 | grep -i 'Maximum Queue Entries Supported'
Maximum Queue Entries Supported (MQES): 8192

I would like to propose that NVME_PCI_MAX_QUEUE_SIZE should be
increased from 4095 to 32767 to match the current NVMe specification
regarding MQES and to give the sysop ability to fully utilize the
performance of the hardware being used, or am I missing something
here?

A spinoff of this would also be that the default of
io_queue_depth=1000 should first attempt to use the reported MQES
value by the device and if that doesnt exist the io_queue_depth should
be set to current default of 1000?

Kind Regards
Apachez

