From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Nov 2018 08:49:10 +0100
Subject: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
In-Reply-To: <20181115173015.GB229449@google.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
 <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
 <20181115145809.GA207836@google.com> <20181115173015.GB229449@google.com>
Message-ID: <20181116074910.GA13556@lst.de>

On Thu, Nov 15, 2018@11:30:15AM -0600, Bjorn Helgaas wrote:
> 
> But I guess you have to do this anyway just to add the vendor/device
> ID to the driver, so maybe this isn't a big deal to you.  If you can
> do a quirk like this in the driver, it would be invisible to me and I
> wouldn't care.  I just don't want to deal with ongoing tweaks like
> this in the PCI core :)

No, NVMe is a spec with a class code, and a specification that is
vendor independent.  NVMe devices declare invididual features based
on common fields.

APST is an optional feature with all kinds of parameters, but there
is absolutely no language that a host should not put the device into
D3 mode if APST is supported anywhere in the NVMe spec, and such
behavior is also rather counter intuitive.  If SK Hynix thinks this
is sensible behavior they should bring it up in the NVMe technical
working group.  I've pinged a contact there to see what this whole
story is about.
