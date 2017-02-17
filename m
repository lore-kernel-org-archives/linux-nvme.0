From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 Feb 2017 01:15:32 -0800
Subject: [PATCH v2] nvmet: discovery controller to set ioccsz and iorcsz
In-Reply-To: <58a6630c.QwbzGsQTsh8C63rk%jsmart2021@gmail.com>
References: <58a6630c.QwbzGsQTsh8C63rk%jsmart2021@gmail.com>
Message-ID: <20170217091532.GA16652@infradead.org>

On Thu, Feb 16, 2017@06:42:20PM -0800, James Smart wrote:
> 
> Revised the patch: add transport capsule inline size into ioccsz value
> 
> The discovery controller's Identify command handler never set these
> fields leaving them zero. The host-side fc transport validates that
> these values are appropriate and was killing the connection with the
> controller as they were zero.
> 
> Set the controller ioccsz and iorcsz values

Discovery controllers do not support I/O commands, so these settings
don't make any sense there.  They are also not included in the
fields that Idenitfy Controller should report for Discovery controllers
(Figure 33 in Fabrics 1.0)
