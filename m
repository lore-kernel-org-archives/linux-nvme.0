From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 22:28:49 +0000
Subject: [PATCHv2-4.5 00/10] NVMe fixes
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160211222848.GA19595@localhost.localdomain>

Just want to point out a couple issues. Both are easy fixes and will
send in a few minutes.

First, admin queues don't have namespaces, so the new namespace state
check isn't always correct. I haven't been able to synthesize a test that
gets an admin command down this path in the disabled queue condition,
but it's clearly not correct.

The second issue potentially existed all along, but it's a littlie easier
to hit now: we need to lock out shutdown from manipulating registers
while they're being setup. This was hit by forcing controller reset from
the shelll in a loop, then "rmmod nvme" at the same time.
