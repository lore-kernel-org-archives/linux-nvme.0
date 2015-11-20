From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Nov 2015 08:47:09 -0800
Subject: nvme lightnvm comments
In-Reply-To: <564EFEBC.3040603@bjorling.me>
References: <20151120105022.GA22131@infradead.org>
 <564EFEBC.3040603@bjorling.me>
Message-ID: <20151120164709.GA9931@infradead.org>

On Fri, Nov 20, 2015@12:06:36PM +0100, Matias Bj?rling wrote:
> >  2) please build the lightnvm.o object conditionally in the makefile
> 
> Then the functions
> 
> nvme_nvm_register
> nvme_nvm_unregister
> nvme_nvm_register
> 
> have to be #ifdef'ed in the pci file. Do you want that instead? It was on
> purpose the other way around, so that the nvme_nvm_* functions was null
> functions if lightnvm isn't compiled in.

Just keep the stubs as inlines in the header.
