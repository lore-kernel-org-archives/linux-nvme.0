From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 3 Jun 2018 14:00:37 +0300
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180601042441.GB14244@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com> <20180531163311.GA30954@lst.de>
 <20180531181757.GB11848@redhat.com> <yq17enjut3q.fsf@oracle.com>
 <20180601042441.GB14244@redhat.com>
Message-ID: <0a0d4ff8-fe06-5869-cd18-a8c99b5e86f6@grimberg.me>


> I'm aware that most everything in multipath.conf is SCSI/FC specific.
> That isn't the point.  dm-multipath and multipathd are an existing
> framework for managing multipath storage.
> 
> It could be made to work with NVMe.  But yes it would not be easy.
> Especially not with the native NVMe multipath crew being so damn
> hostile.

The resistance is not a hostile act. Please try and keep the
discussion technical.

>> But I don't think the burden of allowing multipathd/DM to inject
>> themselves into the path transition state machine has any benefit
>> whatsoever to the user. It's only complicating things and therefore we'd
>> be doing people a disservice rather than a favor.
> 
> This notion that only native NVMe multipath can be successful is utter
> bullshit.  And the mere fact that I've gotten such a reaction from a
> select few speaks to some serious control issues.
> 
> Imagine if XFS developers just one day imposed that it is the _only_
> filesystem that can be used on persistent memory.
> 
> Just please dial it back.. seriously tiresome.

Mike, you make a fair point on multipath tools being more mature
compared to NVMe multipathing. But this is not the discussion at all (at
least not from my perspective). There was not a single use-case that
gave a clear-cut justification for a per-subsystem personality switch
(other than some far fetched imaginary scenarios). This is not unusual
for the kernel community not to accept things with little to no use,
especially when it involves exposing a userspace ABI.

As for now, all I see is a disclaimer saying that it'd need to be
nurtured over time as the NVMe spec evolves.

Can you (or others) please try and articulate why a "fine grained"
multipathing is an absolute must? At the moment, I just don't
understand.

Also, I get your point that exposing state/stats information to
userspace is needed. That's a fair comment.
