From: stefanha@gmail.com (Stefan Hajnoczi)
Date: Tue, 3 Jan 2017 15:59:29 +0000
Subject: [Qemu-devel] Qemu NVME ubuntu 16.04 setup problems
In-Reply-To: <CAKJ7aR7kDde_KrCMojwdU1kaSvK+zw_wM49__EcA+=kO+fT+Hw@mail.gmail.com>
References: <CAKJ7aR7kDde_KrCMojwdU1kaSvK+zw_wM49__EcA+=kO+fT+Hw@mail.gmail.com>
Message-ID: <20170103155929.GG14707@stefanha-x1.localdomain>

On Mon, Dec 26, 2016@01:59:13PM +0530, Gadre Nayan wrote:
> I am trying to test SPDK on a Virtual Machine with NVME support. I do not
> have NVME cards on the Host hence wanted to simulate the Hardware, I have
> install nvmeqemu (https://github.com/nvmeqemu/nvmeqemu) for that purpose.

That repo hasn't been updated since 2012.  NVMe support has been
available in upstream QEMU since 2013.

Please try using a modern QEMU.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170103/05877614/attachment.sig>
