Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32EFC369BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0SEFSDms0Srjc0vCBYMqkmnUZuH7wz5CdiiKrbnvac=; b=1391l0DcQLxp2MTAfyvo+5yZou
	NjGQ/8ks933rHxzeu7Q1NMpr1Rhg8K9u3/he/a216cCCOOurV4eNpYR+5dYtTbxTlHDSdYrzd7AJ4
	lt9cf0c79JAmHCmSuPTBpamlnLGxbz4L+GQOX6cXrBiI/UiMaeA3Xawy9O80ZFdrFoduGV1eHUbKS
	j8ytGaDH/T2VMCLOwBR37IuGvqIlPlKq8W9qVmoMa8jfq2SO6+mnJHvhWgVljug188o+IEwlMt9yu
	TgvRxOx0H69IP8uzv5ucuHNuE2R0cTnIKJZk4lg6FDLOT2/cpb/HH2uOVqEYW3KioemsUFDEJbo+t
	ImldaIKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Bkn-0000000B6cI-2nw0;
	Wed, 16 Apr 2025 23:01:13 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Biu-0000000B6MJ-33sw
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 22:59:17 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-736c3e7b390so88524b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744844355; x=1745449155; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0SEFSDms0Srjc0vCBYMqkmnUZuH7wz5CdiiKrbnvac=;
        b=E9IqNIEz2VQb0MqD0kFKy3i4Tw0hkhKYqGq8CgJBlV6RRp7ZXex+pi26sxWnTgYBz/
         938+WxKAafeMcT454twy72AmKThthwz7N4jorWpp8CZQH/HkUK9pN2NX+wO/iVw0oOOy
         9yzMqOBK4tupvWD4pBx8WgpucXV19QIjX4EOTXAoJ1btjp9rjn54vm1lZfBBA+ZI+ocV
         SFWdaXOYdAcaS9O53Q1G4145NIqCLLbbudIC1BuSRDRBgTg2xSqmdNHETNltyA0VC24B
         SJ1dcOf0H2RZksbuABWuN+vky3Kc2QbMvEDO1hDTsUT+6p5bpg9v0GWg9rH7mYjOzfHX
         OwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744844355; x=1745449155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0SEFSDms0Srjc0vCBYMqkmnUZuH7wz5CdiiKrbnvac=;
        b=rLOelyT63btz9TuJFsUUiso4RS4ZXk3nyfnu99cGCv1pF66U5px1fhsaR5GegodJxu
         ekj6uwolld45C7uluXGDD5z0tyITyG2Fva0rwAQYHWtzWO7uUXftTBGX/w4h3+4wGHZz
         yKebIuzczlZFfwHPbLVKrgyg6RkHzpGTGUHMwYIBleqntAp+VZqF9mvXNdtyNQ2owcQs
         DbOtrI/XujaJS95sJ9hLhjed+rkX/rqpzzxmt1O3lWJFfmdOwpuUmgm3/iliEAHI+Acr
         1R+tUPvUnZFGQhm3/E2t4ngu94dVNvPOOU9ObAec8FFDZxkrkzZrG7ZsmDkD7tz02KET
         j75A==
X-Forwarded-Encrypted: i=1; AJvYcCVNEaiM4la6Ph4FjOlFFWla9kAJ0P8DLK+SN69bx0W/8ilhxVQ+LAR89IGlumI3KQyBog2CXtBcA6/t@lists.infradead.org
X-Gm-Message-State: AOJu0YwZcaMwGyJUOrKh1f74fDwgXSEOzffASPpsOfzqcsMMdHZapGn9
	zzof48Q2ZNbg4ayWNCh/8zZJr8fLOwWmHv9SW9eA8ztp28CxMlpdqeGXGGqerEc=
X-Gm-Gg: ASbGncss1/4s60yJEeR5SKQOA6nLQlg081TrIa2xI6eHBsLhN6gbVYCSNFT6ZJqsXGW
	X0mpjd4dyM+ZN/RJGHh5PVqR0eISjdz2SGCRJTF5Q3A6KPrgwcca6NW1SzsQ1Y8NQkoY8xESJI2
	NEn/sC+8JBV++ViyOElO3YDzZMItBpM/koxGEZUagSswmgwKAEQJ8Iq0eapzkuxGML+blIGudg0
	59+mVPwDm4Yv5GVJNY/oQLnlMccVbiocnbNQ8WG0urXlBkTCeeR6WMBnb6jWPwLgO11rEyew+kq
	lO9SUc+IVmG0injmYKmEiGMccFoBWTosvFuvHOqMrvrY7TY=
X-Google-Smtp-Source: AGHT+IFSEYg7McQOY/czenNGbNNAfA2OUrmKCVnpYselYnTzk2rudOCU17EHO8GEU4xVRm4hqObtOA==
X-Received: by 2002:a05:6a20:c797:b0:1ee:a914:1d67 with SMTP id adf61e73a8af0-203b3e505f1mr6482906637.2.1744844355423;
        Wed, 16 Apr 2025 15:59:15 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8900:32c0::c137])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b0b220e997asm1836362a12.37.2025.04.16.15.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:59:14 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:59:13 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <20250416225913.GA2476975-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
 <20250416004016.GC78596-mkhalfella@purestorage.com>
 <3dad09ce-151d-41fc-8137-56a931c4c224@flourine.local>
 <20250416135318.GI1868505-mkhalfella@purestorage.com>
 <df6cd26e-551a-4bc1-bdc6-9c715e502aa8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6cd26e-551a-4bc1-bdc6-9c715e502aa8@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_155916_767482_219AED88 
X-CRM114-Status: GOOD (  26.73  )
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

On 2025-04-17 01:21:08 +0300, Sagi Grimberg wrote:
> 
> 
> On 16/04/2025 16:53, Mohamed Khalfella wrote:
> > On 2025-04-16 10:30:11 +0200, Daniel Wagner wrote:
> >> On Tue, Apr 15, 2025 at 05:40:16PM -0700, Mohamed Khalfella wrote:
> >>> On 2025-04-15 14:17:48 +0200, Daniel Wagner wrote:
> >>>> Pasthrough commands should fail immediately. Userland is in charge here,
> >>>> not the kernel. At least this what should happen here.
> >>> I see your point. Unless I am missing something these requests should be
> >>> held equally to bio requests from multipath layer. Let us say app
> >>> submitted write a request that got canceled immediately, how does the app
> >>> know when it is safe to retry the write request?
> >> Good question, but nothing new as far I can tell. If the kernel doesn't
> >> start to retry passthru IO commands, we have to figure out how to pass
> >> additional information to the userland.
> >>
> > nvme multipath does not retry passthru commands. That is said, there is
> > nothing prevents userspace from retrying canceled command immediately
> > resulting in the unwanted behavior these very patches try to address.
> 
> userspace can read the controller cqt and implement the retry logic on 
> its own.
> If it doesn't/can't, it should use normal fs io. the driver does not 
> handle passthru retries.

passthru requests are not very different from normal IO. If the driver
holds normal IO requests to prevent corruption, it should hold passthru
requests too, for the same reason, no?

IMO, keeping the request holding logic in the driver makes more sense
than implementing it in userspace. One reason is that CCR can help
release requests held requests faster.

> 
> >
> >>> Holding requests like write until it is safe to be retried is the whole
> >>> point of this work, right?
> >> My first goal was to address the IO commands submitted via the block
> >> layer. I didn't had the IO passthru interface on my radar. I agree,
> >> getting the IO passthru path correct is also good idea.
> > Okay. This will be addressed in the next revision, right?
> 
> I don't think it should. passthru IO requires the issuer to understand 
> the nvme
> device, and CQT falls under this definition.

