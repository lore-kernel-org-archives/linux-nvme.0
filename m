From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 07:38:11 -0800
Subject: [PATCH v1 2/7] lib: Add Sed-opal library
In-Reply-To: <1479338252-8777-3-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161117153811.GA16761@infradead.org>

I'm trying to understand the logic for how the OPAL state machine
and how it interacts with the Security Send / Receive commands.

It seems like it's implemented as an asynchronous state machine,
but all the callers and up waiting synchronously for the result.

How about making ->send and ->recv (or the merged method if you
follow my earlier suggestion) synchronous, e.g. for nvme just
switch from blk_execute_rq_nowait to blk_execute_rq for the
execution and stop passing the cb and cb_data arguments which
would not be needed with this scheme.
