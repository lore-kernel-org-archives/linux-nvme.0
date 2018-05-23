From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 23 May 2018 09:08:31 -0600
Subject: [PATCH v3] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
In-Reply-To: <20180523145420.5ly2r4xjq2u25vv2@linux-x5ow.site>
References: <20180517115250.10027-1-jthumshirn@suse.de>
 <20180523145420.5ly2r4xjq2u25vv2@linux-x5ow.site>
Message-ID: <20180523150831.GA11037@localhost.localdomain>

Thanks for the ping. I started a new branch, nvme-4.18-2, based off of
Jens' for-next with this being the first new commit.

I'm certain we're still missing a lot of reviewed commits. I'll try to
go through the mail history and apply by the end of the week, but any
friendly reminders would not be unappreciated. :)
