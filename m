From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 8 May 2018 13:01:35 -0500
Subject: AER: Malformed TLP recovery deadlock with NVMe drives
In-Reply-To: <bb358683-79fc-0590-eb93-70f4c3c922da@gmail.com>
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
 <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>
 <9fc90040d5712282ea223807ace39312@codeaurora.org>
 <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
 <16bdb0febb842ad0980db9214c8076c5@codeaurora.org>
 <3d4991bc2948430d910a16da36c90b91@ausx13mps321.AMER.DELL.COM>
 <1fdfaaa47ad782ee864f24c5a75a355a@codeaurora.org>
 <20180508165849.GC9529@bhelgaas-glaptop.roam.corp.google.com>
 <bb358683-79fc-0590-eb93-70f4c3c922da@gmail.com>
Message-ID: <20180508180135.GM161390@bhelgaas-glaptop.roam.corp.google.com>

On Tue, May 08, 2018@12:32:28PM -0500, Alex G. wrote:
> On 05/08/2018 11:58 AM, Bjorn Helgaas wrote:
> > (looks like maybe colorizing escape sequences?).
> 
> You mean the ANSI escape sequences. wget and cat in a color terminal.
> You will get so used to this, you will love it so much, you won't ever
> again want to open a a web page.

Hey, you're right!  If I download it and look at it with "less", it *is*
pretty!  It'd be cool if Chrome would do that.  Maybe.

I'm really glad you're looking at this stuff and raising issues.  I'm not
at all confident in the correctness or robustness of this code.

Bjorn
