Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B3CC369C9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Nu20yeS1DzV9UcL7Y7462wf+3OF505hDt3PvXw7uJg=; b=0i2m1O/IIqPCQBnUpcrXHI4Gj/
	KVtu3eTxsvRBqA0Ffgfw0e7SdwRwq+Frd0lXACstRixU8c2RnDd5R7ObAubOcIp/WkIJVp6t3AHSs
	4Prh0plXVk5xME5axTLuTB9U2GX5f2oUHPsssulJliqMgDLryNw0OLE93f5W9pSfSdqTLoWd9omG/
	0tdqyaCgmYGmMw2l0TA8vwhrSRUC3zC7801UP55dlPIY8+VqQZXSFR/0zUW2aycYGDIJLrZWIjXWh
	tFzji5HCDlYY1GBqu6cCZwGnQJ/OMZdYg+OMKB1QNBdbdISUyKnUphAwquxKr8TZIOhvaOddn5RxP
	Fhxd31+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Uu5-0000000EAXT-2Dex;
	Thu, 17 Apr 2025 19:28:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Uu3-0000000EAXG-3qcw
	for linux-nvme@bombadil.infradead.org;
	Thu, 17 Apr 2025 19:28:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0Nu20yeS1DzV9UcL7Y7462wf+3OF505hDt3PvXw7uJg=; b=N7dPrC8PVjY7KFlu6TshlTYatr
	gMY/ZSYKJHI5mWsOioofx1b1hqC/MBkAuL2kXIUV2KLxO4DzBEDQ32p8NSaqIfJLfZtU4VDa0lG1F
	iFhJZ4cX/LBmxCIzcRy4Cd8cU7lsurgz/6ZUAgE9wgBR/q7FCSzshoYnopZQTVMOZ7zx1kDOEQJiA
	Tsj/TANI7vBpCIiZ5kWADrLVjLxqYNpwMretD6j8dds3BmLqAhK+OvHRO5/J8JSfBGb/JkQUJgRIN
	Hs2kFqktxlOPIVpELYpPPwdE5THVCI4f7VWLVPjUxEPrYtb7wAKXNOl6dWUx3gE7PYqV0mEN07hrD
	AOh/4vfg==;
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u5Utz-0000000AO8M-3NX7
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 19:28:02 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so139621a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Apr 2025 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744918075; x=1745522875; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nu20yeS1DzV9UcL7Y7462wf+3OF505hDt3PvXw7uJg=;
        b=U+OdM1wfUsltZlZmdKUtz6E7fcTbG4PzCw7qwv89QyIQwlNObelkYrgbxCW9R9MvVy
         Xujphq5gyU5TK49VWYFuGtrLsyIfFOtMZbBjjZE7RO0napg9WKbUJwJytRg0eyyhIaSn
         2L3UkVcobUyNoJaoO5/K1HtFuaMqBxhp1zY3dbV/hmoUSEviZTE5c1F2UBQourbEPJGl
         Mi5ftdLLQb+24gHIbY0xFEqd7mBaDbmJ4PIiU1eMhJ0oPgkXzS4+OLdEfu/Y3F9Jqs8G
         Wp+9Qksit2MgUKe02FSCeU3n1yhJGu1BIU0oGPyCvZqp7XkdNeZwXroJ9j8zMU+G04Ns
         uOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744918075; x=1745522875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nu20yeS1DzV9UcL7Y7462wf+3OF505hDt3PvXw7uJg=;
        b=eqpwRHyf85G6/MiY+ku56GkoDpilNjEGuSLVAh3ChMtTn6VSalFk2WOSWDbUABiFS+
         5xLxcIDmMvnCfOjMzzE5y+3wFuPBuRhb8wM0ocUWwYJcTW6WpvZd1RsUGj88WoyE8AvM
         ESFLsfnEi7Yk+fthFqPoQ8LVCMKz7LkZl1C/bYRSNlmFXmoq+WMYXnnJHMlx3ij7XkqT
         k/b7TU5HwAfES4JmuxfuLt4moG9zFexmOWtVtxDUAYVr8BdGp7tVzkLDLjDSacbq0H79
         MUe/lp0c0hNN0DcCQXhwfnRVWtKqTx+wb0ZDrYLPA3sYeGSpDXBDf/qRFCHZXOBMyntc
         SJDQ==
X-Gm-Message-State: AOJu0YwYLY4tlvy9nK6eTvbvLTA6KZuQkh1kmf4HeE+CpAn/G3sSgeCv
	pK2tCCHkI498atHfJAJ+GSJN+i+JOIFCqy1m8ik9umApgihZczdvLgJgRO0CB15SO6CGfWVz5cX
	lpHnRCY9IcF0LIKunSTIH9SoDmafH+I2wLhlR4oJgJPWS8vR1
X-Gm-Gg: ASbGncuHQv3xgd9DqaR6LkoTQDDcspTAohOEo3Aak/+O+NfKdKZdSLPFZuzl3hxQnNo
	AHXqAahH0DnoW1wNPVid/zQsnv9jvfQ5mHMgISksaSb26rzFDugtBIqCUTjApJkK/RiM55NcblD
	0xJ7oHZks8nBJBrzrjdwd2
X-Google-Smtp-Source: AGHT+IGRmkHw0tM6REsdGEacYcdqemj4KZvD05VRsVpwaqFEnSN2f745wbm26yDu61wS/2rzDmNIPK11xMKRhMZCScY=
X-Received: by 2002:a17:90b:1b44:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-3087ba5ea96mr118136a91.0.1744918075246; Thu, 17 Apr 2025
 12:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
 <aAFF1b6Zld-Jln8j@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aAFF1b6Zld-Jln8j@kbusch-mbp.dhcp.thefacebook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 17 Apr 2025 12:27:43 -0700
X-Gm-Features: ATxdqUG8NRyE0aZwnw2eoyaeozWTJ4m4p_drBVIxeWB6RBoGtwl4wuLDgcBaB-k
Message-ID: <CADUfDZoYtDWyhXsN8C26OzAaU-RzzBW5+mGNf=sHWbYTFoTeoA@mail.gmail.com>
Subject: Re: DMA pool lock contention
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_202800_875704_D8FEEB9B 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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

On Thu, Apr 17, 2025 at 11:18=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Thu, Apr 17, 2025 at 10:06:11AM -0700, Caleb Sander Mateos wrote:
> > Hi Linux NVMe folks,
> > On a 32 KB NVMe passthru read workload, we see 2.4% of CPU time is
> > spent in _raw_spin_lock_irqsave called from dma_pool_alloc and
> > dma_pool_free.
>
> Just curious, do you have multiple cpu NUMA nodes here? Or do these CPUs
> share a last-level-cache?

CPUs from 2 NUMA nodes. Half of them are hypertwins of the others, so
the contention isn't quite as bad as it otherwise would be. Just
making the DMA pools per-NUMA-node would help considerably.

Best,
Caleb

