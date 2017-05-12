From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 12 May 2017 07:04:42 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <1494597516613.95190@Dell.com>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <1494597516613.95190@Dell.com>
Message-ID: <CALCETrUVb8KqOOzW7fXDWCyCiXj6jpPm-w=XZ-FXrh_rfdDkJQ@mail.gmail.com>

On Fri, May 12, 2017@6:58 AM,  <Mario.Limonciello@dell.com> wrote:
>> Some testing reports suggest that this will fix the issues we've
>> seen on Dell laptops.
>
> It think it also makes sense to revert the quirk that was created based upon the previous aggressiveness of re-entry to PS4 on those machines.  Are you expecting to split that up into a second patch also targeted at 4.11 stable and 4.12, but later after some more testing?

Yes, mostly.  I've written the patch, but I was planning to target it
at 4.12 or 4.13 but not -stable.  It's mostly just a cleanup and has
no real power saving benefit since the RSTe timeouts are so absurdly
conservative that I doubt PS4 will happen in practical usage.  Perhaps
in suspend-to-idle?  (For suspend-to-idle, I suspect we should really
be using D3 instead.  Do we already do that?)
