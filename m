From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Fri, 12 May 2017 13:58:36 +0000
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
Message-ID: <1494597516613.95190@Dell.com>

> Some testing reports suggest that this will fix the issues we've
> seen on Dell laptops.

It think it also makes sense to revert the quirk that was created based upon the previous aggressiveness of re-entry to PS4 on those machines.  Are you expecting to split that up into a second patch also targeted at 4.11 stable and 4.12, but later after some more testing?
