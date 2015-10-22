From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 22 Oct 2015 12:59:17 -0600
Subject: [PATCH 18/18] nvme: move chardev and sysfs interface to common
 code
In-Reply-To: <1445538979.2750.14.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-19-git-send-email-hch@lst.de>
 <1445472671.3307.111.camel@linux.intel.com>
 <20151022074529.GE20076@lst.de>
 <1445538979.2750.14.camel@linux.intel.com>
Message-ID: <20151022185917.GA1492@localhost.localdomain>

> > Why?
> 
> Well, for starters, it's good practice to have strings like this in a
> #define.
> 
> I can send a patch to redefine this and 0x4E564D65 in the nvme.h.
IMO, make the hex "NVMe" a #define or at least keep its comment.
Keep "nvme" in the class_create call because there is no point in obfuscating that :)
