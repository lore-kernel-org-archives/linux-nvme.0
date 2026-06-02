Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3195ACD6E64
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=; b=XxLer598bECLYrhmMkZNzqc2oe
	ZDd0/5m4PIfS7XYb+KQ0L/lScVx9Z4riABJ4/77Kye6GI1s2a9ttkY73EmjK4yP5LediDdkGfSObL
	TEWACqsOxSmA/Z4sB2dxipBbfa80/QG0UffI8HuhDm0h3OKNDuarD3I3qg/B4l4nlHDIp/fFakrD0
	0JV71rxYjF6ACCIqC8YaA8GhHx9C7XCvaVXyIUm8RRJbWGoWXJKj6F5uZgyEd0Vf7UkR3wHbGpHUQ
	dSQk5O3UFQ+w4TVv1Iw1cY8Nhw7VSkKbkmF1UjT3cnytVUta+K2Ppmd8BLgoab5FA94+sSMMuB15S
	dLBDXHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQgX-0000000DFS5-2NNV;
	Tue, 02 Jun 2026 15:05:41 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUNBH-0000000Crj1-1JnD
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 11:21:12 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso20843525e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2026 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780399269; x=1781004069; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=;
        b=WhJHmapgIjwEJ2DAwpaaOlJyts7svK81zdcFTVPGT3t3QWTPgbU4KKpfK/bF9hM++1
         Nk31gnGzossLOVDIDwgdfklH5VqxSrbcc4HHl6Mj6fhXpJ0fjMHTnEADBb5Olxm7NSZP
         KAhDj1yM0BwPKz6h5MtcQdvMZ2nA/U84w2k9KN2DEXtEX6BX4KAz+z01eWmjHL4HOau3
         XVMK2HXC5txioxtyp/FNo6nkpUx1Ng1aGDQBrvzIC0aCb+gxu7qsAVRR6Qw0wgeZ0cmt
         nqaWh56ZdS8sBTIHXYWtedHT5qVIcda8wnCh67WtPi43Kgr9w3x3chFTUtHfT8jLIBlK
         XjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399269; x=1781004069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=;
        b=RN7bgb674NqIuqSp2LgQzwe4+27+UxFlat9UCuftTFGupTB8N/5uWEC/0Xl/ihlakd
         G1+LCddS0QCBk43ehX/PdmYB0ielYPIaSPXqMcgNz0QbdTJPMiwV05VfxBde2v6LIZVo
         oQoeN47qWSFKyzjHiBwmWFc3ENFHIti+Z8fqDJRcMFgkLE46xjDW0UOYU+xJ+PGslxCR
         N+Ig460LxakZh1I6mQd5OslhMNHpolcRfF1CygjN0IF36sR59Kz4jDgEPhYcNF8vhCvy
         7WAtA1upmF9Gbn8zikPiA2n1vr0G8z04OzRjoRPnsb+AuM6imwy0eON6kroWICECLuhu
         rxmw==
X-Forwarded-Encrypted: i=1; AFNElJ8rrfc7VL3mx363nXfUqAUCvQwyI3hPNNXkzTurkZFm4m1T+rLNy01WE4erNgY2c2N2X1afRkNoCI/c@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4w050Roo+sVTtx9Bv/zJvaJajbDV0gr3Aw++7X/mQ3YKaYyG4
	WXSBmsw99fihpJDWUTPEmGO4dE7OpSslHKd2PlY3nteZKkAnbpKHSXCw
X-Gm-Gg: Acq92OGrkH5HY6EWbysSVkL3bAe+ZH0kI2+dQkxMZL4jw0lonT8Dyj7FFn+nCoSVRDM
	WLA9Po769an60PytJ9XKO4NxgQ0sODINiiVrAV0ZHLBosozMFzymkPUrmWBIB3DuelMRs9wAb/n
	HsV+aUkKSqpsjh+siakl2jAhPrLfszCvEtFtFj50zwZVpHqGC5nAD6zCX2sfM2MTMozGcxjBWuq
	wL2gpYeWULOhtdHh44Hvn8tLCtmXI1qgp74hburN9gGIeH4KwssrPM3yHgadce0Oz2hwqogIelF
	wpWZBs5UW+0e0D1uo8/lyCPRJyGPC5lX2sLreR0Dtnu6O9heJUaSoyVcz661fzZb4sqJOXR9Kt7
	TAMjZ7N6vhCrHQD4KDzFcXo7J4uhdnj8mFrxCvtmUk2PtoFz88/4RBpmDELjtNt0UasEuE2ii9l
	6H+ekkA+tr5wqqSSERLTfPexQgO2UiSGmg3BphVxkidqsV8GHh+GCg0IyozE/XbiwnDd+LY3M=
X-Received: by 2002:a05:600c:46d1:b0:490:a7ab:bbe3 with SMTP id 5b1f17b1804b1-490a7abbd7fmr206981415e9.0.1780399268568;
        Tue, 02 Jun 2026 04:21:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm31033836f8f.26.2026.06.02.04.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:21:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:21:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, mkalderon@marvell.com, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
 sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
 jinpu.wang@ionos.com, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, ebadger@purestorage.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260602122104.20afa8b4@pumpkin>
In-Reply-To: <ah6gtquGDMvEXjcb@ashevche-desk.local>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
	<5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
	<ah6gtquGDMvEXjcb@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_042111_374730_7F4DC6DE 
X-CRM114-Status: GOOD (  18.94  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:05:35 -0700
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

On Tue, 2 Jun 2026 12:21:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> > On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:  
> 
> ...
> 
> > > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);  
> > 
> > min_t() shouldn't be used if there is an alternative available. For the
> > SRP drivers, please make sure that both arguments of min() are unsigned
> > instead of using min_t().  
> 
> Ah, I just answered in similar way against v5. I also mentioned clamp() there.
> 

IMHO it is also best to do min(value, 255) not min(255, value).
Like an 'if' put the value you are comparing against second.

The min_t(u8, x, y) you've removed are usually broken.

Maybe I should change clamp() to allow clamp(int_var, 0, unsigned_var).
That will need the order of the compares swapping (to do the low bound
first).
I think they used to be that way around, got changed by a commit that
said it didn't change it!
Correct code shouldn't care.

-- David

