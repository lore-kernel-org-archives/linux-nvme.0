From: keith.busch@intel.com (Keith Busch)
Date: Thu, 2 Jul 2015 14:42:50 +0000 (UTC)
Subject: Question about NVMe share I/O
In-Reply-To: <559531A9.5040704@huawei.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
 <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
 <20150611152348.GB1292@infradead.org> <55935989.70809@huawei.com>
 <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
 <559531A9.5040704@huawei.com>
Message-ID: <alpine.LNX.2.00.1507021428370.15930@localhost.lm.intel.com>

On Thu, 2 Jul 2015, Yijing Wang wrote:
> Most of the time, the Host and NVMe work fine, we could read/write the same
> nvme by different Host, but if we do test which insmod and rmmod nvme
> driver(we reworked) in both hosts, a system crash would happen, Host A,
> because submit queue id in completion is 2.

Could you share the source to your "reworked" driver?
