From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 21 Jun 2017 19:06:12 -0500
Subject: [PATCH v6 00/10] Implement NVMe Namespace Descriptor
 Identification
In-Reply-To: <CA+55aFxJ0bpRFsnZFe6sh2i4jxNdYmDi_6RZx2CQQdmQ_HU3wQ@mail.gmail.com>
 (Linus Torvalds's message of "Fri, 16 Jun 2017 22:28:28 +0900")
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170615163141.GA27307@lst.de>
 <bab953e9-7026-5833-9f65-1ef8b90433d7@suse.de>
 <20170616094056.GA12465@lst.de>
 <905ed2e6-1c1c-f3a3-5391-66e42fb61861@suse.de>
 <20170616095837.GA14217@lst.de>
 <CA+55aFxJ0bpRFsnZFe6sh2i4jxNdYmDi_6RZx2CQQdmQ_HU3wQ@mail.gmail.com>
Message-ID: <87fuesnax7.fsf@xmission.com>

Linus Torvalds <torvalds at linux-foundation.org> writes:

> On Fri, Jun 16, 2017@6:58 PM, Christoph Hellwig <hch@lst.de> wrote:
>> On Fri, Jun 16, 2017@11:48:32AM +0200, Johannes Thumshirn wrote:
>>> >
>>> > Yeah, it's actually there, but for some reason find on sysfs
>>> > behaves strange:
>>> >
>>> > root at testvm:~# find /sys -name uuid
>>> > root at testvm:~# cat /sys/class/nvme/nvme2/nvme2n1/uuid
>>> > 6665a65b-f42f-469b-800e-a047238649eb
>>>
>>> Wasn't there something that find on sysfs isn't reliable?
>>
>> Looks like it.  Which is a pitty.
>
> Hmm. The *traditional* reason for this particular 'find' oddity is
> that find has an optimization which will look at the nlink count of a
> directory to decide how many subdirectories it can have.
>
> So when 'find' then traverses the directory tree, once it has found
> all the subdirectories it expects, it will stop traversing any further
> subdirectories.
>
> The reason for this is that it can then avoid doing the 'lstat()' on
> each directory entry to even figure out what kind of file it is (ie
> directory vs regular file etc). I forget the exact rules, but it
> basically depends on nlink being "2+umber of subdirectories". I wonder
> if the sysfs code gets this wrong for some cases.
>
> All the directories I have on the laptop I'm on right now get it
> right, but maybe nvme triggers something.
>
> You can check with some silly shell scripts, and do things like
>
>     stat -c %h /sys/class/nvme
>
> and then compare that to the number of subdirectories (the link count
> should be 2 higher - the parent entry and the '.' entry).
>
> The traditional *fix* for this is to just set "nlink" to 1 for a
> directory, which tells 'find' to not use this optimization. That's
> what filesystems like VFAT do, that don't count subdirectories. But
> sysfs should get the directory count right.
>
> I can't imagine any other reason why 'find' would screw up.

Definitely worth looking at.

There is only one code path for that in kernfs/sysfs so I don't think
you can mess that up.

I suspect find is getting confused by something more subtle.  Perhaps a
symlink.  /sys/class/nvme/ ought to be be filled with symlinks to other
locations in sysfs.  Which could be part of the challenge.

Perhaps find /sys/ behaves differently than find /sys..

It might be worth running "find /sys | grep uuid" and see if your file
turns up.

After the work I did cleaning up sysfs to support network namespaces
find really ought to work properly on sysfs.  inotify is likely to have
problems but find should work.

Eric
