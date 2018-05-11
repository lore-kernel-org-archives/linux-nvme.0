From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 May 2018 10:36:53 -0600
Subject: [PATCH] Fix controller reset return
In-Reply-To: <20180511162501.7258-1-keith.busch@intel.com>
References: <20180511162501.7258-1-keith.busch@intel.com>
Message-ID: <20180511163653.GA7322@localhost.localdomain>

I'll just need to append "nvme:" to the front of the changelog subject,
otherwise I think this is a trivial fix.

For future, there are multiple places that look for LIVE and ADMIN_ONLY,
so might be worth refactoring this into a function later.
