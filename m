From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Feb 2017 17:51:42 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <8b6205c1-00f6-0a5f-7cd1-10f9a3e3f63b@grimberg.me>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <c42e8e1e-f96f-9b2d-f3e6-72599430a327@grimberg.me>
 <20170215154649.GA30251@localhost.localdomain>
 <20170215160448.fk3igep336tj5f3k@merlins.org>
 <8b6205c1-00f6-0a5f-7cd1-10f9a3e3f63b@grimberg.me>
Message-ID: <20170216225142.GA2227@localhost.localdomain>

On Thu, Feb 16, 2017@11:12:53AM +0200, Sagi Grimberg wrote:
> 
> I have no doubt this patch is useful, I'm just wandering if we can
> place the functionality in a more generic location so that more
> drivers can enjoy it.

What this is doing is too driver specific to make generically.

I think we actually want the ability to back out a request and renter
a different hardware context, but that's too hard. :)
