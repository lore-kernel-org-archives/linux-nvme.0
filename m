From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 17:10:53 +0200
Subject: [PATCHv4 2/4] nvme: use hw qid in trace events
In-Reply-To: <20180702144900.GA22806@localhost.localdomain>
References: <20180629225003.16567-1-keith.busch@intel.com>
 <20180629225003.16567-3-keith.busch@intel.com> <20180702131107.GB4624@lst.de>
 <20180702144900.GA22806@localhost.localdomain>
Message-ID: <20180702151053.GA14721@lst.de>

On Mon, Jul 02, 2018@08:49:01AM -0600, Keith Busch wrote:
> > Relying on assining to macro paramters is a good way to generate
> > unreadable code.
> 
> Sure, I can respin these as inline functions.

I'll fix it up when applying.
