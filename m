From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Mar 2018 08:44:05 +0100
Subject: [pci PATCH v5 1/4] pci: Add pci_sriov_configure_simple for PFs
 that don't manage VF resources
In-Reply-To: <CAKgT0UfH+xXk__R_hEtFMsm7qkBG02hWC-S=8MgYkeeEx5zweA@mail.gmail.com>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172031.3487.20651.stgit@localhost.localdomain>
 <20180312174012.GE18494@localhost.localdomain>
 <CAKgT0UdWc=Sz-xgd4H3bTDt5d17=-PY8VPWz6A3mAciWV6=97w@mail.gmail.com>
 <20180312182321.GG18494@localhost.localdomain>
 <CAKgT0UfH+xXk__R_hEtFMsm7qkBG02hWC-S=8MgYkeeEx5zweA@mail.gmail.com>
Message-ID: <20180313074405.GA32480@lst.de>

On Mon, Mar 12, 2018@01:17:00PM -0700, Alexander Duyck wrote:
> No, I am aware of those. The problem is they aren't accessed as
> function pointers. As such converting them to static inline functions
> is easy. As I am sure you are aware an "inline" function doesn't
> normally generate a function pointer.

I think Keith's original idea of defining them to NULL is right.  That
takes care of all the current trivial assign to struct cases.

If someone wants to call these functions they'll still need the ifdef
around the call as those won't otherwise compile, but they probably
want the ifdef around the whole caller anyway.
