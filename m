From: eli@dev.mellanox.co.il (Eli Cohen)
Date: Thu, 10 Oct 2013 18:29:45 +0300
Subject: [PATCH RFC 50/77] mlx5: Update MSI/MSI-X interrupts enablement
 code
In-Reply-To: <20131003194837.GA27636@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
 <20131003071433.GA7299@mtldesk30>
 <20131003194837.GA27636@dhcp-26-207.brq.redhat.com>
Message-ID: <20131010152945.GC7299@mtldesk30>

On Thu, Oct 03, 2013@09:48:39PM +0200, Alexander Gordeev wrote:
> 
> pci_enable_msix() may fail, but it can not return a positive number.
>

That is true according to the current logic but the comment on top of
pci_enable_msix() still says:
"A return of < 0 indicates a failure.  Or a return of > 0 indicates
that driver request is exceeding the number of irqs or MSI-X vectors
available"

So you're counting on an implementation that may change in the future.
I think leaving the code as it is now is safer.
