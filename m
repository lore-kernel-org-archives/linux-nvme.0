From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 Aug 2016 08:36:51 +0200
Subject: [PATCH 2/3] nvme: Pass pointers, not dma addresses, to
 nvme_get/set_features()
In-Reply-To: <CALCETrWzfovS+kh=UsJZxNvN-_eypav+Df+NppPHt8FPPOSipw@mail.gmail.com>
References: <cover.1472462539.git.luto@kernel.org>
 <2756c572e066ed91a41e35568a4d9346e47d6b42.1472462539.git.luto@kernel.org>
 <20160829162735.GD19986@localhost.localdomain>
 <CALCETrWzfovS+kh=UsJZxNvN-_eypav+Df+NppPHt8FPPOSipw@mail.gmail.com>
Message-ID: <20160830063651.GA32323@lst.de>

On Mon, Aug 29, 2016@04:20:43PM -0700, Andy Lutomirski wrote:
> The "Set Features" command (section 5.15) Figure 103 says:
> 
> If using PRPs, this field shall not be a pointer to a PRP List as the
> data buffer may not cross more than one page boundary. If no data
> structure is used as part of the specified feature, then this field is
> not used.
> 
> Does the Linux driver use PRPs?

The Linux PCIe driver always uses PRPs - and for admin command only
Fabrics can use SGLs anyway.

> Do we need to worry about kmalloc
> returning a buffer that spans a 4k boundary but does not span a Linux
> page boundary?

Isn't kmalloc supposed to return naturally aligned buffers?
