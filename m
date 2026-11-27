Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C5606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t7X/NoGD;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Kp9vwvwD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=; b=t7X/NoGDV2TgwXTe30BF3vNMUp
	bLSfSKbgRG1FczOwIF3f9ufX+7wEQtSp7XAeuYyqt3glWGOoJSLmGNVLGcMBC/wfK4BzJZcsmHhzV
	ZPFeouhy3wGXoT9DDVEs9K18RhBUn+qgUiKpodUPqJZrSyEP0pgfNBW5BlfGREdbgl+lx2m50547l
	5JhHl2dpnoPrEXWOCFIQ5H5HD3taFxqGhIShtiK7xn19NgkZbI81N0kVkZK1lic27RtztOGf+i9YS
	MYFAcqJLU5VYIYqeRpOgdYIqPttAVDp7a92R8vNepAzqC+xn9by4V+IBhqIsVMdS3vA6TYLv0H34D
	GaT/UhHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqWh-0000000F8zB-1I2D;
	Fri, 27 Nov 2026 07:37:47 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWjxo-0000000EhlR-2qSd
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 00:37:22 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5363c8de563so76138861cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2026 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795739839; x=1796344639; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
        b=Kp9vwvwDq8BYxZ93oJiOhEWlobiWO76nAo+gO2ZQKD4a8enljX2fpZYLypQaTXjV2c
         rmG2O8etbdLKAuOzLNKVBdwyBt8fYFGYKX0evdzOmOyBTKYVQq3BRnugB6uTDJ3KwMAu
         O6RUDy7ByJoaXCaXsnSOmOhv+svyQ0KjTRpeFMUFWj795UMVUiqm9QbAH/+JVSqIm1g/
         7laJdYXqFJn+aqnyfNOzi1wzgj+cHSKR8wAaMaXEH6hNwLJpRD3UztJA4VG52FvcxA0n
         ZZqHFY6jR7R3FoA45vkOLjOeDwbeMcdKAGnXxKM0TUs6HA2Ivp0qQR/172pvm6r2yVkG
         aOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795739839; x=1796344639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
        b=12FvyZwQt/28Ink5YAG1+1BwUuFejZPDbO2V1we2f6CPjLMEqwtAlkP1qffopKdfd6
         J4f2KxAHPfJje6N+6E7a9oJ9Liv2axVDlm6r4KdS89vvPVOeTPKnOarIhH2angmdYbR6
         mZ8SiCV/177Is5CnR6FM+FtCf6TlnO4b7o9ZruqOLbrE9WaVF4Lxjmjj9i2RwS8oyKRX
         X/Mb9GBwG7aKTtRnKs1m9Jp+BG8D421TK+UQfJvDDPn9kRAcKlCelpVHO+aYO0dREYRM
         KbDtVbhpHtW5Mf6QeEqdOLLPzD4/M1wsWdJBAd93p9IJJpWOlh/now+2EaB/9ZPWVJIv
         2ePw==
X-Forwarded-Encrypted: i=1; AL+hErHMSJ2+xntN3iDhH09krsC7axhy+nj3q/UDAAYkr9lvDARfaFVEQYKBCsKTrrlAUmoLzkZFkddmJ5no@lists.infradead.org
X-Gm-Message-State: APuU4Z+cHuBGNJffUaGCWqYpXKzSVums7ZaZUgiHY6v1Q8pYgIfSFJ4Y
	kgr1x/oMnFRLI1AuG2iZPbQZKenE4qMvyBe1QMcm8D/3C9CnPGpdGf7prEzR6BwEADQ=
X-Gm-Gg: AZFdTZeHi+WvYY6FiXOL1zaRwipFWjZZMiXL38jO8VC7z4DaBJqsAJbCAAWWoSz54Lr
	O0IFgoMFyFFj0WyBLXJmzPtmfprLOQYRwK+jwgrOaA+eYzZ4NOXjMmkGZDtrN0y5eaWbPiD15zR
	WZKR0uuOhTQjGnBnrfV7LoP/V6xBEnsI16cyyFDJ04K9ZBIR5IhKy3LymRWUS+Hk75f2v1yrWij
	Gl8vvMfMLUu0gJbkYG7Qu+vtxGyN8tJY3u85lBIlWGnVj6n+D52SG0FaXllm1gUxrfSSgHB812D
	SMtAX7pbmxFVERpjuAO0WJatuspo5zmmHcSGSy+AVc9juyw1IuQ/lYrol++nbqAvyl82YE4/mnn
	zuPRGtCFPyra+Q6ALJnxxK0vYDuvFGhp6T6dP4kBc3D0qPTpiddScYMJu0jafJDeAV2OxWEpHjf
	uHvHjIpi31hjtDYTwzY5n8LtrrZ0A8tMUj6zmAlHwucCHiYNZsqrVMFo6e/Q77OicZkur6chY+A
	1GU4EnbfxFDJxrxymTDExNkIvlvQ2kZUudG5L8m7yZhTYC/XFLc67zI/KoeAeU/hi8cDKlH+1dw
	Xvv5zw==
X-Received: by 2002:a05:622a:1f13:b0:533:8900:4eae with SMTP id d75a77b69052e-55d76a168d0mr403124891cf.13.1795739839275;
        Thu, 26 Nov 2026 16:37:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm192115611cf.17.2026.11.26.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:37:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWjxm-00000005OdJ-0d4j;
	Thu, 26 Nov 2026 20:37:18 -0400
Date: Thu, 26 Nov 2026 20:37:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
	treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261127003718.GR246011@ziepe.ca>
References: <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
 <20261125190705.GN246011@ziepe.ca>
 <awfMy1d8ICL6mr9i@nvdebian.thelocal>
 <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_163720_830419_4BF05E36 
X-CRM114-Status: GOOD (  10.48  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Thu, 26 Nov 2026 23:37:45 -0800
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 10:58:13AM +0100, Christian König wrote:
> Would it help if have a call on Teams or similar services to discuss the whole thing?
> 
> That might be easier and especially faster than by mail.

I think that is a good idea, I suggest you and Alistair should pick a
time and see who else can come. From experience eu/au/eastern na
doesn't jive :)

Jason

