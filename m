Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C815C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=; b=avxjDcNiVL6KRskHNON/3ldd3x
	uFYSqKYSYGgNucGolJK6sp19Xq4GVw9HI1sx9je6M5gqohJFKGNKpQaQqsplQWqe3PXIpb/ZnuhcL
	eFrNZiEH9En13LVdHN2ZXppMlnJZB1jKsntQQ6pu4sXXLTScM+AJxcFX6+W7v3NctZy5jjscUGwif
	MmJ3BQyadA9zKJyODF59bB5K4p0ee1jjRgcshVERNe2GjXu5COG+zN+PMR8Y9VxGo8xfKD5JmYC3M
	aYtr93+qd0B98M1WYow8H/iTeouj0+weE8eQSoGiZHsNIEqMlos9EQ6U9gBAIv+e5S+Zd0Le+VpBq
	LX4EucqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmyLG-00000000WNs-4688;
	Tue, 25 Feb 2025 17:03:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfqv-0000000FD5I-2QBP
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 21:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=;
	b=LqNDiC82vdKj1lUIj1FS67vvq8PZ5rplEr6vO1z6gyh/KpT6vwmkrV9Jgm5oGjlVUFEuKr
	mlHM0YPZY4UBNxw/fzWxblNHAdc4m2hbuHAHPnThiMrv0eLVsRUm2+qzrWC/xfd+N4kzUQ
	D4ZGHDulm68HHC1rOUnm7SFruY5cOWw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Es3-jOANMemF3mJ-D_D0IA-1; Mon, 24 Feb 2025 16:18:58 -0500
X-MC-Unique: Es3-jOANMemF3mJ-D_D0IA-1
X-Mimecast-MFC-AGG-ID: Es3-jOANMemF3mJ-D_D0IA_1740431937
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e08b755856so4119348a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 13:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431937; x=1741036737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=;
        b=SSKcpSaBCAmkFjIgvJL/UcFtSQG5MiiPCzkud1vzf63jf2dogp8Hg2aIOzbPm6tzVA
         gwz4UWnQvCcuw06jIy2qCF/TMsfagecJ9vrJl9ybMzYEDKQY4zwsBRbV+03LxQBOlSGq
         3QslU33ND6m4P+46GSIIBJVu25klKw0t2ieTxIjVVqF9hHVQCRHY4AhBMfMy1UG17qvB
         POo5PLv4aIHp7ctOiej+v54D642G3fI5KsYwYhA6eCEq6vG0SCLsI/pe29S5UztCq/Pc
         kqE7EeuMRrG9KUzYZL1XQqc24oIwVAZ92qm+OJpRJeRJAAp+CN89dsFnKgvg74I61Eqb
         LYVw==
X-Forwarded-Encrypted: i=1; AJvYcCUBqEA5ux2t0AcYoakcW/A0iDs2Aw/mVMAtbiJISHn2G1tH/L5nYQ+OKZCvELtU2zTre7d2ppVktQrP@lists.infradead.org
X-Gm-Message-State: AOJu0Yxm72aG1J17GYeSjmLDq+7yeFyJgxuYtl5SuLm/SF/NiBorJuOM
	wmvG3IdVuLg/u8qhplwREgsupnRTgfTJ16vv/n5gg451txew5bBP07kxQc4JvpCZbru+jvE1FF+
	Zy/y7gBUoI5rEUKEYipZjnSH658bpGr/2Xga7xIkm095U1CvC3bFYl6/qjo9rgQ7P
X-Gm-Gg: ASbGnctyGQy4AplDfO6FKFao87kJd9+NTuP6g9P3Y72i/iu+VE8apcojF3uisMMzUE1
	Osz1kEMQuP/vHCbvhtDIwhFsCtMs+QBvGquY1mP3mFtUrmfuFwHGoymNLoKQIomsuoFs9AKf237
	zpS1wD01Xi704AkjO9mMaCuxjnlWbd9PItyAsIIK5gnDBwjH0c3ZSiJRpkWUgbSqMV2rAt4H/Z1
	ZAgtK6GtHDtnDdkKm/ZWnZg7qcHJ2gixUDI4P+VPITDb95tpUiN2VptsPE7W5DOddwq2cftgM8k
	zU6rNsqgGA==
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abc099ead3amr1385577566b.2.1740431936629;
        Mon, 24 Feb 2025 13:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYEBC44CLKnEsK0LbK9e6zpwdED/WRkdl8e2EWDOlyh5Ynisvb1G99K7KkazLO1N5pYn2zMA==
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abc099ead3amr1385570066b.2.1740431936166;
        Mon, 24 Feb 2025 13:18:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20134fdsm23497166b.94.2025.02.24.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:18:55 -0800 (PST)
Date: Mon, 24 Feb 2025 16:18:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH v2 00/13] cpumask: cleanup cpumask_next_wrap()
 implementation and usage
Message-ID: <20250224161832-mutt-send-email-mst@kernel.org>
References: <20250128164646.4009-1-yury.norov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r1opC03iLkeoA_iYToatoOqnHXG4hbt5fIl6xXcpuXs_1740431937
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_131901_690071_8BDF85C4 
X-CRM114-Status: GOOD (  28.03  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 08:58:02 -0800
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

On Tue, Jan 28, 2025 at 11:46:29AM -0500, Yury Norov wrote:
> cpumask_next_wrap() is overly complicated, comparing to it's generic
> version find_next_bit_wrap(), not mentioning it duplicates the above.
> It roots to the times when the function was used in the implementation
> of for_each_cpu_wrap() iterator. The function has 2 additional parameters
> that were used to catch loop termination condition for the iterator.
> (Although, only one is needed.)
> 
> Since 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> macro"), for_each_cpu_wrap() is wired to corresponding generic
> wrapping bitmap iterator, and additional complexity of
> cpumask_next_wrap() is not needed anymore.
> 
> All existing users call cpumask_next_wrap() in a manner that makes
> it possible to turn it to a straight and simple alias to
> find_next_bit_wrap().
> 
> This series replaces historical 4-parameter cpumask_next_wrap() with a
> thin 2-parameter wrapper around find_next_bit_wrap().
> 
> Where it's possible to use for_each_cpu_wrap() iterator, the code is
> switched to use it because it's always preferable to use iterators over
> open loops.
> 
> This series touches various scattered subsystems and To-list for the
> whole series is quite a long. To minimize noise, I send cover-letter and
> key patches #5 and 6 to every person involved. All other patches are sent
> individually to those pointed by scripts/get_maintainers.pl.
> 
> I'd like to move the series with my bitmap-for-next branch as a whole.


virtio-net changes are straight-forward, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1: https://lore.kernel.org/netdev/20241228184949.31582-1-yury.norov@gmail.com/T/
> v2:
>  - rebase on top of today's origin/master;
>  - drop #v1-10: not needed since v6.14 @ Sagi Grinberg;
>  - #2, #3: fix picking next unused CPU @ Nick Child;
>  - fix typos, cleanup comments @ Bjorn Helgaas, Alexander Gordeev;
>  - CC Christoph Hellwig for the whole series.
> 
> Yury Norov (13):
>   objpool: rework objpool_pop()
>   virtio_net: simplify virtnet_set_affinity()
>   ibmvnic: simplify ibmvnic_set_queue_affinity()
>   powerpc/xmon: simplify xmon_batch_next_cpu()
>   cpumask: deprecate cpumask_next_wrap()
>   cpumask: re-introduce cpumask_next{,_and}_wrap()
>   cpumask: use cpumask_next_wrap() where appropriate
>   padata: switch padata_find_next() to using cpumask_next_wrap()
>   s390: switch stop_machine_yield() to using cpumask_next_wrap()
>   scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
>   scsi: lpfc: rework lpfc_next_{online,present}_cpu()
>   PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using
>     cpumask_next_wrap()
>   cpumask: drop cpumask_next_wrap_old()
> 
>  arch/powerpc/xmon/xmon.c            |  6 +--
>  arch/s390/kernel/processor.c        |  2 +-
>  drivers/net/ethernet/ibm/ibmvnic.c  | 18 +++++---
>  drivers/net/virtio_net.c            | 12 ++---
>  drivers/pci/controller/pci-hyperv.c |  3 +-
>  drivers/scsi/lpfc/lpfc.h            | 23 +++-------
>  drivers/scsi/lpfc/lpfc_init.c       |  2 +-
>  include/linux/cpumask.h             | 69 ++++++++++++++++++++---------
>  include/linux/objpool.h             |  7 ++-
>  kernel/padata.c                     |  2 +-
>  lib/cpumask.c                       | 37 +---------------
>  11 files changed, 81 insertions(+), 100 deletions(-)
> 
> -- 
> 2.43.0


