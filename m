From: olivier.mallinger@ip-maker.com (Olivier Mallinger - IP Maker)
Date: Thu, 3 Mar 2016 15:56:07 +0100
Subject: Tested LBA size ?
In-Reply-To: <20160303141659.GB1004@localhost.localdomain>
References: <56D723B9.6030004@ip-maker.com>
 <20160303084729.GA1280@infradead.org> <56D80AB7.4040607@ip-maker.com>
 <20160303141659.GB1004@localhost.localdomain>
Message-ID: <56D85087.7060909@ip-maker.com>

So, "getconf PAGESIZE" returns 4096.

For my understanding, in NVMe system for data transfers, basically two 
sizes have to be managed :
   - MPS :Memory Page Size which defines the size of pages to be transferred
   - LBA data size which defines the size of the logical block.

 From the NVMe controller point of view, these two value needs to be 
computed for each command (Read/Write) to know the number of page (MPS) 
to be transferred.
So controller has to be able to support all combination of MPS and LBA size.

 From the Linux point of view, your answer make me think that all is 
based on PAGESIZE and so PAGESIZE defined both MPS and LBA Size (or at 
least their maximum values as it works with 512 bytes LBA size for example).
Am I right ? And so a NVMe device including namespace with LBA size 
higher than 4kB will never work on a Linux with a PAGESIZE set to 4096 ?

Thanks.
Regards.
Olivier.

Le 03/03/2016 15:17, Keith Busch a ?crit :
> On Thu, Mar 03, 2016@10:58:15AM +0100, Olivier Mallinger - IP Maker wrote:
>> By VM, you mean "Virtual Machine" ?
> VM -- Virtual Memory
>
>> Can I conclude that VM page size is generally 4kB today ? an you
>> confirm that ?
> Probably. 4k is the most common VM page size. It's the only supported size
> on x86. If using something else, YMMV. To confirm, run:
>
>    # getconf PAGESIZE

-------------- next part --------------
A non-text attachment was scrubbed...
Name: olivier_mallinger.vcf
Type: text/x-vcard
Size: 316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160303/778c2c90/attachment.vcf>
