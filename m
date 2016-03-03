From: tgooding@us.ibm.com (Thomas Gooding)
Date: Thu, 3 Mar 2016 11:00:01 -0600
Subject: Tested LBA size ?
In-Reply-To: <56D85087.7060909@ip-maker.com>
References: <56D723B9.6030004@ip-maker.com>
 <20160303084729.GA1280@infradead.org>
 <56D80AB7.4040607@ip-maker.com>
 <20160303141659.GB1004@localhost.localdomain> <56D85087.7060909@ip-maker.com>
Message-ID: <201603031700.u23H0DIh011483@d01av03.pok.ibm.com>

For what its worth, Linux on OpenPower typically runs with a memory page 
size of 64kB.  That would give the opportunity to test with a larger LBA. 
 

Tom


"Linux-nvme" <linux-nvme-bounces at lists.infradead.org> wrote on 03/03/2016 
08:56:07 AM:

> From: Olivier Mallinger - IP Maker <olivier.mallinger at ip-maker.com>
> To: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at infradead.org>, 
linux-nvme at lists.infradead.org
> Date: 03/03/2016 08:58 AM
> Subject: Re: Tested LBA size ?
> Sent by: "Linux-nvme" <linux-nvme-bounces at lists.infradead.org>
> 
> So, "getconf PAGESIZE" returns 4096.
> 
> For my understanding, in NVMe system for data transfers, basically two 
> sizes have to be managed :
>    - MPS :Memory Page Size which defines the size of pages to be 
transferred
>    - LBA data size which defines the size of the logical block.
> 
>  From the NVMe controller point of view, these two value needs to be 
> computed for each command (Read/Write) to know the number of page (MPS) 
> to be transferred.
> So controller has to be able to support all combination of MPS and LBA 
size.
> 
>  From the Linux point of view, your answer make me think that all is 
> based on PAGESIZE and so PAGESIZE defined both MPS and LBA Size (or at 
> least their maximum values as it works with 512 bytes LBA size for 
example).
> Am I right ? And so a NVMe device including namespace with LBA size 
> higher than 4kB will never work on a Linux with a PAGESIZE set to 4096 ?
> 
> Thanks.
> Regards.
> Olivier.
> 
> Le 03/03/2016 15:17, Keith Busch a ?crit :
> > On Thu, Mar 03, 2016 at 10:58:15AM +0100, Olivier Mallinger - IP 
> Maker wrote:
> >> By VM, you mean "Virtual Machine" ?
> > VM -- Virtual Memory
> >
> >> Can I conclude that VM page size is generally 4kB today ? an you
> >> confirm that ?
> > Probably. 4k is the most common VM page size. It's the only supported 
size
> > on x86. If using something else, YMMV. To confirm, run:
> >
> >    # getconf PAGESIZE
> 
> [attachment "olivier_mallinger.vcf" deleted by Thomas Gooding/
> Rochester/IBM] _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
