From: gpiccoli@canonical.com (Guilherme G. Piccoli)
Date: Fri, 27 Apr 2018 19:54:58 -0300
Subject: Should a raid-0 array immediately stop if a component disk is
 removed?
In-Reply-To: <5AE3A00B.6050801@youngman.org.uk>
References: <301f2a37-81ea-938b-3bd1-947f716c0f63@canonical.com>
 <5AE3A00B.6050801@youngman.org.uk>
Message-ID: <600c8404-4eb1-4b53-836d-590b0c5f873c@canonical.com>

Thanks for your quick reply Anthony!
Inline comments below:


On 27/04/2018 19:11, Wols Lists wrote:
> On 27/04/18 22:49, Guilherme G. Piccoli wrote:
> [...]
> Sounds like you're not using mdadm to remove the disk. So why do you
> expect mdadm to stop the array immediately? It doesn't know anything is
> wrong until it trips over the missing disk.

In fact, mdadm is aware something is wrong - it tries to stop the array,
running "mdadm -If <array-component-just-removed>", but it fails because
the mount point prevents it to stop the array.
And the question lies exactly in this point: should it be (successfully)
stopped? I think it should, since we can continue writing on disks
causing data corruption.


> [...]
> Is your array linear or striped? If it's striped, I would expect it to
> fall over in a heap very quickly. If it's linear, it depends whether you

It's stripped. I was able to keep writing for some time (minutes).


> [...] 
> Note that raid-0 is NOT redundant. Standard advice is "if a drive fails,
> expect to lose your data". So the fact that your array limps on should
> be the pleasant surprise, not that it blows up in ways you didn't expect.

OK, I understand that. But imagine the following scenario: a regular
user gets for some reason a component disk removed, and they don't look
the logs before (or after) writes - the user can write stuff thinking
everything is fine, and that data is corrupted. I'd expect userspace
writes to fail as soon as possible in case one of raid-0 components is gone.

Thanks,


Guilherme
