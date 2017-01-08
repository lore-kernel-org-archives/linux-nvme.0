From: hch@lst.de (Christoph Hellwig)
Date: Sun, 8 Jan 2017 10:58:50 +0100
Subject: targetcli and nvmetcli
In-Reply-To: <cab11273-41c3-9af5-9263-e4d251b2c927@redhat.com>
References: <cab11273-41c3-9af5-9263-e4d251b2c927@redhat.com>
Message-ID: <20170108095850.GA25936@lst.de>

On Fri, Jan 06, 2017@11:05:01AM -0800, Andy Grover wrote:
> Hi James and Christoph,
>
> Have you considered integrating nvmetcli with targetcli?

We looked into all the options earlier and decided against it.

The NVMe object are a lot more standardized than those for the SCSI
transports, and both the kernel nvme target condigfs code, and thus
nvmetcli take advantage of that to provide a more coherent user interface.
