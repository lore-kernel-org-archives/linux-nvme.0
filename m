From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 8 May 2019 14:39:13 +0200
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <20190506125752.GA5288@lst.de>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
 <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
 <20190506125752.GA5288@lst.de>
Message-ID: <a789d935-e665-c339-d7ae-3d23997b92d9@redhat.com>

On 06/05/19 07:57, Christoph Hellwig wrote:
> 
> Or to put it into another way:  unless your paravirt interface requires
> zero specific changes to the core nvme code it is not acceptable at all.

I'm not sure it's possible to attain that goal, however I agree that
putting the control plane in the kernel is probably not a good idea, so
the vhost model is better than mdev for this usecase.

In addition, unless it is possible for the driver to pass the queue
directly to the guests, there probably isn't much advantage in putting
the driver in the kernel at all.  Maxim, do you have numbers for 1) QEMU
with aio 2) QEMU with VFIO-based userspace nvme driver 3) nvme-mdev?

Paolo
