From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Nov 2015 07:45:57 -0800
Subject: nvme lightnvm comments
In-Reply-To: <565206C3.3000200@bjorling.me>
References: <20151120105022.GA22131@infradead.org>
 <20151121111210.GA19360@infradead.org>
 <565206C3.3000200@bjorling.me>
Message-ID: <20151123154557.GA20924@infradead.org>

On Sun, Nov 22, 2015@07:17:39PM +0100, Matias Bj?rling wrote:
> On 11/21/2015 12:12 PM, Christoph Hellwig wrote:
> >Btw, another one: it seems like LightNVM devices still claim to
> >use the NVM I/O set per CAP and CC, which seems a little odd.
> >
> 
> Oh, where have you seen it? Thought I had it changed everywhere.

nvme_configure_admin_queue still hardcodes then NVM comman set when
enabling the controller.
