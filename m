From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Mar 2018 13:37:49 -0600
Subject: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
In-Reply-To: <20180326015038.GD9828@ming.t460p>
References: <20180323221923.24545-1-keith.busch@intel.com>
 <20180326015038.GD9828@ming.t460p>
Message-ID: <20180326193749.GB30867@localhost.localdomain>

On Mon, Mar 26, 2018@09:50:38AM +0800, Ming Lei wrote:
> 
> Given no many callers of blk_mq_pci_map_queues(), I suggest to add the
> parameter of 'offset' to this API directly, then people may keep the 
> '.pre_vectors' stuff in mind, and avoid to misuse it.

Yeah, I think I have to agree. I was trying really hard to not touch
other drivers, but the concept doesn't seem odd enough to justify hiding
it behind a default parameter. I'll send v2 tomorrow if there's no other
feedback.
