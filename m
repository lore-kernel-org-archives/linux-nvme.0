From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Jan 2018 09:12:26 -0700
Subject: [PATCH 1/5] nvme: Add more command status translation
In-Reply-To: <20180108153436.GA11632@lst.de>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-2-keith.busch@intel.com>
 <20180108095512.GC4673@lst.de>
 <2beb72a9-8502-fec8-8892-208cbb0967ac@suse.com>
 <20180108101937.GA5423@lst.de> <20180108152933.GA9920@redhat.com>
 <20180108153436.GA11632@lst.de>
Message-ID: <20180108161226.GB15154@localhost.localdomain>

On Mon, Jan 08, 2018@04:34:36PM +0100, Christoph Hellwig wrote:
> It's basically a kernel bug as it tries to access lbas that do not
> exist.  BLK_STS_TARGET should be fine.

Okay, I'll fix this and address your other comments, and resend. Thanks
for the feedback.
