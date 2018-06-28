From: hch@lst.de (Christoph Hellwig)
Date: Thu, 28 Jun 2018 16:42:06 +0200
Subject: [PATCH V4 0/2] nvmet: implement flush all support
In-Reply-To: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>
References: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180628144206.GA17432@lst.de>

On Tue, Jun 26, 2018@06:17:15PM -0400, Chaitanya Kulkarni wrote:
> Hi,
> 
> This implements the flush command behavior described in
> "NVMe 1.3a  TP 4035" for NSID value of FFFFFFFFh. Now flush command
> applies to all the namespaces attached to the controller processing the
> Flush command when the value 0xFFFFFFFF is set in the NSID field. 

Why?  No other I/O command supports 0xFFFFFFFF, and sending an all
namespaces flush is entirely unnatural.  Unless we have a very strong
use case I don't want to carry this code around.
