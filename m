From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 30 Dec 2016 15:52:53 -0700
Subject: [PATCH v4 0/6] SED OPAL Library
In-Reply-To: <20161230082826.GA30378@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <20161230082826.GA30378@infradead.org>
Message-ID: <20161230225252.GA3716@sbauer-Z170X-UD5>

On Fri, Dec 30, 2016@12:28:26AM -0800, Christoph Hellwig wrote:
> Hi Scott,
> 
> do you have a pointer to the userspace using this ioctls?  Over the
> holidays I finally managed to put a test system for my collection of m.2
> key M cards together, so I should be able to test the code, which I'd
> definitively like to do before ACKing.  More comments on the code itself
> will follow soon.


We've enabled the supporte into nvmecli you can pull my branch here:
https://github.com/ScottyBauer/nvme-cli/tree/sed-nvme


Here are some shellscripts I use for testing -- also a HOW-TO-USE in there.
https://github.com/ScottyBauer/nvme-cli-sed-sh


I may have regressed some Single user mode stuff in the library. I was under
the impression one could setup multiple Locking ranges under Single User Mode.
But I can only get one setup without my drive complaining. It doesn't work in
sed-util either, so I have to go read the SUM spec again and see if that is
actually a use-case that's possible or if I was dreaming this test up. I swore
I had this working on previous iterations, but I could be wrong. Normal mode
seems to work fine, though.
