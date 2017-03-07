From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 7 Mar 2017 20:57:04 +0100
Subject: [PATCH v3 01/16] lpfc: Correct WQ creation for pagesize
In-Reply-To: <7c6d6f3b-330c-ea6f-ad3f-65479354c94d@linux.vnet.ibm.com>
References: <58a0d919.08BhoypOnvRSLIqV%jsmart2021@gmail.com>
 <6a197069-2f10-6df1-4cf1-1a62808c8903@linux.vnet.ibm.com>
 <yq1tw75kbdn.fsf@oracle.com>
 <7c6d6f3b-330c-ea6f-ad3f-65479354c94d@linux.vnet.ibm.com>
Message-ID: <20170307195704.GB25619@kroah.com>

On Tue, Mar 07, 2017@10:44:51AM -0300, Mauricio Faria de Oliveira wrote:
> Hello stable kernel maintainers,
> 
> On 03/07/2017 12:35 AM, Martin K. Petersen wrote:
> > Mauricio> Please flag this patch for stable.
> > 
> > Mauricio> This patch resolves a serious problem on IBM Power systems at
> > Mauricio> least.
> > 
> > Both patches are already upstream so I can't tag them for stable. Either
> > you or James should mail stable at vger.kernel.org and request for the
> > patches to be queued up.
> 
> Can this commit be included on stable v4.4+ , please? (in Linus tree)
> 
>     8ea73db486cda442f0671f4bc9c03a76be398a28 "scsi: lpfc: Correct WQ
> creation for pagesize"

I need an ack from a scsi maintainer that this is an ok thing to do
before I can do so.

thanks,

greg k-h
