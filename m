From: james.p.freyensee@intel.com (Jay Freyensee)
Date: Wed, 16 Jul 2014 16:28:52 -0700
Subject: Compiling the latest linux-nvme kernel
Message-ID: <53C70AB4.9030407@intel.com>

Has anyone tried compiling the latest linux-nvme kernel (last change 
6/28/14 looks like)?  It appears the module tree is broken.

What I usually do to try out the latest code on this tree is take a 
distro .config default (in my case, Ubuntu 14.04) and use that as a 
starting .config default, then allow a kernel build use whatever default 
selections are not described in that .config before starting the compile.

These two modules are 'm' by default in my .config process and break:

obj-$(CONFIG_IP_NF_TARGET_ECN) += ipt_ECN.o
obj-$(CONFIG_NETFILTER_XT_MARK) += xt_mark.o

For ipt_ECN, it appears someone did work on a computer that is not 
upper-case specific (i.e., Mac or Windows) because the compile problems 
appear to be upper-lowercase problems.  Turning CONFIG_IP_NF_TARGET_ECN 
to 'n' is pretty simple and allows me to move on.

xt_mark break I haven't quite figured out what is going on- just setting 
CONFIG_NETFILTER_XT_MARK to 'n' does not work; it looks like it gets 
reset to 'm' so I think there is some dependency somewhere I haven't 
figured out yet.

Anyways, if anyone has stumbled upon this problem and already has a 
solution I'd be happy to hear it.

Thanks!
