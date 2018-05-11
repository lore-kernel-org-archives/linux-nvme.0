From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 11 May 2018 11:42:42 -0600
Subject: Another NVMe failure, this time with AER info
In-Reply-To: <20180511172610.GB7344@localhost.localdomain>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
 <20180511172610.GB7344@localhost.localdomain>
Message-ID: <20180511174241.GC7344@localhost.localdomain>

On Fri, May 11, 2018@11:26:11AM -0600, Keith Busch wrote:
> I trust you know the offsets here, but it's hard to tell what this
> is doing with hard-coded addresses. Just to be safe and for clarity,
> I recommend the 'CAP_*+<offset>' with a mask.
> 
> For example, disabling ASPM L1.2 can look like:
> 
>  # setpci -s <B:D.f> CAP_PM+8.l=0:4

My mistake above: CAP_PM is a different capability, not the intended
one. It looks like setpci doesn't even have a convenient symbol for the
L1 PM extended capability, so the hard-coded offsets are the only way
for this setting. Sorry about the mistake.
