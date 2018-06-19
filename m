From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 19 Jun 2018 09:54:38 -0600
Subject: [PATCH] nvme-cli: Implemented primary and secondary controller
In-Reply-To: <20180619154317.GA1638@infradead.org>
References: <20180619152859.3686-1-revanth.rajashekar@intel.com>
 <20180619154531.GC19922@localhost.localdomain>
 <20180619154317.GA1638@infradead.org>
Message-ID: <20180619155438.GD19922@localhost.localdomain>

On Tue, Jun 19, 2018@08:43:17AM -0700, Christoph Hellwig wrote:
> Btw, I'm really unconfortable with having this code around if it
> hasn't actually been tested..

Agreed. If you can't test it, it probably doesn't work.
