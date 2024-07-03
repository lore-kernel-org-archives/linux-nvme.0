Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE32FC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qP4/CssV7EecAy6DBJ2E05mJLaRfSKqBc4cWbAljFuc=; b=w0/EimITAVkzdFhLTqhM0sGTUf
	Dexqvi8xeRkMMEcu7/pv+JPhHOd5AKme6CThnBfgBy+Vueulg14Azz/SNtazJDZxwvMAHGmuKGR+B
	MO6UlNQOUUoYNbytR6QzQbgmKt/WCjbXhl5gssPHdpTvW7Kyt1B4Ay1ARlMvKDLprPlad9riuND6G
	jJPRo1j1a2CHDX1SQUiv44hVe/b9xjmnG8UAtI9q/kn/DGpDjGjBpyaENuck4GoPQ2JH7/mlhVJbc
	5H8VXE7SheYBTZ2/hv9pSGIbzbuFPlAgLmpf1fBieBbByWsHqaAmodMQB3qAJPsHgK7U5Rt9XwkZf
	dQW+RK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP2GT-0000000Akem-158K;
	Wed, 03 Jul 2024 15:51:25 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP2GR-0000000Akdv-0puV
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:51:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CB14ACE2B26;
	Wed,  3 Jul 2024 15:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E69C2BD10;
	Wed,  3 Jul 2024 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021880;
	bh=M2TBqenJePHMkynb5A1SIOpLVmH3H7D/iXSAlQYnb5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc+qeyNjcvMfXoLoLSYrV/OjBmRYjN560U9rM5g1KNtJfyhDmn8WFYPVUX8lcMSL6
	 khJVCU+KU0IiJB0lH+20qj4DzqeRN3kur43qZjoGlHey1qRNicXUsAjw8d2newAM5x
	 C+2La9qYNOaB19TaKRZeUR8kFkS7h1waDmf4ltPCmAiGBKFugxc54BFHXWm/8SeN1a
	 GFdr9hsxxrrrevbZ0JCLF/Lyi27Mu1ricAFJVROJUceiw5jv8XbgqQBBd0Xa8n4q+N
	 RK6NYvdVvLuJ0x0RwfmANnmb6Fu17VSB8t/0ZiSc4qAzbWALiN0J6a9hx7YlBm/nHW
	 7fUJVXY2mTrPQ==
Date: Wed, 3 Jul 2024 18:51:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240703155114.GB95824@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703143530.GA30857@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_085123_625185_2DF5B6B8 
X-CRM114-Status: GOOD (  19.98  )
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

On Wed, Jul 03, 2024 at 04:35:30PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 01:52:53PM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 03, 2024 at 07:42:38AM +0200, Christoph Hellwig wrote:
> > > I just tried to boot this on my usual qemu test setup with emulated
> > > nvme devices, and it dead-loops with messages like this fairly late
> > > in the boot cycle:
> > > 
> > > [   43.826627] iommu: unaligned: iova 0xfff7e000 pa 0x000000010be33650 size 0x1000 min_pagesz 0x1000
> > > [   43.826982] dma_mapping_error -12
> > > 
> > > passing intel_iommu=off instead of intel_iommu=on (expectedly) makes
> > > it go away.
> > 
> > Can you please share your kernel command line and qemu?
> > On my and Chaitanya setups it works fine.
> 
> qemu-system-x86_64 \
>         -nographic \
> 	-enable-kvm \
> 	-m 6g \
> 	-smp 4 \
> 	-cpu host \
> 	-M q35,kernel-irqchip=split \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "root=/dev/vda console=ttyS0,115200n8 intel_iommu=on" \
>         -device intel-iommu,intremap=on \
> 	-device ioh3420,multifunction=on,bus=pcie.0,id=port9-0,addr=9.0,chassis=0 \	
>         -blockdev driver=file,cache.direct=on,node-name=root,filename=/home/hch/images/bookworm.img \
> 	-blockdev driver=host_device,cache.direct=on,node-name=test,filename=/dev/nvme0n1p4 \
> 	-device virtio-blk,drive=root \
> 	-device nvme,drive=test,serial=1234

Thanks, Chaitanya will take a look.

If we put aside this issue, do you think that the proposed API is the right one?

BTW, I have more fancy command line, it is probably the root cause of working/not-working:
/opt/simx/bin/qemu-system-x86_64
        -append root=/dev/root rw ignore_loglevel rootfstype=9p
        rootflags="cache=loose,trans=virtio" earlyprintk=serial,ttyS0,115200
                console=hvc0 noibrs noibpb nopti nospectre_v2 nospectre_v1
                l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off
                mitigations=off panic_on_warn=1
                intel_iommu=on iommu=nopt iommu.forcedac=true
                vfio_iommu_type1.allow_unsafe_interrupts=1
                systemd.hostname=mtl-leonro-l-vm
        -chardev stdio,id=stdio,mux=on,signal=off   
        -cpu host                                  
        -device virtio-rng-pci                    
        -device virtio-balloon-pci               
        -device isa-serial,chardev=stdio        
        -device virtio-serial-pci              
        -device virtconsole,chardev=stdio     
        -device virtio-9p-pci,fsdev=host_fs,mount_tag=/dev/root  
        -device virtio-9p-pci,fsdev=host_bind_fs0,mount_tag=bind0
        -device virtio-9p-pci,fsdev=host_bind_fs1,mount_tag=bind1
        -device virtio-9p-pci,fsdev=host_bind_fs2,mount_tag=bind2
        -device intel-iommu,intremap=on 
        -device connectx7              
        -device nvme,drive=drv0,serial=foo 
        -drive file=/home/leonro/.cache/mellanox/mkt/nvme-1g.raw,if=none,id=drv0,format=raw 
        -enable-kvm                                                                        
        -fsdev local,id=host_bind_fs1,security_model=none,path=/logs          
        -fsdev local,id=host_fs,security_model=none,path=/mnt/self           
        -fsdev local,id=host_bind_fs0,security_model=none,path=/plugins     
        -fsdev local,id=host_bind_fs2,security_model=none,path=/home/leonro
        -fw_cfg etc/sercon-port,string=2  
        -kernel /home/leonro/src/kernel/arch/x86/boot/bzImage 
        -m 5G -machine q35,kernel-irqchip=split              
        -mon chardev=stdio                                  
        -net nic,model=virtio,macaddr=52:54:01:d8:e5:f9    
        -net user,hostfwd=tcp:127.0.0.1:46645-:22  
        -no-reboot -nodefaults -nographic -smp 16 -vga none 

> 
> 

