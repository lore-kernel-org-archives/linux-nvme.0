From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Mar 2013 12:48:41 -0600 (MDT)
Subject: [PATCH v3 7/7] NVMe: End-to-end data protection
In-Reply-To: <20130327225131.GI4671@linux.intel.com>
References: <1363966604-5482-1-git-send-email-keith.busch@intel.com>
 <20130327225131.GI4671@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1303221242170.17928@localhost.localdom>

On Wed, 27 Mar 2013, Matthew Wilcox wrote:

> On Fri, Mar 22, 2013@09:36:44AM -0600, Keith Busch wrote:
>> Registers a DIF capable nvme namespace with block integrity.
>
> I'm assuming I can't apply this until Martin has applied 1-5?  But I
> can apply 6 safely?

Yep, patch 6 is not dependent on anything else. I notice though that
it works better if we include Arjan's patch that moves the nvme kthread
TASK_INTERRUPTIBLE state to avoid an occasional lost wake.
