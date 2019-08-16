From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Fri, 16 Aug 2019 13:30:29 +0100
Subject: [PATCH] Revert "nvme-pci: use host managed power state for
 suspend"
In-Reply-To: <20190816122644.GA21797@lst.de>
References: <20190816121549.8754-1-chris@chris-wilson.co.uk>
 <20190816122644.GA21797@lst.de>
Message-ID: <156595862897.11610.6852982219615959799@skylake-alporthouse-com>

Quoting Christoph Hellwig (2019-08-16 13:26:44)
> Please, report the actual problem.  Blindly reverting a patch without
> even an explanation of your regressions is not the way to do it.

As stated, the system doesn't suspend.

If you would like to wait, you will get test results from our CI
giving the current failed state and the outcome of the patch.
-Chris
