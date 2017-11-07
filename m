From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Nov 2017 17:28:28 +0100
Subject: [PATCH 3/3] nvme: fix eui_show() print format
In-Reply-To: <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de> <1509722197.15520.17.camel@perches.com>
 <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io>
Message-ID: <20171107162828.GA26824@lst.de>

On Sat, Nov 04, 2017@12:22:20PM +0100, Javier Gonz?lez wrote:
> > Perhaps this should just become
> > 
> > 	%8ph
> > 
> > without D
> 
> That would be ok with me.

Can you resend a patch for that?
