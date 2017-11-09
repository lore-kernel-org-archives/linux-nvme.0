From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 12:31:53 +0200
Subject: [PATCH] nvme-pci: avoid dereference of symbol from unloaded module
In-Reply-To: <20171108181531.GA6606@infradead.org>
References: <20171102093624.20333-1-ming.lei@redhat.com>
 <8b9a2473-c011-6224-b69a-61194cfac030@grimberg.me>
 <20171102122926.GB6764@ming.t460p> <20171108181531.GA6606@infradead.org>
Message-ID: <b70e6cb0-3f6c-73e1-8bc1-078eb4e04dd0@grimberg.me>


>> The nvme_wq is shared by all kinds of host(PCI, FC, ...), so
>> not good to flush all queued work in 'nvme_wq' just before
>> removing pci host module only.
>>
>> Not mention 'remove_work' is actually scheduled by system wq
>> instead of nvme_wq.
> 
> Still seems better than messing with module reference counts.

And also does not change the behavior (failing module unload).
