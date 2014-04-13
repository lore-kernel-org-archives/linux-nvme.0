From: willy@linux.intel.com (Matthew Wilcox)
Date: Sun, 13 Apr 2014 13:42:28 -0400
Subject: [PATCH RFC 3/5] NVMe: Asynchronous device scan support
In-Reply-To: <20140411135901.GM5727@linux.intel.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-4-git-send-email-santoshsy@gmail.com>
 <20131230135025.GI4945@linux.intel.com>
 <CALMYJDtMTZKf6pAYsc3LeG4LT9xfe0NFRMUEqxxarp=0yfdHUQ@mail.gmail.com>
 <20140411135901.GM5727@linux.intel.com>
Message-ID: <20140413174228.GQ5727@linux.intel.com>

On Fri, Apr 11, 2014@09:59:01AM -0400, Matthew Wilcox wrote:
> For motivation, I have a device here which erroneously reports that it
> has billions of namespaces.  Every time I forget to include the patch to
> change 'nn' to 1 for that PCI device ID, the driver sends billions of
> IDENTIFY NAMESPACE commands to that device.  While I wait for that to
> happen, it gives me plenty of time to look at the system and think about
> the consequences of the code we have today :-)

By the way, this patch looks like a good start on tackling the problem:

http://lists.infradead.org/pipermail/linux-nvme/2013-September/000470.html

Some of the infrastructure it adds is already present, eg
nvme_submit_admin_cmd_async().  Allocating one discovery event per
namespace seems like a bad idea; since we can't have more than 64 admin
commands in flight, it would seem reasonable to limit the number of
disco events that can be outstanding at any time.  With Keith's example
2 million namespaces, it was allocating 16GB of DMA consistent memory
... not too much of a problem on a typical dev box these days, but I
wouldn't like to be a NAS box.

P.S.: I am, though, greatly in favour of a free disco event.  Perhaps we
can arrange one at a conference soon?
