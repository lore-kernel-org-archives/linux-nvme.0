Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7904EF36C39
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 07:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aDv8kzY/wvtJwMF42UK7u0PfDikhFNNgDHqaPIhIY5g=; b=WSgzXpHfGn9Xr2PJ2xksWNDDkO
	dUs36JJpsvMJnGpD2YDyCERp6mQTzTwsDVgBMN5CFE/UJFyCNIRpBuC0VYpeZPosxQit4myy8bPwM
	V+xO15lXcMWcH8iGWefPlsDpMH8n3cjT6EpCAsaR4d/017+7F2W0/+24eB5yieES8tTkbnx5A8VNX
	KDhNFycD+bxXYotsaZIQgm6Yt+ahrHSae595cRtk91Ayy0kZvqnW86y45QAlIHmOOhvKEirzI3YoQ
	+z6jbzLlbS22pscwmmswWRswWkzuGlOH9H4zXTV3PLjlLFxg2+hw/s929k+GLbyYXi7jaYXPzYufQ
	23LE4nGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEiwy-00000006XmK-1mq3;
	Mon, 20 Apr 2026 07:21:44 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEiww-00000006Xly-19xJ
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 07:21:43 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-47952229648so1585916b6e.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2026 00:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776669701; cv=none;
        d=google.com; s=arc-20240605;
        b=VVqt9R/o7whrdV06QhDiQWeaZoYd09rIND07YSG05D6dC2VS3j3jGSWXClJ4f74siU
         8YMZ3Y8mjXe7I00VcL49Aj+cDoKKVcQe2+h1+D9oEJLfAuRWFoSLdS+cx4tt/biA4nM4
         sGhJtBeAuw+AMCJcJmRiwQGByp9BUsAU8T93xQMG9SF1dLEkN/GE8jebIz18hllHGe3R
         mddWMI/UEW69z2XaMX7kYsQxuIuY+WwonMHfAEdepVGEnVYzxS+V+uwDWz7mJzzBDRKa
         txbv03R87NXu5hmnCdc13uXD8pPCNZk2A7SWpTQnFWBq3BSnvUZd1anmvsxf/JG4Bgyw
         b37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aDv8kzY/wvtJwMF42UK7u0PfDikhFNNgDHqaPIhIY5g=;
        fh=bWyxcm0BJaDq9XgMUF+PPS0STmC2Avc/RdLGwFbg7Dk=;
        b=Bax/JdyLR1v3pRP4HKbPTOm8ti70rIbEOITUE0UoxxUZnMeYLtZ7RSm3TK80UIAeIR
         oB6I4TlWz8xiA1OU+Pr6tELczNW2cq/kOpPFW3Kr/5Sy7GrZoXLjXgGqCpzaNF94Dtcj
         dZhLAF5qqSCelNZwE1spYrQmUJMG4gWdqPjAoSonWAnoyU+6B3jkSOk1Yiv4FNOqnMM1
         Df52YMXa2sLqJ6n0dYhVvZ2FQ5FeZZXy0O+3gzfj4WgewyaDphiZ1G9LL8V2avJRSJYM
         SJpYKLyHdUEAAF0uSmvv6S2t4PwHcHyMX1Pchc54CtIVIGhtfZ9bQEO+jmB8apWRxvNZ
         qpfw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776669701; x=1777274501; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDv8kzY/wvtJwMF42UK7u0PfDikhFNNgDHqaPIhIY5g=;
        b=nU/RhX+mjCHbtaj//NwlJ7a2KOThO9pAVzUtr3QtFotinkPkerozOlPOK7je1DiGIw
         l4n+lfLjT3XwZS3lWjW8mqpKhaJpR1ulSud61wb0FxzUS95jKZ4gVg5IZ8QTrXyeFj9R
         6jwKXXqKpTOvGBv9Pl6Z1EW19BDhDu/xiS3qf8m1EtljEsqbg1rlgOCKcv4/olwL7NX0
         xBG6NHg9v5FY9qjk7IHH0dsmZc+FqwPATsDmZSrWu+42UmvU3zLkvgBP6KXMaClJedKk
         AThO3dySJgum/kHsNTNIwt75LePrQp6v1ZtYyoqYAFmWdsoeNyAu4qienumBd8n4q61U
         3ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776669701; x=1777274501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDv8kzY/wvtJwMF42UK7u0PfDikhFNNgDHqaPIhIY5g=;
        b=jouDCkFwvhRNsoa4o5H10FW8D8ZJ03C39taVPBaPBSpp2v8OnZ0NFY3Dvj0qHWYB7y
         rbBxV+RI+mp0iZO2boc+fUO8L6uIuQ7jsudtfqa3Kr1j6idXZv7D6c+1zPeAOuBXZAxT
         d0E+4aL0MQB/LTfn3kHYue70U+TZs1TOXMNxKNgLB1kvFu0qKcoy+TwKitTFB6pdmiDh
         LiTHsqxtGPdVOuO1hB1zfXRDHlX8dfJ3od9rSKifjAZ15Sobxzd2Ar/TSzP2Xkk0FSQW
         uFajpdBW3EcX/N5T0t+1zyzSdqxlVI6Ylt2FBDGSF1qgso8Td2REDvnHCH7LPCdaLIzk
         2P7g==
X-Forwarded-Encrypted: i=1; AFNElJ/W1S9ihLfV61xwmkTkwAKzT3hVlDYvIeCqkXD+Hha0kDWS8s5kApVNhUvR2dTRBaKb+rbcNrFS2x3t@lists.infradead.org
X-Gm-Message-State: AOJu0YwnRxizeppi3+j81vWLthe5rl+uzq2mffxqg05aIt8gAPFB78AV
	PpRUxPmcharR712GKYDE7L1Y9BfA1rXdoCnsr2vukCY/CgySyF4fiYRLVoFs4H5UtRvMDwUcOoe
	VfvCJvVldg2TBe3M1t8VnUYXNjDMDU2M=
X-Gm-Gg: AeBDieuobYTMUNrwXU1BOj52prsFWBeSG7STEGLXqEWSiXGqwPSj3cc2pxKtXz8bGhV
	Jm3zOmLT9GG0E2msEnS/ONw/nBDZQxWQeJPzvsF2EoEp6hSNp2/4ToqgD6vQYf7aDDGX+GujwzA
	fZXcXmDqRegyNtrrhAD4oWPXdSL8Ifaxv/nm40XJkxFBolUNorIbqbY4H4M3dX64plJKe76o6FA
	UmJi/C2vT7wdifCj8wnFt7sWQzV909/9c+2U9puXWEm5+9ML4HTkae6IbSD9wmdRmxb/zB7F4g9
	A0PxCH4/bbZA+2T7QydglrSRHYotWwIAgFk8E6ffuW+qvuHCHQ==
X-Received: by 2002:a05:6808:bcc:b0:467:14c7:a8ae with SMTP id
 5614622812f47-4799c94d75bmr7221946b6e.21.1776669700915; Mon, 20 Apr 2026
 00:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <202604200606.7BHpBMyA-lkp@intel.com>
In-Reply-To: <202604200606.7BHpBMyA-lkp@intel.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 20 Apr 2026 15:21:28 +0800
X-Gm-Features: AQROBzDranaMeUZhKA4e73Rgphcfp-jFOTvP4WoH3XC-huDjGkWUMD6mLz5Udn4
Message-ID: <CACVXFVMLmH84dJ3h+1PfdfXg9BSHt=xpSSbRBzF6eOs4uNKwug@mail.gmail.com>
Subject: Re: [linux-nvme:for-next 5/19] WARNING: modpost: vmlinux: section
 mismatch in reference: swap_inode_boot_loader+0x36c (section:
 .text.swap_inode_boot_loader) -> start_dirtytime_writeback (section: .init.text)
To: kernel test robot <lkp@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_002142_370315_FB5C7329 
X-CRM114-Status: GOOD (  10.29  )
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

Hello,

On Mon, Apr 20, 2026 at 9:51=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   git://git.infradead.org/nvme.git for-next
> head:   0514a1379e11c6b8038674f43a478b0857d47a5e
> commit: 139c3d972ebafdfb27d05ab33cfc3583fb98a7b2 [5/19] ublk: add helper =
of ublk_need_map_io()
> config: mips-randconfig-r071-20260419 (https://download.01.org/0day-ci/ar=
chive/20260420/202604200606.7BHpBMyA-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5=
bac06718f502014fade905512f1d26d578a18f3)
> smatch: v0.5.0-9007-gcf3ea02b
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260420/202604200606.7BHpBMyA-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604200606.7BHpBMyA-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16e8 (section=
: __ex_table) -> .L0  (section: .debug_str)
> ERROR: modpost: __ex_table+0x16e8 references non-executable section '.deb=
ug_str'

The mentioned ublk patch was merged to v6.15 as:

1d781c0de08c ublk: add helper of ublk_need_map_io()

which also shouldn't cause the failure.

Thanks,
Ming Lei

