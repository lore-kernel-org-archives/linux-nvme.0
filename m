From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Oct 2017 09:02:15 -0600
Subject: How to improve long suspend time in `nvme_shutdown_ctrl`
In-Reply-To: <e6cf0383-038f-b8e5-22e8-0956e04f0edd@molgen.mpg.de>
References: <72b666c9-dd57-ef87-e89e-ba280f34e90c@molgen.mpg.de>
 <20171018074523.GA20872@infradead.org>
 <e6cf0383-038f-b8e5-22e8-0956e04f0edd@molgen.mpg.de>
Message-ID: <20171018150215.GC32530@localhost.localdomain>

On Wed, Oct 18, 2017@12:58:04PM +0200, Paul Menzel wrote:
> rtd3e   : 4c4b40

The specification recommends time to shutdown not exceed rtd3e, which you
have here at 5 seconds, so it sounds like you're well below the device's
maximum. The 338ms your system spent in nvme is already pretty good,
it seems.
