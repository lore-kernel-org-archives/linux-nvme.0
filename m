From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Mon, 12 Mar 2018 09:01:54 -0700
Subject: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
In-Reply-To: <20180312075907.GA5342@lst.de>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
 <20180308190047.5433.77952.stgit@localhost.localdomain>
 <20180311215909.16ed4bf1@t450s.home> <20180312075907.GA5342@lst.de>
Message-ID: <CAKgT0UcJz7go-vRd88M6uo1mqbG9BfedkZmR0CXZ92m6KfRPzw@mail.gmail.com>

On Mon, Mar 12, 2018@12:59 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Mar 11, 2018@09:59:09PM -0600, Alex Williamson wrote:
>> I still struggle to understand why we need this "unmanaged"
>> complication and how a user of the sysfs API is expected to have any
>> idea whether a PF is managed or unmanaged and why they should care.
>> Can't we just have a pci_simple_sriov_configure() helper and ignore
>> this unmanaged business?  Thanks,
>
> Just a pci_simple_sriov_configure is exactly what I envisioned originally.

I can drop the "unmanaged" bits if that is what is wanted, but based
on previous conversations I thought there was some concern about the
kernel loading VFs when there was some foreign entity managing the VFs
other than the kernel.

Thanks.

- Alex
