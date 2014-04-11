From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 11 Apr 2014 09:59:01 -0400
Subject: [PATCH RFC 3/5] NVMe: Asynchronous device scan support
In-Reply-To: <CALMYJDtMTZKf6pAYsc3LeG4LT9xfe0NFRMUEqxxarp=0yfdHUQ@mail.gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-4-git-send-email-santoshsy@gmail.com>
 <20131230135025.GI4945@linux.intel.com>
 <CALMYJDtMTZKf6pAYsc3LeG4LT9xfe0NFRMUEqxxarp=0yfdHUQ@mail.gmail.com>
Message-ID: <20140411135901.GM5727@linux.intel.com>

On Fri, Mar 28, 2014@07:32:54PM +0530, Santosh Y wrote:
> On Mon, Dec 30, 2013@7:20 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
> > On Mon, Dec 30, 2013@03:57:18PM +0530, Santosh Y wrote:
> >> This patch provides asynchronous device enumeration
> >> capability. The 'probe' need not wait until the namespace scanning is
> >> complete.
> >
> > I'm very interested in having something like this, except I don't think
> > it's complete.  You don't seem to handle the cases where the device
> > is shut down in the middle of an async scan.  Also, the only piece you
> > seem to make async is the calls to add_disk(), which are surely not the
> > timeconsuming parts of the scan.  I would think the time consuming parts
> > are sending the IDENTIFY commands, which you don't make async.
> >
> 
> Would you prefer changes in the following patch. Please let me know
> your comments.

There are a few things I'd like to see done differently.

For motivation, I have a device here which erroneously reports that it
has billions of namespaces.  Every time I forget to include the patch to
change 'nn' to 1 for that PCI device ID, the driver sends billions of
IDENTIFY NAMESPACE commands to that device.  While I wait for that to
happen, it gives me plenty of time to look at the system and think about
the consequences of the code we have today :-)

1. I want to be able to remove the module before the scan has finished.
So the 'wait for the mutex' design you have doesn't work for this case;
we need to be able to interrupt the scan.

2. Right now all of the work is being carried out by a kworker.  Since we
have an nvme kthread, I'd like for that to be doing the work so someone
who doesn't know nvme has a decent chance of figuring out that their
system is misbehaving because nvme is doing something unusual.

3. The system is spewing out lots of nasty messages about tasks hanging
waiting for mutexes, eg:

[  721.687298] INFO: task modprobe:1072 blocked for more than 120 seconds.

The mutex it is waiting for is being held by the upper level code which
has called the nvme driver to initialise.  Therefore we must return from
the nvme driver probe code before scanning namespaces has completed.

4. There is an accepted TP for nvme 1.2 that allows the device to send
an Async Notification that some aspect of the namespace inventory has
changed, and invites us to rescan.  I would love to take that into
account in a patch that overhauls scanning.

5. A really good patch would also try to use the nvme 1.1 capability to
report sparse namespaces (IDENTIFY with CNS = 2).

6. You need to find a better email program; the one you have is converting
tabs to spaces.
