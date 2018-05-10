From: mr.nuke.me@gmail.com (Alex G.)
Date: Thu, 10 May 2018 10:06:42 -0500
Subject: Deprecating NVME_IOCTL_SUBSYS_RESET
Message-ID: <866e6766-3a3f-8d14-8475-481e839502ad@gmail.com>

Hi,

I've been getting reports that nvme subsystem resets end up taking down 
the entire machine. That's very easy to do with PCIe drives, since a 
NSSR also brings down the PCIe link. Any in-flight posted requests can 
generate unsupported request errors, and non-posted requests can 
generate completion timeouts, or Fatal MCEs on some PCIe root ports.

In a perfect world, PCIe errors would be handled by their respective 
layers, and we wouldn't need to care. Unfortunately, PCIe error handling 
is still an ill conceived idea and afterthought. What concerns me is the 
potential of NSSR to propagate outside of nvme. I suspect other fabrics 
have much better error handling, but I wouldn't be surprised to see 
similar failures.

There are ways to harden the IOCTL by quiescing all IO before issuing 
the actual reset. Such safeguards are implemented everywhere else in the 
driver. Is NVME_IOCTL_SUBSYS_RESET used in the real-world? I think it's 
too big of an attack surface, and we're better off with -EOPNOTSUPP.

I don't see any benefit in keeping it around. Thpughts?

Alex
