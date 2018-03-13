From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 13 Mar 2018 15:04:23 +0000
Subject: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <CAKgT0UdkUSsHQC7CpJQ0CT77AD8k7P-HeeomWXNJQ-Ek4dJRMQ@mail.gmail.com>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain>
 <1520928772.28745.53.camel@infradead.org>
 <CAKgT0UdkUSsHQC7CpJQ0CT77AD8k7P-HeeomWXNJQ-Ek4dJRMQ@mail.gmail.com>
Message-ID: <1520953463.20126.15.camel@infradead.org>

On Tue, 2018-03-13@07:51 -0700, Alexander Duyck wrote:

> Actually the suggestion I had from Don Dutile was that we should be
> looking at creating a pci-stub like driver specifically for those type
> of devices, but without the ability to arbitrarily assign devices.
> Basically we have to white-list it in one device at a time for those
> kind of things.

It's still not clear what the point of that would be.

> If you have the device ID of the thing you wanted to have work with
> pci-stub before I could look at putting together a quick driver and
> adding it to this set.

1d0f:0053 would be an example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180313/c5597a69/attachment.bin>
