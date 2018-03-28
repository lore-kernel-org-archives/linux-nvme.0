From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 Mar 2018 01:27:08 -0700
Subject: nguid for nvme over fabrics
In-Reply-To: <0832b33613cb166a1c3f46dd3c5d407d@linux.vnet.ibm.com>
References: <410a2655c6f5e4ed9e1c2af36b72f3ee@linux.vnet.ibm.com>
 <4ab62a0f-5cee-cf62-33b3-f4097d34cf72@grimberg.me>
 <0832b33613cb166a1c3f46dd3c5d407d@linux.vnet.ibm.com>
Message-ID: <20180328082708.GA31409@infradead.org>

On Fri, Mar 23, 2018@12:59:53PM +0530, Narasimhan V wrote:
> Shouldn't it be unique ?
> I have instances where for NVMef, multiple devices can have same nguids.
> Which component should be responsible to generate nguid in NVMef ?

You must only usea nguid if you have a ieee id, and then it is your
responsibility to hand out ids based on that.

Which means that you generally should not set a nguid unless you
are building an appliance and really know what you are doing.
